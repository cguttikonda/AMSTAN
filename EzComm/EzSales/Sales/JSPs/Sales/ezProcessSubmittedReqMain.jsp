<%@ page import ="ezc.ezparam.*,ezc.ezbasicutil.*,ezc.ezutil.FormatDate,java.util.*" %>
<%@ page import ="java.text.*,ezc.ezmisc.params.*" %>
<%@ page import ="com.sap.mw.jco.*,java.util.*" %>
<%@ page import ="ezc.ezsap.*,ezc.sapconnection.*,com.sap.mw.jco.*,com.sap.mw.jco.JCO" %>
<%@ include file="../Misc/ezEncryption.jsp"%>
<%@ include file="../Misc/ezDBMethods.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%!
	public String nullCheck(String str)
	{
		String ret = str;

		if(ret==null || "null".equalsIgnoreCase(ret))
			ret = "";

		return ret;
	}
%>
<%
ezc.record.util.EzOrderedDictionary userAuth_R = Session.getUserAuth();

String crType 		= request.getParameter("crType");
String actionType 	= request.getParameter("actionType");

if(crType == null) crType = "C";

String authChkStr = "";

if(crType.equals("C") || crType.equals("RC"))
	authChkStr = "SO_CANCEL";
else if(crType.equals("RGA") && "A".equals(actionType))
	authChkStr = "APPR_RGA";
else if(crType.equals("RGA") && !"A".equals(actionType))
	authChkStr = "SO_RETURN_CREATE";

if(userAuth_R.containsKey(authChkStr))
{
	String cancellationId 	= request.getParameter("cancellationId");
	String requestor 	= request.getParameter("requestor");
	String requestorName 	= request.getParameter("requestorName");
	String reqdate 		= request.getParameter("reqdate");
	String soldToCode 	= request.getParameter("soldToCode");
	String shipToCode 	= request.getParameter("selShipTo");
	String poNumber		= request.getParameter("poNumber");

	String dropShipTo	= request.getParameter("dropShipTo");
	String shipToName 	= request.getParameter("shipToNameH");
	String shipToStreet 	= request.getParameter("shipToStreetH");
	String shipToCity 	= request.getParameter("shipToCityH");
	String shipToState 	= request.getParameter("shipToStateH");
	String shipToCountry 	= request.getParameter("shipToCountry");
	String shipToZipCode 	= request.getParameter("shipToZipH");
	String shipToPhNum 	= request.getParameter("shipToPhoneH");

	String backEndRGANum = "";
	String sDocNumber = null;

	boolean actOnDoc = true;

	log4j.log("CANCELLATION--INT USER--cancellationId======>"+cancellationId, "D");
	log4j.log("CANCELLATION--INT USER--actionType======>"+actionType, "D");

	if (requestor == null || requestor.equals("null")){
		requestor = "";
	}	
	if (reqdate == null) {
		Date dateNow = new Date ();
		SimpleDateFormat format = new SimpleDateFormat("MM/dd/yyyy hh:mm");  
		reqdate = format.format(dateNow);
	}

	String soNum[] 		= request.getParameterValues("soNum");
	String soItem[] 	= request.getParameterValues("soItem");
	String rejReasonCode[] 	= request.getParameterValues("rejReasonCode");
	String rejComments[] 	= request.getParameterValues("rejComments");

	String orderReason 	= request.getParameter("orderReason");
	String incoTerm 	= request.getParameter("incoTerm");
	String forwardingAgent 	= request.getParameter("forwardingAgent");
	String restockFees 	= request.getParameter("restockFees");
	String restockFeesType 	= request.getParameter("restockFeesType");
	String invNotes 	= request.getParameter("invNotes");
	String retText 		= request.getParameter("retText");
	String retHText		= request.getParameter("retHText");
	String expireOn		= request.getParameter("expireOn");
	String rejRCCom		= nullCheck(request.getParameter("rejRCCom"));
	
	if(rejRCCom!=null && !"".equals(rejRCCom)) rejRCCom = replaceString(rejRCCom,"'","`");
	if(invNotes!=null && !"".equals(invNotes)) invNotes = replaceString(invNotes,"'","`");
	if(retHText!=null && !"".equals(retHText)) retHText = replaceString(retHText,"'","`");

	String retMat[] 	= request.getParameterValues("retMat");
	String retQty[] 	= request.getParameterValues("retQty");
	String retPrice[] 	= request.getParameterValues("retPrice");
	String retSorg[] 	= request.getParameterValues("retSorg");
	String retDch[] 	= request.getParameterValues("retDch");
	String retDiv[] 	= request.getParameterValues("retDiv");
	//String lineStatuses[] 	= request.getParameterValues("lineStatus");

	Vector soItemsVect = new Vector();
	Hashtable rgaNumHT = new Hashtable();

	String userId	= Session.getUserId();

	String userFNameH = (String)session.getValue("FIRSTNAME");
	String userLNameH = (String)session.getValue("LASTNAME");

	log4j.log("CANCELLATION--INT USER--userId======>"+userId, "D");

	int soNumCnt = 0;

	if(soNum!=null)
 		soNumCnt = soNum.length;

	String showMsg 		= "", showErrorMessage = "", showSuccessMessage = "";

	if (crType.equals("C") || crType.equals("RC")) {
		// PERFORM CANCELLATION IN SAP 
		for(int i=0;i<soNumCnt;i++)
		{
			boolean isError 	= false;

			String soNumber 	= soNum[i];
			String soItemStr	= soItem[i];
			String rejReasonCodeStr	= rejReasonCode[i];
			String selRejComments 	= rejComments[i];

			if("A".equals(actionType))
			{
				JCO.Client client		=	null;
				JCO.Function jcoFunction 	= 	null;
				JCO.Function commit 		= 	null;
				JCO.Function jcoTextFunction = null;

				String site_S = (String)session.getValue("Site");
				String skey_S = "999";

				try
				{
					client = EzSAPHandler.getSAPConnection(site_S+"~"+skey_S);
					jcoFunction 	= EzSAPHandler.getFunction("BAPI_SALESORDER_CHANGE",site_S+"~"+skey_S);
					//jcoTextFunction = EzSAPHandler.getFunction("Z_EZ_SAVE_TEXT",site_S+"~"+skey_S);
					commit 		= EzSAPHandler.getFunction("BAPI_TRANSACTION_COMMIT",site_S+"~"+skey_S);

					JCO.ParameterList 	sapProc 	= jcoFunction.getImportParameterList();
					JCO.Structure orderHdrStructure     	= sapProc.getStructure("ORDER_HEADER_INX");

					//out.println(orderHdrStructure);

					JCO.Table soItemTab          		= jcoFunction.getTableParameterList().getTable("ORDER_ITEM_IN");
					JCO.Table soItemX          		= jcoFunction.getTableParameterList().getTable("ORDER_ITEM_INX");
					JCO.Table soItemText          		= jcoFunction.getTableParameterList().getTable("ORDER_TEXT");


					//JCO.ParameterList 	sapProcSaveText 	= jcoTextFunction.getImportParameterList();
					//JCO.Structure soTextHdrStructure     	= sapProcSaveText.getStructure("HEADER");
					//JCO.Table textLines          		= jcoTextFunction.getTableParameterList().getTable("LINES");

					Date dateposted = new Date();  
					SimpleDateFormat format = new SimpleDateFormat("MM/dd/yyyy hh:mm");  

					sapProc.setValue(soNumber,"SALESDOCUMENT");

					orderHdrStructure.setValue("U","UPDATEFLAG");

					JCO.Structure	logicSwitch = sapProc.getStructure("LOGIC_SWITCH");
					logicSwitch.setValue("C","PRICING");

					soItemTab.appendRow();
					soItemTab.setValue(soItemStr,"ITM_NUMBER");
					soItemTab.setValue(rejReasonCodeStr,"REASON_REJ");


					soItemX.appendRow();
					soItemX.setValue(soItemStr,"ITM_NUMBER");
					soItemX.setValue("U","UPDATEFLAG");
					soItemX.setValue("X","REASON_REJ");


					soItemText.appendRow();
					soItemText.setValue(soNumber,"DOC_NUMBER");
					soItemText.setValue(soItemStr,"ITM_NUMBER");
					soItemText.setValue("ZPI1","TEXT_ID");
					soItemText.setValue("EN","LANGU");
					soItemText.setValue("*","FORMAT_COL");
					soItemText.setValue("Cancellation Requested by Portal User: "+requestor+" on: "+reqdate,"TEXT_LINE");
					soItemText.setValue("005","FUNCTION");

					if (!selRejComments.trim().equals("")) {
					soItemText.appendRow();
					soItemText.setValue(soNumber,"DOC_NUMBER");
					soItemText.setValue(soItemStr,"ITM_NUMBER");
					soItemText.setValue("ZPI1","TEXT_ID");
					soItemText.setValue("EN","LANGU");
					soItemText.setValue("*","FORMAT_COL");
					soItemText.setValue("Comments on Cancellation:"+selRejComments,"TEXT_LINE");
					soItemText.setValue("005","FUNCTION");
					}

					soItemText.appendRow();
					soItemText.setValue(soNumber,"DOC_NUMBER");
					soItemText.setValue(soItemStr,"ITM_NUMBER");
					soItemText.setValue("ZPI1","TEXT_ID");
					soItemText.setValue("EN","LANGU");
					soItemText.setValue("*","FORMAT_COL");
					soItemText.setValue("Cancellation Id on myasb2b.com: "+cancellationId,"TEXT_LINE");
					soItemText.setValue("005","FUNCTION");

					soItemText.appendRow();
					soItemText.setValue(soNumber,"DOC_NUMBER");
					soItemText.setValue(soItemStr,"ITM_NUMBER");
					soItemText.setValue("ZPI1","TEXT_ID");
					soItemText.setValue("EN","LANGU");
					soItemText.setValue("*","FORMAT_COL");
					soItemText.setValue("Cancellation Approved and Posted by Portal user: "+userFNameH + " " +userLNameH +" on "+format.format(dateposted),"TEXT_LINE");
					soItemText.setValue("005","FUNCTION");



					commit.getImportParameterList().setValue("X", "WAIT");
					//log4j.log(":::::APPENDED TEXT LINE::::::::::::::::::::Cancelled by "+userId+soNumber+soItemStr, "E");


					try
					{

						client.execute(jcoFunction);
						client.execute(commit);

					}
					catch(Exception ec)
					{
						log4j.log("::::::::CLIENT:::::::::::ezProcessSubmittedRequest::::::::::::::::::::"+ec, "E");
					}

					JCO.Table returnTable 	= jcoFunction.getTableParameterList().getTable("RETURN");

					boolean okToUpdateText = true;
					if ( returnTable != null )
					{
						log4j.log(":::::RETURN TABLE FROM SAP::::::::::::::::::::"+returnTable.getNumRows(), "I");
						if (returnTable.getNumRows() > 0)
						{
							do
							{
								if("E".equals(returnTable.getValue("TYPE")))
								{
									isError = true;
									actOnDoc = false;//If SAP returns error DB calls & email should not trigger
									showMsg += returnTable.getValue("MESSAGE"); 

									showErrorMessage += "<Br>Sales Order / Item "+  soNumber+"/"+soItemStr+" is not cancelled. Chek if there is any subsequent documents exists for this item. <Br> "+showMsg;
									okToUpdateText = false;
									log4j.log("::::::::CLIENT:::::::::::ezProcessSubmittedRequest:::::showErrorMessage:::::::::::::::"+showErrorMessage, "E");

								}	


							}while(returnTable.nextRow());
						}	
					}
					log4j.log(":::::NOW ATTEMPT TO UPDATETEXT::::::::::::::::::::"+okToUpdateText, "I");


				}
				catch(Exception e)
				{
					log4j.log("::::::::EXCEPTION:::::::::::ezProcessSubmittedRequest::::::::::::::::::::"+e, "E");
				}
				finally
				{
					if (client!=null)
					{
						log4j.log(":::::::RELEASING CLIENT:::::::::::", "D");
						JCO.releaseClient(client);
						client = null;
						jcoFunction=null;
						commit = null;
					}
				}


				if(!isError)
				{
					showSuccessMessage += "<Br>Sales Order / Item "+  soNumber+"/"+soItemStr+" is cancelled successfully.";
					soItemsVect.addElement(soNumber+"/"+soItemStr);
				}
			}
			else
			{
				showSuccessMessage += "<Br>Sales Order / Item "+  soNumber+"/"+soItemStr+" is Rejected.";
				soItemsVect.addElement(soNumber+"/"+soItemStr);
			}
		}
	} // end if part of ifCrType = "C" i.e. CANCEL OPERATION
	else {
		// Handle crType = "RGA" now

		ReturnObjFromRetrieve valRetObj = null;

		ezc.ezparam.EzcParams valMainParams = new ezc.ezparam.EzcParams(false);
		EziMiscParams valMiscParams = new EziMiscParams();

		valMiscParams.setIdenKey("MISC_SELECT");
		String canQuery="SELECT * FROM EZC_SO_CANCEL_HEADER WHERE ESCH_ID = "+cancellationId;

		valMiscParams.setQuery(canQuery);
		valMainParams.setLocalStore("Y");
		valMainParams.setObject(valMiscParams);
		Session.prepareParams(valMainParams);

		try
		{
			valRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(valMainParams);
		}
		catch(Exception e){}

		String rgaStatus = "";
		if(valRetObj!=null && valRetObj.getRowCount()>0)
		{
			rgaStatus = (valRetObj.getFieldValueString(0,"ESCH_STATUS")).trim();

			log4j.log("actionType======>"+actionType+"::", "D");
			log4j.log("rgaStatus======>"+rgaStatus+"::", "D");

			if("CA".equals(actionType) && "CA".equals(rgaStatus))
				actOnDoc = false;
			if("A".equals(actionType) && "A".equals(rgaStatus))
				actOnDoc = false;

			log4j.log("actOnDoc======>"+actOnDoc, "D");
		}
		if(actOnDoc)
		{
			JCO.Client client		=	null;
			JCO.Function jcoFunctionRGA 	= 	null;
			//JCO.Function commitRGA 		= 	null;


			String site_S = (String)session.getValue("Site");
			String skey_S = "999";
			try // MAIN try block in RGA area
			{
				client 		= EzSAPHandler.getSAPConnection(site_S+"~"+skey_S);
				jcoFunctionRGA 	= EzSAPHandler.getFunction("Z_EZ_BAPI_CUSTOMERRETURN_CRT",site_S+"~"+skey_S);
				//commitRGA 	= EzSAPHandler.getFunction("BAPI_TRANSACTION_COMMIT",site_S+"~"+skey_S);

				Date dateposted = new Date();  
				SimpleDateFormat format = new SimpleDateFormat("MM/dd/yyyy hh:mm");  
				SimpleDateFormat formatyyyymmdd = new SimpleDateFormat("yyyyMMdd");  
				String soItemStrList = "";

				ArrayList splitKey_AL = new ArrayList();
				for(int i=0;i<soNumCnt;i++)
				{
					String itemPlant = request.getParameter("itemPlant_"+soNum[i]+soItem[i]);
					String tmpStr = retSorg[i]+"¥"+retDch[i]+"¥"+retDiv[i]+"¥"+itemPlant+"¥"+soNum[i];

					if (!splitKey_AL.contains(tmpStr)){
						splitKey_AL.add(tmpStr);
					}
				}

				boolean reStkEnt = true;
				boolean createRGA = false;
				boolean isError = false;
				String currentSO = "";

				//Collection c = soNumHT.values();
				//Enumeration cKeys = soNumHT.keys();
				//Iterator itr = cKeys.iterator();

				for(int s=0;s<splitKey_AL.size();s++)
				{
					JCO.ParameterList sapProcRGA 	= jcoFunctionRGA.getImportParameterList();

					JCO.Table returnHeaderIn   	= jcoFunctionRGA.getTableParameterList().getTable("RETURN_HEADER_IN");
					JCO.Table returnHeaderInx  	= jcoFunctionRGA.getTableParameterList().getTable("RETURN_HEADER_INX");
					JCO.Table returnItemTab         = jcoFunctionRGA.getTableParameterList().getTable("RETURN_ITEMS_IN");
					JCO.Table returnItemX          	= jcoFunctionRGA.getTableParameterList().getTable("RETURN_ITEMS_INX");
					JCO.Table returnItemText        = jcoFunctionRGA.getTableParameterList().getTable("RETURN_TEXT");
					JCO.Table returnSchedulesIn     = jcoFunctionRGA.getTableParameterList().getTable("RETURN_SCHEDULES_IN");
					JCO.Table returnSchedulesInx    = jcoFunctionRGA.getTableParameterList().getTable("RETURN_SCHEDULES_INX");
					JCO.Table returnConditionsIn    = jcoFunctionRGA.getTableParameterList().getTable("RETURN_CONDITIONS_IN");
					JCO.Table returnPartners	= jcoFunctionRGA.getTableParameterList().getTable("RETURN_PARTNERS");
					JCO.Table retHeaderText         = jcoFunctionRGA.getTableParameterList().getTable("RETURN_TEXT");

					String splitKey_A 	= (String)splitKey_AL.get(s);
					String salesOrg_A 	= (String)splitKey_A.split("¥")[0];
					String distChnl_A 	= (String)splitKey_A.split("¥")[1];
					String division_A 	= (String)splitKey_A.split("¥")[2];
					String itemPlant_A 	= (String)splitKey_A.split("¥")[3];
					currentSO 		= (String)splitKey_A.split("¥")[4];
					soItemStrList 		= "";

					for(int i=0;i<soNumCnt;i++)
					{
						String itemPlant	= request.getParameter("itemPlant_"+soNum[i]+soItem[i]);
						String tmpStr 		= retSorg[i]+"¥"+retDch[i]+"¥"+retDiv[i]+"¥"+itemPlant+"¥"+soNum[i];

						if(splitKey_A.equals(tmpStr))
						{
							String soNumber 	= soNum[i];
							String soItemStr	= soItem[i];
							String rejReasonCodeStr	= rejReasonCode[i];
							String selRejComments 	= rejComments[i];
							//String retMatStr 	= retMat[i];
							String retMatStr 	= request.getParameter("retMatAct_"+soNumber+soItemStr);
							String retQtyStr 	= retQty[i];
							String retPriceStr 	= retPrice[i];
							String lineStatus 	= request.getParameter("lineStatus"+soNumber+soItemStr);//lineStatuses[i];
							String netPrice		= request.getParameter("retMatNP_"+soNumber+soItemStr);
							String invoiceNum	= request.getParameter("invoiceNum_"+soNumber+soItemStr);
							String invoiceItm	= request.getParameter("invoiceItm_"+soNumber+soItemStr);
							log4j.log("To SAP netPrice======>"+netPrice, "D");
							log4j.log("To SAP lineStatus======>"+lineStatus, "D");

							// check if Sales Order Nr is the one on iteration in hashtable
							//if(!soNumber.equals(currentSO))
							//	continue;

							if("A".equals(actionType) || "R".equals(actionType))
							{
							// Internal User has set Accepted on RGA Line. Treat it like CR Accept

								soItemsVect.addElement(currentSO+"/"+soItemStr+"/"+splitKey_A);

								if("A".equals(actionType))
								{
									String statMsg = "Denied";
									if("A".equals(lineStatus))
									{
										sapProcRGA.setValue("X","TESTRUN");
										createRGA = true;
										statMsg = "Approved";
									}

									showSuccessMessage += "<Br>Sales Order / Item "+  soNumber+"/"+soItemStr+" is "+statMsg+" for Customer Return.";
								}
							}
							if("CA".equals(actionType) && "A".equals(lineStatus))
							{
							// CA = Customer Acceptance of RGA Terms , and lineStatus A should be set for each line that is accepted by Claims

								createRGA = true;
								soItemStrList+=","+soItemStr;
								//showSuccessMessage += "<Br>Sales Order / Item "+  soNumber+"/"+soItemStrList+" is Accepted for Customer Return.";
								soItemsVect.addElement(currentSO+"/"+soItemStr+"/"+splitKey_A);
							}

							if(createRGA)
							{
								String refDocNum = soNumber;
								String refDocItm = soItemStr;
								String refDocCA = "C";

								if((invoiceNum!=null && !"null".equalsIgnoreCase(invoiceNum) && !"".equals(invoiceNum)) && (invoiceItm!=null && !"null".equalsIgnoreCase(invoiceItm) && !"".equals(invoiceItm)))
								{
									refDocNum = invoiceNum;
									refDocItm = invoiceItm;
									refDocCA = "M";
								}

								refDocNum = "0000000000"+refDocNum;
								refDocNum = refDocNum.substring(refDocNum.length()-10,refDocNum.length());

								refDocItm = "000000"+refDocItm;
								refDocItm = refDocItm.substring(refDocItm.length()-6,refDocItm.length());

								if(itemPlant==null || "null".equalsIgnoreCase(itemPlant)) itemPlant = "";

								returnItemTab.appendRow();
								returnItemTab.setValue(splitKey_A,"ZEZSPLITKEY");
								returnItemTab.setValue(soItemStr,"ITM_NUMBER");
								//returnItemTab.setValue(soItemStr,"HG_LV_ITEM");
								returnItemTab.setValue(retMatStr,"MATERIAL");
								returnItemTab.setValue(refDocNum,"REF_DOC");
								returnItemTab.setValue(refDocItm,"REF_DOC_IT");
								returnItemTab.setValue(refDocCA,"REF_DOC_CA");
								returnItemTab.setValue(itemPlant,"PLANT");

								returnItemX.appendRow();
								returnItemX.setValue(splitKey_A,"ZEZSPLITKEY");
								returnItemX.setValue(soItemStr,"ITM_NUMBER");
								returnItemX.setValue("X","MATERIAL");
								returnItemX.setValue("X","REF_DOC");
								returnItemX.setValue("X","REF_DOC_IT");
								returnItemX.setValue("X","REF_DOC_CA");
								returnItemX.setValue("X","PLANT");

								returnSchedulesIn.appendRow();
								returnSchedulesIn.setValue(splitKey_A,"ZEZSPLITKEY");
								returnSchedulesIn.setValue(soItemStr,"ITM_NUMBER");
								returnSchedulesIn.setValue(retQtyStr,"REQ_QTY");

								returnSchedulesInx.appendRow();
								returnSchedulesInx.setValue(splitKey_A,"ZEZSPLITKEY");
								returnSchedulesInx.setValue(soItemStr,"ITM_NUMBER");
								returnSchedulesInx.setValue("X","REQ_QTY");

								String soCondType = "ZMPR";
								if("1001".equals(salesOrg_A))
									soCondType = "ZUMP";
								else if("1002".equals(salesOrg_A))
									soCondType = "ZMPR";
								else if("1004".equals(salesOrg_A))
									soCondType = "ZMPR";

								returnConditionsIn.appendRow();
								returnConditionsIn.setValue(splitKey_A,"ZEZSPLITKEY");
								returnConditionsIn.setValue(soItemStr,"ITM_NUMBER");
								returnConditionsIn.setValue(soCondType,"COND_TYPE");
								returnConditionsIn.setValue(new java.math.BigDecimal(Double.parseDouble(netPrice)/10),"COND_VALUE");

								String stkCondType = "";
								java.math.BigDecimal stkCondVal = null;
								if("PER".equals(restockFeesType))
								{
									stkCondType = "ZURP";
									stkCondVal = new java.math.BigDecimal(Double.parseDouble(restockFees));
								}
								else if("AMT".equals(restockFeesType))
								{
									stkCondType = "ZURD";
									stkCondVal = new java.math.BigDecimal(Double.parseDouble(restockFees)/10);
								}

								if(!"".equals(stkCondType) && reStkEnt)
								{
									returnConditionsIn.appendRow();
									returnConditionsIn.setValue(splitKey_A,"ZEZSPLITKEY");
									returnConditionsIn.setValue("000000","ITM_NUMBER");
									returnConditionsIn.setValue(stkCondType,"COND_TYPE");
									returnConditionsIn.setValue(stkCondVal,"COND_VALUE");
									reStkEnt = false;
								}
							}
						}

					} // end for loop

					if(createRGA)
					{
						String soDocType = "ZRET";
						if("1001".equals(salesOrg_A))
							soDocType = "ZRET";
						else if("1002".equals(salesOrg_A))
							soDocType = "ZRET";
						else if("1004".equals(salesOrg_A))
							soDocType = "RE";

						returnHeaderIn.appendRow();
						returnHeaderIn.setValue(splitKey_A,"ZEZSPLITKEY");
						returnHeaderIn.setValue(currentSO,"REFOBJKEY");
						returnHeaderIn.setValue("TA","REFDOCTYPE");
						returnHeaderIn.setValue(soDocType,"DOC_TYPE");
						returnHeaderIn.setValue(salesOrg_A,"SALES_ORG");
						returnHeaderIn.setValue(distChnl_A,"DISTR_CHAN");
						returnHeaderIn.setValue(division_A,"DIVISION");
						returnHeaderIn.setValue(incoTerm.substring(0,3),"INCOTERMS1");
						returnHeaderIn.setValue(incoTerm.substring(4),"INCOTERMS2"); // Pass part2 of incoTerm in incoTerm String
						returnHeaderIn.setValue(orderReason,"ORD_REASON");
						returnHeaderIn.setValue(poNumber,"PURCH_NO_C");
						returnHeaderIn.setValue(formatyyyymmdd.format(dateposted),"PURCH_DATE"); // CHAITAANTYA --> PASS TODAY's DATE

						returnHeaderInx.appendRow();
						returnHeaderInx.setValue(splitKey_A,"ZEZSPLITKEY");
						returnHeaderInx.setValue("X","PURCH_NO_C");
						returnHeaderInx.setValue("X","PURCH_DATE");
						//returnHeaderInx.setValue("X","REFOBJKEY");
						//returnHeaderInx.setValue("X","REFDOCTYPE");
						returnHeaderInx.setValue("X","DOC_TYPE");
						returnHeaderInx.setValue("X","SALES_ORG");
						returnHeaderInx.setValue("X","DISTR_CHAN");
						returnHeaderInx.setValue("X","DIVISION");
						returnHeaderInx.setValue("X","INCOTERMS1");
						returnHeaderInx.setValue("X","INCOTERMS2");
						returnHeaderInx.setValue("X","ORD_REASON");

						retHeaderText.appendRow();
						retHeaderText.setValue(splitKey_A,"ZEZSPLITKEY");
						retHeaderText.setValue(currentSO,"DOC_NUMBER");
						//retHeaderText.setValue(soItemStr,"ITM_NUMBER");
						retHeaderText.setValue("ZPH1","TEXT_ID");
						retHeaderText.setValue("EN","LANGU");
						retHeaderText.setValue("*","FORMAT_COL");
						retHeaderText.setValue("Return Requested by Portal User: "+requestor+" on: "+reqdate,"TEXT_LINE");
						retHeaderText.setValue("005","FUNCTION");

						retHeaderText.appendRow();
						retHeaderText.setValue(splitKey_A,"ZEZSPLITKEY");
						retHeaderText.setValue(currentSO,"DOC_NUMBER");
						//retHeaderText.setValue(soItemStr,"ITM_NUMBER");
						retHeaderText.setValue("ZPH1","TEXT_ID");
						retHeaderText.setValue("EN","LANGU");
						retHeaderText.setValue("*","FORMAT_COL");
						retHeaderText.setValue("RGA Id on myasb2b.com: "+cancellationId,"TEXT_LINE");
						retHeaderText.setValue("005","FUNCTION");

						retHeaderText.appendRow();
						retHeaderText.setValue(splitKey_A,"ZEZSPLITKEY");
						retHeaderText.setValue(currentSO,"DOC_NUMBER");
						//retHeaderText.setValue(soItemStr,"ITM_NUMBER");
						retHeaderText.setValue("ZPH1","TEXT_ID");
						retHeaderText.setValue("EN","LANGU");
						retHeaderText.setValue("*","FORMAT_COL");
						retHeaderText.setValue("RGA Approved and Posted by Portal user: "+userFNameH + " " +userLNameH +" on "+format.format(dateposted),"TEXT_LINE");
						retHeaderText.setValue("005","FUNCTION");

						int len=0;
						int rem=0;
						String cutLen = "";
						int strLength = invNotes.length();
						if(strLength >130)
						{
							len = strLength / 130 ;
							rem = strLength % 130;
							for(int l=0;l<len;l++)
							{
								try
								{
									cutLen = invNotes.substring(130*l,130*(l+1));
								}
								catch(Exception e)
								{
									cutLen = invNotes.substring(130*l,invNotes.length());
								}

								retHeaderText.appendRow();
								retHeaderText.setValue(splitKey_A,"ZEZSPLITKEY");
								retHeaderText.setValue(currentSO,"DOC_NUMBER");
								//retHeaderText.setValue(soItemStr,"ITM_NUMBER");
								retHeaderText.setValue("0003","TEXT_ID");
								retHeaderText.setValue("EN","LANGU");
								retHeaderText.setValue("*","FORMAT_COL");
								retHeaderText.setValue(cutLen,"TEXT_LINE");
								retHeaderText.setValue("005","FUNCTION");
							}
							if(rem > 0)
							{
								cutLen =invNotes.substring(130*len,strLength);
								retHeaderText.appendRow();
								retHeaderText.setValue(splitKey_A,"ZEZSPLITKEY");
								retHeaderText.setValue(currentSO,"DOC_NUMBER");
								//retHeaderText.setValue(soItemStr,"ITM_NUMBER");
								retHeaderText.setValue("0003","TEXT_ID");
								retHeaderText.setValue("EN","LANGU");
								retHeaderText.setValue("*","FORMAT_COL");
								retHeaderText.setValue(cutLen,"TEXT_LINE");
								retHeaderText.setValue("005","FUNCTION");
							}
						}
						else
						{
							retHeaderText.appendRow();
							retHeaderText.setValue(splitKey_A,"ZEZSPLITKEY");
							retHeaderText.setValue(currentSO,"DOC_NUMBER");
							//retHeaderText.setValue(soItemStr,"ITM_NUMBER");
							retHeaderText.setValue("0003","TEXT_ID");
							retHeaderText.setValue("EN","LANGU");
							retHeaderText.setValue("*","FORMAT_COL");
							retHeaderText.setValue(invNotes,"TEXT_LINE");
							retHeaderText.setValue("005","FUNCTION");
						}

						returnPartners.appendRow();
						returnPartners.setValue(splitKey_A,"ZEZSPLITKEY");
						returnPartners.setValue("AG","PARTN_ROLE");
						returnPartners.setValue(soldToCode,"PARTN_NUMB");

						returnPartners.appendRow();
						returnPartners.setValue(splitKey_A,"ZEZSPLITKEY");
						returnPartners.setValue("WE","PARTN_ROLE");
						returnPartners.setValue(shipToCode,"PARTN_NUMB");

						if("YES".equals(dropShipTo))
						{
							String shipToTransZone = "";
							if(shipToState!=null && !"null".equalsIgnoreCase(shipToState) && !"".equals(shipToState))
								shipToTransZone = "ZUS"+shipToState.trim()+"00000";

							if(shipToCountry==null || "null".equalsIgnoreCase(shipToCountry) || "".equals(shipToCountry))
								shipToCountry = "US";

							returnPartners.setValue(shipToName,"NAME");
							returnPartners.setValue(shipToStreet,"STREET");
							returnPartners.setValue(shipToCity,"CITY");
							returnPartners.setValue(shipToState,"REGION");
							returnPartners.setValue(shipToCountry,"COUNTRY");
							//returnPartners.setValue("US","COUNTRY");
							returnPartners.setValue(shipToZipCode,"POSTL_CODE");
							returnPartners.setValue(shipToPhNum,"TELEPHONE");
							returnPartners.setValue(shipToTransZone,"TRANSPZONE");
						}

						if(!"OTH".equals(forwardingAgent) && !"SEL".equals(forwardingAgent))
						{
							returnPartners.appendRow();
							returnPartners.setValue(splitKey_A,"ZEZSPLITKEY");
							returnPartners.setValue("ZF","PARTN_ROLE");
							returnPartners.setValue(forwardingAgent,"PARTN_NUMB");
						}
					}

					//commitRGA.getImportParameterList().setValue("X", "WAIT");
					log4j.log(":::::APPENDED INFO::::::::::::::::::::Returned by "+userId+currentSO+soItemStrList, "E");
				} // end of splitKey_AL arraylist

				JCO.Table returnTable 	= null;
				if(createRGA)//"CA".equals(actionType)
				{
					client.execute(jcoFunctionRGA);
					//client.execute(commitRGA);
					returnTable = jcoFunctionRGA.getTableParameterList().getTable("RETURN");
				}
				log4j.log(":::::action Type::::::::::::::::::::"+actionType, "I");
				boolean okToUpdateText = true;
				if ( returnTable != null )
				{
					log4j.log(":::::RETURN TABLE FROM SAP::::::::::::::::::::"+returnTable.getNumRows(), "I");
					if (returnTable.getNumRows() > 0)
					{
						do
						{
							if("E".equals(returnTable.getValue("TYPE")))
							{
								isError = true;
								showMsg += returnTable.getValue("MESSAGE"); 

								okToUpdateText = false;
								actOnDoc = false;
								log4j.log("::::::::CLIENT:::::::::::ezProcessSubmittedRequest:::::showErrorMessage:::::::::::::::"+showErrorMessage, "E");
							}	
						}
						while(returnTable.nextRow());

						if(isError)
							showErrorMessage += "<Br>Sales Order / Item "+  currentSO+"/"+soItemStrList+" is not Returnable.  <Br> "+showMsg;
					}
				}
				if(!isError)
				{
					log4j.log(":::::Reached Checking isError::::::::::::::::::::"+actionType, "I");
					if(actionType.equals("CA"))
					{
						if(createRGA)
						{
							JCO.Table returnSAPOrder = jcoFunctionRGA.getTableParameterList().getTable("SAP_SALESORDERS");
							if (returnSAPOrder.getNumRows() > 0)
							{
								do
								{
									String splitKeyOut = (String)returnSAPOrder.getValue("ZEZSPLITKEY");
									backEndRGANum = (String)returnSAPOrder.getValue("SAP_ORDER");

									if((sDocNumber == null) || (sDocNumber.trim().length()==0))
									{
										sDocNumber = backEndRGANum;
									}
									else
									{
										sDocNumber = sDocNumber+ "," + backEndRGANum;
									}
									rgaNumHT.put(splitKeyOut,backEndRGANum);
								}
								while(returnSAPOrder.nextRow());

								showSuccessMessage += "<Br>Sales Order / Item "+  currentSO+"/"+soItemStrList+" is accepted for RGA successfully.<Br>RGA Number(s) : "+sDocNumber;
							}
						}
					}
					else if(actionType.equals("R"))
					{
						showSuccessMessage += "<Br>RGA Request with Id "+cancellationId+" for Sales Order / Item "+  currentSO+"/"+soItemStrList+" has been Withdrawn";
					}
					else
					{
						showSuccessMessage += "<Br>RGA Request with Id "+cancellationId+" for Sales Order / Item "+  currentSO+"/"+soItemStrList+" is sent back to Customer for Acceptance";
					}
					//soItemsVect.addElement(currentSO+"/"+soItemStrList);
				}

			} // end of MAIN try block inside if RGA
			catch(Exception e)
			{
				log4j.log("::::::::EXCEPTION:::::::::::ezProcessSubmittedRequest::::::::::::::::::::"+e, "E");
				JCO.releaseClient(client);
				client = null;
				jcoFunctionRGA=null;
				//commitRGA = null;
				actOnDoc = false;
			}
			finally
			{
				if (client!=null)
				{
					log4j.log(":::::::RELEASING CLIENT:::::::::::", "D");
					JCO.releaseClient(client);
					client = null;
					jcoFunctionRGA=null;
					//commitRGA = null;
				}
			}
		}
		else
		{
			if(("A".equals(actionType) || "CA".equals(actionType) || "R".equals(actionType)))
			{
				showErrorMessage += "<Br>Action has been taken on this RGA request";
			}
		}
	}// end if RGA check

	if(soItemsVect.size()>0 && actOnDoc)
	{
		ezc.ezparam.EzcParams canMainParams = new ezc.ezparam.EzcParams(false);
		EziMiscParams canMiscParams = new EziMiscParams();
		String canQuery = "";
		boolean rgaCreatedForAllItems = true;
		for(int i=0;i<soItemsVect.size();i++)
		{
			String soItemStr        = (String)soItemsVect.get(i);
			log4j.log("soItemStr is ======>"+soItemStr, "D");
			String salesOrdNumber 	= soItemStr.split("/")[0];
			String salesOrdItem 	= soItemStr.split("/")[1];

			String splitKey_RGA 	= "";
			String sapRGANum	= "";
			String sapRGANum_S = "";

			try
			{
				splitKey_RGA 	= soItemStr.split("/")[2];
				sapRGANum	= (String)rgaNumHT.get(splitKey_RGA);
			}
			catch(Exception e){}

			if(crType.equals("RGA") && actionType.equals("CA"))
			{
				if(sapRGANum!=null && !"null".equalsIgnoreCase(sapRGANum) && !"".equals(sapRGANum))
					sapRGANum_S = sapRGANum;
				else
				{
					rgaCreatedForAllItems = false;
					actOnDoc = false;
				}
			}

			String lineStatus 	= request.getParameter("lineStatus"+salesOrdNumber+salesOrdItem);//lineStatuses[i];
			String netPrice		= request.getParameter("retMatNP_"+salesOrdNumber+salesOrdItem);
			String itemApprNote	= request.getParameter("itemApprNotes"+salesOrdNumber+salesOrdItem);
			String itemApprQty	= request.getParameter("retQty_"+salesOrdNumber+salesOrdItem);
			String invoiceNum	= request.getParameter("invoiceNum_"+salesOrdNumber+salesOrdItem);
			String invoiceItm	= request.getParameter("invoiceItm_"+salesOrdNumber+salesOrdItem);
			String itemPlant	= request.getParameter("itemPlant_"+salesOrdNumber+salesOrdItem);
			String itemRetMat	= request.getParameter("retMat_"+salesOrdNumber+salesOrdItem);

			if(itemPlant==null || "null".equalsIgnoreCase(itemPlant)) itemPlant = "";

			log4j.log("Update Status soNumber======>"+salesOrdNumber, "D");
			log4j.log("Update Status soItem======>"+salesOrdItem, "D");
			log4j.log("Update Status netPrice======>"+netPrice, "D");
			log4j.log("Update Status itemApprNote======>"+itemApprNote, "D");
			log4j.log("Update Status lineStatus======>"+lineStatus, "D");

			canMainParams = new ezc.ezparam.EzcParams(false);
			canMiscParams = new EziMiscParams();

			canMiscParams.setIdenKey("MISC_UPDATE");
			canQuery="UPDATE EZC_SO_CANCEL_ITEMS SET ESCI_STATUS = '"+actionType+"',ESCI_COMMENTS = '"+itemApprNote+"' WHERE ESCI_ID = "+cancellationId+" AND ESCI_SO_NUM = '"+salesOrdNumber+"' AND ESCI_SO_ITEM = '"+salesOrdItem+"'";

			if ( crType.equals("RGA") && actionType.equals("A")){
				// do it separately for each line as Acceptance rejection may be different 
				// Also fill in the NET PRICE AND COMMENTS table here based on info from previous page
				canQuery="UPDATE EZC_SO_CANCEL_ITEMS SET ESCI_STATUS = '"+lineStatus+"',ESCI_RETMAT_NP = '"+netPrice+"',ESCI_COMMENTS = '"+itemApprNote+"',ESCI_RET_QTY = '"+itemApprQty+"',ESCI_INV_NUM='"+invoiceNum+"',ESCI_INV_ITEM='"+invoiceItm+"',ESCI_PLANT='"+itemPlant+"',ESCI_RET_MAT='"+itemRetMat+"' WHERE ESCI_ID = "+cancellationId+" AND ESCI_SO_NUM = '"+salesOrdNumber+"' AND ESCI_SO_ITEM = '"+salesOrdItem+"'";
			}
			else if ( crType.equals("RGA") && actionType.equals("CA")){
				canQuery="UPDATE EZC_SO_CANCEL_ITEMS SET ESCI_BACK_END_ORDER = '"+sapRGANum_S+"' WHERE ESCI_ID = "+cancellationId+" AND ESCI_SO_NUM = '"+salesOrdNumber+"' AND ESCI_SO_ITEM = '"+salesOrdItem+"'";
			}

			canMiscParams.setQuery(canQuery);
			canMainParams.setLocalStore("Y");
			canMainParams.setObject(canMiscParams);
			Session.prepareParams(canMainParams);	
			try{	
				ezMiscManager.ezUpdate(canMainParams);
			}catch(Exception e){
				log4j.log(":::::EZC_SO_CANCEL_ITEMS::ezMiscManager::::::::::::ezProcessSubmittedRequest::::::::::::::::::::"+e, "E");
			}
		}
		if(((soItemsVect.size()==soNumCnt) || crType.equals("RGA")) && rgaCreatedForAllItems)
		{
			canMainParams = new ezc.ezparam.EzcParams(false);
			canMiscParams = new EziMiscParams();

			canMiscParams.setIdenKey("MISC_UPDATE");
			canQuery="UPDATE EZC_SO_CANCEL_HEADER SET ESCH_MODIFIED_BY = '"+userId+"',ESCH_MODIFIED_ON = getDate(),ESCH_STATUS = '"+actionType+"',ESCH_APPROVER_NOTE = '"+rejRCCom+"' WHERE ESCH_ID = "+cancellationId;

			if ( crType.equals("RGA") && actionType.equals("A")){
				// IF ITS IS RGA, WE SHOULD UPDATE THE INVOICE TEXT ALSO IF ANY AS IT WILL BE USED TO POST TO SAP
				// ALSO SAVE RESTOCK FEES AND PERCENTAGE VALUE RESPECTIVE FIELDS

				canQuery="UPDATE EZC_SO_CANCEL_HEADER SET ESCH_MODIFIED_BY = '"+userId+"',ESCH_MODIFIED_ON = getDate(),ESCH_STATUS = '"+actionType+"',ESCH_SAP_REASON = '"+orderReason+"', ESCH_INCO_TERM1 = '"+incoTerm.substring(0,3)+"',ESCH_INCO_TERM2 = '"+incoTerm.substring(4)+"',ESCH_SHIPPING_PARTNER = '"+forwardingAgent+"',ESCH_SHIP_TO = '"+shipToCode+"',ESCH_HEADER_FEES_TYPE = '"+restockFeesType+"',ESCH_HEADER_FEES_VALUE = '"+restockFees+"',ESCH_INTERNAL_TEXT = '"+invNotes+"',ESCH_APPROVER_NOTE = '"+retHText+"',ESCH_EXPIRE_ON = convert(datetime,'"+expireOn+"') WHERE ESCH_ID = "+cancellationId;
			}

			canMiscParams.setQuery(canQuery);
			canMainParams.setLocalStore("Y");
			canMainParams.setObject(canMiscParams);
			Session.prepareParams(canMainParams);	
			try{	
				ezMiscManager.ezUpdate(canMainParams);
			}catch(Exception e){
				log4j.log(":::::EZC_SO_CANCEL_HEADER::ezMiscManager::::::::::::ezProcessSubmittedRequest::::::::::::::::::::"+e, "E");
			}
		}
	}
	
	log4j.log(":::::showErrorMessage::::::::::::::::::::"+showErrorMessage, "D");
	log4j.log(":::::showSuccessMessage::::::::::::::::::::"+showSuccessMessage, "D");


	String toEmail	= "";
	String ccEmail	= "";
	String msgText	= "";
	String msgSubject = "";

	Properties prop=new Properties();

	try
	{
		String fileName_P = "ezProcessSubmittedReqMain.jsp";
		String filePath = request.getRealPath(fileName_P);
		filePath = filePath.substring(0,filePath.indexOf(fileName_P));
		filePath +="ezEmailText.properties";

		prop.load(new java.io.FileInputStream(filePath));
	}
	catch(Exception e){}

	boolean insOffLink = false;
	String mainURL = prop.getProperty("MAINURL");
	String offLink = "";
	String toEncryp = "";
	String encrypText = "";

	if(crType.equals("RGA") && actOnDoc)
	{
		// CHAITAANYA, SHOULD WE BE RECREATING THIS URL HERE. I THINK WE SHOULD SEARCH AND SEND THE LINK CREATED AT THE TIME OF REQUEST CREATION ?
		toEncryp = "EzComm/EzSales/Sales/JSPs/Sales/ezCancReqDetailsMain.jsp?cancellationId="+cancellationId+"&crType="+crType;
		encrypText = MD5(toEncryp);
		offLink = "http://"+mainURL+"/AST/ezLinkController.jsp?link="+encrypText;

		String msgSub_Prop = "";
		String msgText_Prop = "";
		if(actionType.equals("A"))
		{
			msgSub_Prop = "EMAILSUB_RGA_APPRVD";
			msgText_Prop = "EMAILBODY_RGA_APPRVD";
		}
		if(actionType.equals("R"))
		{
			msgSub_Prop = "EMAILSUB_RGA_REJECT";
			msgText_Prop = "EMAILBODY_RGA_REJECT";
		}
		if(actionType.equals("CA"))
		{
			msgSub_Prop = "EMAILSUB_RGA_TOSAP";
			msgText_Prop = "EMAILBODY_RGA_TOSAP";
		}
		msgSubject = prop.getProperty(msgSub_Prop);
		msgSubject = msgSubject.replaceAll("%PONumber%",poNumber);
		msgSubject = msgSubject.replaceAll("%RGANumber%",cancellationId);
		msgText = prop.getProperty(msgText_Prop);
		msgText = msgText.replaceAll("%ConcernedUser%",requestorName);
		msgText = msgText.replaceAll("%MainURL%",mainURL);
		msgText = msgText.replaceAll("%OffLineURL%",offLink);

		toEmail = getUserEmail(Session,requestor);

		log4j.log("toEmailtoEmailtoEmail======>"+toEmail, "D");
		log4j.log("ccEmailccEmailccEmail======>"+ccEmail, "D");
		log4j.log("msgTextmsgTextmsgText======>"+msgText, "D");
		log4j.log("msgSubjectmsgSubject======>"+msgSubject, "D");

		//toEmail = "georgesa@AmericanStandard.com";
		//ccEmail = "chanumanthu@answerthink.com,mbablani@answerthink.com";

		sendEmail(Session,toEmail,ccEmail,msgText,msgSubject);
		insOffLink = true;
	}
	else if((crType.equals("C") || crType.equals("RC")) && actOnDoc)
	{
		toEncryp = "EzComm/EzSales/Sales/JSPs/Sales/ezCancReqDetailsMain.jsp?cancellationId="+cancellationId+"&crType="+crType;
		encrypText = MD5(toEncryp);
		offLink = "http://"+mainURL+"/AST/ezLinkController.jsp?link="+encrypText;

		String msgSub_Prop = "";
		String msgText_Prop = "";
		if(actionType.equals("A"))
		{
			msgSub_Prop = "EMAILSUB_CR_APR_TOCU";
			msgText_Prop = "EMAILBODY_CR_APR_TOCU";
		}
		if(actionType.equals("R"))
		{
			msgSub_Prop = "EMAILSUB_CR_REJ_TOCU";
			msgText_Prop = "EMAILBODY_CR_REJ_TOCU";
		}
		msgSubject = prop.getProperty(msgSub_Prop);
		msgSubject = msgSubject.replaceAll("%PONumber%",poNumber);
		msgText = prop.getProperty(msgText_Prop);
		msgText = msgText.replaceAll("%ConcernedUser%",requestorName);
		msgText = msgText.replaceAll("%MainURL%",mainURL);
		msgText = msgText.replaceAll("%OffLineURL%",offLink);

		toEmail = getUserEmail(Session,requestor);

		log4j.log("toEmailtoEmailtoEmail======>"+toEmail, "D");
		log4j.log("ccEmailccEmailccEmail======>"+ccEmail, "D");
		log4j.log("msgTextmsgTextmsgText======>"+msgText, "D");
		log4j.log("msgSubjectmsgSubject======>"+msgSubject, "D");

		//toEmail = "georgesa@AmericanStandard.com";
		//ccEmail = "chanumanthu@answerthink.com,mbablani@answerthink.com,georgesa@AmericanStandard.com";

		sendEmail(Session,toEmail,ccEmail,msgText,msgSubject);
		insOffLink = true;
	}

	if(insOffLink)
	{
		/******************************/
		EzcParams mainParamsURL = new EzcParams(false);
		EziMiscParams miscParamsURL = new EziMiscParams();

		miscParamsURL.setIdenKey("MISC_INSERT");
		miscParamsURL.setQuery("INSERT INTO EZC_URL_MAPPING(EUM_SHORT_URL,EUM_ACTUAL_URL) VALUES('"+encrypText+"','"+toEncryp+"')");

		mainParamsURL.setLocalStore("Y");
		mainParamsURL.setObject(miscParamsURL);
		Session.prepareParams(mainParamsURL);	

		try
		{
			ezMiscManager.ezAdd(mainParamsURL);
		}
		catch(Exception e){}
		/******************************/

		if(crType.equals("RGA") && actionType.equals("CA"))
		{
			try
			{
				String tempDocNo_U = "";
				String tempUrlLink_U = offLink;
				String tempDocType_U = "RE";

				StringTokenizer sDocToken = new StringTokenizer(sDocNumber,",");
				while(sDocToken.hasMoreElements())
				{
					tempDocNo_U = (String)sDocToken.nextElement();
					tempDocNo_U = "0000000000"+tempDocNo_U;
					tempDocNo_U = tempDocNo_U.substring(tempDocNo_U.length()-10,tempDocNo_U.length());
					log4j.log("tempDocNo_UtempDocNo_U======>"+tempDocNo_U, "D");
%>
				<%@ include file="../../../Sales/JSPs/UploadFiles/ezSendURLToSap.jsp"%>
<%
				}
			}
			catch(Exception e){}
		}
	}

	String outMsg = "";
	String outMsgF = "";
	String outMsgB = "";
	String outMsgH = "Cancellation Processed Confirmation";

	if(crType.equals("RGA"))
	{
		outMsgH = "RGA Posting Confirmation";
	}

	if(!"".equals(showErrorMessage))
	{
		outMsg = "ERROR : <BR>"+showErrorMessage;
	}
	else if(!"".equals(showSuccessMessage))
	{
		outMsg = "SUCCESS : <BR>"+showSuccessMessage;
	}

	if("A".equals(actionType) && (crType.equals("C") || crType.equals("RC")))
		outMsgF = "PLEASE NOTE THAT DUE TO CUSTOMER REQUESTED CHANGES TO THIS ORDER PRICING TERMS AND FREIGHT CHARGES MAY BE AFFECTED";

	outMsgB = "<a href=\"JavaScript:funSubmit(\'"+crType+"\')\"><small>&laquo;</small>Ok</a>";

	if(session.getValue("EzMsg")!=null)
		session.removeValue("EzMsg"); 
	if(session.getValue("EzMsgF")!=null)
		session.removeValue("EzMsgF"); 
	if(session.getValue("EzMsgB")!=null)
		session.removeValue("EzMsgB"); 
	if(session.getValue("EzMsgH")!=null)
		session.removeValue("EzMsgH"); 

	session.putValue("EzMsg",outMsg);
	session.putValue("EzMsgF",outMsgF);
	session.putValue("EzMsgB",outMsgB);
	session.putValue("EzMsgH",outMsgH);

log4j.log("EzMsgEzMsgEzMsg======>"+(String)session.getValue("EzMsg"), "D");
log4j.log("EzMsgFEzMsgFEzMsgF======>"+(String)session.getValue("EzMsgF"), "D");
log4j.log("EzMsgBEzMsgBEzMsgB======>"+(String)session.getValue("EzMsgB"), "D");

	response.sendRedirect("../Sales/ezRetOutMsg.jsp");
}
else
{

%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Authorization Error</title>
</head> 
<body class=" customer-account-index">
<div class="main-container col2-layout middle account-pages">
<div class="main">
<div class="col-main1 roundedCorners">
<div class="page-title">
<%
	String authKey = "SO_CANCEL";//(String) request.getAttribute("authKey");
	if(authKey == null) authKey = "";
%>
<h2> Authorization Check Failed </h2>
<p> You are not authorized to view requested information.
<br>Please contact your ASB Administrator or ASB Customer Service if you believe you have received this in error.
<br><strong>Information for Administrator : Auth Key Code checked </strong><%=authChkStr%></p>
<br>
<div id="divAction" style="display:block">
	<button type="button" title="Back" class="button btn-update" onclick="javascript:history.go(-1)"><span>Back</span></button>
</div>
</div>
</div>
</div>
</div>
</body>
</html>
<%
}
%>
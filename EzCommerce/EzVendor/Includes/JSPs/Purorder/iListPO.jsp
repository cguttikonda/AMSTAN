<%@ page import ="ezc.ezparam.*" %>
<%@ page import ="ezc.ezutil.FormatDate.*"%>
<%@ include file="../../Lib/PurchaseBean.jsp"%>
<jsp:useBean id="PoManager" class="ezc.client.EzPurchaseManager" scope="page" />
<jsp:useBean id="AppManager" class="ezc.ezvendorapp.client.EzVendorAppManager" scope="session" />

<%!
	public java.util.Date getDateFormat(String fromDate){
	
		ezc.ezutil.FormatDate formatDate=new ezc.ezutil.FormatDate();
		int dateArray[] = formatDate.getMMDDYYYY(fromDate, true);
				
		dateArray[0]=dateArray[0]-1;
		Date FromDate=new java.sql.Date(dateArray[2]-1900,dateArray[0],dateArray[1]);
		
		return FromDate;
	
	}

%>

<%
	int x=0;

	java.util.Vector v=null;
	java.util.Hashtable blockedPOs=null;

 	String sysKey =(String) session.getValue("SYSKEY");
 	String soldTo =(String) session.getValue("SOLDTO");

 	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(true);
 	mainParams.setLocalStore("Y");	    

 	ezc.ezvendorapp.params.EziPurchaseOrderParams iParams =  new ezc.ezvendorapp.params.EziPurchaseOrderParams();
 	iParams.setSysKey(sysKey);
 	iParams.setSoldTo(soldTo);
     
 	mainParams.setObject(iParams);	
 	Session.prepareParams(mainParams);

 	ezc.ezparam.ReturnObjFromRetrieve retPo = (ezc.ezparam.ReturnObjFromRetrieve)AppManager.ezGetPOAcknowledgement(mainParams);

	final String ORDER = "ORDER";
	final String ORDERDATE = "ORDERDATE";
	final String DELIVERYDATE = "DELIVERYDATE";

	EzPurchHdrXML hdrXML =null;
	EzPSIInputParameters iparams = new EzPSIInputParameters();
	ezc.ezparam.EzcPurchaseParams newParams = new ezc.ezparam.EzcPurchaseParams();
	ezc.ezpurchase.params.EziPurchaseInputParams testParams = new ezc.ezpurchase.params.EziPurchaseInputParams();

	String searchFlag=request.getParameter("SearchFlag");
	String materialNumber=request.getParameter("MaterialNumber");
	String POSearch=request.getParameter("POSearch");
	String POMatSearch=request.getParameter("POMatSearch");

	String shortText=request.getParameter("ShortText");
	
	String orderType=request.getParameter("OrderType");
	
	String dcno=request.getParameter("DCNO");
	String userType=(String)session.getValue("UserType");
	String vendor=(String)session.getValue("SOLDTO");
	
	ezc.ezcommon.EzLog4j.log("searchFlag*"+searchFlag,"I");
	ezc.ezcommon.EzLog4j.log("materialNumber*"+materialNumber,"I");
	ezc.ezcommon.EzLog4j.log("POSearch*"+POSearch,"I");
	ezc.ezcommon.EzLog4j.log("POMatSearch*"+POMatSearch,"I");
	ezc.ezcommon.EzLog4j.log("shortText*"+shortText,"I");
	ezc.ezcommon.EzLog4j.log("fromDate*"+fromDate,"I");
	ezc.ezcommon.EzLog4j.log("toDate*"+toDate,"I");
	ezc.ezcommon.EzLog4j.log("orderType*"+orderType,"I");
		
	int hdrxmlCnt = 0;
		
	if( ((!"null".equals(fromDate)) && (!"null".equals(toDate)) && (fromDate!=null && toDate!=null )   ) && ("All".equals(orderType) || "Open".equals(orderType) || "Closed".equals(orderType) )){
		
		ezc.ezcommon.EzLog4j.log("Date to be setOKKKKKKKKKFINALLLLSET ","I");
		testParams.setFromDate(getDateFormat(fromDate));
		testParams.setToDate(getDateFormat(toDate));
		ezc.ezcommon.EzLog4j.log("Date to be set end","I");
	}
		
	iparams.setMaterial("");
	if (searchFlag==null || "null".equals(searchFlag)){
		searchFlag="AllPurchaseOrders";
	}
	
	if (searchFlag.equals("DCnoSearch")){

		EzcParams params=new EzcParams(true);

		

		//dcno = "*"+dcno+"*"; // DELETE THIS STATEMENT. SOMA.

		ezc.ezshipment.params.EziSearchInputStructure inStruct=new ezc.ezshipment.params.EziSearchInputStructure();
		inStruct.setBase("DCPO");
		//inStruct.setBase("PLPO"); //POs BY PLANT.

		inStruct.setVendor(vendor);
		inStruct.setDocnum(dcno);

		params.setObject(inStruct);
		Session.prepareParams(params);
		ezc.ezshipment.client.EzShipmentManager Manager=new ezc.ezshipment.client.EzShipmentManager();
		hdrXML=(EzPurchHdrXML) Manager.ezGetPOListForDCNumber(params);
		
	}

	if(searchFlag.equals("MaterialNumber")){
		if(!"null".equals(materialNumber)){
			
			EzcParams params=new EzcParams(true);
			materialNumber=materialNumber.trim();
			/*
				testParams.setMaterial(materialNumber.toUpperCase());
				newParams.createContainer();
				newParams.setObject(iparams);
				newParams.setObject(testParams);
			*/
			// added by Suresh.V
	
			ezc.ezshipment.params.EziSearchInputStructure inStruct=new ezc.ezshipment.params.EziSearchInputStructure();
			inStruct.setBase("MATN");
			inStruct.setVendor(vendor);
			inStruct.setDocnum(materialNumber.toUpperCase());
			params.setObject(inStruct);
			
			///ezc.ezcommon.EzLog4j.log("pono>>MATNO"+materialNumber,"I");

			Session.prepareParams(params);
			ezc.ezshipment.client.EzShipmentManager Manager=new ezc.ezshipment.client.EzShipmentManager();

			hdrXML=(EzPurchHdrXML) Manager.ezGetPOListForDCNumber(params);
			/////hdrXML = (EzPurchHdrXML)PoManager.ezGetPurchaseOrderListByMaterial(newParams);
		}

	}
	//added by Suresh.V
	if("Yes".equals(POSearch)){

			String pono = request.getParameter("PurchaseOrder");
			pono = pono.trim();

			
			EzcParams params=new EzcParams(true);
			ezc.ezshipment.params.EziSearchInputStructure inStruct=new ezc.ezshipment.params.EziSearchInputStructure();
			inStruct.setBase("PONO");
			inStruct.setVendor(vendor);
			inStruct.setDocnum(pono);

			params.setObject(inStruct);

			Session.prepareParams(params);
			ezc.ezshipment.client.EzShipmentManager Manager=new ezc.ezshipment.client.EzShipmentManager();
			
			hdrXML=(EzPurchHdrXML) Manager.ezGetPOListForDCNumber(params);
	}
	
	String SearchFlagDc = request.getParameter("SearchFlagDc");
	//ends Here
	if(searchFlag.equals("ShortText")){
		
		if(shortText!=null)
		{
			shortText=shortText.trim();
			testParams.setShortText(shortText);
			newParams.createContainer();
			newParams.setObject(testParams);
			newParams.setObject(iparams);
			Session.prepareParams(newParams);
			hdrXML = (EzPurchHdrXML)PoManager.ezGetPurchaseOrderListByShortText(newParams);

		}

	}
	
	if(searchFlag.equals("FromDate")){	
		if(fromDate!=null)
		{
			java.sql.Date  fomattedDate;
			//getSqlDateFromString Code To Be Moved to The Manager
			ezc.ezutil.FormatDate formatDate=new ezc.ezutil.FormatDate();
			int dateArray[] = formatDate.getMMDDYYYY(fromDate, true);

			dateArray[0]=dateArray[0]-1;
			Date FromDate=new java.sql.Date(dateArray[2]-1900,dateArray[0],dateArray[1]);

			testParams.setFromDate(FromDate);
			newParams.createContainer();
			newParams.setObject(iparams);

			newParams.setObject(testParams);
			Session.prepareParams(newParams);
			hdrXML = (EzPurchHdrXML)PoManager.ezGetPurchaseOrderListSince(newParams);

		}
	}

	if(searchFlag.equals("AllPurchaseOrders"))
	{
		if(orderType!=null)
		{
			orderType=orderType.trim();
			if( (orderType==null || orderType.equals("All") ) )
			{
				newParams.createContainer();
				newParams.setObject(iparams);
				newParams.setObject(testParams);
				Session.prepareParams(newParams);
				hdrXML = (EzPurchHdrXML)PoManager.ezGetAllPurchaseOrderList(newParams);
				//ezc.ezcommon.EzLog4j.log("hdrXML AllPurchaseOrders*"+hdrXML.toEzcString(),"I");
				//ezc.ezcommon.EzLog4j.log("retPo AllPurchaseOrders*"+retPo.toEzcString(),"I");
				v = new java.util.Vector();
				int retCount =  retPo.getRowCount();
				for(int j=0;j<retCount;j++)
				{
					if( retPo.getFieldValueString(j,"DOCSTATUS").equals("B"))
					{
						if("3".equals(userType))
					  		v.addElement(retPo.getFieldValueString(j,"DOCNO"));

					}
				}


			}
			if( (orderType.equals("Open")) )
			{
				newParams.createContainer();
				newParams.setObject(testParams);
				newParams.setObject(iparams);
				Session.prepareParams(newParams);
				hdrXML = (EzPurchHdrXML)PoManager.ezGetOpenPurchaseOrderList(newParams);
				////ezc.ezcommon.EzLog4j.log(hdrXML.toEzcString(),"I");
				v = new java.util.Vector();
				blockedPOs = new java.util.Hashtable();
				int retCount =  retPo.getRowCount();
				for(int j=0;j<retCount;j++)
				{
					if(retPo.getFieldValueString(j,"DOCSTATUS").equals("B"))
					{
						v.addElement(retPo.getFieldValueString(j,"DOCNO"));
					}
					else if( (retPo.getFieldValueString(j,"DOCSTATUS").equals("R") ||  retPo.getFieldValueString(j,"DOCSTATUS").equals("B") || retPo.getFieldValueString(j,"DOCSTATUS").equals("A") || retPo.getFieldValueString(j,"DOCSTATUS").equals("X")) && (!userType.equals("3")) )
					{
						blockedPOs.put(retPo.getFieldValueString(j,"DOCNO"),retPo.getFieldValueString(j,"DOCSTATUS"));
					}
				}
				
				//ezc.ezcommon.EzLog4j.log("STATUS B POS>>>"+v,"I");
				///ezcommon.EzLog4j.log("STATUS ACK[RBAX] POS>>>"+blockedPOs,"I");
			}
			if( (orderType.equals("Closed")) )
			{
				newParams.createContainer();
				newParams.setObject(testParams);
				newParams.setObject(iparams);
				Session.prepareParams(newParams);
				hdrXML = (EzPurchHdrXML)PoManager.ezGetClosedPurchaseOrderList(newParams);
			}
			if(orderType.equals("New"))
			{
				newParams.createContainer();
				newParams.setObject(iparams);
				testParams.setSelectionFlag("O");
				newParams.setObject(testParams);
				Session.prepareParams(newParams);
				hdrXML = (EzPurchHdrXML)PoManager.ezGetOpenPurchaseOrderList(newParams);
				int retCount =  retPo.getRowCount();
				v = new java.util.Vector();
				for(int j=0;j<retCount;j++)
				{
					if(retPo.getFieldValueString(j,"DOCSTATUS").equals("X"))
					{
						v.addElement(retPo.getFieldValueString(j,"DOCNO"));
					}
				}

				if(v.size()>0)
				{

					java.util.Date d = new java.util.Date();
					FormatDate formatDate = new FormatDate();
					String date=formatDate.getStringFromDate(d,".",FormatDate.DDMMYYYY);

					ezc.ezvendorapp.params.EzPOAcknowledgementTableRow tableRow=null;
					ezc.ezvendorapp.params.EzPOAcknowledgementTable table=new ezc.ezvendorapp.params.EzPOAcknowledgementTable();

					ezc.ezparam.EzcParams ezParams = new ezc.ezparam.EzcParams(true);
					ezParams.setLocalStore("Y");

					int cnt = v.size();
					int c = hdrXML.getRowCount();
					String poNo = "";
					String localPo = "";	
					boolean newFlag=false;
					for(int i=0;i<cnt;i++)
					{
						newFlag = false;
						for(int j=0;j<c;j++)
						{
							poNo=hdrXML.getFieldValueString(j,ORDER);	
							localPo = (String)v.elementAt(i);	
							if(localPo.equals(poNo))
							{
								newFlag=true;
								break;														   		
							}

						}

						if(!newFlag)	
						{

							tableRow = new ezc.ezvendorapp.params.EzPOAcknowledgementTableRow();
							tableRow.setDocNo(localPo);
							tableRow.setDocStatus("A");
							tableRow.setModifiedOn(date);
							table.appendRow(tableRow);
							x++;
						}	
					}

					if(x>0)
					{
						ezParams.setObject(table);
						Session.prepareParams(ezParams);
						AppManager.ezUpdatePOAcknowledgement(ezParams);
					}
				}

			}
		}
		else
		{
			newParams.createContainer();
			newParams.setObject(iparams);
			newParams.setObject(testParams);
			Session.prepareParams(newParams);
			//hdrXML = (EzPurchHdrXML)PoManager.ezPurchaseOrderList(newParams);
		}
		
		
			
	}
	//
	
	if(hdrXML!=null)
	{
		hdrxmlCnt = hdrXML.getRowCount();
		//hdrXML.sort(ORDER,true);
		//ezc.ezcommon.EzLog4j.log("MY CHK VALUE>>>"+hdrXML.toEzcString(),"I");
		
	}
	ezc.ezcommon.EzLog4j.log("++++"+hdrXML.getRowCount(),"I");
	/************
		
	B -- Blocked POs
	A -- To be Acknowledged
	X -- Acknowledged
	R -- Rejected
		
	*************/
	
	
%>

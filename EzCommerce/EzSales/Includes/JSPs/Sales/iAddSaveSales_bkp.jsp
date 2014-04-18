<%@ page import="java.util.*"%>
<%@ page import = "ezc.shopping.cart.params.*,ezc.shopping.cart.client.*,ezc.shopping.cart.common.*,ezc.sales.params.*" %>
<%@ include file="../Lables/iAddModifyInfo_Lables.jsp" %>
<%@ include file="../../../Includes/Lib/ezWorkFlow.jsp" %>
<%
	String headerReqDate = request.getParameter("requiredDate");
	GregorianCalendar reqDateH = null;
	try{
		reqDateH =new GregorianCalendar(Integer.parseInt(headerReqDate.substring(6,10)),(Integer.parseInt(headerReqDate.substring(3,5))-1),Integer.parseInt(headerReqDate.substring(0,2)));
	}catch(Exception e){
		reqDateH =(GregorianCalendar)GregorianCalendar.getInstance();
	}
	String PartnNum = setSalVal.getSoldTo();
	String msgExt = "";
	String msgInt = "";
	String subject = "";
	if(("TRANSFERED").equals(status))
	{
%>		<%@ include file="iAddSaveSapShopCartSales.jsp" %>
<%
	}
	
	ReturnObjFromRetrieve retObj=null;
	EzcSalesOrderParams ezcParams = new EzcSalesOrderParams();
	ezcParams.setLocalStore("Y");
	Session.prepareParams(ezcParams);
	
	EzBapisdheadStructure ezHeader  = new EzBapisdheadStructure();
	EzBapisoldtoStructure ezSoldTo  = new EzBapisoldtoStructure();
	EzBapishiptoStructure ezShipTo  = new EzBapishiptoStructure();
	EzBapipartnrTable partnerTable 	= new EzBapipartnrTable();
	EzBapipartnrTableRow prtnrTblRow= new EzBapipartnrTableRow();

  	if(SAPnumber)
  	{
		EzDeliverySchedulesTable  delTable = new  EzDeliverySchedulesTable();
		EzDeliverySchedulesTableRow delRow = new EzDeliverySchedulesTableRow();

		partnerTable.insertRow(0,prtnrTblRow);
		EzBapiiteminTable tblRow = new EzBapiiteminTable();
		EziSalesOrderCreateParams iSOCrParams = new EziSalesOrderCreateParams();
	
		iSOCrParams.setOrderHeaderIn(ezHeader);
		iSOCrParams.setShipToParty(ezShipTo);
		iSOCrParams.setSoldToParty(ezSoldTo);
		iSOCrParams.setOrderPartners(partnerTable);
		iSOCrParams.setOrderItemsIn(tblRow);

	 	ezHeader.setDocType(docType);
		ezHeader.setRefDoc(setSalVal.getScDoc());  	//this is customer sales contract no
		ezHeader.setRefDocNr(setSalVal.getRefDocNr());	//setRefDoc.This is customer sap no
		ezHeader.setRef1(carrierName);
		if((setSalVal.getRefDocNr() == null)||(setSalVal.getRefDocNr().trim().length()!=0))
		{
			ezHeader.setRefDocType("P");
		}
		else
		{
			ezHeader.setRefDocType("S");
		}	
		ezHeader.setDocCurrency(setSalVal.getDocCurrency());
		String netvalueH = setSalVal.getEstNetValue();
		netvalueH=(netvalueH== null|| netvalueH.trim().length()==0)?"0":netvalueH;
		//ezHeader.setNetValue(netvalueH);
		ezHeader.setPoNr(setSalVal.getPoNo());
		ezHeader.setAgentCode(setSalVal.getAgent());
		ezHeader.setStatus(status);
		ezHeader.setOrderDate(new Date());
		ezHeader.setCreatedBy(user);
		ezHeader.setModifiedBy(user);

		if(("TRANSFERED").equals(status))
		{
			if(sDocNumber.trim().length()>10)
				ezHeader.setBackEndOrder("Multi Orders");
			else
				ezHeader.setBackEndOrder(sDocNumber);
		}
		else
		{
			ezHeader.setBackEndOrder("");
		}
		ezHeader.setTransferDate(new Date());	//this will be entered at the time of posting to sap
		ezHeader.setCreatedOn(new Date());	//this will be defaulted to today
		ezHeader.setModifiedOn(new Date());	//this will be defaulted to today
		ezHeader.setStatusDate(new Date());	//this will be defaulted to today
		ezHeader.setPoMethod("EB2B");
		ezHeader.setIncoterms1(incoTerms1);
		ezHeader.setIncoterms2(incoTerms2);
		ezHeader.setShipCond(shippingCond);
		ezHeader.setPmnttrms(setSalVal.getPaymentTerms());
		ezHeader.setText1(generalNotesAll);
		ezHeader.setText2(generalNotes1);
		ezHeader.setText3(generalNotes2);
		ezHeader.setSalesArea(salesAreaCode);
		ezHeader.setReserved1(setSalVal.getPoDate());
		//ezHeader.setINCOTerms3("");		
		//ezHeader.setReserved2();		//this is for reason for rejection
		try
		{
			String poDat = setSalVal.getPoDate();
			int mn = Integer.parseInt(poDat.substring(0,2));
			int dt = Integer.parseInt(poDat.substring(3,5));
			int yr = Integer.parseInt(poDat.substring(6,10));
			GregorianCalendar reqDatePO = new GregorianCalendar(yr,mn-1,dt);
			ezHeader.setPurchDate(reqDatePO.getTime());
		}
		catch(Exception e){}
		try
		{
			String poDat = setSalVal.getPoDate();
			int mn = Integer.parseInt(poDat.substring(0,2));
			int dt = Integer.parseInt(poDat.substring(3,5));
			int yr = Integer.parseInt(poDat.substring(6,10));
			GregorianCalendar reqDatePO = new GregorianCalendar(yr,mn-1,dt);
			ezHeader.setPurchDate(reqDatePO.getTime());
		}catch(Exception e){}
		ezHeader.setReqDateH(reqDateH.getTime());
		ezHeader.setDelFlag("N");
	// SOLDTO
		ezSoldTo.setSoldTo(setSalVal.getSoldTo());
		ezSoldTo.setName(setSalVal.getSoldToName());
		ezSoldTo.setStreet(setSalVal.getSoldToAddress1());
		ezSoldTo.setCity(setSalVal.getSoldToAddress2());
		ezSoldTo.setRegion(setSalVal.getSoldToState());
		ezSoldTo.setPostlCode(setSalVal.getSoldToZipcode());
		ezSoldTo.setCountry(setSalVal.getSoldToCountry());
	// SHIPTO
		ezShipTo.setShipTo(setSalVal.getShipTo());
		ezShipTo.setName(setSalVal.getShipToName());
		ezShipTo.setStreet(setSalVal.getShipToAddress1());
		ezShipTo.setCity(setSalVal.getShipToAddress2());
		ezShipTo.setRegion(setSalVal.getShipToState());
		ezShipTo.setPostlCode(setSalVal.getShipToZipcode());
		ezShipTo.setCountyCde(setSalVal.getShipToCountry());

		EzBapiiteminTableRow rowItm = null;
		int rows = Integer.parseInt(setSalVal.getTotal());
		int dateReq=0,monthReq=0,yearReq=0;
		int delcount=0;
	       	java.math.BigDecimal tValue = new java.math.BigDecimal("0");

		for(int i=0;i<prodCodeLength;i++)
		{
			rowItm = new EzBapiiteminTableRow();
			prodDesc_1[i] 	= EzReplace.setReplace(prodDesc_1[i]);
			String ItemCat 	= prodItemCat_1[i];
			ItemCat 	= ((ItemCat==null)||(("").equals(ItemCat)))?"TAN":ItemCat;
			prodUomQty[i] 	= ((prodUomQty[i]==null)||(("").equals(prodUomQty[i])))?"1":prodUomQty[i];
			prodDQty_1[i] 	= ((prodDQty_1[i]==null)||(("").equals(prodDQty_1[i])))?"0":prodDQty_1[i];
			prodUomQty[i]	= prodUomQty[i].trim();
			desiredPrice 	= desiredPrice_1[i];
			desiredPrice 	= ((desiredPrice == null) || (("").equals(desiredPrice)))?"0":desiredPrice;
			value 		= lineValue_1[i];
			String line 	= String.valueOf((i+1)*10);

			rowItm.setItmNumber(new java.math.BigInteger(line));	// Line numbers will be 10,20,30...
			rowItm.setMaterial(prodCode_1[i]);
			rowItm.setShortText(prodDesc_1[i]);
			rowItm.setSalesUnit(prodPack_1[i]);
			rowItm.setReqQty1(new java.math.BigDecimal(prodDQty_1[i]));
			rowItm.setConfirmedQty(new java.math.BigDecimal(prodDQty_1[i]));
			try{
				rowItm.setQtyInSalesUnit(new java.math.BigDecimal(prodUomQty[i]));
			}catch(Exception e){
				rowItm.setQtyInSalesUnit(new java.math.BigDecimal("1"));
			}
			
			java.math.BigDecimal dCQTY = new java.math.BigDecimal(prodDQty_1[i]);
			java.math.BigDecimal cPrice= new java.math.BigDecimal(desiredPrice);
			java.math.BigDecimal iValue= dCQTY.multiply(cPrice);

			tValue=tValue.add(iValue);
			
			try
			{
				monthReq = Integer.parseInt(desiredDate_1[i].substring(0,2));
				dateReq = Integer.parseInt(desiredDate_1[i].substring(3,5));
				yearReq = Integer.parseInt(desiredDate_1[i].substring(6,10));
				GregorianCalendar reqDateI = new GregorianCalendar(yearReq,monthReq-1,dateReq);

				rowItm.setReqDate( reqDateI.getTime());
				rowItm.setDlvDate( reqDateI.getTime());
			}catch(Exception e){
				rowItm.setReqDate( reqDateH.getTime());
				rowItm.setDlvDate( reqDateH.getTime());
			}
			rowItm.setReqPrice(new java.math.BigDecimal(desiredPrice));
			rowItm.setNetPrice(new java.math.BigDecimal(value));
			rowItm.setConfirmedPrice(new java.math.BigDecimal(desiredPrice));
			rowItm.setCurrency(setSalVal.getDocCurrency());
			rowItm.setDelFlag("N");
			rowItm.setItemCateg(ItemCat);
			rowItm.setItemFOC("0");
			rowItm.setRefDocIt(new java.math.BigInteger("0"));

			if(("TRANSFERED").equals(status))
			{
				String backorderno="";
				String actLine ="";
				for(int ord = 0;ord<orders.getRowCount();ord++)
				{
					String sDocLine = orders.getFieldValueString(ord,"LineNo");
					String sMatCode = orders.getFieldValueString(ord,"MatCode");
					if(prodCode_1[i].equals(sMatCode))
					{
						backorderno	=orders.getFieldValueString(ord,"SalesOrder");
						actLine		=orders.getFieldValueString(ord,"BackLineNo");
						break;
					}
				}
				rowItm.setBackEndOrder(backorderno);
				rowItm.setBackEndItem(actLine);
			}
			else
			{
				rowItm.setBackEndOrder("");
				rowItm.setBackEndItem("");
			}
			tblRow.insertRow(i,rowItm);

			String del_Qty 		     = ((del_sch_qty_1[i]==null)||(("").equals(del_sch_qty_1[i])))?"0":del_sch_qty_1[i];
			String del_Dates 	     = ((del_sch_date_1[i]==null)||(("").equals(del_sch_date_1[i])))?" ":del_sch_date_1[i];
			StringTokenizer del_Dates_St = new StringTokenizer(del_Dates,"@@");
			StringTokenizer del_Qty_ST   = new StringTokenizer(del_Qty,"@@");
			int del_Qty_Count 	     = del_Qty_ST.countTokens();
			String schqty1[]  	     = new String[del_Qty_Count];
			String schdate1[] 	     = new String[del_Qty_Count];

			for(int d=0;d<del_Qty_Count;d++)
			{
				delRow = new  EzDeliverySchedulesTableRow();
				schqty1[d] 	= del_Qty_ST.nextToken();
				schdate1[d] 	= del_Dates_St.nextToken();
				schqty1[d] 	= ((schqty1[d] == null) || ("null".equals(schqty1[d]) ) ||(schqty1[d].trim().length() ==0) )?"0":schqty1[d];
				String s 	= String.valueOf( (i+1)*10);

				if(!"0".equals(schqty1[d]))
				{
					delcount=delcount+1;
					delRow.setItemNumber(s);
					delRow.setScheduleLine(String.valueOf(delcount));
					delRow.setRequiredQty(schqty1[d]);
					delRow.setRequiredDate(schdate1[d]);
					delRow.setDateType("");
					delRow.setRequiredTime("");
					delRow.setBlockedDelLine("");
					delRow.setScheduleLineCat("");
					delRow.setTransPlanningDate("");
					delRow.setMaterialAvailDate("");
					delRow.setLoadDate("");
					delRow.setGoodsIssueDate("");
					delRow.setTransportPlanningTime("");
					delRow.setMaterialStagingTime("");
					delRow.setLoadTime("");
					delRow.setGoodsIssueTime("");
					delRow.setRefObjectType("");
					delRow.setReserved1("");
					delRow.setReserved2("");
					if((("TRANSFERED").equals(status)) && (sDocNumber!=null) && (sDocNumber.trim().length()!=0) && (!"null".equals(sDocNumber)))
					{
						String backorderno="";
						String actLine ="";
						for(int ord = 0;ord<orders.getRowCount();ord++)
						{
							String sDocLine = orders.getFieldValueString(ord,"LineNo");
							String sMatCode =orders.getFieldValueString(ord,"MatCode");
							if(prodCode_1[i].equals(sMatCode))
							{
								backorderno=orders.getFieldValueString(ord,"SalesOrder");
								actLine=orders.getFieldValueString(ord,"BackLineNo");
								break;
							}
						}
						delRow.setBackEndNumber(backorderno);
						delRow.setBackEndItem(actLine);
					}
					else
					{
						delRow.setBackEndNumber("");
						delRow.setBackEndItem("");
					}	
					delTable.insertRow((delcount-1),delRow);
				}
			}
		}
	       	ezHeader.setNetValue(tValue.toString());

//*************************Work Flow Calls Start***********************************

		ezc.ezworkflow.params.EziWFParams 		eziWfparams = new ezc.ezworkflow.params.EziWFParams();
		ezc.ezworkflow.params.EziWFDocHistoryParams 	eziWfDocHis = new ezc.ezworkflow.params.EziWFDocHistoryParams();
		Hashtable wfActions = new Hashtable();

		wfActions.put("NEW","100065");
		wfActions.put("SUBMITTED","100066");
		wfActions.put("APPROVED","100067");
		wfActions.put("REJECTED","100068");
		wfActions.put("TRANSFERED","100070");
		wfActions.put("RETURNEDBYCM","100074");
		wfActions.put("RETURNEDBYLF","100075");
		wfActions.put("RETNEW","100076");
		wfActions.put("RETTRANSFERED","100077");
		wfActions.put("RETCMTRANSFER","100078");

		String wfParticipant = (String)session.getValue("Participant");		
		eziWfparams.setParticipant(wfParticipant);
		eziWfparams.setRole((String)session.getValue("WFRole"));
		eziWfDocHis.setParticipant(wfParticipant);
		eziWfDocHis.setSysKey(salesAreaCode);
		eziWfDocHis.setTemplateCode((String)session.getValue("Template"));
		eziWfDocHis.setAuthKey("SO_CREATE");
		eziWfDocHis.setCreatedBy(user);
		eziWfDocHis.setModifiedBy(user);
		eziWfDocHis.setSoldTo((String) session.getValue("AgentCode"));
		eziWfDocHis.setAction((String)wfActions.get(status));
		if("TRANSFERED".equalsIgnoreCase(status))
			eziWfDocHis.setComments(sDocNumber);
		ezcParams.setObject(eziWfparams);
		ezcParams.setObject(eziWfDocHis);

//*************************Work Flow Calls End***********************************

		ezcParams.setObject(iSOCrParams);
		ezcParams.setObject(delTable);
		try
		{
			EzoSalesOrderCreate   soCreate  = (EzoSalesOrderCreate) EzSalesOrderManager.ezCreateWebSalesOrder(ezcParams);
			ReturnObjFromRetrieve headerIn  = soCreate.getOrderHeaderIn();
			ReturnObjFromRetrieve retShipTo = soCreate.getShipToParty();
			ReturnObjFromRetrieve retSoldTo = soCreate.getSoldToParty();
			weborno = headerIn.getFieldValueString(0,"WEB_ORNO");

			if(!(("NEW").equalsIgnoreCase(status)))
			{
				ezHeader.setDocNumber(weborno);
			}
			if(("SUBMITTED").equals(status))
			{
				subject= "New Sales Order ("+ weborno+") has been created.";				
				msgExt = "New Sales Order ("+ weborno+") has been created.<BR> PO NO : "+ ezHeader.getPoNr()+".<BR>Customer  : " + ezSoldTo.getName()  + "(" + ezSoldTo.getSoldTo() + ")<BR>";

				if(msgExt!=null)
				{
					msgInt = msgExt.replaceAll("<BR>","\n");					
				}
	      	 		/*String mailMessage="New Sales Order ( "  + weborno + ") has been created.";
				String mailMessageDetails=" PO NO : " + ezHeader.getPoNr()  + "\n";
				mailMessageDetails= mailMessageDetails + "Customer  : " + ezSoldTo.getName()  + "(" + ezSoldTo.getSoldTo() + ")\n";

				ezc.ezmail.EzcMailParams mailParams=new ezc.ezmail.EzcMailParams();
		   	   	mailParams.setGroupId("Ezc");
				mailParams.setMsgText(mailMessage + "\nDetails are as follows\n" + mailMessageDetails);
				java.util.ResourceBundle toMail = java.util.ResourceBundle.getBundle("EzSalesMail");
				mailParams.setTo(toMail.getString("TO"));
				mailParams.setCC(toMail.getString("CC"));
				mailParams.setBCC(toMail.getString("BCC"));
   		   		mailParams.setSubject("New Web Sales Order(" +  weborno + ") has been submitted by " + Session.getUserId());
				ezc.ezmail.EzMail soMails=new ezc.ezmail.EzMail();
				soMails.ezSend(mailParams,Session);*/
			}
		}catch(Exception e)
		{
			System.out.println("Exception In Sending Mail=======>"+e.getMessage());
		}

//***********************this part is to remove variables from session**********************

		if(session.getAttribute("getprices")!=null)
			session.removeAttribute("getprices");
		if(session.getAttribute("getValues")!=null)
			session.removeAttribute("getValues");
		if(session.getAttribute("itemNo")!=null)
			session.removeAttribute("itemNo");
		if(session.getValue("groups")!=null)
			session.removeValue("groups");
		if(session.getValue("retsoldto")!=null)
			session.removeValue("retsoldto");
		if(session.getAttribute("SELECTEDMET")!=null)
			session.removeAttribute("SELECTEDMET");
		if(session.getValue("ITEMSOUT")!=null)
			session.removeValue("ITEMSOUT");

		FormatDate formatDate = new FormatDate();
		EzcShoppingCartParams ezcShoppingCartParams = new EzcShoppingCartParams();
		EziReqParams eziReqParams  = new EziReqParams();
		EziShoppingCartParams eziShoppingCartParams = new EziShoppingCartParams();
		EzShoppingCartManager SCManager = new EzShoppingCartManager( Session );
		eziReqParams.setProducts(prodCode_1);
	   	eziReqParams.setReqDate(desiredDate_1);
	   	eziReqParams.setReqQty(prodDQty_1);
	     	eziShoppingCartParams.setLanguage("EN");
	     	eziShoppingCartParams.setEziReqParams(eziReqParams );
	     	eziShoppingCartParams.setObject(eziReqParams);
	        ezcShoppingCartParams.setObject(eziShoppingCartParams);
	        Session.prepareParams(ezcShoppingCartParams);
		try
		{
	             Object retObjDelete = SCManager.deleteCartElement(ezcShoppingCartParams);
		}catch(Exception e){}
	}

	if("NEW".equalsIgnoreCase(status))
	{
		if(SAPnumber)
			msg =webNO_L+":<font color=red>"+weborno+"</font> has been Saved.<br>To Submit it to KISS please go to Saved Orders in the Orders Menu";
		else
			msg ="Web Order has not been Saved";
	}else if("SUBMITTED".equalsIgnoreCase(status))
	{
		 msg ="Web Order No: <font color=red>"+weborno+"</font> has been submitted for further processing.<br>"+"You can track the status of the order by using the <br>" + "above reference number in the  Orders menu"; 
	}
	else
	{
		if(sDocNumber == null || sDocNumber.trim().length()==0)
       		{
       			if(SAPnumber)
       				msg = "Web Order: <font color=red>"+weborno+"</font> has not been posted into SAP <br><font color=red> Error:"+ ErrorMessage +"</font>";
			else
				msg = "Order has not been posted into SAP <br><font color=red> Error:"+ ErrorMessage +"</font>";
       		}
       		else
       		{
       			if(sDocNumber.trim().length()>10)
       			{       				
       				try
       				{
       					StringTokenizer sDocToken=new StringTokenizer(sDocNumber,",");
					String numbers="";
					while(sDocToken.hasMoreElements())
					{
						String a= (String)sDocToken.nextElement();
						numbers =String.valueOf(Integer.parseInt(a))+",";
					}
					numbers=numbers.substring(0,(numbers.length()-1));
					sDocNumber=numbers;
				}catch(Exception e){}
					
			}else
			{
				try
				{
					sDocNumber=String.valueOf(Integer.parseInt(sDocNumber));
				}catch(Exception e){}
			}
	
			if(SAPnumber)
			{
				 msg = "Web Order: <font color=red>"+weborno+"</font> has been Submitted to KISS with Sales Order no(s): <font color=red>"+sDocNumber+"</font>";
				 if("CU".equals(UserRole.toUpperCase()))
				 {
%>				 	<%@ include file="iOrderMailSend.jsp"%>
<%				 }
			}
			else
			{
				msg = "Web Order has not been saved but Posted into SAP with Sales Order no(s): <font color=red>"+sDocNumber+"</font>";
			}       			
       		}
        }
      	session.putValue("EzMsg",msg);      	
%>
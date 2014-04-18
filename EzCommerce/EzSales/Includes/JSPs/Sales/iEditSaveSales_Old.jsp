<%@ page import = "ezc.ezsap.*,ezc.ezbasicutil.*" %>
<%@ page import = "ezc.ezutil.FormatDate" %>
<%@ page import = "ezc.ezcommon.EzGlobalConfig" %>
<%@ include file="../../../Includes/Lib/ezSalesBean.jsp" %>
<%//@ include file="../../../Includes/Lib/ezWorkFlow.jsp" %>
<%@ include file="iGetMaterials.jsp" %>
<%
	String SAPnumber = "Yes";
	String sDocNumber = null;

	String reqDateStr = request.getParameter("ReqDate");

	String[] prodDesc_1 = editSalVal.getProductDesc();
	String[] product_1 = editSalVal.getProduct();
	String[] productGroup_1 = new String[product_1.length];
	String[] productGroupType_1= new String[product_1.length];

	Hashtable productGroup= new Hashtable();

	java.util.ResourceBundle PrdGrpOrdTypes = java.util.ResourceBundle.getBundle("EzPrdGrpOrdTypes");
	java.util.ResourceBundle PrdGrp 	= java.util.ResourceBundle.getBundle("EzPrdGrp");
	java.util.Enumeration enum1=PrdGrp.getKeys();
	Hashtable prdTypesHash  = new Hashtable();
	Vector 	  prdTypesVector= new Vector();
	while(enum1.hasMoreElements())
	{
		String prdElement= (String)enum1.nextElement();
		String prdCode	 = PrdGrp.getString(prdElement);
		java.util.StringTokenizer   prdCode_1=new java.util.StringTokenizer(prdCode,",");
		Vector prdVector=new Vector();
		while(prdCode_1.hasMoreTokens())
		{
			prdVector.addElement(prdCode_1.nextElement());
		}
		prdTypesHash.put(prdElement,prdVector);
		prdTypesVector.addElement(prdElement);
	}
	int totMetCount =retpro.getRowCount();
	for(int p=0;p<product_1.length;p++)
	{
		for(int m=0;m<totMetCount;m++)
		{
		    if((product_1[p]).equals(retpro.getFieldValueString(m,"MATNO")))
		    {
		    	productGroup_1[p]=retpro.getFieldValueString(m,"GROUP_ID");
		    	boolean prdFlag=false;
		    	for(int q=0;q<prdTypesHash.size();q++)
			{

				for(int r=0;r<prdTypesVector.size();r++)
				{
					Vector  prdCodeVec = (Vector)prdTypesHash.get((String)(prdTypesVector.elementAt(r)));
					prdFlag=prdCodeVec.contains(productGroup_1[p]);
					if(prdFlag)
					{
						productGroup.put(product_1[p],prdTypesVector.elementAt(r));						
						break;
					}
				}
				if(prdFlag)
					break;
			}
			if(prdFlag)
				break;
		    }
		}
	}

	String[] pack_1 = editSalVal.getPack();
	String[] fOC_1 = editSalVal.getFocVal();
	String[] desiredQty_1 = editSalVal.getDesiredQty();
	String[] commitedQty_1 = editSalVal.getCommitedQty();
	String[] desiredDate_1 = editSalVal.getDesiredDate();
	String[] commitedDate_1 = editSalVal.getCommitedDate();
	String[] desiredPrice_1 = editSalVal.getDesiredPrice();
	String[] commitedPrice_1 = editSalVal.getCommitedPrice();
	String[] lineNo_1 = editSalVal.getLineNo();
	String[] value_1 = editSalVal.getValue2();
	String[] refDocItem_1 = editSalVal.getRefDocItem();

	ezc.ezcommon.EzLog4j log4j = new ezc.ezcommon.EzLog4j();
	log4j.log("statusstatusstatusstatusstatus::"+status,"W");


       if(("TRANSFERED").equals(status))
       {
       	 	String PartnNum = editSalVal.getSoldTo();
       	 	
       	 	log4j.log("PartnNumPartnNumPartnNum::"+PartnNum,"W");
       	 	
%>       	<%@include file="iAddSaveSapSales.jsp"%>
<%     }
       if("SAVECHANGES".equals(status))
       {
%>	        <%@include file="iEditSaveSapSales.jsp"%>
<%     }
       if("DELETEORDER".equals(status))
       {
%>              <%@include file="iDeleteSaveSapSales.jsp"%>
<%     }

	log4j.log("SAPnumberSAPnumberSAPnumberSAPnumber::"+SAPnumber,"W");


       String user= Session.getUserId();
       String UserType = (String)session.getValue("UserType");
       String agent = (String)session.getValue("Agent");
       String salesAreaCode = (String)session.getValue("SalesAreaCode");
       String lastmoduser = editSalVal.getModifiedBy(); //request.getParameter("ModifiedBy");

       if( ("Yes").equals(SAPnumber))
       {
       		int dateReq=0,monthReq=0,yearReq=0;
       		java.util.GregorianCalendar reqDate = null;
       		java.util.GregorianCalendar desDate = null;
       		java.util.GregorianCalendar comDate = null;
	
       		EzcSalesOrderParams ezcParams = new EzcSalesOrderParams();
       		ezcParams.setLocalStore("Y");
       		Session.prepareParams(ezcParams);	
       		EziSalesOrderChangeParams soParams = new EziSalesOrderChangeParams();
	       	EzBapisdheadStructure ezHeader 	   = new EzBapisdheadStructure();
       		EzBapisoldtoStructure ezSoldToStructure = new EzBapisoldtoStructure();
       		EzBapishiptoStructure ezShipToStructure = new EzBapishiptoStructure();
       		EzBapipartnrTable partnerTable = new EzBapipartnrTable();
       		EzBapipartnrTableRow prtnrTblRow = new EzBapipartnrTableRow();
       		EzBapiiteminTable itemInTable = new EzBapiiteminTable();
	       	EzDeliverySchedulesTable  delTable = new  EzDeliverySchedulesTable();
       		EzDeliverySchedulesTableRow delRow = new EzDeliverySchedulesTableRow();

       	      	ezcParams.setObject(soParams);
       		ezcParams.setObject(delTable);
	
       		soParams.setOrderHeaderIn(ezHeader);
       		soParams.setShipToParty(ezShipToStructure);
       		soParams.setSoldToParty(ezSoldToStructure);
       		soParams.setOrderPartners(partnerTable);
       		soParams.setOrderItemsIn(itemInTable);
	
       		ezHeader.setDocNumber(soNo);
       		ezHeader.setAgentCode(editSalVal.getAgent());
	
       		ezSoldToStructure.setSoldTo(editSalVal.getSoldTo());
       		ezSoldToStructure.setName(editSalVal.getSoldToName());
       		ezSoldToStructure.setStreet(editSalVal.getSoldToAddress1());
       		ezSoldToStructure.setCity(editSalVal.getSoldToAddress2());
       		ezSoldToStructure.setRegion(editSalVal.getSoldToState());
       		ezSoldToStructure.setPostlCode(editSalVal.getSoldToZipcode());
       		ezSoldToStructure.setCountry(editSalVal.getSoldToCountry());
       		ezShipToStructure.setShipTo(editSalVal.getShipTo());
       		ezShipToStructure.setName(editSalVal.getShipToName());
       		ezShipToStructure.setStreet(editSalVal.getShipToAddress1());
       		ezShipToStructure.setCity(editSalVal.getShipToAddress2());
       		ezShipToStructure.setRegion(editSalVal.getShipToState());
       		ezShipToStructure.setPostlCode(editSalVal.getShipToZipcode());
       		ezShipToStructure.setCountyCde(editSalVal.getShipToCountry());
	
		ezHeader.setPoNr(editSalVal.getPoNo());
       		ezHeader.setDiscountCash(" ".equals(editSalVal.getDisCash()) || "".equals(editSalVal.getDisCash())?"0":editSalVal.getDisCash());
       		ezHeader.setDiscountPercentage(" ".equals(editSalVal.getDisPercentage())||"".equals(editSalVal.getDisPercentage())?"0":editSalVal.getDisPercentage());
       		ezHeader.setFreightCharges(editSalVal.getFreight());
       		ezHeader.setIncoterms1(editSalVal.getIncoTerms1());
       		ezHeader.setIncoterms2(editSalVal.getIncoTerms2());
       		ezHeader.setPmnttrms(paymentterms);
       		ezHeader.setText1(generalNotesAll);	//generalnotes
       		ezHeader.setText2(generalNotes1);	//cm notes
       		ezHeader.setText3(generalNotes2);	//bp notes
       		ezHeader.setText4(generalNotes3);	//lf notes	
       		ezHeader.setDocCurrency(editSalVal.getDocCurrency());
	       	//ezHeader.setNetValue(editSalVal.getEstNetValue());
	       	ezHeader.setSalesArea(salesAreaCode);
	       	ezHeader.setDelFlag("N");
                String statusDate = editSalVal.getStatusDate();	
	       	if(("1").equals(statusDate))
       		{	
       			ezHeader.setStatusDate(new Date());
       		}
       		else
       		{
       			if(statusDate != null)
       			{	
       				try
       				{
       			 		monthReq = Integer.parseInt(statusDate.substring(0,2));
       					dateReq  = Integer.parseInt(statusDate.substring(3,5));
       					yearReq  = Integer.parseInt(statusDate.substring(6,10));
		       			reqDate  = new java.util.GregorianCalendar(yearReq,monthReq-1,dateReq);
       					ezHeader.setStatusDate(reqDate.getTime());
       				}catch(Exception e){}
       			}
       		}

	       	if(!((sDocNumber==null) || (sDocNumber.trim().length()==0)))
       	       		ezHeader.setTransferDate(new Date());
       	 	else
       			ezHeader.setTransferDate(new Date());

	       	ezHeader.setModifiedBy(user);
	       	
	       	
	       	log4j.log("statusstatusstatusstatusstatus::"+status,"W");
	       	
	        if("SAVECHANGES".equals(status))
       	   		ezHeader.setStatus("TRANSFERED");
       	        else
       			ezHeader.setStatus(status);
		
		if("TRANSFERED".equals(status))
		{
			if(sDocNumber.trim().length() >10)
				ezHeader.setBackEndOrder("Multi Orders");
			else
				ezHeader.setBackEndOrder(sDocNumber);
		}
		else	
		{
			ezHeader.setBackEndOrder("");
		}
		ezHeader.setReserved1(editSalVal.getPoDate());
		try
		{
			String poDat = editSalVal.getPoDate();
			int mn = Integer.parseInt(poDat.substring(0,2));
			int dt = Integer.parseInt(poDat.substring(3,5));
			int yr = Integer.parseInt(poDat.substring(6,10));
			java.util.GregorianCalendar reqDatePO = new java.util.GregorianCalendar(yr,mn-1,dt);
			ezHeader.setPurchDate(reqDatePO.getTime());
		}
		catch(Exception e){
			log4j.log("poDatpoDatpoDatpoDat::"+e,"W");
		}

       		if("SUBMITTED".equals(status))
       		{
       			ezHeader.setOrderDate(new Date());
       		}
       		else
       		{
       			try{
       				monthReq  = Integer.parseInt(orderDate.substring(0,2));
       				dateReq = Integer.parseInt(orderDate.substring(3,5));
       				yearReq  = Integer.parseInt(orderDate.substring(6,10));
				reqDate = new java.util.GregorianCalendar(yearReq,monthReq-1,dateReq);
       				ezHeader.setOrderDate(reqDate.getTime());
       			}catch(Exception e){
       				log4j.log("monthReqmonthReqmonthReq::"+e,"W");
       			}
	       	}
       		if(("REJECTED".equalsIgnoreCase(status) ) ||("RETURNEDBYCM".equalsIgnoreCase(status))||("RETURNEDBYLF".equalsIgnoreCase(status)) || ("SUBMITTEDTOBP".equalsIgnoreCase(status)) || ("RETURNEDBYBP".equalsIgnoreCase(status)))
       			ezHeader.setReserved2(editSalVal.getReasonForRejection());
       		else
       			ezHeader.setReserved2("");
	       	String line,product,productDesc,name,desiredQty,commitedQty,desiredDate,commitedDate,desiredPrice,commitedPrice,value,plant,Currency;
       		String strFOC ="";
       		int IntFOC=0;
       		int newRows =1;
       		java.math.BigDecimal tValue = new java.math.BigDecimal("0");
       		int delcount=0;
       		java.math.BigDecimal hNetValue = new java.math.BigDecimal("0");
       		
       		log4j.log("RowsRowsRowsRows::"+Rows,"W");
       		
       		for(int i=0;i<Rows;i++)
       		{
       			EzBapiiteminTableRow itemRow = new EzBapiiteminTableRow();
	      		line 		= lineNo_1[i];
       			product 	= product_1[i];	
       			productDesc 	= prodDesc_1[i];
	       		name 		= pack_1[i];
	       		desiredQty 	= desiredQty_1[i];
	       		
	       		log4j.log("desiredQtydesiredQtydesiredQty::"+desiredQty,"W");
	       		
	       		
       			strFOC 		= fOC_1[i];
	       		desiredQty 	= ((desiredQty==null)||(("").equals(desiredQty)))?"0":desiredQty;
	       		commitedQty 	=  commitedQty_1[i];
       			commitedQty 	= ((commitedQty==null)||(("").equals(commitedQty)))?"0":commitedQty;
	       		desiredDate	= desiredDate_1[i];
       			commitedDate	= commitedDate_1[i];
	       		desiredPrice	= desiredPrice_1[i];
       			desiredPrice    = ((desiredPrice == null) || (("").equals(desiredPrice)))?"0":desiredPrice;
	       		commitedPrice   = commitedPrice_1[i];
       			commitedPrice   = ((commitedPrice == null) || (("").equals(commitedPrice)))?"0":commitedPrice;
	       		value 		= value_1[i];
	       		java.math.BigDecimal dDQty = new java.math.BigDecimal(desiredQty);
			java.math.BigDecimal dCQTY = new java.math.BigDecimal(commitedQty);
       			java.math.BigDecimal cPrice= new java.math.BigDecimal(commitedPrice);
       			java.math.BigDecimal iValue= dCQTY.multiply(cPrice);
	       		tValue=tValue.add(iValue);
	       		strFOC = ((strFOC==null)||(strFOC.trim().length()==0) )?"0":strFOC;
	       		IntFOC = Integer.parseInt(strFOC);
	
			monthReq = Integer.parseInt(desiredDate.substring(0,2));
       			dateReq  = Integer.parseInt(desiredDate.substring(3,5));
       			yearReq  = Integer.parseInt(desiredDate.substring(6,10));
			desDate  = new java.util.GregorianCalendar(yearReq,monthReq-1,dateReq);
	       		
	       		monthReq = Integer.parseInt(commitedDate.substring(0,2));
       			dateReq  = Integer.parseInt(commitedDate.substring(3,5));
       			yearReq  = Integer.parseInt(commitedDate.substring(6,10));
	       		comDate = new java.util.GregorianCalendar(yearReq,monthReq-1,dateReq);

	       		itemRow.setDocNumber(soNo);
	       		itemRow.setItmNumber(new java.math.BigInteger(line));
	       		itemRow.setMaterial(product);
	       		itemRow.setShortText(productDesc);
	       		itemRow.setSalesUnit(name);
	       		unitQty[i]=(unitQty[i] != null || "null".equals(unitQty[i]))?"0":unitQty[i];
	       		itemRow.setQtyInSalesUnit(new java.math.BigDecimal(unitQty[i]));
       			itemRow.setReqQty1(dDQty);
			itemRow.setConfirmedQty(dCQTY);
       			itemRow.setReqDate(desDate.getTime());
       			itemRow.setDlvDate(comDate.getTime());
       			itemRow.setReqPrice(new java.math.BigDecimal(desiredPrice));
       			itemRow.setConfirmedPrice(cPrice);
       		       	itemRow.setItemFOC(strFOC);
       			itemRow.setNetPrice(iValue);  

	       		if("TRANSFERED".equalsIgnoreCase(status))
			{
				String backorderno="";
				String actLine ="";
				for(int ord = 0;ord<orders.getRowCount();ord++)
				{
					String sDocLine = orders.getFieldValueString(ord,"LineNo");
					if(line.equals(sDocLine))
					{
						backorderno=orders.getFieldValueString(ord,"SalesOrder");
						actLine=orders.getFieldValueString(ord,"BackLineNo");
						break;
					}
				}
				itemRow.setBackEndOrder(backorderno);
				itemRow.setBackEndItem(actLine);
			}
			else
			{
				itemRow.setBackEndOrder(sDocNumber);
				itemRow.setBackEndItem(line);
			}
			
	       		itemInTable.insertRow(i,itemRow);
       		}
       		
       		log4j.log("itemInTableitemInTableitemInTable::","W");

       		ReturnObjFromRetrieve retSchChangesLocal=(ReturnObjFromRetrieve)session.getValue("EzDeliveryLines");
       		
       		
       		log4j.log("retSchChangesLocalretSchChangesLocal::"+retSchChangesLocal.toEzcString(),"W");
       		
       		if(retSchChangesLocal!=null)
       		{
       			for(int k=0;k<retSchChangesLocal.getRowCount();k++)
       			{
       				String qtyCon=retSchChangesLocal.getFieldValueString(k,"EZDS_CON_QTY");
       				qtyCon=(qtyCon==null || "".equals(qtyCon))?"0":qtyCon;
       				String qtyreq = retSchChangesLocal.getFieldValueString(k,"EZDS_REQ_QTY");
       				qtyreq=(qtyreq==null || "".equals(qtyreq))?"0":qtyreq;
	       			delRow = new EzDeliverySchedulesTableRow();
	       			line   = retSchChangesLocal.getFieldValueString(k,"EZDS_ITM_NUMBER");
       				if("TRANSFERED".equalsIgnoreCase(status) && (sDocNumber !=null ) && (sDocNumber.trim().length() !=0 ) && (!"null".equals(sDocNumber)))
				{
	       				String backorderno="";
					String actLine ="";
					for(int ord = 0;ord<orders.getRowCount();ord++)
					{
						String sDocLine = orders.getFieldValueString(ord,"LineNo");
						if(line.equals(sDocLine))
						{
							backorderno=orders.getFieldValueString(ord,"SalesOrder");
							actLine=orders.getFieldValueString(ord,"BackLineNo");
							break;
						}
					}	
					delRow.setBackEndNumber(backorderno);
					delRow.setBackEndItem(actLine);
				}else{
					delRow.setBackEndNumber(sDocNumber);
					delRow.setBackEndItem(retSchChangesLocal.getFieldValueString(k,"EZDS_ITM_NUMBER"));
				}
				delRow.setSalesDocNumber(soNo);
				delRow.setItemNumber(retSchChangesLocal.getFieldValueString(k,"EZDS_ITM_NUMBER"));
       				delRow.setScheduleLine(retSchChangesLocal.getFieldValueString(k,"EZDS_SCHED_LINE"));
       				delRow.setRequiredQty(qtyreq);

       				//delRow.setRequiredDate(retSchChangesLocal.getFieldValueString(k,"EZDS_REQ_DATE"));
       				delRow.setRequiredDate(reqDateStr);
       				
       				
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
       				delRow.setStatus("N");
       				delRow.setReserved1(qtyreq);
       				delRow.setReserved2(retSchChangesLocal.getFieldValueString(k,"EZDS_REQ_DATE"));
       				delRow.setConfirmedQty("0");
       				delRow.setConfirmedDate("");
				delTable.appendRow(delRow);
       			}	
       		}
       		
       		log4j.log("delTabledelTabledelTable::","W");
       		
	       	ezHeader.setNetValue(tValue.toString());

		ezc.ezworkflow.params.EziWFParams eziWfparams = new ezc.ezworkflow.params.EziWFParams();
		ezc.ezworkflow.params.EziWFDocHistoryParams eziWfDocHis =new ezc.ezworkflow.params.EziWFDocHistoryParams();
		Hashtable wfActions = new Hashtable();

		wfActions.put("NEW","100065");
		wfActions.put("SUBMITTED","100066");
		wfActions.put("APPROVED","100067");
		wfActions.put("REJECTED","100068");
		wfActions.put("TRANSFERED","100070");
		wfActions.put("RETURNEDBYCM","100074");
		wfActions.put("RETURNEDBYLF","100075");
		wfActions.put("APPROVEDBYBP","100076");
		wfActions.put("RETURNEDBYBP","100077");
	
		wfActions.put("RETNEW","100076");
		wfActions.put("RETTRANSFERED","100077");
		wfActions.put("RETCMTRANSFER","100078");

		String wfeditParticipant = (String)session.getValue("Participant");
		eziWfDocHis.setParticipant(wfeditParticipant);
		eziWfparams.setParticipant(wfeditParticipant);
		eziWfparams.setRole((String)session.getValue("WFRole"));
		eziWfDocHis.setSysKey(salesAreaCode);
		eziWfDocHis.setTemplateCode((String)session.getValue("Templet"));
		eziWfDocHis.setAuthKey("SO_CREATE");
		//eziWfDocHis.setCreatedBy(user);
		eziWfDocHis.setModifiedBy(user);
		eziWfDocHis.setSoldTo((String)session.getValue("AgentCode"));
		eziWfDocHis.setAction((String)wfActions.get(status));
		eziWfDocHis.setDocId(soNo);
		ezcParams.setObject(eziWfparams);
		ezcParams.setObject(eziWfDocHis);
	       	try
	       	{
       			ezcParams.setLocalStore("Y");
       		 	EzSalesOrderManager.ezChangeWebSalesOrder(ezcParams);
			if(("SUBMITTED").equals(status))
			{
			 	String mailMessage="New Sales Order ( "  + soNo + ") has been created.";
				String mailMessageDetails=" PO NO : " + ezHeader.getPoNr()  + "\n";
				mailMessageDetails= mailMessageDetails + "Customer  : " + ezSoldToStructure.getName()  + "(" + ezSoldToStructure.getSoldTo() + ")\n";
				
				ezc.ezmail.EzcMailParams mailParams=new ezc.ezmail.EzcMailParams();
		   	   	mailParams.setGroupId("Ezc");
				mailParams.setMsgText(mailMessage + "\nDetails are as follows\n" + mailMessageDetails);				
				java.util.ResourceBundle toMail = java.util.ResourceBundle.getBundle("EzSalesMail");
				mailParams.setTo(toMail.getString("TO"));					
				mailParams.setCC(toMail.getString("CC"));
				mailParams.setBCC(toMail.getString("BCC"));
	   		   	mailParams.setSubject("New Web Sales Order:" +  soNo + "has been submitted by " +Session.getUserId());
				ezc.ezmail.EzMail soMails=new ezc.ezmail.EzMail();
				soMails.ezSend(mailParams,Session);
			}
       		}catch(Exception e)
       		{
       			System.out.println("Exception in sending Mail======>"+e);
       		}
       }
       
       
       
       if(session.getAttribute("getprices")!=null)
       {
       		session.removeAttribute("getprices");
       		session.removeAttribute("getValues");
       	}
       	String msg = "";

       	if("SAVED".equalsIgnoreCase(status))
       		status="NEW";
       	if("NEW".equalsIgnoreCase(status))
        {
               	status="SAVED";
       		msg = webOrdNO_L +": <font color=red>"+soNo+"</font> "+savedChooseToSubEdit_L;
       	}
       	else if("SUBMITTED".equalsIgnoreCase(status))
       	{
       		if(("CM").equals(UserRole) && "SUBMITTED".equals(status))
       		{
        	 	msg = webOrdNO_L +": <font color=red>"+soNo+"</font> "+ savedSuccess_L;
        	}
       		else
       		{
       			msg =webOrdNO_L +": <font color=red>"+soNo+"</font> "+subRepMailSearch_L;
       		}
       	}
       	else if("APPROVED".equalsIgnoreCase(status))
       	{
        	msg = webOrdNO_L+": <font color=red>"+soNo+"</font> "+ hasApproveSAP_L;
       	}
       	else if("REJECTED".equalsIgnoreCase(status))
       	{
       		if(!("CU").equals(UserRole))
       		{
        		msg = webOrdNO_L+": <font color=red>"+soNo+"</font> "+rejectCustMail_L;
       		}
       		else
       		{
       			 msg =webOrdNO_L+": <font color=red>"+soNo+"</font> "+hasReject_L;
       		}
       	}
       	else if("CANCELLED".equalsIgnoreCase(status))
       	{
       		 msg =webOrdNO_L+": <font color=red>"+soNo+"</font>"+ hasCancelled_L;
       	}
       	else if("RETURNEDBYCM".equalsIgnoreCase(status))
       	{
       		 msg =webOrdNO_L+": <font color=red>"+soNo+"</font> "+ hasReturned_L;
       	}
       	else if("RETURNEDBYLF".equalsIgnoreCase(status))
       	{
       		 msg = webOrdNO_L+": <font color=red>"+soNo+"</font> "+ hasReturned_L ;
       	}
       	else if("SUBMITTEDTOBP".equalsIgnoreCase(status))
       	{
       		 msg =webOrdNO_L+": <font color=red>"+soNo+"</font> "+ hasSubmitted_L;
       	}
       	else if("RETURNEDBYBP".equalsIgnoreCase(status))
       	{
       		 msg =webOrdNO_L+": <font color=red> "+soNo+"</font> "+ hasReturned_L;
       	}
       	else if("TRANSFERED".equalsIgnoreCase(status))
       	{
       		if(sDocNumber ==null  || sDocNumber.trim().length()==0)
       		{
       			if(("LF").equals(UserRole))
       			{
       				msg = order_L +" <font color=red>"+soNo+"</font> "+notPostSAP_L+"<br><font color=red>"+ error_L+ ErrorMessage +"</font>";
       			}
       			else
       			{
       				msg = order_L +" <font color=red>"+soNo+"</font> "+noAcceptTryAgain_L+"<br><font color=red>"+error_L+ ErrorMessage +"</font>";
       			}
       			session.putValue("webOrNo",soNo);
       		}else
       		{
			try{
				sDocNumber=String.valueOf(Integer.parseInt(sDocNumber));
			}catch(Exception e)
			{
			}
       			if(("LF").equals(UserRole))
       			{
       		 		 msg = webOrdNO_L +": <font color=red>"+soNo+"</font> "+successSAPSoNo_L+"(s): <font color=red>"+sDocNumber+"</font><br>"+newDispatchAddDispatch_L;
       			}
       			else
       			{
       				 msg = webOrdNO_L +": <font color=red>"+soNo+"</font> "+ acceptedSoNo_L +" <font color=red>"+sDocNumber+"</font>";
       			}
       		}
       	}
	if(session.getValue("EzDeliveryLines")!= null)
               	session.removeValue("EzDeliveryLines");
        if(session.getAttribute("getprices") != null)
              	session.removeAttribute("getprices");
        if(session.getAttribute("getValues") != null)
             	session.removeAttribute("getValues");
        try
        {
        	/*
		ezc.eztrans.EzTransactionParams params2=new ezc.eztrans.EzTransactionParams();
		params2.setSite("100");//connection group number.
		params2.setObject("SALESORDER");//the table name.
		params2.setKey(soNo.trim());//the row which u want to lock
		params2.setUserId(Session.getUserId());//login user id
		params2.setId(session.getId());//http session id
		//params.setUpto("time ");//till the time you want to keep the lock
		params2.setOpType("RELEASE");//to release the lock on the particular row.
		ezc.eztrans.EzTransaction trans2=new ezc.eztrans.EzTransaction();
		trans2.ezTrans(params2);
		*/
	}catch(Exception e){
	}
        sDocNumber = null;
        session.putValue("EzMsg",msg);
%>
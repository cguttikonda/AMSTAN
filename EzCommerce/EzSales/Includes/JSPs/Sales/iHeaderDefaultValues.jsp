<jsp:useBean id="EzWorkFlowManager" class="ezc.ezworkflow.client.EzWorkFlowManager" scope="session" />
<%
	String sessionAgentCode		= (String)session.getValue("AgentCode");
	String UserType			= (String)session.getValue("UserType");
	String agent			= (String)session.getValue("Agent");
	String catalog_area 		= (String)session.getValue("SalesAreaCode");
	String userGroup		= (String)session.getValue("UserGroup");
	String salesOffice		= (String)session.getValue("SalesOffice");
	String template			= (String)session.getValue("Templet");
	String UserRole 		= (String)session.getValue("UserRole");
	String participant		= (String)session.getValue("UserGroup");
	String syskey			= (String)session.getValue("SalesAreaCode");
	
	String BackOrder 		= request.getParameter("BackOrder");	
	
	//out.println("sessionAgentCode::"+sessionAgentCode+"-->"+agent);
	
	ReturnObjFromRetrieve retCustList = new ReturnObjFromRetrieve();
		
	ArrayList desiredSteps = new ArrayList();

	if("CM".equals(UserRole))
		desiredSteps.add("1");
	else if("LF".equals(UserRole))
		desiredSteps.add("2");
	else if("BP".equals(UserRole))
		desiredSteps.add("3");		
		
	ezc.client.EzcUtilManager  UtilManager = new ezc.client.EzcUtilManager(Session);
	boolean USER_GROUP_EXISTS=(userGroup!=null  && !"null".equals(userGroup) && !"".equals(userGroup));

	if("CM".equals(UserRole))
	{
		if(USER_GROUP_EXISTS)
		{
			ezc.ezparam.EzcParams mainParamsu = new ezc.ezparam.EzcParams(false);
			ezc.ezworkflow.params.EziWFParams paramsu= new ezc.ezworkflow.params.EziWFParams();
			paramsu.setTemplate(template);
			paramsu.setSyskey(catalog_area);
			paramsu.setPartnerFunction("AG");
			paramsu.setParticipant(participant);
			paramsu.setDesiredSteps(desiredSteps);
			mainParamsu.setObject(paramsu);
			Session.prepareParams(mainParamsu);
			
			log4j.log("userGroupuserGroupuserGroupuserGroupuserGroupuserGroup1"+userGroup,"W");
			retCustList =(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWorkFlowUsers(mainParamsu);
			log4j.log("userGroupuserGroupuserGroupuserGroupuserGroupuserGroup1"+userGroup,"W");

		}
		else
		{
			log4j.log("userGroupuserGroupuserGroupuserGroupuserGroupuserGroup2"+userGroup,"W");
			retCustList = (ReturnObjFromRetrieve)UtilManager.getUserCustomers(catalog_area);
			log4j.log("userGroupuserGroupuserGroupuserGroupuserGroupuserGroup2"+userGroup,"W");

		}
	}
	else if("LF".equals(UserRole)|| "BP".equals(UserRole))
	{
		ezc.ezparam.EzcParams mainParams1 = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziWFParams params1= new ezc.ezworkflow.params.EziWFParams();
		params1.setTemplate(template);
		params1.setSyskey(catalog_area); 
		params1.setPartnerFunction("AG");
		params1.setParticipant(participant);
		params1.setDesiredSteps(desiredSteps);
		mainParams1.setObject(params1);
		Session.prepareParams(mainParams1);
		retCustList =(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWorkFlowUsers(mainParams1);
	}else
	{
		retCustList = (ReturnObjFromRetrieve)UtilManager.getUserCustomers(catalog_area);
		
	}
	
	Date today = new Date();
	today.setMonth(today.getMonth()+1);
	String fkey 	= (String)session.getValue("formatKey");
	String nextMonth= FormatDate.getStringFromDate(today,fkey,FormatDate.MMDDYYYY);
	String Currency =  request.getParameter("Currency");
	String PONO 	= request.getParameter("poNo");

	if (PONO==null)
		PONO="";
	
	String carrierName = "";
	
	carrierName = request.getParameter("carrierName"); 
	if(session.getValue("CARRIERNAME")!=null && !"null".equals(session.getValue("CARRIERNAME")))
		carrierName = (String)session.getValue("CARRIERNAME");	
	else	
		carrierName = ("null".equals(carrierName)||carrierName==null)?"":carrierName;	

	String PODate 		= request.getParameter("poDate");
	String REQDate 		= request.getParameter("requiredDate");
	String OrderDate 	= request.getParameter("orderDate");
	String RefDocType 	= request.getParameter("RefDocType");
	String SCDoc 		= request.getParameter("SCDoc");
	String forkey 		= (String)session.getValue("formatKey");
	if((PODate==null)||(("").equals(PODate)))
	   PODate = FormatDate.getStringFromDate(new Date(),forkey,FormatDate.MMDDYYYY);
	if((OrderDate==null)||(("").equals(OrderDate)))
	   OrderDate = FormatDate.getStringFromDate(new Date(),forkey,FormatDate.MMDDYYYY);
        RefDocType=( RefDocType==null)?"P": RefDocType;

	if(session.getAttribute("pono_porder")!=null && !"null".equals(session.getAttribute("pono_porder")))
		PONO = (String)session.getAttribute("pono_porder");
	if(session.getAttribute("reqdate_porder")!=null && !"null".equals(session.getAttribute("reqdate_porder")))
		REQDate = (String)session.getAttribute("reqdate_porder");
	if(session.getAttribute("carname_porder")!=null && !"null".equals(session.getAttribute("carname_porder")))
		carrierName = (String)session.getAttribute("carname_porder");



	boolean CU = false ;if(("CU").equalsIgnoreCase(UserRole)) CU = true;
	boolean AG = false ;if(("AG").equalsIgnoreCase(UserRole)) AG = true;
	boolean CM = false ;if(("CM").equalsIgnoreCase(UserRole)) CM = true;
	boolean LF = false ;if(("LF").equalsIgnoreCase(UserRole)) LF = true;

	String defShipTo = UtilManager.getUserDefErpShipTo();
	String defSysKey = UtilManager.getCurrSysKey();
	String defSoldTo = UtilManager.getUserDefErpSoldTo();
	
	String Agent	 = request.getParameter("Agent");
	String SoldTo	 = request.getParameter("soldTo");
 	String ShipTo	 = request.getParameter("shipTo");

	if(defSoldTo.indexOf(',') > 0)
		defSoldTo="";

	Agent=(Agent==null)?defSoldTo:Agent;
	
	if(!"Y".equals(BackOrder))
		SoldTo=sessionAgentCode;
	SoldTo=(SoldTo==null)?defSoldTo:SoldTo;
        ShipTo=(ShipTo==null)?defShipTo:ShipTo;
		
	ReturnObjFromRetrieve retsoldto   = retCustList;
        ReturnObjFromRetrieve listShipTos = null;

	log4j.log("SoldToSoldToSoldToBaluBalu::"+SoldTo+"-->"+defSoldTo,"W");
	

	if(!SoldTo.equals(defSoldTo))
		UtilManager.setSysKeyAndSoldTo(UtilManager.getCurrSysKey(),SoldTo);

	listShipTos = (ReturnObjFromRetrieve)UtilManager.getListOfShipTos(SoldTo);
	
%>
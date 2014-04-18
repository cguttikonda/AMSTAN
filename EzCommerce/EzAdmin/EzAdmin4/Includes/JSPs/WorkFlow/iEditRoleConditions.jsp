<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session"/>
<%@ include file="iAttributesList.jsp"%>
<%@ include file="iWFAuthList.jsp" %>

<%
	String roleId=request.getParameter("Role");
	String ruleId=request.getParameter("chk1");
	
	System.out.println("ruleIdruleIdruleIdruleIdruleId:"+ruleId);

	String byPassCode	=	"";	
	String template		=	"";
	String srcLevel		= 	"";
	String dstLevel		= 	"";
	String direction	= 	"";	
	
	ezc.ezparam.ReturnObjFromRetrieve detailsRet=null;
	ezc.ezparam.EzcParams detailsMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziRoleConditionsParams detailsParams= new ezc.ezworkflow.params.EziRoleConditionsParams();
	detailsParams.setConditionId(ruleId);
	detailsMainParams.setObject(detailsParams);
	Session.prepareParams(detailsMainParams);
	try
	{
		detailsRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getConditionDetails(detailsMainParams);
	}
	catch(Exception e)
	{
		System.out.println("Exception in iEditRoleConditions.jsp"+e);
	}
	
	
	
	ezc.ezparam.ReturnObjFromRetrieve masterRet=null;
	ezc.ezparam.EzcParams detailsMainParams1 = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziConditionsParams detailsParams1= new ezc.ezworkflow.params.EziConditionsParams();
	detailsParams1.setRuleId(ruleId);
	detailsMainParams1.setObject(detailsParams1);
	Session.prepareParams(detailsMainParams1);
	try
	{
		masterRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getConditionMasterDetails(detailsMainParams1);	
	}
	catch(Exception e)
	{
		System.out.println("Exception in iEditRoleConditions.jsp"+e);
	}
	
	String cons	= detailsRet.getFieldValueString(0,"CONDITIONS");
	
	//String[] operators=new String[ctr];
	java.util.Vector operators=new java.util.Vector();
	
	for(int i=0;i<cons.length();i++)
	{
		if(cons.charAt(i)=='A')
			operators.addElement("AND");
		else if(cons.charAt(i)=='O')
			operators.addElement("OR");
	}

	// For getting Bus-domain,DocType,ConditonsList.These variables are used in ez page.
	String busStr ="",docStr="",listStr="";
	
	busStr = detailsRet.getFieldValueString(0,"BUS_DOMAIN").trim();
	docStr = detailsRet.getFieldValueString(0,"DOC_TYPE").trim();
	listStr= detailsRet.getFieldValueString(0,"DOC_NO").trim();
	
	if("B".equals(docStr))
	{
		ezc.ezparam.EzcParams bypassMainParams = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziByPassInfoParams byPassInfoParams=new ezc.ezworkflow.params.EziByPassInfoParams();
		byPassInfoParams.setConditionId(ruleId);
		bypassMainParams.setObject(byPassInfoParams);
		Session.prepareParams(bypassMainParams);
		ezc.ezparam.ReturnObjFromRetrieve bypassRet = (ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getByPassList(bypassMainParams);
		template	=	bypassRet.getFieldValueString("TEMPLATE")+"¥Y";	
		srcLevel	= 	bypassRet.getFieldValueString("SOURCE_LEVEL");
		dstLevel	=	bypassRet.getFieldValueString("DEST_LEVEL");
		direction	=	bypassRet.getFieldValueString("DIRECTION");
		byPassCode 	=	bypassRet.getFieldValueString("BYPASS_ID");
	}
	if("D".equals(docStr))
	{
		ezc.ezparam.EzcParams delMainParams = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziDelegateApproverParams delInfoParams=new ezc.ezworkflow.params.EziDelegateApproverParams();
		delInfoParams.setConditionId(ruleId);
		delMainParams.setObject(delInfoParams);
		Session.prepareParams(delMainParams);
		ezc.ezparam.ReturnObjFromRetrieve delAppRet = (ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.ezGetDelegateApproversList(delMainParams);
		direction	=	delAppRet.getFieldValueString("SOURCE_PARTICIPANT_TYPE");
		srcLevel	= 	delAppRet.getFieldValueString("SOURCE_PARTICIPANT");
		dstLevel	=	delAppRet.getFieldValueString("DEST_PARTICIPANT");
	}
	
%>

<%@ page import ="ezc.ezparam.*"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="EzWorkFlowManager" class="ezc.ezworkflow.client.EzWorkFlowManager" scope="session" />
<%@ page import="ezc.ezworkflow.params.*" %>
<%@ include file="../Misc/iblockcontrol.jsp" %>
<%
	ArrayList desiredSteps	=	new ArrayList();
	String userType 	= 	(String)session.getValue("UserType");
	String userRole 	= 	(String)session.getValue("USERROLE");
	String role	 	= 	(String)session.getValue("ROLE");
	String template		=	(String)session.getValue("TEMPLATE");
	String participant	=	(String)session.getValue("USERGROUP");
	int templateStep 	= 	0;
	String catalog_area 	= 	request.getParameter("CatalogArea");
	String partFun 		= 	"VN";
	if(vendCode != null && !"".equals(vendCode.trim()))
		partFun += "') AND (EC_ERP_CUST_NO LIKE ('"+vendCode+"') OR ECA_NAME LIKE ('"+vendCode+"') OR 0<>'0";

	ezc.ezparam.EzcParams mainParams1 = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziTemplateStepsParams params1= new ezc.ezworkflow.params.EziTemplateStepsParams();
	params1.setCode(template);
	mainParams1.setObject(params1);
	Session.prepareParams(mainParams1);
	ezc.ezparam.ReturnObjFromRetrieve listRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getTemplateStepsList(mainParams1);
	if(listRet!=null)
	{
		for(int i=0;i<listRet.getRowCount();i++)
		{
			if(role.equals((listRet.getFieldValueString(i,"ROLE")).trim()))
			{
				templateStep = 	Integer.parseInt(listRet.getFieldValueString(i,"STEP"));
				desiredSteps.add(templateStep-1+"");
			}
		}
	}	
	
	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziWFParams params= new ezc.ezworkflow.params.EziWFParams();
	params.setTemplate(template);
	params.setSyskey(catalog_area);
	params.setParticipant(participant);
	params.setDesiredSteps(desiredSteps);
	params.setPartnerFunction(partFun);
	mainParams.setObject(params);
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve retsoldto=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWorkFlowUsers(mainParams);
	int soldtoRows = 0;
	if(retsoldto!=null)	
		soldtoRows = retsoldto.getRowCount();
%>
<%@ include file="../Misc/ireleasecontrol.jsp" %>
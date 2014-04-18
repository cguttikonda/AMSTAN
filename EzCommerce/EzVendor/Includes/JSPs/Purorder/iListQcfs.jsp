<%@page import="ezc.ezbasicutil.*"%>
<%@page import="java.io.*"%>
<%@ page import="java.util.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="EzWorkFlowManager" class="ezc.ezworkflow.client.EzWorkFlowManager" scope="session" />
<%

	String type = request.getParameter("Type");
	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziWFDocHistoryParams params= new ezc.ezworkflow.params.EziWFDocHistoryParams();

	/*ezc.client.EzcPurchaseUtilManager PurManager = new ezc.client.EzcPurchaseUtilManager(Session);
	ReturnObjFromRetrieve retcatarea = (ReturnObjFromRetrieve)PurManager.getUserPurAreas();*/
	String sysKey ="";
	String users = "";
	String stats="";

	/*for(int i=0;i<retcatarea.getRowCount();i++)
	{
	     sysKey = sysKey+retcatarea.getFieldValue(i,"ESKD_SYS_KEY")+"','";
	}
	sysKey = sysKey.substring(0,sysKey.length()-3);*/

	sysKey = (String)session.getValue("SYSKEY");

	String template=(String)session.getValue("TEMPLATE");
	String participant=(String)session.getValue("USERGROUP");
	ArrayList desiredSteps=new ArrayList();
	String userRole = (String)session.getValue("USERROLE");

	if(userRole.equals("VP") || userRole.equals("PH"))
	{
		if(userRole.equals("VP"))
		{
			desiredSteps.add("2");
			if(type.equals("A"))
			{
				stats = "'QCFSUBMITTEDBYPP','QCFSUBMITTEDBYPH','QCFRETURNEDBYPH','QCFSUBMITTEDBYVP','QCFRETURNEDBYVP'";
			}
			else
			{
				stats = "'QCFSUBMITTEDBYPH'";
			}
		}
		else if(userRole.equals("PH"))
		{
			desiredSteps.add("1");
			if(type.equals("A"))
			{
				stats = "'QCFSUBMITTEDBYPP','QCFSUBMITTEDBYPH','QCFRETURNEDBYPH','QCFSUBMITTEDBYVP','QCFRETURNEDBYVP'";
			}
			else
			{
				stats = "'QCFSUBMITTEDBYPP','QCFRETURNEDBYVP'";
			}
		}

		ezc.ezparam.EzcParams mainUserParams = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziWFParams userParams= new ezc.ezworkflow.params.EziWFParams();
		userParams.setTemplate(template);
		userParams.setSyskey(sysKey);
		userParams.setParticipant(participant);
		userParams.setDesiredSteps(desiredSteps);
		mainUserParams.setObject(userParams);
		Session.prepareParams(mainUserParams);
		ezc.ezparam.ReturnObjFromRetrieve retsoldto=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWorkFlowUsers(mainUserParams);
		int retSoldToCount = retsoldto.getRowCount();
		if(retSoldToCount>0)
		{
			retsoldto.toEzcString();
			for(int i=0;i<retSoldToCount;i++)
			{
			 	users = users+retsoldto.getFieldValueString(i,"EU_ID")+"','";
			}
			users = users.substring(0,users.length()-3);
		}
	}
	else
	{
		users = Session.getUserId();
		if(type.equals("A"))
		{
			stats = "'QCFSUBMITTEDBYPP','QCFSUBMITTEDBYPH','QCFRETURNEDBYPH','QCFSUBMITTEDBYVP','QCFRETURNEDBYVP'";
		}
		else
		{
			stats = "'QCFRETURNEDBYPH'";
		}
	}

	params.setAuthKey("'PO_LIST'");
	params.setSysKey("'"+sysKey+"'");
	params.setTemplateCode(template);
	params.setCreatedBy("'"+users+"'");
	params.setStatus(stats);

	mainParams.setObject(params);
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve retobj=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWFDocList(mainParams);
	int retObjCount=retobj.getRowCount();	


%>


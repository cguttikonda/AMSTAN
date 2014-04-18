<%@ page import="ezc.ezshipment.params.*" %>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session">
</jsp:useBean>
<jsp:useBean id="BPManager" class="ezc.client.EzBussPartnerManager" scope="session">
</jsp:useBean>
<jsp:useBean id="EzWorkFlowManager" class="ezc.ezworkflow.client.EzWorkFlowManager" scope="session" />
<%@ page import="ezc.ezworkflow.params.*" %>
<%@ page import="java.util.*" %>
<%
	
		ReturnObjFromRetrieve retUser = null;
		String currSysKey = (String)session.getValue("SYSKEY");
		String template=(String)session.getValue("TEMPLATE");
		String participant=(String)session.getValue("USERGROUP");
		String userRole=(String)session.getValue("USERROLE");

		ArrayList desiredSteps=new ArrayList();

		Vector selectUsers= new Vector();
		Hashtable userHash = new Hashtable();

		String userType = (String)session.getValue("UserType");


		ezc.client.EzcPurchaseUtilManager PurManager = new ezc.client.EzcPurchaseUtilManager(Session);
		ReturnObjFromRetrieve retcatarea = (ReturnObjFromRetrieve)PurManager.getUserPurAreas();
		String sysKey ="";
		for(int i=0;i<retcatarea.getRowCount();i++)
		{
		     sysKey = sysKey+retcatarea.getFieldValue(i,"ESKD_SYS_KEY")+"','";
		}
		sysKey = sysKey.substring(0,sysKey.length()-3);

		if(userType.equals("3"))
		{
			desiredSteps.add("-1");
			desiredSteps.add("-2");
			desiredSteps.add("-3");
		}

			if(userRole.equals("PP"))
			{
				desiredSteps.add("1");
				desiredSteps.add("-1");
				desiredSteps.add("-2");


			}
			if(userRole.equals("PH"))
			{
				desiredSteps.add("1");
				desiredSteps.add("2");
				desiredSteps.add("-1");

			}
			if(userRole.equals("VP"))
			{
				desiredSteps.add("1");
				desiredSteps.add("2");
				desiredSteps.add("3");
			}



		ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziWFParams params= new ezc.ezworkflow.params.EziWFParams();
		params.setTemplate(template);
		params.setSyskey(sysKey);
		params.setParticipant(participant);

			params.setDesiredSteps(desiredSteps);
			mainParams.setObject(params);
			Session.prepareParams(mainParams);
			retUser=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWorkFlowUsers(mainParams);
			for(int j=0;j<retUser.getRowCount();j++)
			{
				selectUsers.addElement(retUser.getFieldValueString(j,"EU_ID"));
				userHash.put(retUser.getFieldValueString(j,"EU_ID"),retUser.getFieldValueString(j,"EU_FIRST_NAME"));
			}
%>

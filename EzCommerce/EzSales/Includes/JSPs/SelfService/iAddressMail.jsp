<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ page import ="ezc.ezparam.*"%>
<%@ page import="ezc.ezutil.csb.*" %>
<%@ page import="java.util.*" %>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezWorkFlow.jsp"%>

<%
		String template=(String)session.getValue("Templet");

		//out.println("******template****"+template);
		String group=(String)session.getValue("UserGroup");
		String userRole = (String)session.getValue("UserRole");
		String catalog_area=(String)session.getValue("SalesAreaCode");

		Hashtable allUsers=new Hashtable();


		String participant="";
		ArrayList desiredStep=new ArrayList();
		desiredStep.add("-1");
		desiredStep.add("-2");
		desiredStep.add("-3");
		desiredStep.add("1");
		desiredStep.add("2");
		desiredStep.add("3");


		ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziWFParams params= new ezc.ezworkflow.params.EziWFParams();
		params.setTemplate(template);
		params.setSyskey(catalog_area);
		params.setParticipant((String)session.getValue("Participant"));

		
			//params.setDesiredStep((String)desiredStep.get(i));
			params.setDesiredSteps(desiredStep);

			mainParams.setObject(params);

			Session.prepareParams(mainParams);

			ezc.ezparam.ReturnObjFromRetrieve retsoldto=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlow.getWorkFlowUsers(mainParams);

			if(retsoldto!=null)
			{
				for(int j=0;j<retsoldto.getRowCount();j++)
				{			
					allUsers.put(retsoldto.getFieldValueString(j,"EU_ID"),retsoldto.getFieldValueString(j,"EU_FIRST_NAME")+"^"+retsoldto.getFieldValueString(j,"EU_LAST_NAME"));
				}
			}
		


%>

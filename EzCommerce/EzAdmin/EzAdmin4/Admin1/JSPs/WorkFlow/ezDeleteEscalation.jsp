<%@ include file="../../../Includes/Lib/EzWorkFlowBean.jsp"%>
<%
	ezc.ezparam.EzcParams deleteMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziEscalationParams deleteParams= new ezc.ezworkflow.params.EziEscalationParams();
	String[] chkValue=request.getParameterValues("chk1");
	String val=chkValue[0];
	for(int i=1;i<chkValue.length;i++)
	{
		val +=","+chkValue[i];
	}
	 
	deleteParams.setCode(val);
	deleteMainParams.setObject(deleteParams);
	Session.prepareParams(deleteMainParams);
	EzWorkFlowManager.deleteEscalation(deleteMainParams);
 
	response.sendRedirect("ezEscalationList.jsp");
%>

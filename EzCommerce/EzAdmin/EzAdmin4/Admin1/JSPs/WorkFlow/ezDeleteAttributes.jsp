<%@ include file="../../../Includes/Lib/EzWorkFlowBean.jsp"%>
<%
	ezc.ezparam.EzcParams deleteMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziAttributesParams deleteParams= new ezc.ezworkflow.params.EziAttributesParams();
	String[] chkValue=request.getParameterValues("chk1");
 
	String val="";
	for(int i=0;i<chkValue.length;i++)
		val += chkValue[i]+",";
 
	val = val.substring(0,val.length()-1);
	deleteParams.setAttributeId(val);
	deleteMainParams.setObject(deleteParams);
	Session.prepareParams(deleteMainParams);
	EzWorkFlowManager.deleteAttributes(deleteMainParams);
 
	response.sendRedirect("ezAttributesList.jsp");
%>

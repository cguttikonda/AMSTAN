<%@ page import="java.util.*" %>
<%@ include file="../../Lib/EzWorkFlowBean.jsp"%>
<%@ include file="../../Lib/AddButtonDir.jsp"%>
<%
	ezc.ezparam.EzcParams deleteMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziWorkGroupsParams deleteParams= new ezc.ezworkflow.params.EziWorkGroupsParams();
	String chkValue=request.getParameter("chk1");

	StringTokenizer setVal=new StringTokenizer(chkValue,",");
	String groupid=setVal.nextToken();
	String lang=setVal.nextToken();

	deleteParams.setGroupId("'"+groupid+"'");
	deleteParams.setLang("'"+lang+"'");
	deleteMainParams.setObject(deleteParams);
	Session.prepareParams(deleteMainParams);
	ezc.ezparam.ReturnObjFromRetrieve retObj=(ReturnObjFromRetrieve)EzWorkFlowManager.deleteWorkGroups(deleteMainParams);
%>
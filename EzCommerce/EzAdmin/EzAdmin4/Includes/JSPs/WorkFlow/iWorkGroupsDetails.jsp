
<%@ include file="../../Lib/EzWorkFlowBean.jsp"%>
<%@ page import="java.util.*" %>
<%
	ezc.ezparam.EzcParams detailsMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziWorkGroupsParams detailsParams= new ezc.ezworkflow.params.EziWorkGroupsParams();
	String chkValue=request.getParameter("chk1");
	StringTokenizer st=new StringTokenizer(chkValue,",");
	detailsParams.setGroupId(st.nextToken());
	detailsParams.setLang(st.nextToken());
	detailsMainParams.setObject(detailsParams);
	Session.prepareParams(detailsMainParams);
	ezc.ezparam.ReturnObjFromRetrieve detailsRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWorkGroupDetails(detailsMainParams);
%>

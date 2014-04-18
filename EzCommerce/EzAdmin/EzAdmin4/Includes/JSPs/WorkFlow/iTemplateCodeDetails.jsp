<%@ include file="../../Lib/EzWorkFlowBean.jsp"%>
<%
	ezc.ezparam.EzcParams detailsMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziTemplateCodeParams detailsParams= new ezc.ezworkflow.params.EziTemplateCodeParams();
	String chkValue=request.getParameter("chk1");
	java.util.StringTokenizer st=new java.util.StringTokenizer(chkValue,",");
	
	String tCode=st.nextToken();
	String tDesc=st.nextToken();
	String language=st.nextToken();
	
	detailsParams.setCode(tCode);
	detailsParams.setLang(language);
	detailsMainParams.setObject(detailsParams);
	Session.prepareParams(detailsMainParams);
	ezc.ezparam.ReturnObjFromRetrieve detailsRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getTemplateDetails(detailsMainParams);
%>

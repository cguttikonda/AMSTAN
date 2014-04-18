
<%
	ezc.ezparam.EzcParams detailsMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziActionStatParams detailsParams= new ezc.ezworkflow.params.EziActionStatParams();
	String chkValue=request.getParameter("chk1");
	java.util.StringTokenizer st=new java.util.StringTokenizer(chkValue,",");
	detailsParams.setAction(st.nextToken());
	detailsParams.setAuthKey(st.nextToken());
	detailsMainParams.setObject(detailsParams);
	Session.prepareParams(detailsMainParams);
	ezc.ezparam.ReturnObjFromRetrieve detailsRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getActionStatDetails(detailsMainParams);
%>

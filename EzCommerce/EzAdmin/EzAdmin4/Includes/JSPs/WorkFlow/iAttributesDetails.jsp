<%@ include file="../../Lib/EzWorkFlowBean.jsp"%>
<%
	
	ezc.ezparam.EzcParams detailsMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziAttributesParams detailsParams= new ezc.ezworkflow.params.EziAttributesParams();
	String chkValue=request.getParameter("chk1");
	
	detailsParams.setAttributeId(chkValue);
	detailsMainParams.setObject(detailsParams);
	Session.prepareParams(detailsMainParams);
	ezc.ezparam.ReturnObjFromRetrieve detailsRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getAttributeDetails(detailsMainParams);
	
%>

<%@ include file="../../Lib/EzWorkFlowBean.jsp"%>
<%@ page import="java.util.Date,java.text.*" %>
<%
	ezc.ezparam.EzcParams detailsMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziDelegationInfoParams detailsParams= new ezc.ezworkflow.params.EziDelegationInfoParams();
	String chkValue=request.getParameter("chk1");
	detailsParams.setDelegationId(chkValue);
	detailsMainParams.setObject(detailsParams);
	Session.prepareParams(detailsMainParams);
	ezc.ezparam.ReturnObjFromRetrieve detailsRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getDelegationDetails(detailsMainParams);
SimpleDateFormat sdf=new SimpleDateFormat("MM/dd/yyyy");
	SimpleDateFormat sdf1=new SimpleDateFormat("MM/dd/yyyy");

	Date fd=(Date)detailsRet.getFieldValue("VALIDFROM");
	Date td=(Date)detailsRet.getFieldValue("VALIDTO");
	String fromdate=sdf.format(fd);
	String todate=sdf1.format(td);
%>

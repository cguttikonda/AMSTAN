<%@ include file="../../Lib/EzWorkFlowBean.jsp"%>
<%
	ezc.ezparam.EzcParams deleteMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziDelegationInfoParams deleteParams= new ezc.ezworkflow.params.EziDelegationInfoParams();
	String[] chkValue=request.getParameterValues("chk1");
 
	String val="'"+chkValue[0]+"'";
	for(int i=1;i<chkValue.length;i++)
	{
		val=val+",'"+chkValue[i]+"'";
	}
	deleteParams.setDelegationId(val);
	deleteMainParams.setObject(deleteParams);
	Session.prepareParams(deleteMainParams);
	ezc.ezparam.ReturnObjFromRetrieve retObj=(ReturnObjFromRetrieve)EzWorkFlowManager.deleteDelegations(deleteMainParams);
%>

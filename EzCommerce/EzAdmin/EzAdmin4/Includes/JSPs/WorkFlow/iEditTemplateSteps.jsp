<jsp:useBean id="EzWorkFlowManager" class="ezc.ezworkflow.client.EzWorkFlowManager" scope="session" />
<%@ page import="ezc.ezparam.ReturnObjFromRetrieve,ezc.ezparam.*,ezc.ezworkflow.params.*" %>
<%!
	//This generic function is to remove null from string
	public Object removeNull(Object val)
	{
		if(val==null || "null".equals(val))
			return "";
		else
			return val;
		}
%>

<%
	ezc.ezparam.EzcParams detailsMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziTemplateStepsParams detailsParams= new ezc.ezworkflow.params.EziTemplateStepsParams();
	String chkValue=request.getParameter("chk1");
	java.util.StringTokenizer st=new java.util.StringTokenizer(chkValue,",");

	String tCode=st.nextToken();
	String sCode=st.nextToken();
	String tDesc=request.getParameter("tempDesc");

	detailsParams.setCode(tCode);
	detailsParams.setStep(sCode);
	detailsMainParams.setObject(detailsParams);
	Session.prepareParams(detailsMainParams);
	ezc.ezparam.ReturnObjFromRetrieve detailsRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getTemplteStepDetails(detailsMainParams);
%>
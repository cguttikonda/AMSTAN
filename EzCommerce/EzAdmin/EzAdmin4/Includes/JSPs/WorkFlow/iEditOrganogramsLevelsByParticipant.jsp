<%@ include file="../../Lib/EzWorkFlowBean.jsp"%>

<%
	String chkValue = request.getParameter("chk1");
	java.util.StringTokenizer stk1 = new java.util.StringTokenizer(chkValue,"#");
	String organogramCode = stk1.nextToken();
	String ppt = stk1.nextToken();	
	String level = stk1.nextToken();
	String myFlag = stk1.nextToken();
	ezc.ezparam.EzcParams mainParams1 = new ezc.ezparam.EzcParams(false);
	ezc.ezparam.EzcParams mainParams2 = new ezc.ezparam.EzcParams(false);
	
	
	ezc.ezworkflow.params.EziOrganogramLevelsParams myParams1= new ezc.ezworkflow.params.EziOrganogramLevelsParams();
	myParams1.setCode(organogramCode);
	myParams1.setParticipant(ppt);
	mainParams1.setObject(myParams1);
	Session.prepareParams(mainParams1);
	ezc.ezparam.ReturnObjFromRetrieve retDetails=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getOrganogramLevelsDetails(mainParams1);

	ezc.ezworkflow.params.EziOrganogramLevelsParams myParams2= new ezc.ezworkflow.params.EziOrganogramLevelsParams();
	myParams2.setCode(organogramCode);
	mainParams2.setObject(myParams2);
	Session.prepareParams(mainParams2);
	
	ezc.ezparam.ReturnObjFromRetrieve retList=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getOrganogramLevelsDetails(mainParams2);
%>

<%
	String chkValue = request.getParameter("chk");
	java.util.StringTokenizer stk1 = new java.util.StringTokenizer(chkValue,"#");
	String organogramCode = stk1.nextToken();
	String level1 = stk1.nextToken();
	String ppt = stk1.nextToken();
	String lang = stk1.nextToken();
	String desc = stk1.nextToken();
	String parent = stk1.nextToken();

	ezc.ezparam.EzcParams mainParams2 = new ezc.ezparam.EzcParams(false);

	ezc.ezworkflow.params.EziOrganogramLevelsParams myParams1= new ezc.ezworkflow.params.EziOrganogramLevelsParams();
	myParams1.setCode(organogramCode);
	myParams1.setLevel(level1);
	myParams1.setParticipant(ppt);
	mainParams2.setObject(myParams1);
	Session.prepareParams(mainParams2);
	ezc.ezparam.ReturnObjFromRetrieve retDetails=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getOrganogramLevelsDetails(mainParams2);
%>

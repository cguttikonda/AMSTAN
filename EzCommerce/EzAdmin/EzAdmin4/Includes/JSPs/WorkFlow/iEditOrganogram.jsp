<%
	String temp=request.getParameter("chk1");
	java.util.StringTokenizer stk=new java.util.StringTokenizer(temp,",");
	String orgCode=stk.nextToken();
	String templateCode=stk.nextToken();
	String orgDesc=stk.nextToken();
	
	ezc.ezparam.EzcParams mainParams1 = new ezc.ezparam.EzcParams(false);
	
	ezc.ezworkflow.params.EziOrgonagramParams myParams= new ezc.ezworkflow.params.EziOrgonagramParams();
	myParams.setCode(orgCode);
	mainParams1.setObject(myParams);
	Session.prepareParams(mainParams1);
	ezc.ezparam.ReturnObjFromRetrieve retDetails=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getOrganogramDetails(mainParams1);
	
	String syskey = retDetails.getFieldValueString(0,"SYSKEY");
	String description = retDetails.getFieldValueString(0,"DESCRIPTION");
	String lang = retDetails.getFieldValueString(0,"LANG");;
	String template = retDetails.getFieldValueString(0,"TEMPLATE");
%>

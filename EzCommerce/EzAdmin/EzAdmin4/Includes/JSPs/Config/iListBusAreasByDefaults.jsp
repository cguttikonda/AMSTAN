<%@ include file="../../Lib/AdminUtilsBean.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%
	String areaFlag = request.getParameter("Area");
	ReturnObjFromRetrieve ret = null;
	EziAdminUtilsParams myParams = new EziAdminUtilsParams();
	myParams.setAreaType(areaFlag);
	EzcParams ezcParams = new EzcParams(false);
	ezcParams.setObject(myParams);
	Session.prepareParams(ezcParams);
	ret = (ReturnObjFromRetrieve)AUM.getSystemTypeDefaults(ezcParams);

	ReturnObjFromRetrieve partnersRet = null;
	String defKey = request.getParameter("defKey");
	String defValue = request.getParameter("defValue");
	
	if(defKey != null && defValue != null)
	{
		EziAdminUtilsParams adminUtilsParams = new EziAdminUtilsParams();
		adminUtilsParams.setDefaultKey(defKey);
		adminUtilsParams.setDefaultValue(defValue);
		EzcParams mainParams = new EzcParams(false);
		mainParams.setObject(adminUtilsParams);
		Session.prepareParams(mainParams);
		partnersRet = (ReturnObjFromRetrieve)AUM.getUserAreasByDefautls(mainParams);
	}
%>
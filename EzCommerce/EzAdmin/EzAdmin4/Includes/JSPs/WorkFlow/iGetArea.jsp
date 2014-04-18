<%@ include file="../../../Includes/Lib/CatalogArea.jsp"%>
<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session" />
<%
	String grpid=request.getParameter("groups");
	String efffrom=request.getParameter("effectivefrom");
	String effto=request.getParameter("effectiveto");
	ReturnObjFromRetrieve ret1 = null;
	String areaFlag = request.getParameter("areaFlag");
	String areaLabel = "Business Area";
	if(areaFlag!=null)
	{
		EzcSysConfigParams sparams = new EzcSysConfigParams();
		EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
		snkparams.setLanguage("EN");
		sparams.setObject(snkparams);
		Session.prepareParams(sparams);
		ReturnObjFromRetrieve retC=null,retV=null;
		if ( areaFlag.equals("C") )
		{
			ret1 = (ReturnObjFromRetrieve) sysManager.getCatalogAreas(sparams);
			areaLabel = "Sales Area";
		}
		else if ( areaFlag.equals("V") )
		{
			ret1 = (ReturnObjFromRetrieve) sysManager.getPurchaseAreas(sparams);
			areaLabel = "Purchase Area";
		}
}
%>
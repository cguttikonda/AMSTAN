<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<%@ include file="../../../Includes/Lib/CatalogArea.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>
<%
// Key Variables
String areaFlag = request.getParameter("Area");
String areaLabel = "";
if ( areaFlag.equals("C") )
{
	areaLabel="Sales Area";
}
else if ( areaFlag.equals("V") )
{
	areaLabel = "Purchase Area";
}
else if ( areaFlag.equals("S") )
{
	areaLabel = "Service Area";
}


ReturnObjFromRetrieve ret = null;

//Get All Catalog Areas
EzcSysConfigParams sparams = new EzcSysConfigParams();
EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
snkparams.setLanguage("EN");
sparams.setObject(snkparams);
Session.prepareParams(sparams);

if ( areaFlag.equals("C") )
{
	ret = (ReturnObjFromRetrieve)sysManager.getCatalogAreas(sparams);
}
else if ( areaFlag.equals("V") )
{
	ret = (ReturnObjFromRetrieve)sysManager.getPurchaseAreas(sparams);
}
else if ( areaFlag.equals("S") )
{
	ezc.ezparam.EzDescStructure eds = new ezc.ezparam.EzDescStructure();
	eds.setAreaFlag(areaFlag);
	eds.setSyncFlag("N");
	snkparams.setEzDescStructure(eds);
	ret = (ReturnObjFromRetrieve)sysManager.getBusinessAreas(sparams);
}

ret.check();
%>
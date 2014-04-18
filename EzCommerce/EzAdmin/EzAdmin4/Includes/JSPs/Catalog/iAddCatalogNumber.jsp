<%@ page import = "ezc.ezcommon.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<%@ include file="../../../Includes/Lib/AdminCatalog.jsp"%>
<%@ include file="../../../Includes/Lib/CatalogArea.jsp"%>
<jsp:useBean id="ezsc" class="ezc.client.EzSystemConfigManager" scope="page">
</jsp:useBean>
<%

// Key Variables
ReturnObjFromRetrieve ret = null;
ReturnObjFromRetrieve retsyskey = null;

String sys_key = null;


// Get List Of System Keys

EzcSysConfigParams sparams = new EzcSysConfigParams();
EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
snkparams.setLanguage("EN");
sparams.setObject(snkparams);
Session.prepareParams(sparams);


retsyskey = (ReturnObjFromRetrieve)ezsc.getCatalogAreas(sparams);
retsyskey.check();


int rets = retsyskey.getRowCount();
for ( int w=0; w < rets; w++ )
{

	String checkFlag = retsyskey.getFieldValueString(w,"ESKD_SYNC_FLAG").trim();
	if ( checkFlag.equals("N") )
	{
		retsyskey.deleteRow(w);
		w--;
		rets--;
	}
} 



//Number of Catalog Areas
int numCatArea = retsyskey.getRowCount();
sys_key = request.getParameter("SystemKey");
sys_key=(sys_key==null)?"sel":sys_key;

if(numCatArea > 0)
{

	if(!sys_key.equals("sel"))
	{
		sys_key = sys_key.trim();
		EzCatalogParams catalogParams = new EzCatalogParams();
		Session.prepareParams(catalogParams);
		catalogParams.setLanguage("EN");
		catalogParams.setSysKey(sys_key);
		ret = (ReturnObjFromRetrieve)catalogObj.getProductGroups(catalogParams);
		ret.check();

	}
}

%>
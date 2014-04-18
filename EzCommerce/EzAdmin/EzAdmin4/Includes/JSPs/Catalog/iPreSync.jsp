<%@ page import = "ezc.ezcommon.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<%@ include file="../../../Includes/Lib/Language.jsp"%>
<%@ include file="../../../Includes/Lib/CatalogArea.jsp"%>
<%@ include file="../../../Includes/Lib/Defaults.jsp"%>
<jsp:useBean id="ezsc" class="ezc.client.EzSystemConfigManager" scope="page">
</jsp:useBean>
<%
	// Key Variables
	ReturnObjFromRetrieve retsyskey = null;
	ReturnObjFromRetrieve retdef = null;

	String sys_key = null;
	
	//Get List of Catalog Areas
	EzcSysConfigParams sparams = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
	snkparams.setLanguage("EN");
	sparams.setObject(snkparams);
	Session.prepareParams(sparams);

	retsyskey = (ReturnObjFromRetrieve)ezsc.getCatalogAreas(sparams);
	retsyskey.check();

	//Number of Catalog Areas
	int numCatArea = retsyskey.getRowCount();

	if(numCatArea > 0)
	{
		//Get System Key Value
		sys_key = request.getParameter("SystemKey");
		sys_key=(sys_key==null || "null".equals(sys_key) )?"sel":sys_key.trim();
		if(! sys_key.equals("sel"))
		{
			//Get Defaults for the selected Catalog Area
			String syncFlag = retsyskey.getFieldValueString(0,"ESKD_SYNC_FLAG");
			snkparams.setClient("200");
			snkparams.setSystemKey(sys_key);
			sparams.setObject(snkparams);
			retdef = (ReturnObjFromRetrieve)ezsc.getCatAreaDefaults(sparams);
			

		}//end if
	}
	
%>
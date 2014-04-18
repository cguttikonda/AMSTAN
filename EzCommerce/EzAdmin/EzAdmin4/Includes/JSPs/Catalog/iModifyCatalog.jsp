<%@ page import = "ezc.ezcommon.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<%@ include file="../../../Includes/Lib/AdminCatalog.jsp"%>
<%@ include file="../../../Includes/Lib/CatalogArea.jsp"%>
<jsp:useBean id="ezsc" class="ezc.client.EzSystemConfigManager" scope="page">
</jsp:useBean>

<%
// Key Variables

ReturnObjFromRetrieve retsyskey = null;
ReturnObjFromRetrieve ret = null;
ReturnObjFromRetrieve catdesc = null;
ReturnObjFromRetrieve retcat = null;

String sys_key = null;
String catalog_number = request.getParameter("CatalogNumber");
catalog_number=(catalog_number==null || "null".equals(catalog_number))?"sel":catalog_number;

	int numCatArea=0;

	EzcSysConfigParams sparams = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
	snkparams.setLanguage("EN");
	sparams.setObject(snkparams);
	Session.prepareParams(sparams);

	retsyskey = (ReturnObjFromRetrieve)ezsc.getCatalogAreas(sparams);
	retsyskey.check();

	numCatArea = retsyskey.getRowCount();

	String checkFlag=null;
	for ( int w=0; w < numCatArea; w++ )
	{

		checkFlag = retsyskey.getFieldValueString(w,"ESKD_SYNC_FLAG").trim();
		if ( checkFlag.equals("N") )
		{
			retsyskey.deleteRow(w);
			w--;
			numCatArea--;
		}
	} //end for



	int numCatalogs=0;
	EzCatalogParams catalogParams = new EzCatalogParams();
	Session.prepareParams(catalogParams);
	catalogParams.setLanguage("EN");
	retcat = (ReturnObjFromRetrieve)catalogObj.getCatalogList(catalogParams);
	retcat.check();
	
	numCatalogs = retcat.getRowCount();
	sys_key = request.getParameter("SystemKey");
	sys_key=(sys_key==null || "null".equals(sys_key))?"sel":sys_key;
	
	if(numCatArea > 0 && numCatalogs > 0)
	{
		

		if(!catalog_number.equals("sel"))
		{
			if(!sys_key.equals("sel"))
			{

				catalogParams = null;
				catalogParams = new EzCatalogParams();
				Session.prepareParams(catalogParams);
				catalogParams.setLanguage("EN");
				catalogParams.setCatalogNumber(catalog_number);
				catdesc = (ReturnObjFromRetrieve)catalogObj.getCatalogNumberDesc(catalogParams);
				catdesc.check();

				//Get Product Groups for the Catalog Number
				catalogParams = null;
				catalogParams = new EzCatalogParams();
				Session.prepareParams(catalogParams);
				catalogParams.setLanguage("EN");
				catalogParams.setCatalogNumber(catalog_number);
				catalogParams.setSysKey(sys_key);
				ret = (ReturnObjFromRetrieve)catalogObj.readCatalogSelected(catalogParams);
				ret.check();
			}
		}
	}
	
	
%>

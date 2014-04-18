<%
ezc.client.EzCatalogManager catalogObj = new ezc.client.EzCatalogManager();
ReturnObjFromRetrieve retPrdGroups = null;
int retPrdGroupsCount=0;
       sys_key = request.getParameter("SystemKey");
	if(sys_key!=null && !sys_key.equals("sel"))
	{
		EzCatalogParams catalogParams = new EzCatalogParams();
		Session.prepareParams(catalogParams);
		catalogParams.setSysKey(sys_key);
		catalogParams.setLanguage("EN");
		retPrdGroups = (ReturnObjFromRetrieve)catalogObj.getProductGroups (catalogParams);
		retPrdGroups.check();
		retPrdGroupsCount=retPrdGroups.getRowCount();
	}

%>
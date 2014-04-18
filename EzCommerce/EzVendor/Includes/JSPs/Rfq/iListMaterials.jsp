<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<%
	String material = request.getParameter("matCode");
	String maxRows = request.getParameter("maxRows");
	ezc.ezpreprocurement.client.EzPreProcurementManager PreProcurementManager=new ezc.ezpreprocurement.client.EzPreProcurementManager();
	ezc.ezpreprocurement.params.EziPreProcurementParams param=new ezc.ezpreprocurement.params.EziPreProcurementParams();
	param.setExt1("LIST");
	param.setOpenItems(maxRows);
	param.setMaterial(material);	
	ezc.ezparam.EzcParams mainParams=new ezc.ezparam.EzcParams(true);
	mainParams.setObject(param);
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve retMaterialsList=(ezc.ezparam.ReturnObjFromRetrieve)PreProcurementManager.ezGetMaterialDetails(mainParams);
	
	int materialsCount = 0;
	
	if(retMaterialsList != null)
	{
		materialsCount = retMaterialsList.getRowCount();
	}
%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<%
	String material = request.getParameter("matCode");
	String myIndex = request.getParameter("myIndex");
	if(!material.startsWith("*"))
		material="*"+material;
	String maxRows = request.getParameter("maxRows");
	if(maxRows==null || "null".equals(maxRows)|| "".equals(maxRows))
		maxRows="10";
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
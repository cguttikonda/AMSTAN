<%@ include file="../../Lib/AdminUtilsBean.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<%
	ReturnObjFromRetrieve searchRet = null;
	String searchBy 	= request.getParameter("searchBy");
	String searchPattern 	= request.getParameter("searchPattern");
	String searchCriteria 	= request.getParameter("searchCriteria");
	String msg 		= "Materials ";
	
	if(searchBy!=null && searchPattern!=null)
	{
		if("matCode".equals(searchBy)&&("G".equals(searchPattern)))
			msg = "Material Groups ";
		if("matCode".equals(searchBy)&&("GS".equals(searchPattern)))
			msg = "Material Groups and Sales Areas";
		if("matCode".equals(searchBy)&&("GSC".equals(searchPattern)))
			msg = "Material Groups,Sales Areas and Catalogs";
		if("matGrp".equals(searchBy)&&("S".equals(searchPattern)))
			msg = "Sales Areas ";
		if("matGrp".equals(searchBy)&&("C".equals(searchPattern)))
			msg = "Catalogs ";
	}

	if(searchBy!=null)
	{
		EziMaterialSearchParams searchParams = new EziMaterialSearchParams();
		
		if(searchBy.equals("matDesc"))
		{
			searchCriteria = searchCriteria.replace('*','%');
			searchParams.setMaterialDesc(searchCriteria);
		}
		if(searchBy.equals("matCode"))
		{
			if("M".equals(searchPattern))
			{
				searchCriteria = searchCriteria.replace('*','%');
				searchParams.setMaterialDesc("%' and emm_no like '"+searchCriteria);
			}
			else
			{
				searchCriteria = searchCriteria.replace('*','%');
				//searchCriteria = "000000000000000000"+searchCriteria;
				//searchCriteria = searchCriteria.substring((searchCriteria.length()-18),searchCriteria.length());
				searchParams.setMaterialCode(searchCriteria);
			}	
		}
		if(searchBy.equals("matGrp"))		
		{
			searchParams.setMaterialGroup(searchCriteria);
		}
		if(searchPattern!=null)
			searchParams.setSearchType(searchPattern);
		
		EzcParams mainParams = new EzcParams(false);
		mainParams.setObject(searchParams);
		Session.prepareParams(mainParams);

		searchRet = (ReturnObjFromRetrieve)AUM.searchMaterials(mainParams);
		
	}
	
	
	
%>
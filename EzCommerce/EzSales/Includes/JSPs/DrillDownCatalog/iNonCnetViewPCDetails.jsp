<%
	int pageSize = 0; 
	String pageNo=request.getParameter("d-49520-p");
	int retObjcount = 0;
	String catalogStr = request.getParameter("catalogStr");
	ezc.ezcommon.EzLog4j.log("catalogStr>>>>>>>>"+catalogStr,"I");
	String favGroup = (String)session.getValue("USR_FAV_GRP");
	String favGrpDesc = (String)session.getValue("USR_FAV_DESC");
	try{
		if(request.getParameter("pageSize") != null)
		{
			pageSize = Integer.parseInt(request.getParameter("pageSize"));
		}
		else
		{
			pageSize = 5;
		}
	}catch(Exception ex) 
	{
		pageSize = 5; 
	}	
	
	String isCatUser     = (String)session.getValue("IsCatUser");
	String noDataStatement ="No Data to Display"; 
	pageContext.setAttribute("tableclass", "its");
	String clearSession  = "Y";  
	String pgSizeCh = request.getParameter("pgSizeCh");
	if(request.getParameter("d-49520-p") != null || request.getParameter("d-49520-o")!=null || "Y".equals(pgSizeCh)){
		clearSession = "N";
	}
	
	if("Y".equals(clearSession)){
		session.removeAttribute("PCOBJ");
	}
	
	ResultSet rSet = null;
	int rSetSize=0;
	


	EzCatalogParams ezcpparams = null;
	EzCustomerItemCatParams cnetParams=null;
	if(session.getAttribute("PCOBJ")==null)
	{
		
		
		ezcpparams=new ezc.ezparam.EzCatalogParams();
		cnetParams=new EzCustomerItemCatParams();
		
		EzCatalogParams ezread = new EzCatalogParams();
		ezread.setLanguage("EN");
		ezread.setProductGroup(favGroup);
		Session.prepareParams(ezread);

		ReturnObjFromRetrieve gbRet = (ReturnObjFromRetrieve) EzCatalogManager.readCatalogDetails(ezread);
		ReturnObjFromRetrieve cnetRet = (ReturnObjFromRetrieve)gbRet.getObject("CNETRET");
						//out.println("cnetRet>>>>"+cnetRet.toEzcString());


		if(cnetRet!=null && cnetRet.getRowCount()>0)
		{
			String[] prds = new String[cnetRet.getRowCount()];
			String[] cats = new String[cnetRet.getRowCount()];
			for(int a=0;a<cnetRet.getRowCount();a++)
			{
				prds[a] = cnetRet.getFieldValueString(a,"EPF_MAT_NO");
				cats[a] = cnetRet.getFieldValueString(a,"EPF_ITEMCAT");
			}
				
				
				ezcpparams.setType("GET_PRDS_CAT_PROD");
				
				cnetParams.setProdIDs(prds);
				cnetParams.setCategoryIDs(cats);
				cnetParams.setQuery("");
				//out.println("prds>>>>"+prds[1]);
				//out.println("cats>>>>"+cats[2]);
				ezcpparams.setLocalStore("Y");
				ezcpparams.setObject(cnetParams);
				Session.prepareParams(ezcpparams);
				
				ezc.ezcommon.EzLog4j.log("retObj>>>>STatr","D");
				ReturnObjFromRetrieve retObj = (ReturnObjFromRetrieve)webCatalogObj.getCustomerCategories(ezcpparams);
				ezc.ezcommon.EzLog4j.log("retObj>>>>ENd","D");
	
			
			
			
			if(retObj!=null && retObj.getRowCount()>0)
			{
				for(int k=0;k<retObj.getRowCount();k++)
				{
					gbRet.setFieldValue("EPF_USER_ID","");
					gbRet.setFieldValue("EPF_SYS_KEY","");
					gbRet.setFieldValue("EPF_FAVOURITE_GROUP","");
					gbRet.setFieldValue("EPF_MM_ID",retObj.getFieldValueString(k,"EMM_MANUFACTURER"));
					gbRet.setFieldValue("EPF_CATALOG_NO","");
					gbRet.setFieldValue("EPF_MAT_NO","");
					gbRet.setFieldValue("EPF_PRODUCT_SEQUENCE","");
					gbRet.setFieldValue("EPF_TYPE","CNET");
					gbRet.setFieldValue("EPF_ITEMCAT","");
					gbRet.setFieldValue("EMM_ID",retObj.getFieldValueString(k,"EMM_MANUFACTURER"));
					gbRet.setFieldValue("EMM_CATALOG_NO",retObj.getFieldValueString(k,"EMM_TYPE"));
					gbRet.setFieldValue("EMM_NO",retObj.getFieldValueString(k,"EMM_NO"));
					gbRet.setFieldValue("EMM_MANUFACTURER",retObj.getFieldValueString(k,"EMM_MANUFACTURER"));
					gbRet.setFieldValue("EMM_UNIT_OF_MEASURE","EA");
					gbRet.setFieldValue("EMM_UNIT_PRICE","55");
					gbRet.setFieldValue("EMM_IMAGE_FLAG","");
					gbRet.setFieldValue("EMM_DELETION_FLAG","");
					gbRet.setFieldValue("EMM_AVAIL_QUANTITY","");
					gbRet.setFieldValue("EMM_VARIABLE_PRICE_FLAG","");
					gbRet.setFieldValue("EMM_IMAGE_PATH",retObj.getFieldValueString(k,"EMM_IMAGE_PATH"));
					gbRet.setFieldValue("EMM_STATUS","");
					gbRet.setFieldValue("EMM_FAMILY","");
					gbRet.setFieldValue("EMM_TYPE","");
					gbRet.setFieldValue("EMM_COLOR","");
					gbRet.setFieldValue("EMM_SIZE","");
					gbRet.setFieldValue("EMM_LENGTH","");
					gbRet.setFieldValue("EMM_WIDTH","");
					gbRet.setFieldValue("EMM_FINISH","");
					gbRet.setFieldValue("EMM_SPECS","");
					gbRet.setFieldValue("EMM_EXT_NO","");
					gbRet.setFieldValue("EMM_EAN_UPC_NO",retObj.getFieldValueString(k,"EMM_NO"));
					gbRet.setFieldValue("EMM_CURR_KEY","");
					gbRet.setFieldValue("EMM_FUTURE_PRICE","");
					gbRet.setFieldValue("EMM_EFFECTIVE_DATE","");
					gbRet.setFieldValue("EMD_LANG","");
					gbRet.setFieldValue("EMD_DESC",retObj.getFieldValueString(k,"EMD_DESC"));
					gbRet.setFieldValue("EMD_WEB_DESC","");
					gbRet.setFieldValue("EMD_SPECS1","");
					gbRet.setFieldValue("EMD_SPECS2","");
					gbRet.setFieldValue("EMD_SPECS3","");
					gbRet.setFieldValue("EMD_SPECS4","");
					gbRet.setFieldValue("EMD_EXTERNAL_URL","");			
					gbRet.addRow();
				}
			}

		}
		
		if(gbRet!=null && gbRet.getRowCount()>0){
			String rFields[] = new String[]{"EMM_NO","EMD_DESC","EMM_CATALOG_NO","EMM_MANUFACTURER","EMM_UNIT_PRICE","EMM_UNIT_OF_MEASURE","EMM_IMAGE_PATH","EMM_ID","EMM_EAN_UPC_NO","EPF_TYPE","EPF_MM_ID"}; 
			rSet = new ResultSet();
			rSet.addObject(gbRet,rFields);
			session.setAttribute( "PCOBJ", rSet); 
		}	
	}
	else
	{
		rSet = (ResultSet)session.getAttribute( "PCOBJ");
	}
	
%>

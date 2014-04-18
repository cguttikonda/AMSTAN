<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalogBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalog.jsp"%>
<jsp:useBean id="CnetManager" class="ezc.ezcnetconnector.client.EzCnetConnectorManager" />
<%@ page import="ezc.ezparam.*,ezc.ezcnetconnector.params.*" %>
<%

 // Key Variables

	ReturnObjFromRetrieve ret = null;
	ReturnObjFromRetrieve retprodfav = null;
	ReturnObjFromRetrieve cnetRet = null;

	String pGroupNumber = request.getParameter("ProductGroup");
	String pGroupDesc = request.getParameter("GroupDesc");

	EzcParams ezcpparams = new EzcParams(true);
	EzCnetConnectorParams cnetParams=new EzCnetConnectorParams();


	EzCatalogParams ezread = new EzCatalogParams();
	ezread.setLanguage("EN");
	ezread.setProductGroup(pGroupNumber);
	Session.prepareParams(ezread);
	ret = (ReturnObjFromRetrieve) EzCatalogManager.readCatalogDetails(ezread);
	cnetRet = (ReturnObjFromRetrieve)ret.getObject("CNETRET");
	
	if(cnetRet!=null && cnetRet.getRowCount()>0)
	{
		String[] prds = new String[cnetRet.getRowCount()];
		String[] cats = new String[cnetRet.getRowCount()];
		for(int a=0;a<cnetRet.getRowCount();a++)
		{
			prds[a] = cnetRet.getFieldValueString(a,"EPF_MAT_NO");
			cats[a] = cnetRet.getFieldValueString(a,"EPF_ITEMCAT");
		}
		cnetParams.setStatus("GET_PRDS_CAT_PROD");
		cnetParams.setQuery(" ");
		cnetParams.setProdIDs(prds);
		cnetParams.setCategoryIDs(cats);
		ezcpparams.setObject(cnetParams);
		ezcpparams.setLocalStore("Y");
		Session.prepareParams(ezcpparams);
		ReturnObjFromRetrieve retObj = (ReturnObjFromRetrieve)CnetManager.ezGetCnetProductsByStatus(ezcpparams);
		ezc.ezcommon.EzLog4j.log("retObjretObj>>>>>>>>"+retObj.toEzcString(),"I");
		if(retObj!=null && retObj.getRowCount()>0)
		{
			for(int k=0;k<retObj.getRowCount();k++)
			{
				ret.setFieldValue("EPF_USER_ID","");
				ret.setFieldValue("EPF_SYS_KEY","");
				ret.setFieldValue("EPF_FAVOURITE_GROUP","");
				ret.setFieldValue("EPF_MM_ID","");
				ret.setFieldValue("EPF_CATALOG_NO","");
				ret.setFieldValue("EPF_MAT_NO","");
				ret.setFieldValue("EPF_PRODUCT_SEQUENCE","");
				ret.setFieldValue("EPF_TYPE","CNET");
				ret.setFieldValue("EPF_ITEMCAT","");
				ret.setFieldValue("EMM_ID","10");
				ret.setFieldValue("EMM_CATALOG_NO",retObj.getFieldValueString(k,"CatID"));
				ret.setFieldValue("EMM_NO",retObj.getFieldValueString(k,"ProdID"));
				ret.setFieldValue("EMM_MANUFACTURER",retObj.getFieldValueString(k,"MfIDText"));
				ret.setFieldValue("EMM_UNIT_OF_MEASURE","EA");
				ret.setFieldValue("EMM_UNIT_PRICE","");
				ret.setFieldValue("EMM_IMAGE_FLAG","");
				ret.setFieldValue("EMM_DELETION_FLAG","");
				ret.setFieldValue("EMM_AVAIL_QUANTITY","");
				ret.setFieldValue("EMM_VARIABLE_PRICE_FLAG","");
				ret.setFieldValue("EMM_IMAGE_PATH",retObj.getFieldValueString(k,"ImgID"));
				ret.setFieldValue("EMM_STATUS","");
				ret.setFieldValue("EMM_FAMILY","");
				ret.setFieldValue("EMM_TYPE","");
				ret.setFieldValue("EMM_COLOR","");
				ret.setFieldValue("EMM_SIZE","");
				ret.setFieldValue("EMM_LENGTH","");
				ret.setFieldValue("EMM_WIDTH","");
				ret.setFieldValue("EMM_FINISH","");
				ret.setFieldValue("EMM_SPECS","");
				ret.setFieldValue("EMM_EXT_NO","");
				ret.setFieldValue("EMM_EAN_UPC_NO","");
				ret.setFieldValue("EMM_CURR_KEY","");
				ret.setFieldValue("EMM_FUTURE_PRICE","");
				ret.setFieldValue("EMM_EFFECTIVE_DATE","");
				ret.setFieldValue("EMD_LANG","");
				ret.setFieldValue("EMD_DESC",retObj.getFieldValueString(k,"ProdIDDesc"));
				ret.setFieldValue("EMD_WEB_DESC","");
				ret.setFieldValue("EMD_SPECS1","");
				ret.setFieldValue("EMD_SPECS2","");
				ret.setFieldValue("EMD_SPECS3","");
				ret.setFieldValue("EMD_SPECS4","");
				ret.setFieldValue("EMD_EXTERNAL_URL","");			
				ret.addRow();
			}
		}
		
	}


	
	int retCount = ret.getRowCount();
	if( (ret != null) && (ret.getRowCount() > 0) )
  	{
		String sortField[] = {MATD_DESC};
		ret.sort(sortField,true);
  	}

	EzCatalogParams ezget = new EzCatalogParams();
	ezget.setLanguage("EN");
	Session.prepareParams(ezget);
	retprodfav = (ReturnObjFromRetrieve) EzCatalogManager.getProdFavDesc(ezget);

  
	String chkString=request.getParameter("chkString");
	String [] checkedProducts = null;
	if (!(chkString == null || chkString =="" || "null".equals(chkString)))
	{
		StringTokenizer st=new StringTokenizer(chkString,",");
		checkedProducts = new String[st.countTokens()];
		for(int cal=0;st.hasMoreTokens();cal++)
		{
			checkedProducts[cal]=(String)st.nextElement();
		}
	}

	int chklength=0;
	if(checkedProducts!= null)
		chklength=checkedProducts.length;
%>

<%@ page import="ezc.ezcnetconnector.params.*,ezc.ezparam.*" %>

<%
	
	String itemCat = request.getParameter("itemCat");
	String prdCodeOrDesc = request.getParameter("prdCodeOrDesc");
	String uRole =(String)session.getValue("UserRole");
	ReturnObjFromRetrieve retCat=null,retMfr=null;
	int retCatCnt = 0,retMfrCnt = 0;
	String pCatID="",pCatIDStr="";


	if(prdCodeOrDesc==null)prdCodeOrDesc="";
	if(itemCat==null)itemCat="ALL";



	EzCatalogParams catalogParamsCRI = new ezc.ezparam.EzCatalogParams();  
	EzCustomerItemCatParams ecicCRI = new EzCustomerItemCatParams(); 

	catalogParamsCRI.setType("GET_CRI_CAT");
	ecicCRI.setExt1("");
	catalogParamsCRI.setLocalStore("Y");
	catalogParamsCRI.setObject(ecicCRI);
	Session.prepareParams(catalogParamsCRI);

	retCat = (ReturnObjFromRetrieve)webCatalogObj.getCustomerCategories(catalogParamsCRI);
	//out.println("retCat>>>>"+retCat.toEzcString());
	if(retCat!=null)
		retCatCnt = retCat.getRowCount();
		
		
	if("CU".equals(uRole) || "CUSR".equals(uRole))
	{
		java.util.ArrayList selCustCat = new java.util.ArrayList();
		
		EzCatalogParams catalogParams = new ezc.ezparam.EzCatalogParams();
		EzCustomerItemCatParams ecic = new EzCustomerItemCatParams();

		catalogParams.setType("GET_CUST");
		ecic.setSoldTo((String)session.getValue("AgentCode"));
		ecic.setExt1((String)session.getValue("SalesAreaCode"));

		catalogParams.setLocalStore("Y");
		catalogParams.setObject(ecic);
		Session.prepareParams(catalogParams);

		ReturnObjFromRetrieve retCustCat =(ReturnObjFromRetrieve)webCatalogObj.getCustomerCategories(catalogParams);

		if(retCustCat!=null && retCustCat.getRowCount()>0)
		{
			for(int k=0;k<retCustCat.getRowCount();k++)
			{
				selCustCat.add(retCustCat.getFieldValueString(k,"ECI_ITEMCAT"));
			}
		}
		if(retCatCnt>0)
		{
			for(int i=retCatCnt-1;i>=0;i--)
			{
				if(!selCustCat.contains(retCat.getFieldValueString(i,"EMM_TYPE")))
					retCat.deleteRow(i);
			}
			retCatCnt = retCat.getRowCount();
		}
	}
	for(int a=0;a<retCatCnt;a++)
	{
		pCatID = retCat.getFieldValueString(a,"EMM_TYPE");
		if(a==0)
			pCatIDStr = pCatID;
		else
			pCatIDStr = pCatIDStr + "','" + pCatID;

	}
	session.putValue("USER_CAT_STR",pCatIDStr);
		
	if(itemCat!=null)
	{
		String[] catData = itemCat.split("¥");
		itemCat = catData[0];
		String pItemCat = itemCat;
		if("ALL".equals(pItemCat))
		{
			pItemCat = pCatIDStr;
		}
		
		EzCatalogParams catalogParamsCRI_MFR = new ezc.ezparam.EzCatalogParams(); 
		EzCustomerItemCatParams ecic_MFR=new EzCustomerItemCatParams();
		catalogParamsCRI_MFR.setType("GET_PRDS_MFR");
		ecic_MFR.setQuery("where EMM_TYPE IN ('"+pItemCat+"')");
		//ecic_MFR.setQuery("");
		catalogParamsCRI_MFR.setLocalStore("Y");
		catalogParamsCRI_MFR.setObject(ecic_MFR);
		Session.prepareParams(catalogParamsCRI_MFR);
		log4j.log("webCatalogObj>>>>ss"+itemCat,"I");
		retMfr = (ReturnObjFromRetrieve)webCatalogObj.getCustomerCategories(catalogParamsCRI_MFR);
		log4j.log("webCatalogObj>>>>ee"+itemCat,"I");
	
		if(retMfr!=null)
			retMfrCnt = retMfr.getRowCount();
	
	}
		
		
			
		
	
%>
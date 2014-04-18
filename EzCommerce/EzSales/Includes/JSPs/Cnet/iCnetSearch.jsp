<%@ page import="ezc.ezcnetconnector.params.*,ezc.ezparam.*" %>
<jsp:useBean id="CnetManager" class="ezc.ezcnetconnector.client.EzCnetConnectorManager" />
<%
	
	String itemCat = request.getParameter("itemCat");
	String prdCodeOrDesc = request.getParameter("prdCodeOrDesc");
	String uRole =(String)session.getValue("UserRole");
	ReturnObjFromRetrieve retCat=null,retMfr=null;
	int retCatCnt = 0,retMfrCnt = 0;
	String pCatID="",pCatIDStr="";


	if(prdCodeOrDesc==null)prdCodeOrDesc="";
	if(itemCat==null)itemCat="ALL";


	EzcParams ezcpparams = new EzcParams(true);
	EzCnetConnectorParams cnetParams=new EzCnetConnectorParams();
	cnetParams.setQuery("order by cds_Cat.CatID");
	ezcpparams.setObject(cnetParams);
	ezcpparams.setLocalStore("Y");
	Session.prepareParams(ezcpparams);
	
	retCat = (ReturnObjFromRetrieve)CnetManager.ezGetCnetCategories(ezcpparams);
	//log4j.log("retCat>>>>"+retCat.toEzcString(),"I");
	if(retCat!=null)
		retCatCnt = retCat.getRowCount();
		
	if("CU".equals(uRole) || "CUSR".equals(uRole))
	{
		java.util.ArrayList selCustCat = new java.util.ArrayList();
		EzCatalogParams catalogParams = new ezc.ezparam.EzCatalogParams();
		EzCustomerItemCatParams ecic = new EzCustomerItemCatParams();

		catalogParams.setType("GET_CUST");
		ecic.setSoldTo((String)session.getValue("AgentCode"));
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
				if(!selCustCat.contains(retCat.getFieldValueString(i,"CatID")))
					retCat.deleteRow(i);
			}
			retCatCnt = retCat.getRowCount();
		}
	}
	for(int a=0;a<retCatCnt;a++)
	{
		pCatID = retCat.getFieldValueString(a,"CatID");
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
		
		ezcpparams = new EzcParams(true);
		cnetParams=new EzCnetConnectorParams();
		cnetParams.setStatus("GET_PRDS_MFR");
		cnetParams.setQuery("and cds_Prod.CatID IN ('"+pItemCat+"') order by cds_Vocez.Text");
		ezcpparams.setObject(cnetParams);
		ezcpparams.setLocalStore("Y");
		Session.prepareParams(ezcpparams);

		retMfr = (ReturnObjFromRetrieve)CnetManager.ezGetCnetProductsByStatus(ezcpparams);
	
		if(retMfr!=null)
			retMfrCnt = retMfr.getRowCount();
	
	}
		
		
			
		
	
%>
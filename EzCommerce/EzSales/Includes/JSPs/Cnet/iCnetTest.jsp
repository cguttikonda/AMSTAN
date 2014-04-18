<%@ page import = "ezc.ezparam.*,ezc.ezcnetconnector.params.*" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalogBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalog.jsp"%>
<jsp:useBean id="CnetManager" class="ezc.ezcnetconnector.client.EzCnetConnectorManager" />
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"/>
<jsp:useBean id="webCatalogObj" class="ezc.client.EzWebCatalogManager" scope="page"></jsp:useBean>
<%
	ezc.ezcommon.EzLog4j log4j = new  ezc.ezcommon.EzLog4j();
        String uRole =(String)session.getValue("UserRole");
	String userId	= Session.getUserId();
	String skey	= (String) session.getValue("SalesAreaCode");
      	ReturnObjFromRetrieve retcat = null;
      	ReturnObjFromRetrieve retPerCat = null;

	int retCatCount =0;
        
        java.util.ArrayList selCustCat = new java.util.ArrayList();
        
		
	EzcParams ezcparams = new EzcParams(true);
	EzCnetConnectorParams cnetParams=new EzCnetConnectorParams();
	cnetParams.setQuery("order by cds_Cctez.Description ASC");
	ezcparams.setObject(cnetParams);
	ezcparams.setLocalStore("Y");
	Session.prepareParams(ezcparams);
	retcat = (ReturnObjFromRetrieve)CnetManager.ezGetCnetCategories(ezcparams);

	if(retcat!=null)
	{
		retCatCount= retcat.getRowCount();
		if("CU".equals(uRole) || "CUSR".equals(uRole))
		{
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
			for(int a=retCatCount-1;a>=0;a--)
			{
				if(!selCustCat.contains(retcat.getFieldValueString(a,"CatID")))
					retcat.deleteRow(a);

			}
			retCatCount= retcat.getRowCount();
		}
		if(retCatCount>0)
			retcat.sort(new String[]{"Description"},true);

	}

   	EzCatalogParams ezcpparams = new EzCatalogParams();
	ezcpparams.setLanguage("EN");
	Session.prepareParams(ezcpparams);
	retPerCat = (ReturnObjFromRetrieve) EzCatalogManager.getCustomCatalog(ezcpparams);	
	
	
	
%>

        
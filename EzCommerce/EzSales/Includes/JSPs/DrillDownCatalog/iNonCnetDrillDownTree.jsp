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
	String catType	   ="P";
	String perCatNo    ="N/A";
	String perCatDesc  ="My Favourites";
	String catalogStr  =perCatNo+"@@"+perCatDesc+"@@"+catType;
	String isCatUser     = (String)session.getValue("IsCatUser");

      	ReturnObjFromRetrieve retcat = null;
      	ReturnObjFromRetrieve retPerCat = null;
      	int retCatCount = 0;

	EzCatalogParams catalogParamsCRI = new ezc.ezparam.EzCatalogParams();  
	EzCustomerItemCatParams ecicCRI = new EzCustomerItemCatParams(); 

	catalogParamsCRI.setType("GET_CRI_CAT");
	ecicCRI.setExt1("");
	catalogParamsCRI.setLocalStore("Y");
	catalogParamsCRI.setObject(ecicCRI);
	Session.prepareParams(catalogParamsCRI);

	retcat = (ReturnObjFromRetrieve)webCatalogObj.getCustomerCategories(catalogParamsCRI);
	//out.println("retCat>>>>"+retCat.toEzcString());
	if(retcat!=null)
	retCatCount = retcat.getRowCount();

	if(retcat!=null)
	{
		retCatCount= retcat.getRowCount();
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
			for(int a=retCatCount-1;a>=0;a--)
			{
				if(!selCustCat.contains(retcat.getFieldValueString(a,"EMM_TYPE")))
					retcat.deleteRow(a);

			}
			retCatCount= retcat.getRowCount();
		}
		if(retCatCount>0)
			retcat.sort(new String[]{"EMM_TYPE"},true);

	}

   	EzCatalogParams ezcpparams = new EzCatalogParams();
	ezcpparams.setLanguage("EN");
	Session.prepareParams(ezcpparams);
	retPerCat = (ReturnObjFromRetrieve) EzCatalogManager.getCustomCatalog(ezcpparams);	

	if(retPerCat!=null && retPerCat.getRowCount()>0)
	{
		catType="P";
		perCatNo    =  retPerCat.getFieldValueString(0,"EPG_NO").trim();
		perCatDesc  =  retPerCat.getFieldValueString(0,"EPGD_WEB_DESC");

		perCatDesc=perCatDesc.replace('\"',' ');
		perCatDesc=perCatDesc.replace('\'',' ');	
		perCatDesc=perCatDesc.replace('<',' ');	
		perCatDesc=perCatDesc.replace('>',' ');	
		perCatDesc=perCatDesc.trim();
		perCatDesc=perCatDesc.replace('&','@');	
		perCatDesc=replaceChar(perCatDesc,'&');
		if((perCatNo==null)||(perCatNo=="null")||(perCatNo.trim().length() == 0))
		{
			perCatNo ="N/A";
		}
		if((perCatDesc==null)||(perCatDesc=="null")||(perCatDesc.trim().length() == 0))
		{
			perCatDesc ="My Favourites";
		}
		catalogStr  =perCatNo+"@@"+perCatDesc+"@@"+catType; 
	}
	
	//out.println("retPerCat:::"+retPerCat.toEzcString())
	
	
	
%>
<%!
	public static String replaceChar(String s, char c) 
	{
	      StringBuffer r = new StringBuffer(s.length());
	      r.setLength( s.length()); 	       
	      int current = 0;
	      for (int i = 0; i < s.length(); i ++) 
	      {
	           char cur = s.charAt(i);
	           if (cur == c) 
	           {
	            	r.setLength( s.length()+4); 
	            	//r.setCharAt(current++,cur);
	            	r.setCharAt(current++,'a');
	            	r.setCharAt(current++,'m');
	            	r.setCharAt(current++,'p');
	            	r.setCharAt(current++,';');
	           }	
	           else
	            	r.setCharAt( current++, cur);
	      }
	      return r.toString();
	}
%>
       
        
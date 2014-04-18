<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalogBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalog.jsp"%>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"/>
<%
	ezc.ezcommon.EzLog4j log4j = new  ezc.ezcommon.EzLog4j();
	StringTokenizer st = null;
	String id	= request.getParameter("id");
	log4j.log("idididid:::"+id,"W");
id = "0";
	String grpNum="0",level="0";
	if(!"0".equals(id) && "0"!=id)
	{
		st = new StringTokenizer(id,"$$");
		
		if(st!=null)
		{
			level	= st.nextToken(); 
			grpNum	= st.nextToken();	
		}
	}	

   // Key Variables
   
   ReturnObjFromRetrieve ret 	= null;
   String userId		= Session.getUserId();
   String skey			= (String) session.getValue("SalesAreaCode");
   String catalogCode		= (String) session.getValue("CatalogCode");

log4j.log("catalogCode:::"+catalogCode,"W");
log4j.log("skeyskey:::"+skey,"W");

   EzCatalogParams ezcpparams = new EzCatalogParams();
   
	if("0".equals(id) )
	{   
		Integer test 		= new Integer(level);
		int iLevel 		= test.intValue() + 1;

		char pcLevel 		= ' ';
		pcLevel 		= level.charAt(0); 
		pcLevel 		= (char) (pcLevel + 1); // Next Level

		//iLevel			= 2;
		ezcpparams.setLanguage("EN");
		ezcpparams.setHeirarchyLevel(iLevel);
		ezcpparams.setProductGroup(grpNum);
		Session.prepareParams(ezcpparams);
		try
		{
			log4j.log("readCatalogreadCatalogreadCatalog:::","W");
			ret = (ReturnObjFromRetrieve) EzCatalogManager.readCatalog(ezcpparams);
			//ret.toEzcString();
			log4j.log("readCatalogreadCatalogreadCatalog:::","W");
		}
		catch(Exception e)
		{
			System.out.println("Exception occured here:::"+e);
		}
	}
	else
	{
		ezcpparams.setLanguage("EN");
		ezcpparams.setSysKey(skey);
		ezcpparams.setCatalogNumber(catalogCode);
		Session.prepareParams(ezcpparams);
	   	
	   	log4j.log("readCatalogSelectedreadCatalogSelected:::","W");
	   	System.out.println("retretrretretrretretrretretrretretrretretrretretrretretr");
		
		ret = (ReturnObjFromRetrieve)EzCatalogManager.readCatalogSelected(ezcpparams);
		ret.toEzcString();
		System.out.println("readCatalogSelectedreadCatalogSelected");
		
	}
	int retCount= 0;
	if(ret!=null) retCount= ret.getRowCount();


	 ReturnObjFromRetrieve retcat=null;
	 EzcUserParams uparams= new EzcUserParams();
	 uparams.setUserId(userId);
	 EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
	 ezcUserNKParams.setLanguage("EN");
	 uparams.createContainer();
	 uparams.setObject(ezcUserNKParams);
	 Session.prepareParams(uparams);
	 // Get User Catalog Number
	 retcat = (ReturnObjFromRetrieve)UserManager.getUserCatalogs(uparams);
	 String CatalogDescription ="Catalog";
	 
	 if( retcat != null) CatalogDescription = retcat.getFieldValueString(0,"EPC_NAME");
	 if(CatalogDescription== null) CatalogDescription = "Catalog";
	
%>

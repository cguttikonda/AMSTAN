<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalogBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalog.jsp"%>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"/>
<%
	ezc.ezcommon.EzLog4j log4j = new  ezc.ezcommon.EzLog4j();
	StringTokenizer st = null;
	String id	= request.getParameter("id");

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
   

   EzCatalogParams ezcpparams = new EzCatalogParams();
   
   	String catChk	= "",epgNo="",Parti="",level1="",grpNum1="",finalVal="";
   	java.util.ArrayList childVector = new java.util.ArrayList();
   
	if(!"0".equals(id))
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
			ret = (ReturnObjFromRetrieve) EzCatalogManager.readCatalog(ezcpparams);
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
	   	
		ret = (ReturnObjFromRetrieve)EzCatalogManager.readCatalogSelected(ezcpparams);
		
		boolean flag = false;
		for(int i=0;i<ret.getRowCount();i++)
		{
			flag 	= false;
			epgNo	= ret.getFieldValueString(i,"EPG_NO").trim();
			Parti	= ret.getFieldValueString(i,"EPGD_WEB_DESC");
			level1	= ret.getFieldValueString(i,"EPG_GROUP_LEVEL").trim();
			grpNum1	= ret.getFieldValueString(i,"EPG_NO");
			finalVal= ret.getFieldValueString(i,"EPG_TERMINAL_FLAG");
		
			if(!"1".equals(level1))
				continue;
			
			for(int j=0;j<ret.getRowCount();j++)
			{
				if("1".equals(ret.getFieldValueString(j,"EPG_GROUP_LEVEL").trim()))
					continue;
				
				if((ret.getFieldValueString(j,"EPG_NO").trim()).startsWith(epgNo) && "Y".equals(ret.getFieldValueString(j,"ISCHECKED").trim()))
				{
					flag 	= true;
					break;
				}
			}
			if(flag)
			{
				childVector.add(epgNo);
			}
		}
		
		for(int i=0;i<ret.getRowCount();i++)
		{
			flag 	= false;
			epgNo	= ret.getFieldValueString(i,"EPG_NO").trim();
			Parti	= ret.getFieldValueString(i,"EPGD_WEB_DESC");
			level1	= ret.getFieldValueString(i,"EPG_GROUP_LEVEL").trim();
			grpNum1	= ret.getFieldValueString(i,"EPG_NO");
			finalVal= ret.getFieldValueString(i,"EPG_TERMINAL_FLAG");

			if(!"2".equals(level1))
				continue;

			for(int j=0;j<ret.getRowCount();j++)
			{
				if("2".equals(ret.getFieldValueString(j,"EPG_GROUP_LEVEL").trim()))
					continue;

				if((ret.getFieldValueString(j,"EPG_NO").trim()).startsWith(epgNo) && "Y".equals(ret.getFieldValueString(j,"ISCHECKED").trim()))
				{
					flag 	= true;
					break;
				}
			}
			if(flag)
			{
				childVector.add(epgNo);
			}
		}
		
		
		
		
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
<%@ page import ="ezc.ezparam.*"%>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>  
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>


<%!
	// Start Declarations

	final String PROD_GROUP_DESC_LANG = "EPGD_LANG";
	final String PROD_GROUP_DESC = "EPGD_DESC";
	final String PROD_GROUP_WEB_DESC = "EPGD_WEB_DESC";

	final String SYSTEM_KEY = "ESKD_SYS_KEY";
	final String SYSTEM_KEY_DESC_LANGUAGE = "ESKD_LANG";
	final String SYSTEM_KEY_DESCRIPTION = "ESKD_SYS_KEY_DESC";

	final String CATALOG_NUMBER = "ECG_CATALOG_NO";
	final String CATALOG_SYSTEM_KEY = "ECG_SYS_KEY";
	final String CATALOG_PRODUCT_GROUP = "ECG_PRODUCT_GROUP";

	final String ERP_CUST_NAME = "ECA_NAME";
	final String ERP_CUST_NUM = "EC_ERP_CUST_NO";

	//End Declarations
%>

<%
	int catareaRows = 0;
	int soldtoRows = 0;

	ezc.client.EzcUtilManager UtilManager = new ezc.client.EzcUtilManager(Session);
	// Key Variables
	ReturnObjFromRetrieve retcatarea = null;
	ReturnObjFromRetrieve retsoldto,retsoldto1 = null;
	String redirectfile=null;
	String defsoldto = null,defarea=null;

	retcatarea = (ReturnObjFromRetrieve)UtilManager.getUserCatalogAreas();

	String catalog_area = (String)(retcatarea.getFieldValue(0,SYSTEM_KEY));
	catalog_area.trim();

	retsoldto = (ReturnObjFromRetrieve)UtilManager.getUserCustomers(catalog_area);

	catareaRows = retcatarea.getRowCount(); 
	soldtoRows = retsoldto.getRowCount();

	if((soldtoRows==1)&& (catareaRows == 1))
	{
		ezc.ezparam.EzDefReturn ezDef = Session.isValidSalesUser();
		
		boolean DefSysKey = ezDef.ifDefSysKeyExists();
		boolean DefErpCust = ezDef.IfDefSoldToExists();
		/*if ((DefSysKey)&&(DefErpCust))
		{

		}
		else 
		{*/
			String soldTo = retsoldto.getFieldValueString(0,ERP_CUST_NUM);
	      		String catalogArea = retcatarea.getFieldValueString(0,SYSTEM_KEY);
			UtilManager.setSysKeyAndSoldTo(catalogArea,soldTo);

//added by suresh.V to set Def Bill To

	ReturnObjFromRetrieve listOfBillTos = (ReturnObjFromRetrieve) UtilManager.getListOfBillTos(soldTo);

	if(listOfBillTos != null)
		UtilManager.setDefBillTo(listOfBillTos.getFieldValueString(0,"EC_PARTNER_NO"));

///addition ends here

		//}

		defarea = (String) UtilManager.getCurrSysKey();
		defsoldto = (String) UtilManager.getUserDefErpSoldTo();

		System.out.println(">>>>>>>>DefArea:"+defarea);
		System.out.println(">>>>>>>>DefSoldto:"+defsoldto);

		for ( int c = 0 ; c < retcatarea.getRowCount(); c++ )
		{		
			String val = retcatarea.getFieldValueString(c,SYSTEM_KEY);		
			System.out.println(">>>>>>>>Syskey:"+val);

			if (val.equals(defarea)){
	        		String catArea = retcatarea.getFieldValueString(c,SYSTEM_KEY_DESCRIPTION);
				session.putValue("Country",catArea);
				System.out.println(">>>>>>>>SyskeyDefault in session:"+catArea);
				break;		
			}
		}
		
		int soldto = retsoldto.getRowCount() ;
		if ( soldto > 0 ) 
		{
			for ( int j = 0 ; j < soldto; j++ )
			{		
				String custNum = retsoldto.getFieldValueString(j,"EC_ERP_CUST_NO");
				String custName =retsoldto.getFieldValueString(j,"ECA_NAME");
				System.out.println(">>>>>>>>custNum:"+custNum+">>>"+custName);

				if(defsoldto.equals(custNum.trim()))
				{
					System.out.println(">>>>>>>>Default custNum:"+custNum+">>>"+custName);
					session.putValue("Agent",custName);
					session.putValue("AgentCode",custNum);
					break;
				}
			}
		}
		session.putValue("SalesAreaCode",defarea);
		session.putValue("welcome","1");
		//redirectfile = "ezMenuFrameset.jsp"; 
		redirectfile = "ezMain.jsp"; 
	}
	else if ((catareaRows == 1)&&(soldtoRows>1))
	{
		redirectfile = "ezSelectSoldTo.jsp"; // (REDIRECT)		
	}
	else if(catareaRows > 1)
	{
		int flag=0;
		for (int i=0;i<catareaRows;i++)
		{
			String str=retcatarea.getFieldValueString(i,SYSTEM_KEY);
			retsoldto1 = (ReturnObjFromRetrieve)UtilManager.getUserCustomers(str);
			if (retsoldto1.getRowCount()>1)
			{
				flag=1;
				break;				
			}		
		}
		if (flag==1)
		{
			redirectfile = "ezSelectSoldToFrameset.jsp"; // (REDIRECT)
		}
		else if(flag==0)
		{
			ezc.ezparam.EzDefReturn ezDef = Session.isValidSalesUser();
			boolean DefSysKey = ezDef.ifDefSysKeyExists();
			boolean DefErpCust = ezDef.IfDefSoldToExists();
			if ((DefSysKey)&&(DefErpCust))
			{
			}
			else 
			{
				String soldTo = retsoldto.getFieldValueString(0,ERP_CUST_NUM);
				String catalogArea = retcatarea.getFieldValueString(0,SYSTEM_KEY);
				UtilManager.setSysKeyAndSoldTo(catalogArea,soldTo);
			}
			defarea = (String) UtilManager.getCurrSysKey();
			defsoldto = (String) UtilManager.getUserDefErpSoldTo();
			for ( int c = 0 ; c < retcatarea.getRowCount(); c++ )
			{		
				String val = retcatarea.getFieldValueString(c,"ESKD_SYS_KEY");		
				if (val.equals(defarea )){
	        			String catArea = retcatarea.getFieldValueString(c,"ESKD_SYS_KEY_DESC");
					session.putValue("Country",catArea);
					break;		
				}
			}
			int soldto =retsoldto.getRowCount() ;
			if ( soldto > 0 ) 
			{
				for ( int j = 0 ; j < soldto; j++ )
				{		
					String custNum = retsoldto.getFieldValueString(j,"EC_ERP_CUST_NO");
					String custName =retsoldto.getFieldValueString(j,"ECA_NAME");
					if(defsoldto.equals(custNum.trim()))
					{
						session.putValue("Agent",custName);
						session.putValue("AgentCode",custNum);
						break;
					}
				}
			}	
			session.putValue("welcome","1");
			//redirectfile = "ezMenuFrameset.jsp"; // (REDIRECT)
			redirectfile = "ezMain.jsp";
		}
		
	}
	
	System.out.println("###############redirectfile"+redirectfile);
	System.out.println("redirectfile"+redirectfile);
	System.out.println("redirectfile"+redirectfile);
	System.out.println("redirectfile"+redirectfile);
	System.out.println("redirectfile"+redirectfile);
	
	response.sendRedirect(redirectfile);

%>

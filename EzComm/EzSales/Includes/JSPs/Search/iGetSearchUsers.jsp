<%@ page import="ezc.ezparam.*" %>
<%@ page import="ezc.ezparam.ReturnObjFromRetrieve" %>
<%@ page import="ezc.ezutil.csb.*" %>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session" />
<jsp:useBean id="EzWorkFlowManager" class="ezc.ezworkflow.client.EzWorkFlowManager" scope="session" />
<%!
	public Vector getListOfShipTos(String user_id,ezc.session.EzSession Session)
	{
		ezc.ezparam.ReturnObjFromRetrieve retObjMisc = null;
		ezc.ezparam.EzcParams mainParamsMisc = new ezc.ezparam.EzcParams(false);
		ezc.ezmisc.params.EziMiscParams miscParams = new ezc.ezmisc.params.EziMiscParams();
		ezc.ezmisc.client.EzMiscManager ezMiscManager = new ezc.ezmisc.client.EzMiscManager();

		String query="SELECT DISTINCT(EUD_VALUE) SHIPTO FROM EZC_USER_DEFAULTS WHERE  EUD_USER_ID='"+user_id+"' AND EUD_KEY='SHIPTOPARTY'";

		miscParams.setIdenKey("MISC_SELECT");
		miscParams.setQuery(query);
		mainParamsMisc.setLocalStore("Y");
		mainParamsMisc.setObject(miscParams);
		Session.prepareParams(mainParamsMisc);

		try
		{
			retObjMisc = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsMisc);
		}
		catch(Exception e)
		{
			ezc.ezcommon.EzLog4j.log("Exception in Getting Data"+e,"E");
		}

		Vector toDelShips = null;
		int retCnt = 0;
		if(retObjMisc!=null)
		{
			retCnt = retObjMisc.getRowCount();
			toDelShips =new Vector();
		}	
		if(retCnt>0)
		{
			for(int i=0;i<retCnt;i++)
			{
				toDelShips.add(retObjMisc.getFieldValueString(i,"SHIPTO"));
			}
		}
		return toDelShips;
	}
%>
<%
	response.setHeader("Pragma", "No-cache");
	response.setDateHeader("Expires", 0);
	response.setHeader("Cache-Control", "no-cache");

	ezc.client.EzcUtilManager UtilManagerSA = new ezc.client.EzcUtilManager(Session);

	ReturnObjFromRetrieve retcatarea = null;
	ReturnObjFromRetrieve retParentSoldTo = null;
	ReturnObjFromRetrieve retChildSoldTo = null;
	ReturnObjFromRetrieve retShipTo = null;
	ReturnObjFromRetrieve retTempSoldTo = null;
	ReturnObjFromRetrieve retPartner = null;
	ArrayList dropShips = new ArrayList();

	String[] hdrColums = {"EC_NO","EC_SYS_KEY","EC_ERP_CUST_NO","EC_BUSINESS_PARTNER","ECA_NAME","ECA_CITY","ECA_COMPANY_NAME","ECA_PHONE","ECA_EMAIL","ECA_ADDR_1","ECA_ADDR_2","ECA_ADDR_3","ECA_ADDR_4","ECA_STREET","ECA_COUNTRY","ECA_POSTAL_CODE","ECA_DISTRICT","ECA_INCOTERMS","ECA_PAYMENT_TERMS","ECA_BLOCK_CODE","ECA_ACCOUNT_GROUP","ECA_EXT1","ECA_EXT2","ECA_EXT3"};
	ReturnObjFromRetrieve retAssigSoldTo = new ReturnObjFromRetrieve(hdrColums);

	ezc.ezparam.EzcParams mainParams_S=null;
	EziMiscParams searchParams = null;
	String[] allShips =null;

	String userId 	= Session.getUserId();
	String userType	= (String)session.getValue("UserType");
	String sessionSoldTo = (String)session.getValue("AgentCode");
	String allSalesAreas = "";

	String selParent = request.getParameter("parentSol");
	if(selParent==null || "null".equalsIgnoreCase(selParent)) selParent = "";

	String selSol = request.getParameter("selSoldTo");
	if(selSol==null || "null".equalsIgnoreCase(selSol)) selSol = sessionSoldTo;

	String selShip = request.getParameter("shipTo");
	if("A".equals(selShip))
		allShips = request.getParameterValues("allShips");

	if(selShip==null || "null".equalsIgnoreCase(selShip)) selShip = (String)session.getValue("ShipCode");

	sessionSoldTo = "0000000000"+sessionSoldTo;
	sessionSoldTo = sessionSoldTo.substring(sessionSoldTo.length()-10,sessionSoldTo.length());

	//out.println("selParent:::::::::::::::::"+selParent+"::::selSol:::::"+selSol+":::::selShip::::"+selShip);

	retcatarea = (ReturnObjFromRetrieve)UtilManagerSA.getUserCatalogAreas();
	String BussPart = (String)session.getValue("BussPart");

	String appendQry="";
	if("Y".equals((String)session.getValue("IsSubUser")) || "3".equals(userType))
		appendQry = "AND EC_BUSINESS_PARTNER='"+BussPart+"'";

	if(retcatarea!=null && retcatarea.getRowCount()>0)
	{
		for(int a=0;a<retcatarea.getRowCount();a++)
		{
			if(a==0)
				allSalesAreas =  retcatarea.getFieldValueString(a,"ESKD_SYS_KEY");//EBPA_SYS_KEY
			else
				allSalesAreas = allSalesAreas+"','"+retcatarea.getFieldValueString(a,"ESKD_SYS_KEY");//EBPA_SYS_KEY
		}
	}
	if(!"3".equals(userType))
	{
		if(allSalesAreas!=null && !"".equals(allSalesAreas))
		{
			mainParams_S=new ezc.ezparam.EzcParams(true);
			searchParams = new EziMiscParams();

			//String query_S="SELECT A.EBPC_BUSS_PARTNER,C.ECA_COMPANY_NAME FROM ezc_buss_partner_config A,EZC_CUSTOMER_ADDR C WHERE  ( (A.EBPC_CATALOG_NO=0) AND (0 < (SELECT  COUNT(*) FROM EZC_BUSS_PARTNER_AREAS B  WHERE RTRIM(LTRIM(B.EBPA_BUSS_PARTNER))=  RTRIM(LTRIM(A.EBPC_BUSS_PARTNER))  AND B.EBPA_SYS_KEY IN ('"+allSalesAreas+"'))) AND C.eca_no = A.ebpc_buss_partner) OR  ((A.EBPC_CATALOG_NO!=0) AND (0 = (SELECT  COUNT(*) FROM EZC_CATALOG_GROUP C WHERE C.ECG_CATALOG_NO=A.EBPC_CATALOG_NO AND  C.ECG_SYS_KEY IN ('"+allSalesAreas+"')))) AND C.eca_no = A.ebpc_buss_partner";
			String query_S="SELECT DISTINCT(EBPC_BUSS_PARTNER), ECA_COMPANY_NAME FROM EZC_BUSS_PARTNER_CONFIG, EZC_CUSTOMER_ADDR, EZC_CUSTOMER, EZC_USERS WHERE EBPC_BUSS_PARTNER = ECA_NO AND EBPC_BUSS_PARTNER = EC_BUSINESS_PARTNER AND EBPC_BUSS_PARTNER = EU_BUSINESS_PARTNER ORDER BY ECA_COMPANY_NAME";

			searchParams.setIdenKey("MISC_SELECT");
			searchParams.setQuery(query_S);
			mainParams_S.setLocalStore("Y");
			mainParams_S.setObject(searchParams);
			Session.prepareParams(mainParams_S);

			try
			{
				retParentSoldTo = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParams_S);
			}
			catch(Exception e)
			{
				out.println("Exception in Getting Data"+e);
			}
		}
	}
	else
	{
		mainParams_S=new ezc.ezparam.EzcParams(true);
		searchParams = new EziMiscParams();

		String query_S="SELECT DISTINCT(EC_BUSINESS_PARTNER) EBPC_BUSS_PARTNER ,ECA_COMPANY_NAME  FROM EZC_CUSTOMER,EZC_CUSTOMER_ADDR WHERE EC_ERP_CUST_NO='"+sessionSoldTo+"'  AND EC_PARTNER_FUNCTION='AG' AND EC_NO=ECA_NO "+appendQry;

		searchParams.setIdenKey("MISC_SELECT");
		searchParams.setQuery(query_S);
		mainParams_S.setLocalStore("Y");
		mainParams_S.setObject(searchParams);
		Session.prepareParams(mainParams_S);

		try
		{
			retParentSoldTo = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParams_S);
		}
		catch(Exception e)
		{
			out.println("Exception in Getting Data"+e);
		}

		if(retParentSoldTo!=null && retParentSoldTo.getRowCount()>0)
			selParent=retParentSoldTo.getFieldValueString(0,"EBPC_BUSS_PARTNER");
	}

	String soldStr = selSol;
	if(selSol!=null && "A".equals(selSol))
	{
		if(selParent!=null && "".equals(selParent))
		{
			selSol = sessionSoldTo;
			soldStr = sessionSoldTo;
		}
		else
		{
			ReturnObjFromRetrieve retsoldto_A_SesGet = (ReturnObjFromRetrieve)session.getValue("retsoldto_A_Ses");
			if(retsoldto_A_SesGet!=null)
			{
				soldStr = "";
				for(int i=0;i<retsoldto_A_SesGet.getRowCount();i++)
				{
					String soldToCode_A = retsoldto_A_SesGet.getFieldValueString(i,"EC_ERP_CUST_NO");

					if("".equals(soldStr))
						soldStr = soldToCode_A;
					else
						soldStr = soldStr+"','"+soldToCode_A;
				}
			}
		}
	}
	String dropShipCode = "";
	if(selParent!=null && !"".equals(selParent))
	{
		mainParams_S = new ezc.ezparam.EzcParams(true);
		searchParams = new EziMiscParams();

		String query_S="";
		if(!"3".equals(userType))
			query_S = "SELECT DISTINCT(EC_ERP_CUST_NO),ECA_COMPANY_NAME,ECA_EXT1  FROM EZC_CUSTOMER,EZC_CUSTOMER_ADDR WHERE EC_PARTNER_FUNCTION='AG' AND EC_NO=ECA_NO AND EC_BUSINESS_PARTNER='"+selParent+"'";
		else
			query_S = "SELECT A.*, B.*,C.EC_NO,C.EC_ERP_CUST_NO,C.EC_SYS_KEY FROM EZC_USER_DEFAULTS A, EZC_CUSTOMER_ADDR B , EZC_CUSTOMER C WHERE A.EUD_USER_ID = '"+userId+"' and A.EUD_KEY = 'SOLDTOPARTY' and C.EC_BUSINESS_PARTNER = '"+(String)session.getValue("BussPart")+"' and A.EUD_DEFAULT_FLAG = 'N' and B.ECA_NO = C.EC_NO AND RTRIM(A.EUD_VALUE) = RTRIM(C.EC_ERP_CUST_NO) and A.EUD_SYS_KEY = C.EC_SYS_KEY and C.EC_SYS_KEY IN ('"+allSalesAreas+"') and C.EC_PARTNER_FUNCTION IN ('AG') and B.ECA_LANG = 'EN'";

		searchParams.setIdenKey("MISC_SELECT");
		searchParams.setQuery(query_S);
		mainParams_S.setLocalStore("Y");
		mainParams_S.setObject(searchParams);
		Session.prepareParams(mainParams_S);

		try
		{
			retChildSoldTo = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParams_S);

			Vector delSoldTos = new Vector();
			for(int i=retChildSoldTo.getRowCount()-1;i>=0;i--)
			{
				String toBeDel = retChildSoldTo.getFieldValueString(i,"EC_ERP_CUST_NO");
				String blockCode_A = retChildSoldTo.getFieldValueString(i,"ECA_EXT1");
				if(blockCode_A!=null && "BL".equalsIgnoreCase(blockCode_A))
				{
					retChildSoldTo.deleteRow(i);
				}
				else
				{
					if(delSoldTos.contains(toBeDel))
						retChildSoldTo.deleteRow(i);
					else
						delSoldTos.add(toBeDel);
				}
			}
			if(!("3".equals(userType)) && retChildSoldTo.getRowCount()>0)
			{
				soldStr = "";
				if(selSol!=null && "A".equals(selSol))
				{
					for(int rc=0;rc<retChildSoldTo.getRowCount();rc++)
					{
						String soldToCode_A = retChildSoldTo.getFieldValueString(rc,"EC_ERP_CUST_NO");

						if("".equals(soldStr))
							soldStr = soldToCode_A;
						else
							soldStr = soldStr+"','"+soldToCode_A;
					}
				}
				else
				{
					for(int rc=0;rc<retChildSoldTo.getRowCount();rc++)
					{
						String soldToCode_A = retChildSoldTo.getFieldValueString(rc,"EC_ERP_CUST_NO");

						if(selSol.equals(soldToCode_A))
						{
							soldStr = soldToCode_A;
							break;
						}
					}
					if("".equals(soldStr))
						soldStr = retChildSoldTo.getFieldValueString(0,"EC_ERP_CUST_NO");

					selSol = soldStr;
				}
			}
		}
		catch(Exception e)
		{
			out.println("Exception in Getting Data"+e);
		}

		if(retChildSoldTo!=null && retChildSoldTo.getRowCount()>0)
		{
			mainParams_S=new ezc.ezparam.EzcParams(true);
			searchParams = new EziMiscParams();

			String query_SH = "SELECT DISTINCT(EC_PARTNER_NO),ECA_COMPANY_NAME,ECA_ACCOUNT_GROUP,ECA_EXT1 FROM EZC_CUSTOMER,EZC_CUSTOMER_ADDR WHERE EC_ERP_CUST_NO IN ('"+soldStr+"') AND EC_PARTNER_FUNCTION='WE' AND EC_NO=ECA_NO "+appendQry;

			searchParams.setIdenKey("MISC_SELECT");
			searchParams.setQuery(query_SH);
			mainParams_S.setLocalStore("Y");
			mainParams_S.setObject(searchParams);
			Session.prepareParams(mainParams_S);

			try
			{
				retShipTo = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParams_S);
				if("Y".equals((String)session.getValue("IsSubUser")))
				{
					if(retShipTo!=null)
					{
						Vector delShips = (Vector)getListOfShipTos(Session.getUserId(),Session);
						for(int i=retShipTo.getRowCount()-1;i>=0;i--)
						{
							String toBeDel = retShipTo.getFieldValueString(i,"EC_PARTNER_NO");
							String blockCode_A = retShipTo.getFieldValueString(i,"ECA_EXT1");

							if(blockCode_A!=null && "BL".equalsIgnoreCase(blockCode_A))
							{
								retShipTo.deleteRow(i);
							}
							else
							{
								if(!delShips.contains(toBeDel))
									retShipTo.deleteRow(i);
							}
						}
					}
				}
				else
				{
					if(retShipTo!=null)
					{
						Vector delShips = new Vector();
						for(int i=retShipTo.getRowCount()-1;i>=0;i--)
						{
							String toBeDel = retShipTo.getFieldValueString(i,"EC_PARTNER_NO");
							String blockCode_A = retShipTo.getFieldValueString(i,"ECA_EXT1");
							if(blockCode_A!=null && "BL".equalsIgnoreCase(blockCode_A))
							{
								retShipTo.deleteRow(i);
							}
							else
							{
								if(delShips.contains(toBeDel))
									retShipTo.deleteRow(i);
								else
									delShips.add(toBeDel);
							}
						}
					}
				}
				for(int ac=0;ac<retShipTo.getRowCount();ac++)
				{
					dropShipCode = retShipTo.getFieldValueString(ac,"EC_PARTNER_NO");
					if("CPDA".equalsIgnoreCase(retShipTo.getFieldValueString(ac,"ECA_ACCOUNT_GROUP")))// || dropShipCode.endsWith("9999"))
						dropShips.add(retShipTo.getFieldValueString(ac,"EC_PARTNER_NO"));
				}
			}
			catch(Exception e)
			{
				out.println("Exception in Getting Data"+e);
			}
		}
	}
	else if(selSol!=null && !"".equals(selSol))
	{
		mainParams_S=new ezc.ezparam.EzcParams(true);
		searchParams = new EziMiscParams();

		String query_SH="SELECT DISTINCT(EC_PARTNER_NO),ECA_COMPANY_NAME,ECA_ACCOUNT_GROUP,ECA_EXT1 FROM EZC_CUSTOMER,EZC_CUSTOMER_ADDR WHERE EC_ERP_CUST_NO IN ('"+soldStr+"') AND EC_PARTNER_FUNCTION='WE' AND EC_NO=ECA_NO "+appendQry;

		searchParams.setIdenKey("MISC_SELECT");
		searchParams.setQuery(query_SH);
		mainParams_S.setLocalStore("Y");
		mainParams_S.setObject(searchParams);
		Session.prepareParams(mainParams_S);

		try
		{
			retShipTo = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParams_S);
			if("Y".equals((String)session.getValue("IsSubUser")))
			{
				if(retShipTo!=null)
				{
					Vector delShips = (Vector)getListOfShipTos(Session.getUserId(),Session);
					for(int i=retShipTo.getRowCount()-1;i>=0;i--)
					{
						String toBeDel = retShipTo.getFieldValueString(i,"EC_PARTNER_NO");
						String blockCode_A = retShipTo.getFieldValueString(i,"ECA_EXT1");
						if(blockCode_A!=null && "BL".equalsIgnoreCase(blockCode_A))
						{
							retShipTo.deleteRow(i);
						}
						else
						{
							if(!delShips.contains(toBeDel))
								retShipTo.deleteRow(i);
						}
					}
				}
			}
			else
			{
				if(retShipTo!=null)
				{
					Vector delShips = new Vector();
					for(int i=retShipTo.getRowCount()-1;i>=0;i--)
					{
						String toBeDel = retShipTo.getFieldValueString(i,"EC_PARTNER_NO");
						String blockCode_A = retShipTo.getFieldValueString(i,"ECA_EXT1");
						if(blockCode_A!=null && "BL".equalsIgnoreCase(blockCode_A))
						{
							retShipTo.deleteRow(i);
						}
						else
						{
							if(delShips.contains(toBeDel))
								retShipTo.deleteRow(i);
							else
								delShips.add(toBeDel);
						}
					}
				}
			}
			for(int ac=0;ac<retShipTo.getRowCount();ac++)
			{
				dropShipCode = retShipTo.getFieldValueString(ac,"EC_PARTNER_NO");
				if("CPDA".equalsIgnoreCase(retShipTo.getFieldValueString(ac,"ECA_ACCOUNT_GROUP")))// || dropShipCode.endsWith("9999"))
					dropShips.add(retShipTo.getFieldValueString(ac,"EC_PARTNER_NO"));
			}			
		}
		catch(Exception e)
		{
			out.println("Exception in Getting Data"+e);
		}	
		//out.println("retShipTo:::::::::::::::::"+retShipTo.toEzcString());
	}
	//out.println("retShipTo:::::::::::::::::"+dropShips);
	//out.println("retParentSoldTo:::::::::::::::::"+retParentSoldTo.toEzcString());
	//out.println("selParent:::::::::::::::::"+selParent);
%>
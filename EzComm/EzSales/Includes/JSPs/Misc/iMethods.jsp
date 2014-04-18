<%!
	public Hashtable getBackOrdNum(String webOrdNo,ezc.session.EzSession Session)
	{
		Hashtable multiBackOrdHT = null;

		ezc.ezparam.EzcParams mainParamsMisc		= new ezc.ezparam.EzcParams(false);
		ezc.ezparam.ReturnObjFromRetrieve retObjMisc 	= null;

		ezc.ezmisc.params.EziMiscParams miscParams 	= new ezc.ezmisc.params.EziMiscParams();
		ezc.ezmisc.client.EzMiscManager ezMiscManager 	= new ezc.ezmisc.client.EzMiscManager();
		miscParams.setIdenKey("MISC_SELECT");
		String query="SELECT DISTINCT(ESDI_BACK_END_ORDER) BACKEND_ORNO,ESDI_SALES_DOC FROM EZC_SALES_DOC_ITEMS WHERE ESDI_SALES_DOC IN ('"+webOrdNo+"')";

		miscParams.setQuery(query);
		mainParamsMisc.setLocalStore("Y");
		mainParamsMisc.setObject(miscParams);
		Session.prepareParams(mainParamsMisc);	

		try
		{
			retObjMisc = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsMisc);
		}
		catch(Exception e){}

		if(retObjMisc!=null && retObjMisc.getRowCount()>0)
		{
			multiBackOrdHT = new Hashtable();

			for(int i=0;i<retObjMisc.getRowCount();i++)
			{
				String sapSONum = retObjMisc.getFieldValueString(i,"BACKEND_ORNO");
				String webSONum = retObjMisc.getFieldValueString(i,"ESDI_SALES_DOC");

				if(!multiBackOrdHT.contains(webSONum))
					multiBackOrdHT.put(webSONum,(String)multiBackOrdHT.get(webSONum)+"ÿ"+sapSONum);
				else
					multiBackOrdHT.put(webSONum,sapSONum);
			}
		}
		return multiBackOrdHT;
	}
	public ReturnObjFromRetrieve getUserCustomers(String userType,String allAreas,String userId,String bussPart,ezc.session.EzSession Session)
	{
		ezc.ezparam.ReturnObjFromRetrieve retObjMisc 	= null;
		ezc.ezparam.EzcParams mainParamsMisc 		= new ezc.ezparam.EzcParams(false);

		ezc.ezmisc.params.EziMiscParams miscParams 	= new ezc.ezmisc.params.EziMiscParams();
		ezc.ezmisc.client.EzMiscManager ezMiscManager 	= new ezc.ezmisc.client.EzMiscManager();

		miscParams.setIdenKey("MISC_SELECT");

		String query = "";

		if(!"3".equals(userType))
		{
			//query = "SELECT A.EC_ERP_CUST_NO, B.ECA_NAME,B.ECA_ADDR_1,B.ECA_CITY,B.ECA_DISTRICT,B.ECA_COUNTRY,B.ECA_POSTAL_CODE,B.ECA_PHONE,B.ECA_EMAIL,B.ECA_INCOTERMS,B.ECA_EXT1 FROM EZC_CUSTOMER A, EZC_CUSTOMER_ADDR B WHERE A.EC_NO = B.ECA_NO AND B.ECA_LANG = 'EN' AND EC_SYS_KEY IN ('"+allAreas+"') AND EC_PARTNER_FUNCTION IN ('AG')";
			//query = "SELECT DISTINCT(A.EC_ERP_CUST_NO), B.ECA_NAME,B.ECA_COMPANY_NAME,B.ECA_ADDR_1,B.ECA_ADDR_2,B.ECA_CITY,B.ECA_STATE,B.ECA_PIN,B.ECA_PHONE,B.ECA_COUNTRY,B.ECA_INCOTERMS,B.ECA_PAYMENT_TERMS,B.ECA_BLOCK_CODE,B.ECA_ACCOUNT_GROUP,B.ECA_EXT1,B.ECA_EXT2,B.ECA_EXT3 FROM EZC_CUSTOMER A, EZC_CUSTOMER_ADDR B WHERE A.EC_NO = B.ECA_NO AND B.ECA_LANG = 'EN' AND EC_SYS_KEY IN ('"+allAreas+"') AND EC_PARTNER_FUNCTION IN ('AG') AND B.ECA_EXT1 <> 'BL' ORDER BY ECA_NAME";
			query = "SELECT distinct(A.EC_ERP_CUST_NO),MIN(A.EC_SYS_KEY) EC_SYS_KEY, MAX(B.ECA_NAME) ECA_NAME,MAX(B.ECA_COMPANY_NAME) ECA_COMPANY_NAME,MAX(B.ECA_ADDR_1) ECA_ADDR_1,MAX(B.ECA_ADDR_2) ECA_ADDR_2,MAX(B.ECA_CITY) ECA_CITY,MAX(B.ECA_STATE) ECA_STATE,MAX(B.ECA_PIN) ECA_PIN,MAX(B.ECA_PHONE) ECA_PHONE,MAX(B.ECA_COUNTRY) ECA_COUNTRY,MAX(B.ECA_INCOTERMS) ECA_INCOTERMS,MAX(B.ECA_PAYMENT_TERMS) ECA_PAYMENT_TERMS,MAX(B.ECA_BLOCK_CODE) ECA_BLOCK_CODE,MAX(B.ECA_ACCOUNT_GROUP) ECA_ACCOUNT_GROUP,MAX(B.ECA_EXT1) ECA_EXT1,MAX(B.ECA_EXT2) ECA_EXT2,MAX(B.ECA_EXT3) ECA_EXT3 FROM EZC_CUSTOMER A,EZC_CUSTOMER_ADDR B WHERE A.EC_NO = B.ECA_NO AND B.ECA_LANG = 'EN' AND EC_SYS_KEY IN ('"+allAreas+"') AND EC_PARTNER_FUNCTION IN ('AG') AND B.ECA_EXT1 <> 'BL' GROUP BY EC_ERP_CUST_NO ORDER BY 3";
		}
		else
		{
			//query = "SELECT A.*, B.ECA_NO,B.ECA_NAME,B.ECA_COMPANY_NAME,B.ECA_ADDR_1,B.ECA_ADDR_2,B.ECA_CITY,B.ECA_STATE,B.ECA_PIN,B.ECA_PHONE,B.ECA_COUNTRY,B.ECA_INCOTERMS,B.ECA_PAYMENT_TERMS,B.ECA_BLOCK_CODE,B.ECA_ACCOUNT_GROUP,B.ECA_EXT1,B.ECA_EXT2,B.ECA_EXT3,C.EC_NO,C.EC_ERP_CUST_NO,C.EC_SYS_KEY FROM EZC_USER_DEFAULTS A, EZC_CUSTOMER_ADDR B , EZC_CUSTOMER C WHERE A.EUD_USER_ID = '"+userId+"' and A.EUD_KEY = 'SOLDTOPARTY' and C.EC_BUSINESS_PARTNER = '"+bussPart+"' and A.EUD_DEFAULT_FLAG = 'N' and B.ECA_NO = C.EC_NO AND RTRIM(A.EUD_VALUE) = RTRIM(C.EC_ERP_CUST_NO) and A.EUD_SYS_KEY = C.EC_SYS_KEY and C.EC_SYS_KEY IN ('"+allAreas+"') and C.EC_PARTNER_FUNCTION IN ('AG') and B.ECA_LANG = 'EN'";
			//query = "SELECT C.EC_ERP_CUST_NO, B.ECA_NAME,B.ECA_COMPANY_NAME,B.ECA_ADDR_1,B.ECA_ADDR_2,B.ECA_CITY,B.ECA_STATE,B.ECA_PIN,B.ECA_PHONE,B.ECA_COUNTRY,B.ECA_INCOTERMS,B.ECA_PAYMENT_TERMS,B.ECA_BLOCK_CODE,B.ECA_ACCOUNT_GROUP,B.ECA_EXT1,B.ECA_EXT2,B.ECA_EXT3,C.EC_NO,C.EC_ERP_CUST_NO,C.EC_SYS_KEY FROM EZC_USER_DEFAULTS A, EZC_CUSTOMER_ADDR B , EZC_CUSTOMER C WHERE A.EUD_USER_ID = '"+userId+"' and A.EUD_KEY = 'SOLDTOPARTY' and C.EC_BUSINESS_PARTNER = '"+bussPart+"' and A.EUD_DEFAULT_FLAG = 'N' and B.ECA_NO = C.EC_NO AND RTRIM(A.EUD_VALUE) = RTRIM(C.EC_ERP_CUST_NO) and A.EUD_SYS_KEY = C.EC_SYS_KEY and C.EC_SYS_KEY IN ('"+allAreas+"') and C.EC_PARTNER_FUNCTION IN ('AG') and B.ECA_LANG = 'EN'";
			query = "SELECT distinct(C.EC_ERP_CUST_NO),MIN(C.EC_SYS_KEY) EC_SYS_KEY, MAX(B.ECA_NAME) ECA_NAME,MAX(B.ECA_COMPANY_NAME) ECA_COMPANY_NAME,MAX(B.ECA_ADDR_1) ECA_ADDR_1,MAX(B.ECA_ADDR_2) ECA_ADDR_2,MAX(B.ECA_CITY) ECA_CITY,MAX(B.ECA_STATE) ECA_STATE,MAX(B.ECA_PIN) ECA_PIN, MAX(B.ECA_PHONE) ECA_PHONE,MAX(B.ECA_COUNTRY) ECA_COUNTRY,MAX(B.ECA_INCOTERMS) ECA_INCOTERMS,MAX(B.ECA_PAYMENT_TERMS) ECA_PAYMENT_TERMS,MAX(B.ECA_BLOCK_CODE)ECA_BLOCK_CODE ,MAX(B.ECA_ACCOUNT_GROUP) ECA_ACCOUNT_GROUP,MAX(B.ECA_EXT1) ECA_EXT1,MAX(B.ECA_EXT2) ECA_EXT2,MAX(B.ECA_EXT3) ECA_EXT3 FROM EZC_USER_DEFAULTS A, EZC_CUSTOMER_ADDR B , EZC_CUSTOMER C WHERE A.EUD_USER_ID = '"+userId+"' and A.EUD_KEY = 'SOLDTOPARTY' and C.EC_BUSINESS_PARTNER = '"+bussPart+"' and A.EUD_DEFAULT_FLAG = 'N' and B.ECA_NO = C.EC_NO AND RTRIM(A.EUD_VALUE) = RTRIM(C.EC_ERP_CUST_NO) and A.EUD_SYS_KEY = C.EC_SYS_KEY and C.EC_SYS_KEY IN ('"+allAreas+"') and C.EC_PARTNER_FUNCTION IN ('AG') and B.ECA_LANG = 'EN' AND B.ECA_EXT1 <> 'BL'  GROUP BY EC_ERP_CUST_NO ORDER BY 3";
		}

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
		/*
		if(retObjMisc!=null && retObjMisc.getRowCount()>0)
		{
			ArrayList retsoldto_AL = new ArrayList();
			for(int i=(retObjMisc.getRowCount()-1);i>=0;i--)
			{
				String soldToCode_A = retObjMisc.getFieldValueString(i,"EC_ERP_CUST_NO");
				String blockCode_A  = retObjMisc.getFieldValueString(i,"ECA_EXT1");

				if(blockCode_A!=null && "BL".equalsIgnoreCase(blockCode_A))
				{
					retObjMisc.deleteRow(i);
				}
				else
				{
					if(!retsoldto_AL.contains(soldToCode_A))
						retsoldto_AL.add(soldToCode_A);
					else
						retObjMisc.deleteRow(i);
				}
			}
		}
		if(retObjMisc!=null && retObjMisc.getRowCount()>0)
			retObjMisc.sort(new String[]{"ECA_NAME"},true);
		*/	

		return retObjMisc;
	}
	public Vector getListOfShipTos(String user_id,ezc.session.EzSession Session)
	{
		ezc.ezparam.ReturnObjFromRetrieve retObjMisc =null;
		ezc.ezparam.EzcParams mainParamsMisc= new ezc.ezparam.EzcParams(false);

		ezc.ezmisc.params.EziMiscParams miscParams = new ezc.ezmisc.params.EziMiscParams();
		ezc.ezmisc.client.EzMiscManager ezMiscManager = new ezc.ezmisc.client.EzMiscManager();
		miscParams.setIdenKey("MISC_SELECT");
		String query="SELECT DISTINCT(EUD_VALUE) SHIPTO FROM EZC_USER_DEFAULTS WHERE  EUD_USER_ID='"+user_id+"' AND EUD_KEY='SHIPTOPARTY' ";

		miscParams.setQuery(query);
		mainParamsMisc.setLocalStore("Y");
		mainParamsMisc.setObject(miscParams);
		Session.prepareParams(mainParamsMisc);	

		try
		{
			retObjMisc = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsMisc);
		}
		catch(Exception e){}

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
	public Hashtable getCustAttrs(String custCode,ezc.session.EzSession Session)
	{
		Hashtable custAttrsHT = null;

		ezc.ezparam.EzcParams mainParamsMisc		= new ezc.ezparam.EzcParams(false);
		ezc.ezparam.ReturnObjFromRetrieve retObjMisc 	= null;

		ezc.ezmisc.params.EziMiscParams miscParams 	= new ezc.ezmisc.params.EziMiscParams();
		ezc.ezmisc.client.EzMiscManager ezMiscManager 	= new ezc.ezmisc.client.EzMiscManager();
		miscParams.setIdenKey("MISC_SELECT");
		String query="SELECT DISTINCT(EC_SYS_KEY),(SELECT ECAD_VALUE FROM EZC_CAT_AREA_DEFAULTS WHERE ECAD_SYS_KEY=EC_SYS_KEY AND ECAD_KEY='SALESORG') SALESORG,ECA_PROD_ATTRS FROM EZC_CUSTOMER, EZC_CUSTOMER_ADDR WHERE EC_NO=ECA_NO AND EC_PARTNER_NO='"+custCode+"' AND EC_PARTNER_FUNCTION='WE' AND ECA_LANG='EN' AND ECA_PROD_ATTRS IS NOT NULL AND ECA_EXT1<>'BL'";

		miscParams.setQuery(query);
		mainParamsMisc.setLocalStore("Y");
		mainParamsMisc.setObject(miscParams);
		Session.prepareParams(mainParamsMisc);	

		try
		{
			retObjMisc = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsMisc);
		}
		catch(Exception e){}

		if(retObjMisc!=null && retObjMisc.getRowCount()>0)
		{
			custAttrsHT = new Hashtable();

			for(int i=0;i<retObjMisc.getRowCount();i++)
			{
				String sysKey = retObjMisc.getFieldValueString(i,"SALESORG");
				String prdAttr = retObjMisc.getFieldValueString(i,"ECA_PROD_ATTRS");

				custAttrsHT.put(sysKey,prdAttr);
			}
		}
		return custAttrsHT;
	}
%>
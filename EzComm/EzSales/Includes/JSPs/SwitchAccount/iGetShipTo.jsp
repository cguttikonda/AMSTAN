<%!
	public Vector getListOfShipTos(String user_id,String sysKey,ezc.session.EzSession Session,String bussPart)
	{
		

		ezc.ezparam.ReturnObjFromRetrieve retObjMisc =null;
		ezc.ezparam.EzcParams mainParamsMisc= new ezc.ezparam.EzcParams(false);
		
		ezc.ezmisc.params.EziMiscParams miscParams = new ezc.ezmisc.params.EziMiscParams();
		ezc.ezmisc.client.EzMiscManager ezMiscManager = new ezc.ezmisc.client.EzMiscManager();
		miscParams.setIdenKey("MISC_SELECT");
		//String query="SELECT A.*, B.ECA_NO, B.ECA_NAME, B.ECA_COMPANY_NAME,B.ECA_ERP_UPDATE_FLAG, B.ECA_PHONE, B.ECA_ADDR_2,B.ECA_ADDR_1,B.ECA_CITY,B.ECA_STATE,B.ECA_PIN,B.ECA_COUNTRY,B.ECA_TRANSORT_ZONE,B.ECA_JURISDICTION_CODE,B.ECA_LANG,B.ECA_EMAIL,B.ECA_WEB_ADDR FROM EZC_CUSTOMER A , EZC_CUSTOMER_ADDR B WHERE  A.EC_PARTNER_FUNCTION IN ('WE') AND A.EC_PARTNER_NO IN (SELECT DISTINCT(EECD_DEFAULTS_VALUE) FROM EZC_ERP_CUSTOMER_DEFAULTS WHERE EECD_NO IN (SELECT EUD_VALUE FROM EZC_USER_DEFAULTS WHERE EUD_USER_ID='"+user_id+"' AND EUD_KEY='SOLDTOPARTY' ) AND EECD_DEFAULTS_KEY='SHIPTO' AND EECD_USER_ID='"+user_id+"') AND B.ECA_LANG = 'EN' AND A.EC_NO = B.ECA_NO AND EC_SYS_KEY='"+sysKey+"' AND EC_BUSINESS_PARTNER='"+bussPart+"'";
		String query="SELECT DISTINCT(EUD_VALUE) SHIPTO FROM EZC_USER_DEFAULTS WHERE  EUD_USER_ID='"+user_id+"' AND EUD_KEY='SHIPTOPARTY' ";

		miscParams.setQuery(query);
		mainParamsMisc.setLocalStore("Y");
		mainParamsMisc.setObject(miscParams);
		Session.prepareParams(mainParamsMisc);	

		try
		{		
			ezc.ezcommon.EzLog4j.log("miscParams.getQuery()::::::::"+miscParams.getQuery() ,"I");
			retObjMisc = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsMisc);
			
		}
		catch(Exception e)
		{
			ezc.ezcommon.EzLog4j.log("Exception in Getting Data"+e,"E");
		}
		Vector toDelShips = null;
		int retCnt = 0;
		if(retObjMisc!=null){
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
	public ReturnObjFromRetrieve getListOfShipTos(String custNO,String busPartner,ezc.session.EzSession Session)
	{
		

		ezc.ezparam.ReturnObjFromRetrieve retObjMisc =null;
		ezc.ezparam.EzcParams mainParamsMisc= new ezc.ezparam.EzcParams(false);
		
		ezc.ezmisc.params.EziMiscParams miscParams = new ezc.ezmisc.params.EziMiscParams();
		ezc.ezmisc.client.EzMiscManager ezMiscManager = new ezc.ezmisc.client.EzMiscManager();
		miscParams.setIdenKey("MISC_SELECT");
		String appendQuery = "A.EC_BUSINESS_PARTNER = '"+busPartner+"' AND ";
		appendQuery = "";

		//String query="SELECT A.*, B.* FROM EZC_CUSTOMER A , EZC_CUSTOMER_ADDR B WHERE A.EC_PARTNER_FUNCTION in ('WE') and A.EC_ERP_CUST_NO = '"+custNO+"' AND "+appendQuery+" AND B.ECA_LANG = 'EN' and A.EC_NO = B.ECA_NO AND ECA_ACCOUNT_GROUP NOT IN ('CPDA')";
		String query="Select A.*, B.* from EZC_CUSTOMER A , EZC_CUSTOMER_ADDR B where  A.EC_PARTNER_FUNCTION in ('WE') and A.EC_ERP_CUST_NO = '"+custNO+"' AND "+appendQuery+" B.ECA_LANG = 'EN' and A.EC_NO = B.ECA_NO";

		miscParams.setQuery(query);
		mainParamsMisc.setLocalStore("Y");
		mainParamsMisc.setObject(miscParams);
		Session.prepareParams(mainParamsMisc);	

		try
		{		
			ezc.ezcommon.EzLog4j.log("miscParams.getQuery()::::::::"+miscParams.getQuery() ,"I");
			retObjMisc = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsMisc);

			ArrayList retshipto_AL = new ArrayList();
			for(int i=(retObjMisc.getRowCount()-1);i>=0;i--)
			{
				String shipToCode_A = retObjMisc.getFieldValueString(i,"EC_PARTNER_NO");
				String blockCode_A  = retObjMisc.getFieldValueString(i,"ECA_EXT1");

				if(blockCode_A!=null && "BL".equalsIgnoreCase(blockCode_A))
				{
					retObjMisc.deleteRow(i);
				}
				else
				{
					if(!retshipto_AL.contains(shipToCode_A))
						retshipto_AL.add(shipToCode_A);
					else
						retObjMisc.deleteRow(i);
				}
			}
		}
		catch(Exception e)
		{
			ezc.ezcommon.EzLog4j.log("Exception in Getting Data"+e,"E");
		}		
		return retObjMisc;
	}
%>
<%
	/********************************************************************************
	*										*
	*	Declare variables "catalog_areaSA" for syskeys and "selSoldToSA"	*
	*	for sold To's where ever this page is included.				*
	*										*
	********************************************************************************/

	/*
	Here we are removing blocked ship to accounts and duplicate accounts from retObj
	Added by Chaitaanya H on 23rd Jan 2013
	*/

	UtilManager.setSysKeyAndSoldTo(catalog_areaSA,selSoldToSA);
	ReturnObjFromRetrieve  listShipTosCS =null;
	if(!"Y".equals((String)session.getValue("IsSubUser")))
	{
		//listShipTosCS = (ReturnObjFromRetrieve)UtilManager.getListOfShipTos(selSoldToSA);
		listShipTosCS = (ReturnObjFromRetrieve)getListOfShipTos(selSoldToSA,(String)session.getValue("BussPart"),Session);
		ezc.ezcommon.EzLog4j.log("<<<SHIP TOS>>>>>>>>"+listShipTosCS.toEzcString(),"I");
	}
	else
	{
		Vector delShips = (Vector)getListOfShipTos(Session.getUserId(),catalog_areaSA,Session,(String)session.getValue("BussPart"));
		//listShipTosCS = (ReturnObjFromRetrieve)UtilManager.getListOfShipTos(selSoldToSA);
		listShipTosCS = (ReturnObjFromRetrieve)getListOfShipTos(selSoldToSA,(String)session.getValue("BussPart"),Session);
		//out.println(delShips);
		//out.println(listShipTosCS.toEzcString());
		ezc.ezcommon.EzLog4j.log("<<<SHIP TOS>>>>>>>>"+listShipTosCS.toEzcString(),"I");
		if(delShips.size()>0)
		{
			for(int i=listShipTosCS.getRowCount()-1;i>=0;i--)
			{
				String toBeDel = listShipTosCS.getFieldValueString(i,"EC_PARTNER_NO");
				String blockCode_A  = listShipTosCS.getFieldValueString(i,"ECA_EXT1");

				if(blockCode_A!=null && "BL".equalsIgnoreCase(blockCode_A))
				{
					listShipTosCS.deleteRow(i);
				}
				else
				{
					if(!delShips.contains(toBeDel))
						listShipTosCS.deleteRow(i);
				}
			}
		}
	}
	if(listShipTosCS!=null)
		listShipTosCS.sort(new String[]{"EC_PARTNER_NO"},true);

	UtilManager.setSysKeyAndSoldTo((String)session.getValue("SalesAreaCode"),(String)session.getValue("AgentCode"));
%>

<%
	long start = System.currentTimeMillis();
%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="ezc.ezadmin.ezadminutils.params.*" %>
<%//@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezInboxBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezGlobalBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezWorkFlow.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iAddWebStats.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iMethods.jsp"%>
<jsp:useBean id="UManager" class="ezc.client.EzUserAdminManager" scope="session" />
<jsp:useBean id="ConfigManager" class="ezc.client.EzSystemConfigManager" scope="session"/>
<%@ page import="ezc.personalization.params.EzcPersonalizationParams" %>
<%@ page import="ezc.personalization.params.EziPersonalizationParams" %>

<%@ page import="ezc.ezmisc.params.*" %>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<jsp:useBean id="EzcPersonalizationManager" class="ezc.personalization.client.EzcPersonalizationManager"/>
<jsp:useBean id="EzWorkFlowManager" class="ezc.ezworkflow.client.EzWorkFlowManager" scope="session" />

<html>
<head>
<%
	//This code for Language indipendent

	String lang = (String)session.getValue("userLang"); 
	if(lang==null || "null".equals(lang))
	{
		lang ="ENGLISH";
	}
        if(lang.equals("GERMANY"))
 	{
       		java.util.Locale l = new java.util.Locale("de","DE");
       		session.putValue("LOCALE",l);
 	}
 	else if(lang.equals("ENGLISH"))
 	{
		java.util.Locale l = new java.util.Locale("en","US");
		session.putValue("LOCALE",l);
 	}
 	else
 	{
		java.util.Locale l = new java.util.Locale("de","DE");
		session.putValue("LOCALE",l);
  	}
  	
	//This code for Globel date,currency format's
	EzGlobal.setDateFormat("MM/dd/yyyy");
	EzGlobal.setLocale((java.util.Locale)session.getValue("LOCALE"));
	EzGlobal.setCurrencySymbol("$");
	EzGlobal.setIsPreSymbol(true);
	EzGlobal.setIsSymbolRequired(false);
	//End of Global

	//To put UserRole(from UserDefualts)  into session
	
	ezc.ezparam.EzcUserParams uparams= new ezc.ezparam.EzcUserParams();
	EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
	ezcUserNKParams.setLanguage("EN");
	ezcUserNKParams.setSys_Key("0");
	uparams.createContainer();
	uparams.setUserId(Session.getUserId());
	uparams.setObject(ezcUserNKParams);
	Session.prepareParams(uparams);

	ReturnObjFromRetrieve retobj = (ReturnObjFromRetrieve)(UManager.getAddUserDefaults(uparams));

	//retobj.toEzcString();

	String userStyle=null;
	String userRole=null;
	String userGroup=null;
	String salesOffice=null;
	String isSubUser = null;
	String userStatus = null;
	String suAuth = null;
	String viewAllCust = null;
	String soldTo = null;
	String shipTo = null;
	String SalesAreaCode = null;
	String tempSalesArea = "";
	String poProgType = "";
	String salesRepRes = "";
	String showImages = "";
	String exclMat = "";
	String salesUserSoldTos = "";

	for(int i=0;i<retobj.getRowCount();i++)
	{
		if("STYLE".equals(retobj.getFieldValueString(i,"EUD_KEY")))
		{
			userStyle=retobj.getFieldValueString(i,"EUD_VALUE");
		}
		if("USERROLE".equals(retobj.getFieldValueString(i,"EUD_KEY")))
		{
			userRole=retobj.getFieldValueString(i,"EUD_VALUE");
		}
		if("USERGROUP".equals(retobj.getFieldValueString(i,"EUD_KEY")))
		{
			//userGroup=retobj.getFieldValueString(i,"EUD_VALUE");
		}
		if("SALESOFFICE".equals(retobj.getFieldValueString(i,"EUD_KEY")))
		{
			salesOffice=retobj.getFieldValueString(i,"EUD_VALUE");
		}
		if("ISSUBUSER".equals(retobj.getFieldValueString(i,"EUD_KEY")))
		{
			isSubUser=retobj.getFieldValueString(i,"EUD_VALUE");
		}
		if("STATUS".equals(retobj.getFieldValueString(i,"EUD_KEY")))
		{
			userStatus=retobj.getFieldValueString(i,"EUD_VALUE");
		}
		if("SUAUTH".equals(retobj.getFieldValueString(i,"EUD_KEY")))
		{
			suAuth=retobj.getFieldValueString(i,"EUD_VALUE");
		}
		if("VIEWALLCUST".equals(retobj.getFieldValueString(i,"EUD_KEY")))
		{
			viewAllCust=retobj.getFieldValueString(i,"EUD_VALUE");
		}
		if("C_ERPSOLDTO".equals(retobj.getFieldValueString(i,"EUD_KEY")))
		{
			soldTo=retobj.getFieldValueString(i,"EUD_VALUE");
		}
		if("C_USERSYSTEMKEY".equals(retobj.getFieldValueString(i,"EUD_KEY")))
		{
			SalesAreaCode=retobj.getFieldValueString(i,"EUD_VALUE");
		}
		if("SOLDTOPARTY".equals(retobj.getFieldValueString(i,"EUD_KEY")))
		{
			tempSalesArea=retobj.getFieldValueString(0,"EUD_SYS_KEY");
		}
		if("POPROGTYPE".equals(retobj.getFieldValueString(i,"EUD_KEY")))
		{
			poProgType=retobj.getFieldValueString(i,"EUD_VALUE");
		}
		if("SALESREPRES".equals(retobj.getFieldValueString(i,"EUD_KEY")))
		{
			salesRepRes=retobj.getFieldValueString(i,"EUD_VALUE");
		}
		if("SHOWIMAGES".equals(retobj.getFieldValueString(i,"EUD_KEY")))
		{
			showImages=retobj.getFieldValueString(i,"EUD_VALUE");
		}
		if("EXCLUSIVE_MAT".equals(retobj.getFieldValueString(i,"EUD_KEY")))
		{
			exclMat=retobj.getFieldValueString(i,"EUD_VALUE");
		}
	}

	if("RE".equals(userRole))
	{
		userRole = "CU";
		session.putValue("REPAGENCY","Y");
	}
	else
		session.putValue("REPAGENCY","N");

	if(showImages==null || "null".equals(showImages) || "".equals(showImages)) showImages="N";
	if(exclMat==null || "null".equals(exclMat) || "".equals(exclMat.trim())) exclMat="N";

	//this Method is used to get the userGroup for ALL

	if("CM".equals(userRole) || "LF".equals(userRole) || "CU".equals(userRole))
	{
		ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziWorkGroupsParams params= new ezc.ezworkflow.params.EziWorkGroupsParams();
		params.setUserId(Session.getUserId());
		mainParams.setObject(params);
		Session.prepareParams(mainParams);
	
		ezc.ezparam.ReturnObjFromRetrieve ret=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlow.getWorkGroupsList(mainParams);

		java.util.ArrayList aGroups=new java.util.ArrayList();
		if(ret!=null && ret.getRowCount()>0)
		{
			int retCount = ret.getRowCount();
			userGroup = ret.getFieldValueString(0,"GROUP_ID");
			tempSalesArea = ret.getFieldValueString(0,"SYSKEY");
			if(retCount>1)
			{
				for(int p=1;p<retCount;p++)
					aGroups.add(ret.getFieldValueString(p,"GROUP_ID"));
			}
			session.putValue("AGROUPS",aGroups);
		}
		//ezc.ezcommon.EzLog4j.log("ret:::::::"+ret.toEzcString(),"D");
	}

	//method ends here

	session.putValue("UserGroup",userGroup);	
	

	EzcParams mainParamsMisc= new EzcParams(false);
	EziMiscParams miscParams = new EziMiscParams();

	/********** This code is to pull all the soldTos assigned with the super User for AMSTAN *****/
	if("CU".equals(userRole))
	{
		mainParamsMisc= new EzcParams(false);
		miscParams = new EziMiscParams();
		ReturnObjFromRetrieve allSodToRet = null;
		
		miscParams.setIdenKey("MISC_SELECT");
		miscParams.setQuery("SELECT DISTINCT(EUD_VALUE) SOLDTO FROM EZC_USER_DEFAULTS WHERE EUD_KEY IN ('SOLDTOPARTY') AND EUD_USER_ID='"+Session.getUserId()+"'");

		mainParamsMisc.setLocalStore("Y");
		mainParamsMisc.setObject(miscParams);
		Session.prepareParams(mainParamsMisc);	
		try
		{		
			allSodToRet = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsMisc);
		}
		catch(Exception e){}	
		if(allSodToRet!=null && allSodToRet.getRowCount()>0)
		{
			for(int s=0;s<allSodToRet.getRowCount();s++)
			{
				if(s==0)	
					salesUserSoldTos = allSodToRet.getFieldValueString(s,"SOLDTO");
				else
					salesUserSoldTos = salesUserSoldTos+"¥"+allSodToRet.getFieldValueString(s,"SOLDTO");
			}
		}
	}	
	//ezc.ezcommon.EzLog4j.log("salesUserSoldTos::::::"+salesUserSoldTos,"D");
	session.putValue("SOLDTO_SUPER",salesUserSoldTos);
	/********** This code is to pull all the soldTos assigned with the super User for AMSTAN *****/
	
	
	ReturnObjFromRetrieve retObjMisc = null;
	int countMisc=0;
		
	miscParams.setIdenKey("MISC_SELECT");
	miscParams.setQuery("SELECT EUD_USER_ID,EUD_KEY,EUD_VALUE FROM EZC_USER_DEFAULTS WHERE EUD_KEY IN ('C_USERSYSTEMKEY','C_ERPSOLDTO','C_ERPSHIPTO') AND EUD_USER_ID='"+Session.getUserId()+"'");

	mainParamsMisc.setLocalStore("Y");
	mainParamsMisc.setObject(miscParams);
	Session.prepareParams(mainParamsMisc);	

	try
	{		
		retObjMisc = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsMisc);
	}
	catch(Exception e){}
	
	
		
	if(retObjMisc!=null)
		countMisc = retObjMisc.getRowCount();

	boolean defVals = false;

	if(countMisc<3)
		defVals = true;

	if(countMisc>0 && !defVals)
	{
		/*String value0 = retObjMisc.getFieldValueString(0,"EUD_VALUE");
		String value1 = retObjMisc.getFieldValueString(1,"EUD_VALUE");
		String value2 = retObjMisc.getFieldValueString(2,"EUD_VALUE");*/
		ezc.ezcommon.EzLog4j.log("countMisc::::::::::::::"+countMisc,"D");
		for(int i=0;i<countMisc;i++)
		{
			String value0 = retObjMisc.getFieldValueString(i,"EUD_VALUE");
			ezc.ezcommon.EzLog4j.log("value0::::::::::::::"+value0,"D");
			if("".equals(value0) || "null".equals(value0))
			{
				defVals = true;
				break;
			}
		}
		if(!defVals)
		{
			String defSoldTo = "",defShipTo = "";
			for(int i=0;i<countMisc;i++)
			{
				String defKey = retObjMisc.getFieldValueString(i,"EUD_KEY");

				if("C_ERPSOLDTO".equals(defKey))
					defSoldTo = retObjMisc.getFieldValueString(i,"EUD_VALUE");
				if("C_ERPSHIPTO".equals(defKey))
					defShipTo = retObjMisc.getFieldValueString(i,"EUD_VALUE");
			}
			ReturnObjFromRetrieve retObjBlck = null;

			miscParams.setIdenKey("MISC_SELECT");
			miscParams.setQuery("SELECT DISTINCT(EC_PARTNER_NO),ECA_BLOCK_CODE,ECA_EXT1 FROM EZC_CUSTOMER,EZC_CUSTOMER_ADDR WHERE EC_NO=ECA_NO AND EC_PARTNER_FUNCTION='AG' AND EC_PARTNER_NO='"+defSoldTo+"' AND (ECA_EXT1!='BL' AND ECA_BLOCK_CODE NOT IN ('01','05'))");

			mainParamsMisc.setLocalStore("Y");
			mainParamsMisc.setObject(miscParams);
			Session.prepareParams(mainParamsMisc);	

			try
			{
				retObjBlck = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsMisc);
			}
			catch(Exception e){}

			if(retObjBlck!=null && retObjBlck.getRowCount()>0)
			{
				miscParams.setIdenKey("MISC_SELECT");
				miscParams.setQuery("SELECT DISTINCT(EC_PARTNER_NO),ECA_BLOCK_CODE,ECA_EXT1 FROM EZC_CUSTOMER,EZC_CUSTOMER_ADDR WHERE EC_NO=ECA_NO AND EC_PARTNER_FUNCTION='WE' AND EC_PARTNER_NO='"+defShipTo+"' AND (ECA_EXT1!='BL' AND ECA_BLOCK_CODE NOT IN ('01','05'))");

				mainParamsMisc.setLocalStore("Y");
				mainParamsMisc.setObject(miscParams);
				Session.prepareParams(mainParamsMisc);	

				try
				{
					retObjBlck = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsMisc);
				}
				catch(Exception e){}

				if(retObjBlck!=null && retObjBlck.getRowCount()==0)
					defVals = true;
			}
			else
				defVals = true;
		}
		ezc.ezcommon.EzLog4j.log("defVals::::::::::::::"+defVals,"D");
	}

	boolean salesArea_A = false;
	boolean soldTo_A = false;
	boolean shipTo_A = false;
	ReturnObjFromRetrieve rettempsoldto =null;
	ArrayList desiredSteps=new ArrayList();
	if("CM".equals(userRole))
		desiredSteps.add("1");	
	ezc.ezparam.EzcParams mainShipParams = null;
	EziMiscParams shipParams = null;	
		
	ezc.ezcommon.EzLog4j.log("countMisc::::::::::::::"+countMisc,"D");
	ezc.ezcommon.EzLog4j.log("userRole::::::::::::::"+userRole,"D");
	ezc.ezcommon.EzLog4j.log("userGroup::::::::::::::"+userGroup,"D");
	ezc.ezcommon.EzLog4j.log("defVals::::::::::::::"+defVals,"D");
	if((defVals || countMisc==0) && "CM".equals(userRole))
	{
		ezc.ezcommon.EzLog4j.log("tempSalesArea: in IFFFF:::::::::::::"+tempSalesArea,"D");
		if(!"".equals(tempSalesArea) && !"null".equals(tempSalesArea))
		{
			//Starts
			ezc.ezparam.EzcParams mainParamsu = new ezc.ezparam.EzcParams(false);
			ezc.ezworkflow.params.EziWFParams paramsu= new ezc.ezworkflow.params.EziWFParams();
			paramsu.setTemplate((String)session.getValue("Templet"));
			paramsu.setSyskey(tempSalesArea); //999602
			paramsu.setPartnerFunction("AG");
			paramsu.setParticipant((String)session.getValue("UserGroup"));
			paramsu.setDesiredSteps(desiredSteps);
			mainParamsu.setObject(paramsu);
			Session.prepareParams(mainParamsu);
			try
			{
				rettempsoldto =(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWorkFlowUsers(mainParamsu);
			}
			catch(Exception e)
			{
				ezc.ezcommon.EzLog4j.log("Exception in rettempsoldto:::::::"+e,"D");
			}
			//Ends	
			//ezc.ezcommon.EzLog4j.log("rettempsoldto:::::::"+rettempsoldto.toEzcString(),"D");
			ezc.ezcommon.EzLog4j.log("rettempsoldto.getRowCount():::::::"+rettempsoldto.getRowCount(),"D");
		}
		else
		{
			
			response.sendRedirect("invalidArea.jsp");
		}
		
		
	}
	else if((defVals || countMisc==0) && "CU".equals(userRole))
	{
		mainShipParams = new EzcParams(true);
		shipParams     = new EziMiscParams();
		ezc.ezcommon.EzLog4j.log("defVals:::::::"+defVals,"D");
		
		shipParams.setIdenKey("MISC_SELECT");
		String query_SH="SELECT EUD_VALUE EC_ERP_CUST_NO,EUD_SYS_KEY FROM EZC_USER_DEFAULTS where EUD_USER_ID='"+Session.getUserId()+"' and EUD_KEY='SOLDTOPARTY'";
		shipParams.setQuery(query_SH);

		mainShipParams.setLocalStore("Y");
		mainShipParams.setObject(shipParams);
		Session.prepareParams(mainShipParams);
		try
		{
			rettempsoldto = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainShipParams);
			tempSalesArea = rettempsoldto.getFieldValueString(0,"EUD_SYS_KEY");

		}
		catch(Exception e)
		{
			out.println("Exception in Getting Data"+e);
		}			
	
	}
	
	ReturnObjFromRetrieve retShipTo = null;
	if(rettempsoldto!=null && rettempsoldto.getRowCount()>0)
	{
		//ezc.ezcommon.EzLog4j.log("rettempsoldto:::::::"+rettempsoldto.toEzcString(),"D");
		if(defVals)
		{
			mainShipParams = new EzcParams(true);
			shipParams     = new EziMiscParams();
			
			shipParams.setIdenKey("MISC_DELETE");
			String query_D="DELETE FROM EZC_USER_DEFAULTS where EUD_USER_ID='"+Session.getUserId()+"' and EUD_KEY IN ('C_USERSYSTEMKEY','C_ERPSOLDTO','C_ERPSHIPTO')";
			shipParams.setQuery(query_D);

			mainShipParams.setLocalStore("Y");
			mainShipParams.setObject(shipParams);
			Session.prepareParams(mainShipParams);
			try
			{
				ezMiscManager.ezDelete(mainShipParams);
			}
			catch(Exception e)
			{
				ezc.ezcommon.EzLog4j.log("Exception in Getting Data"+e,"E");
			}		
		}	

		String soldToAll = "";
		for(int so=0;so<rettempsoldto.getRowCount();so++)
		{
			if("".equals(soldToAll))
				soldToAll = rettempsoldto.getFieldValueString(so,"EC_ERP_CUST_NO");
			else
				soldToAll = soldToAll+"','"+rettempsoldto.getFieldValueString(so,"EC_ERP_CUST_NO");
		}
		mainShipParams = new EzcParams(true);
		shipParams     = new EziMiscParams();

		shipParams.setIdenKey("MISC_SELECT");
		String query_D="SELECT DISTINCT(EC_PARTNER_NO),ECA_COMPANY_NAME FROM EZC_CUSTOMER,EZC_CUSTOMER_ADDR WHERE EC_NO=ECA_NO AND EC_SYS_KEY NOT IN ('999701','999702','999704') AND EC_ERP_CUST_NO IN ('"+soldToAll+"') AND EC_PARTNER_FUNCTION='AG' AND (ECA_EXT1!='BL' AND ECA_BLOCK_CODE NOT IN ('01','05'))";
		shipParams.setQuery(query_D);

		mainShipParams.setLocalStore("Y");
		mainShipParams.setObject(shipParams);
		Session.prepareParams(mainShipParams);
		try
		{
			retShipTo = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainShipParams);
		}
		catch(Exception e){}

		//soldTo = rettempsoldto.getFieldValueString(0,"EC_ERP_CUST_NO");
		soldTo = retShipTo.getFieldValueString(0,"EC_PARTNER_NO");
		soldTo_A = true;
		ezc.ezcommon.EzLog4j.log("soldTo:::::::"+soldTo,"D");
		
		mainShipParams = new EzcParams(true);
		shipParams     = new EziMiscParams();
		
		shipParams.setIdenKey("MISC_SELECT");
		String query_SH="SELECT DISTINCT(EC_PARTNER_NO),ECA_COMPANY_NAME FROM EZC_CUSTOMER,EZC_CUSTOMER_ADDR WHERE EC_ERP_CUST_NO='"+soldTo+"' AND EC_PARTNER_FUNCTION='WE' AND EC_NO=ECA_NO AND (ECA_EXT1!='BL' AND ECA_BLOCK_CODE NOT IN ('01','05'))";
		shipParams.setQuery(query_SH);

		mainShipParams.setLocalStore("Y");
		mainShipParams.setObject(shipParams);
		Session.prepareParams(mainShipParams);
		try
		{
			retShipTo = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainShipParams);
		}
		catch(Exception e)
		{
			out.println("Exception in Getting Data"+e);
		}
		if(retShipTo!=null && retShipTo.getRowCount()>0)
		{
			shipTo=retShipTo.getFieldValueString(0,"EC_PARTNER_NO");
			shipTo_A = true;
			if(tempSalesArea!=null && !"".equals(tempSalesArea))
			{
				SalesAreaCode = tempSalesArea;
				salesArea_A = true;
			}	
			String ConnGroup = (String)session.getValue("Site");
			Connection con = null;
			Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");
			java.util.ResourceBundle mySite= java.util.ResourceBundle.getBundle("Site");
			con=DriverManager.getConnection(mySite.getString("ConnectString_"+ConnGroup),mySite.getString("UserId_"+ConnGroup),mySite.getString("Password_"+ConnGroup));
			java.sql.Statement stmt= null;
			try {
				con.setAutoCommit(false);
				stmt= con.createStatement();

			
				stmt.addBatch("INSERT INTO EZC_USER_DEFAULTS VALUES ('"+Session.getUserId()+"','NOT','NULL','C_ERPSOLDTO','"+soldTo+"','H','N')");
				stmt.addBatch("INSERT INTO EZC_USER_DEFAULTS VALUES ('"+Session.getUserId()+"','NOT','NULL','C_USERSYSTEMKEY','"+SalesAreaCode+"','H','N')");
				stmt.addBatch("INSERT INTO EZC_USER_DEFAULTS VALUES ('"+Session.getUserId()+"','NOT','NULL','C_ERPSHIPTO','"+shipTo+"','H','N')");

				int[] updCnt = stmt.executeBatch();
				con.commit();
				ezc.ezcommon.EzLog4j.log("updCnt::::::::::::"+updCnt.length,"D");

				} catch (BatchUpdateException be) {

					//handle batch update exception
					int[] counts = be.getUpdateCounts();
					for (int i=0; i<counts.length; i++) {
						ezc.ezcommon.EzLog4j.log("Statement["+i+"] :"+counts[i],"D");
					}
					con.rollback();
				}
				catch (SQLException e) {

					//handle SQL exception
					con.rollback();
				}
				finally
				{
					if(stmt!=null)
					{
						stmt.close();
						con.close();
					}
				}

			
			//ezc.ezcommon.EzLog4j.log("retShipTo:::::::"+retShipTo.toEzcString(),"D");
			
		}
		
		miscParams.setIdenKey("MISC_SELECT");
		miscParams.setQuery("SELECT EUD_USER_ID,EUD_KEY,EUD_VALUE FROM EZC_USER_DEFAULTS WHERE EUD_KEY IN ('C_USERSYSTEMKEY','C_ERPSOLDTO','C_ERPSHIPTO') AND EUD_USER_ID='"+Session.getUserId()+"'");

		mainParamsMisc.setLocalStore("Y");
		mainParamsMisc.setObject(miscParams);
		Session.prepareParams(mainParamsMisc);	

		try
		{		
			retObjMisc = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsMisc);
		}
		catch(Exception e){}

		if(retObjMisc!=null)
			countMisc = retObjMisc.getRowCount();		
	}
	ezc.ezcommon.EzLog4j.log("tempSalesArea:::::::"+tempSalesArea,"D");
		
	if(countMisc>0)
	{
		for(int i=0;i<countMisc;i++)
		{
			if("C_ERPSOLDTO".equals(retObjMisc.getFieldValueString(i,"EUD_KEY")))
			{
				soldTo=retObjMisc.getFieldValueString(i,"EUD_VALUE");
				ezc.ezcommon.EzLog4j.log("C_ERPSOLDTO:::::::"+soldTo,"D");
				soldTo_A = true;
				try
				{
					soldTo = Long.parseLong(soldTo)+"";
					soldTo = "0000000000"+soldTo;
					soldTo = soldTo.substring((soldTo.length()-10),soldTo.length());
				}
				catch(Exception ex){soldTo = soldTo;}	
			}
			if("C_USERSYSTEMKEY".equals(retObjMisc.getFieldValueString(i,"EUD_KEY")))
			{
				SalesAreaCode=retObjMisc.getFieldValueString(i,"EUD_VALUE");
				ezc.ezcommon.EzLog4j.log("C_USERSYSTEMKEY:::::::"+SalesAreaCode,"D");
				salesArea_A = true;
			}
			if("C_ERPSHIPTO".equals(retObjMisc.getFieldValueString(i,"EUD_KEY")))
			{
				shipTo=retObjMisc.getFieldValueString(i,"EUD_VALUE");
				ezc.ezcommon.EzLog4j.log("C_ERPSHIPTO:::::::"+shipTo,"D");
				shipTo_A = true;
				try
				{
					shipTo = Long.parseLong(shipTo)+"";
					shipTo = "0000000000"+shipTo;
					shipTo = shipTo.substring((shipTo.length()-10),shipTo.length());
				}
				catch(Exception ex){shipTo = soldTo;}
			}
		}
	}

	//soldTo = "0102400000";
	//SalesAreaCode = "999001";
	//shipTo = "0102400001";
	
	//Commision Group Start
	
	EzcParams mainParamsMisc_CD= new EzcParams(false);
	EziMiscParams miscParams_CD = new EziMiscParams();

	ReturnObjFromRetrieve retObjMisc_CD = null;
	int countMisc_CD=0;

	miscParams_CD.setIdenKey("MISC_SELECT");
	miscParams_CD.setQuery("SELECT EUD_USER_ID,EUD_KEY,EUD_VALUE FROM EZC_USER_DEFAULTS WHERE EUD_KEY IN ('SAP_COMM_GROUP') AND EUD_USER_ID='"+Long.parseLong(soldTo)+"'");

	mainParamsMisc_CD.setLocalStore("Y");
	mainParamsMisc_CD.setObject(miscParams_CD);
	Session.prepareParams(mainParamsMisc_CD);
	
	String commGorupId = "";

	try
	{		
		retObjMisc_CD = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsMisc_CD);
	}
	catch(Exception e){}
		
	if(retObjMisc_CD!=null && retObjMisc_CD.getRowCount()>0)
	{
		if("SAP_COMM_GROUP".equals(retObjMisc_CD.getFieldValueString(0,"EUD_KEY")))
		{
			commGorupId=retObjMisc_CD.getFieldValueString(0,"EUD_VALUE");
		}
	
	}
	session.putValue("CommGroup",commGorupId);
	
	ezc.ezcommon.EzLog4j.log("::::commGorupId:::::::"+commGorupId ,"I");
	//Commision Group End

	uparams= new EzcUserParams();
	ezcUserNKParams = new EzcUserNKParams();

 	ezcUserNKParams.setLanguage("EN");

	uparams.setUserId(Session.getUserId());
 	uparams.createContainer();
 	uparams.setObject(ezcUserNKParams);

 	Session.prepareParams(uparams);

	//Get User Catalog Number
	ReturnObjFromRetrieve  catalogno = (ReturnObjFromRetrieve)UManager.getUserCatalogs(uparams);


	for(int i=0;i<catalogno.getRowCount();i++)
	{
		if("USERCATALOG".equals(catalogno.getFieldValueString(i,"EUD_KEY")) )
		{
			String CatalogCode = catalogno.getFieldValueString(i,"EUD_VALUE");
			session.putValue("CatalogCode",CatalogCode);
			break;
		}
	}

	ezc.ezcommon.EzLog4j.log("<<<isSubUser>>>>>>>>>>>>>."+isSubUser ,"I");

	if(isSubUser==null || "null".equalsIgnoreCase(isSubUser) || "".equals(isSubUser))
		isSubUser="N";
	else
		isSubUser=isSubUser.toUpperCase();
	if(userStatus!=null) userStatus=userStatus.trim();

	ezc.ezcommon.EzLog4j.log("<<<userStatus>>>>>>>>>>>>>."+userStatus ,"I");
	ezc.ezcommon.EzLog4j.log("<<<exclMat>>>>>>>>>>>>>"+Session.getUserId()+">>>>"+exclMat+"<<" ,"I");

	if(suAuth==null || "null".equals(suAuth) || "".equals(suAuth)) suAuth = "";
	if(viewAllCust==null || "null".equals(viewAllCust) || "".equals(viewAllCust)) viewAllCust = "N";

	String dispAuth = "N";
	String vipAuth = "N";

	if(poProgType!=null && !"null".equalsIgnoreCase(poProgType) && !"".equals(poProgType))
	{
		StringTokenizer pType_ST = new StringTokenizer(poProgType,"¥");

		while(pType_ST.hasMoreTokens())
		{
			String pType_TK = pType_ST.nextToken();

			if("D".equals(pType_TK))
				dispAuth = "Y";
			else if("V".equals(pType_TK))
				vipAuth = "Y";
		}
	}

	session.putValue("IsSubUser",isSubUser);
	session.putValue("userStyle",userStyle);
	session.putValue("UserRole1",userRole);
	session.putValue("UserRole",userRole);
	session.putValue("SuAuth",suAuth);
	session.putValue("VIEWALLCUST",viewAllCust);
	session.putValue("AgentCode",soldTo);
	session.putValue("ShipCode",shipTo);
	session.putValue("SalesAreaCode",SalesAreaCode);
	session.putValue("DISPAUTH",dispAuth);
	session.putValue("VIPAUTH",vipAuth);
	session.putValue("SALESREPRES",salesRepRes);
	session.putValue("SHOWIMAGES",showImages);
	session.putValue("EXCLMAT",exclMat);

	ezc.client.EzcUtilManager UtilManager = new ezc.client.EzcUtilManager(Session);
	UtilManager.setSysKeyAndSoldTo(SalesAreaCode,soldTo);

	ezc.record.util.EzOrderedDictionary userAuth_R = Session.getUserAuth();
	Enumeration userAuth_Key = (ezc.record.util.EzOrderedDictionaryEnumerator)userAuth_R.keys();

	while(userAuth_Key.hasMoreElements())
	{
		ezc.ezcommon.EzLog4j.log("<<<userAuth_Key>>>>>>>>>>>>>"+Session.getUserId()+">>>>"+userAuth_Key.nextElement() ,"I");
	}

	/*if(userAuth_R.containsKey("ADD_CONTRACT"))
	{
		ezc.ezcommon.EzLog4j.log("<<<userAuth_R>>>>>>>>>>>>>"+userAuth_R.get("ADD_CONTRACT") ,"I");
	}*/

	String progTypeVal = "N/A";

	if("Y".equals((String)session.getValue("REPAGENCY")))
	{
		if(userAuth_R.containsKey("SUBMIT_ORDER")) progTypeVal 	  = "NONE";
		else if(userAuth_R.containsKey("FOC_ORDER")) progTypeVal  = "FOC";
		else if(userAuth_R.containsKey("DISP_ORDER")) progTypeVal = "DISP";
		else if(userAuth_R.containsKey("VIP_ORDER")) progTypeVal  = "VIP";
	}
	else
	{
		if(userAuth_R.containsKey("SUBMIT_ORDER")) progTypeVal 	  = "NONE";
		else if(userAuth_R.containsKey("DISP_ORDER")) progTypeVal = "DISP";
		else if(userAuth_R.containsKey("VIP_ORDER")) progTypeVal  = "VIP";
		else if(userAuth_R.containsKey("FOC_ORDER")) progTypeVal  = "FOC";
	}

	session.putValue("DEFPROG",progTypeVal);

	//Ship to attributes in Hashtable with Sales Org

	Hashtable custAttrs = getCustAttrs(shipTo,Session);

	session.putValue("CUSTATTRS",custAttrs);

	//setting sales area defaults to session

	EzcSysConfigParams sparams2 	= new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams2 = new EzcSysConfigNKParams();
	snkparams2.setLanguage("EN");
	snkparams2.setSystemKey((String)session.getValue("SalesAreaCode"));
	snkparams2.setSiteNumber(200);
	sparams2.setObject(snkparams2);
	Session.prepareParams(sparams2);
	ReturnObjFromRetrieve retde = (ReturnObjFromRetrieve)ConfigManager.getCatAreaDefaults(sparams2);
	retde.check();
	for(int z=0;z<retde.getRowCount();z++)
	{
		if("DOCTYPE".equals(retde.getFieldValueString(z,"ECAD_KEY")) )
		{
			String docType = retde.getFieldValueString(z,"ECAD_VALUE");
			session.putValue("docType",docType);
		}
		if("DIVISION".equals(retde.getFieldValueString(z,"ECAD_KEY")) )
		{
			String division = retde.getFieldValueString(z,"ECAD_VALUE");
			session.putValue("division",division);
		}
		if("DISTRIBUTION".equals(retde.getFieldValueString(z,"ECAD_KEY")) )
		{
			String distributionChannel = retde.getFieldValueString(z,"ECAD_VALUE");
		 	session.putValue("dc",distributionChannel);
		}
		if("SALESORG".equals(retde.getFieldValueString(z,"ECAD_KEY")) )
		{
			String salesOrg = retde.getFieldValueString(z,"ECAD_VALUE");
			session.putValue("salesOrg",salesOrg);
		}
		if("WFTEMPLATE".equals(retde.getFieldValueString(z,"ECAD_KEY")) )
		{
			String template = retde.getFieldValueString(z,"ECAD_VALUE");
			session.putValue("Template",template);
		}
		if("DEFSAPPRDCODE".equals(retde.getFieldValueString(z,"ECAD_KEY")) )
		{
			String defSapMatCode  = retde.getFieldValueString(z,"ECAD_VALUE");
			session.putValue("SAPPRDCODE",defSapMatCode);
		}
		if("SUBUSERLIMIT".equals(retde.getFieldValueString(z,"ECAD_KEY")) )
		{
			String subUserLimit  = retde.getFieldValueString(z,"ECAD_VALUE");
			session.putValue("SUBUSERLIMIT",subUserLimit);
		}
		if("PLANT".equals(retde.getFieldValueString(z,"ECAD_KEY")) )
		{
			String plantVal  = retde.getFieldValueString(z,"ECAD_VALUE");
			session.putValue("PLANT",plantVal);
		}
		if("SOCONDTYPE".equals(retde.getFieldValueString(z,"ECAD_KEY")) )
		{
			String soCondType  = retde.getFieldValueString(z,"ECAD_VALUE");
			session.putValue("SOCONDTYPE",soCondType);
		}
		if("QUOTECONDTYPE".equals(retde.getFieldValueString(z,"ECAD_KEY")) )
		{
			String quoteCondType  = retde.getFieldValueString(z,"ECAD_VALUE");
			session.putValue("QUOTECONDTYPE",quoteCondType);
		}
		if("FREIGHTCONDTYPE".equals(retde.getFieldValueString(z,"ECAD_KEY")) )
		{
			String fCondType  = retde.getFieldValueString(z,"ECAD_VALUE");
			session.putValue("FREIGHTCONDTYPE",fCondType);
		}
		if("PROFITCENTER".equals(retde.getFieldValueString(z,"ECAD_KEY")) )
		{
			String profitCenter  = retde.getFieldValueString(z,"ECAD_VALUE");
			session.putValue("PROFITCENTER",profitCenter);
		}
		if("FREIGHTINS".equals(retde.getFieldValueString(z,"ECAD_KEY")) )
		{
			String freightIns  = retde.getFieldValueString(z,"ECAD_VALUE");
			session.putValue("FREIGHTINS",freightIns);
		}
		if("PAGESIZE".equals(retde.getFieldValueString(z,"ECAD_KEY")) )
		{
			String pageSize  = retde.getFieldValueString(z,"ECAD_VALUE");
			session.putValue("PAGESIZE",pageSize);
		}
		if("FRINSVAL".equals(retde.getFieldValueString(z,"ECAD_KEY")) )
		{
			String frInsVal  = retde.getFieldValueString(z,"ECAD_VALUE");
			session.putValue("FRINSVAL",frInsVal);
		}
		if("CCEMAIL".equals(retde.getFieldValueString(z,"ECAD_KEY")) )
		{
			String ccEmail  = retde.getFieldValueString(z,"ECAD_VALUE");
			session.putValue("CCEMAIL",ccEmail);
		}
	}

	
	session.putValue("SalesOffice",salesOffice);
	session.putValue("DATEFORMAT",String.valueOf(ezc.ezutil.FormatDate.MMDDYYYY));
	session.putValue("DATESEPERATOR","/");

	String WFRole="";
	String Participant="";

	if("CU".equalsIgnoreCase(userRole))
	{
		Participant 	="SALES_CUSTOMER";
		WFRole 		="SALES_CUSTOMER";
	}
	else if("CM".equalsIgnoreCase(userRole))
	{
		Participant	="SALES_CM";
		WFRole		="SALES_CM";
	}
	else if("LF".equalsIgnoreCase(userRole))
	{
		Participant 	="SALES_LF";
		WFRole		="SALES_LF";
	}
	else if("DM".equalsIgnoreCase(userRole))
	{
		Participant 	="SALES_DM";
		WFRole		="SALES_DM";
	}
	else if("SM".equalsIgnoreCase(userRole))
	{
		Participant 	="SALES_SM";
		WFRole		="SALES_SM";
	}
	else if("BP".equalsIgnoreCase(userRole))
	{
		Participant 	="SALES_FINANCE";
		WFRole		="SALES_FINANCE";
	}
	
	Participant = (userGroup == null||"null".equals(userGroup))?Participant:userGroup;
	
	session.putValue("Participant",userGroup);
	session.putValue("WFRole",WFRole);

	String redirectfile = null;

	ReturnObjFromRetrieve retUserData=null;

	EzcUserParams uparamsN= new EzcUserParams();
	EzcUserNKParams ezcUserNKParamsN = new EzcUserNKParams();
	ezcUserNKParamsN.setLanguage("EN");
	uparamsN.setUserId(Session.getUserId());
	uparamsN.createContainer();
	uparamsN.setObject(ezcUserNKParamsN);
	Session.prepareParams(uparamsN);	
	retUserData = (ReturnObjFromRetrieve)UManager.getUserData(uparamsN);

	String UserType	=retUserData.getFieldValueString(0,"EU_TYPE");
	String bussPrt	=retUserData.getFieldValueString(0,"EU_BUSINESS_PARTNER");

	session.putValue("BussPart",bussPrt);
	session.putValue("UserType",UserType);
	
	EzcPersonalizationParams ezget = new EzcPersonalizationParams();
	EziPersonalizationParams izget = new EziPersonalizationParams();
	izget.setLanguage("EN");
	izget.setUserId(Session.getUserId());
	ezget.setObject(izget);
	Session.prepareParams(ezget);
	ReturnObjFromRetrieve retprodfav = (ReturnObjFromRetrieve) EzcPersonalizationManager.getProdFavDesc(ezget);
	int retprodfavCount=retprodfav.getRowCount();
	if(retprodfavCount>0)
	{
		String favGroup = retprodfav.getFieldValueString(0,"EPG_NO");
		String favDesc  = retprodfav.getFieldValueString(0,"EPGD_DESC");
		session.putValue("USR_FAV_GRP",favGroup);
		session.putValue("USR_FAV_DESC",favDesc);
	}
	else
	{
		
		EzcPersonalizationParams ezpparams = new EzcPersonalizationParams();
		EziPersonalizationParams iparams = new EziPersonalizationParams();
		iparams.setLanguage("EN");
		iparams.setUserId(Session.getUserId());
		iparams.setProductFavGroupDesc("MYFAVOURITES");
		iparams.setProductFavGroupWebDesc("My Favourites");
		ezpparams.setObject(iparams);
		Session.prepareParams(ezpparams);
		EzcPersonalizationManager.addUserProdFavDesc(ezpparams);

		String groupNumber = "";
		ezget = new EzcPersonalizationParams();
		izget = new EziPersonalizationParams();
		izget.setLanguage("EN");
		izget.setUserId(Session.getUserId());
		ezget.setObject(izget);
		Session.prepareParams(ezget);
		ReturnObjFromRetrieve retFAV = (ReturnObjFromRetrieve) EzcPersonalizationManager.getProdFavDesc(ezget);
		String favGroup = retFAV.getFieldValueString(0,"EPG_NO");
		String favDesc  = retFAV.getFieldValueString(0,"EPGD_DESC");
		
		session.putValue("USR_FAV_GRP",favGroup);
		session.putValue("USR_FAV_DESC",favDesc);
	
	}	
	
	/************************ Setting SoldTo and ShipTo lists to session - Start ***************************/

	ReturnObjFromRetrieve retcatarea = (ReturnObjFromRetrieve)UtilManager.getUserCatalogAreas();
	String allSalesAreas = SalesAreaCode;
	if(retcatarea!=null && retcatarea.getRowCount()>0)
	{
		for(int a=0;a<retcatarea.getRowCount();a++)
		{
			String retSysKey = retcatarea.getFieldValueString(a,"ESKD_SYS_KEY");

			if(a==0)
				allSalesAreas = retSysKey;
			else
				allSalesAreas = allSalesAreas+"','"+retSysKey;
		}
	}
	session.putValue("ALLSALES_AREAS",allSalesAreas);
	/*ezc.ezcommon.EzLog4j.log("UserType::::::"+UserType,"D");
	ezc.ezcommon.EzLog4j.log("allSalesAreas::::::"+allSalesAreas,"D");
	ezc.ezcommon.EzLog4j.log("bussPrt::::::"+bussPrt,"D");*/
	
	ReturnObjFromRetrieve retsoldto_A = (ReturnObjFromRetrieve)getUserCustomers(UserType,allSalesAreas,(String)Session.getUserId(),bussPrt,Session);
	
	if(retsoldto_A!=null)
		session.putValue("retsoldto_A_Ses",retsoldto_A);

	UtilManager.setSysKeyAndSoldTo(SalesAreaCode,soldTo);
	ReturnObjFromRetrieve  listShipTos_ent = (ReturnObjFromRetrieve)UtilManager.getListOfShipTos(soldTo);

	if(listShipTos_ent!=null)
		session.putValue("listShipTos_entSes",listShipTos_ent);

	/************************ Setting SoldTo and ShipTo lists to session - End ***************************/

	long finish = System.currentTimeMillis();
	ezc.ezcommon.EzLog4j.log("Time taken to execute ezConfirm.jsp>>>"+(finish-start)/1000+" secs","F");

	String OFFLINE = (String)session.getValue("OFFLINE");
	String urlLink = (String)session.getValue("URLLINK");
	String docStat = (String)session.getValue("DocStatus");
	ezc.ezcommon.EzLog4j.log("OFFLINE::::::"+OFFLINE,"D");
	
	if(salesArea_A && soldTo_A && shipTo_A && !"Y".equals(OFFLINE))
	{
		ezc.ezcommon.EzLog4j.log(">>>>>>>UserType>>>>>>>>>>>>>>>>>>>>>>"+docStat,"D");

		String actualLink = "";

		if(urlLink!=null && !"null".equalsIgnoreCase(urlLink) && !"".equals(urlLink))
		{
			EzcParams mainParamsURL = new EzcParams(false);
			EziMiscParams miscParamsURL = new EziMiscParams();

			ReturnObjFromRetrieve retURL = null;
			miscParamsURL.setIdenKey("MISC_SELECT");
			miscParamsURL.setQuery("SELECT EUM_SHORT_URL,EUM_ACTUAL_URL FROM EZC_URL_MAPPING WHERE EUM_SHORT_URL='"+urlLink+"'");

			mainParamsURL.setLocalStore("Y");
			mainParamsURL.setObject(miscParamsURL);
			Session.prepareParams(mainParamsURL);	

			try
			{
				retURL = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsURL);
				actualLink = retURL.getFieldValueString(0,"EUM_ACTUAL_URL");
			}
			catch(Exception e){}
		}

		if("3".equals(UserType))
		{
			ezc.ezcommon.EzLog4j.log(">>>>>>>UserType IN IFFFFF>>>>>>>>>>>>>>>>>>>>>>"+UserType,"D");
			ezc.ezcommon.EzLog4j.log(">>>>>>>userStatus IN IFFFFF>>>>>>>>>>>>>>>>>>>>>>"+userStatus,"D");
			
			ezc.ezshipment.client.EzShipmentManager dsclmrManager = new ezc.ezshipment.client.EzShipmentManager();
			ezc.ezparam.EzcParams dsclmrparams = new ezc.ezparam.EzcParams(true);
			ezc.ezparam.EzcUserParams dsclmrusrparams= new ezc.ezparam.EzcUserParams();
			dsclmrusrparams.setUserId(Session.getUserId()+"¥Y");//This is for knowing whether customer clicked on 'I Agree' button when first time logged in the portal .
			dsclmrparams.setObject(dsclmrusrparams);
			Session.prepareParams(dsclmrparams);
			ezc.ezcommon.EzLog4j.log(">>>>>>>Disclaimer Get>>>>>>>>>>>>>>>>>>>>>>"+session.getValue("OFFLINE"),"D");
			ezc.ezparam.ReturnObjFromRetrieve dsclmrRetObj = (ezc.ezparam.ReturnObjFromRetrieve)dsclmrManager.ezGetDisclaimerStamp(dsclmrparams);
			if (dsclmrRetObj!=null && dsclmrRetObj.getRowCount()==0)
			{
				/*ezc.ezcommon.EzLog4j.log(">>>>>>>Disclaimer Insert>>>>>>>>>>>>>>>>>>>>>>","D");
				ezc.ezshipment.client.EzShipmentManager dsclmrManager_A= new ezc.ezshipment.client.EzShipmentManager();
				dsclmrusrparams = new ezc.ezparam.EzcUserParams();
				dsclmrusrparams.setUserId(Session.getUserId()+"¥Y");//This is for knowing whether customer clicked on 'I Agree' button when first time logged in the portal .
				dsclmrparams.setObject(dsclmrusrparams);
				Session.prepareParams(dsclmrparams);
				dsclmrManager.ezPutDisclaimerStamp(dsclmrparams);*/
				session.putValue("DISCLAIMER","N");
			}
			if (dsclmrRetObj!=null && dsclmrRetObj.getRowCount()>0)
					session.putValue("DISCLAIMER","Y");
			
			if("I".equals(userStatus))
				redirectfile = "ezUserBlock.jsp";
			/*else if (dsclmrRetObj!=null && dsclmrRetObj.getRowCount()>0)
			{
				redirectfile="ezPutDisclaimerStamp.jsp"; 
			}*/
			else if(urlLink!=null && !"null".equalsIgnoreCase(urlLink) && !"".equals(urlLink))
			{
				redirectfile = "../../../../../"+actualLink;
			}
			else
			{
				redirectfile="ezDashBoard.jsp"; // this to for disclamier
			}	
		}
		else if (UserType.equals("2"))
		{
			//redirectfile = "ezUserCheck.jsp";	//  Intranet User

			if(urlLink!=null && !"null".equalsIgnoreCase(urlLink) && !"".equals(urlLink))
			{
				redirectfile = "../../../../../"+actualLink;
			}
			else 
			{			
				redirectfile = "ezDashBoard.jsp";
			}
		}
		else
			redirectfile = "invalidArea.jsp";
	}
	else if ("Y".equals(OFFLINE))
	{
		/*if("NEGOTIATED".equals(docStat))
			redirectfile = "../Sales/ezNegotiateOrderDetails.jsp";
		else if("NEW".equals(docStat))
			redirectfile = "../Sales/ezEditSaveSalesOrderDetails.jsp";
		else if("SUBMITTED".equals(docStat))
			redirectfile = "../Sales/ezApprovalOrderDetails.jsp";
		else if("REJECTED".equals(docStat))
			redirectfile = "../Sales/ezNegotiateOrderDetails.jsp";
		else if("TRANSFERED".equals(docStat))
			redirectfile = "../Sales/ezSalesOrderDetails.jsp";*/

		if(urlLink!=null && !"null".equalsIgnoreCase(urlLink) && !"".equals(urlLink))
		{
			EzcParams mainParamsURL = new EzcParams(false);
			EziMiscParams miscParamsURL = new EziMiscParams();

			ReturnObjFromRetrieve retURL = null;
			miscParamsURL.setIdenKey("MISC_SELECT");
			miscParamsURL.setQuery("SELECT EUM_SHORT_URL,EUM_ACTUAL_URL FROM EZC_URL_MAPPING WHERE EUM_SHORT_URL='"+urlLink+"'");

			mainParamsURL.setLocalStore("Y");
			mainParamsURL.setObject(miscParamsURL);
			Session.prepareParams(mainParamsURL);	

			String actualLink = "";

			try
			{
				retURL = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsURL);
				actualLink = retURL.getFieldValueString(0,"EUM_ACTUAL_URL");
			}
			catch(Exception e){}

			redirectfile = "../../../../../"+actualLink;
		}
		else
			redirectfile = "ezDashBoard.jsp";
	}
	else
		redirectfile = "invalidArea.jsp";

	response.sendRedirect(redirectfile);
%>
</head>

</html>
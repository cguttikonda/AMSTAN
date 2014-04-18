<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>

<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.shopping.cart.params.*,ezc.shopping.cart.client.*,ezc.shopping.cart.common.*,ezc.sales.params.*" %>
<%@ page import="ezc.ezparam.*,ezc.ezbasicutil.*,java.util.*" %>
<%@ page import="ezc.customer.invoice.params.*,ezc.ezmisc.params.*,ezc.ezadmin.ezadminutils.params.*" %>
<%@ page import="java.text.*,ezc.ezsap.*,ezc.client.*,ezc.ezutil.FormatDate" %>

<jsp:useBean id="ConfigManager" class="ezc.client.EzSystemConfigManager" scope="session"/>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<%@ include file="../../../Includes/JSPs/Misc/iMethods.jsp"%>
<%
	String sysKey = (String)session.getValue("SalesAreaCode");
	String catalogArea=request.getParameter("CatalogArea");
	String selSoldTo=request.getParameter("selSoldTo");
	String selShipTo=request.getParameter("selShipTo_S");
	String uId= (String)Session.getUserId().toUpperCase();	

	String shipToName=request.getParameter("shipToName");

	EzcParams mainParamsSU= new EzcParams(false);
	EziMiscParams miscParamsSU = new EziMiscParams();

	EzcParams mainParamsPU= new EzcParams(false);
	EziMiscParams miscParamsPU = new EziMiscParams();

	EzcParams mainParamsSHU= new EzcParams(false);
	EziMiscParams miscParamsSHU = new EziMiscParams();

	boolean updBoolS=false;
	boolean updBoolP=false;
	boolean updBoolSH=false;

	if(!sysKey.equals(catalogArea))
	{
		miscParamsSU.setIdenKey("MISC_UPDATE");
		String querySU="UPDATE EZC_USER_DEFAULTS SET EUD_VALUE='"+catalogArea+"' WHERE EUD_USER_ID='"+uId+"' AND EUD_KEY='C_USERSYSTEMKEY'";
		miscParamsSU.setQuery(querySU);

		mainParamsSU.setLocalStore("Y");
		mainParamsSU.setObject(miscParamsSU);
		Session.prepareParams(mainParamsSU);	
		try
		{		
			ezMiscManager.ezUpdate(mainParamsSU);
			updBoolS=true;
		}
		catch(Exception e){}
	}
	if(!selSoldTo.equals(session.getValue("AgentCode")))
	{
		miscParamsPU.setIdenKey("MISC_UPDATE");
		String queryPU="UPDATE EZC_USER_DEFAULTS SET EUD_VALUE='"+selSoldTo+"' WHERE EUD_USER_ID='"+uId+"' AND EUD_KEY='C_ERPSOLDTO'";
		miscParamsPU.setQuery(queryPU);

		mainParamsPU.setLocalStore("Y");
		mainParamsPU.setObject(miscParamsPU);
		Session.prepareParams(mainParamsPU);	
		try
		{		
			ezMiscManager.ezUpdate(mainParamsPU);
			updBoolP=true;
		}
		catch(Exception e){}

		//Commision Group Start

		EzcParams mainParamsMisc_CD= new EzcParams(false);
		EziMiscParams miscParams_CD = new EziMiscParams();

		ReturnObjFromRetrieve retObjMisc_CD = null;
		int countMisc_CD=0;

		miscParams_CD.setIdenKey("MISC_SELECT");
		miscParams_CD.setQuery("SELECT EUD_USER_ID,EUD_KEY,EUD_VALUE FROM EZC_USER_DEFAULTS WHERE EUD_KEY IN ('SAP_COMM_GROUP') AND EUD_USER_ID='"+Long.parseLong(selSoldTo)+"'");

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

		//session.removeValue("CommGroup");
		session.putValue("CommGroup",commGorupId);

		//Commision Group End
	}
	if(!selShipTo.equals(session.getValue("ShipCode")))
	{
		miscParamsSHU.setIdenKey("MISC_UPDATE");
		String querySHU="UPDATE EZC_USER_DEFAULTS SET EUD_VALUE='"+selShipTo+"' WHERE EUD_USER_ID='"+uId+"' AND EUD_KEY='C_ERPSHIPTO'";
		miscParamsSHU.setQuery(querySHU);

		mainParamsSHU.setLocalStore("Y");
		mainParamsSHU.setObject(miscParamsSHU);
		Session.prepareParams(mainParamsSHU);	
		try
		{		
			ezMiscManager.ezUpdate(mainParamsSHU);
			updBoolSH=true;
		}
		catch(Exception e){}
	}

	if(updBoolS)
	{
		EzcShoppingCartParams ezcShoppingCartParams = new EzcShoppingCartParams();
		EziReqParams eziReqParams = new EziReqParams();
		EziShoppingCartParams eziShoppingCartParams = new EziShoppingCartParams();
		EzShoppingCartManager SCManager = new EzShoppingCartManager(Session);

		eziShoppingCartParams.setLanguage("EN");
		eziShoppingCartParams.setEziReqParams(eziReqParams );
		eziShoppingCartParams.setObject(eziReqParams);
		ezcShoppingCartParams.setObject(eziShoppingCartParams);

		Session.prepareParams(ezcShoppingCartParams);

		try
		{
			SCManager.deleteCart(ezcShoppingCartParams);
		}
		catch(Exception e){}

		session.removeValue("Faucets(incl. Flush Valves)-Non Luxury");
		session.removeValue("Faucets(incl. Flush Valves)-Luxury"); 
		session.removeValue("Chinaware"); 
		session.removeValue("Americast & Acrylics (Excludes Acrylux)"); 
		session.removeValue("Acrylux");
		session.removeValue("Enamel Steel"); 
		session.removeValue("Marble"); 
		session.removeValue("Shower Doors-Standard"); 
		session.removeValue("Shower Doors-Custom"); 
		session.removeValue("Walk In Baths"); 
		session.removeValue("Repair Parts"); 
		session.removeValue("JADO"); 
		session.removeValue("FIAT");

		session.removeValue("SalesAreaCode");
		session.putValue("SalesAreaCode",catalogArea);

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
				String templates = retde.getFieldValueString(z,"ECAD_VALUE");
				session.putValue("Template",templates);
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
		}
	}
	if(updBoolP)
	{
		session.removeValue("AgentCode");
		session.putValue("AgentCode",selSoldTo);

		if(session.getValue("SOLDTO_PREP")!=null)
			session.removeValue("SOLDTO_PREP"); 
	}
	if(updBoolSH)
	{
		session.removeValue("ShipCode");
		session.putValue("ShipCode",selShipTo);

		if(shipToName!=null && !"null".equals(shipToName))
			session.putValue("DISP_SH_NAME",shipToName);

		//Ship to attributes in Hashtable with Sales Org

		Hashtable custAttrs = getCustAttrs(selShipTo,Session);

		session.removeValue("CUSTATTRS");
		session.putValue("CUSTATTRS",custAttrs);

		if(session.getValue("SHIPTO_PREP")!=null)
			session.removeValue("SHIPTO_PREP");
	}
	String displayHeader="No Change!";

	if(updBoolS && updBoolP && updBoolSH)
		displayHeader = "SalesArea and SoldToCode Defaults have been switched";

	else if(updBoolS && !updBoolP && !updBoolSH)
		displayHeader = "Default SalesArea has been switched";

	else if(updBoolS && updBoolP && !updBoolSH)
		displayHeader = "Default SalesArea and SoldToCode have been switched";

	else if(updBoolP && !updBoolS && !updBoolSH)
		displayHeader = "Default SoldToCode has been switched"; 

	else if(updBoolP && !updBoolS && updBoolSH)
		displayHeader = "Default SoldToCode and ShipToCode have been switched"; 

	else if(updBoolSH && !updBoolS && !updBoolP)
		displayHeader = "Default ShipToCode has been switched"; 

	else if(updBoolSH && updBoolS && !updBoolP)
		displayHeader = "Default SalesArea and ShipToCode have been switched"; 
%>
<!--
<h2 ><%//=displayHeader%></h2> 	
<div class="buttons-set form-buttons"><p class="back-link"><a href="../Misc/ezDashBoard.jsp"><small>&laquo; </small>Go Home</a></p></div>
-->
<%
	response.sendRedirect("../Misc/ezDashBoard.jsp");
%>
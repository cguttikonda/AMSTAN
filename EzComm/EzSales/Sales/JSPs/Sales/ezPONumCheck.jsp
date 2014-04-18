<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"></jsp:useBean>
<jsp:useBean id="global" class="ezc.ezbasicutil.EzGlobal" scope="session" />
<%@ page import="ezc.ezparam.*"%>
<%@ page import ="com.sap.mw.jco.*,java.util.*" %>
<%@ page import ="ezc.sapconnection.*,com.sap.mw.jco.*,com.sap.mw.jco.JCO" %>
<%
 	JCO.Client client = null;
 	JCO.Function function = null;

	String poNumber 	= request.getParameter("poNumber");
	String soldToCode 	= request.getParameter("selSoldTo");
	String shipToCode 	= request.getParameter("selShipTo");
	String poDate	 	= request.getParameter("poDate");
	String poExists = "Y";

	java.util.GregorianCalendar poDateObj = null;
	if(poDate!=null && !"null".equalsIgnoreCase(poDate) && !"".equals(poDate))
	{
		int dateReq 	= Integer.parseInt(poDate.substring(3,5));
		int monthReq 	= Integer.parseInt(poDate.substring(0,2));
		int yearReq 	= Integer.parseInt(poDate.substring(6,10));
		poDateObj 	= new java.util.GregorianCalendar(yearReq,monthReq-1,dateReq);
	}

	ezc.ezparam.EzcParams mainParamsShips		= null;
	ezc.ezmisc.params.EziMiscParams miscParamsShips	= new ezc.ezmisc.params.EziMiscParams();
	ezc.ezparam.ReturnObjFromRetrieve poCheckObj	= null;

	mainParamsShips	= new ezc.ezparam.EzcParams(true);

	miscParamsShips.setIdenKey("MISC_SELECT");
	String queryShip	= "SELECT COUNT(*) POCOUNT FROM EZC_SALES_DOC_HEADER WHERE ESDH_PO_NO ='"+poNumber+"' AND ESDH_SOLD_TO='"+soldToCode+"' AND ESDH_SHIP_TO='"+shipToCode+"' AND CAST(ESDH_PURCH_DATE AS DATE) = '"+poDate+"'";
	miscParamsShips.setQuery(queryShip);

	mainParamsShips.setLocalStore("Y");
	mainParamsShips.setObject(miscParamsShips);
	Session.prepareParams(mainParamsShips);
	try
	{
		poCheckObj	= (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsShips);
	}
	catch(Exception e)
	{
		System.out.println("ERROR::::::::::::::::::::"+e);
	}	
 	ezc.ezcommon.EzLog4j.log("miscParamsShips::::"+miscParamsShips.getQuery() ,"I");
 	
 	String countPo = poCheckObj.getFieldValueString(0,"POCOUNT");
 	
 	if(countPo!=null && !"null".equals(countPo) && !"".equals(countPo) && "0".equals(countPo))
 	{
		String site_SO = (String)session.getValue("Site");
		String skey_SO = "999";

		try
		{
			function = EzSAPHandler.getFunction("Z_EZ_CHECK_PO_EXISTENCE",site_SO+"~"+skey_SO);

			JCO.ParameterList impParams = function.getImportParameterList();
			impParams.setValue(poNumber.toUpperCase(),"PONUMBER");
			impParams.setValue(poDateObj.getTime(),"PODATE");
			impParams.setValue(soldToCode,"SOLDTOPARTY");
			impParams.setValue(shipToCode,"SHIPTOPARTY");

			client = EzSAPHandler.getSAPConnection(site_SO+"~"+skey_SO);
			client.execute(function);

			poExists = (String)function.getExportParameterList().getValue("PO_EXISTS");
			ezc.ezcommon.EzLog4j.log("poExists::"+poExists+"::poNumber::"+poNumber,"D");
		}
		catch(Exception e){}
		finally
		{
			if(client!=null)
			{
				JCO.releaseClient(client);
				client = null;
				function = null;
			}
		}
 	}
 	else
 	{
 		poExists = "X";
 	}
 	out.print("POEXISTS##"+poExists);
%>
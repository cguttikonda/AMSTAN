<%@ page import ="ezc.ezparam.*" %>
<%@ page import ="java.util.*" %>
<%@ page import = "ezc.ezcommon.*" %>
<%@ page import = "ezc.ezshipment.client.*" %>
<%@ page import = "ezc.ezutil.FormatDate"%>
<%@ page import = "ezc.ezshipment.params.*,ezc.ezvendorapp.params.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="AppManager" class="ezc.ezvendorapp.client.EzVendorAppManager" />
<jsp:useBean id="PoManager"  class="ezc.client.EzPurchaseManager" scope="page" />
<jsp:useBean id="PcManager"  class ="ezc.client.EzPurContractManager" scope="page" />
<jsp:useBean id="PcManager1" class ="ezc.client.EzPurContractManager" scope="page"></jsp:useBean>

<%
	
	
	
	String orderBase        = request.getParameter("orderBase");
	String backFlg          = request.getParameter("backFlg");
	String ponum		= request.getParameter("ponum");
	if(ponum == null)
		ponum = "";
	String showData		= request.getParameter("showData");
	if(showData == null)
		showData = "N";
	String linktopo		= request.getParameter("linktopo");
	if(linktopo == null)
		linktopo = "N";
		
	String sysKey 		= (String) session.getValue("SYSKEY");
	String soldTo 		= (String) session.getValue("SOLDTO");
	String userType 	= (String) session.getValue("UserType");
	
	Vector	  ackOrders = new java.util.Vector();
	Vector    toShipPos = new java.util.Vector();
	Hashtable shipDates = new java.util.Hashtable();
	shipDates = (Hashtable)session.getValue("shipDates");
	
	int rowCount = 0;
	
	String base		= "PurchaseOrder";
	String baseValue	= request.getParameter("baseValues");
	String OrderValue  	= request.getParameter("OrderValue");
	String orderCurrency 	= request.getParameter("orderCurrency");
	String OrderDate 	= request.getParameter("OrderDate");
	String Type		= "P";
	if("con".equals(orderBase))
		Type		= "M";
		
	int count=0;
	FormatDate formatDate=new FormatDate();
	Date ordDate = null;
	String order="";
	String lineNum = "";
	String matNum = "";
	String matDesc ="";
	String uom = "";
	String qty = "";
	String price = "";
	String netAmount = "";
	Date eDDate = null;
	String poNum = baseValue;
	String plant = "";
	String confKey = "";

	Hashtable historyTable=new Hashtable();
	int retCount =0;
	
	
	ReturnObjFromRetrieve retPoHistory = null;
	EzPurchDtlXML dtlXML = new EzPurchDtlXML();
	if("Y".equals(showData))
	{
		EzPSIInputParameters iparams1 = new EzPSIInputParameters();
		ezc.ezparam.EzcPurchaseParams newParams1 = new ezc.ezparam.EzcPurchaseParams();
		EzPSIInputParameters ioparams = new EzPSIInputParameters();
		
		iparams1.setOrderNumber(ponum);
		newParams1.createContainer();
		newParams1.setObject(iparams1);
		Session.prepareParams(newParams1);
		
		ezc.ezcommon.EzLog4j.log(">>>>>>>>>TKTKTKT>>>>>>>>KIKIKIKIKI>>","I");
		dtlXML =  (EzPurchDtlXML)PoManager.ezPurchaseOrderStatus(newParams1);
		retPoHistory= dtlXML.getPoHistoryTotals();
		ezc.ezcommon.EzLog4j.log(">>>>>>>>>TKTKTKT>>>>>>>>KIKIKIKIKI>>"+dtlXML.toEzcString(),"I");
		ezc.ezcommon.EzLog4j.log(">>>retPoHistory::>"+retPoHistory.toEzcString(),"I");
		
		//for(int i=0;i<retPoHistory.getRowCount();i++)
		//	historyTable.put(retPoHistory.getFieldValueString(i,"PO_ITEM"),retPoHistory.getFieldValueString(i,"DELIV_QTY"));
		/********Added Local History to Get total Delv qty for line item of po***********/
		
		EziShipmentInfoParams inParams =new EziShipmentInfoParams();
		inParams.setSelection("SUM");
		inParams.setEXT1("PoOrderShippedQtys");
		inParams.setPurchaseOrderNumber(ponum);
		inParams.setSoldTo(soldTo);
		inParams.setSysKey(sysKey);
		inParams.setStatus("Y");
		EzcParams ezcparams = new EzcParams(true);
		ezcparams.setLocalStore("Y");
		ezcparams.setObject(inParams);
		Session.prepareParams(ezcparams);
		ezc.ezcommon.EzLog4j.log("LOCAL CALL GET PO >>>>>","I");
		ReturnObjFromRetrieve ret = (ReturnObjFromRetrieve)shipManager.ezGetShipmentInfo(ezcparams);
		ReturnObjFromRetrieve retSum = (ReturnObjFromRetrieve)ret.getFieldValue("SUM");
		ezc.ezcommon.EzLog4j.log("retSum.toEzcString(); >>>>>"+retSum.toEzcString(),"I");
		
		int sumCount=retSum.getRowCount();
		
		if(sumCount == 0)
		{
			for(int i=0;i<retPoHistory.getRowCount();i++)
				historyTable.put(retPoHistory.getFieldValueString(i,"PO_ITEM"),retPoHistory.getFieldValueString(i,"DELIV_QTY"));

			if(retPoHistory.getRowCount() > 0)
			{
				session.putValue("HISTORYHASH",historyTable);
			}
		}
		else
		{
			for(int i=0;i<sumCount;i++)
				historyTable.put(retSum.getFieldValueString(i,"LINENR"),retSum.getFieldValueString(i,"SUMQTY"));
		}
		/********End Local History***********/
		
		ordDate = (Date)dtlXML.getFieldValue(0,"ORDERDATE");
		order= (String)dtlXML.getFieldValue(0,"ORDER");
		order = baseValue;
		retCount = dtlXML.getRowCount();
	}
	
	//ezc.ezcommon.EzLog4j.log("MY CHK Ship dtlXMLKKKKKKKKKKKKKKKKKKKKKK>>"+dtlXML.toEzcString(),"I");
	//ezc.ezcommon.EzLog4j.log("----------------------------------------------","I");
	//ezc.ezcommon.EzLog4j.log("retPoHistory--->"+retPoHistory.getRowCount(),"I");
	
	
	/**FOR LINKING SHIPMENT DATA TO ANOTHER PO STARTS**/
	String dcno		= "";
	String dcdate		= "";
	String invno		= "";
	String invdate		= "";
	String lrno 		= "";
	String shipdate		= "";
	String cname		= "";
	String expTime		= "";
	String text 		= "";
	
	String linktopodat 	= request.getParameter("linktopodat");
	
	
	
	/*out.println("orderBase:"+orderBase);
		out.println("backFlg:"+backFlg);
		out.println("ponum:"+ponum);
		out.println("showData:"+showData);
		out.println("linktopo:"+linktopo);
		out.println("baseValue:"+baseValue);
		out.println("OrderValue:"+OrderValue);
		out.println("orderCurrency:"+orderCurrency);
		out.println("OrderDate:"+OrderDate);
	out.println("linktopodat:"+linktopodat);*/
	ezc.ezbasicutil.EzStringTokenizer EzToken = new ezc.ezbasicutil.EzStringTokenizer(linktopodat,"¤");
	java.util.Vector Tokens = EzToken.getTokens();
			
	if("Y".equals(linktopo)){
		try
		{
			dcno		= (String)Tokens.elementAt(0);	
			dcdate		= (String)Tokens.elementAt(1);	
			invno		= (String)Tokens.elementAt(2);	
			invdate		= (String)Tokens.elementAt(3);	
			lrno 		= (String)Tokens.elementAt(4);	
			shipdate	= (String)Tokens.elementAt(5);	
			cname		= (String)Tokens.elementAt(6);	
			expTime		= (String)Tokens.elementAt(7);	
			text 		= (String)Tokens.elementAt(8);	
		}
		catch(Exception e)
		{}	
	}
	
	/**FOR LINKING SHIPMENT DATA TO ANOTHER PO ENDS**/
	
	
	
%>

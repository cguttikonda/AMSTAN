<%@ page import ="ezc.ezparam.*,java.util.*,ezc.ezutil.*,ezc.ezvendorapp.params.*,ezc.ezpurchase.params.*,ezc.messaging.params.*" %>
<jsp:useBean id="PoManager" class="ezc.client.EzPurchaseManager" scope="page"></jsp:useBean>
<jsp:useBean id="AppManager" class="ezc.ezvendorapp.client.EzVendorAppManager" scope="page"></jsp:useBean>
<jsp:useBean id="Manager" class="ezc.client.EzMessagingManager" scope="session" />
<%@ include file="../../../Includes/Lib/PurchaseBean.jsp"%>
<%@ include file="../../../Includes/Lib/Address.jsp"%>

<%

	String defCatArea	= (String) session.getValue("SYSKEY");
	String defErpVendor 	= (String) session.getValue("SOLDTO");
	String defUser 		= (String) Session.getUserId();
	
	String defOrderTo 	= defErpVendor;
	String defPayTo 	= defErpVendor;
	
	Date FromDate=null;
	
	ezc.ezutil.FormatDate formatDate = new ezc.ezutil.FormatDate();
	ezc.client.EzcPurchaseUtilManager PurManager = new ezc.client.EzcPurchaseUtilManager(Session);

	EzcParams sParams = new EzcParams(false);
	EziPurchaseOrderParams timeStampParams= new EziPurchaseOrderParams();
	sParams.setLocalStore("Y");
	timeStampParams.setDocType("POUPDATEDDATE");
	timeStampParams.setSysKey(defCatArea);
	timeStampParams.setSoldTo(defUser);
	sParams.setObject(timeStampParams);
	Session.prepareParams(sParams);
	ReturnObjFromRetrieve retDate=(ReturnObjFromRetrieve)AppManager.ezGetVendorTimeStamp(sParams);
	ezc.ezcommon.EzLog4j.log("Vendor timestamp "+retDate.toEzcString(),"I");
		
	if(retDate.getRowCount()>0)
	{
		String lastLoginDate = formatDate.getStringFromDate((java.util.Date)retDate.getFieldValue(0,"DOCDATE"),"/",FormatDate.MMDDYYYY);
		int dateArray[] = formatDate.getMMDDYYYY(lastLoginDate,true);
		dateArray[0]=dateArray[0]-1;
		FromDate=new java.sql.Date(dateArray[2]-1900,dateArray[0],dateArray[1]-1);
		ezc.ezcommon.EzLog4j.log("DESTEP4444444444444 FromDate>>"+FromDate,"I");
	}
	else
	{
		
		
		EzcParams aParams = new EzcParams(false);
		EzVendorTimeStampStructure addtimeStampParams= new EzVendorTimeStampStructure();
		aParams.setLocalStore("Y");
		addtimeStampParams.setAuthKey("POUPDATEDDATE");
		addtimeStampParams.setSysKey(defCatArea);
		addtimeStampParams.setSoldTo(defUser);
		addtimeStampParams.setExt1("");
		addtimeStampParams.setExt2("");
		aParams.setObject(addtimeStampParams);
		Session.prepareParams(aParams);
		AppManager.ezAddVendorTimeStamp(aParams);
		
		java.util.Calendar rightNow = java.util.Calendar.getInstance();
		rightNow.add(java.util.Calendar.MONTH,-5);
		FromDate=new java.sql.Date(rightNow.get(java.util.Calendar.YEAR)-1900,rightNow.get(java.util.Calendar.MONTH)-1,rightNow.get(java.util.Calendar.DATE));
		ezc.ezcommon.EzLog4j.log("DESTEP4444444444444 FromDate>>"+FromDate,"I");	
	}

	
ezc.ezcommon.EzLog4j.log(" ezGetNewPurchaseOrderList==","I");
	EzPurchHdrXML hdrXML = null;
	int hdrCount = 0;
	try
	{
		EzPSIInputParameters iparams = new EzPSIInputParameters();
		EzcPurchaseParams Params = new EzcPurchaseParams();
		EziPurchaseInputParams testParams = new EziPurchaseInputParams();
		testParams.setSelectionFlag("N");
		iparams.setCostCenter("ALL");
		if (FromDate != null)
		{
			testParams.setFromDate(FromDate);
		}
		Params.createContainer();
		Params.setObject(iparams);
		Params.setObject(testParams);
		Session.prepareParams(Params);
		ezc.ezcommon.EzLog4j.log("Before ezGetNewPurchaseOrderList==","I");
		hdrXML = (EzPurchHdrXML)PoManager.ezGetNewPurchaseOrderList(Params);
		if(hdrXML != null)
			hdrCount = hdrXML.getRowCount();
	}
	catch(Exception ex)
	{
		ezc.ezcommon.EzLog4j.log("CHECKOOOOOOEXEXEXE>>GET POS FROM R3"+ex,"I");
	}
%>       

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">

<Html>
<Head>
<Script>

	function toggle(source)
	{ 
	    checkboxes = document.getElementsByName('chk1'); 
	    for(i=0;i<checkboxes.length;i++)
	    checkboxes[i].checked = source.checked;
	}
</Script>

<%@include file="../Misc/ezDataTableScript.jsp"%>
</Head>
<Body id="dt_example" scroll=no >
<form name="myForm">	
<%
	String display_header = "Stock Transfer Orders";
	
		
%>
<%@ include file="../Misc/ezDisplayHeader.jsp" %>


	<div id="container">	
	<div id="demo">
	<table class="display" id="example">
	<thead>
		<tr>
			<th><input type="checkbox" name="checkAll"  onClick="javascript :toggle(this)"></th>
			<th>PO Number</th>
			<th>Order Date</th>
			<th>Delivery Date</th>
			<th>Due Date</th>
			<th>Ship Date</th>
			<th>Currency</th>
			<th>Value</th>
		</tr>
	</thead>
	<tbody>
	
	</tbody>
</Body>
</Form>

</Html>
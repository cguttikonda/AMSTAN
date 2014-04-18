<%@ page import = "ezc.ezparam.*,ezc.ezbasicutil.*,ezc.ezutil.FormatDate,java.util.*,ezc.sales.local.client.*" %>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/Lib/ezSalesBean.jsp" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp" %>
<jsp:useBean id="setSalVal" class="ezc.sales.params.EzSalesSetPropParams"/>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%
		ReturnObjFromRetrieve retObj=null;
		EzcSalesOrderParams ezcParams = new EzcSalesOrderParams();
		ezcParams.setLocalStore("Y");
		Session.prepareParams(ezcParams);
		
		EzBapisdheadStructure ezHeader  = new EzBapisdheadStructure();
		EzBapiiteminTable tblRow = new EzBapiiteminTable();
		EzBapiiteminTableRow rowItm = new EzBapiiteminTableRow();
		EzDeliverySchedulesTableRow delRow = new EzDeliverySchedulesTableRow();
	
	  	EzDeliverySchedulesTable  delTable = new  EzDeliverySchedulesTable();	
		EziSalesOrderCreateParams iSOCrParams = new EziSalesOrderCreateParams();
		iSOCrParams.setOrderHeaderIn(ezHeader);
		iSOCrParams.setOrderItemsIn(tblRow);

		ezHeader.setDocNumber("1951");
		int dateReq=0,monthReq=0,yearReq=0;
		int delcount=0;
		java.math.BigDecimal tValue = new java.math.BigDecimal("0");
		
		rowItm.setItmNumber(new java.math.BigInteger("50"));	// Line numbers will be 10,20,30...
		rowItm.setMaterial(" PH-6602");
		rowItm.setShortText("TuSAPin (24 x 100 ml)");
		rowItm.setQtyInSalesUnit(new java.math.BigDecimal("0"));
		rowItm.setSalesUnit("EA");
		GregorianCalendar reqDateI = new GregorianCalendar(2006,11,22);
		rowItm.setReqDate( reqDateI.getTime());
		rowItm.setDlvDate( reqDateI.getTime());
		rowItm.setReqPrice(new java.math.BigDecimal("10"));
		rowItm.setConfirmedPrice(new java.math.BigDecimal("10000"));
		rowItm.setPlant("BP01");		
		rowItm.setReqQty1(new java.math.BigDecimal("100"));
		rowItm.setNetPrice(new java.math.BigDecimal("10000"));
		rowItm.setCurrency("'USD'");
		rowItm.setDelFlag("N");
		rowItm.setSalesArea("999101");
		rowItm.setItemCateg("");
		rowItm.setItemFOC("0");
		rowItm.setRefDocIt(new java.math.BigInteger("0"));
		rowItm.setNotes(" ");

		rowItm.setConfirmedQty(new java.math.BigDecimal("100"));
		java.math.BigDecimal dCQTY = new java.math.BigDecimal("100");
		java.math.BigDecimal cPrice= new java.math.BigDecimal("10");
		java.math.BigDecimal iValue= dCQTY.multiply(cPrice);
		tValue=tValue.add(iValue);
		
		
		
		
		
		rowItm.setBackEndOrder("");
		rowItm.setBackEndItem("50");
		tblRow.insertRow(0,rowItm);
		
		
		
		
		
		
		delRow.setItemNumber("1951");
		delRow.setScheduleLine("50");
		delRow.setRequiredQty("100");
		delRow.setRequiredDate("22/02/2006");
		delRow.setDateType("");
		delRow.setRequiredTime("");
		delRow.setBlockedDelLine("");
		delRow.setScheduleLineCat("");
		delRow.setTransPlanningDate("");
		delRow.setMaterialAvailDate("");
		delRow.setLoadDate("");
		delRow.setGoodsIssueDate("");
		delRow.setTransportPlanningTime("");
		delRow.setMaterialStagingTime("");
		delRow.setLoadTime("");
		delRow.setGoodsIssueTime("");
		delRow.setRefObjectType("");
		delRow.setReserved1("");
		delRow.setReserved2("");		
		delRow.setBackEndNumber("");
		delRow.setBackEndItem("");
		delTable.insertRow(0,delRow);
		
		
		
		ezcParams.setObject(iSOCrParams);
		ezcParams.setObject(delTable);
		
		
		
		
		
		ezc.sales.local.client.EzSalesManager EzSalesManager = new ezc.sales.local.client.EzSalesManager();
		
		
		
		EzSalesManager.ezAddSalesOrderLines(ezcParams);

		
		%>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp" %>
<%@ page import = "ezc.ezsap.*,java.util.*,ezc.ezutil.FormatDate" %>
<%@ include file="../../../Includes/Lib/ezSalesBean.jsp" %>
<%@ include file="../../../Includes/Lib/ezShoppingCartBean.jsp" %>
<%@ include file="../../../Includes/Lib/DateFunctions.jsp" %>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<html>
<%	
	EzcSalesOrderParams  ezcSalesOrderParams 	= new EzcSalesOrderParams();

	// BAPI Parameters
	EzBapisdheadStructure 	orderHeader 	= null;
	EzBapipartnrTable 	orderPartners 	= null;
	EzBapipartnrTableRow 	aRow 		= null;
	EzBapiiteminTable 	iteminTable 	= null;
	EzBapiiteminTableRow 	aItemRow 	= null;
	
	EziSalesOrderCreateParams smParams 	= null;
	EziSalesOrderCreateParams ioParams 	= null;
	
	EzoSalesOrderCreate 	osmParams 	= null;
	ReturnObjFromRetrieve 	priceRet 	= null;
	
	java.util.GregorianCalendar fromDate = null ;
	java.util.GregorianCalendar reqDate = null ;
	java.util.GregorianCalendar reqDateH = null ;
		
	fromDate = (java.util.GregorianCalendar)java.util.GregorianCalendar.getInstance();
	String agentCode	= (String)session.getValue("AgentCode");
	String PartnNum 	= agentCode;
	String inDate 		= "15/03/2007";
	String PONO 		= "Test";
	
	String product 	= request.getParameter("matNo");
	
	log4j.log("inDateinDateinDateinDateinDateinDate	"+inDate,"W");
	
	int dateReq 	= Integer.parseInt(inDate.substring(0,2));
	int monthReq 	= Integer.parseInt(inDate.substring(3,5));
	int yearReq 	= Integer.parseInt(inDate.substring(6,10));
	
	reqDateH 	= new java.util.GregorianCalendar(yearReq,monthReq-1,dateReq);
		
	EzcSalesOrderParams initParams = new EzcSalesOrderParams();
	EziSalesOrderCreateParams initCreateParams = new EziSalesOrderCreateParams();
	initParams.setObject(initCreateParams);
	Session.prepareParams(initParams);
	ioParams = (EziSalesOrderCreateParams)EzSalesOrderManager.initializeSalesOrder(initParams);
	
	//Set values for OrderHeader
		
	log4j.log("reqDateH.getTime()reqDateH.getTime()		"+reqDateH.getTime(),"W");
		
	orderHeader = ioParams.getOrderHeaderIn();
	orderHeader.setDivision("");
	orderHeader.setDistrChan("");
	orderHeader.setSalesOrg("");
	orderHeader.setLog("TRUE");
	orderHeader.setDocType((String)session.getValue("docType"));
	orderHeader.setPurchNo(PONO);
	orderHeader.setPoSupplem("WWW");
	orderHeader.setReqDateH(reqDateH.getTime());
	
	orderPartners = ioParams.getOrderPartners();

	if(PartnNum!=null)
		PartnNum = PartnNum.trim();
		
	if(PartnNum!=null)
	{
		aRow = new EzBapipartnrTableRow();
		aRow.setPartnRole("AG");
		aRow.setPartnNumb(PartnNum);
		orderPartners.insertRow(0, aRow);
	}
		
	//Set ordered items
	
	iteminTable = ioParams.getOrderItemsIn();
	aItemRow = new EzBapiiteminTableRow();
	aItemRow.setMaterial(product);	
	aItemRow.setBillDate(fromDate.getTime());
	java.math.BigDecimal bOrderQty  = new java.math.BigDecimal("100");
	bOrderQty = bOrderQty.multiply(new java.math.BigDecimal(Integer.toString(1000)));
	aItemRow.setReqQty(bOrderQty.toBigInteger());
	String prodDate = "15/03/2007";
	try{
		dateReq  = Integer.parseInt(prodDate.substring(0,2));
		monthReq = Integer.parseInt(prodDate.substring(3,5));
		yearReq  = Integer.parseInt(prodDate.substring(6,10));
		reqDate  = new java.util.GregorianCalendar(yearReq,monthReq-1,dateReq);
		aItemRow.setReqDate(reqDate.getTime());
	}catch(Exception e){
		log4j.log("dateReqdateReqdateReqdateReqinGetPrices "+e,"W");
	}
	//these are required for Multi Simulate
	
	aItemRow.setItmNumber(new java.math.BigInteger(String.valueOf((1)*10)));
	aItemRow.setShipTo(PartnNum);
	aItemRow.setSysKey((String)session.getValue("SalesAreaCode"));
	aItemRow.setPlant("1000");				
	aItemRow.setDocType((String)session.getValue("docType"));
	aItemRow.setSalesOrg((String)session.getValue("salesOrg"));
	aItemRow.setDistributionChanel((String)session.getValue("dC"));
	aItemRow.setDivision((String)session.getValue("division"));
	iteminTable.appendRow(aItemRow);
	
		
	EzBapischdlTable deliveryScheduleTable = new EzBapischdlTable();
	ioParams.setOrderDelSchedule(deliveryScheduleTable);
	ioParams.setType("RBPG");
	ezcSalesOrderParams.setObject(ioParams);
	Session.prepareParams(ezcSalesOrderParams);
	osmParams = (EzoSalesOrderCreate)EzSalesOrderManager.ezSimulateWebSalesOrder(ezcSalesOrderParams);
	ReturnObjFromRetrieve itemoutTable = (ReturnObjFromRetrieve)osmParams.getOrderItemsOut();
	String netVal=itemoutTable.getFieldValueString(0,"NetValue1");
	double natVal1=Double.parseDouble(netVal)*0.01;
	java.text.DecimalFormat myFormatter = new java.text.DecimalFormat("###.##");
	String output = myFormatter.format(natVal1);
%>
<body scroll="no">
<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:80%;height:60%;left:15%;top:30%" >
<Table width="100%" id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0>
	<tr> 
	<th align="left">Material</th>
	<td><%=itemoutTable.getFieldValue(0,"MatEntrd") %></td>
	</tr>
	<tr> 
	<th align="left">Material Description</th>
	<td> <%=itemoutTable.getFieldValue(0,"ShortText") %></td>
	</tr>
	<tr>
	<th align="left">Sales Unit</th>
	<td><%=itemoutTable.getFieldValue(0,"SalesUnit") %></td>
	</tr>
	<tr>
	<th align="left">Price</th>
	<td> <%=output%></td>
	</tr>
</table>
<br><br>
<center>
<%
    	buttonName   = new java.util.ArrayList();
    	buttonMethod = new java.util.ArrayList();
    		
	buttonName.add("Close");
	buttonMethod.add("window.close()");
   		
    	out.println(getButtonStr(buttonName,buttonMethod));
%>
</center>
</div>
</body>
</html>

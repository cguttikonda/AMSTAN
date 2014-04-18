<%@ page import = "ezc.ezutil.FormatDate,java.util.*,java.io.*" %>
<%@ page import ="ezc.client.EzcUtilManager"%>
<jsp:useBean id="CustomerManager" class="ezc.ezcustomer.client.EzCustomerManager" scope = "page"></jsp:useBean>
<%@ include file="../../../Includes/Lib/ezGlobalBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezAddress.jsp"%>

<%
	String fromDate = request.getParameter("FromDate");  // don't delete
	String toDate = request.getParameter("ToDate");
	String orderStatus=request.getParameter("status");
	String newFilter=request.getParameter("newFilter");
	String xsdFileName=request.getParameter("xmlFileName");
	if("null".equals(xsdFileName))	xsdFileName="EzLocalSales";
%>
<%@ include file="../../../Includes/JSPs/Sales/iLocalSalesDetails.jsp" %>
<%
	EzcCustomerParams customerParams = new EzcCustomerParams();
	EzCustomerStructure ezCustomerStructure = new EzCustomerStructure();
	ezCustomerStructure.setLanguage("EN");
	customerParams.setObject(ezCustomerStructure);
	Session.prepareParams(customerParams);
	ReturnObjFromRetrieve retAdd = (ReturnObjFromRetrieve)CustomerManager.getCustomerAddress(customerParams);

	ezc.ezparam.ReturnObjFromRetrieve tempLines =retLines;
	ezc.ezparam.ReturnObjFromRetrieve tempHead =sdHeader;

	Vector columntype= new Vector();
	columntype.addElement("date");
	columntype.addElement("currency");
	EzGlobal.setColTypes(columntype);

	Vector columnname= new Vector();
	columnname.addElement("REQ_DATE");
	columnname.addElement("DESIRED_PRICE");
	EzGlobal.setColNames(columnname);
	ezc.ezparam.ReturnObjFromRetrieve retGlobal = EzGlobal.getGlobal(retLines);
	int tempLinesCount=tempLines.getRowCount();
	Double grandTotal =new Double("0");
	tempLines.addColumn("NET_VALUE");
	tempHead.addColumn("GRAND_TOTAL");
	java.math.BigDecimal bPrice = null;
	java.math.BigDecimal bUprice=null;
	java.math.BigDecimal bQty=null;
	java.math.BigDecimal trncateMRP=null;
	String price="";
	String netPrice="";
	String prodQty="";
	String invoicedt="";
	String productMRP="";
	String prodCategory="";
	for( int k=0;k<tempLinesCount;k++)
     	{
		invoicedt=retGlobal.getFieldValueString(k,"REQ_DATE");
		if("01.01.1900".equals(invoicedt))
			invoicedt="";
		productMRP = retLines.getFieldValueString(k,"DESIRED_PRICE");
		prodCategory= retLines.getFieldValueString(k,"ITEM_CATEGORY");

		productMRP=(productMRP==null || "null".equals(productMRP))?"0":productMRP.trim();
		trncateMRP =new java.math.BigDecimal(productMRP);
		price =(trncateMRP.setScale(2,java.math.BigDecimal.ROUND_HALF_UP)).toString();
		if("EzSalesOrder".equals(xsdFileName)){
			prodQty = retLines.getFieldValueString(k,"DESIRED_QTY");
			bUprice = new java.math.BigDecimal(price);
			bQty = new java.math.BigDecimal(prodQty);
			bPrice = bQty.multiply(bUprice);
			grandTotal=new Double(grandTotal.doubleValue()+bPrice.doubleValue());
			netPrice = (bPrice.setScale(2,java.math.BigDecimal.ROUND_HALF_UP)).toString();
			tempLines.setFieldValueAt("NET_VALUE",netPrice,k);
		}else{
			if("RENN".equals(prodCategory)){
				tempLines.setFieldValueAt("ITEM_CATEGORY","Bonus",k);
			}else
				if("YREN".equals(prodCategory)){
					tempLines.setFieldValueAt("ITEM_CATEGORY","FRS",k);
				}else
					tempLines.setFieldValueAt("ITEM_CATEGORY","",k);
		}
		tempLines.setFieldValueAt("DESIRED_PRICE",price,k);
		tempLines.setFieldValueAt("REQ_DATE",invoicedt,k);
 	}
	columntype= new Vector();
	columntype.addElement("date");
	EzGlobal.setColTypes(columntype);

	columnname= new Vector();
	columnname.addElement("ORDER_DATE");
	EzGlobal.setColNames(columnname);
	retGlobal = EzGlobal.getGlobal(sdHeader);
	String orDate=retGlobal.getFieldValueString("ORDER_DATE");
	String orNo=sdHeader.getFieldValueString("BACKEND_ORNO");
	try{
		orNo =Integer.parseInt(orNo)+"";
	}catch(Exception e){
		if(!("null".equals(BakOrNo)))
		{
		orNo =Integer.parseInt(BakOrNo)+"";
		}
	}
	tempHead.setFieldValueAt("GRAND_TOTAL",grandTotal,0);
	tempHead.setFieldValueAt("ORDER_DATE",orDate,0);
	tempHead.setFieldValueAt("BACKEND_ORNO",orNo,0);


	java.util.Hashtable ht1=new java.util.Hashtable();
	ht1.put("Header",tempHead);
	ht1.put("Lines",tempLines);
	ht1.put("CustomerAddress",retAdd);
	ht1.put("SoldTo",sdSoldTo);
	ht1.put("ShipTo",sdShipTo);

	java.util.ResourceBundle bundle=java.util.ResourceBundle.getBundle("Site");
	String filePath=bundle.getString("XSLTEMPDIR");

	filePath += "EzSales\\";
	String filePath1=filePath;
	filePath += "Temp\\";
	filePath += xsdFileName+"_"+session.getId()+"_"+Session.getUserId()+".xml";
	ezc.ezbasicutil.EzXML xml=new ezc.ezbasicutil.EzXML();
	ByteArrayOutputStream bos = new ByteArrayOutputStream();
	//xml.generate(ht1,"EzLocalSales",filePath);
	xml.generate(ht1,"EzLocalSales",bos);
		try{
			ezc.ezbasicutil.EzPDF pdf=new ezc.ezbasicutil.EzPDF();
			//pdf.getPDF(filePath,filePath1+xsdFileName+".xsl",response,webOrNo.trim());
			pdf.getPDF(bos.toByteArray(),filePath1+xsdFileName+".xsl",response,webOrNo.trim());
		}catch(Exception e){
			System.out.println(e);
	%>
			<html>
			<head>
			<title>Welcome</title>
			<head>
			<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
			<script>
			function funShow(myURL)
			{
				document.body.style.cursor="wait"
				top.document.location.replace(myURL)
			}
			</script>
			</head>
			<body>
			<br><br><br><table align=center><tr><td class=displayalert>Problem In Print Creation</td></tr></table>
			<br><center><img src='../../Images/Buttons/<%= ButtonDir%>/ok.gif' style='cursor:pointer;cursor:hand' onClick=funShow('../Misc/ezMain.jsp')></center>

	<%
		}

%>
<Div id="MenuSol"></Div>
</body>
</html>

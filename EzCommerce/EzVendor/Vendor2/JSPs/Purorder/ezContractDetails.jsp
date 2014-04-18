<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/Lib/PurchaseBean.jsp"%>
<%@ page import = "ezc.ezutil.FormatDate"%>
<%@ include file="../../../Includes/Lib/DateFunctions.jsp"%>
<%@ page import="java.math.*"%>
<%@ page import = "java.util.*"%>
<%@ page import ="ezc.ezparam.*" %>
<html>
<head>
<jsp:useBean id="PcManager" class ="ezc.client.EzPurContractManager" scope="page"></jsp:useBean>
<%
	String userType 	= (String) session.getValue("UserType");
	
	ezc.ezbasicutil.EzCurrencyFormat myFormat= new ezc.ezbasicutil.EzCurrencyFormat();
	myFormat.setLocale((java.util.Locale)session.getValue("LOCALE"));
	myFormat.setNeedSybmol(((Boolean)session.getValue("SREQUIRED")).booleanValue());
	myFormat.isPre(((Boolean)session.getValue("CPOSITION")).booleanValue());
	myFormat.setSymbol((String)session.getValue("CURRENCY"));

	FormatDate formatDate = new FormatDate();
	final String contract = "CONTRACT";
	final String position = "POSITION";
	final String cntrtype = "CONTRACTTYPE";
	final String item = "ITEM";
	final String uom = "UOMPURCHASE";
	final String amount = "AGREEDQUANTITY";
	final String itemdesc = "ITEMDESCRIPTION";
	final String contrdate = "CONTRACTDATE";
	final String agqty = "AGREEDQUANTITY";
      	final String price = "GROSSNETPRICEYN";

	Date cdate = null;
	Date exdate = null;
	EzPurchCtrDtlXML dtlxml = null;
	EzPSIInputParameters ioparams = new EzPSIInputParameters();
	ezc.ezparam.EzcPurchaseParams newParams = new ezc.ezparam.EzcPurchaseParams();
	newParams.createContainer();
	newParams.setObject(ioparams);
	Session.prepareParams(newParams);

	String contractNum = request.getParameter("contractNum");
	contractNum = "0000000000"+contractNum;
	contractNum = contractNum.substring(contractNum.length()-10,contractNum.length());

	String contractValue = request.getParameter("contractValue");
	String currency = request.getParameter("currency");
	if (currency==null){
		currency="null";
	}
	ioparams.setOrderNumber(contractNum);
	Session.prepareParams(ioparams);

	dtlxml = (EzPurchCtrDtlXML)PcManager.getPurchaseContractStatus(newParams);
	cdate = (Date)dtlxml.getFieldValue(0, contrdate);
	exdate = (Date)dtlxml.getFieldValue(0,"VATID");// Desired delivery date is
							// expected to get expiry date
	String exdateString = formatDate.getStringFromDate(exdate,(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
	if ((exdateString==null) || (exdateString=="")){
		exdateString = "Null";
	}
	String orderType = request.getParameter("orderType");
%>
<title>Contract Details</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<Script>
var tabHeadWidth=96
var tabHeight="45%"
</Script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<script>
	function selectOption()
	{
		var hWnd = window.showModalDialog("ezSelectPrintOption.jsp","UserWindow","center=yes;dialogHeight=20;dialogWidth=33;help=no;titlebar=no;status=no;minimize:yes");

		if(hWnd!=null)
		{
			if (hWnd=='All'){
				window.open("ezPrintFrame.jsp?purorder=<%=contractNum%>","PoPrint","menubar=no,statusbars=no,toolbar=no,width=700,height=550,left=10,top=10");
			}
			else{
			    datValues = hWnd.split("###")
			    urlStr="ezSchAgmntPrintFrame.jsp?purorder=<%=contractNum%>&fromDate="+datValues[0]+"&toDate="+datValues[1]
			    window.open(urlStr,"PoPrint","menubar=no,statusbars=no,toolbar=no,width=700,height=550,left=10,top=10");
			}
		    
		}

	}	

	function formEvents1(formEv)
	{		
		window.open(formEv,"PoPrint","menubar=no,statusbars=no,toolbar=no,width=700,height=600,left=10,top=10");
	}
	
	function formEvents(file)
	{
		document.myForm.action=file
		document.myForm.submit()
	}
	
	function funLinkContractDetails(fileName,currency,contractNum,position,unit,contractValue,OrderDate,orderType)
	{
		document.location.href=fileName+"?currency="+currency+"&contractNum="+contractNum+"&position="+position+"&unit="+unit+"&contractValue="+contractValue+"&OrderDate="+OrderDate+"&orderType="+orderType
	}
	function goToPlantAddr(plant)
	{
		window.open("ezPlantAddress.jsp?plant="+plant,"plantdet", "status=no,toolbar=no,menubar=no,location=no,width=320,height=320,left=280,top=200");
	}
</script>
</head>
<body bgcolor="#FFFFF7" onLoad="scrollInit()" onResize="scrollInit()" scroll=no>
<%
if (dtlxml.getRowCount()==0)
{
%>
<br><br><br><br>
<TABLE width="70%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
  <tr>
    <td align=center>No Schedule Agreements available with the given Number. </td>
  </tr>
</table>
<%
}
else
{
	String display_header	= "Schedule Agreement Details";
	
%>

<form method="post" name="myForm">
<input type="hidden" name="chkField">
<input type="hidden" value="<%=formatDate.getStringFromDate(cdate,(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%>" name="OrderDate">
<!--
<TABLE width="50%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
  <tr align="center">
    <td class="displayheader"> Schedule Agreement Details </td>
  </tr>
</table>
-->
<%@ include file="../Misc/ezDisplayHeader.jsp" %>
<br>
    <table width="80%" align="center" bgcolor="#FFFFF7" bordercolor="#660066" border="1">
      <tr>
        <th width="20%" bordercolor="#FFFFF7" >Agreement No </th>
        <td width="10%" bordercolor="#FFFFF7" ><%= Long.parseLong(contractNum) %></td>
        <th width="8%"  bordercolor="#FFFFF7"> Date</th>
        <td width="10%" bordercolor="#FFFFF7"><%=formatDate.getStringFromDate(cdate,(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%></td>
        <th width="14%" bordercolor="#FFFFF7"> Valid Upto</th>
        <td width="10%" bordercolor="#FFFFF7"><%=exdateString%></td>
        <th width="14%" bordercolor="#FFFFF7"> Value[<%=currency%>]</th>
        <td width="10%" bordercolor="#FFFFF7"><%=contractValue%></td>
      </tr>
    </table>
  <br>
<TABLE align="center">
<tr>
<td  align="center" class="blankcell">*Materials in this page are sorted such that the latest changed materials will be on the top for easy reference</td>
</tr>
</table>
<DIV id="theads">
<table id="tabHead" width="96%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
    <tr align="center">
      <th width="6%">Line</th>
      <th width="11%">Material</th>
      <th width="24%">Description</th>
      <th width="6%">UOM</th>
      <th width="12%">Qty</th>
      <th width="11%">Price[<%=currency%>]</th>
      <th width="14%"> Value[<%=currency%>]</th>
       <th width="7%">Plant</th>
      <th width="9%">Delivery Sch. Lines</th>
    </tr>
</Table>
</DIV>

<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:96%;height:60%;left:2%">
<TABLE id="InnerBox1Tab" width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<%
String pono = "";
String matl = "";
String desc = "";
String oqty = "";
String pric = "";
String unit = "";
String amnt = "";
String revi = "";
String dell = "";
String plant="";
int contractRows = dtlxml.getRowCount();
for(int i=0; i<contractRows; i++){
	//contractNum = (String)dtlxml.getFieldValue(i, contract);

	pono = (String)dtlxml.getFieldValue(i, position);
	matl = (String)dtlxml.getFieldValue(i, item);
	matl = matl.trim();
	desc = (String)dtlxml.getFieldValue(i, itemdesc);
	oqty = dtlxml.getFieldValue(i, agqty).toString();
	pric = dtlxml.getFieldValueString(i, price);
	unit = (String)dtlxml.getFieldValue(i, uom);
//	amnt = (String)dtlxml.getFieldValue(i, amount);
//	revi = (String)dtlxml.getFieldValue(i, amount);
	cdate = (Date)dtlxml.getFieldValue(i, contrdate);
	plant = (String)dtlxml.getFieldValue(i, "PLANT");

	double qtynum = Double.parseDouble(oqty);
	double pricenum = Double.parseDouble(pric);
	amnt=myFormat.getCurrencyString(qtynum*pricenum);
//	pric=pric.substring(0,pric.indexOf(".")+3);
//	oqty=oqty.substring(0,oqty.indexOf(".")+3);
//	amnt=amnt.substring(0,amnt.indexOf(".")+3);

%>

    <tr>
      <td width="6%"><%=pono%></td>
      <td  width="11%"><%
	try{
		out.println(Long.parseLong(matl));
	}catch(NumberFormatException nfe)
	{
		out.println(matl);
	}
%> </td>
      <td  width="24%" title="<%=desc%>" alt="desc">
	<input type=text class=tx size=20 value="<%=desc%>" readonly>
	</td>
	  <td width="6%"align=center><%=unit%></td>
	   <td width="12%"  align="right"><%=oqty%></td>
	    <td  width="11%" align="right"><%=myFormat.getCurrencyString(pric)%></td>
      	     <td  width="14%" align=right><%=amnt%></td>
	      <td width="7%"align=center><a href="JavaScript:void(0)" onClick="goToPlantAddr('<%=plant%>')"><%=plant%></a></td>
      <td width="9%" align="center">
	<A href="JavaScript:funLinkContractDetails('ezDelDet.jsp','<%=currency%>','<%=contractNum%>','<%=pono%>','<%=unit%>','<%=contractValue%>','<%=formatDate.getStringFromDate(cdate,(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%>','<%=orderType%>')"  onMouseover="window.status='Click to view the Shedule Lines. '; return true" onMouseout="window.status=' '; return true">
	Go</a>
 </td>
    </tr>
<%
}
%>
</table>
</div>
<!--
<div id="back" style="position:absolute;top:89%;left:43%">
<a href='javascript:history.go(-1)' onMouseover="window.status=' back'; return true" onMouseout="window.status=' '; return true"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif"  border="none" valign=bottom ></a>-->
<%
//if(orderType.equals("Open")||orderType.equals("New"))
//{
%>
<!--<img src="../../Images/Buttons/<%//ButtonDir%>/printversion.gif"  border="none" valign=bottom style="cursor:hand" onClick="formEvents('ezPrint.jsp')">-->
<%
//}
  %>
<!--
</div>
<div id="head1" style="position:absolute;top:95%;left:25%">
<center><font size=1>The value of the Agreement is before Discounts,taxes, duties and levies</font></center>
</div>--->
<Div id="ButtonDiv" style="position:absolute;top:90%;width:100%;visibility:visible">
<center>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();

	buttonName.add("Back");
	buttonMethod.add("javascript:history.go(-1)");
	
	/*if(orderType.equals("Open") && (!userType.equals("2")))*/
	if(!userType.equals("2"))
	{
		buttonName.add("Add Shipments");
		buttonMethod.add("formEvents(\"../Shipment/ezAddShipmentDetails.jsp\")");
	}	

	out.println(getButtonStr(buttonName,buttonMethod));
%>
</center>
</div>
<div id="head1" style="position:absolute;top:95%;width:100%">
	<center><font size=1>The value of the Agreement is before Discounts,taxes, duties and levies</font></center>
</div>
<%@ include file="../Misc/backButton.jsp" %>
<%@ include file="../Misc/AddMessage.jsp" %>


<%
}

%>

<input type=hidden name="currency" value=<%=currency%> >
<input type=hidden name="PurchaseOrder" value='<%=contractNum%>'>

<input type="hidden" name="ponum" value="<%=contractNum%>">
<input type="hidden" name="showData" value="Y">
<input type="hidden" name="backFlg" value="Y">
<input type="hidden" name="orderBase" value="con">



</form>
<Div id="MenuSol"></Div>
</body>
</html>

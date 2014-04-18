<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/PurchaseBean.jsp"%>
<%@ page import="ezc.ezpurchase.csb.*" %>
<%@ page import = "ezc.ezutil.FormatDate"%>
<%@ include file="../../../Includes/Lib/DateFunctions.jsp"%>
<jsp:useBean id="PoManager" class="ezc.client.EzPurchaseManager" scope="page">
</jsp:useBean>
<%

//String Jndi_Name = "EzcPurchaseObjectHome";
//EzcPurchaseObject purObj = (EzcPurchaseObject)Session.ezcFind(Jndi_Name);
FormatDate formatDate = new FormatDate();
final String order = "PURCHASEORDER";
final String pos = "POSITIONNUMBER";
final String seqn = "SEQUENCENUMBERPO";
final String recno = "RECEIPTNUMBER";
final String recdt = "RECEIPTDATE";
final String delqty = "DELIVEREDQTY";
final String backqty = "BACKORDERQTY";
final String matl = "ITEM";
final String puom = "PURCHASEUNIT";
final String rrej = "REASONFORREJECTION";
final String rqty = "REJECTEDQUANTITY";
final String aqty = "APPROVEDQUANTITY";
final String deldt = "CURRENTPLANNEDDELIVERYDATE";
final String rdesc  = "REASONFORREJECTIONDESCRIPTION";
final String amnt="AMOUNT";
final String dcNum="REFDOCNO";
String delNum="";
String vorder = "";
String vpos = "";
String vseqn = "";
String vrecno = "";
Date vrecdt = null;
String vdelqty = "";
String vbackqty = "";
String vmatl = "";
String vpuom = "";
String vrrej = "";
String vrqty = "";
String vaqty = "";
Date vdeldt = null;
String vrdesc = "";

String ponum = request.getParameter("order");  
String polin = request.getParameter("line"); 
String desc = request.getParameter("material"); 
String dcNumber=request.getParameter("DCNumber");
String GRFlag=request.getParameter("GRFlag");
if(dcNumber!=null){
dcNumber=dcNumber.trim();
}
//String ponum = "0040000002";  //MB.s
//String polin = "10"; 
//String desc = "100107.";  //MB.e

EzPSIInputParameters iparams = new EzPSIInputParameters();
ezc.ezparam.EzcPurchaseParams newParams = new ezc.ezparam.EzcPurchaseParams();
newParams.createContainer();
newParams.setObject(iparams);
Session.prepareParams(newParams);

// Vendor Number is hardcoded you can remove afterwards  
//iparams.setVendorNumber("VENDOR1");
EzPurchaseReceipts retobj = new EzPurchaseReceipts();

iparams.setOrderNumber(ponum);
iparams.setPositionNum(polin);



if(GRFlag==null){
retobj =  (EzPurchaseReceipts)PoManager.ezPurchaseOrderReceiptsByDCNumber(newParams,dcNumber);
}
else{

retobj =  (EzPurchaseReceipts)PoManager.ezPurchaseOrderReceiptsByGRNumber(newParams,dcNumber);
}



if(retobj.getRowCount()>0){
vrecdt =(Date)retobj.getFieldValue(0, recdt);




double totalValue=0.00;

for(int j=0;j<retobj.getRowCount();j++)
{
		String netAmount = (String)retobj.getFieldValue(j, amnt);
		double nAmt=0.00;
		if(netAmount!=null){
			netAmount=netAmount.trim();
			if(netAmount.equals("null")){
				nAmt=0.00;
				}
				else{ 
					nAmt=Double.valueOf(netAmount).doubleValue();
				}
				totalValue=totalValue+nAmt;
			}
}
 
%>

<html>
<head>
<title>Purchase Order Receipts</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="../../../../vendor/vendor1/Library/Styles/Theme1.css"><%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %></head>
<body bgcolor="#FFFFF7">
<table width="55%" border="0" align="center">
  <tr align="center"> 
    <td class="displayheader">Purchase Order Receipts</td>
  </tr>
</table>
<p>&nbsp;</p>
<div align="left">
  <table width="59%" border="0" align="center">
    <tr align="center" valign="middle"> 
      <th width="19%"> Order No</th>
      <td width="30%"><%=ponum%></td>
      <th width="22%"> Date</th>
	<td width="29%"><%=formatDate.getStringFromDate(vrecdt,(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%></td>
	<th width="22%"> Value</th>
      	<td width="29%"><%=totalValue%></td>
    </tr>
  </table>
</div>
<table width="82%" border="0" align="center">
  <tr align="center" valign="middle"> 
    <th width="5%"> Line No</th>
    <th width="7%"> Material Number</th>
    <th width="9%"> Material Description</th>
    <th width="8%"> DC Number</th>
    <th width="8%"> GR No.</th>
    <th width="8%">Gr Date</th>
    <th width="9%">Delivered Quantity</th>
    <th width="8%">Approved Quantity</th>
    <th width="9%">Rejected Qty</th>
    <th width="8%">Status</th>
  
  </tr>
  <%
if(retobj!=null){
	int noofrows = retobj.getRowCount();
if (noofrows ==0)
{
%>
  <table width="122%" border="0" align="center">
    <tr align="center"> 
      <td width="82%" height="21">No Sub Items present for this item</td>
    </tr>
  </table>
  <%
}
else {



for (int i=0; i < noofrows ; i++)
{
	vorder = "";
	vpuom = (String)retobj.getFieldValueString(i, puom);
	vpos = (String)retobj.getFieldValueString(i, pos);
	//vseqn = (String)retobj.getFieldValueString(i, seqn);
	vrecno = (String)retobj.getFieldValueString(i, recno);
	vrecdt =(Date)retobj.getFieldValue(i, recdt);
	vdelqty = (String)retobj.getFieldValueString(i, delqty);
	//vdelqty  = vdelqty  + vpuom;
	//vbackqty = (String)retobj.getFieldValueString(i, backqty);
	//vbackqty  = vbackqty  + vpuom;
	vmatl = (String)retobj.getFieldValueString(i, matl);
	//vrrej = (String)retobj.getFieldValueString(i, rrej);
	vrqty = (String)retobj.getFieldValueString(i, rqty);

	vaqty =(String)retobj.getFieldValueString(i, delqty);
	vdeldt =(Date)retobj.getFieldValue(i, deldt);
	vrdesc =(String)retobj.getFieldValueString(i, rdesc);
	delNum =(String)retobj.getFieldValueString(i, dcNum);

%>
  <tr align="center"> 
    <td width="5%"><%=polin%></td>
    <td width="7%"><%=vmatl%></td>
    <td width="9%"><%=desc%></td>
    <td width="8%"><%=delNum%></td>
    <td width="8%"><%=vrecno%></td>

    <td width="8%"><%=formatDate.getStringFromDate(vdeldt,(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%></td>
   <td width ="9%"><%=vdelqty%></td>
   <td width="9%"><%=vaqty%></td>
  <%
	if(vaqty.equals("0.000")){ %>
		 <td width ="8%" align="right"><%=vrqty%></td>
	<% }else{%>
		<td width ="8%" align="right"><a href="ezReasonForRejection.jsp?Reason=<%=vrdesc%>&order=<%=ponum%>&line=<%=polin%>"><%=vrqty%></a></td>
	<%}%>
    <td width="8%"><%=""%></td>
  </tr>
  
  
  
  <%
}
}
}
%>
</table>
<p align="center"><b><font color="red">Rejected Quantity hyperlink takes you to Rejection Reasons</font></b></p>

<%}else{
%>
<p align="center"><b><font color="red">No Receipts Exist For This Search </font></b></p>

<% }%>
<Div id="MenuSol"></Div>
</body>
</html>

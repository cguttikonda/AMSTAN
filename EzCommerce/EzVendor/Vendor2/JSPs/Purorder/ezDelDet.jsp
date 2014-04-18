<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/Lib/PurchaseBean.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<%@ page import ="ezc.ezparam.*" %>
<%@ page import ="java.util.*" %>
<%@ page import ="ezc.ezutil.FormatDate" %>
<jsp:useBean id="PcManager" class ="ezc.client.EzPurContractManager" scope="page"></jsp:useBean>

<%
	Hashtable ht = new Hashtable();
	String orderType = request.getParameter("orderType");
	final String  lineNum="LINENUM";
	final String  order="CONTRACT";
	final String  material="MATERIAL";
	final String  description="MATDESC";
	final String  units="PURCHASEUNIT";
	final String  dlvdate="PLANNEDDELIVERYDATE";
	final String  qty="QUANTITY";
	Date  ddate=null;

	FormatDate formatDate = new FormatDate();
	//EzPurchCtrDSched dsched = null;
	ReturnObjFromRetrieve dsched=null;
	EzPSIInputParameters ioparams = new EzPSIInputParameters();
	ezc.ezparam.EzcPurchaseParams newParams = new ezc.ezparam.EzcPurchaseParams();
	ezc.ezpurchase.params.EziPurOrderDetailsParams testParams=new ezc.ezpurchase.params.EziPurOrderDetailsParams();

	//Vendor Number is hardcoded you can remove afterwards
	//ioparams.setVendorNumber("VENDOR1");

	String contractNum 	= request.getParameter("contractNum");
	String position 	= request.getParameter("position");
	String punit 		= request.getParameter("units");
	String orderDate 	= request.getParameter("OrderDate");
	String contractValue 	= request.getParameter("contractValue");
	//out.println("position::"+position);

	ioparams.setOrderNumber(contractNum);
	ioparams.setPositionNum(position);
	//starting addition --- by vasu
	//ioparams.setVendorNumber("VENDOR333");
	//ioparams.setMaterial("HCL");
	//ioparams.setCostCenter("cc");
	//ioparams.setCompanyCode("cc");
	//ending addition ---- by vasu
        newParams.createContainer();
	newParams.setObject(ioparams);
	newParams.setObject(testParams);
	Session.prepareParams(newParams);

	String oqty="";
	ezc.ezcommon.EzLog4j.log("Delivery Sched :: Before ezPurchaseContractDeliverySchedule() in ezDelDet.jsp","I");
	dsched = (ReturnObjFromRetrieve)PcManager.ezPurchaseContractDeliverySchedule(newParams);
	ezc.ezcommon.EzLog4j.log("Delivery Sched :: After ezPurchaseContractDeliverySchedule() in ezDelDet.jsp"+dsched.toEzcString(),"I");

	//out.println(dsched.toEzcString());
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	int desc = dsched.getRowCount();

	if(desc != 0){
	for (int i = 0 ; i < desc; i++)
	{
		oqty =dsched.getFieldValue(0, qty).toString();
		if(oqty.equals("null")){
			oqty="";
		}
		ddate = (Date)dsched.getFieldValue(i, dlvdate);
		punit = (String)dsched.getFieldValue(i, units);
	}

	if(orderType == null)
		orderType="";
	//out.println("orderType:"+orderType);
	String display_header	= "Delivery Schedule List";
%>
<html>
<head>
<Script>
var tabHeadWidth=75
var tabHeight="40%"
</Script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<script>
function formEvents(formEv)
{
	document.myForm.action=formEv;
	document.myForm.submit();
}
</script>
</head>
<body bgcolor="#FFFFF7"  onLoad="scrollInit()" onResize="scrollInit()" scroll=no>
<form name=myForm>
<!--
<table id="Table1" width="50%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
  <tr align="center">
    <td class="displayheader">Delivery Schedule List</td>
  </tr>
</table>
-->
<%@ include file="../Misc/ezDisplayHeader.jsp" %>
<br>
<table width="75%" align="center" bgcolor="#FFFFF7" bordercolor="#660066" border="1">
      <tr>
        <th align="left" bordercolor="#FFFFF7">Agreement No </th>
        <td align=left bordercolor="#FFFFF7">
		<%try{
			out.println(Long.parseLong(contractNum));
		}catch(Exception numFmtEx)
		{
			out.println(contractNum);
		}
		%>
	</td>

        <th align="left" bordercolor="#FFFFF7">Line</th>
        <td align=left bordercolor="#FFFFF7"><%=position%></td>
	<%
		Hashtable htMat = new Hashtable();
		htMat.put(position,dsched.getFieldValueString(0, description));
		session.setAttribute("materialDesc",ht);
	%>
      </tr>
      <tr>
        <th align="left" bordercolor="#FFFFF7">Material  </th>
         <td align=left bordercolor="#FFFFF7">
		<%
			String dsc = dsched.getFieldValueString(0, material);
			try{
				out.println(Long.parseLong(dsc));
			}catch(Exception numFmtEx)
			{
				out.println(dsc);
			}
			//ht.put(dsc,dsched.getFieldValueString(0, description));
		%>
	</td>
        <th align="left" bordercolor="#FFFFF7">Description</th>
        <td align=left bordercolor="#FFFFF7"><%=dsched.getFieldValueString(0, description)%></td>
      </tr>
<%
	//out.println(position+"   "+position.length());
	ht.put(position,dsched.getFieldValueString(0, description));
	session.setAttribute("materialDesc",ht);
	Hashtable ht1= new Hashtable();
	ht1.put(position,dsched.getFieldValueString(0, material));
	session.setAttribute("materialNos",ht1);

%>
    </table>
	<br>
<DIV id="theads">
<table id="tabHead" width="75%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
  <tr>

    <th width="35%" >Req. Date</th>

    <th width="30%" >UOM</th>

    <th width="35%" > Qty</th>

</tr>
</Table>
</DIV>


<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:75%;height:60%;left:2%">
<TABLE id="InnerBox1Tab" width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<%
 	for (int i = 0 ; i < dsched.getRowCount(); i++)
	{
		oqty = dsched.getFieldValue(i, qty).toString();
		if(oqty.equals("null"))
		{
		oqty="";
			}

		ddate = (Date)dsched.getFieldValue(i, dlvdate);

		punit = (String)dsched.getFieldValue(i, units);

//ddate
%>
	<tr>

    <td  width="35%" align="center"><%=formatDate.getStringFromDate(ddate,(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%></td>

    <td  width="30%" align="center">
      <%=punit%>
    </td>

    <td  width="35%" align="right"><%=oqty%>&nbsp;&nbsp;</td>
	</tr>
<%
}

%>
</table>
</div>
<Div id="ButtonDiv" style="position:absolute;top:90%;width:100%;visibility:visible">
<center>
<%
	String userType = (String)session.getValue("UserType");
	if(userType == null) userType="";
	 
	buttonName.add("Back");
	buttonMethod.add("javascript:history.go(-1)");
	
	if(orderType.equals("Open") && (!userType.equals("2")) ){
		buttonName.add("AddShipments");
		buttonMethod.add("formEvents(\"../Shipment/ezAddShipmentDetails.jsp\")");
	}
	
	buttonName.add("View Shipments");
	buttonMethod.add("formEvents(\"../Shipment/ezViewShipmentHeader.jsp\")");
	
	buttonName.add("View Receipts");
	buttonMethod.add("formEvents(\"ezPoReceiptDetails.jsp\")");
	
	buttonName.add("Payment Details");
	buttonMethod.add("formEvents(\"ezPOPaymentDetails.jsp\")");
	
	out.println(getButtonStr(buttonName,buttonMethod));
%>
	</center>
	</div>
	
<%@ include file="../Misc/backButton.jsp" %>
<%@ include file="../Misc/AddMessage.jsp" %>
<%
}
if (desc ==0)
{
String noDataStatement	= "No Delivery Schedules exist.";
%>

<html>
<head></head>
<body scroll="no">
<%@ include file="../Misc/ezDisplayNoData.jsp" %>

<Div id="ButtonDiv" style="position:absolute;top:90%;width:100%;visibility:visible">
<center>
<%
buttonName.add("Back");
buttonMethod.add("javascript:history.go(-1)");
out.println(getButtonStr(buttonName,buttonMethod));

%>
</center>
</div>
<%


}
else
{
 	for (int i = 0 ; i < dsched.getRowCount(); i++)
	{
		oqty = dsched.getFieldValue(i, qty).toString();
		if(oqty.equals("null")){
		oqty="";
		}
		ddate = (Date)dsched.getFieldValue(i, dlvdate);
		punit = (String)dsched.getFieldValue(i, units);
	}
}
String currency=request.getParameter("currency");

%>

<input type=hidden name=PurchaseOrder value="<%=contractNum%>">
<input type=hidden name=OrderValue value="<%=contractValue%>">
<input type=hidden name=POPrice value="<%=contractValue%>">
<input type=hidden name=baseValues value="<%=contractNum%>">
<input type=hidden name=orderCurrency value="<%=currency%>">
<input type=hidden name=line value="<%=position%>">
<input type=hidden name=material value="<%=dsched.getFieldValueString(0, material)%>">
<input type=hidden name=materialDescFromCtr value="<%=dsched.getFieldValueString(0, description)%>">
<input type=hidden name=base value="PContracts">
<input type=hidden name=OrderDate value="<%=orderDate%>">
<input type=hidden name=orderType value="<%=orderType%>">
<input type=hidden name ="currency" value=<%=currency%> >

<input type="hidden" name="ponum" value="<%=contractNum%>">
<input type="hidden" name="showData" value="Y">
<input type="hidden" name="backFlg" value="Y">
<input type="hidden" name="orderBase" value="con">





</form>
<% session.setAttribute("materialDesc",ht); %>
<Div id="MenuSol"></Div>
</body>
</html>

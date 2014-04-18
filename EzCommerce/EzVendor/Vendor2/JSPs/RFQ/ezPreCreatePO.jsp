<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<%@ page import="ezc.ezutil.FormatDate,java.util.Date,javax.xml.parsers.*,org.w3c.dom.*,ezc.ezparam.ReturnObjFromRetrieve" %>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%
	String collRfq = request.getParameter("chk1");

	ezc.ezpreprocurement.client.EzPreProcurementManager  PreProcurementManager	= new ezc.ezpreprocurement.client.EzPreProcurementManager();
	ezc.ezparam.EzcParams 				     ezcparams			= new ezc.ezparam.EzcParams(false);
	ezc.ezpreprocurement.params.EziRFQHeaderParams 	     ezirfqheaderparams 	= new ezc.ezpreprocurement.params.EziRFQHeaderParams();
	ezirfqheaderparams.setExt1("CPO");
	ezirfqheaderparams.setCollectiveRFQNo(collRfq);
	ezcparams.setObject(ezirfqheaderparams);
	ezcparams.setLocalStore("Y");
	Session.prepareParams(ezcparams);
	ezc.ezparam.ReturnObjFromRetrieve myRet = (ezc.ezparam.ReturnObjFromRetrieve)PreProcurementManager.ezGetRFQList(ezcparams);
	
	int rowCount = 0;
	if(myRet!=null)
		rowCount = myRet.getRowCount();
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<Script>
var tabHeadWidth=96
var tabHeight="65%"
</Script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<Script>
	function createPO()
	{
		var len=document.myForm.chkradio.length
		var myVal = "";
		if(isNaN(len))
		{
			if(document.myForm.chkradio.checked)
				myVal = document.myForm.chkradio.value
		}
		else
		{
			for(var a=0;a<len;a++)
			{
				if(document.myForm.chkradio[a].checked)
					myVal = document.myForm.chkradio[a].value
			}
		}
		
		if(myVal == "")
		{
			alert("Please select RFQ No to create PO");
		}
		else
		{
			var obj=myVal.split(",")
			//alert(obj.length)
			var typ = obj[0]
			var vend= obj[1]
			var mat = obj[2]
			var plnt= obj[3]
			var qty = obj[4]
			var uom = obj[5]
			var dt  = obj[6]
			
			document.myForm.action="ezCreatePO.jsp?chk1="+typ+"&vend="+vend+"&material="+mat+"&plant="+plnt+"&quantity="+qty+"&uom="+uom+"&reqDate="+dt+"&fromRFQ=Y"
			document.myForm.submit();
		}
	}
</Script>
</head>
<body onLoad="scrollInit()" onResize="scrollInit()" scroll=no>
<form name="myForm" method="Post">

<%
	String display_header = "";
	if(rowCount > 0)
	{
		display_header = "Collective RFQs List";
%>
		<%@ include file="../Misc/ezDisplayHeader.jsp"%>

		
		
		<DIV id="theads">
		<table  id="tabHead" width="96%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
		<tr align="center" valign="middle">
		<th width="4%">&nbsp;</th>
		<th width="10%">RFQ No.</th>
		<th width="19%">Vendor</th>
		<th width="30%">Material</th>
		<th width="12%">Quantity</th>
		<th width="12%">Price</th>
		<th width="13%">Deliv.Date</th>
		</tr>
		</Table>
		</DIV>


		<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:96%;height:60%;left:2%">
		<TABLE id="InnerBox1Tab" width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
<%

		FormatDate fD = new FormatDate();
		java.util.Date delDate = null;
		String concat = null;
		
		for(int i=0;i<rowCount;i++)
		{
			delDate = (java.util.Date)myRet.getFieldValue(i,"DELIVERY_DATE");
			concat = "V,"+myRet.getFieldValueString(i,"SOLD_TO")+","+myRet.getFieldValueString(i,"MATERIAL")+","+myRet.getFieldValueString(i,"PLANT")+","+myRet.getFieldValueString(i,"QUANTITY")+","+myRet.getFieldValueString(i,"UOM")+","+fD.getStringFromDate(delDate,".",fD.DDMMYYYY);

%>
			<Tr>
				<Td width="4%" align=center><Input type=radio name=chkradio value="<%=concat%>"></Td>
				<Td width="10%"><%=myRet.getFieldValueString(i,"RFQ_NO")%></Td>
				<Td width="19%"><%=myRet.getFieldValueString(i,"SOLD_TO_NAME")%></Td>
				<Td width="30%"><%=myRet.getFieldValueString(i,"MATERIAL_DESC")%></Td>
				<Td width="12%"><%=myRet.getFieldValueString(i,"QUANTITY")%></Td>
				<Td width="12%"><%=myRet.getFieldValueString(i,"PRICE")%></Td>
				<Td width="13%"><%=fD.getStringFromDate(delDate,".",fD.DDMMYYYY)%></Td>
			</Tr>
<%
		}
%>
		</table>
		</div>
<%
	}
	else
	{}
%>
	
	<input type=hidden name="collectiveRfq" value="<%=collRfq%>">
	
	<div id="back" align=center style="position:absolute;top:91%;visibility:visible;width:100%">
		<a href="javascript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif"  border="none" valign=bottom></a>
		<img src="../../Images/Buttons/<%=ButtonDir%>/createpo.gif"  border="none" valign=bottom style="cursor:hand" onClick="createPO()">
	</div>
	
</form>
<Div id="MenuSol"></Div>
</body>
</html>

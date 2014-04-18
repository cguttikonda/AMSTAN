<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@ page import ="java.math.*" %>
<%@ page import ="java.util.*" %>
<%@ page import ="ezc.ezutil.*" %>

<%@ include file="../../../Includes/JSPs/Materials/iSamplePoLineItems.jsp"%>
<%FormatDate formatDate = new FormatDate();%>
<html>
<head>
<title>PO LINE Details</title>

	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<Script>
var tabHeadWidth=90
var tabHeight="65%"
</Script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>

	<script>
	function formEvents(formEv)
	{
		document.myForm.action=formEv;
		document.myForm.submit();
	}
	function formEvents1(formEv)
	{		
		window.open(formEv,"PoPrint","menubar=no,statusbars=no,toolbar=no,width=700,height=600,left=10,top=10");
	}

	function goToPlantAddr(plant)
	{
		window.open("ezPlantAddress.jsp?plant="+plant,"plantdet", "status=no,toolbar=no,menubar=no,location=no,left=250,top=200,width=300,height=280");
	}
	</script>
	
</head>
<body bgcolor="#FFFFF7" onLoad="scrollInit()" onResize="scrollInit()"  scroll=no>
<%


	int polines = dtlXML.getRowCount();
	//ezc.drl.util.EzCurrencyFormat myFormat = new ezc.drl.util.EzCurrencyFormat("Rs",false,false);
	ezc.ezbasicutil.EzCurrencyFormat myFormat= new ezc.ezbasicutil.EzCurrencyFormat();
	myFormat.setLocale((java.util.Locale)session.getValue("LOCALE"));
	myFormat.setNeedSybmol(((Boolean)session.getValue("SREQUIRED")).booleanValue());
	myFormat.isPre(((Boolean)session.getValue("CPOSITION")).booleanValue());
	myFormat.setSymbol((String)session.getValue("CURRENCY"));

	if (polines ==0)
	{		
	%>	<br><br><br><br><br>
		<TABLE width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<tr align="center"> 
		<th height="21">No Order Lines present for this Purchase Order</th>
		</tr>
		</table>
	<%
	}
	else
	{

		dtlXML.toEzcString();
		String netOrderAmount = request.getParameter("NetAmount");
		if (netOrderAmount==null)
			netOrderAmount = new String("0");

		String currency = request.getParameter("Currency");
		if (currency==null)
			currency = new String("INR");

		String orderType = request.getParameter("orderType");
		if(orderType == null)
			orderType="";
	%>
		<form  name="myForm" method="post">

		<TABLE width="50%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<tr align="center"> 
	    	<td class="displayheader"> Purchase Order Details 
		<input type="hidden" name="chkValue">
		<input type="hidden" name="orderType" value="<%=orderType%>">
		</td>
  		</tr>
		</table>

		<table align="center" bgcolor="#FFFFF7" bordercolor="#660066" border="1">
		<tr> 
	             <th bordercolor="#FFFFF7">PO No </th>
		<td bordercolor="#FFFFF7"><%=Long.parseLong(poNum)%><input type="hidden"  name="PurchaseOrder" value="<%=poNum%>"></td>
	             <th bordercolor="#FFFFF7">Date</th>
             	<td bordercolor="#FFFFF7"><%=formatDate.getStringFromDate((Date)ordDate,(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%> </td>
		<input type="hidden" value="<%=formatDate.getStringFromDate((Date)ordDate,(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%>" name="OrderDate">
             	<th bordercolor="#FFFFF7">Net Value[<%=currency%>]</th>
	             <td bordercolor="#FFFFF7"><%= myFormat.getCurrencyString(netOrderAmount)%>&nbsp;&nbsp;<input type="hidden" name="OrderValue" value="<%=netOrderAmount%>"><!--ADDED BY SOMA-->
		<input type="hidden" name="OrderValue" value="<%=netOrderAmount%>">
		</td>
		</tr>
		</table>
		<input type="hidden" name="orderCurrency" value=<%=currency%>>
		<input type="hidden" name="base" value="PurchaseOrder">
		<input type="hidden" name="baseValues" value="<%=dtlXML.getFieldValue(0,ORDER)%>">
		<br>
		<input type="hidden" name="InvStat" value="P">


		<DIV id="theads">
		<Table id="tabHead" width="90%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr> 
		<th width="10%">Line</th>
	      	<th width="40%">Material Description</th>
      		<th width="15%">UOM</th>
	      	<th width="15%">Order Qty</th>
	      	<th width="20%">ED Date </th>
		</Tr>
		</Table>
		</div>


		<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:96%;height:60%;left:2%">
		<TABLE id="InnerBox1Tab" width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<%
		Hashtable ht = new Hashtable();
		Hashtable ht1= new Hashtable();

		for(int i=0; i<polines; i++)
		{
			String lineNum = (String)dtlXML.getFieldValue(i, LINENO);
			String matNum = (String)dtlXML.getFieldValue(i, MATERIAL);
			matNum = matNum.trim();
			String matDesc = (String)dtlXML.getFieldValue(i, MATDESC);
				matDesc = matDesc.trim();

			String uom = (String)dtlXML.getFieldValue(i, UOM);
			String qty = dtlXML.getFieldValueString(i, ORDQTY);

			ht.put(matNum,matDesc);
			ht.put((String)dtlXML.getFieldValue(i, "ITEM"),matDesc);
			ht.put(lineNum,matDesc);

			Date eDDate =(Date)dtlXML.getFieldValue(i, DDATE);
			String edDate = formatDate.getStringFromDate(eDDate,(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));

			%>

    			<tr align="center">
		      	<td width=10%"><%if(lineNum != null)out.println(lineNum); %><input type="hidden" name="line" value="<%=lineNum%>"></td>
    			<td width="40%"  align="left"><%= matDesc %></td>
			<td width="15%"><%=uom %>&nbsp;</td>
			<td width="15%" align="right"><%=qty%>&nbsp</td>
			<td width="20%" align="center">
			<%
			if(edDate.length() == 10)
			{
				if(dtlXML.getFieldValueString(i,"INDICATOR").equalsIgnoreCase("X"))
				{
			%>		<a href="ezDelDetPO.jsp?orderNum=<%=dtlXML.getFieldValue(0,ORDER)%>&line=<%=lineNum%>&OrderDate=<%=dtlXML.getFieldValue(0,ORDDATE)%>"><%=edDate%></a>
			<%	}
				else
				{
			%>		<%=edDate%>
			<%	}
			}
			%>&nbsp
			</td>
	  		</tr>
			<%

		}
		session.setAttribute("materialDesc",ht);
		session.setAttribute("materialNos",ht1);
		%>

	</table>
	</div>
	<div align='center' style='position:absolute;top:90%'>
	<table align="center" width=100%>
    	<tr align="center"> 
	<td  align=center class=blankcell>
	<a href='javascript:history.go(-1)'  onMouseover="window.status='Click to view the previous screen.'; return true" onMouseout="window.status=' '; return true">
	<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border="none"></a>
	<a href='javascript:formEvents("../Materials/ezSamplePoReceiptDetails.jsp")'  onMouseover="window.status='Click to view the Receipts against the Current PurchaseOrder. '; return true" onMouseout="window.status=' '; return true">
	<img src="../../Images/Buttons/<%=ButtonDir%>/viewstatus.gif" border="none"></a>&nbsp
	&nbsp;
	</td>
	</tr>
  	</Table>
	</div>
<%
	}//end if
%>
 
</form>
<Div id="MenuSol"></Div>
</body>
</html>


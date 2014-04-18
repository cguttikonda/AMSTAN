<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Jsps/Purorder/iPoLineItems.jsp"%>
<%@ include file="../../../Includes/Jsps/Labels/iOpenPoLineItems_Labels.jsp"%>
<%FormatDate formatDate = new FormatDate();%>
<%@ page import ="java.math.*" %>
<%@ page import="java.util.*" %>
<%@ page import="ezc.ezbasicutil.*" %>

<% String userType = (String)session.getValue("UserType"); %>
<html>
<head>
<title>PO LINE Details</title>
	<%@include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<Script>
var tabHeadWidth=96
var tabHeight="50%"
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
		window.open("../Misc/ezPlantAddress.jsp?plant="+plant,"plantdet", "status=no,toolbar=no,menubar=no,location=no,width=370,height=350,left=275,top=100 ");
	}
	</script>

</head>
<body bgcolor="#FFFFF7" onLoad="scrollInit()" onResize="scrollInit()" scroll=no>
<form  name="myForm" method="post">
<%


	int polines = dtlXML.getRowCount();
	//out.println("polines"+polines);
	//ezc.drl.util.EzCurrencyFormat myFormat = new ezc.drl.util.EzCurrencyFormat(((String)session.getValue("CURRENCY")),((Boolean)session.getValue("CPOSITION")).booleanValue(),((Boolean)session.getValue("SREQUIRED")).booleanValue());
	ezc.ezbasicutil.EzCurrencyFormat myFormat= new ezc.ezbasicutil.EzCurrencyFormat();
	myFormat.setLocale((java.util.Locale)session.getValue("LOCALE"));
	myFormat.setNeedSybmol(((Boolean)session.getValue("SREQUIRED")).booleanValue());
	myFormat.isPre(((Boolean)session.getValue("CPOSITION")).booleanValue());
	myFormat.setSymbol((String)session.getValue("CURRENCY"));

	
	if (polines ==0)
	{
%>

		<table id="header" width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr >
  			<td>&nbsp;</td>
    			<td width="100%">
	  			<table border="0" cellpadding="0" cellspacing="0" width="100%">
	    			 <tr valign="middle" class=trclass height="30">
		  			<td width="40%">
		  				&nbsp; <a href="../Misc/ezSBUWelcome.jsp" target="display"><img src="../../Images/Buttons/<%=ButtonDir%>/home_button.gif" alt="Home" width="54" height="17" border=none></a>
		  				&nbsp; <a href="../Misc/ezLogout.jsp" target="_top"><img src="../../Images/Buttons/<%=ButtonDir%>/logout_butt.gif" alt="Logout" width="65" height="17" border=none></a><br>
		  			</td>
		  			<td width="60%" valign="middle" class="greentxt">&nbsp;</td>
				</tr>
	  			</table>
			</td>
			<td>&nbsp;</td>
  		  </tr>
		</table>


		<br><br><br><br><br>
		<TABLE width="80%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
		<tr align="center">
		<th height="21"><%=noOrdLiPres_L%></th>
		</tr>
		</table>
<%
	}
	else
	{
              		java.util.Vector names = new java.util.Vector();
			names.addElement(DDATE);
			names.addElement(ORDDATE);
			EzGlobal.setColNames(names);

			java.util.Vector types = new java.util.Vector();
			types.addElement("date");
			types.addElement("date");
			EzGlobal.setColTypes(types);
	
			ezc.ezparam.ReturnObjFromRetrieve ret = EzGlobal.getGlobal((ezc.ezparam.ReturnObjFromRetrieve)dtlXML);


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

			<table id="header" width="100%" border="0" cellspacing="0" cellpadding="0">
  			<tr >
   			 <td>&nbsp;</td>
    			 <td width="100%">
	  			<table border="0" cellpadding="0" cellspacing="0" width="100%">
	    			 <tr valign="middle" height=30 class=trclass >
		  		  <td width="40%">
		  			&nbsp; <a href="../Misc/ezSBUWelcome.jsp" target="display"><img src="../../Images/Buttons/<%=ButtonDir%>/home_button.gif" alt="Home" width="54" height="17" border=none></a>
		 			 &nbsp; <a href="../Misc/ezLogout.jsp" target="_top"><img src="../../Images/Buttons/<%=ButtonDir%>/logout_butt.gif" alt="Logout" width="65" height="17" border=none></a><br>
		  		  </td>
		 		  <td width="60%" valign="middle" class="greentxt">
		  			<%=poDetails_L%>
				  </td>
				</tr>
	  		</table>
			</td>
			<td>&nbsp;</td>
  			</tr>
			</table>

		<input type="hidden" name="chkValue">
		<input type="hidden" name="orderType" value="<%=orderType%>">
		<table align="center" width=70% border="1" borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1>
		<tr>
	        <th ><%=poNo_L%> </th>
		<td ><%=Long.parseLong(poNum)%><input type="hidden" value="<%=poNum%>" name="PurchaseOrder"></td>
                <th ><%=orderDate_L%></th>

             	<td ><%=ret.getFieldValueString(0,ORDDATE)%> </td>
		<input type="hidden" value="<%=ret.getFieldValueString(0,ORDDATE)%>" name="OrderDate">

             	<th ><%=netValue_L%>[<%=currency%>]</th>
                <td ><%=myFormat.getCurrencyString(netOrderAmount)%>
		<input type="hidden" name="OrderValue" value="<%=myFormat.getCurrencyString(netOrderAmount)%>">
		</td>
		</tr>
		</table>

		<input type="hidden" name="orderCurrency" value=<%=currency%>>

		<!-------------- This two hidden fields are required for shipment deails ------------>
		<input type="hidden" name="base" value="PurchaseOrder">
		<input type="hidden" name="baseValues" value="<%=poNum%>">

		<input type="hidden" name="InvStat" value="P">

		<div id="theads">
		<TABLE id="tabHead"  width=96% align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
		<Tr>
		<th width="5%" ><%=line_L%></th>
      		<th width="9%"><%=mat_L%></th>
	      	<th width="14%"><%=desc_L%></th>
      		<th width="5%"><%=uom_L%></th>
	      	<th width="10%"><%=orQty_L%></th>
	      	<th width="10%"><%=deQty_L%></th>
      		<th width="10%"><%=price_L%></th>
	      	<th width="11%"><%=value_L%></th>
     		<th width="7%"><%=plant_L%></th>
	      	<th width="11%"><%=edDate_L%></th>

	      	<% if(!userType.equals("3"))
		   {
		 %>
	      		<th width="8%"><%=rfqno_L%></th>
	      	 <% } %>
		</Tr>
		</Table>
		</div>
		<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:96%;height:60%;left:2%">
		<TABLE  id="InnerBox1Tab"  width=100% align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
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
			String plant = dtlXML.getFieldValueString(i, "PLANT");
			ht.put(matNum,matDesc);
			ht.put((String)dtlXML.getFieldValue(i, "ITEM"),matDesc);
			//out.println("lineNum: "+lineNum+" "+lineNum.length());
			ht.put(lineNum,matDesc);

			// This field is not coming proerly.Price is comining in Amount field.
			java.math.BigDecimal price1 = (java.math.BigDecimal)dtlXML.getFieldValue(i, PRICE);

			String price = dtlXML.getFieldValueString(i, AMOUNT);

			double amnt = Double.parseDouble(dtlXML.getFieldValueString(i, "NET_VALUE"));
			//out.println("qty: "+ qty +"price:"+price);
			//amnt = (Double.parseDouble(qty) * Double.parseDouble(price))/ (price1.doubleValue());
			//out.println("amnt:"+amnt);
			BigDecimal BD = new BigDecimal(amnt);
			//BD.divide(price1);
			//out.println(BD);
			String netAmount =dtlXML.getFieldValueString(i, AMOUNT);
			//String netAmount = (new Float(amnt)).toString()+"0000";


			//Date eDDate =(Date)dtlXML.getFieldValue(i,DDATE);
			String edDate = ret.getFieldValueString(i,DDATE);

			//for receipts details ezPoReceiptDetails.jsp?order=" + poNum + "&line=" + lineNum + "&desc=" + matDesc +">");

			// THE FOLLOWING CHECK IS DONE ON 27.10.2001

			/*if( (uom != null && !uom.equals("")) && (qty != null && !qty.equals("")))
			{*************/ // THIS CHECK IS REMOVED ON 29.10.2001
			%>

    			<tr align="center">
		      	<td width=5%"><%if(lineNum != null)out.println(lineNum); %><input type="hidden" name="line" value="<%=lineNum%>"></td>

			<%try{
				matNum=String.valueOf(Long.parseLong(matNum));
			}catch(NumberFormatException nfe){}
			ht1.put(lineNum,matNum);
			%>
			<td width="9%" align="left" title="<%=matNum%>">
			<input type=text size="8" class="tx"  value="<%=matNum%>" >
    			</td>

    			<td width="14%" align="left" title="<%=matDesc%>">
			<input type=text size="16" class="tx"  value="<%=matDesc%>" >

    			</td>
			<td width="5%"><%=uom %>&nbsp;</td>
			<td width="10%" align="right"><%=qty%>&nbsp</td>
			<%
				String temp=(String)historyTable.get(lineNum)==null || "null".equals((String)historyTable.get(lineNum))?" ":(String)historyTable.get(lineNum);
			%>
			<td width="10%" align="right"><%=temp%>&nbsp;</td>

			<td width="10%" align="right">
			<%=myFormat.getCurrencyString(price)%>&nbsp
			</td>
			<td width="11%" align="right">
			<%
				String bd = BD.toString();
				out.println(myFormat.getCurrencyString(bd));
			%>
			<input type="hidden" name="POPrice" value="<%=BD%>">&nbsp;</td>
			<td width="7%">
			<a href="Javascript:void(0)" onClick="goToPlantAddr('<%=plant%>')"  onMouseover="window.status='Click to view the Plant Address. '; return true" onMouseout="window.status=' '; return true">
			<%=plant%></a>&nbsp;</td>
    			<td width="11%" align="center">
			<%
			if(edDate.length() == 10)
			{
				if(dtlXML.getFieldValueString(i,"INDICATOR").equalsIgnoreCase("X"))
				{
			%>		<a href="ezDelDetPO.jsp?orderNum=<%=poNum%>&line=<%=lineNum%>&OrderDate=<%=dtlXML.getFieldValue(0,ORDDATE)%>"><%=ret.getFieldValueString(i,DDATE)%></a>
			<%	}
				else
				{
			%>		<%=ret.getFieldValueString(i,DDATE)%>
			<%	}
			}
			%>&nbsp;
			</td>
			<% if(!userType.equals("3"))
			   {
			 %>
				<td width="8%" align="center" title="<%=dtlXML.getFieldValueString(i,"ORDER")%>"><input type=text size="5" class=tx  value="<%=dtlXML.getFieldValueString(i,"ORDER")%>" readonly></td>
			 <% } %>
	  		</tr>
			<%
			//	}  //end if (qty != null and uom != null)
		}//end for
		session.setAttribute("materialDesc",ht);
		session.setAttribute("materialNos",ht1);
		%>


	</table>
	</div>

	<div align='center' style='position:absolute;top:88%;width:100%'>
	        <a href='javascript:history.back(-1)'  onMouseover="window.status='click for List of purchase orders '; return true" onMouseout="window.status=' '; return true">
		<img  src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border="none"></a>

	        <a href='javascript:formEvents("ezPrint.jsp")'  onMouseover="window.status='Click to view the shipment info. for the current PurchaseOrder '; return true" onMouseout="window.status=' '; return true">
		<img  src="../../Images/Buttons/<%=ButtonDir%>/Print.gif" border="none"></a>
		<a href='javascript:formEvents("ezAddComittedDate.jsp")'  onMouseover="window.status='Click to view the Payment details for the current PurchaseOrder.'; return true" onMouseout="window.status=' '; return true">
		<img src="../../Images/Buttons/<%=ButtonDir%>/comitteddates.gif" border="none"></a>
  		<%
			if(userType == null) userType="";

		if(orderType.equals("Open") && (!userType.equals("2")))
		{
		%>
      		        <a href='javascript:formEvents("../Shipment/ezAddShipmentDetails.jsp")'  onMouseover="window.status='Click to add shipment info. for the current PurchaseOrder.'; return true" onMouseout="window.status=' '; return true">
			<img src="../../Images/Buttons/<%=ButtonDir%>/addshipments.gif" border="none"></a>
      		<%}%>

		<a href='javascript:formEvents("../Shipment/ezListViewShipmentHeaders.jsp")'  onMouseover="window.status='Click to view the shipment info. for the current PurchaseOrder '; return true" onMouseout="window.status=' '; return true">
		<img src="../../Images/Buttons/<%=ButtonDir%>/viewshipments.gif" border="none" ></a>
		<a href='javascript:formEvents("ezPoReceiptDetails.jsp")'  onMouseover="window.status='Click to view the Receipts against the Current PurchaseOrder. '; return true" onMouseout="window.status=' '; return true">
		<img src="../../Images/Buttons/<%=ButtonDir%>/viewreceipts.gif" border="none"></a>
       		<a href='javascript:formEvents("ezWaitPOPaymentDetails.jsp")'  onMouseover="window.status='Click to view the Payment details for the current PurchaseOrder.'; return true" onMouseout="window.status=' '; return true">
		<img src="../../Images/Buttons/<%=ButtonDir%>/paymentdetails.gif" border="none"></a>
	</div>


<%
	}
%>

</form>
<Div id="MenuSol"></Div>
</body>
</html>

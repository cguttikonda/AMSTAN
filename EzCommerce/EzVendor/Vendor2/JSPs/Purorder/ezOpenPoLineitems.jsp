<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iOpenPoLineItems_Labels.jsp"%>
<%@ page import ="java.math.*" %>
<%@ page import ="java.util.*" %>
<%@ page import ="ezc.ezutil.*" %>
<%@ include file="../../../Includes/JSPs/Purorder/iPoLineItems.jsp"%>  

<%
	FormatDate formatDate = new FormatDate();
%>
<html>
<head>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<Script>
	var tabHeadWidth=96
	var tabHeight="52%"
</Script>
<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>

	<Script>

		function formEvents(formEv)
		{
			if(formEv!='ezPrint.jsp')
			{ 
				setMessageVisible();
			}	

			document.myForm.action=formEv; 
			document.myForm.submit();
		}
		function formEvents1(formEv)
		{		
			window.open(formEv,"PoPrint","menubar=no,statusbars=no,toolbar=no,width=700,height=530,left=10,top=10");
		}

		function goToPlantAddr(plant)
		{
			window.open("ezPlantAddress.jsp?plant="+plant,"plantdet", "status=no,toolbar=no,menubar=no,location=no,left=280,top=200,width=350,height=320");
		}
		function goToListAck()
		{
			setMessageVisible();
			document.location.href="ezListAcknowledgedPOs.jsp?type=Acknowledged";
			
		}
	</Script>
	
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
%>		
		<br><br><br><br><br>
		<TABLE width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<tr align="center"> 
		<th height="21"><%=noOrdLiPres_L%></th>
		</tr>
		</table>
<%
	}
	else
	{
		String netOrderAmount = request.getParameter("NetAmount");
		if (netOrderAmount==null)
			netOrderAmount = netCalcAmt+"";
		//else
			//netOrderAmount = (Double.parseDouble(netOrderAmount)*100.0)+"";

		String currency = request.getParameter("Currency");
		if (currency==null)
			currency = new String("USD");

		String orderType = request.getParameter("orderType");
		if(orderType == null)
			orderType="";
		String display_header = poDetails_L;
%>
		
                <%@ include file="../Misc/ezDisplayHeader.jsp" %>
               
		
		<Div id='inputDiv' style='position:relative;align:center;top:2%;width:100%;'>
		<Table width="80%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
		<Tr>
			<Td height="5" style="background-color:'#F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"></Td>
			<Td height="5" style="background-color:'#F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"></Td>
			<Td height="5" style="background-color:'#F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"></Td>
		</Tr>
		<Tr>
			<Td width="5" style="background-color:'#F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"></Td>
			<Td style="background-color:'#F3F3F3'" valign=middle>
				<Table border="0" align="center" valign=middle width="100%" class=welcomecell>
					<Tr>
						<Td style="background-color:'#F3F3F3';" align='left'>
							<font size=2><B><%=poNo_L%>&nbsp;:&nbsp;</B><%=poNum%></font>
						</Td>
						<Td style="background-color:'#F3F3F3';" align='center'>
							<font size=2><B><%=orderDate_L%>&nbsp;:&nbsp;</B><%=formatDate.getStringFromDate((Date)dtlXML.getFieldValue(0,ORDDATE),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%></font>
						</Td>
						<Td style="background-color:'#F3F3F3';" align='right'>
							<font size=2><B><%=netValue_L%>[<%=currency%>]&nbsp;:&nbsp;</B><%=myFormat.getCurrencyString(netOrderAmount)%></font>
						</Td>
					</Tr>
				</Table>
			</Td>
			<Td width="5" style="background-color:'#F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e3.gif"><img width="5" height="1" src="Cb_e3.gif"></Td>
		</Tr>
		<Tr>
			<Td width="5" style="background-color:'#F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"></Td>
			<Td height="5" style="background-color:'#F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"></Td>
			<Td width="5" style="background-color:'#F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"></Td>
		</Tr>
		</Table>
		</Div>	
		
		<BR>
		<form  name="myForm">
			<input type="hidden" name="chkValue">
			<input type="hidden" name="orderType" value="<%=orderType%>">
			<input type="hidden" value="<%=poNum%>" name="PurchaseOrder">
			<input type="hidden" value="<%=formatDate.getStringFromDate((Date)dtlXML.getFieldValue(0,ORDDATE),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%>" name="OrderDate">
			<input type="hidden" name="OrderValue" value="<%=netOrderAmount%>">
			<input type="hidden" name="orderCurrency" value=<%=currency%>>
			<input type="hidden" name="base" value="PurchaseOrder">
			<input type="hidden" name="baseValues" value="<%=poNum%>">
			<input type="hidden" name="InvStat" value="P">

		<DIV id="theads">
		<Table id="tabHead" width="96%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
			<Tr> 
				<th width="4%" ><%=line_L%></th>
				<th width="10%"><%=mat_L%></th>
				<th width="22%"><%=desc_L%></th>
				<th width="5%"><%=uom_L%></th>
				<th width="10%"><%=qty_L%></th>
				<th width="10%"><%=deQty_L%></th>
				<th width="11%"><%=price_L%></th>
				<th width="12%"><%=value_L%></th>
				<th width="6%"><%=plant_L%></th>
				<th width="10%"><%=dueDate_L%></th>
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
			String lineNum	= (String)dtlXML.getFieldValue(i, LINENO);
			String matNum 	= (String)dtlXML.getFieldValue(i, MATERIAL);
			String matDesc 	= (String)dtlXML.getFieldValue(i, MATDESC);
			String uom 	= (String)dtlXML.getFieldValue(i, UOM);
			String qty 	= dtlXML.getFieldValueString(i, ORDQTY);
			String plant 	= dtlXML.getFieldValueString(i, "PLANT");
			
			qty = getNumberFormat(qty,0);
			
			matNum 		= matNum.trim();
			matDesc 	= matDesc.trim();
			
			ht.put(matNum,matDesc);
			ht.put((String)dtlXML.getFieldValue(i, "ITEM"),matDesc);
			//out.println("lineNum: "+lineNum+" "+lineNum.length());
			ht.put(lineNum,matDesc);
	
			// This field is not coming proerly.Price is comining in Amount field.
			java.math.BigDecimal price1 = (java.math.BigDecimal)dtlXML.getFieldValue(i, PRICE);
			String price = dtlXML.getFieldValueString(i, AMOUNT);
                        price = (Double.parseDouble(price))*100.0+"";
			double amnt = Double.parseDouble(dtlXML.getFieldValueString(i, "NET_VALUE"));
			//out.println("qty: "+ qty +"price:"+price+" amt"+amnt);
			//amnt = (Double.parseDouble(qty) * Double.parseDouble(price))/ (price1.doubleValue());
			amnt = (Double.parseDouble(qty) * Double.parseDouble(price));
			//out.println("amnt:"+amnt);
			BigDecimal BD = new BigDecimal(amnt);
			//BD.divide(price1);
			//out.println(BD);
			String netAmount =dtlXML.getFieldValueString(i, AMOUNT);
			//String netAmount = (new Float(amnt)).toString()+"0000";
	
			Date eDDate =(Date)dtlXML.getFieldValue(i, DDATE);
			String edDate = formatDate.getStringFromDate(eDDate,(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
	
			//for receipts details ezPoReceiptDetails.jsp?order=" + poNum + "&line=" + lineNum + "&desc=" + matDesc +">");
			// THE FOLLOWING CHECK IS DONE ON 27.10.2001

			/*
			if( (uom != null && !uom.equals("")) && (qty != null && !qty.equals("")))
			{
				
			*************/ 
			// THIS CHECK IS REMOVED ON 29.10.2001
			
%> 
 
    			<tr align="center"> 
		      		<td width=4%">
<%
		      			if(lineNum != null)out.println(lineNum);
%>
					<input type="hidden" name="line" value="<%=lineNum%>">
		      		</td>
				<td width="10%" align="left">
<%
				try{
					matNum=String.valueOf(Long.parseLong(matNum));
				}catch(NumberFormatException nfe){}
				ht1.put(lineNum,matNum);
%>
			<!--<input type=text size="6" style="font-family: verdana,arial,sans-serif;font-size: 11px;background-color:#e1ebf4;border:0"  value="" >-->
			<%= matNum %>
    			&nbsp;</td>

    			<td width="22%"  align="left">
			<!--<input type=text size="20" class="tx"  value="" >-->
			<!--<a href="../Materials/ezGetMaterialCharacteristics.jsp?material=<%//matNum %>&plant=<%//plant%>" onMouseover="window.status='Click to view Material Characteristics. '; return true" onMouseout="window.status=' '; return true"><%//matDesc %></a>-->
			<%= matDesc %>
    			</td>
			<td width="5%"><%=uom %>&nbsp;</td>
			<td width="10%" align="right"><%=qty%>&nbsp;</td>
			<%
				String temp=(String)historyTable.get(lineNum)==null || "null".equals((String)historyTable.get(lineNum))?" ":(String)historyTable.get(lineNum);
				temp = getNumberFormat(temp,0);
			%>
			<td width="10%" align="right">&nbsp;<%=temp%></td>

			<td width="11%" align="right">&nbsp;
			<%=myFormat.getCurrencyString(price)%>
			</td>
			<td width="12%" align="right">
			<%  	
				String bd = BD.toString();
				out.println(myFormat.getCurrencyString(bd));
			%>
			
			</td>
			<td width="6%">
			<a href="Javascript:void(0)" onClick="goToPlantAddr('<%=plant%>')"  onMouseover="window.status='Click to view the Plant Address. '; return true" onMouseout="window.status=' '; return true">
			<%=plant%></a>&nbsp;</td>
    			<td width="10%" align="center">
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
			%>&nbsp;
			</td>
	  		</tr>  
			<%
			//	}  //end if (qty != null and uom != null)
		}//end for
		session.setAttribute("materialDesc",ht);
		session.setAttribute("materialNos",ht1);
%>

	</table>
	</div>


<!-- <div align='center' style='position:absolute;top:90%;width:100%;'> -->
<Div id="ButtonDiv" align='center' style="position:absolute;top:90%;width:100%;visibility:visible">

<%
	String userType = (String)session.getValue("UserType");
	String fromListAck = request.getParameter("fromListAck");
	
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();

	buttonName.add("Back");
	if("Y".equals(listBack)){
		buttonMethod.add("formEvents(\"ezListPOs.jsp\")");
	}
	else if("Y".equals(fromListAck))
	{
		buttonMethod.add("goToListAck()");
	}
	else
	{
		buttonMethod.add("history.go(-1)");
	}
	
	buttonName.add("Print");
	buttonMethod.add("formEvents(\"ezPrint.jsp\")");
	
	buttonName.add("Comitted Dates");
	buttonMethod.add("formEvents(\"ezAddComittedDate.jsp\")");

	if(orderType.equals("Open") && (!userType.equals("2")))
	{
		buttonName.add("Add Shipments");
		buttonMethod.add("formEvents(\"../Shipment/ezAddShipmentDetails.jsp\")");
	}	
	
	buttonName.add("View Shipments");
	buttonMethod.add("formEvents(\"../Shipment/ezViewShipmentHeader.jsp\")");

	buttonName.add("View Receipts");
	buttonMethod.add("formEvents(\"ezPoReceiptDetails.jsp\")");

	buttonName.add("Payment Details");
	buttonMethod.add("formEvents(\"ezWaitPOPaymentDetails.jsp\")");
	
	out.println(getButtonStr(buttonName,buttonMethod));		
%>
</div>
<input type="hidden" name="ponum" value="<%=poNum%>">
<input type="hidden" name="showData" value="Y">
<input type="hidden" name="backFlg" value="Y">
<input type="hidden" name="orderBase" value="po">

<input type="hidden" name="FromDate" value="<%=fromDate%>">
<input type="hidden" name="ToDate" value="<%=toDate%>">
<input type="hidden" name="OrderType" value="<%=OrderType%>">

<input type="hidden" name="SearchFlag" value="<%=SearchFlag%>">
<input type="hidden" name="POSearch" value="<%=POSearch%>">
<input type="hidden" name="MaterialNumber" value="<%=MaterialNumber%>">
<input type="hidden" name="DCNO" value="<%=DCNO%>">
<input type="hidden" name="posearchno" value="<%=posearchno%>">



<%@ include file="../Misc/AddMessage.jsp" %>

<div align='center' style='position:absolute;width:100%;top:95%'>
	<center><font size='1'><%=valOrd_L%></font></center>
</div>
<%
	}//end if
%>
 
</form>
<Div id="MenuSol"></Div>
</body>
</html>

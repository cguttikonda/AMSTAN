<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iNewPoLineItems_Labels.jsp"%>
<%@ page import ="java.math.*" %>
<%@ page import ="java.util.*" %>
<%@ page import ="ezc.ezutil.*" %>
<%@ include file="../../../Includes/JSPs/Purorder/iNewPoLineItems.jsp"%>
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
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<script>
	var alrtPlzAck_L = '<%=alrtPlzAck_L%>';
	function formEvents(formEv,stat)
	{
		
		document.myForm.status.value=stat
		document.myForm.action=formEv;
		var url = "ezSelectAcknowledgeUsers.jsp";
		var hWnd = window.open(url,"UserWindow","width=500,height=300,resizable=yes,scrollbars=yes");
		
		if ((document.window != null) && (!hWnd.opener))
		{			
			hWnd.opener = document.window;
		}
	}	
	function formEvents1(formEv)
	{		
		window.open(formEv,"PoPrint","menubar=no,statusbars=no,toolbar=no,width=700,height=530,left=10,top=10");
	}

	function funSubmit(formEv)
	{
		if(!(formEv=="ezPrint.jsp"))
			setMessageVisible();
		document.myForm.action = formEv
		document.myForm.submit();
	}

	function goToPlantAddr(plant)
	{
		window.open("ezPlantAddress.jsp?plant="+plant,"plantdet", "status=no,toolbar=no,menubar=no,location=no,left=250,top=200,width=350,height=320");
	}

	function funPrint(formFile) 
	{
		alert(alrtPlzAck_L)
		document.myForm.action = formFile
		document.myForm.submit();
	}
</script>
</head>
<body onLoad="scrollInit(0)" onResize="scrollInit(0)" scroll=no>
<%
	int polines = dtlXML.getRowCount();
	ezc.ezbasicutil.EzCurrencyFormat myFormat= new ezc.ezbasicutil.EzCurrencyFormat();
	myFormat.setLocale((java.util.Locale)session.getValue("LOCALE"));
	myFormat.setNeedSybmol(((Boolean)session.getValue("SREQUIRED")).booleanValue());
	myFormat.isPre(((Boolean)session.getValue("CPOSITION")).booleanValue());
	myFormat.setSymbol((String)session.getValue("CURRENCY"));
	if (polines ==0)
	{
		String noDataStatement = noOrdLiPres_L;
%>		
		<%@ include file="../Misc/ezDisplayNoData.jsp" %>
<%
	}
	else
	{
		String netOrderAmount = request.getParameter("NetAmount");
		if (netOrderAmount==null)
		{
			netOrderAmount = netCalcAmt+"";
		}
		String currency = request.getParameter("Currency");
		if (currency==null)
		{
			currency = dtlXML.getFieldValueString(0,"CURRENCY");
		}
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
							<font size=2><B><%=poNo_L%>&nbsp;:&nbsp;</B><%=Long.parseLong(poNum)%></font>
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
		<input type="hidden" value="<%=poNum%>" name="PurchaseOrder">
		<input type="hidden" value="<%=request.getParameter("vendor")%>" name="vendorNo">
		<input type="hidden" name="OrderDate" value="<%=formatDate.getStringFromDate((Date)dtlXML.getFieldValue(0,ORDDATE),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%>"> 
		<input type="hidden" name="NetAmount" value="<%=netOrderAmount%>">		
		<input type="hidden" name="Currency" value="<%=currency%>">		
		<input type="hidden" name="orderType" value="<%=orderType%>">		
		<input type="hidden" name="poSysKey" value="<%=request.getParameter("poSysKey")%>">		
		<input type="hidden" name="show" value="<%=request.getParameter("show")%>">		
		
		
<%	
		String type = (String)session.getValue("UserType");
		String status = request.getParameter("status");
		
		if("3".equals(type) && status != null && status.equals("A"))
		{
%>
			<table align="center">
			<tr>
				<td align="center" class="blankcell">* <%=alrtPlzAck_L%></td>
			</tr>
			</table>
<%
		}
%>
		<DIV id="theads">
		<Table id="tabHead" width="96%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr>
		<th width="5%" ><%=line_L%></th>
      		<th width="12%"><%=mat_L%></th>
	      	<th width="24%"><%=desc_L%></th>
      		<th width="6%"><%=uom_L%></th>
	      	<th width="11%"><%=qty_L%></th>
      		<th width="11%"><%=price_L%></th>
	      	<th width="13%"><%=value_L%></th>
     		<th width="6%"><%=plant_L%></th>
	      	<th width="12%"><%=dueDt_L%></th>
		</Tr>
		</Table>
		</div>


		<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:96%;height:60%;left:2%">
		<TABLE id="InnerBox1Tab" width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<%
		for(int i=0; i<polines; i++)
		{
			String lineNum 	= (String)dtlXML.getFieldValue(i, LINENO);
			String matNum  	= ((String)dtlXML.getFieldValue(i, MATERIAL)).trim();
			String matDesc 	= ((String)dtlXML.getFieldValue(i, MATDESC)).trim();
			String uom 	= (String)dtlXML.getFieldValue(i, UOM);
			String qty 	= dtlXML.getFieldValueString(i, ORDQTY);
			String plant 	= dtlXML.getFieldValueString(i, "PLANT");
			
			qty = getNumberFormat(qty,0);
			
			java.math.BigDecimal price1 = (java.math.BigDecimal)dtlXML.getFieldValue(i, PRICE);
			String price = dtlXML.getFieldValueString(i, AMOUNT);
			price = (Double.parseDouble(price)*100)+"";
			double amnt = Double.parseDouble(dtlXML.getFieldValueString(i, "NET_VALUE"));
			BigDecimal BD = new BigDecimal(amnt*100);
			String netAmount =dtlXML.getFieldValueString(i, AMOUNT);
			Date eDDate =(Date)dtlXML.getFieldValue(i, DDATE);
			String edDate = formatDate.getStringFromDate(eDDate,(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
%>
    			<tr align="center">
			      	<td width=5%"><%if(lineNum != null)out.println(lineNum); %></td>
				<td width="12%" align=left>
<%
				try
				{
					matNum=String.valueOf(Long.parseLong(matNum));
				}catch(NumberFormatException nfe){	}
%>
					<%= matNum %>&nbsp;
				</td>
	    			<td width="24%" align=left title="<%=matDesc%>">
					<%=matDesc%>
	    			</td>
				<td width="6%"><%=uom %>&nbsp;</td>
				<td width="11%" align="right">&nbsp;<%=qty%></td>
				<td width="11%" align="right">&nbsp;
					<%=myFormat.getCurrencyString(price)%>
				</td>
				<td width="13%" align="right">&nbsp;
<%
					String bd = BD.toString();
					out.println( myFormat.getCurrencyString(bd).trim());
%>
				</td>
				<td width="6%">
					<a href="Javascript:void(0)" onClick="goToPlantAddr('<%=plant%>')"  onMouseover="window.status='<%=viwPltAdd_L%>'; return true" onMouseout="window.status=' '; return true">
						<%=plant%>
					</a>&nbsp;
				</td>
	    			<td width="12%" align="center">
<%
					if(edDate.length() == 10)
					{
						if(dtlXML.getFieldValueString(i,"INDICATOR").equalsIgnoreCase("X"))
						{
%>		
							<a href="ezDelDetPO.jsp?orderNum=<%=poNum%>&line=<%=lineNum%>&OrderDate=<%=dtlXML.getFieldValue(0,ORDDATE)%>"><%=edDate%></a>
<%	
						}
						else
						{
							out.println(edDate);
						}
					}
%>
					&nbsp;
				</td>
	  		</tr>
<%
		}
%>
	</Table>
	</div>
	
	<input type="hidden" name="status" value="">
	<input type="hidden" name="toUser" value="">


		<div id="ButtonDiv" style="position:absolute;top:90%;width:100%;visibility:visible">
		<center>
<%
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();

			buttonName.add("Back");
			buttonMethod.add("history.go(-1)");

			//if(!"3".equals(type) )
			{
			
				buttonName.add("Print");
				buttonMethod.add("funSubmit(\"ezPrint.jsp\")");
			
			}

			buttonName.add("View Delivery Schedules");
			buttonMethod.add("funSubmit(\"../Purorder/ezViewDeliverySchedules.jsp\")");
			
			if("3".equals(type)  )
			{
				buttonName.add("Acknowledge");
				buttonMethod.add("funSubmit(\"ezAddComittedDate.jsp\")");


				buttonName.add("Reject");
				buttonMethod.add("formEvents(\"ezComposeRejectMsg.jsp\",\"R\")");
					

				
			}
			if(status==null || status.equals("X")){
				buttonName.add("Comitted Dates");
				buttonMethod.add("funSubmit(\"ezAddComittedDate.jsp\")");
			
			
			}
			
			out.println(getButtonStr(buttonName,buttonMethod));
%>
		</center>
		</div>
		<%@ include file="../Misc/AddMessage.jsp" %>

		<div align='center' style='position:absolute;width:100%;top:95%'>
			<center><font size='1'><%=befDisTax_L%></font></center>
		</div>
<%
	}
%>

</form>
<Div id="MenuSol"></Div>
</body>
</html>
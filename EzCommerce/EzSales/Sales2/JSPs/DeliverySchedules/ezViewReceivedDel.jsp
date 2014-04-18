<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ page import = "ezc.ezutil.FormatDate,java.util.*" %>
<%@ include file="../../../Includes/JSPs/DeliverySchedule/iViewDeliveryDetails.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iViewReceivedDel_Lables.jsp"%>

<html>
<head>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
	<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
	<Script>
		  var tabHeadWidth=95
<%
if ((retHeadDetails!=null)||(retHeadDetails.getRowCount()>0)){
%>
 	   	  var tabHeight="35%"

<%}else{%>
 	   	  var tabHeight="60%"
<%}%>

	</Script>
	<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
	<script>
	function submitPage()
	{
		if (document.forms[0].recDate.value==''){
			alert("Please Choose Received Date")
			document.forms[0].recDate.focus();
			return false;
		}else{
			document.forms[0].action="ezSaveReceivedDel.jsp";
			document.forms[0].submit();
		}
	}
	function displayMsg()
	{
		flag=confirm("<%=ackDispRec_A%>")
		if (flag){
			ezBack()
		}
		else{
			document.forms[0].reset();
			return false;
		}
	}
	function showSpan(spid)
	{
		spobj=document.getElementById("SP"+spid);
		if (spobj!=null){
			if(spobj.style.display=="none")
				spobj.style.display="block";
			else if(spobj.style.display=="block")
				spobj.style.display="none";
		}
	}
	function openWindow(fieldName)
	{
		str = "ezRemarksEntry.jsp?fieldName="+fieldName
		newWindow = window.open(str,"MyWin","resizable=no,left=250,top=180,height=250,width=350,status=no,toolbar=no,menubar=no,location=no")

		/*Str=eval(fieldName).value
		retVal =showModalDialog("../Projections/ezRemarksEntry.jsp",Str,'center:yes;dialogWidth:20;dialogHeight:16;status:no;minimize:yes')
		if (retVal!=null)
			eval(fieldName).value=retVal;
		*/
	}
	function openWindow1(fieldName)
	{
		str = "ezShowRemarks.jsp?fieldName="+fieldName
		newWindow = window.open(str,"MyWin","resizable=no,left=250,top=180,height=250,width=350,status=no,toolbar=no,menubar=no,location=no")


		/*
		Str=eval(fieldName).value
		retVal =showModalDialog("../Projections/ezShowRemarks.jsp",Str,'center:yes;dialogWidth:20;dialogHeight:16;status:no;minimize:yes')
		*/
	}
	function ezBack()
	{
		<%
		String status = request.getParameter("status");
		String SalesOrder =request.getParameter("SalesOrder");
		String from = request.getParameter("from");
		String sT = request.getParameter("soldTo");
		if("ezViewDispatchInfo".equals(from))
		{%>
			document.forms[0].action="ezViewDispatchInfo.jsp?SalesOrder=<%=SalesOrder%>";
			document.forms[0].submit();
		<%}else if ("ezGetDeliveryBySO".equals(from)){
		%>
			document.forms[0].action="ezGetDeliveryBySO.jsp?SalesOrder=<%=SalesOrder%>&status=<%=status%>";
			document.forms[0].submit();
		<%}else if ("ezCustInvoiceDetails".equals(from)){%>
			document.forms[0].action="../Sales/ezCustInvoiceDetails.jsp?salesDocNo=<%=request.getParameter("soNo")%>&custInvNo=<%=request.getParameter("custInvNo")%>&status=<%=status%>";
			document.forms[0].submit();
		<%}else{%>
			history.go(-1);
		<%}%>
	}
	</script>
</head>
<body  onLoad="scrollInit()" onresize="scrollInit()" scroll=no>

<form  method="post" onSubmit="return false" name="Received">
<input type="hidden" name="Stat" value="<%=request.getParameter("Stat")%>" >
<table align=center border="0" cellpadding="0" class="displayheaderback" cellspacing="0" width="100%">
<tr>
    <td height="35" class="displayheaderback" align=center width="100%"><%=disDet_L%><% try{out.println(Long.parseLong(delNum));}catch(Exception e){ out.println(delNum);}%></TD>
	</TR>
	</TABLE>
<%
	ezc.ezbasicutil.EzCurrencyFormat myFormat = new ezc.ezbasicutil.EzCurrencyFormat();
	String userName=(String)Session.getUserId();
	String crBy=null;
	String role=(String)session.getValue("UserRole");
		String stat=null;
		String st=retHeadDetails.getFieldValueString(0,"STATUS");
		st=st.trim();

		if("D".equals(st)) stat="Dispatched";
		else if ("R".equals(st)) stat="Acknowledged";
	if ((retHeadDetails!=null)||(retHeadDetails.getRowCount()>0))
	{

	%>
	<table  width="95%"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
	<tr>
		<th align="left" width='25%'><%=salNum_L%></th>
		<td width='35%'>
		<input type=hidden name="SoNum" value="<%=retHeadDetails.getFieldValue(0,"SO_NUM")%>">
		<input type=hidden name="DelNum" value="<%=delNum%>">
		<%=retHeadDetails.getFieldValue(0,"SO_NUM")%>
		</td>
<!--		<th align="left" width='20%'><%=salDate_L%></th> -->
		<th align="left" width='20%'><%=ordDat_L%></th>

		<td width='20%'><%=FormatDate.getStringFromDate((Date)retHeadDetails.getFieldValue(0,"SO_DATE"),".",FormatDate.MMDDYYYY)%></td>
	</tr>
	<tr>
		<th align="left" width='25%'><%=dcNo_L%></th>
		<td width='35%'><%=retHeadDetails.getFieldValue(0,"DC_NR")%>&nbsp;</td>
		<th align="left" width='20%'><%=dcDate_L%></th>
		<td width='20%'><%=FormatDate.getStringFromDate((Date)retHeadDetails.getFieldValue(0,"DC_DATE"),".",FormatDate.MMDDYYYY)%></td>
	</tr>

	<tr>
		<th align="left" width='25%'><%=lrNo_L%></th>
		<td width='35%'><%=retHeadDetails.getFieldValue(0,"LR_RR_AIR_NR")%></td>
		<!-- <th align="left" width='20%'><%=shiDate_L%></th> -->
		<th align="left" width='20%'><%=shipDat_L%></th>

		<td width='20'><%=FormatDate.getStringFromDate((Date)retHeadDetails.getFieldValue(0,"SHIPMENT_DATE"),".",FormatDate.MMDDYYYY)%></td>
	</tr>
	<tr>
		<th align="left" width='25%'><%=caName_L%></th>
		<td width='35%'><%=retHeadDetails.getFieldValue(0,"CARRIER")%></td>
		<%if ("D".equals(st))
		{%>
			<th align="left" width='20%'><%=exAvaDate_L%></th>
			<td width='20%'><%=FormatDate.getStringFromDate((Date)retHeadDetails.getFieldValue(0,"EXP_ARIVAL_TIME"),".",FormatDate.MMDDYYYY)%></td>
		<%}
		else if("R".equals(st)){%>
			<th align="left" width='20%'><%=recDate_L%></th>
			<td width='20%'><%=FormatDate.getStringFromDate((Date)retHeadDetails.getFieldValue(0,"GOODS_RECEIVED"),".",FormatDate.MMDDYYYY)%></td>
		<%}%>
	</tr>
	<tr>
		<th align="left" width='25%'><%=shipTo_L%> </th>
		<td width='35%'>
		<%
		String sold=retHeadDetails.getFieldValueString(0,"SOLDTO");
		String ship=retHeadDetails.getFieldValueString(0,"SHIPTO");

		/*if (SoldTo.equals(sold)){}
		else
			utilManager.setSysKeyAndSoldTo(SysKey,sold);*/

		ReturnObjFromRetrieve listShipTos = (ReturnObjFromRetrieve) utilManager.getListOfShipTos(sold);

		/*if (SoldTo.equals(sold)){}
		else
			utilManager.setSysKeyAndSoldTo(SysKey,defSoldTo);*/

		String  Name=ship;
		for ( int j = 0 ; j < listShipTos.getRowCount(); j++ )
		{
			if(listShipTos.getFieldValueString(j,"EC_PARTNER_NO").equals(ship))
				Name = listShipTos.getFieldValueString(j,"ECA_NAME");
		}
		out.println(Name);
		%></td>
		<%

		crBy=retHeadDetails.getFieldValueString(0,"CREATED_BY");
		crBy ="MTUCKER";
		crBy=crBy.trim();
		if ("D".equals(st)&&(!"LF".equals(role) || !"BP".equals(role))&&(userName.equals(crBy)))
		{%>
			<th  align="left" width='20%'><%=recDate_L%></th>
			<td width='20%'><input type=text name="recDate" class=InputBox value=""  size=12 maxlength="10" readonly><%=getDateImage("recDate")%></td>
		<%}
		else if("R".equals(st))
		{%>
			<th  align="left" width='20%'><%=status_L%></th>
			<Td width='20%'><%=ack_L%>&nbsp;</td>
		<%}
		else{%>
			<th  align="left" width='20%'><%=status_L%></th>
			<Td width='20%'><%=dispatch_L%></td>
		<%}%>
	</tr>
	<tr>
		<th align="left" width='25%'><%=remark_L%></th>
		<td align="left" colspan=3 width='75%'>
		<TextArea rows="1" style="overflow:auto" class=txarea cols="58" readonly><%=retHeadDetails.getFieldValueString(0,"HEADERTEXT")%></TextArea>
		</td>
	</tr>
	</table>
	<%
	}%>

	<%if ((retLineDetails!=null)||(retLineDetails.getRowCount()>0))
	{
	%>
	<Div id="theads">
	<table width="95%"  id="tabHead"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
	<tr>
		<th width="8%"><%=lineNo_L%></th>
		<th width="16%"><%=batNo_L %></th>
		<th width="35%"><%=proddesc_L%></th>
		<th width="5%"><%=uom_L%></th>
		<th width="13%"><%=qtyShip_L%> </th>
		<th width="13%"><%=qtyRec_L %></th>
	<!--	<th width="6%"><%= rem_L%></th> -->
		<th width="14%"><%=remark_L%></th> 

	</tr>
	</Table>
	</Div>
<%
if ((retHeadDetails!=null)||(retHeadDetails.getRowCount()>0)){
%>
 	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:98%;height:35%;left:2%">

<%}else{%>
	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:98%;height:60%;left:2%">
<%}%>

	<Table align=center  id="InnerBox1Tab"  class=tableClass border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=0 cellSpacing=0 width="100%">
<%
	int line=0;
	String batch=null;
	String matNo=null;
	String matDesc=null;
	String UOM=null;
	String QTY=null;
	String Ext2=null;
	String rqty=null;
	String Plant=null;
	int spanCount=0;
	//out.println(retLineDetails.toEzcString());

	for (int i=0;i<retLineDetails.getRowCount();i++)
	{
		String lin =retLineDetails.getFieldValueString(i,"LINE_NR");
		lin=(lin == null || "null".equals(lin) || lin.trim().length() == 0)?"0":lin;
		line=Integer.parseInt(lin);
		matDesc=retLineDetails.getFieldValueString(i,"MAT_DESC");
		UOM=retLineDetails.getFieldValueString(i,"UOM");
		QTY=retLineDetails.getFieldValueString(i,"QTY_SHIPPED");
		batch=retLineDetails.getFieldValueString(i,"BATCHNO");
		batch= ((batch==null)||("null".equals(batch)))?" ":batch;
		Ext2=retLineDetails.getFieldValueString(i,"REFNO");
		//Plant=retLineDetails.getFieldValueString(i,"PLANT");
		rqty=retLineDetails.getFieldValueString(i,"RECEIPTS");

		if ("MultiBatch".equals(Ext2))
		{%>
		<Tr><td>
			<span>
			<Table width='100%'  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
			<Tr>
			<td width='8%'><%=line%>&nbsp;</td>
			<td width='16%'>
			<a href='JavaScript:showSpan("<%=spanCount%>")'><%=multiBatch_L%></a>
			</td>
			<td width='35%'><%=matDesc%></td>
			<td width='5%'><%=UOM%></td>
			<Td width='13%' align='right'>
			<input type="hidden" name="shippedQty_<%=i%>" value="<%=retLineDetails.getFieldValue(i,"QTY_SHIPPED")%>"><%=retLineDetails.getFieldValue(i,"QTY_SHIPPED")%></Td>
			<% if ("D".equals(st)&&(!"LF".equals(role))&&(userName.equals(crBy)))
			{%>
				<td width='13%' align="right">
				<input type=hidden name="lineno_<%=i%>" value="<%=line%>">
				<input type=hidden name="recQty_<%=i%>" value="<%=retLineDetails.getFieldValue(i,"QTY_SHIPPED")%>">
				<%=retLineDetails.getFieldValue(i,"QTY_SHIPPED")%></td>
				<Td width="14%"><input type="hidden" name="Rem_<%=i%>"><a href="JavaScript:openWindow('Received.Rem_<%=i%>')">&nbsp;<image src="../../Images/Buttons/<%= ButtonDir%>/text.gif" border=0  <%=statusbar%>  ></a></Td>
			<%
		}
		else if ("R".equals(st))
		{%>
			<Td  width='13%' align='right'><%=retLineDetails.getFieldValue(i,"RECEIPTS")%></td>
			<%
			if ("".equals(retLineDetails.getFieldValueString(i,"REMARKS").trim())){%>
				<Td  width="14%">&nbsp;</Td>
			<%}else{%>
				<td  width="14%">&nbsp;<input type="hidden" name="Rem_<%=i%>" value="<%=retLineDetails.getFieldValueString(i,"REMARKS")%>"><a href="JavaScript:openWindow1('Received.Rem_<%=i%>')">&nbsp;<image src="../../Images/Buttons/<%= ButtonDir%>/text.gif" border=0  <%=statusbar%> height="10"></a></td>
			<%}%>
		<%}
		else
		{%>
			<Td  width='13%' align='right'><%=retLineDetails.getFieldValue(i,"RECEIPTS")%></td>
			<Td  width="14%">&nbsp;</Td>
		<%}
		%>

		</Tr>
		</Table>
		</span>
		<span id="SP<%=spanCount%>"  style="display:none">
		<Table width='100%'  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<%
		int n=i;
		int tot = 0;
		for (int j=i+1;j<retLineDetails.getRowCount();j++)
		{
			String refno =retLineDetails.getFieldValueString(j,"REFNO");
			refno=(refno == null || "null".equals(refno) || refno.trim().length() == 0)?"0":refno.trim();
			try{
			refno=String.valueOf(Integer.parseInt(refno));	
			}catch(Exception e){}
			if (lin.equals(refno))
			{	i++;
		%>
			<tr>
				<td width='8%'>&nbsp;</td>
				<td width='16%' align="center"><%=retLineDetails.getFieldValue(j,"BATCHNO")%>&nbsp;</td>
				<td width='35%'><%=retLineDetails.getFieldValue(j,"MAT_DESC")%></td>
				<td width='5%'><%=retLineDetails.getFieldValue(j,"UOM")%></td>
				<Td width='13%' align='right'>
				<input type="hidden" name="shippedQty_<%=j%>" value="<%=retLineDetails.getFieldValue(j,"QTY_SHIPPED")%>">
				<%=retLineDetails.getFieldValue(j,"QTY_SHIPPED")%>
				</Td>
				<%if ("D".equals(st)&&(!"LF".equals(role))&&(userName.equals(crBy)))
				{%>
					<td width='13%' align="right">
					<input type=hidden name="lineno_<%=j%>" value="<%=retLineDetails.getFieldValueString(i,"LINE_NR")%>">
					<input type=hidden name="recQty_<%=j%>" value="<%=retLineDetails.getFieldValue(j,"QTY_SHIPPED")%>">
					<%=retLineDetails.getFieldValue(j,"QTY_SHIPPED")%></td>
					<Td width="14%"><input type="hidden" name="Rem_<%=i%>"><a href="JavaScript:openWindow('Received.Rem_<%=i%>')">&nbsp;<image src="../../Images/Buttons/<%= ButtonDir%>/text.gif" border=0  <%=statusbar%> ></a></Td>
				<%tot++;
				}
				else if ("R".equals(st))
				{%>
					<Td  width='13%' align='right'><%=retLineDetails.getFieldValue(j,"RECEIPTS")%></td>
					<%
					if ("".equals(retLineDetails.getFieldValueString(i,"REMARKS").trim()))
					{%>
						<Td  width="14%">&nbsp;</Td>
					<%}else{%>
						<td  width="14%">&nbsp;<input type="hidden" name="Rem_<%=i%>" value="<%=retLineDetails.getFieldValueString(i,"REMARKS")%>"><a href="JavaScript:openWindow1('Received.Rem_<%=i%>')">&nbsp;<image src="../../Images/Buttons/<%= ButtonDir%>/text.gif" border=0 height="10"  <%=statusbar%>></a></td>
					<%}%>
				<%}
				else
				{%>
					<Td  width='13%' align='right'><%=retLineDetails.getFieldValue(i,"RECEIPTS")%></td>
					<Td  width="14%">&nbsp;</Td>
				<%}%>

			</tr>
			<%
			}
			if ("MultiBatch".equals(retLineDetails.getFieldValueString(j+1,"REFNO")))
			{
				break;
			}
		}%>
		<%if (tot > 0){%><input type="hidden"  name="final_<%=n%>" value="<%= tot%>"><%}%>
		</Table>
		</span>
	<%	spanCount++;
	%>
		</Td></Tr>
	<%
	}
	else
	{%>
		<Tr><Td>
		<span>
		<Table width='100%'  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<Tr>
		<td width='8%'><%=line%></td>
		<td width='16%'><%=batch%>&nbsp;</td>
		<td width='35%'><%=matDesc%></td>
		<td width='5%'><%=UOM%></td>
		<Td width='13%' align='right'>
		<input type="hidden" name="shippedQty_<%=i%>" value="<%=retLineDetails.getFieldValue(i,"QTY_SHIPPED")%>">
		<%=retLineDetails.getFieldValue(i,"QTY_SHIPPED")%>
		</Td>
		<%
		if ("D".equals(st)&&(!"LF".equals(role))&&(userName.equals(crBy)))
		{%>
			<td width='13%' align="right"><input type=hidden name="lineno_<%=i%>" value="<%=line%>">
			<input type="hidden" name="recQty_<%=i%>" value="<%=retLineDetails.getFieldValue(i,"QTY_SHIPPED")%>">
			<%=retLineDetails.getFieldValue(i,"QTY_SHIPPED")%></td>
			<Td width="14%"><input type="hidden" name="Rem_<%=i%>"><a href="JavaScript:openWindow('Received.Rem_<%=i%>')">&nbsp;<image src="../../Images/Buttons/<%= ButtonDir%>/text.gif" border=0  <%=statusbar%>></a></Td>
		<%
		}
		else if ("R".equals(st))
		{%>
			<Td  width='13%' align='right'><%=retLineDetails.getFieldValue(i,"RECEIPTS")%></td>
			<%
			if ("".equals(retLineDetails.getFieldValueString(i,"REMARKS").trim())){%>
				<Td  width="14%">&nbsp;</Td>
			<%}else{%>
				<td  width="14%">&nbsp;<input type="hidden" name="Rem_<%=i%>" value="<%=retLineDetails.getFieldValueString(i,"REMARKS")%>"><a href="JavaScript:openWindow1('Received.Rem_<%=i%>')">&nbsp;<image src="../../Images/Buttons/<%= ButtonDir%>/text.gif" border=0 height="10"  <%=statusbar%>></a></td>
			<%}%>
		<%}
		else
		{%>
			<Td  width='13%' align='right'><%=retLineDetails.getFieldValue(i,"RECEIPTS")%></td>
			<Td  width="14%">&nbsp;</Td>
		<%}
		%>
		</Tr>
		</Table>
		</span>
		</Td></Tr>

	<%}
	}//for
	%>
	</Table>
		</Div>
		
	<input type='hidden' name="TotCount" value="<%=retLineDetails.getRowCount()%>">

	<%}
	else
	{%>
		<table  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >><Tr><Td align='center' colspan=5><%=noLines_L%></Td></Tr></Table>
	<%}%>

	<%
	
	if ("D".equals(st)&&(!"LF".equals(role))&&(userName.equals(crBy))){%>
	<%}%>
	
	<div id="buttonDiv" style="position:absolute;top:90%;width:100%" align=center>
	<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		if ("D".equals(st)&&(!"LF".equals(role)) && (userName.equals(crBy.trim())))
		{
			buttonName.add("Received");
			buttonMethod.add("submitPage()");
			buttonName.add("Back");
			buttonMethod.add("displayMsg()");
		}
		else
		{
			buttonName.add("Back");
			buttonMethod.add("ezBack()");
		}
		out.println(getButtonStr(buttonName,buttonMethod));
	%>
</div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>

<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Shipment/iSelectShipment.jsp" %>
<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script>
	var POrders= new Array()
	var PContracts= new Array()
	ordLength=0
	conLength=0
	var base;
	var baseValue;
	var PODate = new Array()
	var PCDate = new Array()
<%
		int pocount=0;
	/*
		While preparing Open POs list , here we are excluding the POs which are not Acknowledged and Rejected Orders.
	*/
	
	if(hdrXML.getRowCount()>0)
		hdrXML.sort(new String[] {"ORDER"},false);
	
	for(int i=0;i<hdrXML.getRowCount();i++)
      	{
		String poNum = hdrXML.getFieldValueString(i,ORDER);
		
		if (!ackOrders.contains(poNum))
		{
			pocount++;
%>
			POrders[ordLength] = "<%=hdrXML.getFieldValue(i,ORDER)%>"
			PODate[ordLength] = "<%=hdrXML.getFieldValue(i,ORDER)%>^^<%=hdrXML.getFieldValue(i,ORDERDATE)%>^^<%=hdrXML.getFieldValue(i,CURRENCY)%>^^<%=hdrXML.getFieldValueString(i,"NETAMOUNT")%>"
			ordLength=ordLength+1
<%
		}
	}
	
	if(purchctrhdr.getRowCount()>0)
		purchctrhdr.sort(new String[] {"CONTRACT"},false);
	
	for(int i=0;i<purchctrhdr.getRowCount();i++)
      	{
	%>
		PContracts[conLength]="<%=purchctrhdr.getFieldValue(i,contract)%>"
		PCDate[conLength]="<%=purchctrhdr.getFieldValue(i,contract)%>^^<%=purchctrhdr.getFieldValue(i,CONTRACTDATE)%>^^<%=purchctrhdr.getFieldValue(i,CURRENCY1)%>^^<%=purchctrhdr.getFieldValueString(i, "NETAMOUNT1")%>"
		conLength=conLength+1
      	<%
	}
	%>

	function showValues()
	{
		for(slen=document.myForm.baseValues.options.length-1;slen>0;slen--)
			document.myForm.baseValues.options[slen]=null

		if(document.myForm.base.options[document.myForm.base.selectedIndex].value=="PurchaseOrder")
		{
			for(i=0;i<POrders.length;i++)
			{
				document.myForm.baseValues.options[i+1]=new Option(POrders[i],POrders[i])
			}

		}
		else if(document.myForm.base.options[document.myForm.base.selectedIndex].value=="PContracts")
		{
			for(i=0;i<PContracts.length;i++)
			{
				document.myForm.baseValues.options[i+1]=new Option(PContracts[i],PContracts[i])
			}
                }
	}

	function chk()
	{
		if (document.myForm.base.selectedIndex==0){
			alert ("Please select Document Type.");
			document.myForm.base.focus();
			return false;
		}
		else if ((document.myForm.base.selectedIndex!=0)&&(document.myForm.baseValues.selectedIndex==0)){
			alert ("Please Select Document No.");
			document.myForm.baseValues.focus();
			return false;
		}
		else if ((document.myForm.base.selectedIndex!=0)&&(document.myForm.baseValues.value=='0')){
			alert ("No Documents found for the selected Document Type");
			document.myForm.baseValues.focus();
			return false;
		}
		pp = document.myForm.base.value;
		pp1 = document.myForm.baseValues.value;

		if(pp == "PurchaseOrder"){
			for(i=0;i<PODate.length;i++){
				one=PODate[i].split("^^");
				if(pp1==one[0]){
					document.myForm.OrderDate.value=one[1];
					document.myForm.orderCurrency.value=one[2];
					document.myForm.OrderValue.value=one[3];
					document.myForm.Type.value="P";
					break;
				}
			}
		}
		else {
			for(i=0;i<PCDate.length;i++){
				one=PCDate[i].split("^^");
				if(pp1==one[0]){
					document.myForm.OrderDate.value=one[1];
					document.myForm.orderCurrency.value=one[2];
					document.myForm.OrderValue.value=one[3];
					document.myForm.Type.value="S";
					break;
				}
			}
		}
		document.myForm.submit();
	}
</script>

</head>
<body scroll=no>
<%
	if(!userType.equals("2"))
	{
%>
		<form name="myForm" action="ezAddShipmentDetails.jsp">
<%
		int purcount=hdrXML.getRowCount();
		int schagree=purchctrhdr.getRowCount();
		if(pocount==0 && schagree==0)
		{
			String noDataStatement ="No Purchase Orders/Sch.Agreements Present to Add Shipment.";
%>		
			<%@ include file="../Misc/ezDisplayNoData.jsp" %>
<%		
			return;
		}
		String display_header = "Add Shipment";
%>
		<%@ include file="../Misc/ezDisplayHeader.jsp" %>
		<input type="hidden" name="OrderDate">
		<input type="hidden" name="OrderValue">
		<input type="hidden" name="orderCurrency">
		<input type="hidden" name="Type" >
		<br>
	
		<Div id='inputDiv' style='position:relative;align:center;top:10%;width:100%;height:100%'>
		<Table width="30%" height="25%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
		<Tr>
			<Td height="5" style="background-color:'F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"></Td>
			<Td height="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"></Td>
			<Td height="5" style="background-color:'F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"></Td>
		</Tr>
		<Tr >
			<Td width="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"></Td>
			<Td style="background-color:'F3F3F3'" valign=middle>
				<Table border="0" align="center" valign=middle width="100%" cellpadding=5 cellspacing=5 class=welcomecell>
				<Tr>
					<Td style='background:#F3F3F3;font-size=11px;color:#660000;font-weight:bold' width='45%' align=left>
						&nbsp;&nbsp;Document Type
					</Td>
					<Td style='background:#F3F3F3;font-size=11px;color:#660000;font-weight:bold' width='45%' align=right>
						<Select name="base" onChange="showValues()" style="width:100%">
						<option value=" ">Select Type</option>
<%
						if(pocount>0)
						{
%>
							<option value="PurchaseOrder">Purchase Order</option>
<%
						}
						if(schagree>0)
						{
%>
							<option value="PContracts">Scheduled Agreement</option>
<%
						}
%>
						</select>
					</Td>
				</Tr>	
				<Tr>
					<Td style='background:#F3F3F3;font-size=11px;color:#660000;font-weight:bold' width='45%' align=left>
						&nbsp;&nbsp;Document No
					</Td>
					<Td style='background:#F3F3F3;font-size=11px;color:#660000;font-weight:bold' width='45%' align=center>
						<select name="baseValues" style="width:100%">
							<option value=" ">Select No</option>
						</select>
					</Td>
				</Tr>	
				<Tr>
				<Td colspan=2 style='background:#F3F3F3' align=right>
					<Img src="../../../../EzCommon/Images/Body/left_arrow.jpg" style="cursor:hand" border="none" onClick="chk()" onMouseover="window.status=' Add  the Shipment '; return true" onMouseout="window.status=' '; return true">
				</Td>
				</TR>
				</Table>
			</Td>
			<Td width="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e3.gif"><img width="5" height="1" src="Cb_e3.gif"></Td>
		</Tr>
		<Tr>
			<Td width="5" style="background-color:'F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"></Td>
			<Td height="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"></Td>
			<Td width="5" style="background-color:'F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"></Td>
		</Tr>
		</Table>
		</Div>	
		</form>
<%
	}
	else
	{
%>
		<body>
		<br><br><br><br>
		<p align="center"><b>Sorry, You don't have the privilege to Add Shipments as Internal Buyer</b></p>
<%
	}
%>
<Div id="MenuSol"></Div>
</body>
</html>













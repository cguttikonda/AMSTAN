
<%
	boolean showData = false;
	String sysKey = (String) session.getValue("SYSKEY");
	String soldTo = (String) session.getValue("SOLDTO");
	String uType = (String) session.getValue("UserType");
	EziShipmentInfoParams  inParams = new EziShipmentInfoParams ();
	inParams.setSysKey(sysKey);
	inParams.setSoldTo(soldTo);
	if ("2".equals(uType))
		inParams.setStatus("Y");
	EzcParams ezcparams1= new EzcParams(true);
	ezcparams1.setLocalStore("Y");
	ezcparams1.setObject(inParams);
	Session.prepareParams(ezcparams1);
	ReturnObjFromRetrieve retObj=(ReturnObjFromRetrieve) shipManager.ezGetPurchaseOrders(ezcparams1);
	int rowCount = 0;
	if(retObj != null)
	{
		rowCount = retObj.getRowCount();
		if(rowCount>0)
			retObj.sort(new String[] {"PO_NUM"},false);
		for(int i=rowCount-1;i>=0;i--)
	      	{
			if(retObj.getFieldValueString(i,"PO_NUM").equals("Samples"))
			{
				retObj.deleteRow(i);
			}
		}
		rowCount = retObj.getRowCount();
	}
%>

<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<script>
	function submitIt()
	{
		if (document.myForm.base.selectedIndex==0)
		{
			alert ("Please select Document Type.");
			document.myForm.base.focus();
			return false;
		}
		else{
			//document.myForm.action = "ezListViewShipmentHeaders.jsp";
			document.myForm.showData.value='Y'
			document.myForm.submit()
		}
	}

</script>

</head>
<body scroll="no">

<form name="myForm" >
<%
	if(rowCount > 0)
	{
		String display_header = "View Shipment";
%>
		<%@ include file="../Misc/ezDisplayHeader.jsp" %>

	<Div id='inputDiv' style='position:relative;align:center;top:1%;width:100%;height:100%'>
	<Table width="30%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
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
					&nbsp;&nbsp;Purchase Order
				</Td>
				<Td style='background:#F3F3F3;font-size=11px;color:#660000;font-weight:bold' width='45%' align=right>
					<Select name="base" style="width:100%">
						<option value=''>Select</option>
<%
						for(int i=0;i<rowCount;i++)
						{
							out.println("<option value='"+retObj.getFieldValueString(i,"PO_NUM")+"'>"+retObj.getFieldValueString(i,"PO_NUM")+"</option>");
						}
%>
					</select>
				</Td>
				<Td style='background:#F3F3F3' align=center>
					<Img src="../../../../EzCommon/Images/Body/left_arrow.jpg" style="cursor:hand" border="none" onClick="submitIt()" onMouseover="window.status=' Add  the Shipment '; return true" onMouseout="window.status=' '; return true">
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
		<input type=hidden name="showData" >
<%
	}
	else
	{
		String noDataStatement = "No Shipment Info added by "+(String)session.getValue("Vendor")+".";
%>
		<%@ include file="../Misc/ezDisplayNoData.jsp" %>
<%
	}
%>

</form>
<Div id="MenuSol"></Div>
</body>
</html>

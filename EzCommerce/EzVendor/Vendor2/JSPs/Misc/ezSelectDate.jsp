<%
	if( (fromDate== null && toDate == null) || ("null".equals(toDate) && "null".equals(fromDate)) ){
	
		fromDate = "";
		toDate = "";
		
	}

%>


<Div id='inputDateDiv' style='position:relative;align:center;top:0%;width:100%;'>
<Table width="45%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
<Tr>
	<Td height="5" style="background-color:'F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"></Td>
	<Td height="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"></Td>
	<Td height="5" style="background-color:'F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"></Td>
</Tr>
<Tr>
	<Td width="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"></Td>
	<Td style="background-color:'F3F3F3'" valign=middle>
		<Table border="0" align="center" valign=middle width="100%" cellpadding=0 cellspacing=0 class=welcomecell>
		<Tr>
			<Td style='background:#F3F3F3;font-size=11px;color:#00355D;font-weight:bold;' width='45%' valign=center>
				From Date&nbsp;&nbsp;<input type=text class=inputbox value="<%=fromDate%>" id="FromDate" name="FromDate"  readonly size=15 maxlength="10">&nbsp;<%=getDateImage("FromDate")%>
			</Td>
			<Td style='background:#F3F3F3;font-size=11px;color:#00355D;font-weight:bold;' width='45%' align=right valign=center>
				To Date&nbsp;&nbsp;<input type=text class=inputbox value="<%=toDate%>" id="ToDate" name="ToDate"  readonly size=15 maxlength="10">&nbsp;<%=getDateImage("ToDate")%>
			</Td>
			<Td style='background:#F3F3F3;font-size=11px;color:#00355D;font-weight:bold;align:center' width='45%' align=right>
				<Img src="../../../../EzCommon/Images/Body/left_arrow.gif" style="cursor:hand" border="none" <%=clickString%> onMouseover="window.status=''; return true" onMouseout="window.status=' '; return true">
			</Td>
		</Tr>
		
		</Table>
	</Td>
	<Td width="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e3.gif"><img width="5" height="1" src="Cb_e3.gif" ></Td>
</Tr>
<Tr>
	<Td width="5" style="background-color:'F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"></Td>
	<Td height="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"></Td>
	<Td width="5" style="background-color:'F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"></Td>
</Tr>
</Table>
</Div>

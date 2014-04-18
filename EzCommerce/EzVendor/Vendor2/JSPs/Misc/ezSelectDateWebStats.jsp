<Div id='inputDiv' style='position:relative;align:center;top:0%;width:100%;'>
<Table width="63%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
<Tr>
	<Td height="5" style="background-color:'#F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"></Td>
	<Td height="5" style="background-color:'#F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"></Td>
	<Td height="5" style="background-color:'#F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"></Td>
</Tr>
<Tr>
	<Td width="5" style="background-color:'#F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"></Td>
	<Td style="background-color:'#F3F3F3'" valign=middle>
		<Table border="0" align="center" valign=middle width="100%" cellpadding=3 cellspacing=0 class=welcomecell>
		<Tr>
			<Td style='background:##F3F3F3;font-size=11px;color:#00355D;font-weight:bold;' width='21%' align=right >Purchase Area</Td>
			<Td style='background:##F3F3F3;font-size=11px;color:#00355D;font-weight:bold;' width='23%' valign=center >
			<select name="WebSysKey" class="control" align="right" id='ListBoxDiv'>
			<option value="">All</option>
			<%	StringBuffer allopt=new StringBuffer("");
				for(int i=0;i<sysRows;i++)
				{
					if(i==0)
					{
						allopt.append("'" + ret.getFieldValue(i,SYSTEM_KEY) +"'");
					}
					else
					{
						allopt.append(",");
						allopt.append("'" + ret.getFieldValue(i,SYSTEM_KEY) +"'");
					}
			%>							
				<option value="'<%=ret.getFieldValue(i,SYSTEM_KEY)%>'" ><%=ret.getFieldValue(i,SYSTEM_KEY_DESCRIPTION)%></option>
			<%	}%>
			</select>
		     	</Td>
			<Td style='background:##F3F3F3;font-size=11px;color:#00355D;font-weight:bold;' width='30%' valign=center>
				&nbsp;&nbsp;<%=from_L%>&nbsp;&nbsp;<input type=text class=inputbox value="<%=fromDate%>" name="FromDate"  readonly size=15 maxlength="10">&nbsp;<%=getDateImage("FromDate")%>
			</Td>
			<Td style='background:##F3F3F3;font-size=11px;color:#00355D;font-weight:bold;' width='24%' valign=center>
				<%=to_L%>&nbsp;&nbsp;<input type=text class=inputbox name="ToDate" value="<%=toDate%>"  readonly size=15 maxlength="10">&nbsp;<%=getDateImage("ToDate")%>
			</Td>
			<Td style='background:##F3F3F3;font-size=11px;color:#00355D;font-weight:bold' width='2%' valign='right'>
				<Img src="../../../../EzCommon/Images/Body/left_arrow.gif" style="cursor:hand" <%=clickString%> onMouseover="window.status=' Add  the Shipment '; return true" onMouseout="window.status=' '; return true">
			</Td>
		</Tr>
		
		</Table>
	</Td>
	<Td width="5" style="background-color:'#F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e3.gif"><img width="5" height="1" src="Cb_e3.gif" ></Td>
</Tr>
<Tr>
	<Td width="5" style="background-color:'#F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"></Td>
	<Td height="5" style="background-color:'#F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"></Td>
	<Td width="5" style="background-color:'#F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"></Td>
</Tr>
</Table>
</Div>
<Div id="MenuSol"></Div>
<BR>
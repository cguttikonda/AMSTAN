<Table  width=60% align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
<Tr>
	<Th align=right >Sales Area</Td>
	<Td class=blankcell valign=center >
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
	<Th align=right >&nbsp;&nbsp;<%=from_L%>&nbsp;&nbsp;</Th>
	<Td class=blankcell valign=center >
		<input type=text class=inputbox value="<%=fromDate%>" name="FromDate"  readonly size=15 maxlength="10">&nbsp;<%=getDateImage("FromDate")%>
	</Td>
	<Th align=right >&nbsp;&nbsp;<%=to_L%>&nbsp;&nbsp;</Th>
	<Td class=blankcell valign=center>
		<input type=text class=inputbox name="ToDate" value="<%=toDate%>"  readonly size=15 maxlength="10">&nbsp;<%=getDateImage("ToDate")%>
	</Td>
	<Td style='background:##F3F3F3;font-size=11px;color:#00355D;font-weight:bold' width='2%' valign='right'>
		<Img src="../../../../EzCommon/Images/Body/left_arrow.gif" style="cursor:hand" <%=clickString%> onMouseover="window.status=' Add  the Shipment '; return true" onMouseout="window.status=' '; return true">
	</Td>
</Tr>

</Table>

<BR>
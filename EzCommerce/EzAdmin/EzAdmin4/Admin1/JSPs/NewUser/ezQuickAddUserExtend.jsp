<Div id="theads">
      <Table id="tabHead" width="50%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr>
		<Th>Customer Extension</Th>
	</Tr>
	</Table>

        <Table  width="50%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr>
		<Th width = "25%" align="right">Sales Area</Th>
		<Td width = "25%"><input type = "text" class = "tx" name = "salesArea" size = 15 maxlength = "10" value="<%=salesArea%>" readonly></Td>
	</Tr>
	<Tr>	
		<Th width = "25%" align="right">Sold To</Th>
		<%
			soldTo="0000000000"+soldTo;
			soldTo = soldTo.substring(soldTo.length()-10,soldTo.length());
		%>
		<Td width = "25%"><input type = "text" class = "tx" name = "soldTo" size = 30 maxlength = "60" value="<%=soldTo%>" readonly></Td>
	</Tr>
	<Tr>
		<Th width = "25%" align="right">Partner Number</Th>
		<Td width = "25%"><input type = "text" class = "tx" name = "partnerNo" size = 30 maxlength = "60" value='<%=retUserCust.getFieldValueString(0,"EC_BUSINESS_PARTNER")%>' readonly></Td>
	</Tr>
	</Table>	
</Div>

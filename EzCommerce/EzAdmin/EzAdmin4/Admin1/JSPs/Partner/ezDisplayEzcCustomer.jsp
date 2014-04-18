
<%
	int custCount = retcust.getRowCount();
	if ( custCount > 0 && syskeyRows > 0)
	{
		if ( retcust.find("EC_SYS_KEY", catArea) )
		{
%>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
			<Tr>
				<Th colspan="3" class="tabclass">Customers Already Synchronized</Th>
			</Tr>
			<Tr>
				<Th width="20%" class="tabclass">Customer No.</Th>
				<Th width="20%" class="tabclass">Sold To</Th>
				<Th width="60%" class="tabclass">ERP Customer Name</Th>
			</Tr>
<%
		}
		else
		{
			
%>
    			<Tr>
			      	<Th colspan="3" class="tabclass">No Customers Synchronized for this Business Partner</Th>
    			</Tr>
<%
		}//end if retcust.find
		int y = 0;
		int z = 0;
		for ( int x = 0; x < custCount; x++)
		{
			String ezcCust = retcust.getFieldValueString(x,"EC_NO");
			String cType = retcust.getFieldValueString(x,"EC_PARTNER_FUNCTION");
			cType = cType.trim();
			String cArea = retcust.getFieldValueString(x,"EC_SYS_KEY");
			cArea = cArea.trim();
			if ( cType.equals("AG") && cArea.equals(catArea))
			{
				String custNo = retcust.getFieldValueString(x,"EC_ERP_CUST_NO");
				custNo = custNo.trim();
				String custName = retcust.getFieldValueString(x,"ECA_NAME");
				custName = custName.trim();
				String custCity = (String)retcust.getFieldValue(x,"ECA_CITY");
				if ( custCity != null && !custCity.equals("null") )
				{
					custCity = "-"+custCity.trim();
				}
				else
				{
					custCity = "";
				}
				custName = custName+custCity;
%>
				<Tr>
					<Td width="20%" height="22" align="center"> <%= ezcCust %></Td>
					<Td width="20%" height="22" align="center"> <%= custNo %></Td>
					<Td nowrap width="60%" height="22" align="center"><%= custName %></Td>
					<input type="hidden" name="ECUST" value="<%=custNo%>"  >
				</Tr>
<%
				z++;
			}
			else
			{
				y++;
			} //end if cType
		} //end For
%>
		<input type="hidden" name="CheckCount" value=<%=z%> >
		<input type="hidden" name="ECUST" value="">
	</Table>

<%
	if ( y == 0 && z == 0)
	{
%>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
		<Tr>
			<Td class = "labelcell">
				<div align="center"><b>No Customers Synchronized for this Business Partner.</b></div>
				<input type="hidden" name="CheckCount" value=0 >
			</Td>
		</Tr>
		</Table>
<%
	  } //y == 0
	}
	else
	{
%>
	<input type="hidden" name="ECUST" value="">
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
		<Tr>
			<Td class = "labelcell">
				<div align="center"><b>No Customers Synchronized for this Business Partner.</b></div>
				<input type="hidden" name="CheckCount" value=0 >
			</Td>
		</Tr>
	</Table>
<%
	}
%>


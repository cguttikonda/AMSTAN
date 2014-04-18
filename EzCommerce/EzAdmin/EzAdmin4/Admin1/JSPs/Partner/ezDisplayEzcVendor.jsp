
<%
	int custCount = retcust.getRowCount();
	if ( custCount > 0 && syskeyRows > 0)
	{
		if ( retcust.find("EC_SYS_KEY",catArea) )
		{
%>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
    <Tr>
      <Th colspan="3" class="tabclass">Vendors Already Synchronized</Th>
    </Tr>
    <Tr>
      <Th width="40%" class="tabclass">Vendor No.</Th>
      <Th width="38%" class="tabclass">Ship To</Th>
      <Th width="38%" class="tabclass">ERP Vendor Name</Th>
    </Tr>
<%
		}
		else
		{
%>
    <Tr>
    </Table>
  
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">  
    <Tr>
      <Th colspan="3" class="tabclass">No Vendors Synchronized for this Business Partner</Th>
    </Tr>
<%
		} //end if retcust.find

			int y = 0, z = 0, w=0;
			for ( int x = 0; x < custCount; x++)
			{
				String ezcCust = retcust.getFieldValueString(x,"EC_NO");
				String cType = retcust.getFieldValueString(x,"EC_PARTNER_FUNCTION");
				cType = cType.trim();
				String cArea = retcust.getFieldValueString(x,"EC_SYS_KEY");
				cArea = cArea.trim();

				if ( cType.equals("VN") && cArea.equals(catArea))
				{
						String custNo = retcust.getFieldValueString(x,"EC_ERP_CUST_NO");
						custNo = custNo.trim();
						z++;
						String vendName = retcust.getFieldValueString(x,"ECA_NAME");
						vendName = vendName.trim();
						String vendCity = (String)retcust.getFieldValue(x,"ECA_CITY");
						if ( vendCity != null && !vendCity.equals("null") )
						{
							vendCity = "-"+vendCity.trim();
						}
						else
						{
							vendCity = "";
						}
						vendName = vendName+vendCity;
%>
    <Tr>
      <Td width="40%" height="22" align="center"> <%= ezcCust %></Td>
      <Td width="38%" height="22" align="center"> <%= custNo %></Td>
      <Td nowrap width="38%" height="22" align="center"><%= vendName %></Td>
      <input type="hidden" name="ECUST" value="<%=custNo%>">
    </Tr>
<%
				w++;
				}
				else
				{
					y++;
				} //end if cType
			} //end For
%>
		<input type="hidden" name="CheckCount" value=<%=w%> >
		<input type="hidden" name="ECUST" value="">

</Table>
</Table>
<%
	if ( y == 0 && z == 0)
	{
%>
 <br><br>
 <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
 	<Tr>
 		<Td class = "labelcell">
 			<div align="center"><b>No Vendors Synchronized for this Business Partner.</b></div>
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
 			<div align="center"><b>No Vendors Synchronized for this Business Partner.</b></div>
 			<input type="hidden" name="CheckCount" value=0 >
 		</Td>
 	</Tr>
</Table>


<%
	}
%>


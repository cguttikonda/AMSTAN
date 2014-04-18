

<%
int sysRows =0;

 sysRows = retFinal.getRowCount();

String sysNum = "";
String sysDesc = "";
String csysNum = "";
String dsysNum = "";

String userRolesYN = null;

java.util.ResourceBundle res = java.util.ResourceBundle.getBundle("Site");

try
{
	userRolesYN = res.getString("Roles");


} catch ( Exception e ) {
	e.printStackTrace();
	userRolesYN = "N";

}


boolean showRoles = true;
if ( userRolesYN != null && userRolesYN.trim().equals("N") )
{
	showRoles = false;
}
else
{
	showRoles = true;
}



for ( int k = 0; k < retFinal.getRowCount(); k++)
{
	if ( showRoles && !retRoles.find("ROLE_NR",retFinal.getFieldValueString(k,"EBPA_AUTH_KEY").trim()) )
	{
		retFinal.deleteRow(k);
		k--;
	}

} //end for
sysRows = retFinal.getRowCount();


if ( sysRows > 0 )
{
%>
<div id="theads">
<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="89%">
    <Tr>      
      <Th width="20%" >System</Th>
      <Th width="5%" title="Select/Deselect All"><input type='checkbox' name='chk1Main' onClick="selectAll()"></Th>
      <Th width="55%" >List Of Authorizations</Th>
    </Tr>
  </Table>
  </div>

<DIV id="InnerBox1Div">
<Table id="InnerBox1Tab" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
<%

	retFinal.sort(new String[]{"EBPA_AUTH_VALUE"},true);
	for ( int i = 0 ; i < sysRows; i++ )
	{
		String roleIndicator = " ";


%>


<%		if ( !retRoles.find("ROLE_NR",retFinal.getFieldValueString(i,"EBPA_AUTH_KEY").trim()) )
		{

			roleIndicator=" ";
			if ( showRoles )
			{
				continue;
			}
		}
		else
		{

			roleIndicator="R";
			if ( !showRoles )
			{
				continue;
			}
		}

%>

			
		<Tr>
		<label for="cb_<%=i%>">
		<Td  width="20%"  align="center" valign="top">
<%

		sysNum = retFinal.getFieldValueString(i,"EBPA_SYS_NO");
		if (!sysNum.equals(csysNum) )
		{
%>
			<input type=hidden name="SysNum" value="<%=sysNum%>">
			<b><%=sysNum%></b></Td>
<%
		}
		else
		{
%>
			&nbsp;</Td>
<%
		}

%>

		<Td  width="5%" align="center" bgcolor="#CCCCCC">
<%
		if (retFinal.getFieldValueString(i,"ISCHECKED").equals("Y") )
		{
%>

      			<input type="checkbox" name="Check<%=sysNum%>" id="cb_<%=i%>" value="<%=retFinal.getFieldValueString(i,"EBPA_AUTH_KEY")%>#<%=retFinal.getFieldValueString(i,"EBPA_AUTH_VALUE")%>#<%=roleIndicator%>" checked >
      			<input type="hidden" name="Stat<%=sysNum%>" value="<%=retFinal.getFieldValueString(i,"EBPA_AUTH_KEY")%>#<%=retFinal.getFieldValueString(i,"EBPA_AUTH_VALUE")%>#<%=roleIndicator%>">
<%
		}
		else
		{
%>
      			<input type="checkbox" name="Check<%=sysNum%>" id="cb_<%=i%>" value="<%=retFinal.getFieldValueString(i,"EBPA_AUTH_KEY")%>#<%=retFinal.getFieldValueString(i,"EBPA_AUTH_VALUE")%>#<%=roleIndicator%>" >

<%
		}
%>
		</Td>
		<Td  width="55%">
		<%=retFinal.getFieldValueString(i,"EBPA_AUTH_VALUE")%>(<%=(retFinal.getFieldValueString(i,"EBPA_AUTH_KEY"))%>)

		</Td>
		</label>
		</Tr>
<%
		csysNum = sysNum;

	}
%>

	<!--<input type="hidden" name="BusUser" value=<%=bus_user%> >-->

<%

}

%>

</Table>
</div>



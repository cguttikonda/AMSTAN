<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Partner/iShowBPInfo.jsp"%>
<html>
<head>
<Title>Show Business Partner Information</Title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<body>
<form name=myForm method=post action="">
<br>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
<Tr align="center">
    	<Td class="displayheader">Business Partner Information</Td>
</Tr>
</Table>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
<Tr>
	<Td valign="top" align="left" width="49%" >
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="100%">
	<Tr>
		<Td width="42%" class="labelcell">Company Name:</Td>
		<Td width="58%"><%=retinfo.getFieldValue(0,BP_COMPANY_NAME)%></Td>
	</Tr>
	<Tr>
		<Td width="42%" class="labelcell"> Description:</Td>
		<Td width="58%"><%=retinfo.getFieldValue(0,BP_DESC)%></Td>
	</Tr>


	<Tr>
		
		<Td width="39%" class="labelcell">Catalog:</Td>
		<Td width="61%">
<%

		
		
		int catRows = retcat.getRowCount();
		String bpCatalog = (retconfig.getFieldValue(0,BP_CATALOG)).toString();


		if ( bpCatalog == null || bpCatalog.equals("0") )
		{
			out.println("No Catalogs Selected");
		}
		else if ( catRows > 0 )
		{
			for ( int i = 0 ; i < catRows ; i++ )
			{
				String val = (retcat.getFieldValue(i,CATALOG_DESC_NUMBER)).toString();
				if(bpCatalog.equals(val.trim()))
				{
%>				
				      	<a href = "../Catalog/ezShowCatalog.jsp?CatNumber=<%=bpCatalog%>&catDesc=<%=retcat.getFieldValueString(i,CATALOG_DESC)%>"><%=retcat.getFieldValueString(i,CATALOG_DESC)%></a>&nbsp;
<%
				}// End if
			}// End For
		}
%>
		</Td>
	</Tr>
	</Table>
	</Td>
	<Td valign="top" width="51%" align="center">
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="100%">
	<Tr>
	<Td colspan="2">
<%
		String UnlimitedFlag = (String)(retconfig.getFieldValue(0,BP_UNLIMITED_USERS));
		if ("Y".equals(UnlimitedFlag))
		{
%>
			<input type="radio" readonly name="UnlimitedUsers" value="Unlimited" checked >
			Unlimited Users
<%
		}
		else
		{
%>
			Number Of Users:
			<%=(retconfig.getFieldValueString(0,BP_NUMBER_OF_USERS))%>
<%
		}
%>
	</Td>
	</Tr>
	<Tr>
	<Td colspan="2">
<%
		String busIntPartner = (String)(retconfig.getFieldValue(0,BP_INTRANET_USER));
		if (busIntPartner != null && "Y".equals(busIntPartner))
		{
%>
			<input type="checkbox" name="busIntUser" value="Unlimited" checked disabled>
			Intranet Business Partner
<%
		}
		else
		{
%>
			<input type="checkbox" name="busIntUser" value="Unlimited" unchecked disabled>
			Intranet Business Partner
<%
		}
%>
	</Td>
        </Tr>
        </Table>
</Td>
</Tr>
</Table>
<br><br>
<center>
	<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</center>
</form>
</body>
</html>
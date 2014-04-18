<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Rfq/iVendorContactDetails.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<html>
<head>
<Title>Vendor Contact Details</Title>
</head>
<body topmargin=0 rightmargin=0 leftmargin=0 scroll="No">
<Br><Br>	
<%
	if(listOfPayTosCnt>0)
	{
%>
<Table border=0 id="header" borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 width="90%" border="0" align="center">
	<Tr>
		<Th width="60%" valign="middle" align="center">
			<B>Vendor Contact Details</B>
		</Th>
	</Tr>
</Table>
	<table align=center width=90% border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
		<tr>
			<td class="blankcell">
				<table align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 width="100%">
					<tr>
						<th width="20%" align="left">Vendor</th>
						<td width="80%" colspan=3><%=soldTo%>&nbsp;</td>
					</tr>
					<tr>
						<th width="20%" align="left">Name</th>
						<td width="80%" colspan=3><%=companyName%>&nbsp;</td>
					</tr>
					<tr>
						<th width="20%" align="left">Address1 </th>
						<td width="30%"><%=address1%>&nbsp;</td>
						<th width="20%" align="left">Contact Person </th>
						<td width="30%"><%=contactPerson%>&nbsp;</td>
					</tr>
					<Tr>
						<th width="20%" align="left">Address2</th>
						<td width="30%"><%=address2%>&nbsp;</td>
						<th width="20%" align="left">Designation </th>
						<td width="30%"><%=designation%>&nbsp;</td>
					</Tr>
					<tr>
						<th width="20%" align="left">City </th>
						<td width="30%"><%=city%>&nbsp;</td>
						<th width="20%" align="left"> Phone1 </th>
						<td width="30%"><%=phone1%>&nbsp;</td>
					</Tr>
					<Tr>
						<th width="20%" align="left">State</th>
						<td width="30%"><%=state%>&nbsp;</td>
						<th width="20%" align="left"> Phone2 </th>
						<td width="30%"><%=phone2%>&nbsp;</td>
					</tr>
					<tr>
						<th width="20%" align="left">Country </th>
						<td width="30%"><%=CntryNames.getString(country.trim())%> &nbsp;</td>
						<th width="20%" align="left"> Fax </th>
						<td width="30%"><%=fax%>&nbsp;</td>
					</Tr>
					<Tr>
						<th width="20%" align="left">Zip </th>
						<td width="30%"><%=zipcode%>&nbsp;</td>
						<th width="20%" align="left">Email </th>
						<td width="30%"><%=email%>&nbsp;</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
<%
	}
	else
	{
%>	
		<div  style="position:absolute;top:35%;width:100%;visibility:visible" align="center">
			<Br><Br>	
			<Table border=0 width="60%" borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 width="90%" border="0" align="center">
				<Tr>
					<Th  valign="middle" align="center">
						<B>Vendor Details Are Not Available </B>
					</Th>
				</Tr>
			</Table>
		</div>	

<%
	}
%>	

	<div id="buttons" style="position:absolute;top:92%;width:100%;visibility:visible" align="center">
<%
	buttonName = new java.util.ArrayList();
        buttonMethod = new java.util.ArrayList();
	
	buttonName.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Close&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
	buttonMethod.add("window.close()");
	out.println(getButtonStr(buttonName,buttonMethod));
%>
	</div>

</form>
<Div id="MenuSol"></Div>
</body>
</html>
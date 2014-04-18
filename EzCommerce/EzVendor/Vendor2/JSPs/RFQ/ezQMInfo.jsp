<%@ include file="../../Library/Globals/errorPagePath.jsp" %>
<%@ include file="../../../Includes/JSPs/Misc/iblockcontrol.jsp" %>
<%@ include file="../../../Includes/JSPs/Rfq/iQMInfo.jsp" %>
<%@ page import="java.util.*,ezc.ezparam.*" %>

<html>
<head>
<%@include file="../../../Includes/Lib/AddButtonDir.jsp"%>

<style>
	legend
	{
		color:#0082A5;
		font-weight:bold;
	}
</style>
<title>Display Q-Info Record</title>
<script>
function closeWindow()
{
	close()
}
</script>
</head>
<body scroll=no>
<BR>
<%
	if(qmInfoAvailable)
	{
%>	
		<Table align=center border=1 cellPadding=0 cellSpacing=0  width=90%>
		<Tr>
		<Td class='blankcell' align>
		<fieldset>  
				<legend>Release Date</legend>
				<BR>
				<Table align=center width=95% border=1 cellpadding=10 cellspacing=0>
				<Tr>
					<Td width=20% align=left><B>Release Until</B></Td><Td align=left><%=globalRet.getFieldValueString(0,"RELEASE_UNTIL")%></Td>
				</Tr>
				</Table>
				<BR>
		</fieldset>		
		</Td>
		</Tr>
		<Tr><Td class='blankcell'>&nbsp;</Td></Tr>
		<Tr>
		<Td class='blankcell'>
		<fieldset>  
				<legend>Release Quantity</legend>
				<BR>
					<Table align=center width=95% border=1 cellpadding=10 cellspacing=0>
					<Tr>
						<Td align=left width=25%><B>Release Quantity</B></Td><Td width=25% align=left><%=qminfoRetObj.getFieldValueString(0,"RELEASE_QTY")%></Td>
						<Td align=left width=25%><B>Unit Of Measure</B></Td><Td width=25% align=left><%=qminfoRetObj.getFieldValueString(0,"UOM")%></Td>
					</Tr>
					<Tr>
						<Td align=left><B>Ordered Quantity</B></Td><Td><%=qminfoRetObj.getFieldValueString(0,"ORD_QTY")%></Td>
						<Td align=left><B>Reset On</B></Td><Td><%=globalRet.getFieldValueString(0,"RESET_ON")%></Td>
					</Tr>

					</Table>
				<BR>
		</fieldset>		
		</Td>
		</Tr>
		<Tr><Td class='blankcell'>&nbsp;</Td></Tr>
		<Tr>
		<Td class='blankcell'>
		<fieldset>  
				<legend>Certification</legend>
				<BR>
					<Table align=center width=95% border=1 cellpadding=10 cellspacing=0>
					<Tr>
						<Td width=20% align=left><B>Valid To</B></Td><Td align=left><%=globalRet.getFieldValueString(0,"VALID_TO")%></Td>
					</Tr>
					</Table>
				<BR>
		</fieldset>		
		</Td>
		</Tr>
		<Tr><Td class='blankcell'>&nbsp;</Td></Tr>
		<Tr>
		<Td class='blankcell'>
		<fieldset>  
				<legend>Block</legend>
				<BR>
					<Table align=center width=95% border=1 cellpadding=10 cellspacing=0>
					<Tr><Td width=20% align=left><B>Block Function</B></Td><Td align=left><%=qminfoRetObj.getFieldValueString(0,"BLOCK_FUNCTION")%></Td></Tr>
					<Tr><Td width=20% align=left><B>Block Reason</B></Td><Td align=left><%=qminfoRetObj.getFieldValueString(0,"BLOCK_REASON")%></Td></Tr>
					<Tr><Td width=20% align=left><B>Vendor Block</B></Td><Td align=left><%=qminfoRetObj.getFieldValueString(0,"VENDOR_BLOCK")%></Td></Tr>
					</Table>
				<BR>				
		</fieldset>		
		</Td>
		</Tr>
		</Table>
<%
	}
	else
	{
%>	
		<Table align=center border=1 cellPadding=10 cellSpacing=0  width=60%>
		<Tr>
		<Th align=center >
		<%=errorMessage%>
		</Th>
		</Tr>
		</Table>
<%
	}
%>
<BR>
<%
	buttonName = new java.util.ArrayList();
        buttonMethod = new java.util.ArrayList();
	
	buttonName.add("&nbsp;&nbsp;&nbsp;&nbsp; Close &nbsp;&nbsp;&nbsp;&nbsp;");
	buttonMethod.add("closeWindow()");
	out.println(getButtonStr(buttonName,buttonMethod));
%>
</body>
</html>
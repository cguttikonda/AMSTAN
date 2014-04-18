<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<META NAME="Generator" CONTENT="Microsoft Word 97">
<TITLE>TERMS AND CONDITIONS</TITLE>
</HEAD>
<BODY>

<B><U><H3><P ALIGN="CENTER">PO CONDITIONS</P></H3></U>
<%

	String headerText=request.getParameter("headerText");
	out.println(headerText);
	if(headerText==null || "".equals(headerText) || "null".equals(headerText))
	{
%>

		<br><br><br>
		<Table align=center>
		<Tr>
		<Td class=displayHeader>No PO Conditions Existed</Td>
		</Tr>
		</Table>
		<br><br>
<%	}
	else
	{	

		StringTokenizer tokens= new StringTokenizer(headerText,"|||");
		if(tokens!=null)
		{
			out.println("<Table aling=center>");
			while(tokens.hasMoreTokens())
			{
%>
			<Tr>
			<Td align=center><%=tokens.nextToken()%></Td>
			</Tr>
<%
			}

%>
			</Table>
<%
		}
	}
%>
	

<Table align=right">
<Tr><Td><a href="Javascript:history.go(-1)"> Back to Main Page</a>
</Td></Tr></Table>
<Div id="MenuSol"></Div>

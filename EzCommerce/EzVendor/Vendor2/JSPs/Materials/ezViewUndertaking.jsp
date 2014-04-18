<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@ page import="javax.xml.parsers.*,org.w3c.dom.*,javax.xml.transform.*,javax.xml.transform.dom.DOMSource,java.io.FileOutputStream,javax.xml.transform.stream.StreamResult" %>
<%@ include file="../../../Includes/JSPs/Materials/iListUndertaking.jsp" %>

<html>
<head>
<title>Letter Of Undertaking</title>
<style>
.newclass{}
td.newclass{
	font-size: 14pt;
	font-style: bold;
	color: #FFFFFF;
	background-color: #FFFFFF
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
</head>
<body>

<Div>
<table align="center" width="40%" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
  <tr>
    <td align="center" class="displayheader">LETTER OF UNDERTAKING</td>
  </tr>
</table>
<br>

<table align="center" width="96%" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
<tr>
<td>

<%=ret.getFieldValueString(0,"HEADER1")%><br><br>
<hr>
prior to the implementation;<br><br>
<pre>
<%=ret.getFieldValueString(0,"HEADER2")%>
</pre>
    </td>
</table>
<br><br>
<table align="center" width="96%" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
<tr>
<td>
<pre>Signed  :                                       Date:                   </pre>
<pre>Title  :                                        Telephone:              </pre>
<pre>Name and address of the company with seal                               </pre><br>
</td>
</tr>
</table>
<table  align="center" width="96%" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
<tr><td class="newclass">
<font color=black size=2><u>NOTE:THIS LETTER SHOULD BE GIVEN ON YOUR LETTER HEAD</u></font>
</td></tr></table>
<Div>
<br><br>

<Div style="page-break-before:always">
<table align="center" width="60%" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
  <tr>
    <td class="displayheader" align="center">TO WHOMESOEVER IT MAY CONCERN</td>
  </tr>
</table>
<br>
<table align="center" width="85%" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
  <tr>
    <th align="center">TRANSMITTING ANIMAL SPONGIFORM ENCEPHALOPATHY AGENTS(TSE)/BOVINE SPONGIFORM ENCEPHALOPATHY(BSE) DECLARATION</th>
  </tr>
</table>
<br>
<table align="center" width="96%" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
  <tr>
    <td>
<%=ret.getFieldValueString(0,"HEADER3")%>

  </tr>
</table>
<br><br><br>
<table align="center" width="96%" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
<tr>
    <td>For ___________________________________(Manufacturer)<br><br><br>
      (Signatory of the Authorized person with date)<br><br>
      (Authorized person name)<br><br>
      (Authorized designation and department)</td>
</tr>
</table>
</Div>

<center>
<br>
<img src="../../Images/Buttons/<%=ButtonDir%>/print.gif" style="cursor:hand" border=none onClick="window.print()">
<img src="../../Images/Buttons/<%=ButtonDir%>/cancel.gif" style="cursor:hand" border=none onClick="window.close()">
</center>
<Div id="MenuSol"></Div>
</body>
</html>

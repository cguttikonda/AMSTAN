<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

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
<script>
	function funEditSave()
	{
		document.myForm.action="ezEditSaveUndertaking.jsp";
		document.myForm.submit();
	}
</script>
</head>
<body>
<form name="myForm">
<table align="center" width="40%" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
  <tr>
    <td align="center" class="displayheader">LETTER OF UNDERTAKING</td>
  </tr>
</table>
<br>

<table align="center" width="96%" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
<tr>
<td align="center">
<textarea name="header1" rows=3 cols=90 style="overflow:auto"><%=ret.getFieldValueString(0,"HEADER1")%></textarea>
<hr>
prior to the implementation;<br><br>

<textarea name="header2" rows=3 cols=90 style="overflow:auto"><%=ret.getFieldValueString(0,"HEADER2")%></textarea>

</td>
</table>
<br><br>
<table align="center" width="96%" borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
<tr><td>Signed  :</Td><Td>Date:  </Td></Tr>
<tr><td>Title   :</Td><Td>Telephone:  </Td></Tr>
<tr><td>Name and address of the company with seal                               </Td><Td>&nbsp;</td>
</tr>
</table>
<table  align="center" width="96%">
<tr><td>
<font color=black size=2><u>NOTE:THIS LETTER SHOULD BE GIVEN ON YOUR LETTER HEAD</u></font>
</td></tr></table><br><br>

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
    <td align="center">
	    <textarea name="header3" rows="6" cols="90" style="overflow:auto" ><%=ret.getFieldValueString(0,"HEADER3")%></textarea>
    </td>
  </tr>
</table>
<table align="center" width="96%" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
<tr>
    <td>For ___________________________________(Manufacturer)<br><br><br>
      (Signatory of the Authorized person with date)<br><br>
      (Authorized person name)<br><br>
      (Authorized designation and department)</td>
</tr>
</table>

<center>
<br>
<img src="../../Images/Buttons/<%=ButtonDir%>/print.gif" style="cursor:hand" border=none onClick="window.print()">
<img src="../../Images/Buttons/<%=ButtonDir%>/save.gif"  style="cursor:hand" border=none onClick="funEditSave()" >
<img src="../../Images/Buttons/<%=ButtonDir%>/cancel.gif" style="cursor:hand" border=none onClick="window.close()">
</center>
</body>
</form>
<Div id="MenuSol"></Div>
</html>

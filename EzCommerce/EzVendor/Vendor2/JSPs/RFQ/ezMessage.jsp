<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<html>
<head>
<title></title>

<script>
function funOK()
{

	window.close();
}

</script>

		<link rel="stylesheet" href="../../Library/Styles/ezThemeGreen.css">

</head>
<body>
<form>
<br>
<br>
<br>
<br>

<TABLE id="tabHead" width="50%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
  <tr align="center" valign="middle">
    <th width=60%>Quotation Posted Successfully</th>
  </tr>
</tr>
</Table>
<div style="position:absolute;top:45%;left:48%;visibility:visible">
<%
      butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ok &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
      butActions.add("funOK()");
      out.println(getButtons(butNames,butActions));
%>
</div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>

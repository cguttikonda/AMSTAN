
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<html>
<head>

<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>

<link href="../../Library/Styles/ezCalenderGreen.css" rel="stylesheet">

<body>
<form name="myForm" method="post" action="ezSyncProducts.jsp">
<br><br><br><br>
<table id="header" width="60%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<tr align="center">
	<td class="displayheader">Products Synchronized Successfully</td>
</tr>
</table>

<Div id="checkDiv" align="center"   style="width:100%;position:absolute;top:75%">
<a href="javascript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border=none style="cursor:hand" onClick="funCheck()"></a>
</Div>
</form>
</body>
</html>

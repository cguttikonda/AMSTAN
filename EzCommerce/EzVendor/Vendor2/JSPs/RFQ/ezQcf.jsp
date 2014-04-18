<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<html>
<head>
<script>
var newWindow

function showWin()
{
    var n = document.myForm.qcfNumber.value
    if(n!="")
    {

	var url="ezQcfComments.jsp?qcfNumber="+n;
	newWindow=window.open(url,"myWin","width=750,height=550,left=20,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
    }	
    else
    {
        alert("Please Enter Collective Number")	
        document.myForm.qcfNumber.focus()
        return false;
    }
}


	function funUnload()
	{
		if(newWindow!=null && newWindow.open)
		{
		  newWindow.close();
		}
	}
</script>
</head>
<body onLoad="document.myForm.qcfNumber.focus()" onUnload="funUnload()">
<form name="myForm">
<%
	String display_header = "";
%>	

	<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<br><br><br>
<table width="40%" border="1" align="center" borderColorDark=#ffffff borderColorLight=#006666 cellpadding="0" cellspacing="0">
<tr>
<th width="40%" align="left">&nbsp;&nbsp;Collective RFQ No </th>
<td width="45%"><input type="text" name="qcfNumber" size="16" maxlength="16"></td>
<td width="15%" class="blankcell" align="right"><img src="../../Images/Buttons/<%=ButtonDir%>/Go.gif" border="none" style="cursor:hand" onClick="showWin()"></td>
</tr>
</table>

<input type="hidden" name="QcfNumber">
<input type="hidden" name="comments">
<input type="hidden" name="actionNum">

</form>
<Div id="MenuSol"></Div>
</body>
</html>
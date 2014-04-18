<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<html>
<head>
<title>Enter Material Number -- Powered By EzCommerce India</title>
<head>
<%@include file="../../../Includes/Lib/AddButtonDir.jsp"%>

<script>

var parentObj="";
var docObj="";
if(!document.all)
{
  parentObj = opener.document.myForm	
  docObj = opener.document
}
else
{
  parentObj = parent.opener.myForm	
  docObj = parent.opener.document
}

function closeWin()
{
	if(document.myForm.matNum.value=="")
	{
		alert("Please Enter Material Number")
		document.myForm.matNum.focus()
		return false;
	}
	else if(document.myForm.plant.value=="")
	{
		alert("Please Enter Plant")
		document.myForm.plant.focus()
		return false;
	}
	else if(document.myForm.purGrp.value=="")
	{
		alert("Please Enter Purchase Group")
		document.myForm.purGrp.focus()
		return false;
	}	
	else
	{
		 parentObj.matNum.value = document.myForm.matNum.value;
		 parentObj.plant.value = document.myForm.plant.value;
		 parentObj.purGrp.value = document.myForm.purGrp.value;
		 parentObj.submit();
		 window.close()
	}

}
</script>
</head>
<body>
<form name="myForm">
 <br><br>
    <table width="90%" align="center" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >

    <tr>
    <th width="40%" align="left">Enter SAP Material No :</th>
    <td width="60%"><input type="text" name="matNum" class="InputBox" size=12 maxlength=18></td>
    </tr>


    <tr>
    <th width="40%" align="left">Enter Plant :</th>
    <td width="60%"><input type="text" name="plant" class="InputBox" size=12 maxlength=4> </td>
    </tr>
	
    <tr>
    <th width="40%" align="left">Enter Purchase Group :</th>
    <td width="60%"><input type="text" name="purGrp" class="InputBox" size=12 maxlength=3></td>
    </tr>

	
    </table>
	
	
<br>    
 <center>
 <img style="cursor:hand" border=none src="../../Images/Buttons/<%=ButtonDir%>/ok.gif" onClick="closeWin()">
 <img style="cursor:hand" border=none src="../../Images/Buttons/<%=ButtonDir%>/cancel.gif" onClick="window.close()">
 </center>
    
</form>
<Div id="MenuSol"></Div>
</body>
</html>

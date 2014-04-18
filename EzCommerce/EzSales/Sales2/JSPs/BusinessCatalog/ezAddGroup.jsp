<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iAddGroup_Lables.jsp"%>
<html>
<head>
<title>ezAdd Group</title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<script LANGUAGE="JavaScript">

<%
	String fd = request.getParameter("fd");
	String fwd = request.getParameter("fwd");
	if ( fd != null )
	{
%>
	alert("<%=group_L%>  <%= fd %> <%=alExist_A%>");
	document.forms[0].FavGroupDesc.value='<%=fd%>';
	document.forms[0].FavWebDesc.value='<%=fwd%>';
	document.forms[0].FavGroupDesc.focus();
<%
	} //end if fd !=null
%>

function setFocus()
{
	document.forms[0].FavGroupDesc.focus();
}
function trim( inputStringTrim) {
fixedTrim = "";
lastCh = " ";
for( x=0;x < inputStringTrim.length; x++)
{
   ch = inputStringTrim.charAt(x);
 if ((ch != " ") || (lastCh != " ")) { fixedTrim += ch; }
lastCh = ch;
}
if (fixedTrim.charAt(fixedTrim.length - 1) == " ") {
fixedTrim = fixedTrim.substring(0, fixedTrim.length - 1); }
return fixedTrim
}
function isValidChar (c)
{   return ( ((c >= "A") && (c <= "Z")) || ((c >= "a") && (c <= "z")) || ((c >= "0") && (c <= "9")) ||(c==" ")||(c=="_")||(c=="-"))
}
function checkFolder(s)
{
    var i;
    // Search through string's characters one by one
    // until we find a non-numeric character.
    // When we do, return false; if we don't, return true.

    for (i = 0; i < s.length; i++)
    {   
        // Check that current character is number.
        var c = s.charAt(i);
        if (!isValidChar(c)) return false;
    }

    	// All characters are numbers or alphabets.
    	return true;

}
function VerifyEmptyFields() {

	if (trim(document.forms[0].FavGroupDesc.value) == ""){
		alert("Please Enter Group Name");
		document.forms[0].FavGroupDesc.focus()
		document.returnValue = false;
	}else
	if(trim(document.forms[0].FavWebDesc.value )== "" ){
		alert("Please Enter Description");
		document.forms[0].FavWebDesc.focus()
		document.returnValue = false;
	}else{
		/*var group=document.forms[0].FavGroupDesc.value
		document.forms[0].FavGroupDesc.value=group.replace('\'','`')
		var groupDesc=document.forms[0].FavWebDesc.value
		document.forms[0].FavWebDesc.value=groupDesc.replace('\'','`')
		*/
		document.returnValue = true;
		if ( document.returnValue )
		{
			if ( !checkFolder(document.forms[0].FavGroupDesc.value) )
			{
				alert('Group  can be alphabets , numbers ,"_","-" and sapace');
				document.returnValue = false;
				document.forms[0].FavGroupDesc.focus();
			}else	
				if ( !checkFolder(document.forms[0].FavWebDesc.value) )
				{
					alert('Group Description  can be alphabets , numbers ,"_","-" and sapace');
					document.returnValue = false;
					document.forms[0].FavWebDesc.focus();
				}else{
					document.returnValue = true;
				}
		}
		if(document.returnValue)
		{
			document.body.style.cursor="wait"
			document.forms[0].submit();
		}
	}
}
</script>
</head>
<body onload="setFocus()" scroll=no>
<%
	String display_header = "Create catalog"; 	
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>

<br>
<form method="post" action="ezAddFavGroup.jsp" name="favgroup">
  <table width="60%"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
    <tr>
      <th width="30%" height="27">Catalog</td>
      <td width="70%" height="27"><input type="text" class=InputBox name="FavGroupDesc" size="60" maxlength="30"></td>
    </tr>
    <tr>
      <th width="30%" height="27"><%=desc_L%></td>
      <td width="70%" height="27"><input type="text" class=InputBox name="FavWebDesc" size="60" maxlength="30"></td>
    </tr>
  </table>
  <div align="center"><br>
<%
  		buttonName = new java.util.ArrayList();
  		buttonMethod = new java.util.ArrayList();
  		buttonName.add("Create Catalog");
  		buttonMethod.add("VerifyEmptyFields()");
  		buttonName.add("Back");
  		buttonMethod.add("history.go(-1)");
  		out.println(getButtonStr(buttonName,buttonMethod));
%>
  </div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>

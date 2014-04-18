<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iAddGroup_Lables.jsp"%>
<html>
<head>
<title>ezAdd Group</title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<script LANGUAGE="JavaScript">

<%
	String fd	= request.getParameter("fd");
	String fwd 	= request.getParameter("fwd");
	if ( fd != null )
	{
%>
		alert("<%=group_L%>  <%= fd %> <%=alExist_A%>");
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
				alert('Group  can be alphabets , numbers ,"_","-" and spaace');
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
			
			
<%
			// actual parameters
			String pProductNumber = null;
	
			// for looping
			
			String product = null;
			String [] products = null;
		
			String strTcount =  request.getParameter("TotalCount");
			
			if ( strTcount != null )
			{
				int totCount = (new Integer(strTcount)).intValue();
				
				if ( totCount > 0 )
				{
					// Loop thru the last selection
					products = new String[totCount];
					for ( int i = 0 ; i < totCount; i++ )
					{
						product = "Product_"+i;
						pProductNumber = request.getParameter(product);
						products[i] = new String(pProductNumber);
						
					
					}// End For
					session.setAttribute("productscg",products);
				}
			}
%>
			document.body.style.cursor="wait"
			document.catgroup.target="display";
			document.forms[0].submit();
			
		}
	}
}
</script>
</head>
<body onLoad="setFocus()" scroll=no>
<form method="post" action="ezCatGroup.jsp" name="catgroup">
<table align=center border="0" cellpadding="0" class="blankcell" cellspacing="0" width="100%">
	<tr>
	    <td  class="blankcell"  align=center><font color='red'>* Create "ACTIVE" for your own Sales Order Catalog Default</font></td>
	    
	</tr>
	</table>
	<br>
  <table width="50%"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
    <tr>
      <th width="30%" height="27">Catalog</td>
      <td width="70%" height="27"><input type="text" class=InputBox name="FavGroupDesc" size="50" maxlength="50"></td>
    </tr>
    <tr>
      <th width="30%" height="27"><%=desc_L%></td>
      <td width="70%" height="27"><input type="text" class=InputBox name="FavWebDesc" size="50" maxlength="50"></td>
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

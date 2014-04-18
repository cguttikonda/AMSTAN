<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/User/iUserOnlyDefaultsList.jsp"%>

<html>
<head>
<Script src="../../Library/JavaScript/User/ezUserRoles.js"></script>
<script language = "javascript">
function myalert(){
	myurl = document.URL;
	index = myurl.indexOf(".jsp");
 	newurl = myurl.substring(0, index);
	mUrl1 =  newurl + ".jsp?";
	mUrl2 = "BusinessUser=" + document.myForm.BusUser.value;
		mUrl =  mUrl1 + mUrl2;
	location.href= mUrl;
}

</script>

<Title>Business User Defaults</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
</head>
<body>
<Table  width="35%" border="0" align="center">
  <Tr align="center">
    <Td height="2" class="displayheader">User Specific Defaults</Td>
  </Tr>
</Table>
<br>

<form name=myForm method=post action="ezSaveUserOnlyDefaultsList.jsp">

  <Table  width="50%" border="1" align="center">
    <Tr>
      <Td width="43%" class="labelcell"> User:</Td>
      <Td width="57%">
      	<input type=text class = "InputBox" readonly name="Bus_Partner" size="15" value="<%=bus_user%>">
	</Td>
    </Tr>
  </Table>

  <br>

  <Table  width="60%" align="center">
    <Tr>
      <Th colspan="3" >The following defaults are specific to the user.<font color="#0066CC"><font color="#FFFFFF">
        </font></font>For a list of user defaults for a business area
		<a class ="subclass" href="ezUserDefaultsList.jsp?BusUser=<%=bus_user%>" >

        <b>Click Here</b>
        <%
out.println("</a>");
%>
      </Th>
    </Tr>
    <Tr>
      <Th width="37%" align="left" >Default</Th>
      <Th width="36%" align="left" > Value </Th>
      <Th width="27%" >Show To User</Th>
    </Tr>
    <%
int defRows = reterpdef.getRowCount();
String defDescription = null;
if ( defRows > 0 ) {
	for ( int i = 0 ; i < defRows; i++ ){
%>

    <Tr align="center">
      <Td align="left" width="37%">
        <%
	defDescription = reterpdef.getFieldValueString(i,"EUDD_DEFAULTS_DESC");
	if (defDescription != null)
		out.println(defDescription);
	out.println("<input type=\"hidden\" name=\"DefaultsKey_"+i+"\" value=\""+(reterpdef.getFieldValue(i,USER_DEFAULT_KEY)).toString()+"\" >");
%>
      </Td>

      <Td align="left" width="36%">
        <%
		String defValue = (String)reterpdef.getFieldValue(i,USER_DEFAULT_VALUE);
String defKey = (String)(reterpdef.getFieldValue(i,USER_DEFAULT_KEY));
defKey = defKey.trim();

if (defKey.equals("USERROLE"))
{
	out.println("<select name=DefaultsValue_"+i+">");
%>
	<option value=''>--Select Role--</option>
	<script>
		for(var i=0;i<userroles.length;i++)
		{
			var userrole='<%=defValue%>';

			if(userroles[i].RoleCode==userrole)
			{
				document.write("<option value="+userroles[i].RoleCode+" selected>"+userroles[i].RoleDesc+"</option>");
			}
			else
			{
				document.write("<option value="+userroles[i].RoleCode+">"+userroles[i].RoleDesc+"</option>");
			}
		}
	</script>
	</select>
	<script>
	for(slen=0;slen<document.myForm.DefaultsValue_<%=i%>.options.length;slen++)
	{
		if(document.myForm.DefaultsValue_<%=i%>.options[slen].value=="<%=reterpdef.getFieldValue(i,USER_DEFAULT_VALUE)%>")
		{
			document.myForm.DefaultsValue_<%=i%>.selectedIndex=slen
			break;
		}
	}
	</script>
<%
} //ADD ends here
else if (defKey.equals("LANGUAGE")){
int langRows = ret.getRowCount();
	if ( langRows > 0 ) {
        out.println("<select name=DefaultsValue_"+i+">");
		for ( int j = 0 ; j < langRows ; j++ ){
		  String langKey = ((String)ret.getFieldValue(j,LANG_ISO)).toUpperCase();
		if(langKey.equals(defValue.trim())){
		      out.println("<option selected value="+((String)ret.getFieldValue(j,LANG_ISO)).toUpperCase()+">");
		      out.println((ret.getFieldValue(j,LANG_DESC)).toString());
	      	out.println("</option>");
		}else{
		      out.println("<option value="+((String)ret.getFieldValue(j,LANG_ISO)).toUpperCase()+">");
		      out.println((ret.getFieldValue(j,LANG_DESC)).toString());
	      	out.println("</option>");
		}//End if
		}//End for
        out.println("</select>");
	}//End if
}else{
	if (defKey.equals("CURRENCY"))
	{
		int curRows = retcur.getRowCount();
		if ( curRows > 0 )
		{

	        		out.println("<select name=DefaultsValue_"+i+">");
			for ( int k = 0 ; k < curRows ; k++ )
			{
				  String curKey = ((String)retcur.getFieldValue(k,CURRENCY_KEY )).toUpperCase();
				if((curKey.trim()).equals(reterpdef.getFieldValue(i,USER_DEFAULT_VALUE)))
				{
					      out.println("<option selected value="+((String)retcur.getFieldValue(k,CURRENCY_KEY)).toUpperCase()+">");
			     		      out.println((retcur.getFieldValue(k,CURRENCY_LONG_DESC)).toString());
			        		      out.println("</option>");
				}
				else{
			     	out.println("<option value="+((String)retcur.getFieldValue(k, CURRENCY_KEY)).toUpperCase()+">");
			     	out.println((retcur.getFieldValue(k, CURRENCY_LONG_DESC)).toString());
	      		out.println("</option>");
			}//End if
			}//End for
		        out.println("</select>");
		}//End if
	}else{
		if (defValue != null){
		defValue=defValue.trim();
		      out.println("<input type=\"text\" name=DefaultsValue_"+i+" size=\"20\" value=\""+defValue+"\">");
		}else{
		defValue="";
		      out.println("<input type=\"text\" name=DefaultsValue_"+i+" size=\"20\" value=\""+defValue+"\">");
		}
	}//Endif currency
}//Endif Language
%>
      </Td>

      <Td width="27%">
        <%
		//CheckBox for Show it to user flag
		String UserFlag = (String)(reterpdef.getFieldValue(i, "EUD_IS_USERA_KEY"));
		if(UserFlag.equals("Y")){
	%>
	        	<input type="checkbox" name="ChkUser_<%=i%>" value="Selected" checked >
	<%
		}else{
	%>
	        	<input type="checkbox" name="ChkUser_<%=i%>" value="Selected"  >
	<%
		}
	%>
		<input type="hidden" name="TotalCount" value="<%=defRows%>" >
		<input type="hidden" name="BusUser" value="<%=bus_user%>" >

      </Td>
    </Tr>

<%
	}//End for
}//End If
%>
  </Table>
  <p align="center">
    <input type="submit" name="Submit" value="Save">
  </p>
</form>

<%
	String saved = request.getParameter("saved");
	if ( saved != null && saved.equals("Y") )
	{
%>
		<script language="JavaScript">
			alert('User Default(s) updated successfully');
		</script>
<%
	} //end if
%>

</body>
</html>
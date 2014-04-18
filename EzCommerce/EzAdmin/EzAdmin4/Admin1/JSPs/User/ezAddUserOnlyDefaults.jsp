<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/User/iAddUserOnlyDefaults.jsp"%>
<%
	String myUser = "Business User";
	if("2".equals((String)session.getValue("myUserType")))
		myUser = "Intranet User";
%>
<html>
<head>
<Script src="../../Library/JavaScript/User/ezUserRoles.js"></script>
<Title>Business User Defaults</Title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<body>
<form name=myForm method=post action="ezSaveAddUserOnlyDefaults.jsp">
<br>
<Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<Tr align="center">
    	<Td class="displayheader">User Only Defaults</Td>
</Tr>
</Table>
<Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<Tr>
      	<Td width="30%" class="labelcell" align = "right"><%=myUser%>:</Td>
      	<Td width="70%">
	      <input type="hidden" name="BusUser" value="<%=bus_user.trim()%>" >
<%
	      	if("2".equals((String)session.getValue("myUserType")))
	      	{
%>
	      		<a href="../User/ezViewIntranetUserData.jsp?UserID=<%=bus_user%>"><%=bus_user%></a>
<%
	      	}
	      	else
	      	{
%>
	      		<a href="../User/ezUserDetails.jsp?UserID=<%=bus_user%>"><%=bus_user%></a>
<%
	      	}
%>	

 	</Td>
</Tr>
</Table>
<Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<Tr>
	<Th width="100%" colspan="3" height="2" >The following defaults are specific to the user</Th>
</Tr>
<Tr>
      	<Th width="40%" >Default</Th>
	<Th width="45%" >Value</Th>
</Tr>
<%
	int defRows = reterpdef.getRowCount();
	String defDescription = null;
	if ( defRows > 0 )
	{
	    	for ( int i = 0 ; i < defRows; i++ )
		{
			if("STYLE".equals(reterpdef.getFieldValueString(i,"EUD_KEY")))
				continue;		
%>

    			<Tr >
    			<Td align="left">
<%
			defDescription = (String)(reterpdef.getFieldValue(i,USER_DEFAULT_KEY));
			if (defDescription != null)
			{
%>
				<%=defDescription%>
<%
			}
%>
			<input type=hidden name="DefaultsKey" value="<%=reterpdef.getFieldValue(i,USER_DEFAULT_KEY)%>">
			</Td>
		        <Td align="left">
<%
			String defValue = (String)reterpdef.getFieldValue(i,USER_DEFAULT_VALUE);
			String defKey = (String)(reterpdef.getFieldValue(i,USER_DEFAULT_KEY));
defKey = defKey.trim();
if (defKey.equals("USERROLE"))
{
%>
	<select name=DefaultsValue>
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
<%
}
else
{
			if (defDescription.equals("LANGUAGE"))
			{
				int langRows = ret.getRowCount();
				if ( langRows > 0 )
				{
%>
			<select name="DefaultsLanguage" id=ListBoxDiv>
<%
				for ( int j = 0 ; j < langRows ; j++ )
				{
		  			String langKey = (String)ret.getFieldValue(j,LANG_ISO);
					if(langKey.equals(defValue.trim()))
					{
%>
						<option selected value="<%=ret.getFieldValue(j,LANG_DESC)%>" >
		      				<%=ret.getFieldValue(j,LANG_DESC)%>
	      					</option>
<%
					}else{
%>
		    				<option value="<%=ret.getFieldValue(j,LANG_DESC)%>" >
		      				<%=ret.getFieldValue(j,LANG_DESC)%>
	      					</option>
<%
					}
				}
%>
        				</select>
 <%
			}
			}else{
				if (defDescription.equals("CURRENCY"))
				{
				int curRows = retcur.getRowCount();
				if ( curRows > 0 )
				{
%>
	       <select name="DefaultsCurrency" id=ListBoxDiv> 
<%
			for ( int k = 0 ; k < curRows ; k++ ){
			  String curKey = (String)retcur.getFieldValue(k,CURRENCY_KEY );
			if((curKey.trim()).equals("USD")){
%>
				<option selected value="<%=curKey%>" >
				<%=retcur.getFieldValue(k,CURRENCY_LONG_DESC)%>
	      		</option>
<%
			}else{
%>
				<option value="<%=curKey%>" >
			     	<%=(retcur.getFieldValue(k, CURRENCY_LONG_DESC))%>
	      		</option>
<%
			}
			}
%>
		        </select>
<%
		}
	}else{
		if (defValue != null)
			defValue=defValue.trim();
		else
			defValue="";
%>
		      <input type=text class = "InputBox" name="DefaultsValue" size="15" value="<%=defValue%>" >

<%
	}
}
}
%>
	</Td>

    </Tr>

<%
	}
}
%>
  </Table>
  <p align="center">

    <input type="image" src="../../Images/Buttons/<%=ButtonDir%>/finish.gif">
    <a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
    <a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

  </p>
</form>
</body>
</html>
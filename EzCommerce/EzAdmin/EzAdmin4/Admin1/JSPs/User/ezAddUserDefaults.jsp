<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/User/iAddUserDefaults.jsp"%>
<%@ include file="../../../Includes/Lib/AdminUser.jsp"%>
<%
	String myUser = "Business User";
	String myAreaLabel = "Purchase Area";
	if("2".equals((String)session.getValue("myUserType")))
		myUser = "Intranet User";
	if("C".equals((String)session.getValue("myAreaFlag")))
		myAreaLabel = "Sales Area";
%>
<html>
<head>
<script src="../../Library/JavaScript/User/ezAddUserDefaults.js"></script>
<Title>Business User Defaults</Title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<body>
<form name=myForm method=post action="ezSaveAddUserDefaults.jsp">
<br>
<Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<Tr align="center">
    	<Td class="displayheader">User Defaults</Td>
</Tr>
</Table>
<Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<Tr>
      	<Td width="30%" class="labelcell" align = "right"><%=myUser%>:</Td>
      	<Td width="70%">
	     	<input type="hidden" readonly name="BusUser" size="15" value=<%=bus_user.trim()%> >
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
<Tr>
	<Td width="30%" class="labelcell" align = "right"><%=myAreaLabel%>:</Td>
      	<Td width="70%">
<%
	int syskeyRows = retbpsyskey.getRowCount();
	String keyDesc = null;
	if ( syskeyRows > 0 )
	{
%>
        	<select name="SysKey" id=ListBoxDiv onChange="syskeychange()">
<%
		for ( int i = 0 ; i < syskeyRows ; i++ )
		{
			String val = ((String)retbpsyskey.getFieldValue(i,SYSTEM_KEY)).toUpperCase();
			keyDesc = (String)retbpsyskey.getFieldValue(i,SYSTEM_KEY_DESCRIPTION);
			if((sys_key.trim()).equals(val.trim()))
			{
%>
		        	<option selected value=<%=((String)retbpsyskey.getFieldValue(i,SYSTEM_KEY))%> >
<%
				if (keyDesc != null)
				{
%>				
					<%=keyDesc.trim()%> (<%=val%>)
<%
				}
%>
		        	</option>
<%
			}
			else
			{
%>
		        	<option value=<%=((String)retbpsyskey.getFieldValue(i,SYSTEM_KEY))%> >
<%
				if (keyDesc != null)
				{
%>
					<%=keyDesc.trim()%> (<%=val%>)
<%
				}
%>
		        	</option>
<%
			}
		}
%>
	        </select>
<%
	}
%> 
	</Td>
</Tr>
</Table>
<%
  	int defRows = reterpdef.getRowCount();
	String defDescription = null;
  	if ( defRows > 0 ) 
  	{
%>
  		<Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
    		<Tr>
      			<Th width="100%" colspan="3" height="17" >The following User Defaults are
        		dependent on the <%=myAreaLabel%></Th>
    		</Tr>
		<Tr>
      		<Th width="40%" >Default</Th>
      		<Th width="45%" >Value </Th>
	    	</Tr>
<%
		for ( int i = 0 ; i < defRows; i++ )
		{
%>
		    	<Tr align="center">
      		    	<Td>
<%
			defDescription = (String)(reterpdef.getFieldValue(i,"EUDD_DEFAULTS_DESC"));
			if (defDescription != null)
			{
%>
				<%=defDescription%>
<%
			}
%>
			</Td>
			<Td>
<%
			String defValue = (String)reterpdef.getFieldValue(i,USER_DEFAULT_VALUE);
			if (defValue != null)
				defValue=defValue.trim();
			else
				defValue="";
%>
    			<input type=text class = "InputBox" name="DefaultsValue" size="15" value="<%=defValue%>" >
    			<input type=hidden name="DefaultKey" value="<%=reterpdef.getFieldValue(i,USER_DEFAULT_KEY)%>">
			</Td>
    			</Tr>
<%
		}//End for
%>
	 	</Table>
		<br>
		<Center>
	    		<input type="image" src="../../Images/Buttons/<%= ButtonDir%>/continue.gif">
	    		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
			<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
		</Center>
<%
	}//End If
	else
	{
%>
		<br><br><br><br>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
		<Tr>
			<Td class = "labelcell" align="center">No Defaults Present for this <%=myAreaLabel%>.</Td>
		</Tr>
		</Table>
 		<br>
  		<center>
    			<input type="image" src="../../Images/Buttons/<%= ButtonDir%>/continue.gif">
    			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border=none></a>
		</center>
<%
	}
%>
</form>
</body>
</html>
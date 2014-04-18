<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Arms/iListRoleAuth.jsp"%>
<html>
<head>
<meta name="Author" content="Suresh Parimi">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script src="../../Library/JavaScript/Arms/ezListRoleAuth.js" ></script>
<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<Script src="../../Library/JavaScript/ezTrim.js"></Script>

</head>
<body  onLoad='scrollInit();document.myForm.param.focus()' onResize='scrollInit()' scroll=no>
<form name="myForm" method="post" action="ezUpdateRoleAuth.jsp" onSubmit='return check()'>
<br>
	<Table  width="60%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr>
      	<Th width="20%" class="labelcell">Role:</Th>
      	<Td width="80%" >
      	<select name="param" style="width:100%" id=FullListBox onChange="myalert()">
      	<option value="sel" >---Select Role---</option>
<%
	retRoles.sort(new String[]{"ROLE_NR"},true);
	for ( int i = 0 ; i < retRoles.getRowCount() ; i++ )
	{
		if("N".equals(retRoles.getFieldValueString(i,"DELETE_FLAG")))
		{	
			String rDesc = retRoles.getFieldValueString(i,"DESCRIPTION");
			String rRole = retRoles.getFieldValueString(i,"ROLE_NR").trim();
			if(roles!=null && !roles.equals("sel"))
			{
				if(roles.trim().equals(rRole))
				{
%>	
			    	    	<option selected value="<%=rRole%>"><%=rRole%> (<%=rDesc%>)</option>
<%
				}
				else
				{
%>	
		    	    		<option value="<%=rRole%>"><%=rRole%> (<%=rDesc%>)</option>
<%
				}
			}
			else
			{
%>
		    	    	<option value="<%=rRole%>"><%=rRole%> (<%=rDesc%>)</option>
<%
			}
		}
	}
%>
	</select>
	</Td>
    	</Tr>
  	</Table>
<%
	
     	if(roles!=null && !roles.equals("sel"))
     	{
	   	retTopLevelAuth.sort(new String[]{"EUAD_AUTH_DESC"},true);     
	   	int authRows = retTopLevelAuth.getRowCount();
	   	if ( authRows > 0 )
	   	{
%>
			<Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
			<Tr align="center">
				<Td class="displayheader">List of Role Authorizations</Td>
			</Tr>
			</Table>
			<div id="theads">
			<Table id="tabHead" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
			<Tr>
				<Th width="12%" title="Select/Deselect All"><input type='checkbox' name='chk1Main' onClick="selectAll()"></Th>
				<Th width="25%" align="center"> Authorization Key </Th>
				<Th width="53%" align="center"> Authorization Description </Th>
				<Th width="10%" align="center"> Actions </Th>
			</Tr>
			</Table>
			</div>
			<DIV id="InnerBox1Div">
			<Table id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<%
			for ( int i = 0 ; i < authRows ; i++ )
			{
				String checFlag = "";
				String busComponent = retTopLevelAuth.getFieldValueString(i,"EUAD_COMPONENT").trim();
				if ( busComponent.equals("ROLE") )continue;
				String retTopAuthKey = retTopLevelAuth.getFieldValueString(i,"EUAD_AUTH_KEY");
				if(ret.getRowCount()>0)
				{
					if ( ret.find("AUTH_KEY",retTopAuthKey) )
					{
						checFlag = "checked";
					}
						else
					{
						checFlag = "unchecked";
					}
				}
%>
				<Tr align="center" width=12%>
				<label for="cb_<%=i%>">
					<Td><input type="checkbox" name="CheckBox" align="center" id = "cb_<%=i%>" value="<%=retTopLevelAuth.getFieldValueString(i,"EUAD_AUTH_KEY")%>#<%=retTopLevelAuth.getFieldValueString(i,"EUAD_AUTH_DESC")%>" <%=checFlag%>></Td>
					<Td align="left" width=25%><%=retTopLevelAuth.getFieldValueString(i,"EUAD_AUTH_KEY")%></Td>
					<Td align="left" width=53%><%=retTopLevelAuth.getFieldValueString(i,"EUAD_AUTH_DESC")%></Td>
					<Td align="center" width=10% ><a href="javascript:funOpen('<%=i%>')">Click</a href></Td>
				</label>
				</Tr>
<%
			}
%>
			</Table>
			</div>
			<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
				<input type=image src="../../Images/Buttons/<%= ButtonDir%>/update.gif" >       	
				<img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" Style = "cursor:hand"  onClick = "document.myForm.reset()">
       				<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
			</div>
<%
		}
		else
		{
%>
			<br><br><br><br>
			<Tablealign=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
			<Tr>
					<Th>Authorizations are not assigned To the Role(s) which are assigned to this User</Th>
			</Tr>
			</Table>
<%
		}
	}
	else
	{
%>
		<br><br><br><br>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0  width = "80%">
		<Tr>
			<Th align=center >Please select Role  to continue.</Th>
		</Tr>
		</Table>
		<br>
		<center>
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
		</center>			
<%
	}
%>
<input type=hidden name=userid  value=<%=roles%>>
<input type=hidden name=syskey  value=<%=syskey%>>
</form>
</body>
</html>
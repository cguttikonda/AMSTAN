<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp" %>
<%@ include file="../../../Includes/JSPs/WorkFlow/iWorkGroupsList.jsp"%>
<%
	session.putValue("mySearchCriteria",searchPartner);
	session.putValue("myAreaFlag",myAreaFlag);
%>
<Html>
<Head>
<meta name="author"  content="EzWorkbench">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<Script src="../../Library/JavaScript/WorkFlow/ezWorkGroupsList.js"></script>
	<Script src="../../Library/JavaScript/ezTabScroll.js"></script>
	<Script src="../../Library/JavaScript/chkEditAndDelete.js"></Script>
	<Script src="../../Library/JavaScript/ezSubmitForm.js"></Script>
</Head>
<Body onLoad="scrollInit()" onresize="scrollInit()" scroll=no >
<br>
<Form name=myForm method="post" onSubmit="return goForSubmit(document.myForm)">
	<Table  width="60%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr>
      	<Th width="20%" class="labelcell">Role:</Th>
      	<Td width="80%" >
      	<select name="role" style="width:100%" id=FullListBox onChange="funSubmit()">
      	<option value="sel" >---Select Role---</option>
<%
	retRoles.sort(new String[]{"DESCRIPTION"},true);
	for ( int i = 0 ; i < retRoles.getRowCount() ; i++ )
	{
		if("N".equals(retRoles.getFieldValueString(i,"DELETE_FLAG")))
		{
			String rDesc = retRoles.getFieldValueString(i,"DESCRIPTION");
			String rRole = retRoles.getFieldValueString(i,"ROLE_NR").trim();
			if(role!=null && !role.equals("sel"))
			{
				if(role.trim().equals(rRole))
				{
%>	
				    <option selected value="<%=rRole%>"><%=rDesc%></option>
<%
				}
				else
				{
%>	
				    <option value="<%=rRole%>"><%=rDesc%></option>
<%
				}
			}
			else
			{
%>
				    <option value="<%=rRole%>"><%=rDesc%></option>
<%
			}
		}
	}
%>
	</select>
	</Td>
    	</Tr>
  	</Table>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
<Tr>
<td align = "center">
	<%@ include file="../../../Includes/Lib/WFAlphabetBean.jsp" %>
</Td>
</Tr>
</Table>
<input type="hidden" name="searchcriteria" value="$">
<%
	if(role == null || "null".equals(role))
	{
%>
		<br><br><br><br>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
		<Tr>
			<Td class = "labelcell">
				<div align="center"><b>Please Select Role to continue.</b></div>
			</Td>
		</Tr>
		</Table>
		<br>
		<center>
			<input type=image  src=../../Images/Buttons/<%= ButtonDir%>/add.gif  alt="Click Here To Add" border=no onClick="funOpt(1,'ezAddWorkGroups.jsp')">
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
		</center>
<%
		return;
	}
%>
<%
	if(listRet.getRowCount()==0)
	{
%>
		<br><br><br><br>
		<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
		<Tr>
			<Th width="100%" align=center>
			No WorkGroups To List
			</Th>
		</Tr>
		</Table><br><center>
		<input type=image  src="../../Images/Buttons/<%= ButtonDir%>/add.gif"  alt="Click Here To Add" border=no onClick="funOpt(1,'ezAddWorkGroups.jsp')">
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
		</center>
<%
		return;
	}
%>

<%
	int searchCount = 0;
	if(listRet!=null && alphaTree.size()>0 )
	{
		ezc.ezbasicutil.EzSearchReturn mySearch = new ezc.ezbasicutil.EzSearchReturn();
		if(searchPartner !=null && (! "null".equals(searchPartner)) && searchPartner.length()!=0)
		{
	          	mySearch.search(listRet,"DESCRIPTION",searchPartner.toUpperCase());
		}
		if(role!=null)
		{
			for(int i=0;i<listRet.getRowCount();i++)
			{
				if(role.equals(listRet.getFieldValue(i,"ROLE")))
				{
					searchCount++;
				}
			}
		}
		if(searchPartner !=null && (! "null".equals(searchPartner)) && searchPartner.length()!=0 && searchCount==0)
		{
%>
			<br>
			<br>
			<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
			<Tr>
			    	<Td class="displayheader">
    		      			<div align="center">There are no Work Groups to list with alphabet starts with "<%=searchPartner.substring(0,searchPartner.indexOf("*"))%>".</div>
		    		</Td>
		  	</Tr>
		  	</Table>
			<br>
			<center>
				<input type=image  src="../../Images/Buttons/<%= ButtonDir%>/add.gif"  alt="Click Here To Add" border=no onClick="funOpt(1,'ezAddWorkGroups.jsp')">
				<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
			</center>
<%
			return;
		}
	}
%>
	
<%
	if(role!=null && !role.equals("sel") && searchCount!=0)
	{
%>
	<Table  align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
		<Tr class=trClass>
			<Td align=center class=displayheader>Work Groups List</Td>
		</Tr>
		</Table>
		<div id="theads">
		<Table id="tabHead" align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
		<Tr class=trClass>
			<Th class=thClass align=left width="5%">&nbsp;</Th>

			<Th class=thClass align=center width="30%"">Work Group</Th>
			<Th class=thClass align=center width="65%"">Description</Th>
		</Tr>
		</Table>
		</Div>
		<div id="InnerBox1Div">
		<Table id="InnerBox1Tab" align=center  class=tableClass border=1 borderColorDark=#ffffff  borderColorLight=#000000 cellPadding=2 cellSpacing=0>
<%
			
			listRet.sort(new String[]{"GROUP_ID"},true);
			for(int i=0;i<listRet.getRowCount();i++)
			{
%>
				<Tr class=trClass>
				<label for="cb_<%=i%>">
					<Td class=tdClass align=center width="5%">
					<input type=radio name=chk1 id="cb_<%=i%>" value="<%=listRet.getFieldValue(i,"GROUP_ID")%>,<%=listRet.getFieldValue(i,"LANG")%>">
					</Td>
					<Td class=tdClass align=left width="30%"><a style="text-decoration:none" href="ezWorkGroupsDetails.jsp?chk1=<%=listRet.getFieldValue(i,"GROUP_ID")%>,<%=listRet.getFieldValue(i,"LANG")%>"><%=listRet.getFieldValue(i,"GROUP_ID")%></a>&nbsp;</Td>
					<Td class=tdClass align=left width="65%"><%=removeNull(listRet.getFieldValue(i,"DESCRIPTION"))%>&nbsp;</Td>
				</label>
				</Tr>
<%
			}
%>
			</Table>
		</Div>
		<Div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
			<input type=image  src=../../Images/Buttons/<%= ButtonDir%>/add.gif  alt="Click Here To Add" border=no onClick="funOpt(1,'ezAddWorkGroups.jsp')">
			<input type=image  src=../../Images/Buttons/<%= ButtonDir%>/edit.gif  alt="Click Here To Edit" border=no onClick="funOpt(2,'ezEditWorkGroups.jsp')">
			<input type=image  src=../../Images/Buttons/<%= ButtonDir%>/delete.gif  alt="Click Here To Delete" border=no onClick="funOpt(3,'ezDeleteWorkGroups.jsp')">
			<img src=../../Images/Buttons/<%= ButtonDir%>/workgroupusers.gif  alt="Work Group Users" border=no onClick="funWGUsers()" Style = "Cursor:hand">
		</Div>
<%
	}
%>
</Form>
</Body>
</Html>

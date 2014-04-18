<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp" %>
<%@ include file="../../../Includes/JSPs/WorkFlow/iWorkGroupsList.jsp"%>
<%
	String searchPartner=request.getParameter("searchcriteria");

	session.putValue("mySearchCriteria",searchPartner);

	String role = "";
	role = request.getParameter("role");
 	java.util.Vector myVector = new java.util.Vector();
 	java.util.Vector myRoleDescVector = new java.util.Vector();
 	listRet.sort(new String[]{"ROLEDESCRIPTION"},true);
 	int roleCount = listRet.getRowCount();
	for (int i=0;i<roleCount;i++)
	{
		if(!myVector.contains(listRet.getFieldValue(i,"ROLE")))
		{
			myVector.addElement(listRet.getFieldValue(i,"ROLE"));
			myRoleDescVector.addElement(listRet.getFieldValue(i,"ROLEDESCRIPTION"));
		}
	}
	listRet.sort(new String[]{"GROUP_ID"},true);
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
<%
	if(listRet.getRowCount()==0)
	{
%>
		<br><br><br>
		<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
		<Tr>
			<Th width="100%" align=center>
			No WorkGroups To List
			</Th>
		</Tr>
		</Table><br><center>
		<input type=image  src="../../Images/Buttons/<%= ButtonDir%>/add.gif"  alt="Click Here To Add" border=no onClick="funOpt(1,'ezAddWorkGroups.jsp')">
		</center>
<%
	}else{
%>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
<Tr align="center">
	  <Th width="35%" class="labelcell">Role
      </Th>
      <Td width="65%" class="blankcell">
        	<select name="role" style="width:100%" id=FullListBox onChange="funSubmit()">
		<option value="sel">--Select Role--</option>
<%

		for(int i=0;i<myVector.size();i++)
		{
			if(role!=null)
			{

				if(role.equals(myVector.elementAt(i)))
				{
%>
					<option value='<%=myVector.elementAt(i)%>' selected><%=myRoleDescVector.elementAt(i)%> </option>
<%				}
				else
				{
%>
					<option value='<%=myVector.elementAt(i)%>'><%=myRoleDescVector.elementAt(i)%> </option>
<%				}
			}
			else
			{
%>
					<option value='<%=myVector.elementAt(i)%>'><%=myRoleDescVector.elementAt(i)%> </option>
<%
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
<input type="hidden" name="searchcriteria" value="">
<%
	int searchCount = 0;
	if(listRet!=null )
	{
		ezc.ezbasicutil.EzSearchReturn mySearch = new ezc.ezbasicutil.EzSearchReturn();
		if(searchPartner !=null && (! "null".equals(searchPartner)) && searchPartner.length()!=0)
		{
	          	mySearch.search(listRet,"GROUP_ID",searchPartner.toUpperCase());
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
			for(int i=0;i<listRet.getRowCount();i++)
			{
				if(role.equals(listRet.getFieldValue(i,"ROLE")))
				{
%>
				<Tr class=trClass>
					<Td class=tdClass align=center width="5%">
					<input type=radio name=chk1 value="<%=listRet.getFieldValue(i,"GROUP_ID")%>,<%=listRet.getFieldValue(i,"LANG")%>">
					</Td>
					<Td class=tdClass align=left width="30%"><a style="text-decoration:none" href="ezWorkGroupsDetails.jsp?chk1=<%=listRet.getFieldValue(i,"GROUP_ID")%>,<%=listRet.getFieldValue(i,"LANG")%>"><%=listRet.getFieldValue(i,"GROUP_ID")%></a>&nbsp;</Td>
					<Td class=tdClass align=left width="65%"><%=removeNull(listRet.getFieldValue(i,"DESCRIPTION"))%>&nbsp;</Td>
				</Tr>
<%
				}
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

	else
	{
%>
		<br><br>
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
	}
		}
%>


</Form>
</Body>
</Html>

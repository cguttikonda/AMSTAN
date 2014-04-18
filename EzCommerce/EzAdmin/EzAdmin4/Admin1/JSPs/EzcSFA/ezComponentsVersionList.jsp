<%--***************************************************************
       /* Copyright Notice =====================================*
	* This file contains proprietary information of EzCommerce Inc.
	* Copying or reproduction without prior written approval is prohibited.
	* Copyright (c) 2003-2004 =====================================*/
*****************************************************************--%>
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/EzcSFA/iComponentsVersionList.jsp"%>
<%@ include file="../../../Includes/JSPs/EzcSFA/iUserList.jsp"%>



<Html>
<Head>
	<Title>EzComponents Version List----Powered by Ezcommerce Global Solutions</Title>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<script src="../../Library/JavaScript/ezTabScroll.js"></script>
<Script language="JavaScript">
	function fun(option)
	{
		if(option==1)
		{
			if(document.myForm.cCode.selectedIndex!=0)
				document.myForm.submit();
		}
		if(option==2)
		{
			if(document.myForm.cCode.selectedIndex==0 || document.myForm.cCode.selectedIndex==-1)
			{
				alert("Please Select the Component");
				return;
			}
			else
			{
				document.myForm.action="ezComponentsVersionList.jsp";
				document.myForm.submit();
			}
		}
	}
		function funAdd()
		{
			document.myForm.action = "ezAddOldVersion.jsp";
			document.myForm.submit();
		}

</Script>
</Head>
<body onLoad="scrollInit()" scroll=no onResize="scrollInit()">
<Form name=myForm >
<Br>
		<Table width="85%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
		<Tr>
			<Td width=20% class="labelcell" align="right">Component Code *</Td>
			<Td width=20%>
			<Select name=cCode id="FullListBox" onChange="fun(1)" style='width:100%'>
				<Option value="">-Select-</Option>
<%
				if(ComponentsListCount  != 0)
				{
					for(int i=0;i<ComponentsListCount;i++)
					{
						databaseValue=retComponentsList.getFieldValueString(i,"CODE");
						isChecked=(compCode.equals(databaseValue))? "selected" : "";
%>
						<Option value='<%=retComponentsList.getFieldValue(i,"CODE")%>' <%=isChecked%>><%=retComponentsList.getFieldValue(i,"DESCRIPTION")%></Option>
<%
					}
				}
%>
			</Select>
			</Td>
			<Td class="labelcell" width=15% align='right'>Version</Td>
			<Td width=25%>
			<Select name=vCode id="FullListBox" style='width:100%'>
				<Option value="ALL">ALL</Option>
<%
				if(ComponentsVersionListCount != 0)
				{
					for(int i=0;i<ComponentsVersionListCount;i++)
					{
						databaseValue=retComponentsVersionsList.getFieldValueString(i,"VERSION");
						isChecked=(versionNumber.equals(databaseValue))? "selected" : "";
%>
						<Option value='<%=retComponentsVersionsList.getFieldValue(i,"VERSION")%>' <%=isChecked%>><%=retComponentsVersionsList.getFieldValue(i,"VERSION")%></Option>
<%
					}
				}
%>

			</Select>
			</Td>
			<Td class="labelcell" width=5% align='right'>User</Td>
			<Td width=30%>
			<Select name=user id="FullListBox" style='width:100%'>
			<Option value='All'>ALL</Option>
<%
					for(int i=0;i<userList.length;i++)
					{
					String chkUsr=(user.equals(userList[i]))? "selected" : "";

%>
						<Option value='<%=userList[i]%>' <%=chkUsr%>><%=userList[i]%></Option>
<%
					}

%>

			</Select>
			</Td>
			<Td align=center width=10%><a href='javascript:fun(2)'><img src="../../Images/Buttons/<%=ButtonDir%>/show.gif"  alt="Show" border=no></a></Td>
		</Tr>
		</Table>
		<Table align="center" width=60%>
			<Tr>
				<Th class=nolabelcell width=80%>Select Component,Version and User To View their Respective Component Versions</Th>
			</Tr>
		</Table>
		<br>
<%
		if(retListCount!=0)
		{
%>
		<Table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
			<Tr>
				<Th class="displayheader" align=center>List Of Component Versions</Th>
			</Tr>
		</Table>
		<Div id="theads">
			<Table id="tabHead" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
				<Tr>
					<Th width="10%">Version</Th>
					<Th width="50%">UserId</Th>
					<Th width="35%">Last Updated On</Th>
				</Tr>
			</Table>
		</Div>
		<Div id="InnerBox1Div">
			<Table id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
<%
				String Client="";
				for(int j=0;j<retListCount;j++)
				{
%>
					<Tr>
						<Td width="10%"><Input type="Text" class="textInBox" value='<%=retList.getFieldValue(j,"ECV_VERSION")%>'size="10%" readonly></Td>
<%
						Client=retList.getFieldValueString(j,"ECV_CLIENT");
%>
						<Td width="50%"><Input type="Text" class="textInBox" value="<%=Client%>" style='width:100%' readonly></Td>

<%
						String lastupdate=retList.getFieldValueString(j,"ECV_LAST_UPDATED_ON");
%>
						<Td width="35%" align="center"><Input type="Text" class="textInBox" value='<%=lastupdate%>' size="20%"  readonly></Td>
					</Tr>
<%
				}
%>
			</Table>
			</Div>

<%
		}
%>

			<Div id="ButtonDiv" align=center style="position:absolute;top:90%;width:100%">
			<Table border=0 align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width=15%>
			<Tr>
				<Td class="blankcell" align=center>
					<a href="javascript:funAdd()"><img src="../../Images/Buttons/<%=ButtonDir%>/add.gif"  alt="Add" border=no style="cursor:hand"></a>
				</Td>

				<Td class="blankcell" align=center>
					<a href="javascript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif"  alt="Back" border=no style="cursor:hand"></a>
				</Td>
			</Tr>
			</Table>
			</Div>

</Form>
</Body>
</Html>

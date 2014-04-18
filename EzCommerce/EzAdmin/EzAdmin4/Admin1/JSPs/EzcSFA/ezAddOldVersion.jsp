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
				document.myForm.submit();
			}
		}
	}
	function funSave()
	{
		document.myForm.action="ezAddSaveOldVersion.jsp";
		document.myForm.submit();
	}
</Script>
</Head>
<body onLoad="scrollInit()" scroll=no onResize="scrollInit()">
<Form name=myForm >
<Br>
<Table width="40%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
<Tr>
	<Td class="labelcell" width="11%" align=right>User*</Td>
	<Td width=22%>
		<Select name="username" style='width:100%' id="FullListBox">
		<option value='ALL'>ALL</Option>
		<%
			for(int i=0;i<userList.length;i++)
			{
		%>
				<option value='<%=userList[i]%>'><%=userList[i]%></Option>
		<%
			}
		%>
		</Select>
	</Td>
</Tr>
<Tr>
	<Td width=11% class="labelcell" align="right">Component Code *</Td>
	<Td width=22%>
		<Select name=compcode id="FullListBox" onChange="fun(1)" style='width:100%'>
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
</Tr>
<Tr>
	<Td class="labelcell" width=11% align='right'>Version</Td>
	<Td width=23%>
		<Select name=version id="FullListBox" style='width:100%'>
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
</Tr>
</Table><Br>
<Table border=0 align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width=15%>
<Tr>
	<Td class="blankcell" align=center>
		<a href="javascript:funSave()"><img src="../../Images/Buttons/<%=ButtonDir%>/save.gif"  alt="Save" border=no style="cursor:hand"></a>
	</Td>
	<Td class="blankcell" align=center>
		<a href="javascript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif"  alt="Back" border=no style="cursor:hand"></a>
	</Td>
</Tr>
</Table>
</Form>
</Body>
</Html>

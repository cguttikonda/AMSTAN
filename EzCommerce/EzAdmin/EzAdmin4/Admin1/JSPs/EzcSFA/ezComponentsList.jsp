<%--***************************************************************
       /* Copyright Notice =====================================*
	* This file contains proprietary information of EzCommerce Inc.
	* Copying or reproduction without prior written approval is prohibited.
	* Copyright (c) 2003-2004 =====================================*/
*****************************************************************--%>
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/EzcSFA/iComponentsList.jsp"%>
<Html>
<Head>
	<Title>EzComponents List----Powered by Ezcommerce Global Solutions</Title>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<script src="../../Library/JavaScript/ezTabScroll.js"></script>
	<script src="../../Library/JavaScript/chkEditAndDelete.js"></script>
	<script src="../../Library/JavaScript/Components/ezComponentsList.js"></script>

</Head>
<body onLoad="scrollInit()" scroll=no onResize="scrollInit()">
<Form name=myForm method="post" onSubmit="return go()" >

<%
	if(ComponentsListCount==0)
	{
%>
		<Div id="tabHead" align=center style="position:absolute;top:40%;width:100%">
			<Table align="center">
				<Tr>
					<Th class=nolabelcell> No Components To List</Th>
				</Tr>
				<Tr>
					<Th class=nolabelcell>Please Click 'Add' To Add A Component</Th>
				</Tr>
				<Tr>
					<Th class=nolabelcell><input type=image src="../../Images/Buttons/<%=ButtonDir%>/add.gif"  alt="Add" border=no onClick="fun(1)"></Th>
				</Tr>
			</Table>
		</Div>

</Form>
</Body>
</Html>
<%
	return;
	}
	else
	{
%>
		<Br>
		<Table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
			<Tr>
				<Th class="displayheader" align=center>List Of Components</Th>
			</Tr>
		</Table>
		<Div id="theads">
			<Table id="tabHead" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
				<Tr>
					<Th width="5%"><input type=checkbox name=chkAll onclick="checkAll()"></Th>
					<Th width="15%">Code</Th>
					<Th width="20%">Version</Th>
					<Th width="60%">Description</Th>

				</Tr>
			</Table>
		</Div>
		<Div id="InnerBox1Div">
			<Table id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
<%
				String version = "1.0";
				for(int i=0;i<ComponentsListCount;i++)
				{
					version = retComponentsList.getFieldValueString(i,"VERSION");
%>
					<Tr>
						<Td align=center width="5%"><Input type=checkbox  name=chk1  value='<%=retComponentsList.getFieldValue(i,"CODE")%>'></Td>
						<Td width="15%"><%=retComponentsList.getFieldValue(i,"CODE")%></a></Td>
						<Td width="20%"><Input type="Text" name="d" class="textInBox" value='<%=version%>' size="20%" readonly></Td>
						<Td width="60%"><Input type="Text" class="textInBox" value='<%=retComponentsList.getFieldValue(i,"DESCRIPTION")%>'size="30%" readonly></Td>

					</Tr>
<%
				}
%>

			</Table>
		</Div>
		<Div id="ButtonDiv" align=center style="position:absolute;top:90%;width:100%">
			<Table border=0 align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width=35%>
				<Tr>
					<Td class="blankcell" align=center>
						<a href="javascript:fun(1)"><img src="../../Images/Buttons/<%=ButtonDir%>/add.gif" alt="Add" border=no style="cursor:hand"></a>
					</Td>
					<Td class="blankcell" align=center>
						<a href="javascript:fun(2)"><img src="../../Images/Buttons/<%=ButtonDir%>/edit.gif" alt="Edit" border=no style="cursor:hand"></a>
					</Td>
					<Td class="blankcell" align=center>
						<a href="javascript:fun(3)"><img src="../../Images/Buttons/<%=ButtonDir%>/delete.gif" alt="Delete" border=no style="cursor:hand"></a>
					</Td>
					<Td class="blankcell" align=center>
						<a href="javascript:fun(4)"><img src="../../Images/Buttons/<%=ButtonDir%>/version.jpg" alt="New Version" border=no style="cursor:hand"></a>
					</Td>
					<Td class="blankcell" align=center>
						<a href="javascript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif"  alt="Back" border=no style="cursor:hand"></a>
					</Td>
				</Tr>
			</Table>
		</Div>

<%
		}
%>
</Form>
</Body>
</Html>

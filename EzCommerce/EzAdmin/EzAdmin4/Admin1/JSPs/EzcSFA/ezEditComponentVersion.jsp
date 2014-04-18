<%--***************************************************************
       /* Copyright Notice =====================================*
	* This file contains proprietary information of EzCommerce Inc.
	* Copying or reproduction without prior written approval is prohibited.
	* Copyright (c) 2003-2004 =====================================*/

       /* Author : Ammireddy.B
	* Team   : Admin
	* Date   : 10-2-2003
	* Copyright (c) 2003-2004 =====================================*/
*****************************************************************--%>
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/EzcSFA/iComponentsList.jsp"%>
<%@ include file="../../../Includes/JSPs/EzcSFA/iEditComponentVersion.jsp"%>
<Html>
<Head>
	<Title>Edit Component Version----Powered by EzCommerce Global Solutions</Title>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<Script src="../../Library/JavaScript/Misc/checkFormFields.js"></Script>
	<%@ include file="../../../Includes/JSPs/Misc/iCurrentDates.jsp" %>
	<Script src="../../Library/JavaScript/Misc/ezCalender.js"></Script>
	<script src="../../Library/JavaScript/Components/ezEditComponentVersion.js"></script>
</Head>
<Body onLoad="document.myForm.Client.focus()" scroll="no">
<Form name="myForm" method="post" action="ezEditSaveComponentVersion.jsp" onSubmit="return checksubmit()"><Br>
	<Table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="80%">
		<Tr>
			<Th class="displayheader" align=center><b>Edit Component Version</b></Th>
		</Tr>
	</Table>
	<Table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="80%">
		<Tr>
			<Td class="labelcell">Code:</Td>
			<Td width=75%><input type=hidden name="compVerCode" value="<%=retComponentsVersionsDetails.getFieldValue(0,"ECV_COMP_NO")%>"><%=retComponentsVersionsDetails.getFieldValue(0,"ECV_COMP_NO")%></Td>
		</Tr>
		<Tr>
			<Td class="labelcell">Component:*</Td>
			<Td width=80%>
				<Select name=Component id="ListBoxDiv">
					<option value="_">-Select-</option>
<%
					for(int i=0;i<ComponentsListCount;i++)
					{
						if(retComponentsList.getFieldValue(i,"CODE").equals(retComponentsVersionsDetails.getFieldValue(0,"ECV_COMPONENT")))
						{
%>
							<option value="<%=retComponentsList.getFieldValue(i,"CODE")%>" selected><%=retComponentsList.getFieldValue(i,"DESCRIPTION")%></option>
<%
						}
						else
						{
%>
							<option value="<%=retComponentsList.getFieldValue(i,"CODE")%>"><%=retComponentsList.getFieldValue(i,"DESCRIPTION")%></option>
<%
						}
					}
%>
				</Select>

			</Td>
		</Tr>
		<Tr>
			<Td class="labelcell">Version:*</Td>
			<Td width=80%>
				<Select name=Version id="ListBoxDiv">
<%
				for(int i=0;i<ComponentVersionHistoryListCount;i++)
				{
					if(retComponentVersionHistoryList.getFieldValue(i,"VERSION").equals(retComponentsVersionsDetails.getFieldValue(0,"ECV_VERSION")))
					{
%>
						<option value="<%=retComponentVersionHistoryList.getFieldValue(i,"VERSION")%>" selected><%=retComponentVersionHistoryList.getFieldValue(i,"VERSION")%></option>
<%
					}
					else
					{
%>
						<option value="<%=retComponentVersionHistoryList.getFieldValue(i,"VERSION")%>"><%=retComponentVersionHistoryList.getFieldValue(i,"VERSION")%></option>
<%
					}
				}
%>

				</Select>
			</Td>
		</Tr>
		<Tr>
			<Td class="labelcell">Client:*</Td>
			<Td width=80%>
				<Select name=Client id="ListBoxDiv">
					<option value="_">-Select-</option>
					<option value="1">Reddys</option>
					<option value="2">Ranbaxy</option>
					<option value="3">Siris</option>
				</Select>

			</Td>
		</Tr>
		<Script>
			document.myForm.Client.value='<%=retComponentsVersionsDetails.getFieldValue(0,"ECV_CLIENT")%>'
		</Script>
		<Tr>
			<Td class="labelcell">Last Updated On*</Td>
			<Td>
				<Input type=text class=InputBox name="upDate" value="<%=dateRet.getFieldValueString("ECV_LAST_UPDATED_ON")%>"size=10  readonly>
	        			<a href="javascript:void(0)" onClick=showCal("document.myForm.upDate",140,300,"<%=cDate%>","<%=cMonth%>","<%=cYear%>")>
        				<img src="../../Images/Buttons/<%=ButtonDir%>/calendar.gif"  alt="Calendar" border=no></a>
			</Td>

		</Tr>
	</Table>
	<Div align=center id="ButtonDiv" style="position:absolute;top:90%;width:100%">
		<Table border=0 align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width=35%>
			<Tr>
				<Td class="blankcell" align=center>
					<input type=image src="../../Images/Buttons/<%=ButtonDir%>/save.gif"  alt="Save" border=no>
				</Td>
				<Td class="blankcell" align=center>
					<a href="javascript:document.myForm.reset()"><img src="../../Images/Buttons/<%=ButtonDir%>/reset.gif"  alt="Reset" border=no style="cursor:pointer;cursor:hand"></a>
				</Td>
				<Td class="blankcell" align=center>
					<a href="javascript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif"  alt="Back" border=no></a>
				</Td>
			</Tr>
		</Table>
	</Div>
</Form>
</Body>
</Html>

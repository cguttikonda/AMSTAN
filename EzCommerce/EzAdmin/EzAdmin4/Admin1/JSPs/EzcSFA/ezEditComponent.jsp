<%--***************************************************************
       /* Copyright Notice =====================================*
	* This file contains proprietary information of EzCommerce Inc.
	* Copying or reproduction without prior written approval is prohibited.
	* Copyright (c) 2003-2004 =====================================*/
*****************************************************************--%>

<%@ include file="../../../Includes/JSPs/EzcSFA/iEditComponent.jsp" %>
<Html>
<Head>
	<Title>Edit Component----Powered by EzCommerce Global Solutions</Title>
 	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
 	<Script src="../../Library/JavaScript/CheckFormFields.js"></Script>
	<script src="../../Library/JavaScript/Components/ezEditComponent.js"></script>
</Head>
<Body onLoad="document.myForm.compDesc.focus()" scroll="no">
<Form name="myForm" method="post"><Br>
	<Table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="80%">
		<Tr>
			<Th class="displayheader" align=center><b>Edit Component</b></Th>
		</Tr>
	</Table>
	<Table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="80%">
		<Tr>
			<Td class="labelcell">Component Code:</Td>
			<Td width=75%><input type=hidden name="compCode" value="<%=retComponentDetails.getFieldValue(0,"CODE")%>"><%=retComponentDetails.getFieldValue(0,"CODE")%></Td>
		</Tr>
		<Tr>
			<Td class="labelcell">Version:*</Td>
			<Td width=75%><input type=text class=InputBox name="compVersion" value="<%=retComponentDetails.getFieldValue(0,"VERSION")%>" maxlength=5 style="width:100%"></Td>
		</Tr>
		<Tr>
			<Td class="labelcell">Description:*</Td>
			<Td width=75%><input type=text class=InputBox name="compDesc" maxlength=100 style="width:100%" value="<%=retComponentDetails.getFieldValue(0,"DESCRIPTION")%>"></Td>
		</Tr>

	</Table>
	<Div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
		<Table border=0 align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width=35%>
			<Tr>
				<Td class="blankcell" align=center>
					<a href="javascript:checkForm()"><img src="../../Images/Buttons/<%=ButtonDir%>/update.gif"  alt="Update" border=no></a>
				</Td>
				<Td class="blankcell" align=center>
					<a href="javascript:document.myForm.reset()"><img src="../../Images/Buttons/<%=ButtonDir%>/reset.gif"  alt="Reset" border=no ></a>
				</Td>
				<Td class="blankcell" align=center>
					<a href="javascript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif"  alt="Back" border=no  style="cursor:pointer;cursor:hand"></a>
				</Td>
			</Tr>
		</Table>
</Form>
</Body>
</Html>

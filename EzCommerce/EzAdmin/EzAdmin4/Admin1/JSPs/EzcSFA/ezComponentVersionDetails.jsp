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
<%@ include file="../../../Includes/JSPs/Components/iComponenVersionDetails.jsp"%>
<Html>
<Head>
	<Title>Component Version Details----Powered by EzCommerce Global Solutions</Title>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
</Head>
<Body>
	<Form name="myForm"><Br>
		<Table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="80%">
			<Tr>
				<Td class="displayheader" align=center><b>Component Version Details</b></Td>
			</Tr>
		</Table>

		<Table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="80%">
		<Tr>
			<Td class="labelcell">Component Code:</Td>
			<Td width=75%><%=Component%></Td>
		</Tr>
		<Tr>
			<Td class="labelcell">Component Version:</Td>
			<Td width=75%><%=retComponentsVersionsDetails.getFieldValue(0,"ECV_VERSION")%></Td>
		</Tr>
		<Tr>
			<Td class="labelcell">Client:</Td>
			<Td width=75%><%=Client%></Td>
		</Tr>
		<Tr>
			<Td class="labelcell">Last Up Dated On:</Td>
			<Td width=75%><%=retComponentsVersionsDetails.getFieldValueString(0,"ECV_LAST_UPDATED_ON").substring(0,10)%></Td>
		</Tr>
	</Table>
	<Div align=center id="ButtonDiv" style="position:absolute;top:90%;width:100%">
		<Table border=0 align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width=35%>
			<Tr>
				<Td class="blankcell" align=center>
					<a href="javascript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif"  alt="Back" border=no></a>
			</Td>
			</Tr>
		</Table>
	</Div>
</Form>
</Body>
</Html>

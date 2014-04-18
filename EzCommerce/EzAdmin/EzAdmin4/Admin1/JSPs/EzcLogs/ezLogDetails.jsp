<%--***************************************************************
       /* Copyright Notice =====================================*
	* This file contains proprietary information of EzCommerce Inc.
	* Copying or reproduction without prior written approval is prohibited.
	* Copyright (c) 2003-2004 =====================================*/

       /* Author : Ammireddy.B
	* Team   : Admin
	* Date   : 16-3-2004
	* Copyright (c) 2003-2004 =====================================*/
*****************************************************************--%>
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/EzcLogs/iLogsDetails.jsp"%>
<Html>
<Head>
	<Title>Logs Details----Powered by EzCommerce Global Solutions</Title>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
</Head>
<Body>
	<Form name="myForm"><Br>
		<Table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="80%">
			<Tr>
				<Th class="displayheader" align=center><b>Logs Details</b></Th>
			</Tr>
		</Table>

		<Table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="80%">
		<Tr>
			<Td class="labelcell">Log Number:</Td>
			<Td width=75%><%=retLogsDetails.getFieldValue(0,"LOGNO")%></Td>
		</Tr>
		<Tr>
			<Td class="labelcell">User ID:</Td>
			<Td width=75%><%=retLogsDetails.getFieldValue(0,"USERID")%></Td>
		</Tr>
		<Tr>
			<Td class="labelcell">Sys Key:</Td>
			<Td width=75%><%=retLogsDetails.getFieldValue(0,"SYSKEY")%></Td>
		</Tr>
		<Tr>
			<Td class="labelcell">Sold To:</Td>
			<Td width=75%><%=retLogsDetails.getFieldValue(0,"SOLDTO")%></Td>
		</Tr>
		<Tr>
			<Td class="labelcell">Key:</Td>
			<Td width=75%><%=retLogsDetails.getFieldValue(0,"LOGKEY")%></Td>
		</Tr>
		<Tr>
			<Td class="labelcell">Value:</Td>
			<Td width=75%><%=retLogsDetails.getFieldValue(0,"VALUE")%></Td>
		</Tr>
		<Tr>
			<Td class="labelcell">Time Stamp:</Td>
			<Td width=75%><%=retLogsDetails.getFieldValueString(0,"TIMESTAMP").substring(0,10)%></Td>
		</Tr>
	</Table>
	<Div align=center id="ButtonDiv" style="position:absolute;top:90%;width:100%">
		<Table border=0 align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width=35%>
			<Tr>
				<Td class="nolabelcell" align=center>
					<a href="javascript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif"  alt="Back" border=no></a>
			</Td>
			</Tr>
		</Table>
	</Div>
</Form>
</Body>
</Html>

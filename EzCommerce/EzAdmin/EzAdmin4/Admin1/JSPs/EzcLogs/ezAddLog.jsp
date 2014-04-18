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
<Html>
<Head>
	<Title>Add Log----Powered by EzCommerce Global Solutions</Title>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<%@ include file="../../../Includes/JSPs/Misc/iCurrentDates.jsp" %>
	<Script src="../../Library/JavaScript/Misc/ezCalender.js"></Script>
	<Script src="../../Library/JavaScript/Misc/checkFormFields.js"></Script>
	<script src="../../Library/JavaScript/EzcLogs/ezAddLog.js"></script>
</Head>
<Body onLoad="document.myForm.userid.focus()">
<Form name="myForm" method="post" action="ezAddSaveLog.jsp" onSubmit="return checksubmit()"><Br>
	<Table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="80%">
		<Tr>
			<Th class="displayheader" align=center><b>Add Log</b></Th>
		</Tr>
	</Table>

	<Table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="80%">
		<Tr>
			<Td class="labelcell">User ID:*</Td>
			<Td width=75%><input type=text class=InputBox name="userid" maxlength=10 style="width:100%"></Td>
		</Tr>
		<Tr>
			<Td class="labelcell">Sys Key:*</Td>
			<Td width=75%><input type=text class=InputBox name="syskey" maxlength=18 style="width:100%"></Td>
		</Tr>
		<Tr>
			<Td class="labelcell">Sold To:*</Td>
			<Td width=75%><input type=text class=InputBox name="soldto" maxlength=10 style="width:100%"></Td>
		</Tr>
		<Tr>
			<Td class="labelcell">Key:*</Td>
			<Td width=75%><input type=text class=InputBox name="key" maxlength=20 style="width:100%"></Td>
		</Tr>
		<Tr>
			<Td class="labelcell">Value:*</Td>
			<Td width=75%><input type=text class=InputBox name="value" maxlength=500 style="width:100%"></Td>
		</Tr>
		<Tr>
			<Td class="labelcell">Time Stamp*</Td>
			<Td>
				<Input type=text class=InputBox name="timestamp" size=10  readonly >
				<a href="javascript:void(0)"onClick=showCal("document.myForm.timestamp",140,300,"<%=cDate%>","<%=cMonth%>","<%=cYear%>")>
        			<img src="../../Images/Buttons/<%=ButtonDir%>/calendar.gif"  alt="Calendar" border=no></a>
			</Td>
		</Tr>


	</Table>

	<Div align=center id="ButtonDiv" style="position:absolute;top:90%;width:100%">
	<Table border=0 align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width=35%>
		<Tr>
			<Td class="nolabelcell" align=center>
				<input type=image src="../../Images/Buttons/<%=ButtonDir%>/save.gif"  alt="Save" border=no>
			</Td>
			<Td class="nolabelcell" align=center>
				<a href="javascript:document.myForm.reset()"><img src="../../Images/Buttons/<%=ButtonDir%>/reset.gif"  alt="Reset" border=no style="cursor:pointer;cursor:hand"></a>
			</Td>
			<Td class="nolabelcell" align=center>
				<a href="javascript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif"  alt="Back" border=no></a>
			</Td>
		</Tr>
	</Table>
	</Div>
</Form>
</Body>
</Html>

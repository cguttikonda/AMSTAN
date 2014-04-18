<%--***************************************************************
       /* Copyright Notice =====================================*
	* This file contains proprietary information of EzCommerce Inc.
	* Copying or reproduction without prior written approval is prohibited.
	* Copyright (c) 2003-2004 =====================================*/
*****************************************************************--%>

<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%//@ include file="../../../Includes/Lib/InboxBean.jsp"%>
<%@ include file="../../../Includes/Lib/Inbox.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCurrentDates.jsp" %>
<%@ include file="../../../Includes/JSPs/EzcSFA/iComponentsList.jsp" %>
<%@ include file="../../../Includes/JSPs/EzcSFA/iUserList.jsp" %>



<%
	String compCode = request.getParameter("chk1");

%>
<Html>
<Head>
	<Title>EzAddComponentVersionHistory---Powered by Ezcommerce Global Solutions</Title>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
   	<script src="../../Library/JavaScript/ezCalender.js"></script>
	<script src="../../Library/JavaScript/Components/ezAddComponentsVersionHistory.js"></script>
	<script src="../../Library/JavaScript/Misc/checkFormFields.js"></script>
</Head>

<Body onLoad="document.myForm.code.focus()" scroll = "no">
	<Form name=myForm method=post>

<%
    		if(retComponentsList!=null && ComponentsListCount==0)
      		{
 %>

				<Div id="ButtonDiv" align="center" style="position:absolute;top:35%;width:100%">
				<Table align="center" width=100%>
				<Tr>
					<Th class=nolabelcell>No Components Exist for Add Version History</Th>
				</Tr>
				</Table>
				</Div>

				<Div id="ButtonDiv" align="center" style="position:absolute;top:50%;width:100%">
				<Table align="center" width=100%>
				<Tr>
					<Td class=nolabelcell align=center>
						<a href="../../EzClientApp/ezBlank.htm" style="cursor:hand"><img src="../../Images/Buttons/<%=ButtonDir%>/ok.gif"  alt="Close" border=no></a>
					</TD>
				</Tr>

				</Table>
				</Div>

	</Form>
</Body>
</Html>
<%
		return;
		}
%>
		<Table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
		<Tr>
			<Th class="displayheader" align=center><b>Add Component Version History</b></Th>
		</Tr>
		</Table>

		<Table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
		<Tr>
			<Td class="labelcell">Code*</Td>
			<Td width=75%>
				<Input type=text class=InputBox name="code" size=6 value="<%=compCode%>" readonly>
  			</Td>
		</Tr>

		<Tr>
			<Td class="labelcell">User*</Td>
			<Td width=75%>
				<Select name="uName"><option value='ALL'>ALL</option>
<%
				for(int i=0;i<userList.length;i++)
				{
%>
					<option value='<%=userList[i]%>'><%=userList[i]%>
<%
				}
%>
				</Select>
  			</Td>
		</Tr>


		
		<Tr>
			<Td class="labelcell">Released On*</Td>
			<Td width=75%>
				<Input type=text class=InputBox name="releasedOn" size=10 value="" readonly>
					<a href="javascript:void(0)" onClick=showCal("document.myForm.releasedOn",75,250,"<%=cDate%>","<%=cMonth%>","<%=cYear%>")>
       					<img src="../../Images/calendar.gif"  alt="Calendar" border=no>
				</a>
			</Td>
		</Tr>
		<Tr>
			<Td class="labelcell"><a href="javascript:getAttachWindow()" style="text-decoration:underline"><font color=yellow>Click Here For Attachment</font></a></Td>
			<Td><input type=text class="InputBox" name=attachx value="" readonly style="width:100%"><input type=hidden name="attachs"></Td>
		</Tr>

		</Table>

		<Div align=center id="ButtonDiv" style="position:absolute;top:90%;width:100%">
		<Table border=0 align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width=35%>
		<Tr>
			<Td class="blankcell" align=center>

				<a href="javascript:chkSubmit()"><img src="../../Images/Buttons/<%=ButtonDir%>/save.gif"  alt="Save" border=no></a>
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

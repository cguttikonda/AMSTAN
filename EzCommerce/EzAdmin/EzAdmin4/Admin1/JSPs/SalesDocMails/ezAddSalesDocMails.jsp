<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%
	String msgType = "";
	String mailCode = "";
	String from=request.getParameter("From");
	if(from.equals("PP"))
	{
		msgType = "Plant Planner";
	}
	else if(from.equals("centralplanner"))
	{
		msgType = "Central Planner";
		mailCode= from;
	}
	else
	{
		msgType = "Marketing Services";
		mailCode= from;
	}
	
%>
<html>
<head>
<script  src="../../Library/JavaScript/SalesDocMails/ezAddSalesDocMails.js"></script>
<script  src="../../Library/JavaScript/CheckFormFields.js"></script>
</head>


<body onLoad="document.myForm.PCode.focus()">

<form name=myForm method=post >
<br>
	<Table  width="60%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>

		<Tr>
 		<Th align='center'>Add  <%=msgType%> Mail</Th> 
		</Tr>
	</Table>
	
	<Table  width="60%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
		<Tr>
		<Td class='labelcell' align=right>Code</Td>
		<Td><input type=text class = "InputBox" tabIndex=1 name="PCode" value = "<%=mailCode%>"size="15" maxlengTh="18"></Td>
		</Tr>

		<Tr>
		<Td class='labelcell' align=right>Plant/Area</Td>
   		<Td><input type=text class = "InputBox" tabIndex=2 name="Plant" lengTh="11" maxlength="10"></Td>
		</Tr>
		<Tr>
		<Td class='labelcell' align=right>To</Td>
		<Td><input type=text class = "InputBox" tabIndex=3 name="To" size="30" maxlengTh="1024"></Td>
		</Tr>

		<Tr>
		<Td class='labelcell' align=right>CC</Td>
		<Td><input type=text class = "InputBox" tabIndex=4 name="Cc" size="30" maxlengTh="1024"></Td>
		</Tr>

		<Tr>
		<Td class='labelcell' align=right>BCC / ERP ID</Td>
		<Td><input type=text class = "InputBox" tabIndex=5 name="Edd" size="30" maxlengTh="1024"></Td>
		</Tr>


</Table>
	<br>
	<center>
	<img src="../../Images/Buttons/<%= ButtonDir%>/save.gif" tabIndex=6 style = "cursor:hand" onClick = "funSubmit('<%=from%>')">
	<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" tabIndex=7 border=none onClick="document.myForm.reset()" ></a>
	<img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" style="cursor:hand" border=no tabIndex=8 onClick="javascript:history.go(-1)">
	</center>
</form>
</body>
</html>

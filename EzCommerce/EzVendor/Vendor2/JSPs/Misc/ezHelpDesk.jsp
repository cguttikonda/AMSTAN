<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>

<script>
	function formsubmit()
	{
		document.myForm.submit();
	}

</script>
</head>

<body>
<form name="myForm" method="post" action="ezSendHelpMail.jsp">
	<input type="hidden" name="msgSubject" value="Suggestions and FeedBack on Vikreta2DRL">

	<Table align="center" width="50%">
	<Tr>
		<Td class="displayheader" align="center">Comment on our Web Site</Td>
	</Tr>
	</Table><br>
	<Table width="80%" align="center">
	<Tr>
	<Td class="blankcell">We value all comments on how we can improve its navigation, look and content in order to make it a really useful resource.<br>
	If you'd like to send us a comment about our Web Site, you can use the form below. </Td>
	</Tr>
	</Table><br>
	<Table width="80%" align="center">
	<Tr>
	<Th align="left">Please enter your Comments here</Th>

	</Tr>		<Tr>
			<Td align="center">
			<textarea rows="7" name="msgText" style="overflow:auto;border:1;width:100%" wrap="off"></textarea>
			</Td>
		</Tr>
	</Table>

	<Table align=center>
	<Tr>
		<Td class=blankcell align="center">
		<a href ="javascript:history.go(-1)"><image SRC="../../Images/Buttons/<%=ButtonDir%>/back.gif" border="none"></a>
		<a href ="javascript:formsubmit()"><image SRC="../../Images/Buttons/<%=ButtonDir%>/submit.gif" border="none" ></a>
		</Td>
	</Tr>
	</Table>
</form>
<Div id="MenuSol"></Div>
</body>

</html>

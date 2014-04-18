<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AdminUser.jsp" %>
<%@ page import="java.util.*" %>
<html>
<head>
<Title>Find Password Page</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
</script>
<Script language="JavaScript">
	function funOpenPWWin()
	{
		var userID = document.myForm.usrId.value;

		if(userID=="")
		{
			alert("Please Enter UserId");
			document.myForm.usrId.focus();
			return;
		}
		else
		if(userID.indexOf("'")>=0)
		{
			alert("Please enter UserId without single quotation(')");
			document.myForm.usrId.focus();
			return;
		}
		else
			userID=document.myForm.usrId.value;
			
		
		//var retValue = window.showModalDialog("ezDisplayPassword.jsp?usrId="+userID,window.self,"center=yes;dialogHeight=25;dialogWidth=30;help=no;titlebar=no;status=no;minimize:yes");
		//var retValue = window.open("ezDisplayPassword.jsp?usrId="+userID,'','');
		
		var retValue = window.open("ezDisplayPassword.jsp?usrId="+userID,"PasswordWindow","location=0,width=300,height=200,left=75,top=250,resizable=false,scrollbars=yes,toolbar=no,menubar=no");
	}
</Script>
</head >
<body onLoad="document.myForm.usrId.focus()">
<form name=myForm method=post>
<Div align="center" style="position:absolute;top:20%;width:100%">
	<Table  id="textbox" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
		<Tr>
			<Th width="30%">
				User Id
			</Th>
			<Td width="40%">
				<input class="InputBox" type="text" name="usrId" value="" style="width:100%">	
			</Td>
			<Td width="30%"><a href="javascript:funOpenPWWin()"><Font color="red">Click Here For Password</Font></a></Td>
		</Tr>
		<Tr>
			<Center>*Please enter User Id and click on 'Click Here For Password' For Knowing Password for entered User Id.</Center>
		</Tr>
	</Table>
</Div>	
</form>
</body>
</html>

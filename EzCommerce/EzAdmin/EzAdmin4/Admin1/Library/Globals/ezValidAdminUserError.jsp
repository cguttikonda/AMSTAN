<Html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script> 
	function logOut()
	{
		
		top.location.href="../../JSPs/Misc/ezLogout.jsp" ;
		
	}	
</script> 

</head>
<body>
<form name =myForm>
<br><br><br> 
<center><H3>Session timed out or system error.<BR>Please <a href="Javascript:logOut()">click here</a> to login again.</H3></center> 

</center>
<Div id="MenuSol"></Div>
</form>
</html>


<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<html>
<head>
<Title>Untitled Document</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<form name=myForm method=post action="">



<% String param = request.getParameter("GRPID");%>
  <input type="hidden" name="hello" value="<%=param%>">
</form>

<script language="JavaScript">
var docval = document.myForm.hello.value;
alert("   Connection Failed for the Group: "+ docval +"   \n     Correct the Connection Parameters          " );
	location.href= "../CParam/ezUpdateConnectParam.jsp?SystemNumber="+docval;
</script>
</body>
</html>

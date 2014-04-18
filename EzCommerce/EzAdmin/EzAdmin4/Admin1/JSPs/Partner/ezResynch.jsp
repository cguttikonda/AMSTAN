<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Title>Partner Re-Synchronization Confimation-- Powered by EzCommerce Inc</Title>
<script>
function fun1(arg1)
{
		window.returnValue=arg1
		window.close()
}
</script>
</head>
<body>
<br><br><br>
<br>

<font color="red" face="verdana" size="2">
<center><b><script>document.write(parent.dialogArguments)</script> is already Synchronized.</b></center>
<br>
<!--<center>If you want to Re-Synchronize please click  OK. Otherwise click Cancel.</center>
<br><b>Caution:</b>If you click OK, system clears the old data of this partner in selected Sales Area/Purchase Area and allow you
	to  Re-synchronize. So please <b>don't</b> forget to Synchronize otherwise users of this partner may not be able to login.

</font>
<br>
<Center>-->
<div width="100%">
<Center>

	<!--<img src="../../Images/Buttons/<%= ButtonDir%>/ok.gif" border=none onClick='fun1("Yes")' Style = "Cursor:hand">-->
	<img src="../../Images/Buttons/<%= ButtonDir%>/cancel.gif" border=none onClick='fun1("No")' Style = "Cursor:hand">
</Center>
<div>
</body>
</html>


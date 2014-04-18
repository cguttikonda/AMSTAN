<%@ include file="../../../Includes/JSPs/SelfService/iInvoiceExSheet.jsp"%>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<script>
function goHome()
{
	document.myhome.action="../Misc/ezMain.jsp";
	document.myhome.target="_top"
	document.myhome.submit();
}
</script>
<body>
<form name=myhome>
<center>
<br><br><br>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	buttonName.add("Ok");
	buttonMethod.add("goHome()");
	out.println(getButtonStr(buttonName,buttonMethod));
%>
</form>
<Div id="MenuSol"></Div>
</center>
</body>
</html>

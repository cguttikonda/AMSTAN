<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<html>
<head>
<script>
function doPoPrint()
{
	parent.frames[0].focus();
	parent.frames[0].print();
	close();
}

</script>
</head>
<body>
<form>
<%
    butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Print&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");  
    butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;close&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");  
    butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;Save As&nbsp;&nbsp;&nbsp;&nbsp;");   
    butActions.add("doPoPrint()");
    butActions.add("parent.close()");
    butActions.add("parent.frames[0].document.execCommand('SaveAs','0','ezQCF.htm')");
    out.println(getButtons(butNames,butActions));
%>
</form>
</body>
</html>

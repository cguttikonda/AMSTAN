
<html>
<head>
<%//@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%//@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="iAddCart.jsp"%>
<script>
	function fun(){

		document.myForm.action="../MaterialSearch/ezSearchMaterialsList.jsp";
		document.myForm.submit();
	}
</script>
</head>
<body onLoad=fun()>
<form name=myForm>
<br><br>

<input type=hidden name=className value="<%=className%>">
<%
		for(int i=0;i<selClassCharacter.length;i++){
%>
		<input type="hidden" name="selectedClassCharacter" value="<%=selClassCharacter[i]%>">
<%
		}

		for(int i=0;i<selValues.length;i++){
%>
		<input type="hidden" name="selectedValues" value="<%=selValues[i]%>">
<%
		}
%>

<input type=hidden name=GroupLevel value="1">

</form>
</body>
</html>

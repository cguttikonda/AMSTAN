
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp" %>
<%@ include file="../../../Includes/JSPs/Lables/iWebSalesError2_Lables.jsp" %>
<%
	String SoldTo = request.getParameter("SoldTo");  // don't delete
	String orderStatus=request.getParameter("status");
	String SONumber=request.getParameter("SONumber");
	String orderType=request.getParameter("orderType");

%>
<html>
<head>
<Title>Error -- Powered by EzCommerce Inc</Title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<script>

function ezBack()
{
		document.generalForm.target = "main"
		document.body.style.cursor="wait"
		document.generalForm.action="../Sales/ezWaitSalesDisplay.jsp"
		document.generalForm.submit();
}
</script>
</head>
<body>
<form name="generalForm" method="post">
<input type="hidden" name="urlPage">
<br>
<br><br>
<center>
	<%
	String webOrNoVal=SONumber;
		try{
		webOrNoVal=String.valueOf(Long.parseLong(webOrNoVal));;
		}catch(Exception e){}

	%><b>
	<%=SySO_L%>: &nbsp;&nbsp;<b><font color=red><%= webOrNoVal %> </font></b>&nbsp;&nbsp; <%=isCreOffline_L%> </b><br><br>
	<div align=center id="buttonDiv" style="width:100%;">
	<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		buttonName.add("Ok");
		buttonMethod.add("ezBack()");
		out.println(getButtonStr(buttonName,buttonMethod));
	%>
	</div>
</center>
<input type="hidden" name="status" value="<%=orderStatus%>">
<input type="hidden" name="SONumber" value="<%=SONumber%>">
<input type="hidden" name="SoldTo" value="<%=SoldTo%>">
<input type="hidden" name="orderType" value="<%=orderType%>">
<input type="hidden" name="PODATE" value="">
<input type="hidden" name="netValue" value="">
</form>
<Div id="MenuSol"></Div>
</body>
</html>

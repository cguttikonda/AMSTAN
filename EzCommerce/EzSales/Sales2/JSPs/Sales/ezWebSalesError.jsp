
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp" %>
<%@ include file="../../../Includes/JSPs/Lables/iWebSalesError2_Lables.jsp" %>
<%
String fromDate = request.getParameter("FromDate");  // don't delete
String toDate = request.getParameter("ToDate");
String orderStatus=request.getParameter("status");
String newFilter=request.getParameter("newFilter");
String webOrNoVal =request.getParameter("webOrNo");
%>
<html>

<head>
<Title>Error -- Powered by EzCommerce Inc</Title>


<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<script>

function ezBack()
{
	<%

		if("C".equals(orderStatus))
		{
	%>
			document.generalForm.urlPage.value="ClosedBackEndList"
	<%
		}else if("O".equals(orderStatus))
		{
	%>
			document.generalForm.urlPage.value="OpenBackEndList"
	<%
		}else if("RC".equals(orderStatus))
		{
	%>
			document.generalForm.urlPage.value="ClosedReturnBackEndList"
	<%
		}else if("RO".equals(orderStatus))
		{
	%>
			document.generalForm.urlPage.value="OpenReturnBackEndList"
	<%
		}else if("fO".equals(orderStatus))
		{
	%>
			document.generalForm.urlPage.value="OpenFRSBackEndList"
	<%
		}else
		{
	%>
			document.generalForm.urlPage.value="listPage";
	<%
		}
	%>

		document.body.style.cursor="wait"
		document.generalForm.target="main"
		document.generalForm.action="../Misc/ezMenuFrameset.jsp"
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
		try{
		webOrNoVal=String.valueOf(Long.parseLong(webOrNoVal));;
		}catch(Exception e){}

	%><b>
	<%=SySO_L%>: &nbsp;&nbsp;<b><font color=red><%= webOrNoVal %> </font></b>&nbsp;&nbsp; <%=isCreOffline_L%> </b><br><br>
	
	<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		buttonName.add("Ok");
		buttonMethod.add("ezBack()");
		out.println(getButtonStr(buttonName,buttonMethod));
%>

</center>
<input type="hidden" name="onceSubmit" value=0>
<input type="hidden" name="FromDate" value="<%=fromDate%>" >
<input type="hidden" name="ToDate" value="<%=toDate%>" >
<input type=hidden name="newFilter"  value="<%=newFilter%>">
<input type="hidden" name="orderStatus" value="'<%=orderStatus%>'">
</form>
<Div id="MenuSol"></Div>
</body>
</html>


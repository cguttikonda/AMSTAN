<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%
  	String webOrNo  = request.getParameter("webOrNo");
  	String exp 	= request.getParameter("exp");
%>
<%@ include file="../../../Includes/JSPs/Lables/iWebSalesError_Lables.jsp"%>
<html>
<head>
	<Title>Error -- Powered by Answerthink Ind Ltd</Title>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<script>
	function ezBack()
	{
	     if(document.generalForm.onceSubmit.value!=1)
	     {
             		document.generalForm.onceSubmit.value=1
        		document.body.style.cursor="wait"
			//document.generalForm.target="_top"
			document.generalForm.action="../Misc/ezWelcome.jsp"
			document.generalForm.submit();
	      } 
	}
</script>
</head>
<body>
<form name="generalForm">
<table height=100% width=100% valign=middle cellPadding=0 cellSpacing=0>
	<tr>
		<td rowspan=2 align=center class=blankcell>
<%
			if(exp.indexOf("time")!=-1)
			{
%>				<img border=0 src="../../Images/timeout.gif">
<%			}
			else
			{
%>				<img border=0 src="../../Images/lock.gif">
<%			}
%>
		</td>
		<td align=center class=displayheader>
			Order:<%=webOrNo%><br><%=exp%>
		</td>
	</tr>
	<tr>
		<td align=center class=blankcell>
<%			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();
			buttonName.add("Ok");
			buttonMethod.add("ezBack()");
			out.println(getButtonStr(buttonName,buttonMethod));
%>		</td>
	</tr>
</table>
<input type="hidden" name="onceSubmit" value=0>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
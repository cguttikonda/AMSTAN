<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<html>
<head>
	<title>Resons-- Powered By EzCommerce(India) Ltd</title>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
	<Script>
		var tabHeadWidth=96
		var tabHeight="65%"
	</Script>
	<script src="../../Library/JavaScript/ezTrim.js"></script>
	<script src="../../Library/JavaScript/ezTabScroll.js"></Script>

</head>
<body>
<form name="myForm">
<br>
<%
		String Reasons = request.getParameter("Reason");
%>


	<table  align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
		<tr><th>Reasons </th></tr>
		<tr>
			<td align="center">
				<Textarea rows="10" cols="35" class=txarea name="reasons" readonly><%=Reasons%></Textarea>
			</td>
		</tr>
	</table>
<br>
<Div id="EzButtonDiv" align=center style="position:absolute;top:90%;visibility:visible;width:100%">
<%
		  	 butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");  
			 butActions.add("history.go(-1)");
		    	 out.println(getButtons(butNames,butActions));
		  
  %>
			
		</Div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>

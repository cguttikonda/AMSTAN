
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%
	String urlByRole=" ";
	String role=(String)session.getValue("UserRole");
	int banWidth=0;
	if ("LF".equals(role))
	{
		urlByRole="ezSalesLFMenu.jsp";
		banWidth=22;
	}
	else if("CM".equals(role))
	{
	       urlByRole="ezSalesCMALLMenu.jsp";
		banWidth=22;
	}
	else if("BP".equals(role))
	{ 
		urlByRole="ezSalesBPMenu.jsp";
		banWidth=20;
	}
	else
	{
		//urlByRole="ezSalesCUContractMenu.jsp";
		urlByRole="ezSalesCUMenu.jsp";
		banWidth=18;			
	}
%>
<html>
<head>
<title>Welcome to EzCommerce Customer Portal</title>
</head>
<frameset rows="25,*" cols="*" border="0" framespacing="0"  marginheight=0 margintop=0> 
  <frame src="<%=urlByRole%>" scrolling="no" name="menu" frameborder="NO" marginwidth="0"  marginheight=0 margintop=0>
  <frame src="../Inbox/ezListPersMsgs.jsp" scrolling="auto" name="display" frameborder="NO" marginwidth="0"  marginheight=0 margintop=0>
</frameset>
<noframes> 
<body bgcolor="#FFFFFF">
</body>
</noframes> 
<Div id="MenuSol"></Div>
</html>

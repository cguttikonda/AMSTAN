
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%
	String redirectfile=null;
	String userType=(String)session.getValue("UserType");
	if(userType !=null)
	{
		if(userType.equals("3"))
			//redirectfile = "ezSelectAgent.jsp";
			redirectfile = "ezSelectSoldToFrameset.jsp";
		else if(userType.equals("2"))

			redirectfile = "ezSelectSoldToFrameset.jsp";
		else
			 redirectfile = "invalidArea.jsp";
	}

	else		
			 redirectfile = "invalidArea.jsp";
			 
		response.sendRedirect(redirectfile);
%>
<script>
alert(<%=redirectfile%>)
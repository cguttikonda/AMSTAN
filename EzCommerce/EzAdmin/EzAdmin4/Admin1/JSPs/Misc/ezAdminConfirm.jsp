
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iAdminConfirm.jsp"%>
<jsp:useBean id="UManager" class="ezc.client.EzUserAdminManager" scope="session" />
<%
	EzDefReturn defReturn = Session.isValidAdminUser();
	boolean validAdmin = defReturn.isValidAdminUser();

	if (logonstatus.IsSuccess()) 
 	{
		if (validAdmin)
		{
			String userStyle=null;
			if(Session.getUserPreference("STYLE")!=null)
				userStyle=(String)Session.getUserPreference("STYLE");
			session.putValue("userStyle",userStyle);
			session.putValue("ConnGroup",ConnGroup);
			response.sendRedirect("ezMenuFrameSet.jsp"); 		
		}
	 	else
 		{
 			response.sendRedirect("ezLoginError.jsp");
	 	}
 	}
 	else
 	{
 		response.sendRedirect("ezLoginError.jsp");
 	}
%>
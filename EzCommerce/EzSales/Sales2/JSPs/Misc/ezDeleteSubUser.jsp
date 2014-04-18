<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%@ page import = "ezc.ezparam.*,ezc.ezmisc.params.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="MiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"></jsp:useBean>
<%
	String values[] = request.getParameter("BusinessUser").split("¥");
	
	String userId = values[0];
	boolean check = true;
	
	if(userId!=null && !"null".equals(userId) && !"".equals(userId))
	{
		userId = userId.trim();
		
		EziMiscParams miscParams = new EziMiscParams();
		EzcParams miscMainParams = new EzcParams(true);

		miscParams.setQuery("DELETE FROM EZC_USERS WHERE EU_ID='"+userId+"'");
		miscMainParams.setObject(miscParams);
		miscMainParams.setLocalStore("Y");

		Session.prepareParams(miscMainParams);
		
		try
		{
			MiscManager.ezDelete(miscMainParams);
		}
		catch(Exception e)
		{
			check = false;
		}
		
		if(check)
		{
			miscParams.setQuery("DELETE FROM EZC_USER_DEFAULTS WHERE EUD_USER_ID='"+userId+"'");

			try
			{
				MiscManager.ezDelete(miscMainParams);
			}
			catch(Exception e)
			{
				check = false;
			}

			if(check)
			{
				miscParams.setQuery("DELETE FROM EZC_USER_AUTH WHERE EUA_USER_ID='"+userId+"'");
				MiscManager.ezDelete(miscMainParams);
			}
		}
	}
	
	response.sendRedirect("ezListSubUsers.jsp");
%>

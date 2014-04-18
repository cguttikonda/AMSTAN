<%@ page import="java.util.*" %>
<%@ include file="../../../Includes/Lib/InboxBean.jsp"%>
<%@ include file="../../../Includes/JSPs/Inbox/iSelectUsers.jsp" %>
<%
	String userId = request.getParameter("userId");
	userId = userId.toUpperCase();
	ArrayList all       = new ArrayList();
	ArrayList finalList = new ArrayList();
	if(userId.indexOf(",")>0)
	{
		StringTokenizer st = new StringTokenizer(userId,",");
		while(st.hasMoreTokens())
		{
			all.add(""+st.nextToken());
			
		}
	}
	else
	{
		all.add(""+userId);
	}
	for(int i=0;i<all.size();i++)
	{
		if(!selectUsers.containsKey(all.get(i)))
		{
			finalList.add((""+all.get(i)).trim());
		}
	}
	out.print("£");
	for(int i=0;i<finalList.size();i++)
	{
		if(i==0)
			out.print((""+finalList.get(i)).trim());
		else
			out.print((","+finalList.get(i)).trim());
	}	
	out.print("¥"+finalList.size());
%>	
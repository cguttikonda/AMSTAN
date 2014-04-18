<%
	String URL=request.getParameter("URL");
	java.util.StringTokenizer st =new java.util.StringTokenizer(URL,"¥");
	String newUrl="";
	while(st.hasMoreTokens())
	{
		newUrl = newUrl.trim();
		newUrl+=(String)st.nextToken()+"&";
		
		
	}
	newUrl = newUrl.substring(0,newUrl.length()-1);
	out.println(newUrl);

%>
<%--<jsp:forward page="<%=newUrl%>"></jsp:forward>--%>
<%
	for(int i=65;i<91;i++)
	{
		char alpha = (char)i;
		if(alphaTree.contains(""+alpha))		
		{
%>
			&nbsp;<a href = "JavaScript:ezAlphabet('<%=alpha%>')"><font color = "red"><%=alpha%></font></a>&nbsp;
<%
		}
		else
		{
%>		
			&nbsp;<%=alpha%>&nbsp;			
<%
		}
	}
	if(alphaTree.size()>0)
	{	
%>
		&nbsp;<a href = "JavaScript:ezAlphabet('All')"><font color = "red">All</font></a>&nbsp;
<%
	}
	else
	{
%>
		&nbsp;All
<%
	}
%>
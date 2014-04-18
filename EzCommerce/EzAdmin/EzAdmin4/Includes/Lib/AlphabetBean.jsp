	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
	<Tr>
	<td align = "center">
<%
	String myAreaLabel = areaLabel.substring(0,areaLabel.length()-1);
	for(int i=65;i<91;i++)
	{
		char alpha = (char)i;
		if(alphaTree.contains(""+alpha))		
		{
%>
			&nbsp;<a href = "JavaScript:ezAlphabet('<%=alpha%>','<%=myAreaLabel%>')"><font color = "red"><%=alpha%></font></a>&nbsp;
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
		&nbsp;<a href = "JavaScript:ezAlphabet('All','<%=myAreaLabel%>')"><font color = "red">All</font></a>&nbsp;
<%
	}
	else
	{
%>
		&nbsp;All
<%
	}
%>
		</Td>
	</Tr>
	</Table>


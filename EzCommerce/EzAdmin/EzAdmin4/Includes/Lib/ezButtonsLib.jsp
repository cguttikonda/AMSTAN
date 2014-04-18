<%@ include file = "../../../Library/Styles/Theme1.css"%>
<%
	String ButtonDir = (String)session.getValue("userStyle");
	if(("BROWN").equals(ButtonDir))
		{         
		session.putValue("Header","#818181");
		session.putValue("Body","#F3EDD8");
		}			
           else
           	{
		session.putValue("Header","#336699");
		session.putValue("Body","#E1EBF4");
		}
%>
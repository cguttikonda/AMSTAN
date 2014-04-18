<%@page import="java.util.*"%>

	
<%
	String inboxPath="";

	ResourceBundle site=null;
	try
	{
		site= ResourceBundle.getBundle("Site");
		inboxPath=site.getString("UPLOADDIR");
		//inboxPath=inboxpath.replace('\\','/');
	}
	catch(Exception e)
	{ 
	    System.out.println("Got Exception while getting Upload Temp Dir "+e);	
	}
	
%>	
	
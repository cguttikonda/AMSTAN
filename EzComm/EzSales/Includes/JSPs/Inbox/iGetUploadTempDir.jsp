<%@page import="java.util.*"%>
<%
	String inboxPath	= "";
	ResourceBundle site	= null;
	try
	{
		site	  = ResourceBundle.getBundle("Site");
		inboxPath = site.getString("INBOXPATH");
	}
	catch(Exception e)
	{ 
	    System.out.println("Got Exception while getting Upload Temp Dir "+e);	
	}
	
	String uploadTempDir="";
	String uploadFilePathDir="";

	
	try
	{
		uploadTempDir	  = site.getString("UPLOADTEMPDIR");
		uploadFilePathDir = site.getString("UPLOADFILEPATHDIR");
		uploadFilePathDir = uploadFilePathDir.replace('\\','/');
	}
	catch(Exception e)
	{ 
	    System.out.println("Got Exception while getting Upload Temp Dir "+e);	
	}		
	
%>	
	
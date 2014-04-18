<%@page import="java.util.*"%>
<%
	String uploadTempDir="";
	String uploadFilePathDir="";

	ResourceBundle site=null;
	try
	{
		site		  = ResourceBundle.getBundle("Site");
		uploadTempDir	  = site.getString("UPLOADTEMPDIR");
		uploadFilePathDir = site.getString("UPLOADFILEPATHDIR");

		uploadFilePathDir = uploadFilePathDir.replace('\\','/');
	}
	catch(Exception e)
	{ 
	    System.out.println("Got Exception while getting Upload Temp Dir "+e);	
	}
%>
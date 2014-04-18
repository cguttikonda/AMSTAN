<%@page import="java.util.*"%>

	
<%
	String uploadTempDir="";
	String uploadFilePathDir="";

	ResourceBundle site=null;
	try
	{
		site= ResourceBundle.getBundle("Site");
		uploadTempDir=site.getString("UPLOADTEMPDIR");
		uploadFilePathDir=site.getString("UPLOADFILEPATHDIR");

		uploadFilePathDir=uploadFilePathDir.replace('\\','/');
		
		//out.println(uploadFilePathDir);
		//commented by suresh 
	}
	catch(Exception e)
	{ 
	    System.out.println("Got Exception while getting Upload Temp Dir "+e);	
	}
	
%>	
	
<%@ page import="java.util.*"%>
<%
	String uploadDir="";
	ResourceBundle site=null;
	try
	{
		site= ResourceBundle.getBundle("Site");
		uploadDir=site.getString("UPLOADDIR");
	}
	catch(Exception e)
	{
	    System.out.println("Got Exception while getting Upload Temp Dir "+e);
	}
%>

<%@page import="java.util.*"%>

	
<%
	String imagePath	= "";
	ResourceBundle site	= null;
	try
	{
		site	    = ResourceBundle.getBundle("Site");
		imagePath   = "E:\\WEBSTORE\\CatalogImages\\";//site.getString("IMAGEPATH");
	}
	catch(Exception e)
	{ 
	    System.out.println("Got Exception while getting Upload imagePath Dir "+e);	  
	}
	
%>	
	
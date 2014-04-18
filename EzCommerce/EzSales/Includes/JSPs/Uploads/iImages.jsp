<%@page import="java.util.*"%>
<%@page import="java.io.*"%>

<%
	String imagePath	= "";
	ResourceBundle site	= null;
	String[] fileList 	= null;    
	try
	{
		site	    = ResourceBundle.getBundle("Site");
		imagePath   = site.getString("IMAGEPATH");
		java.io.File f = new java.io.File(imagePath+"\\"); 
		fileList = f.list();
	}
	catch(Exception e)
	{ 
	    System.out.println("Got Exception while getting Upload imagePath Dir "+e);	
	}
	
		
	Hashtable files = new Hashtable();
	if(fileList!=null)
	{
		for(int l=0;l<fileList.length;l++)
		{
			if(fileList[l]!=null)
			{
				//fileList[l] = fileList[l].substring(0,fileList[l].lastIndexOf('.'));
				files.put((fileList[l].substring(0,fileList[l].lastIndexOf('.'))).toUpperCase(),fileList[l]);
			}
		}
	}	

%>

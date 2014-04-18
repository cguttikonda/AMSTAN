<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ page import="java.util.Enumeration,javax.servlet.*,javax.servlet.http.*,java.io.*" %>
<%@ page import="ezc.ezupload.MultipartRequest" %>
<%@page import="java.util.*"%>
<%@ include file="../../../Includes/JSPs/Uploads/iImagePath.jsp"%>   

<%
	 		
	
	String filename="";  
    	try
    	{
       		File f=null;
	        File f1=new File(imagePath);
        	if((f1.exists()) && (f1.isFile()))
         	{
	        }
         	else
         	{
          		boolean dir=f1.mkdir();
	  		System.out.println("directory created:"+dir);
	 	}
       		String dirName=f1.getPath();

         	MultipartRequest multi = new MultipartRequest(request, dirName, 10*1024*1024);
         	Enumeration params = multi.getParameterNames();
        	while (params.hasMoreElements())
        	{
           		String name = (String)params.nextElement();
           		String value = multi.getParameter(name);
	        }
        	Enumeration files = multi.getFileNames();

	        while (files.hasMoreElements())
        	{
           		String name = (String)files.nextElement();
           		filename = multi.getFilesystemName(name);
           		
           		String type = multi.getContentType(name);
          		f = multi.getFile(name); 
        	}
	//     response.sendRedirect("ezAttachment.jsp?fname="+f1.getName());
    	}
    	catch(Exception e)
    	{
      		out.println("Error while reading file : "+e);
    	}
    	//out.println("filenamefilename>>"+filename);
    	//out.println("uploadTempDir  "+uploadTempDir);
	//out.println("uploadFilePathDir  "+uploadFilePathDir);
	response.sendRedirect("ezBulkAfterAttach.jsp?filename="+filename);
%>
<Div id="MenuSol"></Div>	
	
	
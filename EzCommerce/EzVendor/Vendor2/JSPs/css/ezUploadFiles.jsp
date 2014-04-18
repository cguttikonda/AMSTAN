<%@ page import="java.util.Enumeration,javax.servlet.*,javax.servlet.http.*,java.io.*" %>
<%@ page import="ezc.ezupload.MultipartRequest" %>

<%
	String  sessionId=request.getParameter("sessionId");
	//out.println(sessionId);
	
	String inboxPath="";

	ResourceBundle site=null;
	try
	{
		site= ResourceBundle.getBundle("Site");
		inboxPath=site.getString("UPLOADTEMPDIR");
		//inboxPath=inboxpath.replace('\\','/');
	}
	catch(Exception e)
	{ 
	    System.out.println("Got Exception while getting Upload Temp Dir "+e);	
	}
	
	
	String filename="";
    	try
    	{
       		File f=null;
	        
	        File f1=new File(inboxPath+sessionId);
	        
	        
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
    	}
    	catch(Exception e)
    	{
      		System.out.println("Error while reading file : "+e);
    	}
    	//out.println("uploadTempDir  "+uploadTempDir);
	//out.println("uploadFilePathDir  "+uploadFilePathDir);
	//session.removeAttribute("bulletinNo");
	response.sendRedirect("ezAfterAttach.jsp?filename="+filename);

%>

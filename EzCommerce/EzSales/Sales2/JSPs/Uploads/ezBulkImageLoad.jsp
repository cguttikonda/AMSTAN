<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ page import="java.util.Enumeration,javax.servlet.*,javax.servlet.http.*,java.io.*" %>
<%@ page import="ezc.ezupload.MultipartRequest" %>
<%@page import="java.util.*"%>
<%@ include file="../../../Includes/JSPs/Uploads/iImagePath.jsp"%>   
<%
	String attachtype        = request.getParameter("type");
	String prdCode     = request.getParameter("prdCode");
	String vendCatalog = request.getParameter("vendCatalog");
	String matId       = request.getParameter("matId"); 

	String filename="";  
	String dirName="";
	String folderPath="";
    	try
    	{
       		long timeInMilli = Calendar.getInstance().getTimeInMillis();
       		File f=null;
       		
       		folderPath = session.getId()+timeInMilli;
       		
	        File f1=new File(imagePath+folderPath);
	        
	        if(!((f1.exists()) && (f1.isDirectory()))) 
                {
         	   boolean dir=f1.mkdir();
         	   
	        }
	       
	        dirName=f1.getPath();

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
      		out.println("Error while reading file : "+e); 
    	}
    	
    	
    	response.sendRedirect("ezBulkAfterAttach.jsp?filename="+filename+"&dirName="+folderPath+"&type="+attachtype+"&prdCode="+prdCode+"&vendCatalog="+vendCatalog+"&matId="+matId);
%>
<Div id="MenuSol"></Div> 	
	
	
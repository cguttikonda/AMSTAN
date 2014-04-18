<%@ page import="java.util.Enumeration" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.io.*" %>
<%@ page import="ezc.ezupload.MultipartRequest" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%!  String dirName=""; %>
<%
   	String user= Session.getUserId();
    	dirName = "C:\\MailApp\\"+user;
    	File dir = new File(dirName);
    	boolean x = dir.mkdirs();

    	try 
      	{
		MultipartRequest multi = new MultipartRequest(request, dirName, 10*1024*1024); 
       		Enumeration params = multi.getParameterNames();
        	while (params.hasMoreElements()) 
        	{
           		String name = (String)params.nextElement();
           		String value = multi.getParameter(name);
           		out.println(name + " = " + value);
        	}
        	Enumeration files = multi.getFileNames();
        	while (files.hasMoreElements()) 
        	{
        	   	String name = (String)files.nextElement();
           		String filename = multi.getFilesystemName(name);
           		String type = multi.getContentType(name);
           		File f = multi.getFile(name);
        	}
      		response.sendRedirect("ezSendAttachmentFrame.jsp");
    	}
    	catch (IOException IEx) 
    	{
      		out.println("Exception is"+IEx);
    	}
%>
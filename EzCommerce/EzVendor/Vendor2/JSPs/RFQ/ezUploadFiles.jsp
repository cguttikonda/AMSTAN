<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ page import="java.util.Enumeration,javax.servlet.*,javax.servlet.http.*,java.io.*" %>
<%@ page import="ezc.ezupload.MultipartRequest" %>
<%@ include file="../../../Includes/Jsps/Inbox/iGetUploadTempDir.jsp"%>
<%
	String filename	= "";
	double length = 0.0f;
	File f	= null;
	boolean flg = false;
    	try
    	{
       		
       		File f1	= new File(inboxPath+session.getId());
        	if((f1.exists()) && (f1.isFile()))
         	{
	        }
         	else
         	{
          		boolean dir	= f1.mkdir();
	  		System.out.println("directory created:"+dir);
	 	}
       		String dirName	= f1.getPath();
         	MultipartRequest multi = new MultipartRequest(request, dirName, 10*1024*1024);
         	Enumeration params = multi.getParameterNames();
        	while (params.hasMoreElements())
        	{
           		String name 	= (String)params.nextElement();
           		String value 	= multi.getParameter(name);
	        }
        	Enumeration files = multi.getFileNames();

	        while (files.hasMoreElements())
        	{
           		String name = (String)files.nextElement();
           		filename += multi.getFilesystemName(name);
           		String type = multi.getContentType(name);
          		f = multi.getFile(name);
          		        		
          		length = (double)f.length();
          		if(f.length() <= 3145728)
          		{
          			flg  = true;
          		}
         	}
	//     response.sendRedirect("ezAttachment.jsp?fname="+f1.getName());
    	}
    	catch(Exception e)
    	{
      		System.out.println("Error while reading file : "+e);
    	}
 
    	
    	if(flg)
    	{
		response.sendRedirect("ezAfterAttach.jsp?filename="+filename);
	}	
	else
	{
%>	
		<html>
		<head>
		<title>
			Message
		</title>
		<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
		</head>
		<br>
		<br>
		<br>
		<table width="90%" align="center" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1>
		  <tr align="center">
		    <th align="center">Attachment Not Possible<Br>File Exceeded 3MB</th>
		  </tr>
		</table>
		<br><br>
		<center>
<%
		    butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Close&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
		    butActions.add("window.close()");
		    out.println(getButtons(butNames,butActions));
%>
		</center>
		</body>
		</html>
<%		

	}
%>

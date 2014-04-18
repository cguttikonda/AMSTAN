<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ page import="java.util.Enumeration,javax.servlet.*,javax.servlet.http.*,java.io.*" %>
<%@ page import="ezc.ezupload.MultipartRequest" %>
<%@ include file="../../../Includes/JSPs/Inbox/iGetUploadTempDir.jsp"%>
<%
	String attachedFilesStr = "";//(String)session.getValue("ATTACHFILES");
	String filePath = request.getParameter("filepath");
	String actType = request.getParameter("actType");
	String filename	= "";
	double length = 0.0f;
	File f	= null;
	boolean flg = false;
	String value ="";
    	try
    	{
       		
       		File f1	= new File(inboxPath+session.getId());
       		out.println("f1::"+f1);
        	if((f1.exists()) && (f1.isFile()))
         	{
	        }
         	else
         	{
          		boolean dir	= f1.mkdir();
          		System.out.println("directory :"+f1);
	  		System.out.println("directory created:"+dir);
	 	}
       		String dirName	= f1.getPath();
         	MultipartRequest multi = new MultipartRequest(request, dirName, 10*1024*1024);
         	out.println("attchdFiles::"+(String)multi.getParameter("attchdFiles"));
         	attachedFilesStr = (String)multi.getParameter("attchdFiles");
         	
         	Enumeration params = multi.getParameterNames();
        	while (params.hasMoreElements())
        	{
           		String name 	= (String)params.nextElement();
           		value 	= multi.getParameter(name);
	        }
        	Enumeration files = multi.getFileNames();

	        while (files.hasMoreElements())
        	{
           		String name = (String)files.nextElement();
           		
           		filename += multi.getFilesystemName(name);
           		String type = multi.getContentType(name);
          		f = multi.getFile(name);
          		length = (double)f.length();
          		if(f.length() <= 6291456)
          		{
          			flg  = true;
          		}
         	}
	   //  response.sendRedirect("ezAttachment.jsp?fname="+f1.getName());
    	}
    	catch(Exception e)
    	{
      		System.out.println("Error while reading file : "+e);
    	}
 
    	
    	if(flg)
    	{
		String sessKey = "ATTACHFILES";

		if(attachedFilesStr!=null)
    		{
    			attachedFilesStr = attachedFilesStr+"$$"+filename;
    			session.putValue(sessKey,attachedFilesStr);
    		}
    		else
    		{
    			session.putValue(sessKey,filename);
    			attachedFilesStr = filename;
    		}	
    		
		response.sendRedirect("ezAttachFile.jsp?filename="+filename+"&filepath="+value+"&attacheddFiles="+attachedFilesStr+"&actType="+actType);
	}	
	else
	{
%>	
		<html>
		<head>
		
		<title>
			Message
		</title>
		<%@ include file="../../../Includes/Lib/ezCommonHead.jsp"%>
		</head>
		<br>
		<br>
		<br>
		<table width="90%" align="center" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1>
		  <tr align="center">
		    <th align="center">Attachment Not Possible<Br>File Exceeded 6MB</th>
		  </tr>
		</table>
		<br><br>
		<center>
		<button type="button" onClick="javascript:window.close()" class="button btn-update"><span>Close</span></button>
		</center>
		</body>
		</html>
<%		

	}
%>

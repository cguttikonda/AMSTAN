<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ page import="java.util.Enumeration,javax.servlet.*,javax.servlet.http.*,java.io.*" %>
<%@ page import="ezc.ezupload.MultipartRequest" %>
<%@ include file="../../../Includes/JSPs/Inbox/iGetUploadTempDir.jsp"%>
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
           		filename = multi.getFilesystemName(name);
           		String type = multi.getContentType(name);
          		f = multi.getFile(name);
          		
			if(f.length() <= 3145728)
			{
				flg  = true ;
          		}
        	}
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
			<title>File Attachment Status -- Powered By Answerthink India Pvt Ltd.</title>
			<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
		</head>
		<br><br><br>
		<Table width="90%" align="center" border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0>
			<Tr align="center">
				<Th align="center">Attachment Not Possible<Br>File Exceeded 3MB</Th>
			</Tr>
		</Table>
		<br><br>
		<center>
		<%
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();
			buttonName.add("Close");
			buttonMethod.add("window.close()");
				
			out.println(getButtonStr(buttonName,buttonMethod));	
		%>
		</center>
		<Div id="MenuSol"></Div>
		</body>
		</html>
<%		

	}
%>



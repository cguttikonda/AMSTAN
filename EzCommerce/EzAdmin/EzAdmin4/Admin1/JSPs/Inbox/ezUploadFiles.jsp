<%@ page import="java.util.Enumeration,javax.servlet.*,javax.servlet.http.*,java.io.*" %>
<%@ page import="ezc.ezupload.MultipartRequest" %>
<%@ page import="java.util.*" %>

<%
	try
	{
		ResourceBundle rb=ResourceBundle.getBundle("Site");
		String path=rb.getString("INBOXPATH");
		File upFile=null;
		File dirFile=new File(path+session.getId());

		String[] attachedList=request.getParameterValues("attachList");
		String attachedFiles="";

		if(attachedList != null)
		{
			if(attachedList.length > 0)
				attachedFiles = "&attachedFiles="+attachedList[0];
			for(int i=1;i<attachedList.length;i++)
			{
				attachedFiles += "&attachedFiles="+attachedList[i];
			}
		}

		if(!((dirFile.exists()) && (dirFile.isDirectory())))
		{
			boolean dir=dirFile.mkdirs();
		}
		String dirName=dirFile.getPath();

		MultipartRequest multi = new MultipartRequest(request, dirName, 10*1024*1024);
		java.util.Enumeration files = multi.getFileNames();
		if(files.hasMoreElements())
		{
			String name = (String)files.nextElement();
			upFile = multi.getFile(name);
		}

		String fname=upFile.getName();


		response.sendRedirect("ezAttachment.jsp?attachedFiles="+fname+""+attachedFiles);
	}
	catch(Exception e)
	{
		out.println("Error while reading file : "+e);
	}
%>

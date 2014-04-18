<%@ page import="java.io.*"%>
<%@ include file="../../../Includes/Jsps/Inbox/iGetUploadTempDir.jsp"%>
<%
	String s = inboxPath+session.getId()+"\\"+request.getParameter("filePath");
	File file = new File(s);
	String s3 = file.getName();
	s3 = s3.substring(s3.indexOf("_") + 1, s3.length());
	response.setContentType("application/x-download");
	response.setHeader("Content-Disposition", "attachment;filename=" + s3);
	FileInputStream fileinputstream = new FileInputStream(file);
	javax.servlet.ServletOutputStream servletoutputstream = response.getOutputStream();
	int i = 256;
	boolean flag = false;
	while(i >= 0)
	{
		i = fileinputstream.read();
		servletoutputstream.write(i);
	}
	servletoutputstream.flush();
	servletoutputstream.close();
	fileinputstream.close();
%>

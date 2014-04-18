<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ page import="java.util.Enumeration,javax.servlet.*,javax.servlet.http.*,java.io.*" %>
<%@ page import="ezc.ezupload.MultipartRequest" %>
<%@ include file="../../../Includes/JSPs/Inbox/iGetUploadTempDir.jsp"%>
<%
	String attachedFilesStr = "";//(String)session.getValue("ATTACHEDFILES");
	String filename	= "";
	double length = 0.0f;
	File f	= null;
	boolean flg = false;
	String value ="";
    	try
    	{
       		File f1	= new File(inboxPath+session.getId());
ezc.ezcommon.EzLog4j.log("dirNamedirName:::::f1"+f1,"D");
        	if(!((f1.exists()) && (f1.isFile())))
         	{
          		boolean dir	= f1.mkdir();
	 	}
ezc.ezcommon.EzLog4j.log("dirNamedirName:::::dir"+f1,"D");
       		String dirName	= f1.getPath();
         	MultipartRequest multi = new MultipartRequest(request, dirName, 10*1024*1024);
ezc.ezcommon.EzLog4j.log("dirNamedirName:::::"+dirName,"D");
         	attachedFilesStr = (String)multi.getParameter("attchdFiles");
ezc.ezcommon.EzLog4j.log("attachedFilesStr:::::"+attachedFilesStr,"D");
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
	}
    	catch(Exception e){}
ezc.ezcommon.EzLog4j.log("flgflgflgflg:::::"+flg,"D");
    	if(flg)
    	{
    		if(attachedFilesStr!=null)
    		{
    			attachedFilesStr = attachedFilesStr+"$$"+filename;
    			session.putValue("ATTACHEDFILES",attachedFilesStr);
    		}
    		else
    		{
    			session.putValue("ATTACHEDFILES",filename);
    			attachedFilesStr = filename;
    		}
    		ezc.ezcommon.EzLog4j.log("attachedFilesStr:::::"+attachedFilesStr,"D");
		out.print(attachedFilesStr);
	}
	else
	{
		out.print("Attachment Not Possible<Br>File Exceeded 6MB");
	}
%>
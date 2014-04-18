<%@ page import="java.util.*,javax.servlet.*,javax.servlet.http.*,ezc.ezbasicutil.*,java.io.*" %>
<%@ page import="ezc.ezupload.MultipartRequest" %>
<%@ page import="ezc.ezparam.*" %>
<%@ page import="ezc.ezparam.ReturnObjFromRetrieve" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>

<%@ include file="../../../Includes/Lib/ezSalesCatalog.jsp"%>
<%@ include file="../../../Includes/JSPs/Inbox/iGetUploadTempDir.jsp"%>
<%@ include file="iValidateProcessFileByStatus.jsp"%> 

<%@page import="org.apache.poi.hssf.usermodel.HSSFCell"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFRow"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFSheet"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>

<%@page import="org.apache.poi.xssf.usermodel.XSSFSheet"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFWorkbook"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFRow"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFCell"%>

<%
	String filename	= "";
	double length 	= 0.0f;
	File file	= null; 
	boolean flag     = true;
	
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
		//out.println("dirName:::"+dirName);
		MultipartRequest multi = new MultipartRequest(request, dirName, 10*1024*1024);
		//out.println("multi::"+multi);
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
			file = multi.getFile(name);

			if(file.length() >= 3670016)  
			{
			   flag  = false ;
			}

		}
	}
	catch(Exception r)
	{
		out.println(r);
	}  
	
	String value1="";
	
	if (filename != null && !filename.equals("")) 
	{
		try{
			FileInputStream ExcelFileToRead =new FileInputStream(inboxPath+session.getId()+"\\"+filename);
			XSSFWorkbook  wb = new XSSFWorkbook(ExcelFileToRead);
			XSSFWorkbook test = new XSSFWorkbook(); 
			XSSFSheet sheet = wb.getSheetAt(0);
			XSSFRow row; 
			XSSFCell cell;
			int rows  = sheet.getPhysicalNumberOfRows();
			for (int r = 0; r < rows; r++)
			{
				for(int j=0;j<6;j++)
				{
					HSSFRow row   = sheet.getRow(r);
					HSSFCell cell1  = row.getCell((short)j);
					value1 = cell1.getStringCellValue();
					out.println(value1);
				}
			}
		}
		catch(Exception r)
		{
			out.println(r);
		}  
	}
%>
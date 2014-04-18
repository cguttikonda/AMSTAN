<%@ page import="java.util.*,javax.servlet.*,javax.servlet.http.*,ezc.ezbasicutil.*,java.io.*" %>
<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<%@ include file="../../../Includes/Lib/AdminCatalog.jsp"%>
<%@ page import="ezc.ezupload.MultipartRequest" %>
<%@ include file="../../../Includes/Jsps/Inbox/iGetUploadTempDir.jsp"%>

<%
	String filename	= "";
	double length 	= 0.0f;
	File file	= null;
	boolean flg     = false;
	int rowCount    = 0;
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
          		file = multi.getFile(name);
			if(file.length() <= 3145728)
			{
				flg  = true ;
          		}
        	}
    	}
    	catch(Exception r)
    	{
    	}
    	
    	
    	EzExcelDriver driver = new EzExcelDriver();
    	
    	   	
    	String rFields[] =new String[]{"Product Code",
					"Product Description",
					"Manufacturer",
					"List Price",
					"Status",
					"Family",
					"UPC",
					"Type",
					"Color",
					"Size",
					"Length",
					"Width",
					"UOM",
					"Finish",
					"Specification1",
					"Specification2",
					"Specification3",
					"Specification4"};
    	
    	try{
    		java.util.Date data = new java.util.Date();
    		out.println("====>"+data.getHours()+":"+data.getMinutes()+":"+data.getSeconds());
    		ReturnObjFromRetrieve retObj = (ReturnObjFromRetrieve)driver.readFromExcel(file,rFields);
    		ReturnObjFromRetrieve dataObj = (ReturnObjFromRetrieve)retObj.getFieldValue(0,"DATA_OBJ");
    		
    		System.out.println("========>"+dataObj.toEzcString());
    		
    		java.util.Date data1 = new java.util.Date();
    		out.println("====>"+data1.getHours()+":"+data1.getMinutes()+":"+data1.getSeconds());
    		
    	}catch(Exception err){
    		out.println("======>"+err);
    	}
    	
    	
    	
%>


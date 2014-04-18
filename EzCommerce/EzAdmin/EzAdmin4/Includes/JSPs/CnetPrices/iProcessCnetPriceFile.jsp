<%@ page import="java.util.*,javax.servlet.*,javax.servlet.http.*,ezc.ezbasicutil.*,java.io.*" %>
<%@ page import="ezc.ezupload.MultipartRequest" %>

<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<%@ include file="../../../Includes/Lib/AdminCatalog.jsp"%>
<%@ include file="../../../Includes/JSPs/Inbox/iGetUploadTempDir.jsp"%>
<%@ include file="../../../Includes/JSPs/Catalog/iValidateProcessFile.jsp"%>

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
          		
          		if(file.length() >= 3670016)
			{
			   flag  = false ;
          		}
			
        	}
    	}
    	catch(Exception r)
    	{
    	}
    	
    	
    	EzExcelDriver driver = new EzExcelDriver();
	    	
	    	   	
	String rFields[] =new String[]{"CNET ID",
					"CNET MFR Name",
					"CNET MFR PN",
					"MSRP"};
					
	ReturnObjFromRetrieve retObj = null;
	ReturnObjFromRetrieve dataObj1 = null;
	ReturnObjFromRetrieve errorObj = null;
	
	int dataObj1Count = 0;
	int dataObjCount = 0;
	
	
	try{
		retObj = (ReturnObjFromRetrieve)driver.readFromExcel(file,rFields);
		dataObj1 = (ReturnObjFromRetrieve)retObj.getFieldValue(0,"DATA_OBJ");
		errorObj = (ReturnObjFromRetrieve)retObj.getFieldValue(0,"ERROR_OBJ");
		
		if(dataObj1!=null)
		    dataObj1Count=dataObj1.getRowCount();

	}catch(Exception err){
		
    	}  	
    	
    	/********************** Validation Method **********************/
    	
    	
	ReturnObjFromRetrieve retObj1 = null;
	ReturnObjFromRetrieve dataObj = null;
	ReturnObjFromRetrieve errorObj1 = null;
	int errObjCount=0;

    	
    	
    if(dataObj1!=null && dataObj1.getRowCount()>0)
    {
    
    	Hashtable validateHT = new Hashtable();
	
	validateHT.put("CNET ID","L¥40");
	validateHT.put("CNET MFR Name","L¥225");
	validateHT.put("CNET MFR PN","L¥40");
	validateHT.put("MSRP","N¥19");
		
		
		
	retObj1 = (ReturnObjFromRetrieve)validateExcel(dataObj1,validateHT,rFields);
	dataObj = (ReturnObjFromRetrieve)retObj1.getFieldValue(0,"DATA_OBJ");
	
	
	
	errorObj1 = (ReturnObjFromRetrieve)retObj1.getFieldValue(0,"ERROR_OBJ");
	
	session.putValue("retObj1",retObj1); 

        if(errorObj1!=null)
                 errObjCount=errorObj1.getRowCount();
                 
         
        if(dataObj!=null){
		dataObjCount = dataObj.getRowCount();
	}
	
     }
	
    	/***************************************************************/
    	
    	
    	
%>



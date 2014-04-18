<%@ page import="java.util.*,javax.servlet.*,javax.servlet.http.*,ezc.ezbasicutil.*,java.io.*" %>
<%@ page import="ezc.ezupload.MultipartRequest" %>

<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<%@ include file="../../../Includes/Lib/AdminCatalog.jsp"%>
<%@ include file="../../../Includes/JSPs/Inbox/iGetUploadTempDir.jsp"%>
<%@ include file="iValidateProcessFile.jsp"%>

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
	    	
	    	   	
	String rFields[] =new String[]{"Product Code",
					"Product Description",
					"Manufacturer",
					"List Price",
					"Image Path",
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
    	
    	ReturnObjFromRetrieve retcat = null;
	int retCatCount =0;
	String cat_num=null;
	
	EzCatalogParams catalogParams = new EzCatalogParams();
	Session.prepareParams(catalogParams);
	catalogParams.setLanguage("EN");
	retcat = (ReturnObjFromRetrieve)catalogObj.getCatalogList(catalogParams);
	retcat.check();
	
		
	if(retcat!=null){
		retCatCount= retcat.getRowCount();
	}    	
    	
    	/********************** Validation Method **********************/
    	
    	
	ReturnObjFromRetrieve retObj1 = null;
	ReturnObjFromRetrieve dataObj = null;
	ReturnObjFromRetrieve errorObj1 = null;
	int errObjCount=0;

    	
    	
    if(dataObj1!=null && dataObj1.getRowCount()>0)
    {
    
    	Hashtable validateHT = new Hashtable();
	
	validateHT.put("Product Code","ML¥18");
	validateHT.put("Product Description","ML¥60");
	validateHT.put("Manufacturer","ML¥40");
	validateHT.put("List Price","N¥11");
	validateHT.put("Image Path","L¥220");
	validateHT.put("Status","L¥30");
	validateHT.put("Family","L¥30");
	validateHT.put("UPC","L¥18");
	validateHT.put("Type","L¥30");
	validateHT.put("Color","L¥30");
	validateHT.put("Size","L¥10");
	validateHT.put("Length","L¥10");
	validateHT.put("Width","L¥10");
	validateHT.put("UOM","ML¥3");
	validateHT.put("Finish","L¥30");
	validateHT.put("Specification1","L¥120");
	validateHT.put("Specification2","L¥120");
	validateHT.put("Specification3","L¥120");
	validateHT.put("Specification4","L¥120");
		
		
		
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



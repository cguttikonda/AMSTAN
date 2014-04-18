<%@ page import="java.util.*,javax.servlet.*,javax.servlet.http.*,ezc.ezbasicutil.*,java.io.*" %>
<%@ page import="ezc.ezupload.MultipartRequest" %>

<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<%@ include file="../../../Includes/Lib/AdminCatalog.jsp"%>
<%@ include file="../../../Includes/JSPs/Inbox/iGetUploadTempDir.jsp"%>
<%@ include file="iValidateProcessFileByStatus.jsp"%> 

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
					"Specification4",
					"Future Price",
					"Effective Date",
					"Weight",
					"Weight UOM",
					"Lead Time",
					"Operation"};
					
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
    
    	Hashtable addValHT = new Hashtable();
    	Hashtable maiValHT = new Hashtable();
    	Hashtable delValHT = new Hashtable();
	
	addValHT.put("Product Code","ML¥18");
	addValHT.put("Product Description","ML¥60");
	addValHT.put("Manufacturer","ML¥40");
	addValHT.put("List Price","N¥11");
	addValHT.put("Image Path","L¥220");
	addValHT.put("Status","L¥30");
	addValHT.put("Family","L¥30");
	addValHT.put("UPC","L¥18");
	addValHT.put("Type","L¥30");
	addValHT.put("Color","L¥30");
	addValHT.put("Size","L¥10");
	addValHT.put("Length","L¥10");
	addValHT.put("Width","L¥10");
	addValHT.put("UOM","ML¥3");
	addValHT.put("Finish","L¥30");
	addValHT.put("Specification1","L¥120");
	addValHT.put("Specification2","L¥120");
	addValHT.put("Specification3","L¥120");
	addValHT.put("Specification4","L¥120");
	addValHT.put("Future Price","N¥11");
	addValHT.put("Effective Date","L¥10");
	addValHT.put("Weight","N¥5");
	addValHT.put("Weight UOM","L¥2");
	addValHT.put("Lead Time","N¥5");
	addValHT.put("Operation","ML¥1");


	maiValHT.put("Product Code","ML¥18");
	maiValHT.put("Product Description","L¥60");
	maiValHT.put("Manufacturer","L¥40");
	maiValHT.put("List Price","N¥11");
	maiValHT.put("Image Path","L¥220");
	maiValHT.put("Status","L¥30");
	maiValHT.put("Family","L¥30");
	maiValHT.put("UPC","L¥18");
	maiValHT.put("Type","L¥30");
	maiValHT.put("Color","L¥30");
	maiValHT.put("Size","L¥10");
	maiValHT.put("Length","L¥10");
	maiValHT.put("Width","L¥10");
	maiValHT.put("UOM","L¥3");
	maiValHT.put("Finish","L¥30");
	maiValHT.put("Specification1","L¥120");
	maiValHT.put("Specification2","L¥120");
	maiValHT.put("Specification3","L¥120");
	maiValHT.put("Specification4","L¥120");
	maiValHT.put("Future Price","N¥11");
	maiValHT.put("Effective Date","L¥10");
	maiValHT.put("Weight","N¥5");
	maiValHT.put("Weight UOM","L¥2");
	maiValHT.put("Lead Time","N¥5");
	maiValHT.put("Operation","ML¥1");

	retObj1 = (ReturnObjFromRetrieve)validateExcel(dataObj1,addValHT,maiValHT,rFields);
	dataObj = (ReturnObjFromRetrieve)retObj1.getFieldValue(0,"DATA_OBJ");
	
	
	
	errorObj1 = (ReturnObjFromRetrieve)retObj1.getFieldValue(0,"ERROR_OBJ");
	
	session.putValue("retObj1",retObj1); 

        if(errorObj1!=null)
                 errObjCount=errorObj1.getRowCount();
                 
         
        if(dataObj!=null){
		dataObjCount = dataObj.getRowCount();
		//dataObj.sort(new String[]{"Effective Date"},true);
	}
	
     }
	
    	/***************************************************************/
    	

  
   
   
   
    	
%>



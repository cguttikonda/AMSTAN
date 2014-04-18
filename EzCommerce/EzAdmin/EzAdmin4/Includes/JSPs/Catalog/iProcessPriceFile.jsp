<%@ page import="java.util.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import="ezc.ezbasicutil.*,java.io.*" %>
<%@ page import="ezc.ezupload.MultipartRequest" %>
<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<%@ include file="../../../Includes/Lib/AdminCatalog.jsp"%>
<%@ include file="../../../Includes/JSPs/Inbox/iGetUploadTempDir.jsp"%>
<%@ include file="iValidateProcessFile.jsp"%>

<%
	String filename	= "";
	double length 	= 0.0f;
	File file	= null;
	boolean flag     = false;
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
				flag  = true ;
          		}
        	}
    	}
    	catch(Exception r)
    	{
    	}

	
	EzExcelDriver driver = new EzExcelDriver();
	String rFields[] =new String[]{"Product Code","List Price","Image Path","Spec 1","Spec 2","Spec 3","Spec 4"};
					
	ReturnObjFromRetrieve retObj = null;
	ReturnObjFromRetrieve dataObj1 = null;
	ReturnObjFromRetrieve errorObj = null;

	try{
		retObj   = (ReturnObjFromRetrieve)driver.readFromExcel(file,rFields);
		dataObj1 = (ReturnObjFromRetrieve)retObj.getFieldValue(0,"DATA_OBJ");
		errorObj = (ReturnObjFromRetrieve)retObj.getFieldValue(0,"ERROR_OBJ");
		
		
	}catch(Exception err){
		
    	}  
    	
	/********************** Validation Method **********************/
	    	
	  int errObjCount=0;					
	  int dataObjCount=0;  	
	    	
	  ReturnObjFromRetrieve retObj1 = null;
	  ReturnObjFromRetrieve dataObj = null;
	  ReturnObjFromRetrieve errorObj1 = null;

	  if(dataObj1!=null && dataObj1.getRowCount()>0)
	  {
		Hashtable validateHT = new Hashtable();
		
		validateHT.put("Product Code","M¥18");
		validateHT.put("List Price","N¥9");
		validateHT.put("Image Path","L¥250");
		validateHT.put("Spec 1","L¥250");
		validateHT.put("Spec 2","L¥250");
		validateHT.put("Spec 3","L¥250");
		validateHT.put("Spec 4","L¥250");
				
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
     
     /************* List of catalogs *********************/
     	
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
     
   /****************************************************/
	    	
%>	
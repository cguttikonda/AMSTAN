<%@ page import="java.util.*,javax.servlet.*,javax.servlet.http.*,ezc.ezbasicutil.*,java.io.*" %>
<%@ page import="ezc.ezupload.MultipartRequest" %>

<%@ page import="ezc.ezparam.*" %>
<%@ page import="ezc.ezparam.ReturnObjFromRetrieve" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>

<%@ include file="../../../Includes/Lib/ezSalesCatalog.jsp"%>
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
       		//out.println("f1::"+f1);
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
    	//out.println("filename:::"+filename);
    	//out.println("file:::"+file);
    	EzExcelDriver driver = new EzExcelDriver();	    	
	    	   	
	String rFields[] =new String[]{"Product Code",
					"Quantity",									
					"My PO Line",
					"My SKU","Job Quote","Job Quote Line"};
					
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
    	//out.println("dataObj1:::"+dataObj1.toEzcString());
    	//out.println("errorObj:::"+errorObj.toEzcString());
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
	addValHT.put("Quantity","ML¥15");	
	//addValHT.put("Desired Date","L¥10");
	//addValHT.put("Program Type","ML¥5");
	addValHT.put("My PO Line","L¥18");
	addValHT.put("My SKU","L¥18");
	addValHT.put("Job Quote","N¥18");
	addValHT.put("Job Quote Line","N¥18");
	
	maiValHT.put("Product Code","ML¥18");
	maiValHT.put("Quantity","ML¥15");	
	//maiValHT.put("Desired Date","L¥10");
	//maiValHT.put("Program Type","ML¥5");
	maiValHT.put("My PO Line","L¥18");
	maiValHT.put("My SKU","L¥18");
	maiValHT.put("Job Quote","N¥18");
	maiValHT.put("Job Quote Line","N¥18");

	retObj1 = (ReturnObjFromRetrieve)validateExcel(dataObj1,addValHT,maiValHT,rFields);
	dataObj = (ReturnObjFromRetrieve)retObj1.getFieldValue(0,"DATA_OBJ");
	
	
	
	errorObj1 = (ReturnObjFromRetrieve)retObj1.getFieldValue(0,"ERROR_OBJ");
	
	//out.println("errorObj1::"+errorObj1.toEzcString());
	//out.println("dataObj:::"+dataObj.toEzcString());
	
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



<%@ page import="java.util.*,javax.servlet.*,javax.servlet.http.*,ezc.ezbasicutil.*,java.io.*" %>
<%@ page import="ezc.ezupload.MultipartRequest" %>
<%@ page import="ezc.ezparam.*" %>
<%@ page import="ezc.ezparam.ReturnObjFromRetrieve" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%@ include file="../../../Includes/JSPs/Inbox/iGetUploadTempDir.jsp"%>
<%@ include file="../../../Includes/JSPs/ShoppingCart/iValidateProcessFileByStatus.jsp"%>
<%
	String filename	= "";
	double length 	= 0.0f;
	File file	= null;
	boolean flag    = true;

	try
    	{
       		File f1	= new File(inboxPath+session.getId());
       		//out.println("f1::"+f1);
       		ezc.ezcommon.EzLog4j.log("f1::excel"+f1,"D");
        	if((f1.exists()) && (f1.isFile()))
         	{
	        }
         	else
         	{
			boolean dir	= f1.mkdir();
	 	}
       		String dirName	= f1.getPath();
       		//out.println("dirName:::"+dirName);
       		ezc.ezcommon.EzLog4j.log("dirName::excel"+dirName,"D");
         	MultipartRequest multi = new MultipartRequest(request, dirName, 10*1024*1024);
         	//out.println("multi::"+multi);
         	ezc.ezcommon.EzLog4j.log("multi::excel"+multi,"D");
         	Enumeration params = multi.getParameterNames();
        	while (params.hasMoreElements())
        	{
           		String name 	= (String)params.nextElement();
           		String value 	= multi.getParameter(name);
	        }
        	Enumeration files = multi.getFileNames();
	        while (files.hasMoreElements())
        	{
           		String name 	= (String)files.nextElement();
           		filename 	= multi.getFilesystemName(name);
           		String type 	= multi.getContentType(name);
          		file 		= multi.getFile(name);

          		if(file.length() >= 3670016)  
			{
				flag  	= false;
          		}
        	}
    	}
    	catch(Exception r)
    	{
    		out.println(r);
    		ezc.ezcommon.EzLog4j.log("r::excel"+r,"D");
    	}    	
    	//out.println("filename:::"+filename);
    	//out.println("file:::"+file);
	ezc.ezcommon.EzLog4j.log("file::excel"+file,"D");

    	EzExcelDriver driver = new EzExcelDriver();	    	
	    	   	
	String rFields[] =new String[]{"Customer"};

	ReturnObjFromRetrieve retObj = null;
	ReturnObjFromRetrieve dataObj1 = null;
	ReturnObjFromRetrieve errorObj = null;

	int dataObj1Count = 0;
	int dataObjCount = 0;

	try
	{
		retObj 		= (ReturnObjFromRetrieve)driver.readFromExcel(file,rFields);
		dataObj1 	= (ReturnObjFromRetrieve)retObj.getFieldValue(0,"DATA_OBJ");
		errorObj 	= (ReturnObjFromRetrieve)retObj.getFieldValue(0,"ERROR_OBJ");

		if(dataObj1!=null)
			dataObj1Count=dataObj1.getRowCount();
	}
	catch(Exception err){}

    	//out.println("dataObj1:::"+dataObj1.toEzcString());
    	//out.println("errorObj:::"+errorObj.toEzcString());
	ezc.ezcommon.EzLog4j.log("dataObj1::excel"+dataObj1.toEzcString(),"D");

    	/********************** Validation Method **********************/

	ReturnObjFromRetrieve retObj1 = null;
	ReturnObjFromRetrieve dataObj = null;
	ReturnObjFromRetrieve errorObj1 = null;
	int errObjCount=0;    	

	if(dataObj1!=null && dataObj1.getRowCount()>0)
	{
		Hashtable addValHT = new Hashtable();
		Hashtable maiValHT = new Hashtable();

		addValHT.put("Product Code","N¥1");
		maiValHT.put("Product Code","N¥1");

		retObj1 = (ReturnObjFromRetrieve)validateExcel(dataObj1,addValHT,maiValHT,rFields);
		dataObj = (ReturnObjFromRetrieve)retObj1.getFieldValue(0,"DATA_OBJ");
		errorObj1 = (ReturnObjFromRetrieve)retObj1.getFieldValue(0,"ERROR_OBJ");

		//out.println("errorObj1::"+errorObj1.toEzcString());
		//out.println("dataObj:::"+dataObj.toEzcString());

		//session.putValue("retObj1",retObj1); 

		if(errorObj1!=null)
			 errObjCount = errorObj1.getRowCount();

		if(dataObj!=null)
			dataObjCount = dataObj.getRowCount();
	}
	ezc.ezcommon.EzLog4j.log("dataObj::excel"+dataObj.toEzcString(),"D");

	String buffer = "<Table class='data-table' id='custTable' style=' height:300px; overflow:auto; display:block;'>";
	buffer = buffer+"<Tr><Th class='a-center' width='10%'>Select All<br><input type='checkbox' name='CheckBox1' value='' onclick='selectAll()'></Th>";
	buffer = buffer+"<Th nowrap width='40%'><strong> Allowed Sold To Account(s) <em style='color:red'>*</em></strong></th>";
	buffer = buffer+"<Th nowrap width='50%'><strong> Allowed Ship To Account(s) <em style='color:red'>*</em></strong></th></Tr>";

	response.getWriter().println(buffer);

    	/***************************************************************/
%>
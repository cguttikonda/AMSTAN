<%@ page import="ezc.ezparam.ReturnObjFromRetrieve,ezc.ezbasicutil.EzExcelDriver" %>
<%@ page import="java.util.*" buffer="512kb" autoFlush="true" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%
        
        EzExcelDriver driver = new EzExcelDriver();
        
        ReturnObjFromRetrieve rowsRetObj=null;
        ReturnObjFromRetrieve dataObj1 = null;
	ReturnObjFromRetrieve errorObj1 = null;
	
        
        rowsRetObj=(ReturnObjFromRetrieve)session.getValue("retObj1");
          
        dataObj1 = (ReturnObjFromRetrieve)rowsRetObj.getFieldValue(0,"DATA_OBJ");
	errorObj1 = (ReturnObjFromRetrieve)rowsRetObj.getFieldValue(0,"ERROR_OBJ");

        
        ArrayList myLabels 	= new ArrayList();
     	ArrayList sMHead1 	= new ArrayList();
    	
	ArrayList myLabelsArr[] = new ArrayList[1];
	ArrayList mHead[] 	= new ArrayList[1];
	
	
	myLabels.add("Service Type");
	myLabels.add("Zone");
	myLabels.add("Country Code");
	myLabels.add("Pack Type");
	myLabels.add("Weight");
	myLabels.add("Price");
	myLabels.add("Key");
	
	
	myLabelsArr[0]	= myLabels;
	
	sMHead1.add("Error Data");
	mHead[0] = sMHead1;
	
    	ReturnObjFromRetrieve retArr[] = new ReturnObjFromRetrieve[1];
	retArr[0] = errorObj1;
	
	try
    	{
    	  driver.ezCreateExcel(response,"Error.xls",retArr,myLabelsArr,mHead,false);
    	}
    	catch(Exception e){  
    	  System.out.println("Exception occured while writing data to excel"+e);
    	}
    	
%>
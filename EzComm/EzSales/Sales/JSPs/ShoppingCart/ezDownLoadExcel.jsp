<%@ page import="ezc.ezparam.ReturnObjFromRetrieve,ezc.ezbasicutil.EzExcelDriver" %>
<%@ page import="java.util.*" buffer="512kb" autoFlush="false" %>
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

	myLabels.add("Product Code");
	myLabels.add("Quantity");
	//myLabels.add("Desired Date");
	//myLabels.add("Program Type");
	myLabels.add("My PO Line");
	myLabels.add("My SKU");
	myLabels.add("Job Quote");
	myLabels.add("Job Quote Line");

	myLabelsArr[0]	= myLabels;

	sMHead1.add("");
	mHead[0] = sMHead1;

	ReturnObjFromRetrieve retArr[] = new ReturnObjFromRetrieve[1];
	retArr[0] = errorObj1;

	try
	{
		driver.ezCreateExcel(response,"ErrorData.xls",retArr,myLabelsArr,mHead,false);
	}
	catch(Exception e){  
		System.out.println("Exception occured while writing data to excel"+e);
	}
    	
%>
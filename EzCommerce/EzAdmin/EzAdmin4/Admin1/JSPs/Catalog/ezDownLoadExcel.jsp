<%@ page import="ezc.ezparam.ReturnObjFromRetrieve,ezc.ezbasicutil.EzExcelDriver" %>
<%@ page import="java.util.*" buffer="512kb" autoFlush="true" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%
        
        String from = request.getParameter("from");
        
        if(from==null || "null".equals(from))
        	from="";
        
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
	
	
	if("MAINTAIN".equals(from)){
	    myLabels.add("Product Code");
	    myLabels.add("List Price");
	    myLabels.add("Image Path");
	}
	else{
	    myLabels.add("Product Code");
	    myLabels.add("Product Description");
	    myLabels.add("Manufacturer");
	    myLabels.add("List Price");
	    myLabels.add("Image Path");
	    myLabels.add("Status");
	    myLabels.add("Family");
	    myLabels.add("UPC");
	    myLabels.add("Type");
	    myLabels.add("Color");
	    myLabels.add("Size");
	    myLabels.add("Length");
	    myLabels.add("Width");
	    myLabels.add("UOM");
	    myLabels.add("Finish");
	    myLabels.add("Specification1");
	    myLabels.add("Specification2");
	    myLabels.add("Specification3");
	    myLabels.add("Specification4");
        }
	
	
	myLabelsArr[0]	= myLabels;
	
	sMHead1.add("Error Data");
	mHead[0] = sMHead1;
	
    	ReturnObjFromRetrieve retArr[] = new ReturnObjFromRetrieve[1];
	retArr[0] = errorObj1;
	
	try
    	{
    	  driver.ezCreateExcel(response,"Product.xls",retArr,myLabelsArr,mHead,false);
    	}
    	catch(Exception e){  
    	  System.out.println("Exception occured while writing data to excel"+e);
    	}
    	
%>
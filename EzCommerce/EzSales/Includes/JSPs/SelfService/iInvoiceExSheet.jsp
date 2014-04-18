<%@ page import="ezc.ezparam.ReturnObjFromRetrieve,ezc.ezbasicutil.EzExcelDriver" %>
<%@ page import="java.util.Vector" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%

		String filename			= request.getParameter("fname");			
		EzExcelDriver ed		= null;
		ReturnObjFromRetrieve retObj	= null;
		String result			= null;
		String xfilename		= "";
		
		filename	= (filename==null)?"InvoicesList":filename;
		xfilename	= filename.trim()+".xls";
		retObj		= (ReturnObjFromRetrieve)session.getValue("InvoiceReturnObject");

		if(retObj!=null)
		{
			Vector columns=new Vector();
			columns.add("BILLINGDOCUMENTNO");
			columns.add("SAPINVOICENO");
			if(filename.startsWith("Open",0))
				columns.add("DELIVERYDOCUMENTNO");
			columns.add("INVOICEDATE");
			if(filename.startsWith("Open",0))
				columns.add("DUEDATE");
			columns.add("INVOICEVALUE");
			ed=new EzExcelDriver();
		try{
			result=ed.ezCreateExcel(xfilename.trim(),"Sheet1",response,retObj,columns);
		}catch(Exception e){
			System.out.println(">?>?>?>?>Exception:"+e.getMessage());}
		}
%>

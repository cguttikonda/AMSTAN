
<%@ page import="ezc.ezparam.*,java.util.*"%>
%@ include file="../../../Includes/JSPs/DrillDownCatalog/iFullCatalog.jsp"%>
<%
	out.println("<?xml version=\"1.0\"?>");		
	out.println("<tree id='"+id+"'>");
	
	String child ="1";
	
	//level	= "3";
	/*
	if("0".equals(id))
	{
		if(retStockReportCount>0)
			out.println("<item child='1' open='1' id='"+Session.getUserId()+"�"+userRole+"' text='"+Session.getUserId()+"' im0='book.gif' im1='books_open.gif' im2='books_close.gif'>");
		else
			out.println("<item child='0' open='1' id='NODATA' text='No Data Found'>");
	}*/	
	for (int i=0; i<retCount;i++)
	{
		child 		= "1";
		String Parti	= ret.getFieldValueString(i,PROD_GROUP_DESC);
		String level1	= ret.getFieldValueString(i,PROD_GROUP_LEVEL);
		String grpNum1	= (String)ret.getFieldValue(i,PROD_GROUP_NUMBER);
		String finalVal	= ret.getFieldValueString(i,"EPG_TERMINAL_FLAG");
		
		if(level1!=null)
			level1 = level1.trim();
		if("0".equals(id))			
		{
			if(!"1".equals(level1) )
				continue;
		}
		if("Y".equals(finalVal)) 
			child= "0";

		//System.out.println(Parti+"-->"+level1+"-->"+grpNum1+"-->"+finalVal);

		out.println("<item child='"+child+"' id='"+level1+"$$"+grpNum1+"$$"+Parti+"$$"+CatalogDescription+"' text='"+Parti+"' im0='book.gif' im1='books_open.gif' im2='books_close.gif'></item>");
		//System.out.println("<item child='"+child+"' id='"+level1+"$$"+grpNum1+"' text='"+Parti+"' im0='book.gif' im1='books_open.gif' im2='books_close.gif'></item>");
	}
	out.println("</tree>");
%>

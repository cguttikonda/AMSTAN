<%@ page import="ezc.ezparam.*,java.util.*"%>
<%@ include file="../../../Includes/JSPs/Misc/iBlockControl.jsp"%>
<%@ include file="../../../Includes/JSPs/DrillDownCatalog/iFullCatalog.jsp"%>
<%
	
	
	out.println("<?xml version=\"1.0\"?>");		
	out.println("<tree id='"+id+"'>");
	
	String child ="0";
	
	catChk	= "";epgNo="";Parti="";level1="";grpNum1="";finalVal="";
	for (int i=0; i<retCount;i++)
	{
		child	= "0";
		epgNo	= ret.getFieldValueString(i,"EPG_NO").trim();
		Parti	= ret.getFieldValueString(i,"EPGD_WEB_DESC");
		level1	= ret.getFieldValueString(i,"EPG_GROUP_LEVEL");
		grpNum1	= ret.getFieldValueString(i,"EPG_NO");
		finalVal= ret.getFieldValueString(i,"EPG_TERMINAL_FLAG");
		
		if("0".equals(id))
		{
			catChk	= ret.getFieldValueString(i,"ISCHECKED");
			if("N".equals(catChk))
				continue;
			if(!"1".equals(level1) )
				continue;
				
			if(childVector.contains(epgNo))	
				child= "1";
							
		}
		else
		{
			if("Y".equals(finalVal))
				child= "0";
			else
				child= "1";	
		} 
		if(level1!=null)
			level1 = level1.trim();
		
		out.println("<item child='"+child+"' id='"+level1+"$$"+grpNum1+"$$"+Parti+"$$"+CatalogDescription+"' text='"+Parti+"' im0='book.gif' im1='books_open.gif' im2='books_close.gif'></item>");
	}
	out.println("</tree>");
%>

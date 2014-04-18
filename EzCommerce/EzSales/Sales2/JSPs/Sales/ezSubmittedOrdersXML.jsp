<%@ page import="ezc.ezparam.*,ezc.ezsap.*,ezc.client.*"%>
<%@ page import= "ezc.ezutil.FormatDate,java.util.*,java.text.*" %>
<%@ include file="../../../Includes/JSPs/Lables/iListSalesOrder_Lables.jsp"%>
<%@ include file="../../../Includes/JSPs/Sales/iListSalesOrders.jsp"%>   
<%@ include file="../../../Includes/Lib/ezGlobalBean.jsp"%>
<%!
	public static String replaceChar(String s,char c)
	{
		StringBuffer r = new StringBuffer(s.length()+4);
		r.setLength(s.length()+4);
		int current = 0;
		for(int i=0;i<s.length();i++)
		{
			char cur=s.charAt(i);
			if(cur==c)
			{
				r.setCharAt(current++,cur);
				r.setCharAt(current++,'a');
				r.setCharAt(current++,'m');
				r.setCharAt(current++,'p');
				r.setCharAt(current++,';');
			}
			else
			{
				r.setCharAt(current++,cur); 
			}
		}
		return r.toString();
	}

%>
<%

	out.println("<?xml version=\"1.0\"?>");		
	out.println("<rows>");

	String backEndOrderNo=null;
	String forkey 	= (String)session.getValue("formatKey"); 		
	if(forkey==null) forkey="/";
			
	Set set = new HashSet();
	int count1=retobj.getRowCount();

	
	if ((retobj!=null)&&(count1> 0))
	{

		String sortField[]={"BACKEND_ORNO"};
		retobj.sort(sortField,false);
	}
		
	
	if(count1>0)
	{
		Vector types = new Vector();
		types.addElement("date");
		types.addElement("date");
		EzGlobal.setColTypes(types);

		Vector names = new Vector();
		names.addElement("ORDER_DATE");
		names.addElement("STATUS_DATE");
		EzGlobal.setColNames(names);
		
		ezc.ezparam.ReturnObjFromRetrieve ret = EzGlobal.getGlobal(retobj);  
		
		
		String wdateString=null;
		String lfdateString=null;
		Hashtable myValues= new Hashtable();

		int wl=0;
		int lf=0;
		for(int rCount=0;rCount<count1;rCount++)
		{

			backEndOrderNo=retobj.getFieldValueString(rCount,"BACKEND_ORNO");
			backEndOrderNo=("null".equals(backEndOrderNo))?"N/A": backEndOrderNo;
			wdateString=ret.getFieldValueString(rCount,"ORDER_DATE");
			lfdateString=ret.getFieldValueString(rCount,"STATUS_DATE");


			wl=wdateString.indexOf(" ");
			lf=lfdateString.indexOf(" ");


			wdateString=(wl==-1)?ret.getFieldValueString(rCount,"ORDER_DATE"):" ";
			lfdateString=(lf==-1)?ret.getFieldValueString(rCount,"STATUS_DATE"):" ";
			
			wdateString = wdateString.replace('.','/');

			String anchBegin="";
			String soldtoWeb = retobj.getFieldValueString(rCount,"WEB_ORNO");
			String soldtocode =retobj.getFieldValueString(rCount,"SOLD_TO_CODE");
			String soldtoarea=retobj.getFieldValueString(rCount,"SYSKEY");
			String retSatus = retobj.getFieldValueString(rCount,"STATUS");
			String backEndOrNo =retobj.getFieldValueString(rCount,"BACKEND_ORNO");
			String tempBackEndOrNo="";
			String soldToCodeTemp = soldtocode;
			
			
			try{
				tempBackEndOrNo = Long.parseLong(backEndOrNo)+"";
			}
			catch(Exception e){}
			
			if(retSatus!=null && retSatus.equals("NEW"))
			{
				retSatus = "Saved";
			}
			else
			{
				retSatus = "Accepted";
			}
			orderStatus =orderStatus.toUpperCase();
			String cuname= retobj.getFieldValueString(rCount,"SOTO_ADDR1");
			String createdBy =retobj.getFieldValueString(rCount,"CREATEDBY");
			String ponoName=retobj.getFieldValueString(rCount,"PO_NO");
			cuname = replaceChar(cuname,'&');
			createdBy = replaceChar(createdBy,'&');
			ponoName = replaceChar(ponoName,'&');
 
			if(set.add(soldtoWeb)) 
			{
				anchBegin="<a href=\"JavaScript:funShowDetails('" + soldtoWeb + "','"+soldtocode+"','"+soldtoarea+"')\" style=\"cursor:hand\"  >";
				soldtoWeb = replaceChar(soldtoWeb,'&');
				soldToCodeTemp = replaceChar(soldToCodeTemp,'&');
				
				
				out.println("<row id='"+ backEndOrNo +","+soldToCodeTemp+","+soldtoarea+"'><cell><![CDATA[<nobr><a href=\"JavaScript:funShowDetails1('"+soldtocode+"','../Sales/ezBackWaitSalesDisplay.jsp?SONumber="+backEndOrNo+"&amp;status=S&amp;pageUrl=BackOrder&amp;PODATE=&amp;orderType=Open&amp;netValue=')\" >"+tempBackEndOrNo+"</a></nobr>]]></cell><cell>"+wdateString+"</cell><cell>"+ponoName+"</cell><cell>"+createdBy+"</cell><cell>"+cuname+"</cell></row>");	
			} 	
		}
	}else
	{
		out.println("<row id='"+count1+"'></row>");
	}
	out.println("</rows>");
%>	
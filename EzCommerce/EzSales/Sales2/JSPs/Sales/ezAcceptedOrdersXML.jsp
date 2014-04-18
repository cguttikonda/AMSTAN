<%
	response.setContentType("text/xml");
	out.println("<?xml version=\"1.0\" encoding=\"ISO-8859-1\" ?>");	
	out.println("<rows>");
%>
<%@ page import="ezc.ezparam.*"%>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%@ include file="../../../Includes/JSPs/Sales/iAcceptedOrdersXML.jsp"%>
<%@ page import = "ezc.ezutil.FormatDate,java.util.*" %>
<%!
	public static String replaceChar(String s,char c)
	{
		StringBuffer r = new StringBuffer(s.length());
		r.setLength(s.length());
		int current = 0;
		for(int i=0;i<s.length();i++)
		{
			char cur=s.charAt(i);
			if(cur==c)
			{
				r.setLength(s.length()+4);
				//r.setCharAt(current++,cur);
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
	String roleBO	=(String)session.getValue("UserRole");

	String refDocType1 = request.getParameter("RefDocType");
	String forkey 	= (String)session.getValue("formatKey");
	ezc.ezutil.FormatDate formatDate = new ezc.ezutil.FormatDate();

	if(forkey==null) forkey="/";
	System.out.println("refDocType1  "+refDocType1);
	int LrowCount=orderList.getRowCount();
	//out.println("<?xml version=\"1.0\"?>");		
	//out.println("<rows>");

	
	int p = 0;
	if(cnt >0)
	{
		for(int i=0;i<LrowCount;i++)
		{
			p++;
			String tempsoNumber = "";
			String soNumber	= orderList.getFieldValueString(i,"SdDoc");
			String soCust 	= orderList.getFieldValueString(i,"SoldTo");
			String netValue	= orderList.getFieldValueString(i,"NetValHd");
			String cuname	= orderList.getFieldValueString(i,"Name");
			String DocDate 	= ret.getFieldValueString(i,"DocDate");
			StringTokenizer st1 = new StringTokenizer(DocDate,"/");
			String[] docsplit = new String[3];
			int h=0;
			while(st1.hasMoreTokens())
			{
				docsplit[h]=st1.nextToken();
				h++;
			}			
			java.util.Date dDate = new java.util.Date(Integer.parseInt(docsplit[2])-1900,Integer.parseInt(docsplit[0])-1,Integer.parseInt(docsplit[1]));
			DocDate = formatDate.getStringFromDate(dDate,forkey,formatDate.MMDDYYYY);				
			String podate=ret.getFieldValueString(i,"ValidFrom");
			
			/*
			if(podate!=null && podate.indexOf(".")>0)
			{
				StringTokenizer st2 = new StringTokenizer(podate,".");
				String[] fromsplit = new String[3];
				int h1=0;
				while(st2.hasMoreTokens())
				{
					fromsplit[h1]=st2.nextToken();
					h1++;
				}
				java.util.Date frDate = new java.util.Date(Integer.parseInt(fromsplit[2])-1900,Integer.parseInt(fromsplit[0])-1,Integer.parseInt(fromsplit[1]));
				podate = formatDate.getStringFromDate(frDate,forkey,formatDate.MMDDYYYY);
				
				podate = ret.getFieldValueString(i,"ValidFrom");
				
			}
			else
			{
				podate ="N/A";
			}
			*/
			
			if(podate!=null)
			{
				podate = ret.getFieldValueString(i,"ValidFrom");
			}
			else
			{
				podate ="N/A";
			}
			
			try{
				tempsoNumber = (Long.parseLong(soNumber))+"";	
			}
			catch(Exception e)
			{	
				tempsoNumber = soNumber;
			}
			cuname=(cuname == null || "null".equals(cuname))?"":cuname;
			cuname=cuname.trim();
			if((cuname==null)||(cuname=="null")||(cuname.trim().length() == 0))cuname ="N/A";
			if(cuname.length()>24)
			{
				cuname = cuname.substring(0,23)+"..";
				
			}
			cuname = replaceChar(cuname,'&');
			cuname=cuname.trim();
			if((cuname==null)||(cuname=="null")||(cuname.trim().length() == 0))cuname ="N/A";
			String pono = orderList.getFieldValueString(i,"PurchNo");
			if((podate==null)||(podate=="null")||(podate.trim().length() == 0))
			{
				podate ="N/A";
			}
			if((tempsoNumber==null)||(tempsoNumber=="null")||(tempsoNumber.trim().length() == 0))
			{
				podate ="N/A";
			}
			if((soNumber==null)||(soNumber=="null")||(soNumber.trim().length() == 0))
			{
				soNumber ="N/A";
			}
			
		
			if((pono==null)||(pono=="null")||(pono.trim().length() == 0))
			{
				pono ="N/A";
			}
			if((netValue==null)||(netValue=="null")||(netValue.trim().length() == 0))
			{
				netValue ="N/A";
			}
			if((DocDate==null)||(DocDate=="null")||(DocDate.trim().length() == 0))
			{
					DocDate ="N/A";
			}
			String anchBegin ="";
			if((pono == null)||(pono.trim().length() == 0))
			{
				pono ="N/A";
				anchBegin ="<a href=\"JavaScript:funShowDetails('"+soNumber+"','"+fromDate+"','"+toDate+"','"+soCust+"','O','BackOrder','','Open','')\" style=\"cursor:hand\">"; 
				
				if("CU".equals(roleBO))
				{
					out.println("<row id='"+soNumber+"'><cell><![CDATA[<nobr>"+anchBegin+tempsoNumber+"</a></nobr>]]></cell><cell>"+DocDate+"</cell><cell>N/A</cell><cell>"+podate+"</cell><cell>"+netValue+"</cell></row>");
				}
				else
				{
					out.println("<row id='"+soNumber+"'><cell><![CDATA[<nobr>"+anchBegin+tempsoNumber+"</a></nobr>]]></cell><cell>"+DocDate+"</cell><cell>N/A</cell><cell>"+podate+"</cell><cell>"+netValue+"</cell><cell>"+cuname+"</cell></row>");
				}
			}
			else
			{
				anchBegin ="<a href=\"JavaScript:funShowDetails('"+soNumber+"','"+fromDate+"','"+toDate+"','"+soCust+"','O','BackOrder','','Open','')\" style=\"cursor:hand\">"; 
				if("CU".equals(roleBO))
				{
					if(localList.contains(orderList.getFieldValueString(i,"SdDoc").trim()))
					{
						out.println("<row id='"+soNumber+"'><cell><![CDATA[<nobr>"+anchBegin+tempsoNumber+"</a></nobr>]]></cell><cell>"+DocDate+"</cell><cell>"+pono+"</cell><cell>"+podate+"</cell><cell>"+netValue+"</cell></row>");	//<![CDATA[<nobr><a href='../Sales/ezBackWaitSalesDisplay.jsp?Back="+soNumber+"&amp;SoldTo="+soCust+"&amp;status=O&amp;pageUrl=EditBackOrder&amp;PODATE=&amp;orderType=Open'>"+pono+"</a></nobr>]]>
					}
					else
					{
						out.println("<row id='"+soNumber+"'><cell><![CDATA[<nobr>"+anchBegin+tempsoNumber+"</a></nobr>]]></cell><cell>"+DocDate+"</cell><cell>"+pono+"</cell><cell>"+podate+"</cell><cell>"+netValue+"</cell></row>");
					}
				}
				else
				{
					/*if(localList.contains(orderList.getFieldValueString(i,"SdDoc").trim()))
					{
						out.println("<row id='"+soNumber+"'><cell><![CDATA[<nobr>"+anchBegin+tempsoNumber+"</a></nobr>]]></cell><cell>"+DocDate+"</cell><cell>"+pono+"</cell><cell>"+podate+"</cell><cell>"+netValue+"</cell><cell>"+cuname+"</cell></row>");	//<![CDATA[<nobr><a href='../Sales/ezBackWaitSalesDisplay.jsp?Back="+soNumber+"&amp;SoldTo="+soCust+"&amp;status=O&amp;pageUrl=EditBackOrder&amp;PODATE=&amp;orderType=Open'>"+pono+"</a></nobr>]]>
					}
					else
					{*/
						out.println("<row id='"+soNumber+"'><cell><![CDATA[<nobr>"+anchBegin+tempsoNumber+"</a></nobr>]]></cell><cell>"+DocDate+"</cell><cell>"+pono+"</cell><cell>"+podate+"</cell><cell>"+netValue+"</cell><cell>"+cuname+"</cell></row>");
					//}
				}
			}	
		}
	}
	else
	{
		out.println("<row id='"+LrowCount+"'></row>");
	}
	
	out.println("</rows>");
%>

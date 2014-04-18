<%@ include file="../../../Includes/JSPs/Sales/iBackEndSOList.jsp"%>
<%@ page import = "ezc.ezutil.FormatDate,java.util.*" %>
<%
	String id = request.getParameter("id");
	String forkey 	= (String)session.getValue("formatKey");
	session.putValue("docSoldTo",agentCode);
	ezc.ezutil.FormatDate formatDate = new ezc.ezutil.FormatDate();
	if(forkey==null) forkey="/";
	int orderListCount=cnt;

	out.println("<?xml version=\"1.0\"?>");		
	out.println("<tree id='"+id+"'>");

	for(int i=0;i<orderListCount;i++)
	{
		String soNumber=orderList.getFieldValueString(i,"SdDoc");
		//String soCust = orderList.getFieldValueString(i,"SoldTo");
		String podate=ret.getFieldValueString(i,"ValidFrom");
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
		}
		else
		{
			podate ="N/A";
		}
		String pono = orderList.getFieldValueString(i,"PurchNo");
		//out.println("<item child='"+child+"' id='"+soNumber+"¥"+soCust+"' text='"+soNumber+"' im0='book.gif' im1='books_open.gif' im2='books_close.gif'></item>");					
		out.println("<item child='"+"0"+"' id='"+soNumber+"' text='"+soNumber+"' tooltip='PO No:"+pono+" and Order Date:"+podate+"' im0='book.gif' im1='books_open.gif' im2='books_close.gif'></item>");					
	}	
	out.println("</tree>");
%>
<Div id="MenuSol"></Div>
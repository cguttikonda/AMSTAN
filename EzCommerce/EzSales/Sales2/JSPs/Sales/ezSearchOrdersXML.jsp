<%@ include file="ezSearch.jsp"%>
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
	
	if(count1>0)
	{
			
		String wdateString=null;
		String lfdateString=null;
		Hashtable myValues= new Hashtable();

		int wl=0;
		int lf=0;
		for(int rCount=0;rCount<count1;rCount++)
		{

			backEndOrderNo=retobj.getFieldValueString(rCount,"BACKEND_ORNO");
			backEndOrderNo=("null".equals(backEndOrderNo))?"N/A": backEndOrderNo;
			wdateString=retobj.getFieldValueString(rCount,"ORDER_DATE");
			lfdateString=retobj.getFieldValueString(rCount,"STATUS_DATE");


			wl=wdateString.indexOf(" ");
			lf=lfdateString.indexOf(" ");


			wdateString=(wl==-1)?retobj.getFieldValueString(rCount,"ORDER_DATE"):" ";
			lfdateString=(lf==-1)?retobj.getFieldValueString(rCount,"STATUS_DATE"):" ";
			
			wdateString = wdateString.replace('.','/');

			String anchBegin="";
			String soldtoWeb = retobj.getFieldValueString(rCount,"WEB_ORNO");
			String SoNumber = retobj.getFieldValueString(rCount,"BACKEND_ORNO");
			String soldtocode =retobj.getFieldValueString(rCount,"SOLD_TO_CODE");
			String soldtoarea=retobj.getFieldValueString(rCount,"SYSKEY");
			String retSatus = retobj.getFieldValueString(rCount,"STATUS");
			orderStatus =orderStatus.toUpperCase();
			String cuname= retobj.getFieldValueString(rCount,"SOTO_ADDR1");
			cuname = replaceChar(cuname,'&');

			if(set.add(soldtoWeb))
			{
				anchBegin="<a href='../Sales/ezBackWaitSalesDisplay.jsp?Back="+SoNumber+"&amp;SoldTo="+soldtocode+"&amp;status=O&amp;pageUrl=EditBackOrder&amp;PODATE=&amp;orderType=Open' >";
				String anchEnd="";
				
					out.println("<row id='"+ soldtoWeb +","+soldtocode+","+soldtoarea+"'><cell><![CDATA[<nobr><b>"+anchBegin + soldtoWeb +"</a></nobr>]]></cell><cell>"+wdateString+"</cell><cell>"+retobj.getFieldValueString(rCount,"PO_NO")+"</cell><cell>"+retobj.getFieldValueString(rCount,"CREATEDBY")+"</cell><cell>"+cuname+"</cell></row>");
								
			}	
		}
	}else
	{
		out.println("<row id='"+count1+"'></row>");
	}
	out.println("</rows>");
%>
<Div id="MenuSol"></Div>
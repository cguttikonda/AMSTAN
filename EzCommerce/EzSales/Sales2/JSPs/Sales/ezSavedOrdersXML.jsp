<%
	response.setContentType("text/xml");
	out.println("<?xml version=\"1.0\" encoding=\"ISO-8859-1\" ?>");	
	out.println("<rows>");
%>
<%@ page import="ezc.ezparam.*,ezc.ezsap.*,ezc.client.*"%>
<%@ page import= "ezc.ezutil.FormatDate,java.util.*,java.text.*" %>
<%@ include file="../../../Includes/JSPs/Lables/iListSalesOrder_Lables.jsp"%>
<%@ include file="../../../Includes/JSPs/Sales/iListSalesOrders.jsp"%>         
<%@ include file="../../../Includes/Lib/ezGlobalBean.jsp"%>
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

	//out.println("<?xml version=\"1.0\"?>");		
	//out.println("<rows>");
	String backEndOrderNo=null;
	String forkey 	= (String)session.getValue("formatKey");       		
	if(forkey==null) forkey="/";
			
	Set set = new HashSet();
	int count1=retobj.getRowCount();
	
	retobj.sort(new String[]{"WEB_ORNO"},false);
	
	if(count1>0)
	{
		Vector types = new Vector();
		types.addElement("date");
		types.addElement("date");
		types.addElement("date");
		EzGlobal.setColTypes(types);

		Vector names = new Vector();
		names.addElement("ORDER_DATE");
		names.addElement("STATUS_DATE");
		names.addElement("MODIFIEDON");
		EzGlobal.setColNames(names);
		
		ezc.ezparam.ReturnObjFromRetrieve ret = EzGlobal.getGlobal(retobj);  
		
		String wdateString=null;
		String lfdateString=null;
		String modifiedOnStr = null;
		Hashtable myValues= new Hashtable();

		int wl=0;
		int lf=0;
		int mod=0;
		for(int rCount=0;rCount<count1;rCount++)
		{

			backEndOrderNo=retobj.getFieldValueString(rCount,"BACKEND_ORNO");
			backEndOrderNo=("null".equals(backEndOrderNo))?"N/A": backEndOrderNo;
			wdateString=ret.getFieldValueString(rCount,"ORDER_DATE");
			lfdateString=ret.getFieldValueString(rCount,"STATUS_DATE");
			modifiedOnStr =ret.getFieldValueString(rCount,"MODIFIEDON");

			wl=wdateString.indexOf(" ");
			mod=modifiedOnStr.indexOf(" ");
			lf=lfdateString.indexOf(" ");


			wdateString=(wl==-1)?ret.getFieldValueString(rCount,"ORDER_DATE"):" ";			
			modifiedOnStr=(mod==-1)?ret.getFieldValueString(rCount,"MODIFIEDON"):" ";
			lfdateString=(lf==-1)?ret.getFieldValueString(rCount,"STATUS_DATE"):" ";
			
			wdateString = wdateString.replace('.','/');
			modifiedOnStr = modifiedOnStr.replace('.','/');

			String anchBegin="";
			String soldtoWeb = retobj.getFieldValueString(rCount,"WEB_ORNO");
			String soldtocode =retobj.getFieldValueString(rCount,"SOLD_TO_CODE");
			String soldtoarea=retobj.getFieldValueString(rCount,"SYSKEY");
			String retSatus = retobj.getFieldValueString(rCount,"STATUS");
			String backEndOrNo =retobj.getFieldValueString(rCount,"BACKEND_ORNO");
			
			try{
				backEndOrNo = Long.parseLong(backEndOrNo)+"";
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
			String createdBy = retobj.getFieldValueString(rCount,"CREATEDBY");
			cuname = replaceChar(cuname,'&');
			createdBy = replaceChar(createdBy,'&');
			
			

			if(set.add(soldtoWeb))
			{
				anchBegin="<a href=\"JavaScript:funShowEdit('" + soldtoWeb + "','"+soldtocode+"','"+soldtoarea+"')\" style=\"cursor:hand\"  >";
				String anchEnd="";
				if( searchType == null || "null".equals(searchType))
				{
					if(soldtocode.indexOf('&') != -1)
					soldtocode = replaceChar(soldtocode,'&');
					out.println("<row id='"+ soldtoWeb +","+soldtocode+","+soldtoarea+"'><cell></cell><cell><![CDATA[<nobr><b>"+ soldtoWeb +"</b></nobr>]]></cell><cell>"+wdateString+"</cell><cell>"+retobj.getFieldValueString(rCount,"PO_NO")+"</cell><cell>"+createdBy+"</cell><cell>"+cuname+"</cell><cell>"+modifiedOnStr+"</cell></row>");
				}
				else
				{
					anchBegin="<a href=\"JavaScript:funShowDetails('" + soldtoWeb + "','"+soldtocode+"','"+soldtoarea+"')\" style=\"cursor:hand\"  >";
					if(soldtocode.indexOf('&') != -1)
					soldtocode = replaceChar(soldtocode,'&');
					//out.println("<row id='"+ soldtoWeb +","+soldtocode+","+soldtoarea+"'><cell><![CDATA[<nobr><b>"+anchBegin + soldtoWeb +"</a></nobr>]]></cell><cell>"+wdateString+"</cell><cell>"+retobj.getFieldValueString(rCount,"PO_NO")+"</cell><cell>"+createdBy+"</cell><cell>"+backEndOrNo+"</cell><cell>"+retSatus+"</cell></row>");
					out.println("<row id='"+ soldtoWeb +","+soldtocode+","+soldtoarea+"'><cell><![CDATA[<nobr><b>"+anchBegin + backEndOrNo +"</a></nobr>]]></cell><cell>"+wdateString+"</cell><cell>"+retobj.getFieldValueString(rCount,"PO_NO")+"</cell><cell>"+createdBy+"</cell><cell>"+retSatus+"</cell></row>");
				}				
			}	
		}
	}else
	{
		out.println("<row id='"+count1+"'></row>");
	}
	out.println("</rows>");
%>	
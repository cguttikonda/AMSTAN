<%@ page import="ezc.ezparam.*"%>
<%@ page import = "ezc.ezsap.*" %>
<%@ page import = "ezc.client.*" %>
<%@ page import = "ezc.ezutil.FormatDate,java.util.*,java.text.*" %>
<%@ include file="../../../Includes/JSPs/Lables/iListSalesOrder_Lables.jsp"%>
<%@ include file="../../../Includes/JSPs/Sales/iListSalesOrders.jsp"%>
<%@ include file="../../../Includes/Lib/ezGlobalBean.jsp"%>


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
		System.out.println("222222retobj3333333 "+retobj.toEzcString());		
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
			orderStatus =orderStatus.toUpperCase();

			if(set.add(soldtoWeb))
			{
				anchBegin="<a href=\"JavaScript:funShowEdit('" + soldtoWeb + "','"+soldtocode+"','"+soldtoarea+"')\" style=\"cursor:hand\"  >";
				String anchEnd="";
				if( searchType == null || "null".equals(searchType))
				{
					out.println("<row id='"+ soldtoWeb +","+soldtocode+","+soldtoarea+"'><cell></cell><cell><![CDATA[<nobr>"+anchBegin + soldtoWeb +"</a></nobr>]]></cell><cell>"+wdateString+"</cell><cell>"+retobj.getFieldValueString(rCount,"PO_NO")+"</cell><cell>"+retobj.getFieldValueString(rCount,"CREATEDBY")+"</cell><cell>"+retobj.getFieldValueString(rCount,"SOTO_ADDR1")+"</cell></row>");
				}
				else
				{
					out.println("<row id='"+ soldtoWeb +","+soldtocode+","+soldtoarea+"'><cell><![CDATA[<nobr>"+anchBegin + soldtoWeb +"</a></nobr>]]></cell><cell>"+wdateString+"</cell><cell>"+retobj.getFieldValueString(rCount,"PO_NO")+"</cell><cell>"+retobj.getFieldValueString(rCount,"CREATEDBY")+"</cell><cell>"+retobj.getFieldValueString(rCount,"SOTO_ADDR1")+"</cell></row>");
				}				
			}	
		}

					

	}else
	{
		out.println("<row id='"+count1+"'></row>");
	}
	
		
	out.println("</rows>");
	
	
	
%>
<Div id="MenuSol"></Div>
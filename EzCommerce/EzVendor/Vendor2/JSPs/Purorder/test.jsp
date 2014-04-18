<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Purorder/iListAcknowledgedPO.jsp"%>
<%
	ezc.ezutil.FormatDate formatDate = new ezc.ezutil.FormatDate();
	String poNum 	= "";
	String ordDate	= "";
	String ackDate	= "";
	String vendor 	= "";
	String status   = "";
	String createdBy= "";
	String headerTxt= "";
	String shipDate = "";
	String poSysKey	= "";
	
	String purGrp	= "";
	String cCode	= "";	
	java.util.Hashtable  purGroupsHash = (java.util.Hashtable) session.getValue("PURGRPSHASH");//REFFROM: iloginbanner.jsp
	java.util.Hashtable  ccHash	   = (java.util.Hashtable) session.getValue("CCODEHASH");  //REFFROM: iloginbanner.jsp
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
	<%@include file="../Misc/ezDataTableScript.jsp"%>
</head>
<body id="dt_example">
<form name="myForm">
<div id="container">
	<div class="full_width big">
		Blocked Purchase Orders
	</div>
<div id="demo">
<table cellpadding="0" cellspacing="0" border="0" class="display" id="example" width="100%">
<thead>
<%
	if(Count > 0)
	{
		if(orderType.equals("Acknowledged"))
		{
%>
			<tr>
				<th>PO Number</th>
				<th>Created On</th>
				<th>Ship. Date</th>
				<th>Ackn. Date</th>
			</tr>
		
<%
		}

		else if(orderType.equals("NotAcknowledged"))
		{	
			if("PH".equals(userRole) && "ALL".equals(show) )
			{
%>
			<tr>
				<th><input type="checkbox" name="checkAll"></th>
				<th>PO Number</th>
				<th>Pur Group</th>
				<th>Company Code</th>
				<th>Order Date</th>
				<th>Ship Date</th>
				<th>Vendor</th>
			</tr>
			
<%
			}else
			{
%>
			
			<tr>
				<th><input type="checkbox" name="checkAll"></th>
				<th>PO Number</th>
				<th>Order Date</th>
				<th>Ship Date</th>
				<th>Vendor</th>
			</tr>
<%
			}
		}
		else 
		{
%>
			<tr>
				<th><input type="checkbox" name="checkAll"></th>
				<th>PO Number</th>
				<th>Order Date</th>
				<th>Ship Date</th>
				<th>Reason</th>
			</tr>
			
<%
		}
	}
%>
	</thead>
	<tbody>	
<%
	if(Count > 0)
	{
		if(orderType.equals("Acknowledged"))
		{
			for(int i=0;i<Count;i++)
			{
				poNum 	 = ret.getFieldValueString(i,"DOCNO");
				status   = ret.getFieldValueString(i,"DOCSTATUS");
				ordDate  = formatDate.getStringFromDate((java.util.Date)ret.getFieldValue(i,"DOCDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
				ackDate  = formatDate.getStringFromDate((java.util.Date)ret.getFieldValue(i,"MODIFIEDON"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
				if(poHash.get(poNum.trim()) != null)
				{
					formatDate.getStringFromDate((java.util.Date)poHash.get(poNum.trim()),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
				}
				else
					shipDate = "";
				//out.println("<row id='"+poNum+"'><cell><![CDATA[<nobr><a href='ezOpenPoLineitems.jsp?orderType=Open&PurchaseOrder="+poNum+"&amp;status="+status+"'>"+poNum+"</a></nobr>]]></cell><cell>"+ordDate+"</cell><cell>"+shipDate+"</cell><cell>"+ackDate+"</cell></row>");
%>
				<tr>
					<td><%=poNum%></td>
					<td><%=ordDate%></td>
					<td><%=shipDate%></td>
					<td><%=ackDate%></td>
				</tr>
<%
			}
		}
		else if(orderType.equals("NotAcknowledged"))
		{
			for(int i=0;i<Count;i++)
			{
				poNum 	  	= ret.getFieldValueString(i,"DOCNO");
				status  	= ret.getFieldValueString(i,"DOCSTATUS");
				createdBy 	= ret.getFieldValueString(i,"CREATEDBY");
				ordDate 	= formatDate.getStringFromDate((java.util.Date)ret.getFieldValue(i,"DOCDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
				vendor 		= ret.getFieldValueString(i,"EXT1");
				poSysKey = ret.getFieldValueString(i,"DOCSYSKEY");
				
				if(poHash.get(poNum.trim()) != null)
				{
					formatDate.getStringFromDate((java.util.Date)poHash.get(poNum.trim()),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
				}
				else
					shipDate = "";				
					
				if("PH".equals(userRole) && "ALL".equals(show) )
				{
					try
					{
						purGrp 	 = (String)purGroupsHash.get(poSysKey);
						cCode    = (String)ccHash.get(poSysKey) ;
					}
					catch(Exception e)
					{
						purGrp="";
						cCode=""; 
					}
					
					//out.println("<row id='"+poNum+"¥"+vendor+"'><cell><![CDATA[<nobr><input type=checkbox name=chk1 value='"+poNum+"¥"+vendor+"¥"+"A¥"+poSysKey+"'></nobr>]]></cell> <cell><![CDATA[<nobr><a href='ezNewPoLineitems.jsp?PurchaseOrder="+poNum+"&amp;status="+status+"&amp;vendor="+vendor+"&amp;poSysKey="+poSysKey+"&amp;show="+show+"'>"+poNum+"</a></nobr>]]></cell><cell>"+purGrp+"</cell><cell>"+cCode+"</cell><cell>"+ordDate+"</cell><cell>"+shipDate+"</cell> <cell>"+vendor+"</cell></row>");
%>
					<tr>
						<td><%=poNum%></td>
						<td><%=purGrp%></td>
						<td><%=cCode%></td>
						<td><%=ordDate%></td>
						<td><%=shipDate%></td>
						<td><%=vendor%></td>
					</tr>
<%					
				}
				else
				{	
					//out.println("<row id='"+poNum+"¥"+vendor+"'><cell><![CDATA[<nobr><input type=checkbox name=chk1 value='"+poNum+"¥"+vendor+"¥"+"A¥"+poSysKey+"'></nobr>]]></cell><cell><![CDATA[<nobr><a href='ezNewPoLineitems.jsp?PurchaseOrder="+poNum+"&amp;status="+status+"&amp;vendor="+vendor+"'>"+poNum+"</a></nobr>]]></cell><cell>"+ordDate+"</cell><cell>"+shipDate+"</cell><cell>"+vendor+"</cell></row>");
%>
					<tr>
						<td><%=poNum%></td>
						<td><%=ordDate%></td>
						<td><%=shipDate%></td>
						<td><%=vendor%></td>
					</tr>
<%
				}	
			}
		}
		else
		{
			for(int i=0;i<Count;i++)
			{
				poNum 	  	= ret.getFieldValueString(i,"DOCNO");
				status  	= ret.getFieldValueString(i,"DOCSTATUS");
				ordDate 	= formatDate.getStringFromDate((java.util.Date)ret.getFieldValue(i,"DOCDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
				headerTxt	= ret.getFieldValueString(i,"HEADERTEXT");
				vendor 		= ret.getFieldValueString(i,"EXT1");
				if(poHash.get(poNum.trim()) != null)
				{
					formatDate.getStringFromDate((java.util.Date)poHash.get(poNum.trim()),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
				}
				else
				{
					shipDate = "";				
				//out.println("<row id='"+poNum+"¥"+vendor+"'><cell><![CDATA[<nobr><input type=checkbox name=chk1 value='"+poNum+"¥"+vendor+"¥"+"R'></nobr>]]></cell><cell><![CDATA[<nobr><a href='ezBlockedPoLineitems.jsp?PurchaseOrder="+poNum+"&amp;Vendor="+vendor+"&amp;type=R'>"+poNum+"</a></nobr>]]></cell><cell>"+ordDate+"</cell><cell>"+shipDate+"</cell><cell><![CDATA[<nobr><a href=\"javascript:funShowReason('"+headerTxt+"')\">Reason</a></nobr>]]></cell></row>");
%>
					<tr>
						<td><%=poNum%></td>
						<td><%=ordDate%></td>
						<td><%=shipDate%></td>
						<td><a href="">Reason</a></td>
					</tr>
<%
				}
			}
		}
	}
%>
</tbody>
</table>
</div>
<div class="spacer"></div>
</div>
<Div id="MenuSol"></Div>
</form>
</body>
</html>
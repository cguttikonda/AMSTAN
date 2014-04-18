<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Purorder/iListAcknowledgedPO.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
	<%@include file="../Misc/ezDataTableScript.jsp"%>
</head>
<body id="dt_example">
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

%>			<form name="myForm">
			<div id="container">
				<div class="full_width big">
					Blocked Purchase Orders
				</div>
			<div id="demo">
			<table cellpadding="0" cellspacing="0" border="0" class="display" id="example" width="100%">
				<thead>
					<tr>
						<th><input type="checkbox" name="checkAll"></th>
						<th>PO Number</th>
						<th>Order Date</th>
						<th>Ship Date</th>
						<th>Vendor</th>
					</tr>
				</thead>
				<tbody>
<%
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
					<td>check</td>
					<td><%=poNum%></td>
					<td><%=ordDate%></td>
					<td><%=shipDate%></td>
					<td><a href="">Reason</a></td>
				</tr>
<%
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
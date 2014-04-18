<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Purorder/iListAcknowledgedPO.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
	<script>
	function funShowReason(arguments)
	{
	    newWindow = window.showModalDialog("ezShowRejectedPOReasons.jsp",arguments,"center=yes;dialogHeight=26;dialogleft=100;dialogTop=120;dialogWidth=50;help=no;titlebar=no;status=no;resizable=no")
	}
	function checkVal(stat)
	{
		var selectedLength = 0
		var checkObj = document.myForm.chk1
		var reqData = "";
		if(checkObj != null)
		{
			var checkLength = checkObj.length;
			var reqData = "";
			if(isNaN(checkLength))
			{
				if(document.myForm.chk1.checked)
				{
					reqData = document.myForm.chk1.value;
					selectedLength++;
				}	
			}
			else
			{
				for(i=0;i<checkLength;i++)
				{
					if(document.myForm.chk1[i].checked)
					{
						reqData += document.myForm.chk1[i].value+"µ";
						selectedLength++;
					}	
				}
			}	
		}
	
		if(selectedLength == 0)
		{
			if(stat=='NA')
				alert(selPO_L);
			else
				alert(selBlockPO_L);
		}
		else
		{
			document.myForm.poData.value = reqData;
			if(stat=='NA')
				document.myForm.action="ezSendReminders.jsp";
			else if(stat=='REL')
				document.myForm.action="ezReleasePurchaseOrder.jsp";
			else
				document.myForm.action="ezReleaseOrders.jsp";
			setMessageVisible();
			document.myForm.submit();	
		}
		
		
	}
	
	function toggle(source)
		{ 
		    checkboxes = document.getElementsByName('chk1'); 
		    for(i=0;i<checkboxes.length;i++)
		    checkboxes[i].checked = source.checked;
	}
</script>
	<%@include file="../Misc/ezDataTableScript.jsp"%>
</head>
<body id="dt_example" scroll="no">
	<form name="myForm" method="post">

<%	
		String display_header ="";
		if(orderType.equals("Acknowledged"))
		{
			display_header	= "Acknowledged Purchase Orders";
		}
		else if(orderType.equals("NotAcknowledged"))
		{
			display_header	= "To Be Acknowledged Purchase Orders";
		}
		else
		{
			display_header	= "Rejected Purchase Orders";
		}

%>
	<%@ include file="../Misc/ezDisplayHeader.jsp" %>
	<div id="container">
	<div id="demo">
	<table cellpadding="0" cellspacing="0" border="0" class="display" id="example" width="100%">
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

	
		if(orderType.equals("Acknowledged"))
		{
%>
			
			
			
				<thead>
					<tr>
						<th>PO Number</th>
						<th>Created On</th>
						<th>Ship. Date</th>
						<th>Ackn. Date</th>
					</tr>
				</thead>
				<tbody>
<%				
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
						
						<td><%out.print("<a href='ezOpenPoLineitems.jsp?orderType=Open&PurchaseOrder="+poNum+"&amp;status="+status+"'>"+poNum+"</a>");%></td>
						<td><%=ordDate%></td>
						<td><%=shipDate%></td>
						<td><%=ackDate%></td>
						
					</tr>
					
<%
			}
%>
				</tbody>
			
		
<%
		}
		else if(orderType.equals("NotAcknowledged"))
		{
			if("PH".equals(userRole) && "ALL".equals(show) )
			{
%>
			
					<thead>
						<tr>
							<th align="center"><input type="checkbox" name="checkAll"  onClick="javascript :toggle(this)"></th>
							<th>PO Number</th>
							<th>Pur Group</th>
							<th>Company Code</th>
							<th>Order Date</th>
							<th>Ship Date</th>
							<th>Vendor</th>
						</tr>
					</thead>
					<tbody>	
<%
			}
			else
			{
%>

				
					<thead>
						<tr>
							<th align="center"><input type="checkbox" name="checkAll"  onClick="javascript :toggle(this)"></th>
							<th>PO Number</th>
							<th>Order Date</th>
							<th>Ship Date</th>
							<th>Vendor</th>
						</tr>
					</thead>
					<tbody>	
<%
			}
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
								<td align="center"><%out.print("<input type=checkbox name=chk1 value='"+poNum+"¥"+vendor+"¥"+"A¥"+poSysKey+"'>");%></td>
								<td><%out.print("<a href='ezNewPoLineitems.jsp?PurchaseOrder="+poNum+"&amp;status="+status+"&amp;vendor="+vendor+"&amp;poSysKey="+poSysKey+"&amp;show="+show+"'>"+poNum+"</a>");%></td>
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
								<td align="center"><%out.print("<input type=checkbox name=chk1 value='"+poNum+"¥"+vendor+"¥"+"A¥"+poSysKey+"'>");%></td>
								<td><%="<a href='ezNewPoLineitems.jsp?PurchaseOrder="+poNum+"&amp;status="+status+"&amp;vendor="+vendor+"'>"+poNum+"</a>"%></td>
								<td><%=ordDate%></td>
								<td><%=shipDate%></td>
								<td><%=vendor%></td>
							</tr>
					
<%
				}	
			}
%>
					
<%
		}
		else
		{
%>
		
			
				<thead>
					<tr>
						<th><input type="checkbox" name="checkAll"  onClick="javascript :toggle(this)"></th>
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
					<td align="center"><%="<input type=checkbox name=chk1 value='"+poNum+"¥"+vendor+"¥"+"R'>"%></td>
					<td><%="<a href='ezBlockedPoLineitems.jsp?PurchaseOrder="+poNum+"&amp;Vendor="+vendor+"&amp;type=R'>"+poNum+"</a>"%></td>
					<td><%=ordDate%></td>
					<td><%=shipDate%></td>
					<td><%="<a href=\"javascript:funShowReason('"+headerTxt+"')\">Reason</a>"%></td>
				</tr>
<%
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
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		

<%@ include file="../../Library/Globals/errorPagePath.jsp"%>  
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Purorder/iListBlockedPO.jsp"%>
<%@ include file="../../../Includes/JSPs/Labels/iListBlockedPO_Labels.jsp"%>

<%
	boolean hasReleaseAuth = false;
	if(session.getValue("USERAUTHS") != null)
	{
		java.util.Vector authVector = (java.util.Vector)session.getValue("USERAUTHS");
		if(authVector.contains("RELEASE_PO"))
		{
			hasReleaseAuth = true;
		}
		else
		{
			hasReleaseAuth = false;
		}
	}	
	else
	{
		hasReleaseAuth = false;
	}
	
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
	<%@include file="../Misc/ezDataTableScript.jsp"%>
	<script>
	function toggle(source)
	{ 
	    checkboxes = document.getElementsByName('chk1'); 
	    for(i=0;i<checkboxes.length;i++)
	    checkboxes[i].checked = source.checked;
	}
	</script>
	<Script>
		var selBlockedPo_L = '<%=selBlockedPo_L%>'; 
		var releaseAuth = <%=hasReleaseAuth%>;
		function checkVal()
		{ 
			if(releaseAuth)
			{
				var reqData = "";
				var selectedLength = 0
				var checkObj = document.myForm.chk1
				if(checkObj != null)
				{
					var checkLength = checkObj.length;
					if(isNaN(checkLength))
					{
						if(document.myForm.chk1.checked)
						{
							reqData += document.myForm.chk1.value;
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
					alert(selBlockedPo_L)	
				}
				else
				{
					document.myForm.poData.value = reqData;
					setMessageVisible();
					document.myForm.action="ezReleasePurchaseOrder.jsp";
					document.myForm.submit();	
				}
			}	
			else
			{
				alert("You are not authorized for releasing the Purchase Order to the Vendor");
			}
		}
</Script>
</head>
<body id="dt_example" scroll=no>
<form name="myForm">
<%
	String display_header	= "Blocked Purchase Orders";
%>
<%@ include file="../Misc/ezDisplayHeader.jsp" %>
<div id="container">
<div id="demo">
<table cellpadding="0" cellspacing="0" border="0" class="display" id="example" width="100%">
<%

	if("PH".equals(userRole) && "ALL".equals(show) )
	{
%>
	<thead>
		<tr>
			<th><input type="checkbox" name="checkAll" onClick="javascript :toggle(this)" ></th>
			<th>PO Number</th>
			<th>Created On</th>
			<th>Pur. Group</th>
			<th>Company Code</th>
			<th>Blocked Date</th>
			<th>Vendor</th>
		</tr>
	</thead>
<%
	}
	else
	{
%>
	<thead>
		<tr>
			<th><input type="checkbox" name="checkAll" onClick="javascript :toggle(this)" ></th>
			<th>PO Number</th>
			<th>Created On</th>
			<th>Blocked Date</th>
			<th>Vendor</th>
		</tr>
	</thead>
<%
	}
%>
<tbody>	
<%
	ezc.ezutil.FormatDate formatDate = new ezc.ezutil.FormatDate();
	String poNum 	= "";
	String poDate	= "";
	String mdDate	= "";
	String vendor 	= "";
	String poSysKey	= "";
	String purGrp	= "";
	String cCode	= "";
	
	java.util.Hashtable  purGroupsHash = (java.util.Hashtable) session.getValue("PURGRPSHASH");//REFFROM: iloginbanner.jsp
	java.util.Hashtable  ccHash	   = (java.util.Hashtable) session.getValue("CCODEHASH");  //REFFROM: iloginbanner.jsp
	
	//out.println("ret"+ret.toEzcString());

	if(Count > 0)
	{
		for(int i=0;i<Count;i++)
		{
			if(ret.getFieldValueString(i,"DOCSTATUS").equals("B"))	
			{
				poNum 	 = ret.getFieldValueString(i,"DOCNO");
				vendor   = ret.getFieldValueString(i,"EXT1");
				poSysKey = ret.getFieldValueString(i,"DOCSYSKEY");
				
				poDate = formatDate.getStringFromDate((java.util.Date)ret.getFieldValue(i,"DOCDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
				mdDate = formatDate.getStringFromDate((java.util.Date)ret.getFieldValue(i,"MODIFIEDON"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
				if("PH".equals(userRole) && "ALL".equals(show) )
				{
					try{
						purGrp 	 = (String)purGroupsHash.get(poSysKey);
						cCode    = (String)ccHash.get(poSysKey) ;
					}catch(Exception e)
					{
					purGrp="";cCode="";
					}	
					//out.println("<row id='"+poNum+"¥"+vendor+"'><cell><![CDATA[<nobr><input type=checkbox name=chk1 value='"+poNum+"¥"+vendor+"¥"+"B¥"+poSysKey+"'></nobr>]]></cell><cell><![CDATA[<nobr><a href='ezBlockedPoLineitems.jsp?PurchaseOrder="+poNum+"&amp;Vendor="+vendor+"&amp;type=B&amp;poSysKey="+poSysKey+"'>"+poNum+"</a></nobr>]]></cell><cell>"+poDate+"</cell><cell>"+purGrp+"</cell><cell>"+cCode+"</cell><cell>"+mdDate+"</cell><cell>"+vendor+"</cell></row>");
%>
			<tr>
				<td align="center"><input type="checkbox" name="chk1" value='"+poNum+"¥"+vendor+"¥"+"B¥"+poSysKey+"'></td>
				<td align="center"><a href="ezBlockedPoLineitems.jsp?PurchaseOrder=<%=poNum%>&Vendor=<%=vendor%>&type=B&poSysKey=<%=poSysKey%>"><%=poNum%></a></td>
				<td align="center"><%=poDate%></td>
				<td align="center"><%=purGrp%></td>
				<td align="center"><%=cCode%></td>
				<td align="center"><%=mdDate%></td>
				<td align="center"><%=vendor%></td>
			</tr>
<%
				}else
				{
%>
			<tr>
				<td align="center"><input type="checkbox" name="chk1" value='"+poNum+"¥"+vendor+"¥"+"B¥"+poSysKey+"'></td>
				<td align="center"><a href="ezBlockedPoLineitems.jsp?PurchaseOrder=<%=poNum%>&Vendor=<%=vendor%>&type=B&poSysKey=<%=poSysKey%>"><%=poNum%></a></td>
				<td align="center"><%=poDate%></td>
				<td align="center"><%=mdDate%></td>
				<td align="center"><%=vendor%></td>
			</tr>
<%
					//out.println("<row id='"+poNum+"¥"+vendor+"'><cell><![CDATA[<nobr><input type=checkbox name=chk1 value='"+poNum+"¥"+vendor+"¥"+"B¥"+poSysKey+"'></nobr>]]></cell><cell><![CDATA[<nobr><a href='ezBlockedPoLineitems.jsp?PurchaseOrder="+poNum+"&amp;Vendor="+vendor+"&amp;type=B&amp;poSysKey="+poSysKey+"'>"+poNum+"</a></nobr>]]></cell><cell>"+poDate+"</cell><cell>"+mdDate+"</cell><cell>"+vendor+"</cell></row>");
				}
			}
		}
	}
%>
	</tbody>
	</table>
</div>
<div class="spacer"></div>
<!--<div align="center">
	<button type="button" onclick="goBack()">Back</button>
	<button type="button" onclick="checkVal()">Release Order</button>
</div>-->
</div>
<Div id="MenuSol"></Div>
</body>
</html>
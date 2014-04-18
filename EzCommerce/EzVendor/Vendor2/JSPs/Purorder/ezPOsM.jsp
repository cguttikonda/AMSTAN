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
	//out.print("RET:::::"+ret.toEzcString());
	
%>
<!DOCTYPE html>
<!--[if IE 8]>         <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->
<head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<title>Answerthink</title>
	<link rel="stylesheet" href="../../Mobile/css/normalize.css" />
	<link rel="stylesheet" href="../../../../../EzMobile/css/bootstrap.css" />
	<link rel="stylesheet" href="../../../../../EzMobile/css/bootstrap-responsive.css" />
	<link rel="stylesheet" href="../../../../../EzMobile/css/answerthink.css" />
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
<body>
<div class="row-fluid">
	<div class="span12">
		<h2>Answerthink</h2>
	</div>
</div>

<div class="row">
    <div class="span12"><h4>PO Details</h4></div>
</div>

<form name="myForm">
<div class="row-fluid">
          <div class="span12 offset4 panel">
<table class="table table-bordered table-striped">
<%

	if("PH".equals(userRole) && "ALL".equals(show) )
	{
%>
	<thead>
		<tr>
			<th>PO Number</th>
			<th>Pur. Group</th>
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
			<th>PO Number</th>
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
				<td align="center"><a href="ezPOLItemsM.jsp?PurchaseOrder=<%=poNum%>&Vendor=<%=vendor%>&type=B&poSysKey=<%=poSysKey%>"><%=poNum%></a></td>
				<td align="center"><%=purGrp%></td>
				<td align="center"><%=vendor%></td>
			</tr>
<%
				}else
				{
%>
			<tr>
				<td align="center"><a href="ezPOLItemsM.jsp?PurchaseOrder=<%=poNum%>&Vendor=<%=vendor%>&type=B&poSysKey=<%=poSysKey%>"><%=poNum%></a></td>
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
</div>
</form>
</body>
</html>
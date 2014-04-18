<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@include file="../../../Includes/Lib/AddButtonDir.jsp" %> 
<%@include file="../../../Includes/JSPs/Misc/iGetData.jsp"%>
<html>
<head> 
<script>
	function updateXML()
	{
		document.myForm.action = "ezSaveXMLData.jsp";
		document.myForm.submit();
	}
</script>
</head> 
<body>
<Form name=myForm method="POST">
<input type="hidden" name="selOpt" value="">


<br>
<table width="60%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
<tr>
	<th width="40%" align="left">Domain Name</th>
	<td width="60%"><input type=text name=domainName size=50 value="<%=ret.getFieldValueString(0,"DOMAIN_NAME")%>" class="InputBox"></td>
</tr>
<tr>
	<th width="40%" align="left">Sales Support</th>
	<td width="60%"><input type=text name=supportSales size=50 value="<%=ret.getFieldValueString(0,"SALES_SUPPORT")%>" class="InputBox"></td>
</tr>
<tr>
	<th width="40%" align="left">Vendor Support</th>
	<td width="60%"><input type=text name=supportVendor size=50 value="<%=ret.getFieldValueString(0,"VENDOR_SUPPORT")%>" class="InputBox"></td>
</tr>
</table>

<Div id="ButtonDiv" align=center style="position:absolute;top:85%;visibility:visible;width:100%">
	<a href="javascript:updateXML()"><img src="../../Images/Buttons/<%= ButtonDir%>/update.gif" border=none></a>
</div>
<Div id="MenuSol"></Div>		
</Form>
</body>
</html>
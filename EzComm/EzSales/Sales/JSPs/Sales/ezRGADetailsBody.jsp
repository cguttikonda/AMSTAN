<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>

<html>
<head>
<script>
function rgaSave()
{

opener.document.myForm.rgaProd.value=val
opener.document.myForm.rgaQty.value=val
window.close();
}
</script>
</head>

<body  scroll=auto>
<form>
<div class="main-container col2-layout middle account-pages">
<div class="main" style="width:auto !important;">
<div class="col-main roundedCorners" style="width:680px !important; margin-left:30px;">

<%
	String rgaDet = request.getParameter("rgaDet");
	if(rgaDet==null || "null".equals(rgaDet))rgaDet="";
	String[] rgaDetArray = rgaDet.split("¥");
	int rgaDetCnt =0;

	if(rgaDetArray!=null)rgaDetCnt = rgaDetArray.length;
%>
	<table class='data-table'>
	<thead>
	<th>Product</th>
	<th>RGA Product</th>
	<th>RGA QTY</th>
	</thead>

	<tbody>
<%
	for(int i=0;i<rgaDetCnt;i++)
	{
		String canId = rgaDetArray[i];
%>		
		<tr>
		<td><%=canId%></td>
		<td><input type=text name="rgaProdPop<%=i%>" value=""></td>
		<td><input type=text name="rgaQtyPop<%=i%>" value=""></td>
		</tr>	

<%	}
%>
	</tbody>
	</table>
	
	<input type=button value="Save" onClick="rgaSave()">
</div>
</div>
</div>
	
</form>	
</body>
</html>	


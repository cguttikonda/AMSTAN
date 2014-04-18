<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/BusinessCatalog/iRunProductSearch.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iRunProductSearch_Lables.jsp"%>
<%@ include file="../../../Includes/JSPs/Uploads/iImages.jsp"%>

<html><head>
<title>List of Products</title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
	<Script>
		  var tabHeadWidth=85
 	   	  var tabHeight="60%"
	</Script>
	<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
<script language="Javascript">
function CheckSelect() {
	var pCount=0;
	var selCount=0;
	pCount = document.CatalogFinalLevel.TotalCount.value;
	var i = 0;
	for ( i = 0 ; i < pCount; i++ ) {
		if(document.CatalogFinalLevel.elements['CheckBox_' + i].checked){
			selCount = selCount + 1;
		}
	}
	if(selCount<1){
		alert("<%=selItemAdd_A%>");
		document.returnValue = false;
	}else{
		document.CatalogFinalLevel.submit();
	}
}
function AddToFav(){
	var pCount=0;
	var selCount=0;
	pCount = document.CatalogFinalLevel.TotalCount.value;
	var i = 0;
	for ( i = 0 ; i < pCount; i++ ) {
		if(document.CatalogFinalLevel.elements['CheckBox_' + i].checked){
			selCount = selCount + 1;
		}
	}
	if(selCount<1){
		alert("<%=selItemGrp_A%>");
		document.returnValue = false;
	}else{
	document.forms[0].action = "../BusinessCatalog/ezAddToProductFav.jsp";
	document.forms[0].submit();
	}
}
function selectAll(obj)
{
	if(obj.checked==true)
	{
		for(var i=0;i<<%=prodCount%>;i++)
		{
			document.forms[0].elements['CheckBox_' + i].checked=true;
		}
	}
	else
	{
		for(var i=0;i<<%=prodCount%>;i++)
		{
			document.forms[0].elements['CheckBox_' + i].checked=false;
		}
	}
}
</script>
</head>

<body  onLoad="scrollInit()" onresize="scrollInit()" scroll=no>
<form method="post" action="../ShoppingCart/ezAddCart.jsp" name="CatalogFinalLevel">
<input type="hidden" name="back" value="2">
<table align=center border="0" cellpadding="0" class="displayheaderback" cellspacing="0" width="100%">
<tr>
    <td height="35" class="displayheaderback" align=center width="100%"><%=prodList_L%></td>
</tr>
</table>
<br>
<%
	if(prodCount == 0){
%>
		<br><br><br><br>
		<table  align=center border=0>
		<tr>
			<td class=displayalert align ="center" colspan ="4"><%=noProdSeaAgain_L %></td>
		</tr>
		</table >
		<br><br>
		<center>
<%
		  			buttonName = new java.util.ArrayList();
		  			buttonMethod = new java.util.ArrayList();
		  			buttonName.add("Back");
		  			buttonMethod.add("history.go(-1)");
		  			out.println(getButtonStr(buttonName,buttonMethod));
%>
		</center>

<%
	return;
	}
%>
	<Div id="theads">
	<table width="85%" id="tabHead"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<tr align="center" valign="middle">
<%
		if(ADDCART)
		{
%>
			<th width="5%"><input type="checkbox" name="select" onClick="selectAll(this)" title="Select/Deselect All"> </th>
			<th width="20%"> Product </th>
			<th width="75%"> <%=desc_L %> </th>

<%
		}else{
%>
			<th width="20%"> Product </th>
			<th width="80%"> <%=desc_L %> </th>
<%
		}
%>
		</tr>
	</Table>
	</Div>
	
	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:88%;height:60%;left:6%">
	<Table width="100%"  id="InnerBox1Tab"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
<%
	int i = 0;
	String prodNum = null;
	String productDesc = null;
	String prodPrice = null;
	for(i=0; i<prodCount; i++)
	{
		prodNum 	= retProducts.getFieldValueString(i, MAT_NUMBER);
		productDesc 	= retProducts.getFieldValueString(i, MATD_DESC);
		if(retProducts.getFieldValue(i, MAT_PRICE) != null)
		{
			prodPrice = retProducts.getFieldValueString(i, MAT_PRICE);
		}
%>
		<tr align="center">
<%
		if(ADDCART)
		{
			String matCodeTemp="";
%>
			<td width='5%'><input type="checkbox" name="CheckBox_<%=i%>" value="Selected" unchecked>		</Td>
			<td align = 'left' width='20%'>
<%
				 try{
					 matCodeTemp=""+Long.parseLong(prodNum);
					 out.println(matCodeTemp);
				    }catch(Exception e)
				    {
					matCodeTemp=prodNum;
					out.println(prodNum);
				    }
%>
			</td>
			<td align = 'left' width='75%'> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
			<%
				//prodNum = prodNum.trim();
				
				if(files.containsKey(matCodeTemp))
				{
			%>
					<A HREF ="../DrillDownCatalog/ezProductInfo.jsp?ProductNumber=<%= prodNum %>&fileName=<%=(String)files.get(matCodeTemp)%>"><%=productDesc%></A>
			<%	}
				else
				{
			%>
					<%=productDesc%>
			<%	}
			%>
					<%-- ProductNumber as hidden parameter --%>
     				<input type="hidden" name="Product_<%=i%>" value="<%=prodNum %>">
     			</td>
<%
		}else
		{
%>
			<td align = 'left' width='20%'>
<%
	 		try{
				out.println(Long.parseLong(prodNum));
			}catch(Exception e)
			{
				out.println(prodNum);
			}
			
				
%>
			
			</td>
			<td align = 'left' width='80%'> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<%
			prodNum = prodNum.trim();
			
			if(files.containsKey(prodNum))
			{
			%>
				<A HREF ="ezProductInfo.jsp?ProductNumber=<%= prodNum %>"><%=productDesc%></A>
			<%}
			else
			{%>
				<%=productDesc%>
			<%}%>
				
				<%-- ProductNumber as hidden parameter --%>
     				<input type="hidden" name="Product_<%= i %>" value="<%=prodNum %>">
     			</td>

<%
		}
%>
    		</tr>
<%
	}//End for
%>	
</Table>
</Div>

<input type="hidden" name="TotalCount" value="<%=prodCount%>">
<div id="buttonDiv" align="center" style='position:Absolute;Top:90%;width:100%'>
<table align=center cellPadding=0 cellSpacing=0>
	<tr>
<%
  		if(ADDCART)
  		{
%>
		<td>	
<%
  			buttonName = new java.util.ArrayList();
  			buttonMethod = new java.util.ArrayList();
  			buttonName.add("Add To Cart");
  			buttonMethod.add("CheckSelect()");
  			out.println(getButtonStr(buttonName,buttonMethod));
%>
		</td>
<%
  		}
  		if ( groupRows > 0 )
   		{
%>
			<td>
<%
   			buttonName = new java.util.ArrayList();
  			buttonMethod = new java.util.ArrayList();
			buttonName.add("Add To Groups");
			buttonMethod.add("AddToFav()");
			out.println(getButtonStr(buttonName,buttonMethod));
%>
			</td>
			<td>
			<select name="FavGroups">
<%			
			for ( int j = 0 ; j < groupRows ; j++ ){
%>			
				<option value="<%=retprodfav.getFieldValue(j,PROD_GROUP_NUMBER)%>"><%=retprodfav.getFieldValue(j,PROD_GROUP_WEB_DESC)%></option>");
<%				
			}
%>			
        		</select>
        		</td>
<%        		
		}	
%>
		<td>
		
<%		
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		buttonName.add("Back");
		buttonMethod.add("history.go(-1)");
		out.println(getButtonStr(buttonName,buttonMethod));
%>		
		</td>
	</tr>		
</table>	
</div>

</form>
<Div id="MenuSol"></Div>
</body>
</html>

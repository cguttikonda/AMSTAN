<%@ page import = "java.util.*"%>
<%@ page import = "ezc.ezutil.FormatDate"%>
<%@ page import ="ezc.ezutil.*" %>
<%@ page import ="ezc.ezparam.*" %>
<%@ include file="../../../Includes/JSPs/Lables/iRunProductSearch_Lables.jsp"%>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>

<%@ include file="../../../Includes/JSPs/BusinessCatalog/iProductNoSearch.jsp"%>

<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/Uploads/iImages.jsp"%>

               
<Script>
	var tabHeadWidth=70
	var tabHeight="50%"
</Script>
	<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
<script>
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
		for(var i=0;i<<%=rowCount%>;i++)
		{
			document.forms[0].elements['CheckBox_' + i].checked=true;
		}
	}
	else
	{
		for(var i=0;i<<%=rowCount%>;i++)
		{
			document.forms[0].elements['CheckBox_' + i].checked=false;
		}
	}
}
</script>
<body  onLoad="scrollInit()" onresize="scrollInit()" scroll=no>
<form method="post"  action="../ShoppingCart/ezAddCart.jsp" name="CatalogFinalLevel">
<input type="hidden" name="TotalCount" value="<%=rowCount%>">
<input type="hidden" name="back" value="2">


<table align=center border="0" cellpadding="0" class="displayheaderback" cellspacing="0" width="100%">
<tr>
    <td height="35" class="displayheaderback" align=center width="100%">Products List</td>
</tr>
</table>
<br>

<%
	if(rowCount>0)
	{
		java.util.Date myDateObj=new Date();
		myDateObj.setDate(myDateObj.getDate()+1);
 		String myDate= FormatDate.getStringFromDate(myDateObj,".",FormatDate.MMDDYYYY);

%>
 		<DIV id="theads" >	
			<Table width="70%" border="1" id="tabHead" align=center borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
			<Tr>
				<Th class=innerhead width='5%'><input type="checkbox" name="select" onClick="selectAll(this)" title="Select/Deselect All"></Th>
				<Th class=innerhead width='18%'>Product</Th>
				<Th class=innerhead width='50%'> Description</Th>	
			</Tr>						
			</Table>
			
		</Div>	
 		<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:73%;height:50%;left:10%">
	
			
		<Table width="100%" id="InnerBox1Tab" border=1 align=center borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
			
 		<%
		
		
		
		for(int g=0;g<rowCount;g++)
		{
	%>	
			<Tr>
			<Td align='center' width='5%'><input type="checkbox" name="CheckBox_<%=g%>" value="Selected" unchecked></Td>
			<Td align='left' width='18%'>&nbsp;
			<%
				String matNoTemp="";
				try{
					matNoTemp=""+Integer.parseInt((String)mat.get(g));
				}catch(Exception err){matNoTemp=(String)mat.get(g);}
				if(files.containsKey(matNoTemp))
				{ 
			%>
					<A href="../DrillDownCatalog/ezProductInfo.jsp?ProductNumber=<%=(String)mat.get(g)%>&fileName=<%=(String)files.get(matNoTemp)%>" onMouseover="window.status='Click to view Plant Details '; return true" onMouseover="window.status=' '; return true"><%=matNoTemp%></a>
			<%	}
				else
				{
			%>
					<%=matNoTemp%>
			<%	}
			%>
			
			
			
			
			</Td>
			<Td align='left' width='50%'>&nbsp;<input type='hidden' name='matDesc' value="<%=(String)Desc.get(g)%>"><%=(String)Desc.get(g)%></Td>
			</Tr>
			<input type="hidden" name="Product_<%=g%>" value="<%=(String)mat.get(g) %>">

			
	<%			
		}		
	%>
		</Table>
		</Div>	
		<input type="hidden" name="reqDate" value="<%=myDate%>">
		
<%
		
	}
	else
	{
	
%>	
	<br><br><br><br><br><br>
	<center>
		<table  align=center border=0>
				<tr>
					<td class=displayalert align ="center" colspan ="4">No Products available that match your search criteria. Change your criteria and search again</td>
				</tr>
		</table >
	</center>	

<%	}
	
	

	
%>

<div id="buttonDiv" align="center" style='position:Absolute;Top:90%;width:100%'>
<table align=center cellPadding=0 cellSpacing=0>
	<tr>
<%
  		if(rowCount>0)
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
  		if ( groupRows > 0 && rowCount>0)
   		{
%>
			<td>
<%
   			buttonName = new java.util.ArrayList();
  			buttonMethod = new java.util.ArrayList();
			buttonName.add("Add To Catalog");
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
<Div id="MenuSol"></Div>
</form>
</body>
</html>
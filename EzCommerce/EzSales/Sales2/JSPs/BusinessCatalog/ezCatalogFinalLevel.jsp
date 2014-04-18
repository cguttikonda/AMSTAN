<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/BusinessCatalog/iCatalogFinalLevel.jsp"%>
<%@ include file="../../../Includes/JSPs/BusinessCatalog/iViewCart.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iCatalogFinalLevel_Lables.jsp" %>

<html>
<head>
<title>ezCatalogFinalLevel</title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
	<Script>
		  var tabHeadWidth=60
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
		alert("<%=selItemtoAdd_A%>");
		document.CatalogFinalLevel.alert.value="0"
		document.returnValue = false;
	}else{
		document.CatalogFinalLevel.alert.value="1"
		document.returnValue = true;
		document.CatalogFinalLevel.submit();
	}
}


function viewCart()
{

	document.CatalogFinalLevel.alert.value="0"
	document.CatalogFinalLevel.onceSubmit.value=1
	document.body.style.cursor="wait"
	document.CatalogFinalLevel.action="../ShoppingCart/ezViewCart.jsp?back=1"
	document.CatalogFinalLevel.submit();


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
		alert("<%=selItemtoGroup_A%>");
		document.returnValue = false;
	}else{
	document.forms[0].action = "../BusinessCatalog/ezAddToProductFav.jsp";
	document.returnValue = true;
	}
}
function giveAlert()
{
	<%if (!(chkString == null || chkString =="" || "null".equals(chkString))){%>
		alert("Products have been added successfully to shopping cart")
	<%}%>
}
function goBack()
{
document.forms[0].action ="../BusinessCatalog/ezFullCatalog.jsp"
document.forms[0].submit();
}
</script>
</head>
<body  onLoad="scrollInit();giveAlert()" onresize="scrollInit()" scroll=no>
<form method="post" action="../ShoppingCart/ezAddCart.jsp" name="CatalogFinalLevel">
<input type="hidden" name="alert">
<input type="hidden" name="from" value="ezCatalogFinalLevel.jsp">
<input type="hidden" name="CatalogDescription" value="<%=CatalogDescription%>">
<input type="hidden" name="GroupDesc" value="<%=groupDesc%>">
<input type="hidden" name="ProductGroup" value="<%=pGroupNumber%>">

<table align=center border="0" cellpadding="0" class="displayheaderback" cellspacing="0" width="100%">
<tr>
<%
	if(ADDFLAG)
	{
%>	
	<td height="35" class="displayheader" align=center  width="80%"><%=groupDesc%></td>
	<td height="35" class="displayheaderback" align=right width="20%">Shopping Cart Items:<%=Cart.getRowCount()%>&nbsp;&nbsp;&nbsp;&nbsp;</td>
<%	
	}else{
%>
	<td height="35" class="displayheader" align=center  width="100%"><%=groupDesc%></td>
<%
	}
%>

</tr>
</table>



<%
	if(retCount==0)
	{
%>
		<table align="center" >
		<tr ><td class=displayalert  align=center><%=noprods_L%></td></tr>
		</table>
		<br><br><br><br>
		<table border="0" align="center">
		<tr align="center">
		<td class="blankcell"align="center">
<%		
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		buttonName.add("Back");
		buttonMethod.add("goBack()");
		out.println(getButtonStr(buttonName,buttonMethod));
%>
		</td>
		</tr>
		</table>

<%
		return;	
	}
	// Display the Products
	
%>
		<Div id="theads">
		<table id="tabHead" width="60%"   align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<tr>
<%
		if((retCount>0)&&(ADDFLAG))
		{
%>        
			<th width='7%'><%=add_L%></th>
			<th width='93%'><%=prods_L%></th>
<%		
	        }else{
%>        
			<th colspan=2 width='93%'><%=prods_L%></th>
<%		
	        }
%>
		</tr>
		</Table>
		</Div>

		<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:62%;height:60%;left:20%">
		<Table align=center id="InnerBox1Tab" class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="100%">
<%
		String prodNum ="";
		for ( int i = 0 ; i <  retCount; i++ )
		{
			prodNum = (String)(ret.getFieldValue(i,MAT_NUMBER));
%>
                	<tr align='center'>
<%
			if(ADDFLAG)
			{
				if(chklength>0)
				{
					boolean chkflag=true;
					for(int c=0;c < chklength ;c++)
					{
						if(prodNum.equals(checkedProducts[c]))
						{
%>					
							<td width='7%' ><input type='checkbox' name='CheckBox_<%=i%>' value='Selected' checked > </td>
<%						
							chkflag=false;
							break;
						}
					}
					if(chkflag)
					{
%>				
						<td width='7%' ><input type='checkbox' name='CheckBox_<%=i%>' value='Selected' unchecked> </td>
<%					
					}	
				}else{
%>			
						<td width='7%' > <input type='checkbox' name='CheckBox_<%=i%>' value='Selected' unchecked> </td>
<%				
				}

			}
			
			%>         	
			<td width='93%' align='left'> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<A HREF ="ezProductInfo.jsp?ProductNumber=<%=prodNum%>" onMouseover="window.status=' '; return true" onMouseout="window.status=' '; return true">
				<%=ret.getFieldValue(i,MATD_WEB_DESC)%>
			</A>
<%
			java.math.BigDecimal bUprice = new java.math.BigDecimal(ret.getFieldValueString(i,MAT_PRICE));
%>			
			<input type="hidden" name="Product_<%=i%>" value="<%= prodNum %>">
              		</td>
              		</tr>
<%              		
      			
		}// End for
%>
	</Table>
	</Div>
	<input type="hidden" name="TotalCount" value=<%=retCount%>>			
	<input type="hidden" name="onceSubmit" value=0>
	
<div id="buttonDiv" align='center' style='Position:Absolute;width:100%;top:90%'>
<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		if(ADDFLAG)
		{
			buttonName.add("Add To Cart");
			buttonMethod.add("CheckSelect()");
			buttonName.add("View Cart");
			buttonMethod.add("viewCart()");
		}	
		buttonName.add("Back");
		buttonMethod.add("goBack()");
		out.println(getButtonStr(buttonName,buttonMethod));
%>

</div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>


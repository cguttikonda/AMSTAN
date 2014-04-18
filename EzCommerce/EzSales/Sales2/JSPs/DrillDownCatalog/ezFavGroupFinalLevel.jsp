<%//@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/BusinessCatalog/iFavGroupFinalLevel.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iFavGroupFinalLevel_Lables.jsp"%>
<%@ include file="../../../Includes/JSPs/BusinessCatalog/iViewCart.jsp"%>
<html>
<head>
<title>ezFavourite Group Details</title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
	<Script>
		  var tabHeadWidth=80
 	   	  var tabHeight="60%"
	</Script>
	<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
<script language="Javascript">
function CheckSelect() {
     if(document.CatalogFinalLevel.onceSubmit.value!=1) {
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
		//return false;
	}else{
		document.CatalogFinalLevel.alert.value="1"
		document.body.style.cursor="wait"
		document.CatalogFinalLevel.submit();
		document.returnValue = true;
	}
   }
}
function DelFromFav(){
 if(document.CatalogFinalLevel.onceSubmit.value!=1) {
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
		alert("<%=selItemtoRemove_A%>");
		document.returnValue = false;
		//return false;
	}else{

		document.body.style.cursor="wait"
            	document.forms[0].action = "../BusinessCatalog/ezDelFromProductFav.jsp";
		document.CatalogFinalLevel.onceSubmit.value=1
	    	document.forms[0].submit()
		document.returnValue = true;
	}
   }
}
function formSubmit(obj)
{
	document.CatalogFinalLevel.alert.value="0"
	document.CatalogFinalLevel.action=obj;
	document.CatalogFinalLevel.submit();
}

function setBack()
{
document.forms[0].action = "../BusinessCatalog/ezCatalog.jsp"
document.forms[0].submit()
}
function giveAlert()
{
	<%if (!(chkString == null || chkString =="" || "null".equals(chkString))){%>
		alert("Products have been added successfully to shopping cart")
	<%}%>
}

</script>
</head>
<% String UserRole = (String)session.getValue("UserRole"); %>
<body onLoad="scrollInit();giveAlert()" onresize="scrollInit()" scroll=no>
<form method="post" action="../ShoppingCart/ezAddCart.jsp" name="CatalogFinalLevel">
<input type="hidden" name="alert">
<input type="hidden" name="onceSubmit" value=0>
<input type="hidden" name="FavGroup" value="<%=pGroupNumber%>">
<input type="hidden" name="GroupDesc" value="<%=pGroupDesc%>">
<input type="hidden" name="from" value="ezFavGroupFinalLevel.jsp">
<input type="hidden" name="TotalCount" value=<%=retCount%>>
<table align=center border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
	<!--td height="35" class="displayheaderback" align=center  width="80%"><%=pGroupDesc%></td>
	<td height="35" class="displayheaderback" align=right width="20%">Shopping Cart Items:<%=Cart.getRowCount()%>&nbsp;&nbsp;</td-->
	<Td height="25" class="displayheader"  width="100%" align='right'>Shopping Cart Items:<%=Cart.getRowCount()%></Td>

</tr>
</table>
<%
	if(retCount==0)
	{
%>	
		<br><br><br><br>
		<Table  align=center border=0  >
			<Tr>
			<Td align="center" class=displayalert><%=noItemsGroup_L%></Td>
			</Tr>
		</Table><br><br><br>
		<center>
<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		buttonName.add("Add Products");
		buttonMethod.add("formSubmit(\"ezAddProducts.jsp\")");
		buttonName.add("Back");
		buttonMethod.add("setBack()");
		out.println(getButtonStr(buttonName,buttonMethod));
%>
		</center>
<%		
		return;
	}
%>
		<Div id="theads">
		<Table width="80%" id="tabHead"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
			<Tr>
				<th width="5%">&nbsp; </th>
				<th width="20%">Product </th>
				<th width="75%" align="center">Descirption</th>
			</tr>
		</Table>
		</Div>
		<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:63%;height:60%;left:20%">
		<Table width="100%" id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
<%
		int Count = 0;
		String list_price = null;
		for ( int i = 0 ; i <  retCount; i++ )
		{
			String prodNum = (String)(ret.getFieldValue(i,MAT_NUMBER));
%>
			<TR align="center">
<%
			if(chklength>0)
			{
				boolean chkflag=true;
				for(int c=0;c < chklength ;c++){
					if(prodNum.equals(checkedProducts[c])){
%>					
						<td width='5%' ><input type='checkbox' name='CheckBox_<%=i%>' value='Selected' checked> </td>
<%						
						chkflag=false;
						break;
					}
				}
				if(chkflag)
				{
%>				
					<td width='5%' ><input type='checkbox' name='CheckBox_<%=i%>' value='Selected' unchecked> </td>
<%					
				}	
			}else{
%>			
				<td width='5%' > <input type='checkbox' name='CheckBox_<%=i%>' value='Selected' unchecked> </td>
<%				
			}
%>

			  <TD width="20%" align="center">	<%=prodNum%></Td>
			  <TD width="75%" align="left">&nbsp;&nbsp;&nbsp;&nbsp;
				<%-- <A HREF = ezProductInfo.jsp?ProductNumber=<%=prodNum%>> --%>
				<%= ret.getFieldValueString(i,MATD_DESC) %>
				<%-- </A> --%>
				<input type="hidden" name="Product_<%=i%>" size="18" value="<%= prodNum %>" >
			  </TD>
		    </TR>
<%
			Count = Count + 1;
		}// End for
%>
		</Table>
  		</Div>
		<div id="buttonDiv" align='center' style='Position:Absolute;width:100%;top:85%'>
<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		if("Y".equalsIgnoreCase(request.getParameter("personalize")))
		{
			buttonName.add("Delete");
			buttonMethod.add("DelFromFav()");
			buttonName.add("Add Products");
			buttonMethod.add("formSubmit(\"ezAddProducts.jsp\")");
			buttonName.add("Back");
			buttonMethod.add("formSubmit(\"ezListFavGroups.jsp\")");
			
		}else{
			buttonName.add("Add To Cart");
			buttonMethod.add("CheckSelect()");
			buttonName.add("View Cart");
			buttonMethod.add("formSubmit(\"../DDShoppingCart/ezViewCart.jsp?back=1\")");
			buttonName.add("Back");
			buttonMethod.add("setBack()");
		}	
		out.println(getButtonStr(buttonName,buttonMethod));
%>
		</div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>

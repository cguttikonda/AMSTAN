<%//@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/BusinessCatalog/iFavGroupFinalLevel.jsp"%>
<%//@ include file="../../../Includes/JSPs/DrillDownCatalog/iGetMatDetailsJCO.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iFavGroupFinalLevel_Lables.jsp"%>
<%@ include file="../../../Includes/JSPs/BusinessCatalog/iViewCart.jsp"%>

<html>
<head>
<title>ezFavourite Group Details</title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
	<Script>
		  var tabHeadWidth=90
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
            	document.forms[0].action = "../BusinessCatalog/ezDelFromProductFavDT.jsp";
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

function addProducts()
{
	
	document.CatalogFinalLevel.addProduct.value="Y"
	document.CatalogFinalLevel.FavGroup.value="<%=pGroupNumber%>"
	document.CatalogFinalLevel.GroupDesc.value="<%=pGroupDesc%>"
	
	
	document.CatalogFinalLevel.target = "_parent";
	document.CatalogFinalLevel.action="../DrillDownCatalog/ezDrillDownVendorCatalog.jsp";
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

function selectAll(obj)
{
	var obj1 = document.CatalogFinalLevel.produm
	if(obj1!=null)
	{
		if(isNaN(obj1.length))		
		{	
			if(obj.checked==true)
			{
				document.CatalogFinalLevel.elements['CheckBox_0'].checked=true		
			}
		}	
		else
		{
			if(obj.checked==true)
			{
				for(var i=0;i<obj1.length;i++)
				{
					document.CatalogFinalLevel.elements['CheckBox_' + i].checked=true;
				}
			}
			else
			{
				for(var i=0;i<obj1.length;i++)
				{
					document.CatalogFinalLevel.elements['CheckBox_' + i].checked=false;
				}
			}
		}
	}
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
<input type="hidden" name="ProductGroup" value="<%=request.getParameter("ProductGroup")%>">
<input type="hidden" name="GroupDesc" value="<%=request.getParameter("GroupDesc")%>">
<input type="hidden" name="chkString" value="<%=request.getParameter("chkString")%>">
<input type="hidden" name="personalize" value="<%=request.getParameter("personalize")%>">
<input type="hidden" name="addProduct">

<%
	String title ="";
	if("Y".equalsIgnoreCase(request.getParameter("personalize")))
	{
		title="View <font color='red'>"+pGroupDesc+"</font>";
	}
	else
	{
		title="Browse Catalog <font color='red'>"+pGroupDesc+"</font>";
	}

%>
<%
	String display_header = title; 	
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
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
		//buttonName.add("Add Products");
		//buttonMethod.add("addProducts()");
		buttonName.add("Back");
		buttonMethod.add("formSubmit(\"ezListFavGroupsDT.jsp\")");
		out.println(getButtonStr(buttonName,buttonMethod));
%>
		</center>
		<Div id="MenuSol"></Div>
<%		
		return;
	}
%>
		<Div id="theads">
		<Table width="90%" id="tabHead"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
			<Tr>
				<th width="5%"><input type="checkbox" name="select" onClick="selectAll(this)" title="Select/Deselect All"></th>
				<th width="20%">Product</th>
				<th width="45%" align="center">Description</th>
				<th width="30%" align="center">Manufacturer</th>
				<!--<th width="15%" align="center">List Price($)</th>-->
			</tr>
		</Table>
		</Div>
		<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:90%;height:60%;left:20%">
		<Table width="100%" id="InnerBox1Tab" align=right border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
<%
		String matSt="",manNum="",manName="",stock="",matFlg="";
		java.util.StringTokenizer st = null;
	        
		int Count = 0;
		String tempprodNum = "";
		String list_price = null;
		for ( int i = 0 ; i <  retCount; i++ )
		{
			String prodNum = (String)(ret.getFieldValue(i,MAT_NUMBER));
			tempprodNum = "";
			
			try
			{
				tempprodNum = Integer.parseInt(prodNum)+"";
			}
			catch(Exception e)
			{
				tempprodNum = prodNum; 
			}
%>
			<TR align="center">
			<td width='5%' > <input type='checkbox' name='CheckBox_<%=i%>' value='Selected' unchecked> </td>
                          <TD width="20%" align="left"><input type="hidden" name="produm">	<%=tempprodNum%></Td>
			  <TD width="45%" align="left">&nbsp;&nbsp;&nbsp;&nbsp;
				<%= ret.getFieldValueString(i,MATD_DESC) %>
				<input type="hidden" name="Product_<%=i%>" size="18" value="<%= prodNum %>" >
				<input type="hidden" name="VendCatalog_<%=i%>" value="<%=ret.getFieldValue(i,"EMM_CATALOG_NO")%>">
				<input type="hidden" name="Type_<%=i%>" value="<%=ret.getFieldValue(i,"EPF_TYPE")%>">
			  </TD>
			  <TD width="30%" align="center"><%= ret.getFieldValueString(i,"EMM_MANUFACTURER") %></Td>
			  <!--<TD width="15%" align="center"><%= ret.getFieldValueString(i,"EMM_UNIT_PRICE") %>&nbsp;</Td>-->
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
			buttonName.add("Delete Products");
			buttonMethod.add("DelFromFav()");
			//buttonName.add("Add Products");
			//buttonMethod.add("formSubmit(\"ezAddProducts.jsp\")");
			//buttonMethod.add("addProducts()");
			buttonName.add("Back");
			buttonMethod.add("formSubmit(\"ezListFavGroupsDT.jsp\")");
			
		}else{ 
			//buttonName.add("Add To Cart");
			//buttonMethod.add("CheckSelect()");
			buttonName.add("View Cart");
			buttonMethod.add("formSubmit(\"../ShoppingCart/ezViewCart.jsp?back=1\")");
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

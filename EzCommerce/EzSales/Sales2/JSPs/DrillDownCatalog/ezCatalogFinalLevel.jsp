<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/Uploads/iImagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/DrillDownCatalog/iCatalogFinalLevel.jsp"%> 
<%@ include file="../../../Includes/JSPs/BusinessCatalog/iViewCart.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iCatalogFinalLevel_Lables.jsp" %>

<html>
<head>
<%
	String pst = request.getParameter("produm");
	java.util.Date myDateObj_A=new Date();
	myDateObj_A.setDate(myDateObj_A.getDate()+1);
	String myDate_A= ezc.ezutil.FormatDate.getStringFromDate(myDateObj_A,".",ezc.ezutil.FormatDate.MMDDYYYY);	
%>
<title>ezCatalogFinalLevel</title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
	<Script>
		  var tabHeadWidth=85
 	   	  var tabHeight="60%"
	</Script>
	<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
<script>	

</script>	
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
		if(document.CatalogFinalLevel.select.checked)
			document.CatalogFinalLevel.produm.value='C'
			
		document.CatalogFinalLevel.alert.value="1"
		document.returnValue = true;
		document.CatalogFinalLevel.submit();
	}
}


function viewCart()
{

	//document.CatalogFinalLevel.alert.value="0"
	//document.CatalogFinalLevel.onceSubmit.value=1
	//document.body.style.cursor="wait"
	document.CatalogFinalLevel.action="../DDShoppingCart/ezViewCart.jsp?back=1"
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
	document.forms[0].action = "ezAddToProductFav.jsp";
	document.returnValue = true;
	}
}
function giveAlert()
{
	
	 var prod = "<%=pst%>"
	<% if("C".equals(pst)){%>
	 	document.CatalogFinalLevel.select.checked=true;
 	
	<% }if(!"S".equals(alertStr)){%>
		alert("Products have been added successfully to shopping cart")
	<%}%>	
		
	<%--if ((chkString == null || chkString =="" || "null".equals(chkString))){--%>
		//alert("Products have been added successfully to shopping cart")
	<%--}--%>
}
function goBack()
{
	//document.forms[0].action ="ezDrillDownCatalog.jsp"
	//document.forms[0].submit();
	parent.document.location.href="../Misc/ezWelcome.jsp";
}
function selectAll(obj)
{
	if(obj.checked==true)
	{
		document.CatalogFinalLevel.produm.value='C'
		for(var i=0;i<<%=retCount%>;i++)
		{
			document.CatalogFinalLevel.elements['CheckBox_' + i].checked=true;
		}
	}
	else
	{
		//document.CatalogFinalLevel.produm.value=''
		for(var i=0;i<<%=retCount%>;i++)
		{
			document.CatalogFinalLevel.elements['CheckBox_' + i].checked=false;
		}
	}
}

function showPrice(matNo)
{
   	attach=window.open("ezGetPrice.jsp?matNo="+matNo,"UserWindow","width=400,height=300,left=300,top=250,resizable=no,scrollbars=yes,toolbar=no,menubar=no");
}
function popUp(matNo,fileName)
{
	attach=window.open("ezImagePopup.jsp?matNo="+matNo+"&fileName="+fileName,"UserWindow","width=450,height=250,left=300,top=250,resizable=yes,scrollbars=yes,toolbar=no,menubar=no");
}
function getATP(index)
{

	
	var matNo="";
	var matDesc="";
	var uom="";
	var requiredQty="";
	var requiredDate="";
	
	var product_final = eval("document.CatalogFinalLevel.Product_"+index);
	var productdesc_final = eval("document.CatalogFinalLevel.Productdesc_"+index);
	matNo=product_final.value;
	matDesc=productdesc_final.value
	uom="EA";
	requiredDate='<%=myDate_A%>'
	requiredQty="0";
	
	var retValue = window.showModalDialog("../Sales/ezGetATPResult.jsp?matNo="+matNo+"&uom="+uom+"&requiredQty="+requiredQty+"&requiredDate="+requiredDate+"&matDesc="+matDesc,window.self,"center=yes;dialogHeight=28;dialogWidth=30;help=no;titlebar=no;status=no;minimize:yes")	



}

</script>
</head>
<body  onLoad="scrollInit(10);giveAlert()" onresize="scrollInit(10)" scroll=NO >
<form method="post" action="../DDShoppingCart/ezAddCart.jsp" name="CatalogFinalLevel">
<input type="hidden" name="alert">
<input type="hidden" name="from" value="ezCatalogFinalLevel.jsp">
<input type="hidden" name="CatalogDescription" value="<%=CatalogDescription%>">
<input type="hidden" name="GroupDesc" value="<%=groupDesc%>">
<input type="hidden" name="ProductGroup" value="<%=pGroupNumber%>">
<input type="hidden" name="produm">


<!--table align=center border="0" cellpadding="0" class="displayheaderback" cellspacing="0" width="80%"-->
<Table border="0" cellpadding="0" cellspacing="0" width="98%">
<tr>
<%
	if(ADDFLAG)
	{
%>		<Td height="25" style="background:transparent" class="displayheader"  width="100%" align='right'>Shopping Cart Items:<%=Cart.getRowCount()%></Td>
<%	
	}else{
%>
		<td height="25" style="background:transparent" class="displayheader" align=center  width="100%"><%=groupDesc%></td>
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
		<Div id="theads" >
		<Table width="85%" id="tabHead"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		
		<tr>
<%
		String imgTemp = "";
		if((retCount>0)&&(ADDFLAG))
		{
%>        
			<th width='7%'><input type="checkbox" name="select" onClick="selectAll(this)" title="Select/Deselect All"></th>
			<th width='20%'>Image</th>
			<th width='60%'>Product & Description</th>
			<th width='13%'>Price&<br>ATP</th>
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

		<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:63%;height:60%;left:2%">
		<Table width="100%" id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		
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
			String showProdNum = prodNum;
			try
			{
				showProdNum = Long.parseLong(prodNum)+"";
			}
			catch(Exception e)
			{
				showProdNum = prodNum;
			}
			
%>         	
			<td width='20%' align='left'>
	<%
			  if(files.containsKey(showProdNum)) 
			   {
				%>
			<center> <a href="JavaScript:popUp('<%=prodNum%>','<%=(String)files.get(showProdNum)%>')"><img src="../../Images/IMAGEUPLOAD/<%=(String)files.get(showProdNum)%>"   height="50" width="65" vspace="10" hspace="10" border=none  <%=statusbar%>></a> </center>
				
				
				</A>
	<%
				}
				else
				{
	%>
			<center> No Image Exist </center>
			
			<% } %>
			</td>
			<td width='60%' align='left'><b> <%=showProdNum%> </b><br> <%=ret.getFieldValue(i,MATD_WEB_DESC)%>
			

<%
			
			java.math.BigDecimal bUprice = new java.math.BigDecimal(ret.getFieldValueString(i,MAT_PRICE));
%>			
			<input type="hidden" name="Product_<%=i%>" value="<%= prodNum %>">
			<input type="hidden" name="Productdesc_<%=i%>" value="<%=ret.getFieldValue(i,MATD_WEB_DESC)%>">
              		</td>
              		<td width='13%' align='left'><a href="Javascript:showPrice('<%=prodNum%>')">Price</a>
              		<br><a href="Javascript:getATP('<%=i%>')">ATP</a>
              		</td>
              		</tr>
<%              		
      			
		}// End for
%>
	</Table>
	</Div>
	<input type="hidden" name="TotalCount" value=<%=retCount%>>	 		
	<input type="hidden" name="onceSubmit" value=0>
	
<div id="buttonDiv" align='center' style='Position:Absolute;width:100%;top:80%'>
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


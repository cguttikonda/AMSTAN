<%//@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/Uploads/iImagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/DrillDownCatalog/iVendorCatalogFinalLevel.jsp"%> 
<%@ include file="../../../Includes/JSPs/BusinessCatalog/iViewCart.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iCatalogFinalLevel_Lables.jsp" %>

<html>
<head>
<%
	String prodDesc1   = request.getParameter("ProdDesc1"); 
	
	String pst = request.getParameter("produm");
	java.util.Date myDateObj_A=new Date();
	myDateObj_A.setDate(myDateObj_A.getDate()+1);
	String myDate_A= ezc.ezutil.FormatDate.getStringFromDate(myDateObj_A,".",ezc.ezutil.FormatDate.MMDDYYYY);	
%>
<title>ezCatalogFinalLevel</title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
	<Script>
		  var tabHeadWidth=95
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
function addCatalog(obj)
{
   	
   	y=chkChkBox();
   	
   	if(eval(y))
   	{
		document.body.style.cursor="wait"
		document.CatalogFinalLevel.addPrd.value="addproduct"
		document.CatalogFinalLevel.action=obj
		document.CatalogFinalLevel.onceSubmit.value=1 
		document.CatalogFinalLevel.submit()
      	}
}
function chkChkBox()
{
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
		alert("Please select atleast one product to add to your group");
		document.returnValue = false;
	}
	else
		return true;
		
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
function checkDesc()
{
   var pdesc = document.CatalogFinalLevel.ProdDesc1.value;
   if ( pdesc == '')
   {
	alert('Please enter data');
	document.CatalogFinalLevel.ProdDesc1.focus();
	return ;
   }
   else 
   {
	document.CatalogFinalLevel.alertStr.value="S"
	document.CatalogFinalLevel.action="ezVendorCatalogFinalLevel.jsp";
	document.CatalogFinalLevel.submit();

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
<input type="hidden" name="from" value="ezVendorCatalogFinalLevel.jsp">
<input type="hidden" name="CatalogDescription" value="<%=CatalogDescription%>">
<input type="hidden" name="GroupDesc" value="<%=groupDesc%>">
<input type="hidden" name="ProductGroup" value="<%=pGroupNumber%>">
<input type="hidden" name="CatalogNo" value="<%=catalogNo%>">
<input type="hidden" name="id" value="<%=idStr%>">
<input type="hidden" name="produm">
<input type="hidden" name="FavGroup" value="<%=FavGroup%>">
<input type="hidden" name="GroupDesc" value="<%=GroupDesc%>">
<input type="hidden" name="addPrd">
<input type="hidden" name="subFlag" value='Y'>
<input type="hidden" name="alertStr" >



<!--table align=center border="0" cellpadding="0" class="displayheaderback" cellspacing="0" width="80%"-->
<!--<Table border="0" cellpadding="0" cellspacing="0" width="98%">
<tr>
<%
	if(ADDFLAG && false) 
	{
%>		<Td height="25" style="background:transparent" class="displayheader"  width="100%" align='right'>Shopping Cart Items:<%=Cart.getRowCount()%></Td>
<%	
	}else{
%>
		<td height="25" style="background:transparent" class="displayheader" align=center  width="100%"><%=catalogDesc%></td>
<%
	}
%>

</tr>
</table>
-->

<%
    if(retCount>0)
    {
%>

<Div id='inputDiv' style='position:relative;align:center;top:1%;width:100%;'>
<Table width="60%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
<Tr>
	<Td height="5" style="background-color:'F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"></Td>
	<Td height="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"></Td>
	<Td height="5" style="background-color:'F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"></Td>
</Tr>
<Tr>
	<Td width="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"></Td>
	<Td style="background-color:'F3F3F3'" valign=middle>
		<Table border="0" align="center" valign=middle width="100%" cellpadding=0 cellspacing=0 class=welcomecell>
		<Tr>
			<Td style='background:#F3F3F3;font-size=11px;color:#00355D;font-weight:bold;' width='50%' align=center valign=center>
				Search the Catalog by Product Id 
				
			</Td>
			
				<Td style='background:#F3F3F3;font-size=11px;color:#00355D;font-weight:bold;' width='50%' align=left valign=center>
					<input type="text" name="ProdDesc1" class=InputBox size="22" maxlength="100">

				</Td>			
			<Td style='background:#F3F3F3;font-size=11px;color:#00355D;font-weight:bold;align:center' width='20%' align=center>
				<Img src="../../Images/Common/left_arrow.gif" style="cursor:hand" border="none" onClick="checkDesc()" onMouseover="window.status=''; return true" onMouseout="window.status=' '; return true">
			</Td>
		</Tr>
		
		</Table>
	</Td>
	<Td width="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e3.gif"><img width="5" height="1" src="Cb_e3.gif" ></Td>
</Tr>
<Tr>
	<Td width="5" style="background-color:'F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"></Td>
	<Td height="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"></Td>
	<Td width="5" style="background-color:'F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"></Td>
</Tr>
</Table>
</Div>

<%
   }
%>
<br>

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
		<Table width="95%" id="tabHead"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		
		<tr>
<%
		String imgTemp = "";
		if((retCount>0)&&(ADDFLAG))
		{
%>        
			<th width='5%'><input type="checkbox" name="select" onClick="selectAll(this)" title="Select/Deselect All"></th>
			<th width='20%'>Product</th>
			<th width='40%'>Description</th>
			<th width='20%'>Brand</th>
			<th width='20%'>List Price</th>
			<th width='5%'>Image</th>
			<th width='10%'>SAP</th>
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

		<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:95%;height:60%">
		<Table width="100%" id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		
<%
                ret.toEzcString();
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
							<td width='5%' ><input type='checkbox' name='CheckBox_<%=i%>' value='Selected' checked > </td>
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
                        <td width='20%' align='left'><%=showProdNum%></td>
			<td width='40%' align='left'><%=ret.getFieldValue(i,"EMD_DESC")%>

<%
			
			java.math.BigDecimal bUprice = new java.math.BigDecimal(ret.getFieldValueString(i,MAT_PRICE));
%>			
			<input type="hidden" name="Product_<%=i%>" value="<%= prodNum %>">
			<input type="hidden" name="Productdesc_<%=i%>" value="<%=ret.getFieldValue(i,"EMD_DESC")%>">
			<input type="hidden" name="VendCatalog_<%=i%>" value="<%=ret.getFieldValue(i,"EMM_CATALOG_NO")%>">
              		</td>
              		<td width='20%' align='left'><%=ret.getFieldValue(i,"EMM_MANUFACTURER")%></td>
              		<td width='20%' align='left'><%=ret.getFieldValue(i,"EMM_UNIT_PRICE")%></td>
              		
			<td width='5%' align='left'>
<%			 if(files.containsKey(showProdNum)) 
			 {
%>
				<center> <a href="JavaScript:popUp('<%=prodNum%>','<%=(String)files.get(showProdNum)%>')"><img src="../../Images/IMAGEUPLOAD/<%=(String)files.get(showProdNum)%>"   height="50" width="65" vspace="10" hspace="10" border=none  <%=statusbar%>></a> </center></A>	
<%
			 }
			 else
			 {
%>
				<center>No Image</center>

<% 
			 } 
%>
			</td>
              		<td width='10%' align='left'><a href="Javascript:showPrice('<%=prodNum%>')">Price</a>
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
		if(ADDFLAG && !ADDPRDFLAG)
		{
			buttonName.add("Add To Cart");
			buttonMethod.add("CheckSelect()");
			buttonName.add("View Cart");
			buttonMethod.add("viewCart()");
		}
		else if(ADDPRDFLAG)
		{
		        buttonName.add("Add To Catalog");
		        buttonMethod.add("addCatalog(\"../BusinessCatalog/ezAddProductPer.jsp\")");
		}
		buttonName.add("Back");
		buttonMethod.add("goBack()");
		out.println(getButtonStr(buttonName,buttonMethod));
%>

</div>
</form>
<script>

<%
   if(prodDesc1!=null)
   {
%>
   	document.forms[0].ProdDesc1.value="<%=prodDesc1%>"
   
<% } %>

</script>
<Div id="MenuSol"></Div>
</body>
</html>


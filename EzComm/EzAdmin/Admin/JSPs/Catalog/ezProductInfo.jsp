<%@ page import="ezc.ezparam.*,ezc.ezmisc.params.*" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<link rel="stylesheet" href="../../Library/Styles/legend.css" type="text/css"/>

<!-- Add fancyBox -->
<link rel="stylesheet" href="../../Library/Script/jquery.fancybox.css?v=2.0.5" type="text/css" media="screen" />
<script type="text/javascript" src="../../Library/Script/jquery.fancybox.pack.js?v=2.0.5"></script>
<!-- end of fancybox -->

<%@ include file="../../../Includes/JSPs/Catalog/iProductInfo.jsp"%>
<%
	//out.println("prodInfoObj::"+prodInfoObj.toEzcString());
	String prodCode		= prodInfoObj.getFieldValueString("EZP_PRODUCT_CODE");
	String type		= prodInfoObj.getFieldValueString("EZP_TYPE");
	String webSKU		= prodInfoObj.getFieldValueString("EZP_WEB_SKU");
	String webProdId	= prodInfoObj.getFieldValueString("EZP_WEB_PROD_ID");
	String upcCode		= prodInfoObj.getFieldValueString("EZP_UPC_CODE");
	String erpCode		= prodInfoObj.getFieldValueString("EZP_ERP_CODE");
	String brand		= prodInfoObj.getFieldValueString("EZP_BRAND");
	String family		= prodInfoObj.getFieldValueString("EZP_FAMILY");
	String model		= prodInfoObj.getFieldValueString("EZP_MODEL");
	String color		= prodInfoObj.getFieldValueString("EZP_COLOR");
	String curPrice		= prodInfoObj.getFieldValueString("EZP_CURR_PRICE");
	String futPrice		= prodInfoObj.getFieldValueString("EZP_FUTURE_PRICE");
	String curEffDate	= prodInfoObj.getFieldValueString("EZP_CURR_EFF_DATE");
	String futEffDate	= prodInfoObj.getFieldValueString("EZP_FUTURE_EFF_DATE");
	if("null".equals(type))
		type = "";
	if("null".equals(webSKU))
		webSKU = "";
	if("null".equals(webProdId))
		webProdId = "";
	if("null".equals(upcCode))
		upcCode = "";
	if("null".equals(erpCode))
		erpCode = "";
	if("null".equals(brand))
		brand = "";
	if("null".equals(family))
		family = "";
	if("null".equals(model))
		model = "";
	if("null".equals(color))
		color = "";
	if("null".equals(curPrice))
		curPrice = "";
	if("null".equals(futPrice))
		futPrice = "";
	if("null".equals(curEffDate))
		curEffDate = "";
	if("null".equals(futEffDate))
		futEffDate = "";	
%>
<script src="../../Library/Script/popup.js"></script>
<script type="text/javascript">

function update()
{
	var prod_code 	= document.getElementById("productCode").value;
	var type 	= document.getElementById("type").value;
	var webSKU 	= document.getElementById("webSKU").value;
	var webProdId 	= document.getElementById("webProdId").value;
	var upcCode 	= document.getElementById("upcCode").value;
	var erpCode 	= document.getElementById("erpCode").value;
	var brand 	= document.getElementById("brand").value;
	var family 	= document.getElementById("prodFamily").value;
	var model 	= document.getElementById("model").value;
	
	var color 	= document.getElementById("color").value;
	var curPrice 	= document.getElementById("currPrice").value;
	var futPrice 	= document.getElementById("futPrice").value;
	var curEffDate 	= document.getElementById("curEffDate").value;
	var futEffDate 	= document.getElementById("futEffDate").value;
	
	updateProduct(prod_code,type,webSKU,webProdId,upcCode,erpCode,brand,family,model,color,curPrice,futPrice);
	//alert(prod_code+"***"+type+"***"+webSKU+"***"+webProdId+"***"+upcCode+"***"+erpCode+"***"+brand+"***"+family+"***"+model+"***"+color+"***"+curPrice+"***"+futPrice);
}
function GetXmlHttpObject()
{
	if(window.XMLHttpRequest)
	{
		return new XMLHttpRequest();
	}
	if(window.ActiveXObject)
	{
		return new ActiveXObject("Microsoft.XMLHTTP");
	}
	return null;
}

var xmlhttp;

function updateProduct(prod_code,type,webSKU,webProdId,upcCode,erpCode,brand,family,model,color,curPrice,futPrice)
{
	xmlhttp = GetXmlHttpObject();

	if(xmlhttp==null)
	{
		alert ("Your browser does not support Ajax HTTP");
		return;
	}

	Popup.showModal('modal');

	var url="../Catalog/ezEditProductInfoAjax.jsp";
	url=url+"?proCode="+prod_code+"&type="+type+"&webSKU="+webSKU+"&webProdId="+webProdId+"&upcCode="+upcCode+"&erpCode="+erpCode+"&brand="+brand+"&family="+family+"&model="+model+"&color="+color+"&curPrice="+curPrice+"&futPrice="+futPrice;

	if(xmlhttp!=null)
	{
		xmlhttp.onreadystatechange=Process;
		xmlhttp.open("GET",url,true);
		xmlhttp.send(null);

	}
	else
		Popup.hide('modal');
}

function Process()
{
	if(xmlhttp.readyState==4)
	{
		var resText = xmlhttp.responseText;
		var resultText	= resText.split("##");
		var addSuccess	= resultText[2];
		//alert("::"+resText+"::");
		Popup.hide('modal');
	}
}
</script>
</head>
<body>
<form name="myForm" method="post">
<div id="modal" style="border:0px solid black; background-color:white; padding:1px; font-size:10;width:40%;height:180px; text-align:center; display:none;">
	<ul>
		<li>&nbsp;</li>
		<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
		<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
	</ul>
</div>
<table width="100%">
	<tbody>
	<tr>
		<td width="40%" valign="top">
			<div>
				<fieldset>
				<legend>Product Code : <%=prodCode%> </legend>
				<table align="center">
				<tbody align="center">
					
					<tr>
						<td align="right">Type</td>
						<td><input type="text" name="type" id="type" value="<%=type%>" maxlength="2"></td>
					</tr>
					<tr>
						<td align="right">Web SKU</td>
						<td><input type="text" name="webSKU" id="webSKU" value="<%=webSKU%>"></td>
					</tr>
					<tr>
						<td align="right">Web Product Id</td>
						<td><input type="text" name="webProdId" id="webProdId" value="<%=webProdId%>"></td>
					</tr>
					<tr>
						<td align="right">UPC Code</td>
						<td><input type="text" name="upcCode" id="upcCode" value="<%=upcCode%>"></td>
					</tr>
					<tr>
						<td align="right">ERP Code</td>
						<td><input type="text" name="erpCode" id="erpCode" value="<%=erpCode%>"></td>
					</tr>
					<tr>
						<td align="right">Brand</td>
						<td><input type="text" name="brand" id="brand" value="<%=brand%>"></td>
					</tr>
					<tr>
						<td align="right">Product Family</td>
						<td><input type="text" name="prodFamily" id="prodFamily" value="<%=family%>"></td>
					</tr>
					<tr>
						<td align="right">Model</td>
						<td><input type="text" name="model" id="model" value="<%=model%>"></td>
					</tr>
					<tr>
						<td align="right">Color</td>
						<td><input type="text" name="color" id="color" value="<%=color%>"></td>
					</tr>
					<input type="hidden" name="productCode" id= "productCode"value="<%=prodCode%>">
				</tbody>
				</table>
							
				</fieldset>
			</div>
		</td>
		<td  valign="top" width="60%">
			<div>
				<fieldset>
				<legend>Product Pricing</legend>
				<table align="center">
				<tbody align="center">
					
					<tr>
						<td align="right">Current Price</td>
						<td><input type="text" name="currPrice" id="currPrice" value="<%=curPrice%>"></td>
						<td align="right">Effected Date</td>
						<td><input type="text" name="curEffDate" id="curEffDate" value="<%=curEffDate%>"></td>
					</tr>
					<tr>
						<td align="right">Future Price</td>
						<td><input type="text" name="futPrice" id="futPrice" value="<%=futPrice%>"></td>
						<td align="right">Effected Date</td>
						<td><input type="text" name="futEffDate" id="futEffDate" value="<%=futEffDate%>"></td>
					</tr>

				</tbody>
				</table>
				</fieldset>
				
			</div>
		</td>
	</tr>
	</tbody>
</table>
<center><input type="Button" value="Update" onClick="update();"></center>
</form>
</body>

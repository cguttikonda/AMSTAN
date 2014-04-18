<%@ page import="ezc.ezparam.*,ezc.ezmisc.params.*" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<%@ include file="../../../Includes/JSPs/Catalog/iProductDesc.jsp"%>
<!-- Add fancyBox -->
<link rel="stylesheet" href="../../Library/Script/jquery.fancybox.css?v=2.0.5" type="text/css" media="screen" />
<script type="text/javascript" src="../../Library/Script/jquery.fancybox.pack.js?v=2.0.5"></script>
<!-- end of fancybox -->
<link rel="stylesheet" href="../../Library/Styles/legend.css" type="text/css"/>
<script src="../../Library/Script/popup.js"></script>
<%
	//out.println("prodDescObj::"+prodDescObj.toEzcString());
	String prodCode = prodDescObj.getFieldValueString("EPD_PRODUCT_CODE");
	String details	= prodDescObj.getFieldValueString("EPD_PRODUCT_DETAILS");
	String desc	= prodDescObj.getFieldValueString("EPD_PRODUCT_DESC");
	if("null".equals(details))
		details = "";
	if("null".equals(desc))
		desc = "";
%>
<script type="text/javascript">
function update()
{
	var prod_code 	= document.getElementById("productCode").value;
	var details 	= document.getElementById("productDet").value;
	var desc 	= document.getElementById("productDesc").value;
	
	updateProduct(prod_code,details,desc);
	//alert(prod_code+"***"+details+"***"+desc);
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

function updateProduct(prod_code,details,desc)
{
	xmlhttp = GetXmlHttpObject();

	if(xmlhttp==null)
	{
		alert ("Your browser does not support Ajax HTTP");
		return;
	}

	Popup.showModal('modal');

	var url="ezEditProductDescAjax.jsp";
	url=url+"?proCode="+prod_code+"&details="+details+"&desc="+desc;

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
<div id="modal" style="border:0px solid black; background-color:white; padding:1px; font-size:10;width:60%;height:180px; text-align:center; display:none;">
	<ul>
		<li>&nbsp;</li>
		<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
		<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
	</ul>
</div>
<table align="center">
	<tbody>
	<tr>
		<td valign="top" width="80%">
		<div>
			<fieldset>
			<legend>Product Code : <%=prodCode%></legend>
			<table align="center">
				<tr>
					<td valign="top" width="80%">
					<div>
						<fieldset>
						<legend>Product Details</legend>
							<textarea name="productDet" id="productDet" cols="80" rows="5" style="resize:none;"><%=details%>
						</textarea>
						</fieldset>
					</div>
					</td>
					<input type="hidden" name="productCode" id= "productCode"value="<%=prodCode%>">
				</tr>
				<tr>
					<td valign="top" width="80%">
					<div>
						<fieldset>
						<legend>Product Description</legend>
							<textarea name="productDesc" id="productDesc" cols="80" rows="5" style="resize:none;"><%=desc%>
						</textarea>
						</fieldset>
					</div>
					</td>
				</tr>
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
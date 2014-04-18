<%@ page import="ezc.ezparam.*,ezc.ezmisc.params.*" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<link rel="stylesheet" href="../../Library/Styles/legend.css" type="text/css"/>
<!-- Add fancyBox -->
<link rel="stylesheet" href="../../Library/Script/jquery.fancybox.css?v=2.0.5" type="text/css" media="screen" />
<script type="text/javascript" src="../../Library/Script/jquery.fancybox.pack.js?v=2.0.5"></script>
<!-- end of fancybox -->
<%@ include file="../../../Includes/JSPs/Catalog/iProductStatus.jsp"%>
<%
	//out.println("prodStatusObj::"+prodStatusObj.toEzcString());
	String prodCode 	= prodStatusObj.getFieldValueString("EZP_PRODUCT_CODE");
	String featured 	= prodStatusObj.getFieldValueString("EZP_FEATURED");
	String discontinued	= prodStatusObj.getFieldValueString("EZP_DISCONTINUED");
	String discDate		= prodStatusObj.getFieldValueString("EZP_DISCONTINUE_DATE");
	String replace		= prodStatusObj.getFieldValueString("EZP_REPLACES_ITEM");
	String newFrom		= prodStatusObj.getFieldValueString("EZP_NEW_FROM");
	String newTo		= prodStatusObj.getFieldValueString("EZP_NEW_TO");
	String status		= prodStatusObj.getFieldValueString("EZP_STATUS");
	if("null".equals(featured))
		featured = "";
	if("null".equals(discontinued))
		discontinued = "";
	if("null".equals(discDate))
		discDate = "";
	if("null".equals(replace))
		replace = "";
	if("null".equals(newFrom))
		newFrom = "";
	if("null".equals(newTo))
		newTo = "";
	if("null".equals(status))
		status = "";
%>

<script src="../../Library/Script/popup.js"></script>
<script type="text/javascript">
function update()
{
	var prod_code 	= document.getElementById("productCode").value;
	var status 	= document.getElementById("status").value;
	var featured 	= document.getElementById("featured").value;
	var discontinued 	= document.getElementById("discontinued").value;
	var discDate 	= document.getElementById("discDate").value;
	var replace 	= document.getElementById("replace").value;
	var newFrom 	= document.getElementById("newFrom").value;
	var newTo 	= document.getElementById("newTo").value;
		
	updateProduct(prod_code,status,featured,discontinued,discDate,replace,newFrom,newTo);
	//alert(prod_code+"***"+status+"***"+featured+"***"+discontinued+"***"+discDate+"***"+replace+"***"+newFrom+"***"+newTo);
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

function updateProduct(prod_code,status,featured,discontinued,discDate,replace,newFrom,newTo)
{
	xmlhttp = GetXmlHttpObject();

	if(xmlhttp==null)
	{
		alert ("Your browser does not support Ajax HTTP");
		return;
	}

	Popup.showModal('modal');

	var url="../Catalog/ezEditProductStatusAjax.jsp";
	url=url+"?proCode="+prod_code+"&status="+status+"&featured="+featured+"&discontinued="+discontinued+"&discDate="+discDate+"&replace="+replace+"&newFrom="+newFrom+"&newTo="+newTo;

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
	
		<td valign="top" width="80%">
		<div>
			<fieldset>
			<legend>Product Code : <%=prodCode%></legend>
			<table align="center">
				<tr>
					<td valign="top" width="60%">
					<div>
					<fieldset>
					<legend>Product Status</legend>
					<table align="center" >
					<tbody align="center" >
						<tr>
							<td align="right">Status</td>
							<td><input type="text" name="status" id="status" value="<%=status%>" maxlength="2"></td>

						</tr>
						<tr>
							<td align="right">Featured</td>
							<td><input type="text" name="featured" id="featured" value="<%=featured%>"></td>

						</tr>
						<tr>
							<td align="right">Discontinued</td>
							<td><input type="text" name="discontinued" id="discontinued" value="<%=discontinued%>"></td>

						</tr>
						<tr>
							<td align="right">Discontinued Date</td>
							<td><input type="text" name="discDate" id="discDate" value="<%=discDate%>"></td>

						</tr>
						<tr>
							<td align="right">Replaces Item</td>
							<td><input type="text" name="replace" id="replace" value="<%=replace%>"></td>
						</tr>
						<tr>
							<td align="right">New From</td>
							<td><input type="text" name="newFrom" id="newFrom" value="<%=newFrom%>"></td>
						</tr>
						<tr>
							<td align="right">New To</td>
							<td><input type="text" name="newTo" id="newTo" value="<%=newTo%>"></td>
						</tr>
						<input type="hidden" name="productCode" id= "productCode"value="<%=prodCode%>">
					</tbody>
					</table>
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
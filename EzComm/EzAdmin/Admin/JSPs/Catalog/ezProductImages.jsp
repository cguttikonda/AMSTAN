<%@ page import="ezc.ezparam.*,ezc.ezmisc.params.*" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<link rel="stylesheet" href="../../Library/Styles/legend.css" type="text/css"/>

<!-- Add fancyBox -->
<link rel="stylesheet" href="../../Library/Script/jquery.fancybox.css?v=2.0.5" type="text/css" media="screen" />
<script type="text/javascript" src="../../Library/Script/jquery.fancybox.pack.js?v=2.0.5"></script>
<!-- end of fancybox -->

<%@ include file="../../../Includes/JSPs/Catalog/iProductImages.jsp"%>
<%
	//out.println("prodImagesObj::"+prodImagesObj.toEzcString());

	String productCode 	= prodImagesObj.getFieldValueString("EPA_PRODUCT_CODE");
	String assetId	 	= prodImagesObj.getFieldValueString("EPA_ASSET_ID");
	String imageType	= prodImagesObj.getFieldValueString("EPA_IMAGE_TYPE");
	String screenName	= prodImagesObj.getFieldValueString("EPA_SCREEN_NAME");
	String mime		= prodImagesObj.getFieldValueString("EZA_MIME_TYPE");
	String link		= prodImagesObj.getFieldValueString("EZA_LINK");
	
	if("null".equals(assetId))
		assetId = "";
	if("null".equals(imageType))
		imageType = "";
	if("null".equals(screenName))
		screenName = "";
	if("null".equals(mime))
		mime = "";
	if("null".equals(link))
		link = "";
%>
<script src="../../Library/Script/popup.js"></script>

<script type="text/javascript">
function update()
{
	var prod_code 	= document.getElementById("productCode").value;
	var assetId 	= document.getElementById("assetId").value;
	var imageType 	= document.getElementById("imageType").value;
	var screenName 	= document.getElementById("screenName").value;
	var mime 	= document.getElementById("mime").value;
		
	updateProduct(prod_code,assetId,imageType,screenName,mime);
	//alert(prod_code+"***"+assetId+"***"+imageType+"***"+screenName+"***"+mime);
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

function updateProduct(prod_code,assetId,imageType,screenName,mime)
{
	xmlhttp = GetXmlHttpObject();

	if(xmlhttp==null)
	{
		alert ("Your browser does not support Ajax HTTP");
		return;
	}

	Popup.showModal('modal');

	var url="../Catalog/ezEditProductImageAjax.jsp";
	url=url+"?prod_code="+prod_code+"&assetId="+assetId+"&imageType="+imageType+"&screenName="+screenName+"&mime="+mime;

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
			<legend>Product Code : <%=productCode%></legend>
			<table align="center">
				<tr>
					<td valign="top" width="60%">
					<div>
					<fieldset>
					<legend>Product Status</legend>
					<table align="center" >
					<tbody align="center" >
						<tr>
							<td align="right">Asset Id</td>
							<td><input type="text" name="assetId" id="assetId" value="<%=assetId%>"></td>

						</tr>
						<tr>
							<td align="right">Image Type</td>
							<td><input type="text" name="imageType" id="imageType" value="<%=imageType%>"></td>

						</tr>
						<tr>
							<td align="right">Screen Name</td>
							<td><input type="text" name="screenName" id="screenName" value="<%=screenName%>"></td>

						</tr>
						<tr>
							<td align="right">Mime Type</td>
							<td><input type="text" name="mime" id="mime" value="<%=mime%>"></td>

						</tr>
						<tr>
							<td align="right">Link</td>
							<td><input type="text" name="link" id="link" value="<%=link%>"></td>
						</tr>
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
<%@ page import="ezc.ezparam.*,ezc.ezmisc.params.*" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<link rel="stylesheet" href="../../Library/Styles/legend.css" type="text/css"/>

<!-- Add fancyBox -->
<link rel="stylesheet" href="../../Library/Script/jquery.fancybox.css?v=2.0.5" type="text/css" media="screen" />
<script type="text/javascript" src="../../Library/Script/jquery.fancybox.pack.js?v=2.0.5"></script>
<!-- end of fancybox -->

<%@ include file="../../../Includes/JSPs/Catalog/iProductDimensions.jsp"%>
<%
	//out.println("prodDimObj::"+prodDimObj.toEzcString());
	String prodCode 	= prodDimObj.getFieldValueString("EZP_PRODUCT_CODE");
	String style	 	= prodDimObj.getFieldValueString("EZP_STYLE");
	String size		= prodDimObj.getFieldValueString("EZP_SIZE");
	String finish		= prodDimObj.getFieldValueString("EZP_FINISH");
	String length		= prodDimObj.getFieldValueString("EZP_LENGTH");
	String lengthUOM	= prodDimObj.getFieldValueString("EZP_LENGTH_UOM");
	String width		= prodDimObj.getFieldValueString("EZP_WIDTH");
	String weight		= prodDimObj.getFieldValueString("EZP_WEIGHT");
	String weightUOM	= prodDimObj.getFieldValueString("EZP_WEIGHT_UOM");
	String volume		= prodDimObj.getFieldValueString("EZP_VOLUME");
	String volumeUOM	= prodDimObj.getFieldValueString("EZP_VOLUME_UOM");
	if("null".equals(style))
		style = "";
	if("null".equals(size))
		size = "";
	if("null".equals(finish))
		finish = "";
	if("null".equals(length))
		length = "";
	if("null".equals(lengthUOM))
		lengthUOM = "";
	if("null".equals(width))
		width = "";
	if("null".equals(weight))
		weight = "";
	if("null".equals(weightUOM))
		weightUOM = "";
	if("null".equals(volume))
		volume = "";
	if("null".equals(volumeUOM))
		volumeUOM = "";	
%>
<script src="../../Library/Script/popup.js"></script>
<script type="text/javascript">
function update()
{	
	
	var proCode 	= document.getElementById("productCode").value;
	var style 	= document.getElementById("style").value;
	var size 	= document.getElementById("size").value;
	var finish 	= document.getElementById("finish").value;
	var width	= document.getElementById("width").value;
	var weight 	= document.getElementById("weight").value;
	var weightUOM 	= document.getElementById("weightUOM").value;
	var volume 	= document.getElementById("volume").value;
	var volumeUOM 	= document.getElementById("volumeUOM").value;
	var length 	= document.getElementById("length").value;
	var lengthUOM 	= document.getElementById("lengthUOM").value;
	
	updateProduct(proCode,style,size,finish,width,weight,weightUOM,volume,volumeUOM,length,lengthUOM);
	//alert(proCode+"***"+style+"***"+size+"***"+finish+"***"+width+"***"+weight+"***"+weightUOM+"***"+volume+"***"+volumeUOM+"***"+length+"***"+lengthUOM);
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

function updateProduct(proCode,style,size,finish,width,weight,weightUOM,volume,volumeUOM,length,lengthUOM)
{
	xmlhttp = GetXmlHttpObject();

	if(xmlhttp==null)
	{
		alert ("Your browser does not support Ajax HTTP");
		return;
	}

	Popup.showModal('modal');

	var url="../Catalog/ezEditProductDimensionsAjax.jsp";
	url=url+"?proCode="+proCode+"&style="+style+"&size="+size+"&finish="+finish+"&width="+width+"&weight="+weight+"&weightUOM="+weightUOM+"&volume="+volume+"&volumeUOM="+volumeUOM+"&length="+length+"&lengthUOM="+lengthUOM;

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
			<legend>Product code : <%=prodCode%></legend>
			<table align="center">
				<tr>
					<td valign="top" width="60%">
					<div>
						<fieldset>
							<legend>Product Dimensions</legend>
							<table align="center">
							<tbody align="center">
								<tr>
									<td align="right">Style</td>
									<td><input type="text" name="style" id="style" value="<%=style%>"></td>
									<td align="right">Size</td>
									<td><input type="text" name="size" id="size" value="<%=size%>"></td>
									
								</tr>
								<tr>
									<td align="right">Finish</td>
									<td><input type="text" name="finish" id="finish" value="<%=finish%>"></td>
									<td align="right">Width</td>
									<td><input type="text" name="width" id="width" value="<%=width%>"></td>
								</tr>
								<tr>
									<td align="right">Weight</td>
									<td><input type="text" name="weight" id="weight" value="<%=weight%>"></td>
									<td align="right">Weight UOM</td>
									<td><input type="text" name="weightUOM" id="weightUOM" value="<%=weightUOM%>"></td>
									
								</tr>
								<tr>
									<td align="right">Volume</td>
									<td><input type="text" name="volume" id="volume" value="<%=volume%>"></td>
									<td align="right">Volume UOM</td>
									<td><input type="text" name="volumeUOM" id="volumeUOM" value="<%=volumeUOM%>"></td>
								</tr>
								<tr>
									<td align="right">Length</td>
									<td><input type="text" name="length" id="length" value="<%=length%>"></td>
									<td align="right">Length UOM</td>
									<td><input type="text" name="lengthUOM" id="lengthUOM" value="<%=lengthUOM%>"></td>
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
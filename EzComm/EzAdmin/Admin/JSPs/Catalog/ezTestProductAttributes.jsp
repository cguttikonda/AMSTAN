<%@ page import="ezc.ezparam.*,ezc.ezmisc.params.*" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<link rel="stylesheet" href="../../Library/Styles/legend.css" type="text/css"/>

<%@ include file="../../../Includes/JSPs/Catalog/iProductAttributesConfig.jsp"%>
<%@ include file="../../../Includes/JSPs/Catalog/iProductAttributes.jsp"%>
<%
	String productCode = productAttributesObj.getFieldValueString("EPA_PRODUCT_CODE");
	//out.println("productAttributesConObj::"+productAttributesConObj.toEzcString());
	//out.println("productAttributesObj::"+productAttributesObj.toEzcString());
%>

<script src="http://code.jquery.com/jquery-latest.js"></script>
  
<!-- fancy box popup instead of original from rb -->
<link rel="stylesheet" href="../../Library/Script/jquery.fancybox.css?v=2.0.5" type="text/css" media="screen" />
<script type="text/javascript" src="../../Library/Script/jquery.fancybox.pack.js?v=2.0.5"></script>
<!-- end of fancybox -->

<Script src="../../Library/Script/popup.js"></Script> 
<script>
	$(document).ready(function() {
		$(".fancybox").fancybox({closeBtn:true}),

	    //select all the a tag with name equal to modal
	    $('a[name=modal]').click(function(e) {
		//Cancel the link behavior
		e.preventDefault();

		//Get the A tag
		var id = $(this).attr('href');

		//Get the screen height and width
		var maskHeight = $(document).height();
		var maskWidth = $(window).width();

		//Set heigth and width to mask to fill up the whole screen
		$('#mask').css({'width':maskWidth,'height':maskHeight});

		//transition effect
		$('#mask').fadeIn(1000);
		$('#mask').fadeTo("slow",0.8);

		//Get the window height and width
		var winH = $(window).height();
		var winW = $(window).width();

		//Set the popup window to center
		$(id).css('top',  winH/2-$(id).height()/2);
		$(id).css('left', winW/2-$(id).width()/2);

		//transition effect
		$(id).fadeIn(2000);

	    });

	    //if close button is clicked
	    $('.window .close').click(function (e) {
		//Cancel the link behavior
		e.preventDefault();

		$('#mask').hide();
		$('.window').hide();
	    });
	});
</script>
<style>
	#mask {
	  position:absolute;
	  left:0;
	  top:0;
	  z-index:9000;
	  background-color:#000;
	  display:none;
	}

	#boxes .window {
	  position:absolute;
	  left:0;
	  top:0;
	  width:500px;
	  height:350px;
	  display:none;
	  z-index:9999;
	  padding:20px;
	}

	#boxes #dialog {
	  width:500px;
	  height:362px;
	  padding:10px;
	  background-color:#fff;
	}

	#input {
	box-shadow: inset 0px 0px 0px ; 
	-moz-box-shadow: inset 0px 0px 0px ; 
	-webkit-box-shadow: inset 0px 0px 0px ; 
	border: none; 
	}
</style>
<script type="text/javascript">
function save()
{	alert("tr len ="+(document.getElementById("attributes").getElementsByTagName("tr").length));
	var rowCount = (document.getElementById("attributes").getElementsByTagName("tr").length-1);
	
	var proCode 	= document.getElementById("productCode").value;
	var attrCode 	= document.getElementById("attrCode").value;
	var attrValue 	= document.getElementById("attrValue").value;
	var attrDesc 	= document.getElementById("attrDesc").value;
	var values 	= document.getElementById("values").value;
	alert("rowCount="+(rowCount));
	var len=(rowCount)-13;
	alert("len="+len);
	alert("aa====:"+document.saveForm.attrCode[13].value);
		
	updateProduct(proCode,attrCode,attrValue,attrDesc,values);
	alert(proCode+"***"+attrCode+"***"+attrValue+"***"+attrDesc+"***"+values);
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

function updateProduct(proCode,attrCode,attrValue,attrDesc,values)
{
	
	xmlhttp = GetXmlHttpObject();

	if(xmlhttp==null)
	{
		alert ("Your browser does not support Ajax HTTP");
		return;
	}

	Popup.showModal('modal');

	var url="ezInsertAttributes.jsp";
	url=url+"?values="+values;

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
		alert("::"+resText+"::");
		Popup.hide('modal');
	}
}
</script>
<script type="text/javascript">
function addAttribute()
{
	var rowCount = document.getElementById("attributes").getElementsByTagName("tr").length;
	var table=document.getElementById("attributes");
	var row = table.insertRow(rowCount);
	var count = $("[type='checkbox']:checked").length;
	
	var val = [];
		$(':checkbox:checked').each(function(i){
		  val[i] = $(this).val();
		  //alert(val[i]);
	});
	//var value = $("input:checkbox:checked").val(); 
	//alert(value);
	for(var c = 0;c<val.length;c++)
	{
		var row = table.insertRow(rowCount);
		var cell1 = row.insertCell(0);
		var cell2 = row.insertCell(1);
		var cell3 = row.insertCell(2);
		
		//var attId = "attId"+rowCount;
		//var attDesc = "attDesc"+rowCount;

		cell1.innerHTML="<input type='text' name='attrCode' disabled='disabled' value='"+val[c].split("#")[0]+"'>";
		cell2.innerHTML="<input type='text' name='attrDesc' disabled='disabled' value='"+val[c].split("#")[1]+"'>";
		cell3.innerHTML="<input type='text' name='attrValue' value=''>";
		
		
		//var attrValues = document.getElementById("attr").value;
		//var arr = attrValues.split("#");
		$.fancybox.close();
		//eval("document.saveForm.attId"+rowCount).value = arr[0];
		//eval("document.saveForm.attDesc"+rowCount).value = arr[1];
	}
}

function compareCodes()
{
	//alert("This is compareCodes"+document.saveForm.attrCode.length);
	var attCode	= document.saveForm.attrCode;
	var attValues	= document.saveForm.attrValues;
	for(var i=0;i<attValues.length;i++)
	{
		for(var j=0;j<attCode.length;j++)
		{
			if(attValues[i].value.split("#")[0] == attCode[j].value)
			{
				//alert(attValues[i].value.split("#")[0]);
				attValues[i].disabled = true;
			}
		}
	}
}

</script>
</head>
<body>
<form name="saveForm" method='post'>
<a class="fancybox" href="#addAttribute" onClick="compareCodes();">Add an Attribute</a>
<div id="addAttribute" style="display:none;height:300px;">
	<table cellspacing="" cellpadding="">
	<thead>
		<th></th>
		<th>Attribute Code</th>
		<th>Description</th>
	</thead>
	<tbody>
	<tr>
<%
			for(int i=0;i<productAttributesConObj.getRowCount();i++)
			{		
				String attrId		= productAttributesConObj.getFieldValueString(i,"EAC_ID");
				String attrDesc		= productAttributesConObj.getFieldValueString(i,"EAC_DESC");
			
%>			
			<tr>
			<td><input type="checkbox" name="attrValues" class="att" id="attrValues" value="<%=attrId%>#<%=attrDesc%>"></td>
			<td><%=attrId%></td>
			<td><%=attrDesc%></td>
			</tr>
<%
			}
%>
			<tr>
				<td colspan="3"><center><input type="Button" value="Save" onClick='addAttribute();'></center></td>
			</tr>
	</tr>
	</tbody>
	</table>
	
</div>
<div>
<table width="100%">
	<tbody>
		<tr>
			<td valign="top" width="80%">
			<div style="width: 850px; height: 600px; z-index:10000;">
				<fieldset>
				<legend>Product Code : <%=productCode%> </legend>
				<table style="width: 850px; height: 500px; z-index:10000;">
					<tr>
						<td valign="top" width="60%">
						<div style="width: 850px; height: 400px; z-index:10000;" >
						<fieldset>
						<legend>Product Attributes</legend>
						<table align="center" id="attributes">
						<thead>
							
							<tr>
								<th>Attribute Code</th>
								<th>Description</th>
								<th>Attribute Value</th>
							</tr>
						</thead>
						<tbody align="center">
<%
						String values ="";						
						for(int i=0;i<productAttributesObj.getRowCount();i++)
						{		
							String attrCode		= productAttributesObj.getFieldValueString(i,"EPA_ATTR_CODE");
							String attrValue	= productAttributesObj.getFieldValueString(i,"EPA_ATTR_VALUE");
							String attrDesc		= productAttributesObj.getFieldValueString(i,"EAC_DESC");
							if(attrValue.equals(""))
							values+=attrCode+"¥"+"0"+"¥"+attrDesc+"¥"+productCode+"$"+"";
							else
							values+=attrCode+"¥"+attrValue+"¥"+attrDesc+"¥"+productCode+"$"+"";
%>			
							<tr>
								<td><input type="text" disabled='disabled' name="attrCode" id="attrCode" value="<%=attrCode%>"></td>
								<td><input type="text" disabled='disabled' name="attrDesc" id="attrDesc" value="<%=attrDesc%>"></td>
								<td><input type="text" name="attrValue" id="attrValue" value="<%=attrValue%>"></td>
								<input type="hidden" name="productCode" id="productCode" value="<%=productCode%>">
							</tr>
<%
						}
%>
						<input type="hidden" name="values" id="values" value="<%=values%>">
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
</div>
<table>
	<tr>
		<center><input type="Button" value="Update" onClick="save();"></center>
 	</tr>
</table>
</form>
</body>
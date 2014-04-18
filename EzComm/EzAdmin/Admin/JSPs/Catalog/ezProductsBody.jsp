<%@ include file="../../../Includes/JSPs/Catalog/iProducts.jsp"%>
<%
	//out.println("productsObj::"+productsObj.toEzcString());
%>
<style type="text/css" media="screen">
 	@import "../../Library/Styles/demo_table_jui.css";
 	@import "../../Library/Styles/jquery-ui-1.7.2.custom.css";
 
 	/*
 	 * Override styles needed due to the mix of three different CSS sources! For proper examples
 	 * please see the themes example in the 'Examples' section of this site
 	 */
 	.dataTables_info { padding-top: 0; }
 	.dataTables_paginate { padding-top: 0; }
 	.css_right { float: right; }
 	#products_wrapper .fg-toolbar { font-size: 0.8em }
 	#theme_links span { float: left; padding: 2px 10px; }
 	#products_wrapper { -webkit-box-shadow: 2px 2px 6px #666; box-shadow: 2px 2px 6px #666; border-radius: 5px; }
 	#products tbody {
 		border-left: 1px solid #AAA;
 		border-right: 1px solid #AAA;
 	}
 	#products thead th:first-child { border-left: 1px solid #AAA; }
 	#products thead th:last-child { border-right: 1px solid #AAA; }
 </style>
 
 <script src="http://code.jquery.com/jquery-latest.js"></script>
 <script type="text/javascript" src="../../Library/Script/complete.min.js"></script>
 <script type="text/javascript" src="../../Library/Script/jquery.dataTables.min.js"></script> 
 <script type="text/javascript" src="../../Library/Script/TableTools-2.1.1/js/TableTools.min.js"></script> 
  <script  src="../../Library/Script/colResizable-1.3.min.js"></script>
  
<!-- fancy box popup instead of original from rb -->
<link rel="stylesheet" href="../../Library/Script/jquery.fancybox.css?v=2.0.5" type="text/css" media="screen" />
<script type="text/javascript" src="../../Library/Script/jquery.fancybox.pack.js?v=2.0.5"></script>
<!-- end of fancybox -->
<!-- Style for New Header -->
<!-- end of style for new header -->
<Script src="../../Library/Script/popup.js"></Script> 
<script type="text/javascript">
	$(document).ready( function() 
	{		
		$(".fancybox").fancybox(
		{
			closeBtn:true	
		});
	});

	function fnFeaturesInit ()
	{
		/* Not particularly modular this - but does nicely :-) */
		$('ul.limit_length>li').each( function(i) {
			if ( i > 10 ) {
				this.style.display = 'none';
			}
		} );

		$('ul.limit_length').append( '<li class="css_link">Show more<\/li>' );
		$('ul.limit_length li.css_link').click( function () {
			$('ul.limit_length li').each( function(i) {
				if ( i > 5 ) {
					this.style.display = 'list-item';
				}
			} );
			$('ul.limit_length li.css_link').css( 'display', 'none' );
		} );
	}
 	$(document).ready( function() {
 		fnFeaturesInit();
 		$('#products').dataTable( {
 			"bJQueryUI": true,
 			"sPaginationType": "full_numbers",
 			"bStateSave":true,
 			"sDom": '<"H"Tfr>t<"F"ip>',
 			"oTableTools": {
 				"sSwfPath": "/AST/EzComm/EzSales/Sales/Library/Script/TableTools-2.1.1/swf/copy_csv_xls_pdf.swf",
 				"aButtons": [
 				{
 				    "sExtends":    "csv",
 				    "sButtonText": "Download CSV"
 				}
 				]
 			}
 		} );
 	} );
		
	$(function()
	{
		var onSampleResized = function(e){
			var columns = $(e.currentTarget).find("th");
			var msg = "columns widths: ";
			columns.each()
		};

		$("#products").colResizable({
			liveDrag:true,
			gripInnerHtml:"<div class='grip'></div>",
			draggingClass:"dragging",
			onResize:onSampleResized
			});
	});
	function save()
	{
		var prod_code = document.getElementById("productCode").value;
		var type = document.getElementById("type").value;
		var status = document.getElementById("status").value;
		var webSKU = document.getElementById("webSKU").value;
		var upcCode = document.getElementById("upcCode").value;
		var brand = document.getElementById("brand").value;

		var model = document.getElementById("model").value;
		saveProduct(prod_code,type,status,webSKU,upcCode,brand,model);
		//alert(prod_code+"**"+type+"**"+status+"**"+webSKU+"**"+upcCode+"**"+brand+"**"+model);
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
	function saveProduct(prod_code,type,status,webSKU,upcCode,brand,model)
	{
		xmlhttp = GetXmlHttpObject();

		if(xmlhttp==null)
		{
			alert ("Your browser does not support Ajax HTTP");
			return;
		}

		Popup.showModal('modal');

		var url="../Catalog/ezAddProductsAjax.jsp";
		url=url+"?col1="+prod_code+"&col2="+type+"&col3="+status+"&col4="+webSKU+"&col5="+upcCode+"&col6="+brand+"&col7="+model;

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
			close();
		}
	}
	function close()
	{
		event.preventDefault();
		parent.$.fancybox.close();  
		$('saveForm').submit();

	}
</script>
</head>
<body>
<form name="saveForm" method='post'>
<div class="main-container col2-left-layout middle account-pages">
<div class="main">
<div class="col-main1 roundedCorners">
<div class="page-title">
<a class="fancybox" href="#addProduct">Add Product</a>
<div id="addProduct" style="display:none">
	<table class="data-table" id="addProducts" align="center">
	<tr>
		<td>Product Code:</td>
		<td><input type = "text" id = "productCode" name  = "productCode" value=""></td>
	</tr>
	<tr>
		<td>Type:</td>
		<td><input type = "text" id = "type" name  = "type"  value=""></td>
	</tr>
	<tr>
		<td>Status:</td>
		<td><input type = "text" id = "status" name  = "status"  value=""></td>
	</tr>
	<tr>
		<td>WEB SKU:</td>
		<td><input type = "text" id = "webSKU" name  = "webSKU"  value=""></td>
	</tr>
	<tr>
		<td>UPC CODE:</td>
		<td><input type = "text" id = "upcCode" name  = "upcCode"  value=""></td>
	</tr>
	<tr>
		<td>Brand:</td>
		<td><input type = "text" id = "brand" name  = "brand"  value=""></td>
	</tr>
	<tr>
		<td>Model:</td>
		<td><input type = "text" id = "model" name  = "model"  value=""></td>
	</tr>
	</table>
	<center><input type="Button" value="Save" onClick="save();"></center></td>
</div>
<table class="data-table" id="products">
	<thead>
	<tr>
		<th>Product Code</th>
		<th>Type</th>
		<th>Status</th>
		<th>WEB SKU</th>
		<th>UPC CODE</th>
		<th>Brand</th>
		<th>Model</th>
		
	</tr>
	</thead>
	<tbody>
<%
	for(int i=0;i<productsObj.getRowCount();i++)
	{		
		String prodCode		= productsObj.getFieldValueString(i,"EZP_PRODUCT_CODE");
		String prodType		= productsObj.getFieldValueString(i,"EZP_TYPE");
		String prodStatus	= productsObj.getFieldValueString(i,"EZP_STATUS");
		String webSku		= productsObj.getFieldValueString(i,"EZP_WEB_SKU");
		String upcCode		= productsObj.getFieldValueString(i,"EZP_UPC_CODE");
		String prodBrand	= productsObj.getFieldValueString(i,"EZP_BRAND");
		String prodModel	= productsObj.getFieldValueString(i,"EZP_MODEL");
%>		
		<tr>
			<td><a href="ezAddProducts.jsp?proCode=<%=prodCode%>"><%=prodCode%></a></td>
			<td><%=prodType%></td>
			<td><%=prodStatus%></td>
			<td><%=webSku%></td>
			<td><%=upcCode%></td>
			<td><%=prodBrand%></td>
			<td><%=prodModel%></td>
			
		</tr>
<%
	}
%>
	</tbody>
</table>
</div>
</div>
</div>
</div>
</form>
</body>
<%@ include file="../../../Includes/JSPs/Catalog/iCatalogList.jsp"%>
<%
	//out.println("catalogsListObj::"+catalogsListObj.toEzcString());
%>
<!-- jQuery for sorting & pagination STARTS here-->
 
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
 	#catalog_wrapper .fg-toolbar { font-size: 0.8em }
 	#theme_links span { float: left; padding: 2px 10px; }
 	#catalog_wrapper { -webkit-box-shadow: 2px 2px 6px #666; box-shadow: 2px 2px 6px #666; border-radius: 5px; }
 	#catalog tbody {
 		border-left: 1px solid #AAA;
 		border-right: 1px solid #AAA;
 	}
 	#catalog thead th:first-child { border-left: 1px solid #AAA; }
 	#catalog thead th:last-child { border-right: 1px solid #AAA; }
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

<script type="text/javascript">
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
 		$('#catalog').dataTable( {
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
</script>
<Script src="../../Library/Script/popup.js"></Script> 
<script type="text/javascript">
$(function(){

	var onSampleResized = function(e){
		var columns = $(e.currentTarget).find("th");
		var msg = "columns widths: ";
		columns.each()
	};

	$("#catalog").colResizable({
		liveDrag:true,
		gripInnerHtml:"<div class='grip'></div>",
		draggingClass:"dragging",
		onResize:onSampleResized
		
		
		});
	});
<script type="text/javascript"  src="DataTable.js"></script>
<script type="text/javascript" charset="utf-8">
	
			function restoreRow ( oTable, nRow )
			{
				var aData = oTable.fnGetData(nRow);
				var jqTds = $('>td', nRow);
				for ( var i=0, iLen=jqTds.length ; i<iLen ; i++ ) {
					oTable.fnUpdate( aData[i], nRow, i, false );
				}
				
				oTable.fnDraw();
			}
			
			function addRow ( oTable, nRow )
			{	
				var aData = oTable.fnGetData(nRow);
				var jqTds = $('>td', nRow);
				jqTds[0].innerHTML = '<input type="hidden" value="10010" >'+10010+'';
				jqTds[1].innerHTML = '<input type="text" value="'+aData[1]+'">';
				jqTds[2].innerHTML = '<a class="edit" href="">Save</a>';
			}
			
			function saveRow ( oTable, nRow )
			{
			
				var jqInputs = $('input', nRow);
				addRow_D(jqInputs[0].value,jqInputs[1].value);
				oTable.fnUpdate( jqInputs[0].value, nRow, 0, false );
				oTable.fnUpdate( jqInputs[1].value, nRow, 1, false );
				oTable.fnUpdate( '<a class="edit" href="">Edit</a>', nRow, 2, false );
				oTable.fnDraw();
			}
			
			function editRow ( oTable, nRow )
			{					
				var aData = oTable.fnGetData(nRow);
				var jqTds = $('>td', nRow);
				jqTds[0].innerHTML = '<input type="hidden" value="'+aData[0]+'">'+10010+'';
				jqTds[1].innerHTML = '<input type="text" value="'+aData[1]+'">';
				jqTds[2].innerHTML = '<a class="edit" href="">Update</a>';
			}
			
			function updateRow ( oTable, nRow )
			{
				
				var jqInputs = $('input', nRow);
				
				var col1 = $.trim(jqInputs[0].value);
				var col2 = $.trim(jqInputs[1].value);
				var col3 = $.trim(jqInputs[2].value);
				
				updateRow_D(col1,col2,col3);
				oTable.fnUpdate( col1, nRow, 0, false );
				oTable.fnUpdate( col2, nRow, 1, false );
				oTable.fnUpdate( '<a class="edit" href="">Edit</a>', nRow, 2, false );
				oTable.fnDraw();
			}
						
			function deleteRow ( oTable, nRow )
			{
				
			}
			
			var xmlhttp;
			function addRow_D(col1,col2)
			{
				xmlhttp = GetXmlHttpObject();
				
				if(xmlhttp==null)
				{
					alert ("Your browser does not support Ajax HTTP");
					return;
				}

				Popup.showModal('modal');

				var url="../Catalog/ezAddCatalogCategoryAjax.jsp";
				url=url+"?col1="+col1+"&col2="+col2;

				if(xmlhttp!=null)
				{
					xmlhttp.onreadystatechange=Process;
					xmlhttp.open("GET",url,true);
					xmlhttp.send(null);
				}
				else
					Popup.hide('modal');
			}
			
			function updateRow_D(col1,col2,col3)
			{
				
				xmlhttp = GetXmlHttpObject();

				if(xmlhttp==null)
				{
					alert ("Your browser does not support Ajax HTTP");
					return;
				}

				Popup.showModal('modal');

				var url="../Catalog/ezUpdateCatalogCategoryAjax.jsp";
				url=url+"?col1="+col1+"&col2="+col2+"&col3="+col3;

				if(xmlhttp!=null)
				{
					xmlhttp.onreadystatechange=Process_U;
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
			function Process_U()
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
			
			$(document).ready(function() {
				var oTable = $('#catalog').dataTable();
				var nEditing = null;
				
				$('#new').click( function (e) {
					e.preventDefault();
					var aData = oTable.fnGetData(nRow);
					var aiNew = oTable.fnAddData( [ '', '',  
						'<a class="edit" href="">Edit</a>', '<a class="delete" href="">Delete</a>' ] );
					var nRow = oTable.fnGetNodes( aiNew[0] );
					addRow( oTable, nRow );
					nEditing = nRow;
				} );
				
				$('#catalog a.delete').live('click', function (e) {
					e.preventDefault();
					//deleteRow(oTable,nRow);
					nEditing = nRow;
					var nRow = $(this).parents('tr')[0];
					oTable.fnDeleteRow( nRow );
				} );
				
				$('#catalog a.edit').live('click', function (e) {
					e.preventDefault();
					
					/* Get the row as a parent of the link that was clicked on */
					var nRow = $(this).parents('tr')[0];
					
					if ( nEditing !== null && nEditing != nRow ) {
						/* Currently editing - but not this row - restore the old before continuing to edit mode */
						restoreRow( oTable, nEditing );
						editRow( oTable, nRow );
						nEditing = nRow;
					}
					else if ( nEditing == nRow && this.innerHTML == "Save" ) {
						/* Editing this row and want to save it */
						saveRow( oTable, nEditing );
						nEditing = null;
					}
					else if ( nEditing == nRow && this.innerHTML == "Update" ) {
						/* Editing this row and want to save it */
						updateRow( oTable, nEditing );
						nEditing = null;
					}
					else if ( nEditing == nRow && this.innerHTML == "Delete" ) {
						/* Editing this row and want to save it */
						deleteRow( oTable, nEditing );
						nEditing = null;
					}
					else {
						/* No edit in progress - let's start one */
						editRow( oTable, nRow );
						nEditing = nRow;
					}
				} );
			} );
		
		
</script>
</head>
<body>
<form name="saveForm" method='post'>
<div id="modal" style="border:0px solid black; background-color:white; padding:1px; font-size:10;width:40%;height:180px; text-align:center; display:none;">
	<ul>
		<li>&nbsp;</li>
		<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
		<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
	</ul>
</div>
<div class="main-container col2-left-layout middle account-pages">
<div class="main">
<div class="col-main1 roundedCorners">
<div class="page-title">
<p><a id="new" href="">Add Category</a></p>
<table class="data-table" id="catalog">
	<thead>
	<tr>
		<th>Catalog Id</th>
		<th>Category Id</th>
		<th>Edit</th>
		<th>Delete</th>
	</tr>
	</thead>
	<tbody>
<%
	for(int i=0;i<catalogsListObj.getRowCount();i++)
	{		
		String catalogId = catalogsListObj.getFieldValueString(i,"ECC_CATALOG_ID");
		String categoryId = catalogsListObj.getFieldValueString(i,"ECC_CATEGORY_ID");
%>		
		<tr>
			<td><%=catalogId%></td>
			<td><%=categoryId%></td>
			<input type=hidden name=categoryId id=categoryId value='<%=categoryId%>'>
			<td><a class="edit" href="">Edit</a></td>
			<td><a class="delete" href="">Delete</a></td>
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
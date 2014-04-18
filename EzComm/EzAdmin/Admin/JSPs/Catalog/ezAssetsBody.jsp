<%@ include file="../../../Includes/JSPs/Catalog/iAssets.jsp"%>
<%
	//out.println("assetsObj::"+assetsObj.toEzcString());
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
 	#assets_wrapper .fg-toolbar { font-size: 0.8em }
 	#theme_links span { float: left; padding: 2px 10px; }
 	#assets_wrapper { -webkit-box-shadow: 2px 2px 6px #666; box-shadow: 2px 2px 6px #666; border-radius: 5px; }
 	#assets tbody {
 		border-left: 1px solid #AAA;
 		border-right: 1px solid #AAA;
 	}
 	#assets thead th:first-child { border-left: 1px solid #AAA; }
 	#assets thead th:last-child { border-right: 1px solid #AAA; }
 </style>
 <script type="text/javascript"  src="DataTable.js"></script>
 <script type="text/javascript" charset="utf-8"></script>
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
 		$('#assets').dataTable( {
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
<script type="text/javascript">
$(function(){

	var onSampleResized = function(e){
		var columns = $(e.currentTarget).find("th");
		var msg = "columns widths: ";
		columns.each()
	};

	$("#assets").colResizable({
		liveDrag:true,
		gripInnerHtml:"<div class='grip'></div>",
		draggingClass:"dragging",
		onResize:onSampleResized});

});
			function restoreRow ( oTable, nRow )
			{
				var aData = oTable.fnGetData(nRow);
				var jqTds = $('>td', nRow);
				
				for ( var i=0, iLen=jqTds.length ; i<iLen ; i++ ) {
					oTable.fnUpdate( aData[i], nRow, i, false );
				}
				
				oTable.fnDraw();
			}
			
			function editRow ( oTable, nRow )
			{
				var aData = oTable.fnGetData(nRow);
				var jqTds = $('>td', nRow);
				jqTds[0].innerHTML = '<input type="text" value="'+aData[0]+'">';
				jqTds[1].innerHTML = '<input type="text" value="'+aData[1]+'">';
				jqTds[2].innerHTML = '<input type="text" value="'+aData[2]+'">';
				jqTds[3].innerHTML = '<input type="text" value="'+aData[3]+'">';
				jqTds[4].innerHTML = '<a class="edit" href="">Save</a>';
			}
			
			function saveRow ( oTable, nRow )
			{
				var jqInputs = $('input', nRow);
				oTable.fnUpdate( jqInputs[0].value, nRow, 0, false );
				oTable.fnUpdate( jqInputs[1].value, nRow, 1, false );
				oTable.fnUpdate( jqInputs[2].value, nRow, 2, false );
				oTable.fnUpdate( jqInputs[3].value, nRow, 3, false );
				oTable.fnUpdate( '<a class="edit" href="">Edit</a>', nRow, 4, false );
				oTable.fnDraw();
			}
			
			$(document).ready(function() {
				var oTable = $('#assets').dataTable();
				var nEditing = null;
				
				$('#new').click( function (e) {
					e.preventDefault();
					
					var aiNew = oTable.fnAddData( [ '', '', '', '',
						'<a class="edit" href="">Edit</a>', '<a class="delete" href="">Delete</a>' ] );
					var nRow = oTable.fnGetNodes( aiNew[0] );
					editRow( oTable, nRow );
					nEditing = nRow;
				} );
				
				$('#assets a.delete').live('click', function (e) {
					e.preventDefault();
					
					var nRow = $(this).parents('tr')[0];
					oTable.fnDeleteRow( nRow );
				} );
				
				$('#assets a.edit').live('click', function (e) {
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
<div class="main-container col2-left-layout middle account-pages">
<div class="main">
<div class="col-main1 roundedCorners">
<div class="page-title">
<p><a id="new" href="">Add new row</a></p>
<table class="data-table" id="assets">
	<thead>
	<tr>
		<th>Asset Id</th>
		<th>Mime Type</th>
		<th>Content</th>
		<th>Link</th>
		<th>Edit</th>
		<th>Delete</th>
	</tr>
	</thead>
	<tbody>
<%
	for(int i=0;i<assetsObj.getRowCount();i++)
	{		
		String assetId	 = assetsObj.getFieldValueString(i,"EZA_ASSET_ID");
		String mimeType	 = assetsObj.getFieldValueString(i,"EZA_MIME_TYPE");
		String content	 = assetsObj.getFieldValueString(i,"EZA_CONTENT");
		String link	 = assetsObj.getFieldValueString(i,"EZA_LINK");
%>		
		<tr>
			<td>&nbsp;<%=assetId%></td>
			<td>&nbsp;<%=mimeType%></td>
			<td>&nbsp;<%=content%></td>
			<td>&nbsp;<%=link%></td>
			<td>&nbsp;<a class="edit" href="">Edit</a></td>
			<td>&nbsp;<a class="delete" href="">Delete</a></td>
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
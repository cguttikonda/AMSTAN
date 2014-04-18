<meta http-equiv="content-type" content="text/html; charset=utf-8">
	<link rel="shortcut icon" type="image/ico" href="http://www.sprymedia.co.uk/media/images/favicon.ico">

	<title>TableTools example</title>
	<style type="text/css" title="currentStyle">
		@import "../../media/css/demo_page.css";
		@import "../../media/css/demo_table_jui.css";
		@import "../../media/css/jquery-ui-1.8.4.custom.css";
		@import "../../media/css/TableTools_JUI.css";
		
	</style>
	<script type="text/javascript" charset="utf-8" src="../../media/js/jquery.js"></script>
	<script type="text/javascript" charset="utf-8" src="../../media/js/jquery.dataTables.js"></script>
	<script type="text/javascript" charset="utf-8" src="../../media/js/ZeroClipboard.js"></script>
	<script type="text/javascript" charset="utf-8" src="../../media/js/TableTools.js"></script>
	<script type="text/javascript" charset="utf-8">
		if(screen.width < 10)
		{
			$(document).ready(function() {
					 $('#example').dataTable({});
			} );
		}else{
		
			$(document).ready( function () {
							 oTable = $('#example').dataTable( {
								"bJQueryUI": true,
								"sPaginationType": "full_numbers",
								"sDom": '<"H"Tfr>t<"F"ip>',
								"oTableTools": {
									"sSwfPath": "../../media/swf/copy_csv_xls_pdf.swf",
									"aButtons": [
										{
											"sExtends":    "xls",
											"sButtonText": "Download as Excel",
											"sTitle": "My title", // Excel file name
											 "sToolTip": "Save as Excel"
			
										},
										{
											"sExtends":    "pdf",
											"sButtonText": "Download as PDF",
											"sTitle": "My title",
											 "sToolTip": "Save as PDF"
			
										}
			
											]
										}
							} );
			} );
		}
	function goBack()
	{
		document.myForm.action = "../Misc/ezSBUWelcome.jsp";
		document.myForm.submit();
	}
	</script>
	<style>
		button {
		   border-top: 1px solid #96d1f8;
		   background: #65a9d7;
		   background: -webkit-gradient(linear, left top, left bottom, from(#3e779d), to(#65a9d7));
		   background: -webkit-linear-gradient(top, #3e779d, #65a9d7);
		   background: -moz-linear-gradient(top, #3e779d, #65a9d7);
		   background: -ms-linear-gradient(top, #3e779d, #65a9d7);
		   background: -o-linear-gradient(top, #3e779d, #65a9d7);
		   padding: 5px 10px;
		   -webkit-border-radius: 9px;
		   -moz-border-radius: 9px;
		   border-radius: 9px;
		   -webkit-box-shadow: rgba(0,0,0,1) 0 1px 0;
		   -moz-box-shadow: rgba(0,0,0,1) 0 1px 0;
		   box-shadow: rgba(0,0,0,1) 0 1px 0;
		   text-shadow: rgba(0,0,0,.4) 0 1px 0;
		   color: white;
		   font-size: 13px;
		   font-family: Georgia, serif;
		   text-decoration: none;
		   vertical-align: middle;
		   }
		 button:hover {
		   border-top-color: #28597a;
		   background: #28597a;
		   color: #ccc;
		   }
		 button:active {
		   border-top-color: #1b435e;
		   background: #1b435e;
   		}
	</style>
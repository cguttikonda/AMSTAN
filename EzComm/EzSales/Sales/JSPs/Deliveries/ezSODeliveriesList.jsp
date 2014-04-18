
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<% String poNumber = request.getParameter("PurchaseOrder"); %>
<!DOCTYPE html>
<html lang="en">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<title>ASNs/Packing Slips</title>

<meta name="description" content="Default Description">
<meta name="robots" content="INDEX,FOLLOW">
<link rel="icon" href="../../Library/images/favicon.ico" type="image/x-icon">
<link rel="shortcut icon" href="../../Library/images/favicon.ico" type="image/x-icon"> 
 
<!--[if lt IE 7]> 
<script type="text/javascript">
//<![CDATA[ 
    var BLANK_URL = 'https://www.americanstandard.com/js/blank.html';
    var BLANK_IMG = 'https://www.americanstandard.com/js/spacer.gif';    
//]]>
</script>
<![endif]-->
<!-- **** FONTS **** --> 
<script type="text/javascript"> 
BASE_URL = 'http://www.americanstandard.com/';
SKIN_URL = 'http://www.americanstandard.com/skin/frontend/1/2/';
</script>

<style type="text/css">.tk-proxima-nova{font-family:"proxima-nova",sans-serif;}</style>  

<!--<link href="../../Styles/css" rel="stylesheet" type="text/css">-->

<!-- **** END FONTS **** -->

<link rel="stylesheet" type="text/css" href="../../Library/Styles/style0.css">
<link rel="stylesheet" type="text/css" href="../../Library/Styles/style1.css" media="all">
<link rel="stylesheet" type="text/css" href="../../Library/Styles/style2.css" media="print">

<!--[if lt IE 7]>
<script type="text/javascript" src="../../Library/Script/magentojscript-rbsitelink.js"></script>
<![endif]-->

<style type="text/css">
 .highlight {
                 height: 65px;
                 width: 100%;
                 background: #e9e9e9;
                 background: -webkit-linear-gradient(#e9e9e9, #c0c0c0);
                 background: -moz-linear-gradient(#e9e9e9, #c0c0c0);
                 background: -ms-linear-gradient(#e9e9e9, #c0c0c0);
                 background: -o-linear-gradient(#e9e9e9, #c0c0c0);
                 background: linear-gradient(#e9e9e9, #c0c0c0);
 }
 </style>
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
	#example_wrapper .fg-toolbar { font-size: 0.8em }
	#theme_links span { float: left; padding: 2px 10px; }
	#example_wrapper { -webkit-box-shadow: 2px 2px 6px #666; box-shadow: 2px 2px 6px #666; border-radius: 5px; }
	#example tbody {
		border-left: 1px solid #AAA;
		border-right: 1px solid #AAA;
	}
	#example thead th:first-child { border-left: 1px solid #AAA; }
	#example thead th:last-child { border-right: 1px solid #AAA; }
</style>

<script type="text/javascript" src="../../Library/Script/complete.min.js"></script>
<script type="text/javascript" src="../../Library/Script/jquery.dataTables.min.js"></script> 
<script type="text/javascript" src="../../Library/Script/TableTools-2.1.1/js/TableTools.min.js"></script> 

<script  src="../../Library/Script/colResizable-1.3.min.js"></script>
<Script src="../../Library/Script/popup.js"></Script> 
 


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
		$('#example').dataTable( {
			"bJQueryUI": true,
			"sPaginationType": "full_numbers",
			"aaSorting": [[ 1, "desc" ]],
			"bSort":true, 
			"sDom": '<"H"Tfr>t<"F"ip>',
			"oTableTools": {
				"sSwfPath": "/AST/EzComm/EzSales/Sales/Library/Script/TableTools-2.1.1/swf/copy_csv_xls_pdf.swf",
				"aButtons": [
				{
				    "sExtends":    "csv",
				    "sButtonText": " Download CSV "
		    
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

	$("#example").colResizable({
		liveDrag:true,
		gripInnerHtml:"<div class='grip'></div>",
		draggingClass:"dragging",
		onResize:onSampleResized});

});
</script>
</head>

<body class=" customer-account-index">
<div class="wrapper container" id="top-of-page">
	<noscript>
        &lt;div class="noscript"&gt;
            &lt;div class="noscript-inner"&gt;
                &lt;p&gt;&lt;strong&gt;JavaScript seem to be disabled in your browser.&lt;/strong&gt;&lt;/p&gt;
                &lt;p&gt;You must have JavaScript enabled in your browser to utilize the functionality of this website.&lt;/p&gt;
            &lt;/div&gt;
        &lt;/div&gt;
	</noscript>
	
<div class="page">
<%@ include file="../../../Includes/JSPs/Misc/iWelcomeAlerts.jsp"%>         
<%
	String helpKey	="EZSODELIVERYLIST";
%>
<%@ include file="../Misc/ezHeader.jsp"%>      
<%@ include file="../Misc/ezMenu.jsp"%>  
<% ezc.record.util.EzOrderedDictionary userAuth_R = Session.getUserAuth();
    if(userAuth_R.containsKey("SO_DLV_DTL")) {
 %>   
 <%@ include file="../Deliveries/ezSODeliveries.jsp"%> 
 <% } else { request.setAttribute("authKey","SO_DLV_DTL"); %>
 <%@ include file="../Misc/ezNoAuthorization.jsp"%> 
 <% } %>
<%@ include file="../Misc/ezFooter.jsp"%> 
</div>
</div>   
</body>
</html>    
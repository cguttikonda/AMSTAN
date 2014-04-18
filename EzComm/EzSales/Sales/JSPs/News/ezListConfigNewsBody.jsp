<%@ include file="../../../Includes/JSPs/News/iGetConfigNewsList.jsp"%>
<%
	//out.print("configNewsListObj:::::::::::****"+configNewsListObj.toEzcString());
	int configNewsListObjCount = configNewsListObj.getRowCount();
%>
<html>
<head>
<div class="main-container col2-left-layout middle account-pages">
<div class="hly-perftop"></div>
<div class="main">
<div class="col-main roundedCorners">
<div class="my-account">
<div class="dashboard">
<script src="../../Library/Script/jquery.js" type="text/javascript"></script>
<style>
	a {color:#5D87A1; text-decoration:none}
	a:hover {color:#ccc; text-decoration:none}
</style>
<style type="text/css">
#myInstance1abc1 {
	border: 2px solid #6699ff !important;
}
.nicEdit-selected {
	border: 2px solid #6699ff !important;
}
.nicEdit-panel {
	background-color: #fff !important;
}
.nicEdit-button {
	background-color: #fff !important;
}
</style>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="../../Library/Script/complete.min.js"></script>


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
<script type="text/javascript" src="../../Library/Script/jquery.dataTables.min.js"></script> 
<script type="text/javascript" src="../../Library/Script/TableTools-2.1.1/js/TableTools.min.js"></script> 
<script  src="../../Library/Script/colResizable-1.3.min.js"></script>
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
			"bStateSave":true,
			"bSort" : true
		} );
	   });
		
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
		onResize:onSampleResized
	});
});

function ezViewNews(newsSub,newsId,sysKey,newsText)
{
		document.myForm.hiddenText.value=newsText
		document.myForm.hiddenSub.value=newsSub
		document.myForm.newsId.value=newsId
		document.myForm.sysKey.value=sysKey
		document.myForm.action="ezListViewNewsMain.jsp"
		document.myForm.submit();
}
</script>

<!-- jQuery for sorting & pagination ENDS here -->
<link rel="stylesheet" type="text/css" href="../../Library/Styles/formalize.css">
<script type="text/javascript" src="../../Library/Script/jquery.formalize.js"></script>
<!--<link rel="stylesheet" type="text/css" href="../../Library/Styles/Alerts/jquery.alerts.css">
<script type="text/javascript" src="../../Library/Script/Alerts/jquery.alerts.js"></script>
<script type="text/javascript" src="../../Library/Script/jquery-ui-1.8.21.all.min.js"></script>
<Script language="JavaScript" src="../../Library/JavaScript/Misc/Trim.js"></Script>-->


</head>
<body>
<form name="myForm" id="myForm" method="post" onSubmit="return createNews()">
<div class="block" style="padding: 0px !important;">
	<div class="block-title"><strong><span>Configure News</span></strong></div>
</div>
<input type="hidden" name="hiddenText">
<input type="hidden" name="hiddenSub">
<input type="hidden" name="newsId">
<input type="hidden" name="sysKey">
<div class="col1-set">
<div class="info-box"><br>
	<table class="data-table" id="example">
	<thead>
		<Th>All News</Th>
	</thead>
	<tbody>
<%
		for (int i = 0 ; i< configNewsListObjCount; i++)
		{
			String newsId		= configNewsListObj.getFieldValueString(i,"EZN_ID");
			String newsSyskey	= configNewsListObj.getFieldValueString(i,"EZN_SYSKEY");
			String assiSoldTo	= configNewsListObj.getFieldValueString(i,"EZN_SOLDTO");
			String assiShipTo	= configNewsListObj.getFieldValueString(i,"EZN_SHIPTO");
			String createdOn	= configNewsListObj.getFieldValueString(i,"EZN_CREATED_DATE");
			String createdBy	= configNewsListObj.getFieldValueString(i,"EZN_CREATED_BY");
			String startDate_N	= configNewsListObj.getFieldValueString(i,"EZN_START_DATE");	
			String endDate_N	= configNewsListObj.getFieldValueString(i,"EZN_END_DATE");	
			String newsCat		= configNewsListObj.getFieldValueString(i,"EZN_CATEGORY");
			String newsType		= configNewsListObj.getFieldValueString(i,"EZN_NEWS_TYPE");
			String newsText		= configNewsListObj.getFieldValueString(i,"EZN_NEWS_TEXT");
				newsText	=	newsText.replaceAll("\'","`");
				newsText	=	newsText.replaceAll("\"","``");
			String newsSub		= configNewsListObj.getFieldValueString(i,"EZN_SUBJECT");
			String newsAuth		= configNewsListObj.getFieldValueString(i,"EZN_AUTH");
			String attachFlag	= configNewsListObj.getFieldValueString(i,"EZN_ATTACHMENTS");
%>
		<Tr>
			<td><h3 ><a href="javascript:ezViewNews('<%=newsSub%>','<%=newsId%>','<%=newsSyskey%>','<%=newsText%>')">
				  <%=newsSub%></a><p><small style="font-size: 10px !important;font-style: italic;color: #a0a0a0;text-transform: capitalize;">published on <%=createdOn%></small></p></h3> 
			</td>
		</Tr>
<%
		}
%>
	</tbody>
	</Table>
</div>
</div>
</div>
</div>
</div>
<div class="col-left sidebar roundedCorners" style="width:209px !important">
	<div class="block">
	<div class="block-title"><strong><span>News</span></strong></div>
	<div class="block-content">
	<ul>
		<li><a href="ezConfigureNews.jsp">Configure News</a></li>
		<li class="current"><Strong>News List</strong></li>
	</ul>
	</div>
	</div>
</div>
</div>
</div>
</form>
</body>
</html>
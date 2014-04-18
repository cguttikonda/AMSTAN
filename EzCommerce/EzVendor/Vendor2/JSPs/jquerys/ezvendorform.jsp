<%
	//String proCode	= request.getParameter("proCode");
	//session.putValue("PRODCODE",proCode.trim());
%>


<link rel="stylesheet" href="jquery-ui.css" type="text/css"/>
<script type="text/javascript" src="jquery-1.8.2.js"></script>
<script type="text/javascript" src="Library/Script/jquery-ui.js"></script>
<script>
$(document).ready(function() {

	$("#tab1").click(function(){
		$(".productInfo").fadeIn(1500);
     		});
	 $("#tab2").click(function(){
	         $(".productDesc").fadeIn(1500);
	      });
	 $("#tab3").click(function(){
	         $(".productDimensions").fadeIn(1500);
	      });
	 $("#tab4").click(function(){
	         $(".productImages").fadeIn(1500);
	      });
	 $("#tab5").click(function(){
	         $(".productStatus").fadeIn(1500);
	      });
	 $("#tab6").click(function(){
	 	 $(".productAttributes").fadeIn(1500);
	      });
	$(function() {
		$("#tabs").tabs();
	     });
   });
</script>
</head>
<body>
<form name="saveForm" method='post'>
<div class="main-container col2-left-layout middle account-pages">
<div class="main">
<div class="col-main1 roundedCorners" style="min-height:500px !important;">
<style>
#tabs ul li{float:left;}
</style>
<div id="tabs" style="width:0px !important;">
    <ul style="width:890px !important;">
            
	<li width="20px"><a style="width:110px;" href="#tabs-1" id="tab1">Information</a></li>
	<li width="20px"><a style="width:110px;" href="#tabs-2" id="tab2">Description</a></li>
	<li width="20px"><a style="width:110px;" href="#tabs-3" id="tab3">Dimensions</a></li>
	<li width="20px"><a style="width:110px;" href="#tabs-4" id="tab4">Images</a></li>
	<li width="20px"><a style="width:110px;" href="#tabs-5" id="tab5">Status</a></li>
	<li width="20px"  style="width:150px !important;"><a style="width:145px;" href="#tabs-6" id="tab6">Attributes</a></li>
            
            
        </ul>
        <div id="tabs-1" class="productInfo">
		<iframe src="ezProductInfo.jsp?prod=<%=proCode%>" frameborder="" name="productInfo" width="875" height="400" scrolling="no"></iframe>
        </div>
        <div id="tabs-2" class="productDesc">
		<iframe src="ezProductDesc.jsp?prod=<%=proCode%>" frameborder="" name="productDesc" width="875" height="400" scrolling="no"></iframe>
        </div>
        <div id="tabs-3" class="productDimensions">
		<iframe src="ezProductDimensions.jsp?prod=<%=proCode%>" frameborder="" name="productDimensions" width="875" height="400" scrolling="no"></iframe>
        </div>
        <div id="tabs-4" class="productImages">
		<iframe src="ezProductImages.jsp?prod=<%=proCode%>" frameborder="" name="productImages" width="875" height="400" scrolling="no"></iframe>
        </div>
        <div id="tabs-5" class="productStatus">
		<iframe src="ezProductStatus.jsp?prod=<%=proCode%>" frameborder="" name="productStatus" width="875" height="400" scrolling="no"></iframe>
        </div>
        <div id="tabs-6" class="productAttributes" style="height:470px !important; display:inline-block; overflow:no;">
		<iframe src="ezProductAttributes.jsp?prod=<%=proCode%>" frameborder="" name="productAttributes" width="890" height="470" scrolling="yes"></iframe>
        </div>
</div>
</div>
</div>
</div>
</form>
</body> 
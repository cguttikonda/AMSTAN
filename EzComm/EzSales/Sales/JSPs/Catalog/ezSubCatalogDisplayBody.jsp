<%@ include file="../../../Includes/JSPs/Catalog/iSubCatalogDisplay.jsp"%>
<!-- Add fancyBox -->
<link rel="stylesheet" href="../../Library/Script/jquery.fancybox.css?v=2.0.5" type="text/css" media="screen" />
<script type="text/javascript" src="../../Library/Script/jquery.fancybox.pack.js?v=2.0.5"></script>
<!-- end of fancybox -->

<script type="text/javascript">
$(document).ready( function() {		
$(".fancybox").fancybox();
} );
</script>
<%
	//out.println("subCatalogsListObj:::::::::::::::::"+subCatalogsListObj.toEzcString());
	String mainCatId = subCatalogsListObj.getFieldValueString(0,"PARENT_CAT_ID");
	String mainCatDesc = subCatalogsListObj.getFieldValueString(0,"PARENT_DESC");
	String mainCatParentDesc = subCatalogsListObj.getFieldValueString(0,"PARENT_TEXT");
	
	String mainCatParentDescPop="";
		if(mainCatParentDesc  != null) 
		{
			int catHeadLen=mainCatParentDesc.indexOf("<p>");
			if(catHeadLen!=-1)
			{
				mainCatParentDesc = mainCatParentDesc.substring(0,catHeadLen);
			}
	
		}
		
		if((mainCatParentDesc != null) && (mainCatParentDesc.length() > 500)) 
		{
			mainCatParentDescPop=mainCatParentDesc;
			mainCatParentDesc = mainCatParentDesc.substring(0,500);
		}

	String ordCatType = request.getParameter("ordCatTypeSub");
%>
<div class="main-container col2-left-layout">
<div class="main">
	<div class="breadcrumbs">
		<ul>
		<li class="home"><a href="../Misc/ezDashBoard.jsp" title="Go to Home Page">Home</a></li>
		<% if (!mainCatId.equalsIgnoreCase("DXVPRODUCTS")) { %>
		<li class="category3"><span>/&nbsp;</span><a href="../Catalog/ezCatalogDisplay.jsp" title="">Products Categories</a></li>
		<li class="category4"><span>/&nbsp;</span><a href="javascript:getSupCatalogList('<%=mainCatId%>','<%=mainCatDesc%>')" title=""><%=mainCatDesc%></a></li>
		<% } else { %>
		<li class="category3"><span>/&nbsp;</span><a href="javascript:getSupCatalogList('<%=mainCatId%>','<%=mainCatDesc%>')" title=""><%=mainCatDesc%></a></li>
		<% } %>
		</ul>
	</div>
<div class="col-main">
<div class="category-view">
<div id="category-wrapper">
<div>

<div style="width:100%; height:300px">
		<div style="width:49%; height:280px; float:left;">	
		<p align="justify"><%=mainCatParentDesc%>...
		
		<a class="fancybox" href="#catDescDisp"><span><strong>Learn More...</strong></span></a>
		<br><br>
		</div>
		<div id="catDescDisp" style="display: none; ">
		<h2>Category Description</h2>
		<br>
		<table width=100%>
		<tr>
		<th><p align="justify" ><%=mainCatParentDescPop%></p></th>
		</tr>
		</table>	
		</p>
		</div>
		
		<div style="width:49%; height:280px; float:right">
		<img src="Images/Categories/<%=mainCatId%>.jpg" width = "343" height="280" alt="<%=mainCatDesc%>" title"<%=mainCatDesc%>">
		
		</div>
	</div>



<script type="text/javascript">
	jQuery(document).ready(function() {
	jQuery('.jcarousel-tabs-rb > ul').jcarousel({
	visible: 4,
	scroll: 4,
	animation: 1200,
	itemFallbackDimension: 160,
	easing: 'easeInOutCubic'
	});
	});
</script>
</div>
</div>
<div id="adj-nav-container">
<div class="toolbar"></div>
<div class="category-products">
<script type="text/javascript">
	function getSubCatalogList(catId,catDesc,mainCatId,mainCatDesc)
	{
		document.catForm.categoryID.value=catId;
		document.catForm.categoryDesc.value=catDesc;
		
		document.catForm.mainCatID.value=mainCatId;
		document.catForm.mainCatDesc.value=mainCatDesc;

		document.catForm.action="ezProductsDisplay.jsp";
		document.catForm.submit();
	}
	function getSupCatalogList(supCatId,supCatDesc)
	{
		document.catForm.mainCatID.value=supCatId;
		document.catForm.mainCatDesc.value=supCatDesc;

		document.catForm.action="ezSubCatalogDisplay.jsp";
		document.catForm.submit();
	}

</script>
<form name="catForm" method="post">
<input type="hidden" name="categoryID">
<input type="hidden" name="categoryDesc">
<input type="hidden" name="mainCatID">
<input type="hidden" name="mainCatDesc">
<input type="hidden" name="catType" value="<%=ordCatType%>">
<%
	int cnt = 0;
	int uCnt = 3;
	
	

	for(int i=0;i<subCatalogsListObj.getRowCount();i++)
	{
		if(i%3==0)
		{
%>
			<ul class="products-grid">
<%
			uCnt++;
		}

		String css_class = "item";

		if(cnt==0) css_class = "item first";
		if(cnt==1) css_class = "item";
		if(cnt==2)
		{
			css_class = "item last";
			cnt = 0;
		}
		else
			cnt++;

		String categoryId 	= subCatalogsListObj.getFieldValueString(i,"SUB_CAT_ID");
		String categoryDesc 	= subCatalogsListObj.getFieldValueString(i,"SUB_CAT_DESC");
		String categoryLongDesc = subCatalogsListObj.getFieldValueString(i,"LONG_TEXT");

		if(categoryDesc==null || "null".equals(categoryDesc)) categoryDesc = "&nbsp";
		else
		{
			if(categoryLongDesc.length()>225)
				categoryLongDesc = categoryLongDesc.substring(0,225)+"...";
		}

		if(categoryLongDesc==null || "null".equals(categoryLongDesc)) categoryLongDesc = "&nbsp";
%>
		<li class="<%=css_class%>">
			<a href="javascript:getSubCatalogList('<%=categoryId%>','<%=categoryDesc%>','<%=mainCatId%>','<%=mainCatDesc%>')" title="<%=categoryDesc%>" class="product-image">
			<img src="<%=catImgHM.get(categoryId)%>" width="192" height="215" alt="<%=categoryDesc%>"></a>
			<h2 class="product-name"><a href="javascript:getSubCatalogList('<%=categoryId%>','<%=categoryDesc%>','<%=mainCatId%>','<%=mainCatDesc%>')"><%=categoryDesc%></a></h2>
			<p class="set-config"><%=categoryLongDesc%></p>
		</li>
<%
		if((i+1)%3==0)
		{
%>
			</ul>
<%
		}
	}
%>
	</ul>
</form>
	<script type="text/javascript">decorateGeneric($$('ul.products-grid'), ['odd','even','first','last'])</script>
</div>
<div class="toolbar-bottom">
<div class="toolbar">
<div class="back-to-top">
	<a onclick="jQuery('html, body').animate( { scrollTop: 0 }, 'slow');" href="javascript:void(0);" class="to-top"><span><span>Back to top</span></span></a>
</div>
</div>
</div>
<div class="adj-nav-progress" style="display:none">
<img src="" alt="Preloader">
</div>
</div>
</div>
<script type="text/javascript">
	// <![CDATA[
	jQuery(document).ready(function () {
	jQuery('#tabs').tabify();
	});
	// ]]>
</script>
<input type="hidden" id="adjnav-has-slide" value="0">
</div>
<div class="col-left sidebar">
<div class="ba-cms-left-block">
	<div class="layerednav-top">
	<% if (!mainCatId.equalsIgnoreCase("DXVPRODUCTS")) { %>
		<h3>sub-categories</h3>
	<% } else { %>	
		<h3>categories</h3>
	<% }; %>
	</div>
</div>
<div id="adj-nav-navigation">
<style>
a {color:#333; text-decoration:none}
a:hover {color:#000;font-weight:bold; text-decoration:none}
</style>
<script type="text/javascript">
	var personalizeSelected = false;

	function getProducts(catId,catDesc,mainCatId,mainCatDesc)
	{
		document.myForm.categoryID.value=catId;
		document.myForm.categoryDesc.value=catDesc;
		
		document.myForm.mainCatID.value=mainCatId;
		document.myForm.mainCatDesc.value=mainCatDesc;

		document.myForm.action="ezProductsDisplay.jsp";
		document.myForm.submit();
	}

</script>
<script type="text/javascript" src="../../Library/Script/adjnav-14.js"></script>
<input type="hidden" id="adjnav-attr-expand" value="Show More Attributes">
<input type="hidden" id="adjnav-attr-collapse" value="Show Less Attributes">
<input type="hidden" id="adjnav-attr-val-expand" value="Show More">
<input type="hidden" id="adjnav-attr-val-collapse" value="Show Less">
<div class="block block-layered-nav adj-nav">
<div class="block-content">
<div class="narrow-by">

<form name="myForm" method="post">
<input type="hidden" name="categoryID">
<input type="hidden" name="categoryDesc">
<input type="hidden" name="mainCatID">
<input type="hidden" name="mainCatDesc">
<input type="hidden" name="catType" value="<%=ordCatType%>">
	<input type="hidden" id="adj-nav-url" value="">
	<input type="hidden" id="adj-nav-params" value="">
	<input type="hidden" id="adj-nav-ajax" value="">
	<dl id="narrow-by-list">
	<dt class="adj-nav-dt odd"><li><%=mainCatDesc%></li></dt>
	<dd id="adj-nav-filter-set_configuration" class="odd">
	<ol style="overflow-x: hidden; overflow-y: hidden; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px; width: 190px; ">
<%
	for(int j=0;j<subCatalogsListObj.getRowCount();j++)
	{
		String subCategoryId 	= subCatalogsListObj.getFieldValueString(j,"SUB_CAT_ID");
		String subCategoryDesc 	= subCatalogsListObj.getFieldValueString(j,"SUB_CAT_DESC");
%>
		<li class="attr-val-featured">
		<a href="javascript:getProducts('<%=subCategoryId%>','<%=subCategoryDesc%>','<%=mainCatId%>','<%=mainCatDesc%>')"><%=subCategoryDesc%></a>
		</li>
<%
	}
%>
	</ol>
	</dd>
	</dl>
</form>
	<script type="text/javascript">
		decorateDataList('narrow-by-list');
		adj_nav_init();
	</script>
</div>
</div>
<div class="adj-nav-progress" style="display:none"></div>
</div>
<script type="text/javascript">
	if('function' == typeof(sns_layer_add_attr))
	{
		sns_layer_add_attr();
	}
	adj_nav_toolbar_init();

	//adjnavInitFeaturedValues();
	//adjnavInitFeaturedAttributes();

</script>
<script type="text/javascript">

jQuery(document).ready(function() {
jQuery('#narrow-by-list dd ol').jScrollPane({ verticalDragMaxHeight: 13, verticalDragMinHeight: 13 });
jQuery('.personalizer-attribute ol li').each(function(){

	if(jQuery('a', this).text() != "Yes"){
		jQuery(this).hide();
	}else{
		jQuery('a', this).text('Engrave');
		if(personalizeSelected){ jQuery('a', this).addClass('adj-nav-attribute-selected'); 
	}
		jQuery('dt.hidden-personalize-option').removeClass('hidden-personalize-option');
		jQuery('a',this).show();
	}
	});

	if(jQuery('.personalizer-attribute ol li').length < 2)
	{
		jQuery('.personalizer-attribute ol li').each(function()
		{
			if(jQuery('a',this).text() === "No")
			{
				jQuery(this).parent().parent().parent().parent().hide();
			}
		});
	}
});

</script>
</div>
</div>
</div>
</div>
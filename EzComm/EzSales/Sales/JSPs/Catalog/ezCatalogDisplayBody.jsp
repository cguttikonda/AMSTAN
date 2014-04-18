<%@ include file="../../../Includes/JSPs/Catalog/iCatalogList.jsp"%>
<div class="main-container col2-left-layout">
<div class="main">
	<div class="breadcrumbs">
		<ul>
		<li class="home"><a href="../Misc/ezDashBoard.jsp" title="Go to Home Page">Home</a></li>
		<li class="category3"><span>/&nbsp;</span><a href="../Catalog/ezCatalogDisplay.jsp" >Products Categories</a></li>
		</ul>
	</div>
<div class="col-main">
<div class="category-view">
<div id="adj-nav-container">
<div class="category-products">
<style>
a {color:#333; text-decoration:none}
a:hover {color:#50B4B6 !important; font-weight:bold; text-decoration:none}

</style>
<script type="text/javascript">
	function getSubCatalogList(catId,catDesc)
	{
		document.catForm.mainCatID.value=catId;
		document.catForm.mainCatDesc.value=catDesc;

		document.catForm.action="ezSubCatalogDisplay.jsp";
		document.catForm.submit();
	}
</script>
<form name="catForm" method="post">
<input type="hidden" name="mainCatID">
<input type="hidden" name="mainCatDesc">
<input type="hidden" name="ordCatTypeSub" value="<%=ordCatType%>">
<%
	int cnt = 0;
	int uCnt = 3;

	for(int i=0;i<catalogsListObj.getRowCount();i++)
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

		String categoryId = 	catalogsListObj.getFieldValueString(i,"CATEGORY_ID");			
		String categoryDesc = 	catalogsListObj.getFieldValueString(i,"CATEGORY_DESC");
		String categoryLongDesc = 	catalogsListObj.getFieldValueString(i,"LONG_TEXT");

		if(categoryDesc==null || "null".equals(categoryDesc)) categoryDesc = "&nbsp";
		else
		{
			if(categoryLongDesc.length()>200)
				categoryLongDesc = categoryLongDesc.substring(0,200)+"...";
		}

		if(categoryLongDesc==null || "null".equals(categoryLongDesc)) categoryLongDesc = "&nbsp";
%>
		<li class="<%=css_class%>">
			<a href="javascript:getSubCatalogList('<%=categoryId%>','<%=categoryDesc%>')" title="<%=categoryDesc%>" class="product-image">
			<img src="Images/Categories/<%=categoryId%>.jpg" width="192" height="215" alt="<%=categoryDesc%>"></a>
			<h2 class="product-name"><a href="javascript:getSubCatalogList('<%=categoryId%>','<%=categoryDesc%>')"><%=categoryDesc%></a></h2>
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
</form>
	<script type="text/javascript">decorateGeneric($$('ul.products-grid'), ['odd','even','first','last'])</script>
</div>
<div class="toolbar-bottom">
<div class="toolbar">
<div class="back-to-top">
<a onclick="jQuery('html, body').animate({ scrollTop: 0 }, 'slow');" href="javascript:void(0);" class="to-top"><span><span>Back to top</span></span></a>
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
		<h3>product categories</h3>
	</div>
</div>
<div id="adj-nav-navigation">
<script type="text/javascript">
	var personalizeSelected = false;

	function getProducts(catId,catDesc,supCatId,supCatDesc)
	{
		document.myForm.categoryID.value=catId;
		document.myForm.categoryDesc.value=catDesc;
		
		document.myForm.mainCatID.value=supCatId;
		document.myForm.mainCatDesc.value=supCatDesc;		

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
<%
	for(int i=0;i<catalogsListObj.getRowCount();i++)
	{
		String categoryId = 	catalogsListObj.getFieldValueString(i,"CATEGORY_ID");
		String categoryDesc = 	catalogsListObj.getFieldValueString(i,"CATEGORY_DESC");
%>
		<dt class="adj-nav-dt odd"><li><a href="javascript:getSubCatalogList('<%=categoryId%>','<%=categoryDesc%>')" title="<%=categoryDesc%>" class="product-image"><%=categoryDesc%></li></dt>
		
		<dd id="adj-nav-filter-set_configuration" class="odd">
		<ol style="overflow: auto:width: 190px; ">
<%
		for(int j=0;j<subCatalogsListObj.getRowCount();j++)
		{
			String parentCategoryId = 	subCatalogsListObj.getFieldValueString(j,"PARENT_CAT_ID");
			String subCategoryId 	= 	subCatalogsListObj.getFieldValueString(j,"SUB_CAT_ID");
			String subCategoryDesc 	= 	subCatalogsListObj.getFieldValueString(j,"SUB_CAT_DESC");

			//out.println(categoryId+"::::::::::::::::::"+parentCategoryId);			

			if(categoryId.equals(parentCategoryId))
			{
%>
				<li class="attr-val-featured">
				<a href="javascript:getProducts('<%=subCategoryId%>','<%=subCategoryDesc%>','<%=categoryId%>','<%=categoryDesc%>')"><%=subCategoryDesc%></a>
				</li>
<%
			}
		}	
%>
		</ol>
		</dd>
<%
	}
%>
	</dl>
</form>
	<script type="text/javascript">
		decorateDataList('narrow-by-list');
		adj_nav_init();
	</script>
</div>
</div>
<div class="adj-nav-progress" style="display:none">
</div>
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

			if(personalizeSelected)
			{
				jQuery('a', this).addClass('adj-nav-attribute-selected'); 
			}
			jQuery('dt.hidden-personalize-option').removeClass('hidden-personalize-option');
			jQuery('a',this).show();
		}
	});

	if(jQuery('.personalizer-attribute ol li').length < 2){

		jQuery('.personalizer-attribute ol li').each(function(){
			if(jQuery('a',this).text() === "No"){
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
</div>
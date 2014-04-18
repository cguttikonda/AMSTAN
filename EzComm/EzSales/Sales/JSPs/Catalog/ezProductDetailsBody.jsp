<html>
<head>
  <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
  <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script>
  <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>
  
  <script type="text/javascript">
  $(document).ready(function() {
    $("#tabs").tabs();
  });
  
 function addToCart()
{
	var subUser = '<%=session.getValue("IsSubUser")%>'
	alert("subUser:::::"+subUser)
	if(subUser=='Y')
	{
		var subAuth = '<%=session.getValue("SuAuth")%>'
		if(subAuth=='VONLY')
		{
			alert("You are not authorised to add products to Cart.")
			return;
		
		}
	}	
	document.myForm.action="../ShoppingCart/ezViewCart.jsp";
	document.myForm.submit();
}


$(document).ready(function() {

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
        $(id).css('top',  winH/3-$(id).height()/3);
        $(id).css('left', winW/3-$(id).width()/3);

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

function iframeDisplay()
{	
	var url;
	var atpfor = document.myForm.atpfor.value;
	var atpqty = document.myForm.atpqty.value;
	var atpon=document.myForm.atpon.value;
	var stAtp=document.myForm.stAtp.value;
	url = "../Misc/ezATPCheck.jsp?atpfor="+atpfor+"&atpon="+atpon+"&atpqty="+atpqty+"&stAtp="+stAtp;
	var iframeObj = document.getElementById("atpIFrame");
	iframeObj.src = url;
	//window.frames['atpIFrame'].location.reload(); 
	iframeObj.src = iframeObj.src
}

</script>
</head>
<style>
a {color:#333; text-decoration:none}
a:hover {color:#ccc; text-decoration:none}

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
  width:980px;
  height:530px;
  display:none;
  z-index:9999;
  padding:20px;
}

#boxes #dialog {
  width:980px;
  height:542px;
  padding:10px;
  background-color:#000;
}
</style>

<%@ include file="../../../Includes/JSPs/Catalog/iProductDetails.jsp"%>
<%

	String atpon   = request.getParameter("atpon");
	if(atpon==null || "null".equalsIgnoreCase(atpon)) atpon = cMonth_S+"/"+cDate_S+"/"+cYear;
	
	//out.println(prodDetailsRetObj.toEzcString());
	String prodCode = nullCheck(prodDetailsRetObj.getFieldValueString(0,"EZP_PRODUCT_CODE"));
	String prodDesc = nullCheck(prodDetailsRetObj.getFieldValueString(0,"PROD_DESC"));
	String prodModel = nullCheck(prodDetailsRetObj.getFieldValueString(0,"EZP_MODEL"));
	String prodPrice = nullCheck(prodDetailsRetObj.getFieldValueString(0,"EZP_CURR_PRICE"));
	String webSKU = nullCheck(prodDetailsRetObj.getFieldValueString(0,"EZP_PRODUCT_CODE"));//EZP_WEB_SKU
	String eanUpc = nullCheck(prodDetailsRetObj.getFieldValueString(0,"EZP_UPC_CODE"));
%>
<form name="myForm" method="post">
<input type="hidden" name="prodIden" value="1">
<input type="hidden" name="categoryID" value="<%=categoryID%>">
<input type="hidden" name="prodDesc_1" value="<%=prodDesc%>">
<input type="hidden" name="prodCode_1" value="<%=webSKU%>">
<input type="hidden" name="listPrice_1" value="<%=prodPrice%>">
<input type="hidden" name="eanUpc_1" value="<%=eanUpc%>">

<input type="hidden"  id="atpfor" name="atpfor" value="<%=prodCode%>" />
<input type="hidden"  id="atpon" name="atpon" value="<%=atpon%>" />
<input type="hidden"  id="stAtp" name="stAtp" value="<%=session.getValue("shipState")%>" />
<div class="main-container col1-layout">
<div class="main">
<!--<div class="breadcrumbs">
	<ul>
	<li class="home"><a href="../Misc/ezDashBoard.jsp" title="Go to Home Page">Home</a><span>/ </span></li>
	<li class="category3"><a href="../Catalog/ezCatalogDisplay.jsp" title="">Products Types</a><span>/ </span></li>
	<li class="category4"><a href="javascript:void(0)" title="">&nbsp;</a><span>/ </span></li>
	<li class="category5"><a href="javascript:void(0)" title="">&nbsp;</a><span>/ </span></li>
	<li class="category5">&nbsp;</li>
	</ul>
</div>-->
<div class="col-main">
	<script type="text/javascript">
		var optionsPrice = new Product.OptionsPrice([]);
	</script>
<div id="messages_product_view"></div>
<div class="product-view">
<!-- TOP TABS -->
<div id="tabs">

	<ul>
	<li ><a href="#contentDetail">Item Details</a></li>
	<li ><a href="#contentLinks">Downloads</a></li>
	
	</ul>

<!-- ITEM DETAILS -->
<div class="content" id="contentDetail">
<div class="inner-detail">

<div class="no-display">
	<input type="hidden" name="product" value="<%=prodCode%>" />
	<input type="hidden" name="related_product" id="related-products-field" value="" />
</div>
<div class="product-shop">
	<div class="product-name">
		<h1><%=prodDesc%></h1>
	</div>
	<div class="short-description">
		<div class="std">Model #:<%=prodModel%></div>
	</div>
	<span class="grey-item">SKU# <%=prodCode%> </span>
	<div class="price-box">
		<span class="top-price-wrapper">List Price:
			<span class="regular-price" id="product-price-1310">
				<span class="price">$<%=prodPrice%></span>
			</span>
		</span>
		<span class="top-price-wrapper">300 point Price:
			<span class="regular-price" id="product-price-1310">
				<span class="price">$55.00</span>
			</span>
		</span>
	</div>

<div class="clearer"></div>
<!--Qty, Wishlist Compare-->
<div class="add-to-box">
<div class="add-to-cart">
	<label for="qty">Qty:</label>
	<input type="text" name="atpqty" id="qty" maxlength="12" value="1" title="Qty" class="input-text qty" />
	<button type="button" title="Add to Cart" class="button btn-cart" onclick="javascript:addToCart()"><span><span>Add to Cart</span></span></button>
	
</div>
<a href="#dialog" name="modal"><button type="button"  title="Check ATP" onClick="iframeDisplay()" class="button btn-cart"><span>check ATP</span></button></a>

<a href="javascript: history.go(-1)"><button type="button" class="button btn-update"><span>Back</span></button></a>

</div>
<!--    Price added to view-->

<div id="boxes">

<div id="dialog" class="window">
<a href="#" class="close"/><font color=white>[x] Close</font></a>
<iframe id="atpIFrame" width="980" height="530"></iframe>

</div>
<div id="mask"></div>
</div>

<div class="product-collateral">
	<div class="box-collateral box-description">
		<br><h2>Details</h2>
		<div class="std">
		&nbsp;
		<ul>
			<li>&nbsp;</li>
		</ul>
		</div>
	</div>
</div>
</div>
<div class="product-img-box">
	<a class="product-image MagicZoom" id="zoom" title="" href="" rel="selectors-mouseover-delay: 200; zoom-width: 530; zoom-height: 510; zoom-window-effect: false; show-title: false; selectors-effect: fade; zoom-distance:55; ">
	<img src="" height="340" width="310" alt="" /></a>
<div id="yourzoom" style="position:absolute; top:0px; left:0px;"></div>
<div class="more-views">
	<ul>
		<li><a href="" rel="zoom-id:zoom;" rev="" title="">
		<img src="" alt="" width="47" height="57" /></a></li>
        </ul>
</div>
</div>
<div class="clearer"></div>

</div>
</div>
<!--END ITEM DETAILS-->
<!--SCENE 7 PERSONALIZER-->
<!--END SCENE 7 PERSONALIZER-->
<div class="content" id="contentLinks">
<div class="inner-contentlinks">
	<h2>More &amp; Informtion</h2>
	<ul>
		<li>More Information here</li>
		<li></li>
		<li></li>
	</ul>
	<!--<p class="email-friend"><a href=""></a></p>-->
</div>
</div>
</div>
<!-- END TOP TABS -->
<!-- RELATED TABS -->
<div class="baRelatedProducts">
<div id="related-tabs-title">Related Items.</div>
<div class="related-tabs">
	<ul id="tabsRel">
	<li class="active"><a href="#contentRel0">Similar</a></li>
	<li ><a href="#contentRel1">Competitor</a></li>
	</ul>
</div>
<div class="content" id="contentRel0">
<div class="box-collateral box-related">
	<ul class="block-content ">
	<li class="item row-count-1">
	<div class="item-info">
		<a href="http://www.reedandbarton.com/flatware/sterling-flatware/18th-century-butter-serving-knife" class="product-image">
		<img src="./ezs-rb-myaccount_files/1338_prd_s_002.jpg" width="192" height="215" alt="18th Century Butter Serving Knife" title="18th Century Butter Serving Knife" /></a>
		<div class="product-details">
			<h3 class="product-name"><a href="http://www.reedandbarton.com/flatware/sterling-flatware/18th-century-4-piece-place-set">24" Standard Collection Towel Bar w/Glass Shelf</a></h3>
			<!--subtitle attribute-->
			<h4 class="related-sku">Model#:6726, 6726S, M923031-007A, M962233-0070A</h4>
			<!-- SKU-->
			<h4 class="related-sku"><span class="grey-item"> Item &#35; 12345 </span></h4>
			<div class="price-box">
			<span class="top-price-wrapper">List Price:
				<span class="regular-price" id="product-price-1308-related">
					<span class="price">$164.00</span>
				</span>
			</span>
			<span class="top-price-wrapper">300 Point Price:
				<span class="regular-price" id="product-price-1308-related">
					<span class="price">$73.00</span>
				</span>
			</span>
		        </div>
			<div class="add-to-links">
				<input type="checkbox" class="compare-check"  data-product-id="1308" />
				<label class="compare-label compare-link">Compare</label>
			</div>
			<div class="add-to-cart">
				<label for="qty1308">Qty:</label>
				<input type="text" name="qty" id="qty1308" maxlength="12" value="1" title="Qty" class="input-text qty" />
			</div>
			<div class="order-input">
				<input type="checkbox" class="checkbox related-checkbox ba-add-to-cart-related-checkbox" id="related-checkbox1308" name="related_products[]" value="1308" />
				<span class="rel-add-to">Add to my order</span>
			</div>
		</div>
	</div>
	</li>
	<li class="item row-count-1">
	<div class="item-info">
		<a href="http://www.reedandbarton.com/flatware/sterling-flatware/18th-century-butter-serving-knife" class="product-image">
		<img src="./ezs-rb-myaccount_files/1338_prd_s_002.jpg" width="192" height="215" alt="18th Century Butter Serving Knife" title="18th Century Butter Serving Knife" /></a>
		<div class="product-details">
			<h3 class="product-name"><a href="http://www.reedandbarton.com/flatware/sterling-flatware/18th-century-4-piece-place-set">24" Standard Collection Towel Bar w/Glass Shelf</a></h3>
			<!--subtitle attribute-->
			<h4 class="related-sku">Model#:6726, 6726S, M923031-007A, M962233-0070A</h4>
			<!-- SKU-->
			<h4 class="related-sku"><span class="grey-item"> Item &#35; 12345 </span></h4>
			<div class="price-box">
			<span class="top-price-wrapper">List Price:
				<span class="regular-price" id="product-price-1308-related">
					<span class="price">$164.00</span>
				</span>
			</span>
			<span class="top-price-wrapper">300 Point Price:
				<span class="regular-price" id="product-price-1308-related">
					<span class="price">$73.00</span>
				</span>
			</span>
			</div>
			<div class="add-to-links">
				<input type="checkbox" class="compare-check"  data-product-id="1308" />
				<label class="compare-label compare-link">Compare</label>
			</div>
			<div class="add-to-cart">
				<label for="qty1308">Qty:</label>
				<input type="text" name="qty" id="qty1308" maxlength="12" value="1" title="Qty" class="input-text qty" />
			</div>
			<div class="order-input">
				<input type="checkbox" class="checkbox related-checkbox ba-add-to-cart-related-checkbox" id="related-checkbox1308" name="related_products[]" value="1308" />
				<span class="rel-add-to">Add to my order</span>
			</div>
		</div>
	</div>
	</li>
	</ul>
	<script type="text/javascript">decorateGeneric($$('ul.block-content li'), ['odd','even','first','last'])</script>
</div>
</div>
<div class="content" id="contentRel1">
	<div class="box-collateral box-related">
		<script type="text/javascript">decorateGeneric($$('ul.block-content li'), ['odd','even','first','last'])</script>
		<ul class="block-content additional-related">
		</ul>
		<script type="text/javascript">decorateGeneric($$('ul.block-content li'), ['odd','even','first','last'])</script>
	</div>
</div>
<div class="content" id="contentRel2">
<div class="box-collateral box-related">
	<script type="text/javascript">decorateGeneric($$('ul.block-content li'), ['odd','even','first','last'])</script>
	<script type="text/javascript">decorateGeneric($$('ul.block-content li'), ['odd','even','first','last'])</script>
</div>
</div>
</div>
<div class="related-atc">
	<div id="ba-add-to-cart" class="add-to-cart" data-url="http://www.reedandbarton.com/baCheckout/cart/baUpdate/">
		<button id="ba-add-to-cart-button" type="button" title="Update Cart" class="button btn-cart"><span><span>Update Cart</span></span></button>
	</div>
	<div id="ba-cart-update-message" class="ba-cart-update-message" style="display:none"></div>
	<div id="ba-cart-update-wait" class="ba-cart-update-wait" style="display:none">
		<img src="http://www.reedandbarton.com/skin/frontend/blueacorn/blueacorn_rb/images/ajax-loader.gif" alt="Please Wait..."/>
	</div>
</div>
<script>new BaRelatedProductTabs();</script>
<!-- END RELATED TABS -->
<div class="compare-controls"> <a href="#" id="compare-link" class="compare-link" data-count="0"> Compare Your Selections		<span>[&nbsp; <span class="x-out">0</span> &nbsp;]</span></a>
		 &nbsp;|&nbsp; 
		<a href="#" id="compare-clear">[&nbsp;<span class="x-out">x</span>&nbsp;] Clear All</a> </div>
	<script type="text/javascript">
        new AddToCompare('compare-check', 'compare-link', 'compare-clear');
    </script> 
	<script type="text/javascript">
        // <![CDATA[

        jQuery(document).ready(function($) {
            $('#tabs, #tabsRel').tabify();
            
            $('#personalize-tab a').click(function(){
                $('.baRelatedProducts, .related-atc').hide();
                $('.baRelatedProducts, .related-atc').addClass('hidden-products');
            });
            
            $('#item-details-tab a, #care-and-use-tab a').click(function(){
                $('.baRelatedProducts, .related-atc').show();
                $('.baRelatedProducts, .related-atc').removeClass('hidden-products');
            });
            
            if ($('#personalize-tab').hasClass('active') == true) {
                $('.baRelatedProducts, .related-atc').hide();
                $('.baRelatedProducts, .related-atc').addClass('hidden-products');
            }
            
            if ($('ul.messages li').length > 0) {
                $('.breadcrumbs').css('top', '60px');
            }
        });

        // ]]>
    </script> 
</div>
<script type="text/javascript">
    //<![CDATA[
    var productAddToCartForm = new VarienForm('product_addtocart_form');
    productAddToCartForm.submit = function(button, url) {
        if (this.validator.validate()) {
            var form = this.form;
            var oldUrl = form.action;

            if (url) {
                form.action = url;
            }
            var e = null;
            try {
                this.form.submit();
            } catch (e) {
            }
            this.form.action = oldUrl;
            if (e) {
                throw e;
            }

            if (button && button != 'undefined') {
                button.disabled = true;
            }
        }
    }.bind(productAddToCartForm);

    productAddToCartForm.submitLight = function(button, url){
        if(this.validator) {
            var nv = Validation.methods;
            delete Validation.methods['required-entry'];
            delete Validation.methods['validate-one-required'];
            delete Validation.methods['validate-one-required-by-name'];
            if (this.validator.validate()) {
                if (url) {
                    this.form.action = url;
                }
                this.form.submit();
            }
            Object.extend(Validation.methods, nv);
        }
    }.bind(productAddToCartForm);
    
    if (!$$('#product_addtocart_form input[data-attribute-name^="s7"]').any(Field.present)) {
        $$('.per-button').invoke('update', Translator.translate('Personalize'));
    }
    //]]>
        
</script> 
</div>
</div>
</div>



</form>
</html>
<%!
	public String nullCheck(String str)
	{
		String ret = str;

		if(ret==null || "null".equalsIgnoreCase(ret) || "".equals(ret))
			ret = "N/A";

		return ret;
	}
%>
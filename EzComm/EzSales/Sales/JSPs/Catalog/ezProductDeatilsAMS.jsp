<!doctype html>
<head>
<title></title>

<script>
function addToCart()
{
	document.myFormD.action="../ShoppingCart/ezAddCartQuickEntry.jsp";
	document.myFormD.submit();
}
function addToCart_D(num)
{
	document.myFormD.prodIden.value=num;

	document.myFormD.action="../ShoppingCart/ezAddCartItems.jsp";
	document.myFormD.submit();
}
</script>

<script type="text/javascript" src="../../Library/Script/LightBox.js"></script>

<script>
jQuery(document).ready(function() {

    //select all the a tag with name equal to modal
    jQuery('a[name=modal]').click(function(e) {
        //Cancel the link behavior
        e.preventDefault();

        //Get the A tag
        var id = jQuery(this).attr('href');

        //Get the screen height and width
        var maskHeight = jQuery(document).height();
        var maskWidth = jQuery(window).width();

        //Set heigth and width to mask to fill up the whole screen
        jQuery('#mask').css({'width':maskWidth,'height':maskHeight});

        //transition effect
        jQuery('#mask').fadeIn(1000);
        jQuery('#mask').fadeTo("slow",0.8);

        //Get the window height and width
        var winH = jQuery(window).height();
        var winW = jQuery(window).width();

        //Set the popup window to center
        jQuery(id).css('top',  winH/2-jQuery(id).height()/2);
        jQuery(id).css('left', winW/2-jQuery(id).width()/2);

        //transition effect
        jQuery(id).fadeIn(2000);

    });

    //if close button is clicked
    jQuery('.window .close').click(function (e) {
        //Cancel the link behavior
        e.preventDefault();

        jQuery('#mask').hide();
        jQuery('.window').hide();
    });
});

function iframeDisplay()
{	
	var url;
	var atpfor = document.myFormD.atpfor.value;
	var atpqty = document.myFormD.atpqty.value;
	var atpon=document.myFormD.atpon.value;
	var stAtp=document.myFormD.stAtp.value;
	url = "../Misc/ezATPCheck.jsp?atpfor="+atpfor+"&atpon="+atpon+"&atpqty="+atpqty+"&stAtp="+stAtp;
	var iframeObj = document.getElementById("atpIFrame");
	iframeObj.src = url;	
	//window.frames['atpIFrame'].location.reload(); 
	iframeObj.src = iframeObj.src	
}

</script>
</head>


<style>

/*#mask {
  position:absolute;
  left:0;
  top:0;
  z-index:9000;
  background-color:#000;
  display:none;
}*/

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
	String prodCode  = nullCheck(prodDetailsRetObj.getFieldValueString(0,"EZP_PRODUCT_CODE"));
	String prodDesc  = nullCheck(prodDetailsRetObj.getFieldValueString(0,"EPD_PRODUCT_DESC"));
	String prodModel = nullCheck(prodDetailsRetObj.getFieldValueString(0,"EZP_MODEL"));
	String prodPrice = nullCheck(prodDetailsRetObj.getFieldValueString(0,"EZP_CURR_PRICE"));
	String webSKU 	 = nullCheck(prodDetailsRetObj.getFieldValueString(0,"EZP_PRODUCT_CODE"));//EZP_WEB_SKU
	String eanUpc 	 = nullCheck(prodDetailsRetObj.getFieldValueString(0,"EZP_UPC_CODE"));
	
	String prodDet   = nullCheck(prodDetailsRetObj.getFieldValueString(0,"EPD_PRODUCT_DETAILS"));
	String prodProp1 = nullCheck(prodDetailsRetObj.getFieldValueString(0,"EPD_PRODUCT_PROP1"));
	String prodProp2 = nullCheck(prodDetailsRetObj.getFieldValueString(0,"EPD_PRODUCT_PROP2"));
	String prodProp3 = nullCheck(prodDetailsRetObj.getFieldValueString(0,"EPD_PRODUCT_PROP3"));
	String prodProp4 = nullCheck(prodDetailsRetObj.getFieldValueString(0,"EPD_PRODUCT_PROP4"));
	String prodProp5 = nullCheck(prodDetailsRetObj.getFieldValueString(0,"EPD_PRODUCT_PROP5"));
	String prodProp6 = nullCheck(prodDetailsRetObj.getFieldValueString(0,"EPD_PRODUCT_PROP6"));
%>
<body class=" catalog-product-view catalog-product-view product-pointed-antique-5-piece-place-set categorypath-flatware-sterling-flatware category-sterling-flatware">
<form method="post" name="myFormD" id="product_addtocart_form">
<input type="hidden" name="prodIden">
<input type="hidden" name="categoryID" value="<%=categoryID%>">
<input type="hidden" name="prodDesc_1" value='<%=prodDesc%>'>
<input type="hidden" name="prodCode_1" value="<%=webSKU%>">
<input type="hidden" name="listPrice_1" value="<%=prodPrice%>">
<input type="hidden" name="eanUpc_1" value="<%=eanUpc%>">

<input type="hidden"  id="atpfor" name="atpfor" value="<%=prodCode%>" />
<input type="hidden"  id="atpon" name="atpon" value="<%=atpon%>" />
<input type="hidden"  id="stAtp" name="stAtp" value="<%=session.getValue("shipState")%>" />

<div class="main-container col1-layout">
<div class="main">
<div class="col-main">
<div id="messages_product_view"></div>
<div class="product-view">

	<!-- TOP TABS -->

	<div class="product-essential">

		<div class="tabs-container">
		<ul id="tabs">
			<li id="item-details-tab" class="active"><a href="#contentDetail">Item Details</a></li>
	        	<li id="care-and-use-tab"><a href="#contentLinks">Downloads</a></li>
	        	<li id="repair-parts-tab"><a href="#contentParts">Repair Parts</a></li>
	        	<li id="colors-finishes-tab"><a href="#contentColors">Colors/Finishes</a></li>
	        </ul>
		</div>

		<!-- ITEM DETAILS -->
		<div class="content" id="contentDetail">
			<div class="inner-detail">
			<h2>Item Details</h2>
				
					<div class="no-display">
						<input type="hidden" name="product" value="1300" />
						<input type="hidden" name="related_product" id="related-products-field" value="" />
					</div>
					<div class="product-shop">

						<div class="product-name">
							<h1><%=prodDesc%></h1>
						</div>

						<div class="short-description">
							<div class="std">Model #:<%=prodModel%></div>
						</div>

						

			<span class="grey-item">PROD# <%=prodCode%> </span>
				<div class="price-box">
					<span class="top-price-wrapper">List Price:
						<span class="regular-price" id="product-price-1310">
							<span class="price">$<%=eliminateDecimals(prodPrice)%></span>
						</span>
					</span>
					<span class="top-price-wrapper">300 point Price:
						<span class="regular-price" id="product-price-1310">
							<span class="price">$55.00</span>
						</span>
					</span>
				</div>
	
			<div class="clearer"></div>

		<div class="add-to-box">
		<div class="add-to-cart">
			<label for="qty">Qty:</label>
			<input type="text" name="atpqty" id="atpqty" maxlength="5" value="1" title="Qty" class="input-text qty" />
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
	<br>
    <h2>Details</h2>
    <div class="std">
    
<%
	boolean bool=true;
	if("N/A".equals(prodDet))
	{
    		prodDet = "No Details available for selected product.";
    		bool=false;
    	}
    	
%>
        <%=prodDet%>
        <ul>
<%	if(bool)     
	{
%>
		<li><%=prodProp1%></li>
		<li><%=prodProp2%></li>
		<li><%=prodProp3%></li>
		<li><%=prodProp4%></li>
<%      }
%>
        </ul>    
       </div>
 </div>
			<!--Reviews-->

			<div class="add_this_box">

			</div>
			</div>
		</div>
<%		String imageDisLarge="",imageDisSTD="",imageDisThumb="";
		String mainDisLarge="",mainDisSTD="",mainDisThumb="";
		int indDisLarge=0,indDisSTD=0,indDisThumb=0;
		if(prodDetailsRetObjDWN!=null && prodDetailsRetObjDWN.getRowCount()>0)
		{
			for(int ims=0;ims<prodDetailsRetObjDWN.getRowCount();ims++)
			{			
				imageDisLarge = prodDetailsRetObjDWN.getFieldValueString(ims,"EZA_ASSET_ID");
				if(imageDisLarge!=null && !"".equals(imageDisLarge) && !"null".equals(imageDisLarge))
				{
					indDisLarge = imageDisLarge.indexOf("LG");
				}
				imageDisSTD = prodDetailsRetObjDWN.getFieldValueString(ims,"EZA_ASSET_ID");
				if(imageDisSTD!=null && !"".equals(imageDisSTD) && !"null".equals(imageDisSTD))
				{
					indDisSTD = imageDisSTD.indexOf("ST");
				}
				imageDisThumb = prodDetailsRetObjDWN.getFieldValueString(ims,"EZA_ASSET_ID");
				if(imageDisThumb!=null && !"".equals(imageDisThumb) && !"null".equals(imageDisThumb))
				{
					indDisThumb = imageDisThumb.indexOf("SU");
				}

				if("MAIN".equals(prodDetailsRetObjDWN.getFieldValueString(ims,"EPA_IMAGE_TYPE")) && indDisLarge!=-1)
				{				
					mainDisLarge=nullCheck(prodDetailsRetObjDWN.getFieldValueString(ims,"EZA_LINK"));					
				}
				else if("MAIN".equals(prodDetailsRetObjDWN.getFieldValueString(ims,"EPA_IMAGE_TYPE")) && indDisSTD!=-1)
				{				
					mainDisSTD=nullCheck(prodDetailsRetObjDWN.getFieldValueString(ims,"EZA_LINK"));					
				}
				else if("ZOOM".equals(prodDetailsRetObjDWN.getFieldValueString(ims,"EPA_IMAGE_TYPE")) && indDisThumb!=-1)
				{				
					mainDisThumb=nullCheck(prodDetailsRetObjDWN.getFieldValueString(ims,"EZA_LINK"));					
				}
			}
		}				
%>		
		<div class="product-img-box">

        <a class="product-image MagicZoom" id="zoom" title=""  href="<%=mainDisLarge%>"
        rel="selectors-mouseover-delay: 200; zoom-width: 530; zoom-height: 510; zoom-window-effect: false; 
        show-title: false; selectors-effect: fade; zoom-distance:55; "
        >
            <img src="<%=mainDisSTD%>" alt="" />        </a>

        <div id="yourzoom" style="position:absolute; top:0px; left:0px;"></div>
        <div class="more-views">
	<ul>
        
<%      if(prodDetailsRetObjDWN!=null && prodDetailsRetObjDWN.getRowCount()>0)
	{
	for(int im=0;im<prodDetailsRetObjDWN.getRowCount();im++)
	{
		
		String mainLarge="",mainSTD="",mainThumb="";
		int indLarge=0,indSTD=0,indThumb=0;
		
		String imageLarge = prodDetailsRetObjDWN.getFieldValueString(im,"EZA_ASSET_ID");
		if(imageLarge!=null && !"".equals(imageLarge) && !"null".equals(imageLarge))
		{
			indLarge = imageLarge.indexOf("LG");
		}
		String imageSTD = prodDetailsRetObjDWN.getFieldValueString(im,"EZA_ASSET_ID");
		if(imageSTD!=null && !"".equals(imageSTD) && !"null".equals(imageSTD))
		{
			indSTD = imageSTD.indexOf("ST");
		}
		String imageThumb = prodDetailsRetObjDWN.getFieldValueString(im,"EZA_ASSET_ID");
		if(imageThumb!=null && !"".equals(imageThumb) && !"null".equals(imageThumb))
		{
			indThumb = imageThumb.indexOf("SU");
		}
		
		if("MAIN".equals(prodDetailsRetObjDWN.getFieldValueString(im,"EPA_IMAGE_TYPE")) && indLarge!=-1)
		{				
			mainLarge=nullCheck(prodDetailsRetObjDWN.getFieldValueString(im,"EZA_LINK"));					
		}
		else if("MAIN".equals(prodDetailsRetObjDWN.getFieldValueString(im,"EPA_IMAGE_TYPE")) && indSTD!=-1)
		{				
			mainSTD=nullCheck(prodDetailsRetObjDWN.getFieldValueString(im,"EZA_LINK"));					
		}
		else if("ZOOM".equals(prodDetailsRetObjDWN.getFieldValueString(im,"EPA_IMAGE_TYPE")) && indThumb!=-1)
		{				
			mainThumb=nullCheck(prodDetailsRetObjDWN.getFieldValueString(im,"EZA_LINK"));					
		}

		
			
		if(mainThumb!=null && !"".equals(mainThumb) && !"null".equals(mainThumb))
		{
%>
			<li>
		    <a href="<%=mainLarge%>"	rel="zoom-id:zoom;" rev="<%=mainSTD%>"  title=""> 
		    <img src="<%=mainThumb%>" alt="" width="47" height="57"/></a>
		    </li>
		}
									
		
<%	}
	}	
%>
		</ul>
		</div>
		 </div>
		<div class="clearer"></div>		
		
</form>
		</div>
		</div>
		<!--END ITEM DETAILS-->
		<!--SCENE 7 PERSONALIZER-->
		<!--END SCENE 7 PERSONALIZER-->
		<div class="content" id="contentLinks">
		<div class="inner-contentlinks">
		<h2>Downloads</h2>
		
			<ul>
<%			if(prodDetailsRetObjDWN!=null && prodDetailsRetObjDWN.getRowCount()>0)
			{
				for(int i=0;i<prodDetailsRetObjDWN.getRowCount();i++)
				{
					if("NA".equals(prodDetailsRetObjDWN.getFieldValueString(i,"EPA_IMAGE_TYPE")))
					{
%>				
						<li><a target="_blank" href="<%=nullCheck(prodDetailsRetObjDWN.getFieldValueString(i,"EZA_LINK"))%>" >
							<%=nullCheck(prodDetailsRetObjDWN.getFieldValueString(i,"EPA_SCREEN_NAME"))%>
						    </a>
						</li>
<%					}
				}
			}
			else
			{
%>
				<h4>There are no downloads found for this search.</h4>
<%			}
			
%>							
			</ul>
		</div>
		</div>
		
		
		<div class="content" id="contentParts">
		<div class="inner-contentParts">

		<div class="box-collateral box-related">
		<h2>Repair Parts</h2>
		
		
			
			
<%			
			if(prodDetailsRetObjREL!=null && prodDetailsRetObjREL.getRowCount()>0)
			{
%>			
			<table >
			<tr>
			
			
<%			for(int r=0;r<prodDetailsRetObjREL.getRowCount();r++)
			{
			
				if("R".equals(prodDetailsRetObjREL.getFieldValueString(r,"EPR_RELATION_TYPE")))
				{					
%>											
					<td>
					<div class="more-views">
					<ol class="mini-products-list" id="wishlist-sidebar">  
					<li class="item">

					<a href="javascript:getProductDetails('<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(r,"EPR_PRODUCT_CODE2"))%>')" 
					title="" class="product-image"><img src="<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(r,"EZA_LINK"))%>" 
					width="50" height="70" alt="">
					</a>
						<div class="product-details">
						<table width=90%>
						<tbody>												
						<tr>
						<td>
						<h4 class="product-name">
							<a href="javascript:getProductDetails('<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(r,"EPR_PRODUCT_CODE2"))%>')" title="">
							<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(r,"EPD_PRODUCT_DESC"))%></a>
						</h4>
						</td>
						</tr>
						<tr><td><span class="grey-item"> PROD &#35; <%=nullCheck(prodDetailsRetObjREL.getFieldValueString(r,"EPR_PRODUCT_CODE2"))%></span></td></tr>
						<tr><td>
							<div class="price-box">
							<span class="top-price-wrapper">Your Price:
							<span class="regular-price" id="product-price-1366-related">
							<span class="price">$<%=eliminateDecimals(nullCheck(prodDetailsRetObjREL.getFieldValueString(r,"EZP_CURR_PRICE")))%></span>                
							</span>
							</span>						
							</div>						
						</td></tr>
						<tr><td><div class="grid-qty-cont">
							<label class="grid-qty-label">Qty:</label>
							<input type="text" name="qty_<%=r%>" id="qty_<%=r%>" value="1" class="grid-qty-input">
							
							<input type="hidden" name="prodDesc_<%=r%>"  value='<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(r,"EPD_PRODUCT_DESC"))%>'>
							<input type="hidden" name="prodCode_<%=r%>"  value='<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(r,"EPR_PRODUCT_CODE2"))%>'>
							<input type="hidden" name="listPrice_<%=r%>" value='<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(r,"EZP_CURR_PRICE"))%>'>
							<input type="hidden" name="eanUpc_<%=r%>"    value='<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(r,"EZP_UPC_CODE"))%>'>

						</div>						
						
						<!--<a href="javascript:addToCart_D('<%=r%>')" title=""><span><span><strong><font color=red>Add to Cart</font></strong></span></span></a>-->
						<button type="button" title="Add to Cart"  class="button btn-cart" onclick="javascript:addToCart_D('<%=r%>')"><span><span>Add to Cart</span></span></button>

						</tbody>
						</table>
						</div>

					</li>
					</ol>
					</div>
					</td>
				
					
<%				}

			}
%>
			
			</tr>
			</table>
<%			}
			else
			{
%>			
				<h4>There are no repair parts found for this search.</h4>	
<%			}
%>									
			
			
			</div>
			
			
			
		</div>
		</div>
		
		<div class="content" id="contentColors">
		<div class="inner-contentColors">
		<h2>Colors/Finishes</h2>
			
			<ul>
				<li><%=nullCheck(prodDetailsRetObj.getFieldValueString(0,"EZP_COLOR"))%></li>
				<li><%=nullCheck(prodDetailsRetObj.getFieldValueString(0,"EZP_FINISH"))%></li>
			</ul>
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
<%			
			if(prodDetailsRetObjREL!=null && prodDetailsRetObjREL.getRowCount()>0)
			{
			for(int s=0;s<prodDetailsRetObjREL.getRowCount();s++)
			{
			
				if("S".equals(prodDetailsRetObjREL.getFieldValueString(s,"EPR_RELATION_TYPE")))
				{
%>			
			
				<li class="item row-count-1">
				<div class="item-info"> <a href="javascript:getProductDetails('<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(s,"EPR_PRODUCT_CODE2"))%>')" 
				class="product-image"><img src="<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(s,"EZA_LINK"))%>" width="192" height="215" alt="" title="" /></a>
				<div class="product-details">
				<h3 class="product-name">
				
				<a href="javascript:getProductDetails('<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(s,"EPR_PRODUCT_CODE2"))%>')" title="">
				<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(s,"EPD_PRODUCT_DESC"))%></a>
				</h3>

				<!--subtitle attribute-->



				<!-- SKU-->
				<h4 class="related-sku"><span class="grey-item"> PROD &#35; <%=nullCheck(prodDetailsRetObjREL.getFieldValueString(s,"EPR_PRODUCT_CODE2"))%> </span></h4>

				<div class="price-box">
				<span class="top-price-wrapper">Your Price:
				<span class="regular-price" id="product-price-1366-related">
				<span class="price">$<%=eliminateDecimals(nullCheck(prodDetailsRetObjREL.getFieldValueString(s,"EZP_CURR_PRICE")))%></span>                </span>
				</span>

				</div>

				
				<div class="add-to-cart">
				<label for="qty1366">Qty:</label>
				<input type="text" name="qty-<%=s%>" id="qty-<%=s%>" maxlength="12" value="1" title="Qty" class="input-text qty" />
				
				<input type="hidden" name="prodDesc_<%=s%>" 	value='<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(s,"EPD_PRODUCT_DESC"))%>'>
				<input type="hidden" name="prodCode_<%=s%>" 	value='<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(s,"EPR_PRODUCT_CODE2"))%>'>
				<input type="hidden" name="listPrice_<%=s%>" 	value='<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(s,"EZP_CURR_PRICE"))%>'>
				<input type="hidden" name="eanUpc_<%=s%>" 	value='<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(s,"EZP_UPC_CODE"))%>'>

				</div>
				<!--<a href="javascript:addToCart_D('<%=s%>')" title=""><span><span><strong><font color=red>Add to Cart</font></strong></span></span></a>-->
				<button type="button" title="Add to Cart" class="button btn-cart" onclick="javascript:addToCart_D('<%=s%>')"><span><span>Add to Cart</span></span></button>
				
				</div>
				</div>
				</li>
				
<%				}

			
			}
			}
			else
			{
%>			
				<h4>There are no similar products found for this search.</h4>	
<%			}
%>			
			</ul>
			<script type="text/javascript">decorateGeneric($$('ul.block-content li'), ['odd','even','first','last'])</script>
			</div>
			</div>
			
		<div class="content" id="contentRel1">
		<div class="box-collateral box-related">
		<ul class="block-content ">
		
<%			
			if(prodDetailsRetObjREL!=null && prodDetailsRetObjREL.getRowCount()>0)
			{
			for(int c=0;c<prodDetailsRetObjREL.getRowCount();c++)
			{
			
				if("C".equals(prodDetailsRetObjREL.getFieldValueString(c,"EPR_RELATION_TYPE")))
				{
%>		
				<li class="item row-count-1">
				<div class="item-info"> <a href="javascript:getProductDetails('<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(c,"EPR_PRODUCT_CODE2"))%>')"
				class="product-image"><img src="<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(c,"EZA_LINK"))%>" width="192" height="215" alt="" title="" /></a>
				<div class="product-details">
				<h3 class="product-name">	
				<a href="javascript:getProductDetails('<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(c,"EPR_PRODUCT_CODE2"))%>')" title="">
				<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(c,"EPD_PRODUCT_DESC"))%></a>
				</h3>

				<!--subtitle attribute-->



				<!-- SKU-->
				<h4 class="related-sku"><span class="grey-item"> PROD &#35; <%=nullCheck(prodDetailsRetObjREL.getFieldValueString(c,"EPR_PRODUCT_CODE2"))%> </span></h4>


				<div class="price-box">
				<span class="top-price-wrapper">Your Price:
				<span class="regular-price" id="product-price-1299-related">
				<span class="price">$<%=eliminateDecimals(nullCheck(prodDetailsRetObjREL.getFieldValueString(c,"EZP_CURR_PRICE")))%></span>                </span>
				</span>

				</div>

				
				<div class="add-to-cart">
				<label for="qty1299">Qty:</label>
				<input type="text" name="qty-<%=c%>" id="qty-<%=c%>" maxlength="12" value="1" title="Qty" class="input-text qty" />
				
				<input type="hidden" name="prodDesc_<%=c%>"  value='<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(c,"EPD_PRODUCT_DESC"))%>'>
				<input type="hidden" name="prodCode_<%=c%>"  value='<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(c,"EPR_PRODUCT_CODE2"))%>'>
				<input type="hidden" name="listPrice_<%=c%>" value='<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(c,"EZP_CURR_PRICE"))%>'>
				<input type="hidden" name="eanUpc_<%=c%>"    value='<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(c,"EZP_UPC_CODE"))%>'>
				
				</div>
				<!--<a href="javascript:addToCart_D('<%=c%>')" title=""><span><span><strong><font color=red>Add to Cart</font></strong></span></span></a>-->
				<button type="button" title="Add to Cart" class="button btn-cart" onclick="javascript:addToCart_D('<%=c%>')"><span><span>Add to Cart</span></span></button>

				</div>
				</div>
				</li>
<%				}

			}
			}
			else
			{
%>			
				<h4>There are no competitors found for this search.</h4>	
<%			}
%>			
		</ul>
		<script type="text/javascript">decorateGeneric($$('ul.block-content li'), ['odd','even','first','last'])</script>
		</div>
		</div>
		
	</div>



<script>new BaRelatedProductTabs();</script>

	<!-- END RELATED TABS -->
	<!-- === DISABLED FOR B2C LAUNCH PER BLUEPRINTS === -->
	<!-- === END DISABLED FOR B@C LAUNCH PER BLUEPRINTS === -->

	<script type="text/javascript">
        // <![CDATA[

        jQuery(document).ready(function(jQuery) {
            jQuery('#tabs, #tabsRel').tabify();

            jQuery('#personalize-tab a').click(function(){
                jQuery('.baRelatedProducts, .related-atc').hide();
                jQuery('.baRelatedProducts, .related-atc').addClass('hidden-products');
            });

            jQuery('#item-details-tab a, #care-and-use-tab a, #repair-parts-tab a, #colors-finishes-tab a').click(function(){
                jQuery('.baRelatedProducts, .related-atc').show();
                jQuery('.baRelatedProducts, .related-atc').removeClass('hidden-products');
            });

            if (jQuery('#personalize-tab').hasClass('active') == true) {
                jQuery('.baRelatedProducts, .related-atc').hide();
                jQuery('.baRelatedProducts, .related-atc').addClass('hidden-products');
            }

            if (jQuery('ul.messages li').length > 0) {
                jQuery('.breadcrumbs').css('top', '60px');
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

<script type="text/javascript">
    new CustomMenu({
        insertionPoint   : 'ul.level0',
        rolloverElement  : 'li.level1',
        rolloverImgId    : 'nav_image',
        rolloverImgClass : 'nav-image',

    });

    if (!window.BlueAcorn) window.BlueAcorn = {};
    window.BlueAcorn.images = $$('[data_categoryimage]').collect(function(item) {
    var imgsrc = item.getAttribute('data-categoryImage');
    return new Element('img', { src: imgsrc });
    });

</script>

<!--/{CATALOG_NAVIGATION_de4603e96ce4313aa3643c1505fce5a7}-->
</body>
</html>

<%!
	public String nullCheck(String str)
	{
		String ret = str;

		if(ret==null || "null".equalsIgnoreCase(ret) || "".equals(ret))
			ret = "N/A";

		return ret;
	}
	
	public String eliminateDecimals(String myStr)
	{
		String remainder = "";
		if(myStr.indexOf(".")!=-1)
		{
			remainder = myStr.substring(myStr.indexOf(".")+1,myStr.length());
			myStr = myStr.substring(0,myStr.indexOf("."));
		}
		return myStr;
	}
%>
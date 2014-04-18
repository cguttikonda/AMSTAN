<%@ include file="../../../Includes/JSPs/Catalog/iGetFavProducts.jsp"%>
<%
	String usrFavGrp     = (String)session.getValue("USR_FAV_GRP");
	String usrFavDesc     =(String)session.getValue("USR_FAV_DESC");
	String atpon   = cMonth_S+"/"+cDate_S+"/"+cYear;
	//out.println("usrFavGrp:::::::::::::::::"+usrFavGrp);
	//out.println("usrFavDesc:::::::::::::::::"+usrFavDesc);
%>	
<script type="text/javascript" src="../../Library/Script/jquery.js"></script>

<!-- Start of the Styles and Scripts for Hello Bar Solo -->
<link type="text/css" rel="stylesheet" href="../../../Includes/Lib/hellobar-solo/hellobar.css" />
<script type="text/javascript" src="../../../Includes/Lib/hellobar-solo/hellobar.js"></script>
<!-- End of the Styles and Scripts for Hello Bar Solo -->
<Script src="../../Library/Script/popup.js"></Script>
<script type="text/javascript" src="../../Library/JavaScript/Cart/ezCartAlerts.js"></script>
<div class="main-container col1-layout ">
<div class="main">

<div class="col-main">
<div class="category-view">
<div id="category-wrapper">
<br>
<h1 class="sub-title"><font size=16>My Favorites</font></h1>
<br>
<div>
	
	<!--<section class="categoryTabsFav">
	<div class="content jcarousel-tabs-rb" id="category1">
	<ul>
<%
	/*if(catalogProductsRetObj_F!=null && catalogProductsRetObj_F.getRowCount()>0)
	{
		for(int i=0;i<catalogProductsRetObj_F.getRowCount();i++)
		{
			String prodDesc = nullCheck(catalogProductsRetObj_F.getFieldValueString(i,"PROD_DESC"));
			String prodCode = catalogProductsRetObj_F.getFieldValueString(i,"EZP_PRODUCT_CODE");
			String webSKU = catalogProductsRetObj_F.getFieldValueString(i,"EZP_PRODUCT_CODE");//EZP_WEB_SKU
			String currPrice = eliminateDecimals(catalogProductsRetObj_F.getFieldValueString(i,"EZP_CURR_PRICE"));
			String prodLinkHF = catalogProductsRetObj_F.getFieldValueString(i,"EZA_LINK");
			
			if(prodLinkHF==null || "null".equals(prodLinkHF) || "".equals(prodLinkHF)) 
			{
				prodLinkHF="../../Images/noimage.gif";
				
			}
%>

<%//@include file="../../../Includes/JSPs/Catalog/iScalePrices.jsp"%>

<%				String priceScale="0";
				priceScale=scaleResultRet.getFieldValueString(scaleResultRet.getRowCount()-1,"CONDVAL");
				try
				{
					priceScale = new java.math.BigDecimal(priceScale).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
				}
				catch(Exception e){}
				if("NA".equals(scaleResultRet.getFieldValueString(0,"PRODUCT")))
				{
					priceScale="N/A";
				}
%>
			<li>
			<div class="ba-rb-tab-product-container-div">
			<a href="javascript:void(0)">
				<div class="ba-rb-home-overlay-div">
				<div class="box">
					<h3><%=prodDesc%></h3>
					<p>Model#<%=webSKU%></p>
					<p>List Price : $<%=currPrice%></p>
					<p>Best Price : $<%=priceScale%></p>
				</div>
				</div>
				<div class="ba-rb-tab-product-image-div">
					<img src="<%=prodLinkHF%>" alt='<%=prodDesc%>' width=140>
				</div>
			</a>
			</div>
			</li>
<%
		}
	}*/	
%>
	</ul>
	</div>
	</section>-->
	<!--<script type="text/javascript">
		jQuery(document).ready(function() {
		jQuery('.jcarousel-tabs-rb > ul').jcarousel({
			visible: 5,
			scroll: 5,
			animation: 1200,
			itemFallbackDimension: 160
			
		});
		});
	</script>-->
</div>
</div>
<div id="adj-nav-container1">
<script>
// Javascript originally by Patrick Griffiths and Dan Webb.
// http://htmldog.com/articles/suckerfish/dropdowns/
sfHover = function() {
	var sfEls = document.getElementById("navbar1").getElementsByTagName("li");
	for (var i=0; i<sfEls.length; i++) {
		sfEls[i].onmouseover=function() {
			this.className+=" hover";
		}
		sfEls[i].onmouseout=function() {
			this.className=this.className.replace(new RegExp(" hover\\b"), "");
		}
	}
}
if (window.attachEvent) window.attachEvent("onload", sfHover);
</script>

<script type="text/javascript">
	function addToCart(num)
	{
		//document.myForm.prodIden.value=num;

		//document.myForm.action="../ShoppingCart/ezAddCartItems.jsp";
		//document.myForm.submit();
		
		var catType=document.myForm.catTypeE.value;
		
		if(catType=='Q')
		{
			alert("Cart contains Quick Ship items. \nPlease remove them to add other items");
			return false;
		}
		else if(catType=='C')
		{
			alert("Cart contains Custom items. \nPlease remove them to add other items");
			return false;
		}
		else
		{
			addToCartFav(num);
		}
	}
	var req
	var pcode
	function addToCartFav(val)
	{		
		req=Initialize();

		if (req==null)
		{
		alert ("Your browser does not support Ajax HTTP");
		return;
		}			
		Popup.showModal('modal');
		var url

		var atpfor  = eval("document.myForm.prodCode_"+val).value;
		var atpqty  = eval("document.myForm.qty_"+val).value;
		var atpdesc = eval("document.myForm.prodDesc_"+val).value;
		var atpprice= eval("document.myForm.listPrice_"+val).value;
		var atpupc  = eval("document.myForm.eanUpc_"+val).value;

		pcode=atpfor

		url="../ShoppingCart/ezAddCartQuickEntry.jsp";
		url=url+"?atpfor="+atpfor+"&atpqty="+atpqty+"&atpdesc="+atpdesc+"&atpprice="+atpprice+"&atpupc="+atpupc;			


		if(req!=null)
		{			
			req.onreadystatechange = Process;
			req.open("GET", url, true);
			req.send(null);
		}			
	}

	function Process() 
	{	

		if (req.readyState == 4)
		{
			var resText     = req.responseText;	 	        	
			if (req.status == 200)
			{			

				var alertCode					
				//var barCol = '#eb593c'
				var reasonCode	
				var alertIcon
				var flag = true;

				for(i=0;i<myKeys.length;i++)
				{
					var chkKey = myKeys[i].helpKey;

					if(resText.indexOf(chkKey)!=-1)
					{
						alertCode = '';
						reasonCode = myKeys[i].helpText;
						alertIcon = '<img src="../../Library/images/icon-error-message.png"/>';
						flag = false;
						break;
					}
				}

				if(flag)
				{
					alertCode=' has been successfully added to Cart.'
					//barCol = '#71c6aa'
					alertIcon = '<img src="../../Library/images/icon-success-message.png"/>';
					
					var currentC = jQuery('#cartcount').text();
					var newC =parseInt(currentC)+1;
					jQuery('#cartcount').text(newC);
				}

				new HelloBar( '<span>'+ alertIcon +' Product ' +pcode+ ' '+alertCode+ ' ' +reasonCode+ '</span><a href="../ShoppingCart/ezViewCart.jsp">Click to See Your Cart!</a>', {

				showWait: 1000,
				positioning: 'sticky',
				fonts: 'Arial, Helvetica, sans-serif',
				forgetful: true,
				helloBarLogo : false,			
				height : 30

				}, 1.0 );					

			}
			else
			{
				if(req.status == 500)	 
				alert("Error in adding product(s)");
			}
			
			Popup.hide('modal');
		}
	}

	function Initialize()
	{

	    if (window.XMLHttpRequest)
	    {
	       return new XMLHttpRequest();
	    }
	    if (window.ActiveXObject)
	    {
	      return new ActiveXObject("Microsoft.XMLHTTP");
	    }

	return null;	
	}
	function deleteFav(num)
	{
		Popup.showModal('modal');
		document.myForm.favDtl.value=num;

		document.myForm.action="ezDelFavItems.jsp";
		document.myForm.submit();	
	
	}
	function getProductDetails(code)
	{
		Popup.showModal('modal');
		document.myForm.prodCode_D.value=code;

		document.myForm.action="../Catalog/ezProductDetails.jsp";
		document.myForm.submit();
	}
	function getProducts(page)
	{
		Popup.showModal('modal');
		document.myForm.pageNum.value = page;

		document.myForm.action="../Catalog/ezGetFavProdMain.jsp";
		document.myForm.submit();
	}
	function viewProducts(page)
	{
		Popup.showModal('modal');
		document.myForm.pageSize.value = page;

		document.myForm.action="../Catalog/ezGetFavProdMain.jsp";
		document.myForm.submit();
	}
	function sortBy()
	{
		document.myForm.action="../Catalog/ezGetFavProdMain.jsp";
		document.myForm.submit();
	}
		
</script>
<script>
	var xmlhttp
	var getInd
	function loadContent(ind)
	{
	
	 getInd = ind;
	 xmlhttp=GetXmlHttpObject();
	
	  if (xmlhttp==null)
	  {
	   alert ("Your browser does not support Ajax HTTP");
	   return;
	  }
		var atpfobj = eval("document.myForm.prodCode_"+ind)
		var atpqobj = eval("document.myForm.qty_"+ind)
		
		
	    var atpfor = atpfobj.value;
	    var atpqty = atpqobj.value;
	    var atpon=document.myForm.atpon.value;
	    var stAtp=document.myForm.stAtp.value;
	
	    var url="../ShoppingCart/ezATPAjaxLightBoxHome.jsp";
	    url=url+"?atpfor="+atpfor+"&atpon="+atpon+"&atpqty="+atpqty+"&stAtp="+stAtp;	    	
	
	    xmlhttp.onreadystatechange=getOutput;
	    xmlhttp.open("GET",url,true);
	    xmlhttp.send(null);
	}
	
	function getOutput()
	{
	
	  if (xmlhttp.readyState==4)
	  {
	  
	  document.getElementById("ajaxid"+getInd).innerHTML=xmlhttp.responseText;
	  
	  }
	}
	
	function GetXmlHttpObject()
	{
	    if (window.XMLHttpRequest)
	    {
	       return new XMLHttpRequest();
	    }
	    if (window.ActiveXObject)
	    {
	      return new ActiveXObject("Microsoft.XMLHTTP");
	    }
	 return null;
	}
	
	var xmlhttpA
	var getIndA
	function loadScalePrice(ind)
	{
	
	 getIndA = ind;
	 xmlhttpA=GetXmlHttpObjectA();
	
	  if (xmlhttpA==null)
	  {
	   alert ("Your browser does not support Ajax HTTP");
	   //$( "#dialog-notsup" ).dialog('open');
	   return;
	  }
		var atpfobj = eval("document.myForm.prodCode_"+ind)
		var atpdobj = eval("document.myForm.prodDesc_"+ind)
	
	    var atpfor = atpfobj.value;
 	    var atpPdesc = atpdobj.value;	
 	    
	    var url="../Catalog/ezScalePrices.jsp";
	    url=url+"?atpfor="+atpfor+"&atpPdesc="+atpPdesc;	    	
	
	    xmlhttpA.onreadystatechange=getOutputA;
	    xmlhttpA.open("GET",url,true);
	    xmlhttpA.send(null);
	}
	
	function getOutputA()
	{
	
	  if (xmlhttpA.readyState==4)
	  {
	
	  document.getElementById("scaleid"+getIndA).innerHTML=xmlhttpA.responseText;
	
	  }
	}
	
	
	function GetXmlHttpObjectA()
	{
	    if (window.XMLHttpRequest)
	    {
	       return new XMLHttpRequest();
	    }
	    if (window.ActiveXObject)
	    {
	      return new ActiveXObject("Microsoft.XMLHTTP");
	    }
	 return null;
	}	
</script>
<!-- Add fancyBox -->
<link rel="stylesheet" href="../../Library/Script/jquery.fancybox.css?v=2.0.5" type="text/css" media="screen" />
<script type="text/javascript" src="../../Library/Script/jquery.fancybox.pack.js?v=2.0.5"></script>

<!-- end of fancybox -->
<%@ include file="../../../Includes/JSPs/ShoppingCart/iCheckCartItems.jsp"%>


<script type="text/javascript">
$(document).ready( function() {		
$(".fancybox").fancybox();
} );
</script>
<form name="myForm" method="post" >
<div id="modal" style="border:0px solid black; background-color:white; padding:1px; font-size:10;width:40%;height:180px; text-align:center; display:none;">
	<ul>
		<li>&nbsp;</li>
		<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
		<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
	</ul>
</div>
<input type="hidden" name="pageSize" value="<%=pageSize_F%>">
<input type="hidden" name="FavGroup" >
<input type="hidden" name="GroupDesc" >
<input type="hidden" name="chkProds" >
<input type="hidden"  id="atpon" name="atpon" value="<%=atpon%>" />
<input type="hidden"  id="stAtp" name="stAtp" value="<%=session.getValue("shipState")%>" />
<input type="hidden" name="catTypeE" value="<%=catType_C%>">

<div class="toolbarfav">
<%
	//out.println("catalogProductsRetObj_F:::::::::::::::::::"+catalogProductsRetObj_F.toEzcString());
	if(catalogProductsRetObj_F!=null && catalogProductsRetObj_F.getRowCount()>0)
	{
%>	
		<div class="limiter">
		<label>View:</label>
<%

		String viewPages[] = {"18","27","99"};

		for(int v=0;v<viewPages.length;v++)
		{
			String cSel = "";

			if(viewPages[v].equals(pageSize_F+"")) cSel = "class=selected";
%>
			<button onclick="javascript:viewProducts(<%=(viewPages[v])%>)" <%=cSel%>><span><span><%=(viewPages[v])%></span></span></button>
<%
		}
		
%>
		</div>
	<div class="pager" style="left:150px;">
	<div class="pages" style="left:150px;">
<%
	int startCnt = (pageMaxNo_F-pageSize_F)+1;

	if(pageMaxNo_F<pageSize_F)
		startCnt = 1;

	int endCnt = pageMaxNo_F;

	int numLinksCnt = itemsCnt_F/pageSize_F;
	int numLinksDiv = itemsCnt_F%pageSize_F;

	//if(numLinksCnt==1) numLinksCnt=0;

	boolean allItems = false;

	if((numLinksCnt==4 && numLinksDiv>0) || numLinksCnt>4)
		allItems = true;

	if(itemsCnt_F>0)
	{
%>
		<span>Page:</span>
		<ol>
<%
		int pLast = pageSize_F+3;
		int pFirst = pLast-3;

		if(pLast>numLinksCnt)
		{
			pLast = numLinksCnt+1;

			if(pLast>4)
				pFirst = pLast-3;
		}

		if(pLast<=4)
			pFirst = 1;

		int prev = pFirst-1;
		int next = pLast+1;

		if(allItems)
		{
			if(pFirst==1)
			{
%>
				<li class="previous-outer"><img src="../../Images/btn-arrow-left.png" alt="Previous"></li>
<%
			}
			else
			{
%>
				<li class="previous-outer"><a class="previous i-previous" href="javascript:getProducts(<%=prev%>)" title="Previous">
				<img src="../../Images/btn-arrow-left.png" alt="previous"></a></li>
				<li><a href="javascript:getProducts(1)">1</a></li>
				<li class="dot-dot"><img src="../../Images/ellipse.png" alt="Ellipse"></li>
<%
			}
		}
		else
		{
			pLast = numLinksCnt+1;
		}

		for(int i=pFirst;i<=pLast;i++)
		{
			if(i==pageSize_F)
			{
%>
				<li class="current"><%=i%></li>
<%
			}
			else
			{
%>
				<li><a href="javascript:getProducts(<%=i%>)"><%=i%></a></li>
<%
			}
		}

		if(allItems)
		{
			if(pLast>numLinksCnt)
			{
%>		
				<li class="next-outer"><img src="../../Images/btn-arrow-right.png" alt="next"></li>
<%
			}
			else
			{
%>
				<li class="dot-dot"><img src="../../Images/ellipse.png" alt="Ellipse"></li>
				<li><a href="javascript:getProducts(<%=(numLinksCnt+1)%>)"><%=(numLinksCnt+1)%></a></li>
				<li class="next-outer"><a class="next i-next" href="javascript:getProducts(<%=(pageSize_F+1)%>)" title="Next">
				<img src="../../Images/btn-arrow-right.png" alt="next"></a></li>
<%
			}
		}
%>
		</ol>
<%
	}
%>
	</div>
	</div>
	<!--<div class="sort-by">
	<div class="selector" id="uniform-undefined">
		<span>Sort By</span>
		<select name="sortBy" onChange="sortBy()" style="width:50%;">
			<option value="">Price low to high</option>
			<option value="">Price high to low</option>
		</select>
	</div>
	</div>-->
</div>
<input type="hidden" name="prodIden">
<input type="hidden" name="favDtl">
<input type="hidden" name="prodCode_D">

<input type="hidden" name="pageNum" value="<%=pageSize_F%>">
<div class="category-products">
<%
	String cssLiClass = "item first";
	int uCnt = 4;

	for(int i=0;i<catalogProductsRetObj_F.getRowCount();i++)
	{
		if(i%4==0)
		{
%>
			<ul class="products-grid">
<%
			uCnt++;
		}

		if(i>0 && i%4==0) cssLiClass = "item first";
		if(i>0 && (i-1)%4==0) cssLiClass = "item second";
		if(i>0 && (i-2)%4==0) cssLiClass = "item third";
		if(i>0 && (i-3)%4==0) cssLiClass = "item last";

		String prodDesc = nullCheck(catalogProductsRetObj_F.getFieldValueString(i,"PROD_DESC"));
		String webSKU = catalogProductsRetObj_F.getFieldValueString(i,"EZP_PRODUCT_CODE");//EZP_WEB_SKU
		String currPrice = eliminateDecimals(catalogProductsRetObj_F.getFieldValueString(i,"EZP_CURR_PRICE"));
		String eanUpc = catalogProductsRetObj_F.getFieldValueString(i,"EZP_UPC_CODE");
		String prodCode = catalogProductsRetObj_F.getFieldValueString(i,"EZP_PRODUCT_CODE");
		String categoryId = catalogProductsRetObj_F.getFieldValueString(i,"EPF_ITEMCAT");
		String prodLinkHF = catalogProductsRetObj_F.getFieldValueString(i,"EZA_LINK");
		String favDtl = prodCode+"~~"+categoryId+"~~CNET";
		String discChk = catalogProductsRetObj_F.getFieldValueString(i,"EZP_STATUS");
		
		if(prodLinkHF==null || "null".equals(prodLinkHF) || "".equals(prodLinkHF)) 
		{
			prodLinkHF="../../Images/noimage.gif";
						
		}
		
%>
<%//@include file="../ShoppingCart/ezCartItemATPCheck.jsp"%>

			<li class="<%=cssLiClass%>">
				<a href="javascript:getProductDetails('<%=prodCode%>')" title='<%=prodDesc%>' class="product-image">
					<img src="<%=prodLinkHF%>" width="192" height="215" alt='<%=prodDesc%>'>
				</a>
				<h2 class="product-name"><a href="javascript:getProductDetails('<%=prodCode%>')" title='<%=prodDesc%>'><%=prodDesc%>&nbsp;</a></h2>
				<!--<p class="cat-num"><%=prodDesc%></p>-->
				<p class="cat-num">SKU # <%=webSKU%>
				
				
<%				
				if("Z3".equals(discChk) || "Z2".equals(discChk) || "Z4".equals(discChk))
				
				{	

%>													
					<font color=red>(Discontinued)</font></p>					
<%				}
				else if("ZM".equals(discChk))
				{	
%>
					<font color=red>(Modification - Contact Customer Care for Ordering)</font></p>
<%
				}
				else if("ZP".equals(discChk))
				{
%>
					<font color=red>(Production Hold - ordering is impermissible)</font></p>
<%
				}
				else if("ZF".equals(discChk))
				{	
%>				
					<font color=red>(To Be Discontinued)</font></p>	
<%				}
				else if("11".equals(discChk))
				{

%>				
					<font color=red>(New)</font></p>	
<%				}

				String disc = "Y";
				String atpAvailCC="", atpAvailC="";
				if("Z4".equals(discChk) || "ZF".equals(discChk) || "11".equals(discChk) || "ZP".equals(discChk))
				{
					disc = "N";
				}
				
				if("".equals(discChk))
				{
					atpAvailC  = "Y";
					disc = "N";
								
				}
%>				
				
				
				
				<div class="price-box">
				<span class="top-price-wrapper">List Price:
				<span class="regular-price" id="product-price-<%=i%>">
					<span class="price" style="color:#000000;">$<%=currPrice%></span>
				</span>
				
				</div>
				<table >
				<tbody>
				<tr>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;
				</td>
				<td valign="bottom">
				<br>
				Qty:
				<input type="text" name="qty_<%=i%>" id="qty_<%=i%>" value='1' class="grid-qty-input" style="width:24px;height:20px;border-radius:3px;">
				</td>					
				
				<td>&nbsp;&nbsp;
				</td>
				<td>
				<br>
				<ul id="navbar1">
				<li><a href="javascript:void()" style="border-radius:3px;"><img src="../../Library/images/actionsicon.png" style="margin-top:3px;" width='17' height='11'><span class="arrow"></span></a>
				<ul style="z-index:10000;border-radius:5px;">
				<%if("N".equals(disc)) //"Y".equals(atpAvailC) && 
				{%>					
					<li><a href="#" onClick="javascript:addToCart('<%=i%>')"><span>Add to Cart</span></a></li>
				<%}%>
					<li><a href="#" onClick="javascript:deleteFav('<%=favDtl%>')"><span>Delete</span></a></li>			
					<li><a class="fancybox" href="#ajaxid<%=i%>" onclick="javascript:loadContent('<%=i%>')" ><span>Current Availability</span></a></li>			
					
					<%if("Y".equals(bestPrice))
					{%>
					<li><a class="fancybox" href="#scaleid<%=i%>" onClick="javascript:loadScalePrice(<%=i%>)" ><span>Best Price</span></a></li>
					<%}%>
				</ul>
				</li>
				</ul>
				</td>
				<td>&nbsp;&nbsp;
				</td>
				<td>
				<br>
	<%			/*if("Y".equals(atpAvailCC))
				{
	%>																					
					<p class="availability out-of-stock"> <span><FONT COLOR="GREEN">IN Stock</FONT> </span> </p>  

	<%			}
				else
				{					
	%>				
					<p class="availability out-of-stock"><span><FONT COLOR='#C11B17'>NO Stock</FONT></span></p>
	<%			}*/
	%>			
				</td>
				</tr>
				</tbody>
				</table>
				
				
			
				
				
				
<input type="hidden" name="prodDesc_<%=i%>" value='<%=prodDesc%>'>
<input type="hidden" name="prodCode_<%=i%>" value="<%=webSKU%>">
<input type="hidden" name="listPrice_<%=i%>" value="<%=currPrice%>">
<input type="hidden" name="eanUpc_<%=i%>" value="<%=eanUpc%>">
<input type="hidden" name="categoryID_<%=i%>" value="<%=categoryId%>">

				<div class="actions">

				<div id="ajaxid<%=i%>" style="width: 1000px; height:300px; display: none; ">
					<div align=center  style="padding-top:10px;">
							<ul>
								<li>&nbsp;</li>
								<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
								<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
							</ul>
					</div>
				
				</div>
				<%if("Y".equals(bestPrice))
				{%>
				<div id="scaleid<%=i%>" style="width: 500px; display: none; ">
					<div align=center  style="padding-top:10px;">
						<ul>
							<li>&nbsp;</li>
							<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
							<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
						</ul>
					</div>
				</div>
				<%}%>
				<!--<a href="#" onClick="deleteFav('<%=favDtl%>')"><img style="valign:center" src="../../Images/Common/delete_icon.gif" height="20" width="20" border=0  style='cursor:hand' title="Delete Item"></a>-->
				<!--<input type="submit" class="button" value="Add to Cart" title="Add to Cart" onClick="addToCart('<%=i%>')" />-->
				
				
				</div>
			</li>
<%
		if((i+1)%4==0)
		{
%>
			</ul>
<%
		}
	}
}
else
{
%>
		<h4>No products to display<h4>
<%}%>		
</div>
</form>
	
</div>
</div>
</div>

	
</div>
</div>
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
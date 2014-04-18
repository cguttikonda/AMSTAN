<%
	ArrayList brandsVect = new  ArrayList();
	ArrayList stylesVect = new  ArrayList();
	ArrayList familyVect = new  ArrayList();
	ArrayList disVect    = new  ArrayList();
	ArrayList modelsVect = new  ArrayList();
	ArrayList lengthVect = new  ArrayList();
	ArrayList subtypeVect= new  ArrayList();
	ArrayList attrVect   = new  ArrayList();
	ArrayList attrVectFil= new  ArrayList();
	
	String brandvalues[]  = request.getParameterValues("brandchk");
	String stylevalues[]  = request.getParameterValues("stylechk");
	String familyvalues[] = request.getParameterValues("familychk");
	String disvalues[]    = request.getParameterValues("dischk");
	
	String modelvalues[]   = request.getParameterValues("modelchk");
	String lengthvalues[]  = request.getParameterValues("lengthchk");
	String subtypevalues[] = request.getParameterValues("subtypechk");
	String attrvalues[]    = request.getParameterValues("attrchk");
	
	String filterStr = "";
	String filterQryStr = "";
	String brandQryStr = "";
	String styleQryStr = "";
	String familyQryStr = "";
	String disQryStr = "";
	String modelQryStr = "";
	String lengthQryStr = "";
	String subtypeQryStr = "";
	//String attrQryStr = "";

	if(brandvalues!=null)
	{
		filterStr = "";
		for(int i=0;i<brandvalues.length;i++)
		{
			brandsVect.add(brandvalues[i]);
			
			if(filterStr!="")			
				filterStr = filterStr+"','"+brandvalues[i]+"";
			else
				filterStr = brandvalues[i];
			
			brandQryStr = "AND EZP_BRAND IN ('"+filterStr+"')";
		}
	}
	if(stylevalues!=null)
	{
		filterStr = "";
		for(int i=0;i<stylevalues.length;i++)
		{
			stylesVect.add(stylevalues[i]);
			if(filterStr!="")			
				filterStr = filterStr+"','"+stylevalues[i]+"";
			else
				filterStr = stylevalues[i];
				
			styleQryStr = "AND EZP_STYLE IN ('"+filterStr+"')";
		}
	}
	if(familyvalues!=null)
	{
		filterStr = "";
		for(int i=0;i<familyvalues.length;i++)
		{
			familyVect.add(familyvalues[i]);
			if(filterStr!="")			
				filterStr = filterStr+"','"+familyvalues[i]+"";
			else
				filterStr = familyvalues[i];
				
			familyQryStr = "AND EZP_FAMILY IN ('"+filterStr+"')";	
		}
	}
	if(disvalues!=null)
	{
		filterStr = "";
		for(int i=0;i<disvalues.length;i++)
		{
			disVect.add(disvalues[i]);			
			if("Discontinued".equals(disvalues[i]))
				disQryStr = "AND EZP_STATUS = 'Z4'";
			if("To Be Discontinued".equals(disvalues[i]))
				disQryStr = "AND EZP_STATUS = 'ZF'";
			if("New".equals(disvalues[i]))
				disQryStr = "AND EZP_STATUS = '11'";				
			else if("Active".equals(disvalues[i]))
				disQryStr = "AND (EZP_STATUS NOT IN ('Z4','ZF','11') OR EZP_STATUS IS NULL)";
		}
		if(disvalues.length==4)
			disQryStr = "";
	}
	
	if(modelvalues!=null)
	{
		filterStr = "";
		for(int i=0;i<modelvalues.length;i++)
		{
			modelsVect.add(modelvalues[i]);
			if(filterStr!="")			
				filterStr = filterStr+"','"+modelvalues[i]+"";
			else
				filterStr = modelvalues[i];
				
			modelQryStr = "AND EZP_MODEL IN ('"+filterStr+"')";	
		}
	}
	if(lengthvalues!=null)
	{
		filterStr = "";
		for(int i=0;i<lengthvalues.length;i++)
		{
			lengthVect.add(lengthvalues[i]);
			if(filterStr!="")			
				filterStr = filterStr+"','"+lengthvalues[i]+"";
			else
				filterStr = lengthvalues[i];
				
			lengthQryStr = "AND EZP_LENGTH IN ('"+filterStr+"')";	
		}
	}
	if(subtypevalues!=null)
	{
		filterStr = "";
		for(int i=0;i<subtypevalues.length;i++)
		{
			subtypeVect.add(subtypevalues[i]);
			if(filterStr!="")			
				filterStr = filterStr+"','"+subtypevalues[i]+"";
			else
				filterStr = subtypevalues[i];
				
			subtypeQryStr = "AND EZP_SUB_TYPE IN ('"+filterStr+"')";			
		}
	}
	if(attrvalues!=null)
	{
		filterStr = "";
		for(int i=0;i<attrvalues.length;i++)
		{			
			String splitAttr[] = attrvalues[i].split("#");
			attrVect.add(splitAttr[1]);
			attrVectFil.add(attrvalues[i]);
			
			if(filterStr!="")			
				filterStr = filterStr+"','"+attrvalues[i]+"";
			else
				filterStr = attrvalues[i];
				
			//attrQryStr = "AND EZP_BRAND IN ('"+filterStr+"')";		
		}
	}	

	filterQryStr = brandQryStr+" "+lengthQryStr+" "+disQryStr+" "+modelQryStr+" "+styleQryStr+" "+subtypeQryStr+" "+familyQryStr;
	
	String atpon   = cMonth_S+"/"+cDate_S+"/"+cYear;

%>
<script type="text/javascript" src="../../Library/Script/jquery.js"></script>
<!-- Add fancyBox -->
<link rel="stylesheet" href="../../Library/Script/jquery.fancybox.css?v=2.0.5" type="text/css" media="screen" />
<script type="text/javascript" src="../../Library/Script/jquery.fancybox.pack.js?v=2.0.5"></script>
<!-- end of fancybox -->
<script type="text/javascript" src="../../Library/JavaScript/Cart/ezCartAlerts.js"></script>
<script type="text/javascript">
$(document).ready( function() {		
$(".fancybox").fancybox();
} );
</script>

<%@ include file="../../../Includes/JSPs/Catalog/iProductsDisplay.jsp"%>
<%@ include file="../../../Includes/JSPs/ShoppingCart/iCheckCartItems.jsp"%>

<%
	String usrFavGrp      = (String)session.getValue("USR_FAV_GRP");
	String usrFavDesc     = (String)session.getValue("USR_FAV_DESC");
	String catDesc        = request.getParameter("categoryDesc");
	String supCatId       = request.getParameter("mainCatID");
	String supCatDesc     = request.getParameter("mainCatDesc");
%>	

<div class="main-container col2-left-layout">
<div class="main">
<div class="breadcrumbs">
	<ul>
	<li class="home"><a href="../Misc/ezDashBoard.jsp" title="Go to Home Page">Home</a></li>
	<%if(catType.equals("Q"))
	{%>
	<li class="category3"><span>/&nbsp;</span><a href="../Catalog/ezCatalogDisplayByClassification.jsp?ctype='Q'" >Quick Ship</a></li>
	<li class="category3"><span>/&nbsp;</span><a href="javascript:void(0)" ><%=classDesc%></a></li>
	<%}
	else if(catType.equals("C"))
	{%>
	<li class="category3"><span>/&nbsp;</span><a href="../Catalog/ezCatalogDisplayByClassification.jsp?ctype='C'" >Custom</a></li>
	<li class="category3"><span>/&nbsp;</span><a href="javascript:void(0)" ><%=classDesc%></a></li>
	<%}
	else
	if(!supCatId.equalsIgnoreCase("DXVPRODUCTS"))
	{%>
	<li class="category3"><span>/&nbsp;</span><a href="../Catalog/ezCatalogDisplay.jsp" title="">Products Categories</a></li>
	<li class="category4"><span>/&nbsp;</span><a href="javascript:getSubCatalogList('<%=supCatId%>','<%=supCatDesc%>')" title=""><%=supCatDesc%></a></li>
	<li class="category5"><span>/&nbsp;</span><a href="javascript:getProductsBC('<%=categoryID%>','<%=catDesc%>')" title=""><%=catDesc%></a></li>
	<%} else {%>
	<li class="category3"><span>/&nbsp;</span><a href="../Catalog/ezSubCatalogDisplay.jsp?dxvOrGeneral=DXV&mainCatID=DXVPRODUCTS&mainCatDesc=DXV Products" title="">DXV Products Categories</a></li>
	<li class="category4"><span>/&nbsp;</span><a href="javascript:getProductsBC('<%=categoryID%>','<%=catDesc%>')" title=""><%=catDesc%></a></li>
	<%}%>

	<!--<li class="category5">&nbsp;</li>-->
	</ul>
</div>
<div class="col-main">
<div>

<%
	String catHeadDesc = nullCheck(categoryDetailsObj.getFieldValueString(0,"ECD_TEXT"));
	String catHeadDescPop="";
	if(catHeadDesc  != null) 
	{
		int catHeadLen=catHeadDesc.indexOf("<p>");
		if(catHeadLen!=-1)
		{
			catHeadDesc = catHeadDesc.substring(0,catHeadLen);
		}

	}
	
	if((catHeadDesc != null) && (catHeadDesc.length() > 500)) 
	{
		catHeadDescPop=catHeadDesc;
		catHeadDesc = catHeadDesc.substring(0,500);
	}
%>
	
	<div style="width:100%; height:300px">
		<div style="width:49%; height:280px; float:left;">	
		<p align="justify"><%=catHeadDesc%>...
		
		<a class="fancybox" href="#catDescDisp"><span><strong>Learn More...</strong></span></a>
		<br><br>
		</div>
		<div id="catDescDisp" style="display: none; ">
		<h2>Category Description</h2>
		<br>
		<table width=100%>
		<tr>
		<th><p align="justify" ><%=catHeadDescPop%></p></th>
		</tr>
		</table>	
		</p>
		</div>
		
		<div style="width:49%; height:280px; float:right">
		<% if ( categoryID != null && !"null".equalsIgnoreCase(categoryID) && categoryID.startsWith("DXV") ) { %>
		<p class="category-image" ><img src="Images/Categories/<%=categoryID%>.jpg" width = "350" height="280" alt="<%=categoryID%>" title="<%=categoryID%>"></p>
		<% }; if ( categoryID != null && !"null".equalsIgnoreCase(categoryID) && !categoryID.startsWith("DXV") ) {%>
		<p class="category-image" ><img src="<%=categoryAssetsListObj.getFieldValueString(0,"eza_link")%>" width = "350" height="280" alt="<%=categoryID%>" title="<%=categoryID%>"></p>
		<% }; if(classificationID != null && !"null".equalsIgnoreCase(classificationID)) {%>
		<p class="category-image" ><img src="Images/Categories/<%=classificationID%>.jpg" width = "350" height="280" alt="<%=classificationID%>" title="<%=classificationID%>"></p>
		<% }; %>
		</div>
	</div>
	

	<!--<section class="categoryTabs">
	<div class="content jcarousel-tabs-rb" id="category1">
	<ul>
<%
	for(int i=0;i<catalogProductsRetObj.getRowCount();i++)
	{
		String prodDesc  = catalogProductsRetObj.getFieldValueString(i,"PROD_DESC");
		String prodCode  = catalogProductsRetObj.getFieldValueString(i,"PROD_DESC");
		String webSKU 	 = catalogProductsRetObj.getFieldValueString(i,"EZP_PRODUCT_CODE");//EZP_WEB_SKU
		String currPrice = eliminateDecimals(catalogProductsRetObj.getFieldValueString(i,"EZP_CURR_PRICE"));
		String prodLink = nullCheck(catalogProductsRetObj.getFieldValueString(i,"EZP_ATTR3"));
		
		if(!"Y".equals(catalogProductsRetObj.getFieldValueString(i,"EZP_FEATURED")))
			continue;
		
		if(!prodLink.startsWith("http://dxv") && categoryID.startsWith("DXV"))
			prodLink="http://dxv.blob.core.windows.net/dxv-product-images/DXV_NoImage-01.jpg";

		if("N/A".equals(prodLink))
			prodLink="../../Images/noimage.gif";
		
%>
<%//@include file="../../../Includes/JSPs/Catalog/iScalePrices.jsp"%>

<%				String priceScale="0";
				/*priceScale=scaleResultRet.getFieldValueString(scaleResultRet.getRowCount()-1,"CONDVAL");
				try
				{
					priceScale = new java.math.BigDecimal(priceScale).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
				}
				catch(Exception e){}
				if("NA".equals(scaleResultRet.getFieldValueString(0,"PRODUCT")))
				{*/
					priceScale="N/A";
				//}
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
				<img src="<%=prodLink%>" alt='<%=prodDesc%>' width=140>
			</div>
		</a>
		</div>
		</li>
<%
	}
%>
	</ul>
	</div>
	</section>-->
	<script type="text/javascript">
		jQuery(document).ready(function() {
		jQuery('.jcarousel-tabs-rb > ul').jcarousel({
			visible: 4,
			scroll: 4,
			animation: 1200,
			itemFallbackDimension: 160,
			
		});
		});
	</script>

<div id="adj-nav-container1">

<!-- Start of the Styles and Scripts for Hello Bar Solo -->
<link type="text/css" rel="stylesheet" href="../../../Includes/Lib/hellobar-solo/hellobar.css" />
<script type="text/javascript" src="../../../Includes/Lib/hellobar-solo/hellobar.js"></script>
<!-- End of the Styles and Scripts for Hello Bar Solo -->

<Script src="../../Library/Script/popup.js"></Script>

<script type="text/javascript">
	function getProductsBC(catId,catDesc)
	{
		document.myFormPD.categoryID.value=catId;
		document.myFormPD.categoryDesc.value=catDesc;

		document.myFormPD.action="ezProductsDisplay.jsp";
		document.myFormPD.submit();
	}
	
	function getSubCatalogList(supCatId,supCatDesc)
	{
		document.myFormPD.mainCatID.value=supCatId;
		document.myFormPD.mainCatDesc.value=supCatDesc;

		document.myFormPD.action="ezSubCatalogDisplay.jsp";
		document.myFormPD.submit();
	}

	function addToCart_D(num)
	{
		
		/*var subUser = '<%=session.getValue("IsSubUser")%>'
		//alert("subUser:::::"+subUser)
		if(subUser=='Y')
		{
			var subAuth = '<%=session.getValue("SuAuth")%>'
			if(subAuth=='VONLY')
			{
				alert("You are not authorised to add products to Cart. Please Contact administartor for any queries.")
				return;

			}
		}*/		
		var cRefType = document.myFormPD.catRefType.value;
		var cType = document.myFormPD.catType.value;

		var typeFlag = true;
		
		if(cRefType=='QS')
		{
			if(cType=='PT' || cType=='FOC' || cType=='C')
			{
				typeFlag = false;
				alert("Cart contains Quick Ship items. \nPlease remove them to add other items");
			}
		}
		if(cRefType=='PT')
		{
			if(cType=='Q' || cType=='FOC' || cType=='C')
			{
				typeFlag = false;
				alert("Cart contains Standard items. \nPlease remove them to add other items");
			}
		}
		if(cRefType=='FOC')
		{
			if(cType=='Q' || cType=='PT' || cType=='C')
			{
				typeFlag = false;
				alert("Cart contains Free Of Charge items. \nPlease remove them to add other items");
			}
		}
		if(cRefType=='QT')
		{
			if(cType=='Q' || cType=='FOC' || cType=='C')
			{
				typeFlag = false;
				alert("Cart contains Quote items. \nPlease remove them to add other items");
			}
		}
		if(cRefType=='C')
		{
			if(cType=='Q' || cType=='FOC' || cType=='PT')
			{
				typeFlag = false;
				alert("Cart contains Custom items. \nPlease remove them to add other items");
			}
		}		
		
		if(typeFlag)
		{				
			var cflag   	  =  eval("document.myFormPD.cgchk_"+num).value;
			var commgrpdesc   =  eval("document.myFormPD.commgrp_"+num).value;
			var commgrp   	  =  eval("document.myFormPD.commGrp_"+num).value;
			
			if(cflag=="N" && commgrp!='CS' && commgrp!='QS')
			{					
				alert("Selected Product is Exclusive to "+commgrpdesc+" customers. \nIf you want to order, please contact Customer Admin Service")	
				return false;		
			}
			else
			{				
				var qty    = eval("document.myFormPD.qty_"+num).value;
				var Atpqty = eval("document.myFormPD.Atpqty_"+num).value;			

				/*if(parseInt(qty)>parseInt(Atpqty))
				{
					alert("Available Quantity:  "+parseInt(Atpqty)+"\nPlease order the quantity within the limit.");
					return false;
				}
				else
				{*/		
					//document.myFormPD.prodIden.value=num;

					//document.myFormPD.action="../ShoppingCart/ezAddCartItems.jsp";
					//document.myFormPD.submit();
					
					addToCartFav(num,'1234','C');
				//}				
			}
		}
	}
	
	function getProductDetails(code)
	{
		document.myFormPD.prodCode_D.value=code;

		document.myFormPD.action="../Catalog/ezProductDetails.jsp";
		document.myFormPD.submit();
	}
	function getProducts(page)
	{
		document.myFormPD.pageNum.value = page;

		document.myFormPD.action="../Catalog/ezProductsDisplay.jsp";
		document.myFormPD.submit();
	}
	function viewProducts(page)
	{
		document.myFormPD.pageSize.value = page;

		document.myFormPD.action="../Catalog/ezProductsDisplay.jsp";
		document.myFormPD.submit();
	}
	function sortBy()
	{
		document.myFormPD.action="../Catalog/ezProductsDisplay.jsp";
		document.myFormPD.submit();
	}
	function refBrand()  
	{	
		Popup.showModal('modal');
		document.myFormPD.action="../Catalog/ezProductsDisplay.jsp"; 	
		document.myFormPD.submit();
	}
	function clearAll()  
	{	
	
		Popup.showModal('modal');

		if(document.myFormPD.brandchk!=null)
		{
			var brandlen  = document.myFormPD.brandchk.length;
			if(isNaN(brandlen))
			{
				document.myFormPD.brandchk.checked = false;			
			}
			else
			{
				for(a=0;a<brandlen;a++)
				{
					document.myFormPD.brandchk[a].checked = false;				
				}
			}
		}
		
		if(document.myFormPD.stylechk!=null)
		{
			var stylelen  = document.myFormPD.stylechk.length;
			if(isNaN(stylelen))
			{
				document.myFormPD.stylechk.checked = false;			
			}
			else
			{
				for(a=0;a<stylelen;a++)
				{
					document.myFormPD.stylechk[a].checked = false;				
				}
			}
		}
		if(document.myFormPD.familychk!=null)
		{		
			var familylen = document.myFormPD.familychk.length;
			if(isNaN(familylen))
			{
				document.myFormPD.familychk.checked = false;			
			}
			else
			{
				for(a=0;a<familylen;a++)
				{
					document.myFormPD.familychk[a].checked = false;				
				}
			}
		}
		if(document.myFormPD.dischk!=null)
		{		
			var dislen    = document.myFormPD.dischk.length;
			if(isNaN(dislen))
			{
				document.myFormPD.dischk.checked = false;			
			}
			else
			{
				for(a=0;a<dislen;a++)
				{
					document.myFormPD.dischk[a].checked = false;				
				}
			}
		}
		if(document.myFormPD.modelchk!=null)
		{		
			var modellen   = document.myFormPD.modelchk.length;
			if(isNaN(modellen))
			{
				document.myFormPD.modelchk.checked = false;			
			}
			else
			{
				for(a=0;a<modellen;a++)
				{
					document.myFormPD.modelchk[a].checked = false;				
				}
			}
		}
		if(document.myFormPD.lengthchk!=null)
		{		
			var lengthlen  = document.myFormPD.lengthchk.length;
			if(isNaN(lengthlen))
			{
				document.myFormPD.lengthchk.checked = false;			
			}
			else
			{
				for(a=0;a<lengthlen;a++)
				{
					document.myFormPD.lengthchk[a].checked = false;				
				}
			}
		}
		if(document.myFormPD.subtypechk!=null)
		{		
			var subtypelen = document.myFormPD.subtypechk.length;
			if(isNaN(subtypelen))
			{
				document.myFormPD.subtypechk.checked = false;			
			}
			else
			{
				for(a=0;a<subtypelen;a++)
				{
					document.myFormPD.subtypechk[a].checked = false;				
				}
			}
		}
		if(document.myFormPD.attrchk!=null)
		{		
			var attrlen    = document.myFormPD.attrchk.length;
			if(isNaN(attrlen))
			{
				document.myFormPD.attrchk.checked = false;			
			}
			else
			{
				for(a=0;a<attrlen;a++)
				{
					document.myFormPD.attrchk[a].checked = false;				
				}
			}		
		}
		document.myFormPD.action="../Catalog/ezProductsDisplay.jsp"; 	
		document.myFormPD.submit();
	}
	
	
	var req
	var stat 
	var pcode
	function addToCartFav(val,prodcode,stats)
	{		
		
		/*var subUser = '<%=session.getValue("IsSubUser")%>'
		//alert("subUser:::::"+subUser)
		if(subUser=='Y')
		{
			var subAuth = '<%=session.getValue("SuAuth")%>'
			if(subAuth=='VONLY')
			{
				alert("You are not authorised to add products to Cart. Please Contact administartor for any queries.")
				return;

			}
		}*/		
		
		req=Initialize();

		if (req==null)
		{
		alert ("Your browser does not support Ajax HTTP");
		return;
		}			
		
		var chkval = val
		var catid = '<%=categoryID%>'
		var clsid = '<%=classificationID%>'
		pcode=prodcode
		var url
		stat=stats
	    
		if(stat=="C")
		{	
		
			var atpfor  = eval("document.myFormPD.prodCode_"+val).value;
			var atpqty  = eval("document.myFormPD.qty_"+val).value;
			var atpdesc = eval("document.myFormPD.prodDesc_"+val).value;
			var atpprice= eval("document.myFormPD.listPrice_"+val).value;
			var atpupc  = eval("document.myFormPD.eanUpc_"+val).value;
			var atpcgr  = eval("document.myFormPD.commGroup_"+val).value;
			var atpdiv  = eval("document.myFormPD.prodDiv_"+val).value;
	    		
	    		var cType = document.myFormPD.catType.value;
	    		
	    		pcode=atpfor

			//url="../ShoppingCart/ezAddCartItems.jsp";
			//url=url+"?atpfor="+atpfor+"&atpqty="+atpqty+"&atpdesc="+atpdesc+"&atpprice="+atpprice+"&atpupc="+atpupc+"&atpcgr="+atpcgr+"&catType="+cType+"&atpdiv="+atpdiv;			

			url="../ShoppingCart/ezAddCartQuickEntry.jsp";
			url=url+"?atpfor="+atpfor+"&atpqty="+atpqty+"&atpdesc="+atpdesc+"&atpprice="+atpprice+"&atpupc="+atpupc;
		}
		if(stat=="V")
		{	
			
			url="ezAddProductsFav.jsp";
			url=url+"?chkProds="+chkval+"&categoryID="+catid+"&classificationID="+clsid;		
		}
			
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
				if(stat=="C")
				{
					var alertCode
					var reasonCode = '';	
					var alertIcon
					var barCol = '#eb593c'
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
						alertCode='has been successfully added to cart'
						alertIcon = '<img src="../../Library/images/icon-success-message.png"/>';
						//barCol = '#71c6aa'
						
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
					//barColor : barCol,
					height : 30

					}, 1.0 );
				}
				if(stat=="V")
				{
					var alertIcon = '<img src="../../Library/images/icon-success-message.png"/>';
					new HelloBar( '<span>'+ alertIcon +' Product '+pcode+' has been successfully added to Your Favorites.</span> <a href="ezGetFavProdMain.jsp">Click to See Your Favorites!</a>', {
							showWait: 1000,
							positioning: 'sticky',
							fonts: 'Arial, Helvetica, sans-serif',
							forgetful: true,
							helloBarLogo : false,
							//barColor : '#71c6aa',
							height : 30
							
					}, 1.0 );
					
					//alert("New product(s) have been successfully added to My Favorites")
				}
			}
			else
			{
				if(req.status == 500)	 
				alert("Error in adding product(s)");
			}
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
	    var atpfobj = eval("document.myFormPD.prodCode_"+ind)
	    var atpqobj = eval("document.myFormPD.qty_"+ind)	
		
	    var atpfor = atpfobj.value;
	    var atpqty = atpqobj.value;
	    var atpon=document.myFormPD.atpon.value;
	    var stAtp=document.myFormPD.stAtp.value;
	
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
		var atpfobj = eval("document.myFormPD.prodCode_"+ind)
		var atpdobj = eval("document.myFormPD.prodDesc_"+ind)
	
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


<style>
a {color:#333; text-decoration:none}
a:hover {color:#50B4B6 !important; font-weight:bold; text-decoration:none}
</style>
<form name="myFormPD" method="post" >
<input type="hidden" name="pageSize" value="<%=pageSize%>">
<input type="hidden" name="FavGroup" >
<input type="hidden" name="GroupDesc" >
<input type="hidden" name="chkProds" > 
<input type="hidden" name="categoryID" value="<%=categoryID%>">
<input type="hidden" name="categoryDesc" value='<%=catDesc%>'>
<input type="hidden" name="mainCatID" value='<%=supCatId%>'>
<input type="hidden" name="mainCatDesc" value='<%=supCatDesc%>'> 



<div class="toolbar">
	<div class="limiter">
	

		<label>View:</label>
<%
	
	String viewPages[] = {"9","18","27","99"};

	for(int v=0;v<viewPages.length;v++)
	{
		String cSel = "";

		if(viewPages[v].equals(pageSize+"")) cSel = "class=selected";
%>
		<button onclick="javascript:viewProducts(<%=(viewPages[v])%>)" <%=cSel%>><span><span><%=(viewPages[v])%></span></span></button>
<%
	}
	
%>
	</div>
	<div class="pager">
	<div class="pages">
<%
	int startCnt = (pageMaxNo-pageSize)+1;

	if(pageMaxNo<pageSize)
		startCnt = 1;

	int endCnt = pageMaxNo;

	int numLinksCnt = itemsCnt/pageSize;
	int numLinksDiv = itemsCnt%pageSize;

	if(numLinksCnt==1) numLinksCnt=0;

	boolean allItems = false;

	if((numLinksCnt==4 && numLinksDiv>0) || numLinksCnt>4)
		allItems = true;

	if(itemsCnt>0)
	{
%>
		<span>Page:</span>
		<ol>
<%
		int pLast = pageNum_T+3;
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
			if(i==pageNum_T)
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
				<li class="next-outer"><a class="next i-next" href="javascript:getProducts(<%=(pageNum_T+1)%>)" title="Next">
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
<input type="hidden" name="prodCode_D">

<input type="hidden" name="classificationID" value="<%=classificationID%>">
<input type="hidden" name="catType" value="<%=catType%>">
<input type="hidden" name="ctype" value="<%=catType%>">
<input type="hidden" name="pageNum" value="<%=pageNum_T%>">
<input type="hidden" name="catRefType" value="<%=catType_C%>">
<div class="category-products">
<input type="hidden"  id="atpon" name="atpon" value="<%=atpon%>" />
<input type="hidden"  id="stAtp" name="stAtp" value="<%=session.getValue("shipState")%>" />


<%
	ArrayList prodCodesAL = new ArrayList();
	String prodCodeAL  = null;
	for(int al=0;al<catalogProductsRetObj.getRowCount();al++)
	{
		prodCodeAL  = catalogProductsRetObj.getFieldValueString(al,"EZP_PRODUCT_CODE");		
		prodCodesAL.add(prodCodeAL);	
	}
	
%>

<%@include file="ezATPMultiple.jsp"%>

<%
	//out.println("atpMultHM"+atpMultHM);
	String atpAvailCC = "",atpAvailC="",prodDesc = "",webSKU = "",currPrice = "",eanUpc = "",prodCode = "",prodLink = "",discChk = "",filePath = "",prodDiv = "";
	String commGrpDesc="",repProdCode="",discStat="",commGorupId_PA="",favDtl="",commGroupFlag = "";
	String atpProdAvlb   = "";
	float atpRetQtyC=0;
	
	String strCommGroup  =   (String)session.getValue("CommGroup");
	
	HashMap cgHM = new HashMap();
			
	cgHM.put("AM","AOR, Menards");
	cgHM.put("AU","AOR");
	cgHM.put("BA","CS & AOR, Menards");
	cgHM.put("BB","CS & AOR");
	cgHM.put("BC","CS & CANADA AOR");
	cgHM.put("BD","CS & CANADA COSTCO");
	cgHM.put("BE","CS & CANADA THD");
	cgHM.put("BF","CS & MEXICO THD");
	cgHM.put("BG","CS & HOME DEPOT US");
	cgHM.put("BH","CS & CANADA LOWES");
	cgHM.put("BI","CS & MEXICO LOWES");
	cgHM.put("BJ","CS & Lowes, AOR");
	cgHM.put("BK","CS & LOWES US");
	cgHM.put("BL","CS & Menards, Trade");
	cgHM.put("BM","CS & MENARDS US");
	cgHM.put("BN","CS & CANADA RONA");
	cgHM.put("BO","CS & HD Lowes Menard");
	cgHM.put("BP","CS & AOR SAMS CLUB");
	cgHM.put("BQ","CS & RETAIL ONLY");
	cgHM.put("CA","CANADA AOR");
	cgHM.put("CC","CANADA COSTCO");
	cgHM.put("CS","CUSTOM SKU MATL");
	cgHM.put("EI","E-TAIL/INTERNET");
	cgHM.put("FG","FERGUSON EXCL..");
	cgHM.put("HC","CANADA THD");
	cgHM.put("HM","MEXICO THD");
	cgHM.put("HU","HOME DEPOT US");
	cgHM.put("LC","CANADA LOWES");
	cgHM.put("LM","MEXICO LOWES");
	cgHM.put("LR","Lowes, AOR");
	cgHM.put("LU","LOWES US");
	cgHM.put("MT","Menards, Trade");
	cgHM.put("MU","MENARDS US");
	cgHM.put("QS","QUICK SHIP FAUCET");
	cgHM.put("RC","CANADA RONA");
	cgHM.put("RE","HD, Lowes, Menards");
	cgHM.put("SC","AOR SAMS CLUB");
	cgHM.put("WW","WATERWORKS US");
	cgHM.put("ZR","RETAIL ONLY");
	cgHM.put("ZW","HD/YOW AOR LOWE/TRUM");
	cgHM.put("ZX","HD,YOW, AOR, ETAIL");
	cgHM.put("ZY","HD, YOW, AOR, FD");
	cgHM.put("ZZ","RETAIL, ETAIL ONLY");
			
	
		
	String cssLiClass = "item first";
	int uCnt = 3;

	for(int i=0;i<catalogProductsRetObj.getRowCount();i++)
	{
	
	
		if(i%3==0)
		{
%>
			<ul class="products-grid">
<%
			uCnt++;
		}

		if(i>0 && i%3==0) cssLiClass = "item first";
		if(i>0 && (i-1)%3==0) cssLiClass = "item ";
		if(i>0 && (i-2)%3==0) cssLiClass = "item last";

		 prodDesc = catalogProductsRetObj.getFieldValueString(i,"PROD_DESC");
		 if(prodDesc==null || "".equals(prodDesc) || "null".equals(prodDesc))
			prodDesc = "N/A";
		 webSKU = catalogProductsRetObj.getFieldValueString(i,"EZP_PRODUCT_CODE");//EZP_WEB_SKU
		 currPrice = eliminateDecimals(catalogProductsRetObj.getFieldValueString(i,"EZP_CURR_PRICE"));
		 eanUpc = catalogProductsRetObj.getFieldValueString(i,"EZP_UPC_CODE");
		 prodCode = catalogProductsRetObj.getFieldValueString(i,"EZP_PRODUCT_CODE");
		 prodLink = nullCheck(catalogProductsRetObj.getFieldValueString(i,"EZP_ATTR3"));
		 discChk = catalogProductsRetObj.getFieldValueString(i,"EZP_STATUS");
		 prodDiv = catalogProductsRetObj.getFieldValueString(i,"DIVISION");
		 
		 atpProdAvlb = (String)atpMultHM.get(prodCode);
		 				
		try{
			atpRetQtyC = Float.parseFloat(atpProdAvlb);
		}catch(Exception e){
			atpRetQtyC = 0;
		}

		if(atpRetQtyC>=1)
		{
			atpAvailCC = "Y";
			atpAvailC = "Y";
		}
		else
		{
			atpAvailCC = "N";
			atpAvailC = "N";
		}
		
	
		
		if("N/A".equals(prodLink))
			prodLink="../../Images/noimage.gif";
			
		if(!prodLink.startsWith("http://dxv") && categoryID.startsWith("DXV"))
			prodLink="http://dxv.blob.core.windows.net/dxv-product-images/DXV_NoImage-01.jpg";
			
		
		//code for identifying the item discontinued or replaced.
				
		 repProdCode = catalogProductsRetObj.getFieldValueString(i,"EZP_REPLACES_ITEM");
		 discStat    = catalogProductsRetObj.getFieldValueString(i,"EZP_DISCONTINUED");
		 commGorupId_PA   = catalogProductsRetObj.getFieldValueString(i,"EZP_ATTR1");
		
		if(categoryID==null || "null".equals(categoryID) || "".equals(categoryID))categoryID = classificationID;
		 favDtl = prodCode+"~~"+categoryID+"~~CNET";
%>


			<li class="<%=cssLiClass%>">
				<a href="javascript:getProductDetails('<%=prodCode%>')" title='<%=prodDesc%>' class="product-image">
					<img src="<%=prodLink%>" width="200px" height="220px" alt="">
				</a>
				<h6 class="product-name"><a href="javascript:getProductDetails('<%=prodCode%>')" title='<%=prodDesc%>'><%=prodDesc%>&nbsp;</a></h6>
				<!--<p class="cat-num"><%=prodDesc%></p>-->
				<p class="cat-num">SKU # <%=webSKU%>

<%				String disc = "Y",discActive="";
				
				//if("Z3".equals(discChk) || "Z2".equals(discChk) || "Z4".equals(discChk))
				if("Z4".equals(discChk))
				{					
%>													
					<font color=red>(Discontinued)</font></p>					
<%				}
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
				
				if("Z4".equals(discChk) || "ZF".equals(discChk) || "11".equals(discChk) || "ZP".equals(discChk))
				{
					disc = "N";
					discActive="Y";
				}	
				
%>

				<div class="price-box">
				<span class="top-price-wrapper">List Price:
				<span class="regular-price" id="product-price-<%=i%>">
					<span class="price" style="color:#000000;">$<%=currPrice%></span>
				</span>
				
					
		
				</div>
				
				
				
				
				
<%//@include file="../ShoppingCart/ezCartItemATPCheck.jsp"%>

<%
				
		commGrpDesc=(String)cgHM.get(commGorupId_PA);
		
		if(commGorupId_PA!=null && !"".equals(commGorupId_PA) && !"null".equals(commGorupId_PA))
		{
			if(strCommGroup.equals(commGorupId_PA))
			{
				commGroupFlag = "Y";			
			}
			else
			{
				commGroupFlag = "N";	
			}
		}		
		
		//out.println("commGorupId_PA:::"+commGorupId_PA);
		//out.println("strCommGroup:::"+strCommGroup);
											
		
%>
			<input type="hidden" name="cgchk_<%=i%>" id="cgchk_<%=i%>" value='<%=commGroupFlag%>' class="grid-qty-input">
			<input type="hidden" name="commgrp_<%=i%>" id="commgrp_<%=i%>" value='<%=commGrpDesc%>' class="grid-qty-input">
			<input type="hidden" name="commGrp_<%=i%>" id="commGrp_<%=i%>" value='<%=commGorupId_PA%>' class="grid-qty-input">
			
			<table>
			<tbody>
<%
			// CHECK for DXV or Exclusivity Indicator now
			Hashtable custAttrsHT	= (Hashtable)session.getValue("CUSTATTRS");
			String prepShipTo	= (String)session.getValue("SHIPTO_PREP");

			boolean prdAllowed = true;
			String custAttr ="";
			//ezc.ezcommon.EzLog4j.log("DEBUG:::::::::: MUKESH::::HastTable : " + custAttrsHT,"D");
			//out.println(custAttrsHT);
			try
			{
				//get the sales org appropriate for product
				String atpSOr = catalogProductsRetObj.getFieldValueString(i,"EZP_SALES_ORG");
				custAttr	= (String)custAttrsHT.get(atpSOr); 
				String prodAttr = catalogProductsRetObj.getFieldValueString(i,"EZP_PROD_ATTRS");
				//get the prod. Attribute matrix for Product
				prdAllowed	= checkAttributes(prodAttr,custAttr);
				
				ezc.ezcommon.EzLog4j.log("DEBUG:::::::::: MUKESH::::Attributes being checked: Prod Master SO" + atpSOr + "Cust Attr" + custAttr+ "-Prod Attr-"+prodAttr,"D");
				
			}
			catch(Exception e){}
			
			// ENd if Exclusivity Checks
			if ( prdAllowed && !("11".equals(discChk))) {
%>
			
			<tr>
			<td >&nbsp;&nbsp;&nbsp;&nbsp;</td>
			
			<td valign="bottom">
			<br>
			Qty:
			<input type="text" name="qty_<%=i%>" id="qty_<%=i%>" value='1' class="grid-qty-input" style="width:24px;height:17px;border-radius:3px;">
			</td>
			
			<td >&nbsp;&nbsp;
			</td>
			<td>
			<br>
			<ul id="navbar1" >
			<li><a href="javascript:void()" style="border-radius:3px;"><img src="../../Library/images/actionsicon.png" style="margin-top:3px;" width='17' height='11'><span class="arrow"></span></a>

			<ul style="z-index:10000;border-radius:5px;">

<%	
			if("".equals(discChk))
			{
				atpAvailC  = "Y";
				disc = "N";
				
			}

			if(("Y".equals(atpAvailC) && "N".equals(disc) && prdAllowed))
			{
%>				
				<li><a href="#"  onClick="javascript:addToCart_D('<%=i%>')"><span>Add to Cart</span></a></li>
				<li><a href="#"  onClick="javascript:addToCartFav('<%=favDtl%>','<%=prodCode%>','V')"><span>Add to Fav.</span></a></li>			
<%						
			}
%>				
				<li><a class="fancybox" href="#ajaxid<%=i%>"  onClick="javascript:loadContent('<%=i%>')" ><span>Availability</span></a></li>			
				
				<%if("Y".equals(bestPrice))
				{%>
				<li><a class="fancybox" href="#scaleid<%=i%>"  onClick="javascript:loadScalePrice(<%=i%>)" ><span>Best Price</span></a></li>
				<%}%>
				
			</ul>

			</li>
			</ul>

			</td>
			<td >&nbsp;&nbsp;</td>
			<td>
			<br>
<%			if("Y".equals(atpAvailCC) && prdAllowed)
			{
%>																					
				<p class="availability out-of-stock"> <span><FONT COLOR="GREEN">IN Stock</FONT> </span> </p>  
				
<%			}
			else
			{			
				if (prdAllowed) {
%>				
				<p class="availability out-of-stock"><span><FONT COLOR='#C11B17'>NO Stock</FONT></span></p>
<%			} }
%>			
			</td>			
			</tr>
<% }  // end of if prdAllowed for DXV/Exclusive check 
else {
	if (! prdAllowed) {
%>									
	<tr><td><span><FONT COLOR="RED">Not included in your portfolio or<br>default Ship-To Account</span></td></tr>
<% } } // end of else prdAllowed for DXV/Exclusive check  %>	
			</tbody>
			</table>
			
			<input type="hidden" name="Atpqty_<%=i%>" id="Atpqty_<%=i%>" value='<%=atpRetQtyC%>'>
					
<%			if(repProdCode!=null && !"".equals(repProdCode) && !"null".equals(repProdCode) && "Y".equals(discStat))
			{
%>				
				<!--<label class="grid-qty-label" style="color:red">Replaced With:</label>
				<h3 class="product-name"><a href="javascript:getProductDetails('<%=repProdCode%>')" 
				title="Click here for Details"><%=repProdCode%>&nbsp;</a></h3>-->
<%			}				
%>									
				
<input type="hidden" name="prodDesc_<%=i%>" value='<%=prodDesc%>'>
<input type="hidden" name="prodCode_<%=i%>" value="<%=webSKU%>">
<input type="hidden" name="listPrice_<%=i%>" value="<%=currPrice%>">
<input type="hidden" name="eanUpc_<%=i%>" value="<%=eanUpc%>">
<input type="hidden" name="commGroup_<%=i%>" value="<%=commGorupId_PA%>">
<input type="hidden" name="prodDiv_<%=i%>" value="<%=prodDiv%>">

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
			<div id="scaleid<%=i%>" style="width: 500px; display: none; ">
				<div align=center  style="padding-top:10px;">
					<ul>
						<li>&nbsp;</li>
						<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
						<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
					</ul>
				</div>
			</div>
			</div>
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
	<script type="text/javascript">decorateGeneric($$('ul.products-grid'), ['odd','even','first','last'])</script>
</div>

	<div class="toolbar-bottom">
		<div class="toolbar">
		<div class="back-to-top">
			<a onclick="jQuery('html, body').animate( { scrollTop: 0 }, 'slow');" href="javascript:void(0);" class="to-top"><span><span>Back to top</span></span></a>
		</div>
		</div>
	</div>
	<div class="compare-controls" style="display: none; ">
		<a href="http://www.americanstandard.com/#" id="compare-link" class="compare-link disabled" data-count="0">
			Compare Your Selections <span>[&nbsp; <span class="x-out">0</span> &nbsp;]</span>
		</a>
		&nbsp;|&nbsp;
		<a href="http://www.americanstandard.com/#" id="compare-clear">[&nbsp; <span class="x-out">x</span> &nbsp;] Clear All</a>
	</div>
	<script type="text/javascript">
		new AddToCompare('compare-check', 'compare-link', 'compare-clear');
	</script>
	<div class="adj-nav-progress" style="display:none"><img src="" alt="Preloader"></div>
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
<% String categoryDesc180 = categoryDetailsObj.getFieldValueString(0,"ECD_TEXT");
   if ((categoryDesc180  != null) && (categoryDesc180.length() >180)) {
   	categoryDesc180 = categoryDesc180.substring(0,180);
   
   }
 %>  
   
<% if (classificationID != null && !"null".equalsIgnoreCase(classificationID)) { %>
<h3><%=classificationID%></h3>
<% }; if (categoryID != null && !"null".equalsIgnoreCase(categoryID)) { %>
<h3><%=catDesc%></h3>
<% }; %>
	
	<% if (classificationID != null && !"null".equalsIgnoreCase(classificationID)) { %>
	<p>From Classification</p>
	<% }; %>
	<!--<a href="ezProductsDisplay.jsp#"><span>Learn More</span></a>-->
</div>
</div>
<div id="layerednav-top-content" style="display:none">
	<% if (categoryID != null && !"null".equalsIgnoreCase(categoryID)) { %>
	<h2><%=categoryID%></h2>
	<p><%=categoryDetailsObj.getFieldValueString(0,"ECD_TEXT")%></p>
	<% }; %>
	<% if (classificationID != null && !"null".equalsIgnoreCase(classificationID)) { %>
		<h2><%=classificationID%></h2>
		<p>From Classification Text</p>
	<% }; %>
	<div class="know-close-button"><a href="ezProductsDisplay.jsp#">[ x ] Close</a></div>
</div>
	<script type="text/javascript">
	var viewport = document.viewport.getDimensions();
 
 	$$('.layerednav-top a').invoke('observe', 'click' ,function(){
 		Dialog.info($('layerednav-top-content').innerHTML, { className: "magento know", width:620, height:763, zIndex: 99999, recenterAuto:false, autoresize:false, top:160, left: viewport.width/2 - 230, onShow:function(){
 				$$('.overlay_magento.know', '.know-close-button a').invoke('observe','click',function(){
 					Dialog.closeInfo()
 				});
 		} });
 	});
 	</script>
<div id="adj-nav-navigation">
<script type="text/javascript">var personalizeSelected = false;</script>
<script type="text/javascript" src="../../Library/Script/adjnav-14.js"></script>
<input type="hidden" id="adjnav-attr-expand" value="Show More Attributes">
<input type="hidden" id="adjnav-attr-collapse" value="Show Less Attributes">
<input type="hidden" id="adjnav-attr-val-expand" value="Show More">
<input type="hidden" id="adjnav-attr-val-collapse" value="Show Less">
<div class="block block-layered-nav adj-nav">
<div class="block-content">
<div class="narrow-by">
<input type="hidden" id="adj-nav-url" value="">
<input type="hidden" id="adj-nav-params" value="">
<input type="hidden" id="adj-nav-ajax" value="">

<dl id="narrow-by-list">
<%
	if(brandsVect.size()!=0 || stylesVect.size()!=0  || familyVect.size()!=0  || disVect.size()!=0 ||
	   modelsVect.size()!=0 || lengthVect.size()!=0  || subtypeVect.size()!=0 || attrVect.size()!=0
	)
	{
%>
	<div class="compare-controls" style="left:100px">
	    <a href="javascript:clearAll()" class="adj-nav-dt odd"><font color='grey'><strong>[ x ] Clear All</strong></font></a>
	</div>
<%	}

	if(catalogBrandRetObj!=null && catalogBrandRetObj.getRowCount()>0)
	{
%>	
	<dt class="adj-nav-dt odd"><li>Brand</li></dt>
	<dd id="adj-nav-filter-set_configuration" class="odd">
	<ol style="overflow-x: hidden; overflow-y: hidden; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px; width: 190px; ">
<% 
	for(int b=0;b<catalogBrandRetObj.getRowCount();b++)
	{
	
		String brandRet = catalogBrandRetObj.getFieldValueString(b,"BRANDS");
		
		if(brandRet!=null && !"".equals(brandRet) && !"null".equals(brandRet))
		{
			
			String brandFilCnt ="";
			String brandCount ="";
			if(brandsHM.containsKey(brandRet))
			{  brandFilCnt = (String)brandsHM.get(brandRet); }
			if(!"".equals(brandFilCnt))
			{
				brandCount=eliminateDecimals(brandFilCnt);
			}
						
			
			String checked = "";
			if(brandsVect.contains(brandRet))
				checked = "checked";
				
			try{
				Integer.parseInt(brandCount);
				brandCount = "("+brandCount+")";
			}catch(Exception e){
				checked = "disabled";
			}
%>
		<li class="attr-val-featured">
		<input type="checkbox" style="outline:thin solid #66CC33;" name="brandchk" value="<%=brandRet%>" onClick="refBrand()" <%=checked%>/>
		<a href="#" >
			
			<%=brandRet%> <%=brandCount%>
			
		</a>
		</li>
<%
		}
	}
%>
	</ol>
	</dd>
<%	
	}
	if(catalogStyleRetObj!=null && catalogStyleRetObj.getRowCount()>0)
	{
%>	
	<dt class="adj-nav-dt odd"><li>Style</li></dt>
	<dd id="adj-nav-filter-set_configuration" class="odd">
	<ol style="overflow-x: hidden; overflow-y: hidden; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px; width: 190px; ">	
	
<%
	
	for(int s=0;s<catalogStyleRetObj.getRowCount();s++)
	{

		String stylesRet = catalogStyleRetObj.getFieldValueString(s,"STYLES");		
		
		if(stylesRet!=null && !"".equals(stylesRet) && !"null".equals(stylesRet))
		{
			
			String styleFilCnt ="";
			String styleCount = "";
			if(styleHM.containsKey(stylesRet))
			{  styleFilCnt = (String)styleHM.get(stylesRet); }
			if(!"".equals(styleFilCnt))
			{
				styleCount=eliminateDecimals(styleFilCnt);
			}
												
			String checked = "";
			if(stylesVect.contains(stylesRet))
				checked = "checked";
				
			try{
				Integer.parseInt(styleCount);
				styleCount = "("+styleCount+")";
			}catch(Exception e){
				checked = "disabled";
			}
%>
		<li class="attr-val-featured">
		<input type="checkbox" name="stylechk" value="<%=stylesRet%>" onClick="refBrand()" <%=checked%>/>
		<a href="#" >
			
			<%=stylesRet%><%=styleCount%>
			
		</a>
		</li>
<%
		}
	}
%>
	</ol>
	</dd>
<%	
	}
	if(catalogFamilyRetObj!=null && catalogFamilyRetObj.getRowCount()>0)
	{
%>	
	<dt class="adj-nav-dt odd"><li>Collections</li></dt>
	<dd id="adj-nav-filter-set_configuration" class="odd">
	<ol style="overflow-x: hidden; overflow-y: hidden; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px; width: 190px; ">	
	
<%
	for(int f=0;f<catalogFamilyRetObj.getRowCount();f++)
	{

		String familyRet = catalogFamilyRetObj.getFieldValueString(f,"FAMILY");
		
		if(familyRet!=null && !"".equals(familyRet) && !"null".equals(familyRet))
		{
			String familyFilCnt ="";
			String familyCount ="";
			if(familyHM.containsKey(familyRet))
			{  familyFilCnt = (String)familyHM.get(familyRet); }
			if(!"".equals(familyFilCnt))
			{
				familyCount=eliminateDecimals(familyFilCnt);
			}
		
			String checked = "";
			if(familyVect.contains(familyRet))
				checked = "checked";
				
				
			try{
				Integer.parseInt(familyCount);
				familyCount = "("+familyCount+")";
			}catch(Exception e){
				checked = "disabled";
			}
		
%>
		<li class="attr-val-featured">
		<input type="checkbox" name="familychk" value="<%=familyRet%>" onClick="refBrand()" <%=checked%>/>
		<a href="#" >
			
			<%=familyRet%>
			<%=familyCount%>
			
						
					
		</a>
		</li>
<%
		}
	}
%>
	</ol>
	</dd>
	
<%	
	}
	if(catalogModelRetObj!=null && catalogModelRetObj.getRowCount()>0)
	{
%>	
	<dt class="adj-nav-dt odd"><li>Models</li></dt>
	<dd id="adj-nav-filter-set_configuration" class="odd">
	
	
	<ol style="overflow: auto:width: 190px; ">	

<%
	for(int m=0;m<catalogModelRetObj.getRowCount();m++)
	{

		String modelRet = catalogModelRetObj.getFieldValueString(m,"MODEL");		

		if(modelRet!=null && !"".equals(modelRet) && !"null".equals(modelRet))
		{
		
			String modelFilCnt ="";
			String modelCount="";
			if(modelHM.containsKey(modelRet))
			{  modelFilCnt = (String)modelHM.get(modelRet); }
			
			if(!"".equals(modelFilCnt))
			{			
				modelCount=eliminateDecimals(modelFilCnt);									
			}	
						
			String checked = "";
			if(modelsVect.contains(modelRet))
				checked = "checked";
				
			try{
				Integer.parseInt(modelCount);
				modelCount = "("+modelCount+")";
			}catch(Exception e){
				checked = "disabled";
			}
			
%>			
		
		<li class="attr-val-featured">
		<input type="checkbox" name="modelchk" value="<%=modelRet%>" onClick="refBrand()" <%=checked%>/>
		<a href="#" >

			<%=modelRet%> <%=modelCount%>
						
		</a>
		</li>
		
<%
		}
	}
%>
	</ol>
	</dd>
<%	
	}
	if(catalogLengthRetObj!=null && catalogLengthRetObj.getRowCount()>0)
	{
%>	
	
	<dt class="adj-nav-dt odd"><li>Lengths</li></dt>
	<dd id="adj-nav-filter-set_configuration" class="odd">
	<ol style="overflow: auto:width: 190px; ">

<%
	for(int l=0;l<catalogLengthRetObj.getRowCount();l++)
	{

		String lengthRet = catalogLengthRetObj.getFieldValueString(l,"LENGTH");
		

		if(lengthRet!=null && !"".equals(lengthRet) && !"null".equals(lengthRet))
		{
			String lengthFilCnt ="";
			String lengthCount="";
			if(lengthHM.containsKey(lengthRet))
			{  lengthFilCnt = (String)lengthHM.get(lengthRet); }
			
			if(!"".equals(lengthFilCnt))
			{			
				lengthCount=eliminateDecimals(lengthFilCnt);									
			}

			String checked = "";
			if(lengthVect.contains(lengthRet))
				checked = "checked";
				
			try{
				Integer.parseInt(lengthCount);
				lengthCount = "("+lengthCount+")";
			}catch(Exception e){
				checked = "disabled";
			}

%>
		<li class="attr-val-featured">
		<input type="checkbox" name="lengthchk" value="<%=lengthRet%>" onClick="refBrand()" <%=checked%>/>
		<a href="#" >

			<%=lengthRet%><%=lengthCount%>	
						
		</a>
		</li>
<%
		}
	}
%>
	</ol>
	</dd>
<%	
	}
	if(catalogSubTypeRetObj!=null && catalogSubTypeRetObj.getRowCount()>0)
	{
%>	
	<dt class="adj-nav-dt odd"><li>Sub Type</li></dt>
	<dd id="adj-nav-filter-set_configuration" class="odd">
	<ol style="overflow-x: hidden; overflow-y: hidden; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px; width: 190px; ">	

<%
	for(int st=0;st<catalogSubTypeRetObj.getRowCount();st++)
	{

		String subtypeRet = catalogSubTypeRetObj.getFieldValueString(st,"SUBTYPE");
		
		
		String subtypeFilCnt ="";
		String subtypeCount ="";
		if(subtypeHM.containsKey(subtypeRet))
		{  subtypeFilCnt = (String)subtypeHM.get(subtypeRet); }
		if(!"".equals(subtypeFilCnt))
		{

			subtypeCount=eliminateDecimals(subtypeFilCnt);
		}
								
			

		if(subtypeRet!=null && !"".equals(subtypeRet) && !"null".equals(subtypeRet))
		{
			
			String checked = "";
			if(subtypeVect.contains(subtypeRet))
				checked = "checked";
								
		try{
			Integer.parseInt(subtypeCount);
			subtypeCount = "("+subtypeCount+")";
		}catch(Exception e){
			checked = "disabled";
		}

%>
		<li class="attr-val-featured">
		<input type="checkbox" name="subtypechk" value="<%=subtypeRet%>" onClick="refBrand()" <%=checked%>/>
		<a href="#" >

			<%=subtypeRet%><%=subtypeCount%>
							
		</a>
		</li>
<%
		}
	}
%>
	</ol>
	</dd>
	
<%	}
%>	
	<dt class="adj-nav-dt odd"><li>Status</li></dt>
	<dd id="adj-nav-filter-set_configuration" class="odd">
	<ol style="overflow-x: hidden; overflow-y: hidden; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px; width: 190px; ">	

<%

	ArrayList disAL = new ArrayList();
	disAL.add("New");
	disAL.add("Active");
	disAL.add("To Be Discontinued");
	disAL.add("Discontinued");
	
	for(int d=0;d<disAL.size();d++)
	{
		
		String disRet = (String)disAL.get(d);		
		if(disRet!=null && !"".equals(disRet) && !"null".equals(disRet))
		{
		
		
			String statusFilCnt ="";
			String statusCount ="";
			
			if(statusHM.containsKey(disRet))
			{  statusFilCnt = (String)statusHM.get(disRet); }
			if(!"".equals(statusFilCnt))
			{			
			 statusCount=eliminateDecimals(statusFilCnt);
			}
			
			String checked = "";
			if(disVect.contains(disRet))
				checked = "checked";
			try{
				Integer.parseInt(statusCount);
				statusCount = "("+statusCount+")";
			}catch(Exception e){
				checked = "disabled";
			}	
				
%>
		<li class="attr-val-featured">
		<input type="checkbox" name="dischk" value="<%=disRet%>" onClick="refBrand()" <%=checked%>/>
		<a href="#" >

			<%=disRet%><%=statusCount%>
			
		</a>
		</li>
<%
		}
	}
%>
	</ol>
	</dd>
	

	<!--<dt class="adj-nav-dt odd"><li>Attributes</li></dt>
	<dd id="adj-nav-filter-set_configuration" class="odd">
	<ol style="overflow-x: hidden; overflow-y: hidden; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px; width: 190px; ">	
	-->
<%	
	/*
	ArrayList attrValuesAL = new ArrayList();
	for(int at=0;at<catalogAttributesRetObj.getRowCount();at++)
	{
		String attrFilterable = catalogAttributesRetObj.getFieldValueString(at,"EAC_FILTERABLE");
		
		if("Y".equals(attrFilterable) || "X".equals(attrFilterable))
		{			
		
		String attrRet    = catalogAttributesRetObj.getFieldValueString(at,"EAC_DESC");
		String attrRetVal = catalogAttributesRetObj.getFieldValueString(at,"EAC_ID");		
	
%>
		<li class="attr-val-featured">
		
			<%=attrRet%>
		</li>	
			
			<%//@include file="ezAttrValues.jsp"%>
			
<%			for(int i=0;i<retObjMisc_AID.getRowCount();i++)
			{
				String attrCodeVal     = retObjMisc_AID.getFieldValueString(i,"EPA_ATTR_VALUE");
				String attrCode        = retObjMisc_AID.getFieldValueString(i,"EPA_ATTR_CODE");
				String attrProdCode    = retObjMisc_AID.getFieldValueString(i,"EPA_PRODUCT_CODE");
				String mixAttr 	       = attrCode+"#"+attrCodeVal+"¥"+attrProdCode;
				attrValuesAL.add(mixAttr);
								
%>								
					
		</li>
			
<%			if(attrCodeVal!=null && !"".equals(attrCodeVal) && !"null".equals(attrCodeVal))
			{
				String checked = "";
				if(attrVect.contains(attrCodeVal))
					checked = "checked";

%>				
		<li class="attr-val-featured">
			<input type="checkbox" name="attrchk" value="<%=attrCode%>#<%=attrCodeVal%>" onClick="refBrand()"  <%=checked%>/>
			<%=attrCodeVal%>			
		</li>		
		
<%	
			}
			}
		}
	}
	*/
%>
	<!--</ol>
	</dd>-->
	
<%
	if(brandsVect.size()!=0 || stylesVect.size()!=0  || familyVect.size()!=0  || disVect.size()!=0 ||
	   modelsVect.size()!=0 || lengthVect.size()!=0  || subtypeVect.size()!=0 
	)
	{
%>
	<div class="compare-controls" style="left:100px">
	    <a href="javascript:clearAll()" class="adj-nav-dt odd"><font color='grey'><strong>[ x ] Clear All</strong></font></a>
	</div>
<%	}

	
	//session.putValue("attrValuesALSes",attrValuesAL);
	
%>
</dl>
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
				if(personalizeSelected){ jQuery('a', this).addClass('adj-nav-attribute-selected'); }
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
</form>

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
	
	
	public boolean checkAttributes(String prdAttrs,String custAttr)
	{
		boolean prdAllowed = true;
		int i1 = custAttr.indexOf("X");
		char c1;
		while (i1 >= 0)
		{
			c1 = prdAttrs.charAt(i1);

			prdAllowed = true;
			if('X'==c1)
			{
				prdAllowed = false;
				break;
			}
			i1 = custAttr.indexOf("X",i1+1);
		}
		return prdAllowed;
	}	

%>
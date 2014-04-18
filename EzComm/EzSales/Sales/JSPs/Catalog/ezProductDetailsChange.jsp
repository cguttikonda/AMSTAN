<%@ page contentType="text/html;charset=utf-8" %>
<script type="text/javascript" src="../../Library/Script/jquery.elevatezoom.js"></script>

<!-- Add fancyBox -->
<link rel="stylesheet" href="../../Library/Script/jquery.fancybox.css?v=2.0.5" type="text/css" media="screen" />
<script type="text/javascript" src="../../Library/Script/jquery.fancybox.pack.js?v=2.0.5"></script>
<!-- end of fancybox -->

<!-- Start of the Styles and Scripts for Hello Bar Solo -->
<link type="text/css" rel="stylesheet" href="../../../Includes/Lib/hellobar-solo/hellobar.css" />
<script type="text/javascript" src="../../../Includes/Lib/hellobar-solo/hellobar.js"></script>
<!-- End of the Styles and Scripts for Hello Bar Solo -->

<script type="text/javascript">

// Javascript originally by Patrick Griffiths and Dan Webb.
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

<!--added by Vimal -->
jQuery(function($){
    $(".fancybox").fancybox({closeBtn:true, hideOnOverlayClick:true});
});
<!--added by Vimal -->

</script>
<script type="text/javascript" src="../../Library/JavaScript/Cart/ezCartAlerts.js"></script>
<script type="text/javascript" src="../../Library/Script/jquery.formalize.js"></script>
<style type="text/css">

a {color:#006699; text-decoration:none}
a:hover {color:#000;font-weight:bold; text-decoration:none}

.highlight 
{
	height: 65px;
	width: 940px;
	background: #e9e9e9;
	background: -webkit-linear-gradient(#e9e9e9, #c0c0c0);
	background: -moz-linear-gradient(#e9e9e9, #c0c0c0);
	background: -ms-linear-gradient(#e9e9e9, #c0c0c0);
	background: -o-linear-gradient(#e9e9e9, #c0c0c0);
	background: linear-gradient(#e9e9e9, #c0c0c0);
}
a[href="#contentLinks-tab"]:hover {color:#50B4B6 !important;} 
a[href="#contentDetail-tab"]:hover {color:#50B4B6 !important;}
a[href="#contentParts-tab"]:hover {color:#50B4B6 !important;}
a[href="#contentRel0-tab"]:hover {color:#50B4B6 !important;}
a[href="#contentRel1-tab"]:hover {color:#50B4B6 !important;}
a[href="#contentRel2-tab"]:hover {color:#50B4B6 !important;}
.active a {color:#50B4B6 !important;}
</style>

<script type="text/javascript">

function colorChange()
{	
	var code = document.myFormD.colfin.value;
	if(code!="")
	{
		getProductDetails(code);
	}
}
function getProductDetails(code)
{
	document.myFormD.prodCode_D.value=code;
	document.myFormD.action="../Catalog/ezProductDetails.jsp";
	document.myFormD.submit();
}
function getProductsBC(catId,catDesc)
{
	document.myFormD.categoryID.value=catId;
	document.myFormD.categoryDesc.value=catDesc;
	document.myFormD.action="ezProductsDisplay.jsp";
	document.myFormD.submit();
}
function getSubCatalogList(supCatId,supCatDesc)
{
	document.myFormD.mainCatID.value=supCatId;
	document.myFormD.mainCatDesc.value=supCatDesc;
	document.myFormD.action="ezSubCatalogDisplay.jsp";
	document.myFormD.submit();
}

var req
var stat 
var pcode
var bool
function addToCartFav(val,prodcode,stats)
{		
	req=Initialize();

	if (req==null)
	{
		alert ("Your browser does not support Ajax HTTP");
		return;
	}			
	var pqty = document.myFormD.atpqty.value;
	var chkval = val
	var catid = ''
	var clsid = ''
	pcode=prodcode
	var url
	stat=stats
	var subUser = '<%=session.getValue("IsSubUser")%>'
	if(subUser=='Y')
	{
		var subAuth = '<%=session.getValue("SuAuth")%>'
		if(subAuth=='VONLY')
		{
		}
	}	
	
	if(stat=="C")
	{	
		url="../ShoppingCart/ezAddCartQuickEntry.jsp";
		url=url+"?atpfor="+pcode+"&atpqty="+pqty;			
	}
	else if(stat=="V")
	{	
		url="ezAddProductsFav.jsp";
		url=url+"?chkProds="+chkval+"&categoryID="+catid+"&classificationID="+clsid;		
	}
	else if(stat=="D")
	{
		url="ezDelFavItemAjax.jsp";
		url=url+"?pcode="+pcode;	
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
					alertCode='has been successfully added to Cart'
					reasonCode=''					
					alertIcon = '<img src="../../Library/images/icon-success-message.png"/>';
					var currentC = jQuery('#cartcount').text();
					var newC =parseInt(currentC)+1;
					jQuery('#cartcount').text(newC);
				}

				new HelloBar( '<span>'+ alertIcon +' Product ' +pcode+ ' '+alertCode+ ' ' +reasonCode+  '.</span><a href="../ShoppingCart/ezViewCart.jsp">Click to See Your Cart!</a>', {
								
				showWait: 1000,
				positioning: 'sticky',
				fonts: 'Arial, Helvetica, sans-serif',
				forgetful: true,
				helloBarLogo : false,				
				height : 30
				}, 1.0 );
			}
			else if(stat=="V")
			{									
				alertIcon = '<img src="../../Library/images/icon-success-message.png"/>';
				new HelloBar(  '<span>'+ alertIcon +' Product '+pcode+' has been successfully added to Your Favorites.</span> <a href="ezGetFavProdMain.jsp">Click to See Your Favorites!</a>', {
						showWait: 1000,
						positioning: 'sticky',
						fonts: 'Arial, Helvetica, sans-serif',
						forgetful: true,
						helloBarLogo : false,
						height : 30
				}, 1.0 );
			}
			else if(stat=="D")
			{
				alertIcon = '<img src="../../Library/images/icon-error-message.png"/>';
				new HelloBar( '<span>'+ alertIcon +' Product '+pcode+' has been removed from Favorites.</span> <a href="ezGetFavProdMain.jsp">Click to See Your Favorites!</a>', {
						showWait: 1000,
						positioning: 'sticky',
						fonts: 'Arial, Helvetica, sans-serif',
						forgetful: true,
						helloBarLogo : false,
						height : 30
				}, 1.0 );
			}
		}
		else
		{
			if(req.status == 500)	 
			alert("Error in adding product(s) to Favorites");
		}
		
		if(stat=="V" || stat=="D")
		{
			wait(500);
			document.myFormD.action="ezProductDetails.jsp";
			document.myFormD.submit();
		}
		else
		{
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

function wait(msecs)
{
	var start = new Date().getTime();
	var cur = start
	while(cur - start < msecs)
	{
		cur = new Date().getTime();
	}	
}


var xmlhttp

function loadContent(ind)
{
	xmlhttp=GetXmlHttpObject();
	if (xmlhttp==null)
	{
		alert ("Your browser does not support Ajax HTTP");
		return;
	}
	var atpfor = document.myFormD.atpfor.value;
	var atpqty = document.myFormD.atpqty.value;
	var atpon=document.myFormD.atpon.value;
	var stAtp=document.myFormD.stAtp.value;

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
		document.getElementById("ajaxidATP").innerHTML=xmlhttp.responseText;
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

var xmlhttpSC
var getIndSC
var getSC
function loadContentSC(indSC,prodItm)
{
	getIndSC = indSC;
	getSC = prodItm
	xmlhttpSC=GetXmlHttpObjectSC();

	if (xmlhttpSC==null)
	{
		alert ("Your browser does not support Ajax HTTP");
		return;
	}
	if(getSC=='S')
	{
		var atpfobj = eval("document.myFormD.prodCode_S"+indSC)
		var atpqobj = eval("document.myFormD.qty_S"+indSC)	
	}
	else if(getSC=='C')
	{
		var atpfobj = eval("document.myFormD.prodCode_CO"+indSC)
		var atpqobj = eval("document.myFormD.qty_CO"+indSC)	
	}
	else if(getSC=='R')
	{
		var atpfobj = eval("document.myFormD.prodCode_C"+indSC)
		var atpqobj = eval("document.myFormD.qty_C"+indSC)
	}
	else 
	{
		var atpfobj = eval("document.myFormD.prodCode_R"+indSC)
		var atpqobj = eval("document.myFormD.qty_R"+indSC)
	}

	var atpfor = atpfobj.value;
	var atpqty = atpqobj.value;
	var atpon=document.myFormD.atpon.value;
	var stAtp=document.myFormD.stAtp.value;

	var url="../ShoppingCart/ezATPAjaxLightBoxHome.jsp";
	url=url+"?atpfor="+atpfor+"&atpon="+atpon+"&atpqty="+atpqty+"&stAtp="+stAtp;	    	

	xmlhttpSC.onreadystatechange=getOutputSC;
	xmlhttpSC.open("GET",url,true);
	xmlhttpSC.send(null);
}

function getOutputSC()
{	
	if (xmlhttpSC.readyState==4)
	{	  
		if(getSC=='S')
		{
			document.getElementById("ajaxid_S_"+getIndSC).innerHTML=xmlhttpSC.responseText;	
		}
		else if(getSC=='C')
		{
			document.getElementById("ajaxid_C_"+getIndSC).innerHTML=xmlhttpSC.responseText;	
		}
		else if(getSC=='R')
		{
			document.getElementById("ajaxid_R_"+getIndSC).innerHTML=xmlhttpSC.responseText;
		}
		else 
		{
			document.getElementById("ajaxid_CO_"+getIndSC).innerHTML=xmlhttpSC.responseText;
		}
	}
}

function GetXmlHttpObjectSC()
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
var getA
function loadScalePrice(ind,prodItm)
{
	getIndA = ind;
	getA = prodItm;
	xmlhttpA=GetXmlHttpObjectA();

	if (xmlhttpA==null)
	{
		alert ("Your browser does not support Ajax HTTP");
		return;
	}		
	if(getA=='S')
	{
		var atpfobj = eval("document.myFormD.prodCode_S"+getIndA)
		var atpqobj = eval("document.myFormD.prodDesc_S"+getIndA)	
	}
	else if(getA=='C')
	{
		 var atpfobj = eval("document.myFormD.prodCode_CO"+getIndA)
		 var atpqobj = eval("document.myFormD.prodDesc_CO"+getIndA)	
	}
	else if(getA=='R')
	{
		var atpfobj = eval("document.myFormD.prodCode_C"+getIndA)
		var atpqobj = eval("document.myFormD.prodDesc_C"+getIndA)
	}
	else 
	{
		var atpfobj = eval("document.myFormD.prodCode_R"+getIndA)
		var atpqobj = eval("document.myFormD.prodDesc_R"+getIndA)
	}	
	var atpfor = atpfobj.value;
	var atpPdesc = atpqobj.value;
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
		if(getA=='S')
		{
			document.getElementById("scaleid_S_"+getIndA).innerHTML=xmlhttpA.responseText;	
		}
		else if(getA=='C')
		{
			document.getElementById("scaleid_C_"+getIndA).innerHTML=xmlhttpA.responseText;	
		}
		else if(getA=='R')
		{
			document.getElementById("scaleid_R_"+getIndA).innerHTML=xmlhttpA.responseText;
		}
		else 
		{
			document.getElementById("scaleid_CO_"+getIndA).innerHTML=xmlhttpA.responseText;
		}
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

function addToCart()
{
	document.myFormD.action="../ShoppingCart/ezAddCartQuickEntry.jsp";
	document.myFormD.submit();
}
function addToCart_D(num,atyp)
{
	var subUser = '<%=session.getValue("IsSubUser")%>'
	addToCart_Rep(num,atyp);
}

var reqRep
var pcodeRep
function addToCart_Rep(val,atype)
{		
	reqRep=InitializeRep();
	if (reqRep==null)
	{
		alert ("Your browser does not support Ajax HTTP");
		return;
	}			

	var url
	var typJoin = atype+val

	var atpfor  = eval("document.myFormD.prodCode_"+typJoin).value;
	var atpqty  = eval("document.myFormD.qty_"+typJoin).value;
	var atpdesc = eval("document.myFormD.prodDesc_"+typJoin).value;		
	var atpprice= eval("document.myFormD.listPrice_"+typJoin).value;
	var atpupc  = eval("document.myFormD.eanUpc_"+typJoin).value;

	pcodeRep=atpfor

	url="../ShoppingCart/ezAddCartQuickEntry.jsp";
	url=url+"?atpfor="+atpfor+"&atpqty="+atpqty+"&atpdesc="+atpdesc+"&atpprice="+atpprice+"&atpupc="+atpupc;			


	if(reqRep!=null)
	{			
		reqRep.onreadystatechange = ProcessRep;
		reqRep.open("GET", url, true);
		reqRep.send(null);
	}			
}

function ProcessRep() 
{	
	if (reqRep.readyState == 4)
	{
		var resText     = reqRep.responseText;	 	        	
		if (reqRep.status == 200)
		{			
			var alertCode					
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
				alertCode='has been successfully'
				reasonCode = 'added to Cart'
				alertIcon = '<img src="../../Library/images/icon-success-message.png"/>';
				var currentC = jQuery('#cartcount').text();
				var newC =parseInt(currentC)+1;
				jQuery('#cartcount').text(newC);
			}

			new HelloBar( '<span>'+ alertIcon +' Product ' +pcodeRep+ ' '+alertCode+ ' ' +reasonCode+  '.</span><a href="../ShoppingCart/ezViewCart.jsp">Click to See Your Cart!</a>', {

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
			if(reqRep.status == 500)	 
			alert("Error in adding product(s)");
		}
	}
}

function InitializeRep()
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
<%@ include file="../../../Includes/JSPs/ShoppingCart/iCheckCartItems.jsp"%>
<%@ include file="../../../Includes/JSPs/Catalog/iProductDetails.jsp"%>
<%@ include file="../Catalog/ezATPMultiple.jsp"%>
<%
	String colProdCodeGet   = request.getParameter("colfin");
	String atpon   = request.getParameter("atpon");
	if(atpon==null || "null".equalsIgnoreCase(atpon)) atpon = cMonth_S+"/"+cDate_S+"/"+cYear;
	
	//ezc.ezcommon.EzLog4j.log("prodDetailsRetObj>>>>>>>"+prodDetailsRetObj.toEzcString() ,"I");
	String prodCode		= nullCheck(prodDetailsRetObj.getFieldValueString(0,"EZP_PRODUCT_CODE"));
	String prodDesc		= nullCheck(prodDetailsRetObj.getFieldValueString(0,"EPD_PRODUCT_DESC"));
	String prodModel	= nullCheck(prodDetailsRetObj.getFieldValueString(0,"EZP_MODEL"));
	String prodUPC		= nullCheck(prodDetailsRetObj.getFieldValueString(0,"EZP_UPC_CODE"));
	String prodBrand	= nullCheck(prodDetailsRetObj.getFieldValueString(0,"EZP_BRAND"));
	String prodWebProd	= nullCheck(prodDetailsRetObj.getFieldValueString(0,"EZP_WEB_PROD_ID"));
	String prodAlternate3	= nullCheck(prodDetailsRetObj.getFieldValueString(0,"EZP_ALTERNATE3"));
	String prodAttr		= nullCheck(prodDetailsRetObj.getFieldValueString(0,"EZP_PROD_ATTRS"));
	String infav="",bgimg="",mktgSite="",brandImgLink="";
	boolean imgBool=false;
	
	
	String siteLink="";
	
	if(!"N/A".equals(prodWebProd) && !"N/A".equals(prodBrand))  
	{
	
		ReturnObjFromRetrieve newsValMapRetObj = null;
		
		ezc.ezparam.EzcParams mainParams_NVM = new ezc.ezparam.EzcParams(false);
		EziMiscParams miscParams_NVM = new EziMiscParams();				

		miscParams_NVM.setIdenKey("MISC_SELECT"); // Mandatory 
		miscParams_NVM.setQuery("SELECT MAP_TYPE,VALUE1,VALUE2 FROM EZC_VALUE_MAPPING  WHERE MAP_TYPE = 'BRANDPRDURL'"); // NEWSVALMAP is the map_type in the table and if it is optional should pass the blank parameter

		mainParams_NVM.setLocalStore("Y");
		mainParams_NVM.setObject(miscParams_NVM);
		Session.prepareParams(mainParams_NVM);	
		try{		
			newsValMapRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParams_NVM);
		}
		catch(Exception e){out.println("Exception in Getting Data"+e);}
		
		if(newsValMapRetObj!=null && newsValMapRetObj.getRowCount()>0)
		{
			for(int i=0;i<newsValMapRetObj.getRowCount();i++)
			{
				String brandLink = newsValMapRetObj.getFieldValueString(i,"VALUE1");


				if(brandLink.equals(prodBrand))
					siteLink=newsValMapRetObj.getFieldValueString(i,"VALUE2");
				

			}
		}
		if (prodBrand.equals("DXV")){
			ezc.ezcommon.EzLog4j.log("DEBUG:::::::::: MUKESH::::ProdAlternate3 : " + siteLink + "--"+ prodAlternate3,"D");
			if (prodAlternate3.equals("") || prodAlternate3.equals("N/A")){
				
				mktgSite="http://www.dxv.com/products?query="+prodCode;
				
			}	
			else { 
				mktgSite=siteLink+""+prodAlternate3;
			}	
		} else {
			mktgSite=siteLink+""+prodWebProd;
		}
		
	}
	if(!"N/A".equals(prodBrand))
	{

		ReturnObjFromRetrieve newsValMapRetObjBRND = null;

		ezc.ezparam.EzcParams mainParams_BRND = new ezc.ezparam.EzcParams(false);
		EziMiscParams miscParams_BRND = new EziMiscParams();

		miscParams_BRND.setIdenKey("MISC_SELECT"); 

		miscParams_BRND.setQuery("SELECT MAP_TYPE,VALUE1,VALUE2 FROM EZC_VALUE_MAPPING  WHERE MAP_TYPE = 'BRANDURL'"); 
		mainParams_BRND.setLocalStore("Y");
		mainParams_BRND.setObject(miscParams_BRND);
		Session.prepareParams(mainParams_BRND);	
		try{		
			newsValMapRetObjBRND = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParams_BRND);
		}
		catch(Exception e){out.println("Exception in Getting Data"+e);}
		if(newsValMapRetObjBRND!=null && newsValMapRetObjBRND.getRowCount()>0)
		{
			for(int i=0;i<newsValMapRetObjBRND.getRowCount();i++)
			{
				String brandCode = newsValMapRetObjBRND.getFieldValueString(i,"VALUE1");


				if(brandCode.equals(prodBrand))
					brandImgLink=newsValMapRetObjBRND.getFieldValueString(i,"VALUE2");
			}
		}
	}
	
	if(favProdsAL.size()>0)
	{	
		if(favProdsAL.contains(prodCode))
			imgBool=true;			
	}
	
	ReturnObjFromRetrieve prodDetailsRetObjMDL = null;
	if(prodModel!=null && !"".equals(prodModel) && !"null".equals(prodModel))
	{
		EzcParams prodParamsMiscMDL = new EzcParams(false);
		EziMiscParams prodParamsMDL = new EziMiscParams();
				
		
		prodParamsMDL.setIdenKey("MISC_SELECT");
		String queryMDL="SELECT DISTINCT EZP_MODEL,EZP_PRODUCT_CODE,EZP_CURR_PRICE,EZP_STATUS,CASE WHEN EZP_STATUS = '11' THEN '1' WHEN EZP_STATUS = '' THEN '2' WHEN EZP_STATUS = 'ZF' THEN '3' WHEN EZP_STATUS = 'Z2' OR EZP_STATUS = 'Z3' OR EZP_STATUS = 'Z4' THEN '4' ELSE '5' END STATUS,SUBSTRING(EZP_PRODUCT_CODE,PATINDEX('%.%',EZP_PRODUCT_CODE)+1,(LEN(EZP_PRODUCT_CODE))) COLOR,VALUE2 FROM EZC_PRODUCTS,EZC_VALUE_MAPPING WHERE EZP_MODEL = '"+prodModel+"' AND PATINDEX('%.%',EZP_PRODUCT_CODE) > 0 and  map_type = 'COLORDESCR' and SUBSTRING(EZP_PRODUCT_CODE,PATINDEX('%.%',EZP_PRODUCT_CODE)+1,(LEN(EZP_PRODUCT_CODE)))=VALUE1 ORDER BY STATUS,VALUE2";
	
		prodParamsMDL.setQuery(queryMDL);
	
		prodParamsMiscMDL.setLocalStore("Y");
		prodParamsMiscMDL.setObject(prodParamsMDL);
		Session.prepareParams(prodParamsMiscMDL);	
	
		try
		{
			prodDetailsRetObjMDL = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(prodParamsMiscMDL);
		}
		catch(Exception e){}
		
	}
	int finCnt=0;
	if(prodDetailsRetObjMDL!=null && prodDetailsRetObjMDL.getRowCount()>0)
		finCnt = prodDetailsRetObjMDL.getRowCount();
		boolean finCntBool = false;
		if(finCnt<=0)
			finCntBool = true;
			
	HashMap prodLine = new HashMap();

	prodLine.put("55","ACRYLICS");
	prodLine.put("14","AMERICAST");
	prodLine.put("7A","AS ACRYLICS");
	prodLine.put("7G","AS GELCOATS");
	prodLine.put("43","AS MARBLE");
	prodLine.put("7O","AS OPTIONS");
	prodLine.put("42","AS SHOWERITE");
	prodLine.put("22","CHINAWARE");
	prodLine.put("56","CIENCIA");
	prodLine.put("5P","COMMERCIAL SANYMETAL");
	prodLine.put("48","CORIAN");
	prodLine.put("5C","CRANE ACRYLICS");
	prodLine.put("5A","CRANE CHINAWARE");
	prodLine.put("5I","CRANE ENAMEL STEEL");
	prodLine.put("5F","CRANE FAUCETS");
	prodLine.put("5K","CRANE MARBLE");
	prodLine.put("5E","CRANE PLASTICS");
	prodLine.put("5R","CRANE REPAIR PARTS");
	prodLine.put("5T","CRANE SEATS & COVERS");
	prodLine.put("WP","CRANE SEMI-FINISHED");
	prodLine.put("5G","CRANE SHOWERITE");
	prodLine.put("6K","ELJER ACC & TRIM KITS");
	prodLine.put("6C","ELJER ACRYLICS");
	prodLine.put("6G","ELJER CAST IRON");
	prodLine.put("6A","ELJER CHINAWARE");
	prodLine.put("6E","ELJER ENAMEL STEEL");
	prodLine.put("6P","ELJER MARBLE");
	prodLine.put("RM","ELJER RAW MATERIAL");
	prodLine.put("6M","ELJER REPAIR PARTS");
	prodLine.put("6I","ELJER SEATS & COVERS");
	prodLine.put("17","ENA STEEL SB-DIY");
	prodLine.put("15","ENAMEL STEEL");
	prodLine.put("44","ENDURAN");
	prodLine.put("5L","FIAT CANADA  PRODUCTS");
	prodLine.put("5N","FIAT US PRODUCTS");
	prodLine.put("32","FITTINGS");
	prodLine.put("36","FITTINGS REPAIR PARTS");
	prodLine.put("30","FURNITURE");
	prodLine.put("12","IRON");
	prodLine.put("8A","SAFETY TUBS ACRYLICS");
	prodLine.put("8G","SAFETY TUBS GELCOATS");
	prodLine.put("8O","SAFETY TUBS OPTIONS");
	prodLine.put("13","STAINLESS STEEL");
	prodLine.put("18","TANK TRIM/SM");
	prodLine.put("5M","TERRAZZO");
	prodLine.put("47","TOILET SEATS");
	prodLine.put("D1","DXV CHINAWARE");
	prodLine.put("D2","DXV FAUCETS");
	prodLine.put("D3","DXV FURNITURE");
	prodLine.put("D4","DXV TUBS");
	prodLine.put("D5","DXV SINKS(NON-CW)");
	prodLine.put("D9","DXV REPAIR PARTS");
			
					
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
	String compType  = nullCheck(prodDetailsRetObj.getFieldValueString(0,"EZP_TYPE"));
	
	String commGroup = "",compItemType = "",compBool = "N",luxury = "No",priceLine="N/A",commRes="",discStatus = "",hierCode="";
	String strCommGroup  =   (String)session.getValue("CommGroup");
	
	if(prodDetailsRetObj!=null && prodDetailsRetObj.getRowCount()>0)
	{
		for(int cg=0;cg<prodDetailsRetObj.getRowCount();cg++)
		{
			if("SAP_COMM_GROUP".equals(prodDetailsRetObj.getFieldValueString(cg,"EPA_ATTR_CODE")))
			{				
				commGroup = prodDetailsRetObj.getFieldValueString(cg,"EPA_ATTR_VALUE");					
			}
			if("ITEM_CAT_GROUP".equals(prodDetailsRetObj.getFieldValueString(cg,"EPA_ATTR_CODE")))
			{				
				compItemType = nullCheck(prodDetailsRetObj.getFieldValueString(cg,"EPA_ATTR_VALUE"));					
			}
			//if("DCH_STATUS".equals(prodDetailsRetObj.getFieldValueString(cg,"EPA_ATTR_CODE")))
			{				
				discStatus = nullCheck(prodDetailsRetObj.getFieldValueString(cg,"EZP_STATUS"));					
			}			
			if("PROD_HIERARCHY1".equals(prodDetailsRetObj.getFieldValueString(cg,"EPA_ATTR_CODE")))
			{
				luxury = prodDetailsRetObj.getFieldValueString(cg,"EPA_ATTR_VALUE");
				commRes = prodDetailsRetObj.getFieldValueString(cg,"EPA_ATTR_VALUE");
				priceLine = prodDetailsRetObj.getFieldValueString(cg,"EPA_ATTR_VALUE");
				hierCode = prodDetailsRetObj.getFieldValueString(cg,"EPA_ATTR_VALUE");
			
				if(luxury!=null && !"null".equals(luxury) && !"".equals(luxury) && luxury.length()>3)
				{														
					if("10".equals(luxury.substring(2,4)) || "20".equals(luxury.substring(2,4)))							
						luxury="Yes";
					else
						luxury="No";														
				}
				else   
				{
					luxury="No";	
				}
				if(commRes!=null && !"null".equals(commRes) && !"".equals(commRes) && commRes.length()>3)
				{														
					if("50".equals(commRes.substring(2,4)))	
					{
						commRes="Commercial";
					}
					else if("10".equals(commRes.substring(2,4)) || "20".equals(commRes.substring(2,4)) 
					|| "30".equals(commRes.substring(2,4)) || "40".equals(commRes.substring(2,4)) 
					|| "60".equals(commRes.substring(2,4)) || "95".equals(commRes.substring(2,4)))
					{
						commRes="Residential";	
					}
					else
					{
						commRes="";	
					}
				}
				else
				{
					commRes="";
				}
				if(priceLine!=null && !"null".equals(priceLine) && !"".equals(priceLine)  && priceLine.length()>1)
				{							
					priceLine = priceLine.substring(0,2);
					priceLine = (String)prodLine.get(priceLine);																							
				}
				else if(priceLine==null && "null".equals(priceLine) && "".equals(priceLine)) 
				{
					priceLine = "N/A";
				}
			}								
		}
	}

	String commGroupFlag = "";
	if(commGroup!=null && !"".equals(commGroup) && !"null".equals(commGroup) && !"QS".equals(commGroup) )
	{
		if(strCommGroup.equals(commGroup))
		{
			commGroupFlag = "Y";			
		}
		else
		{
			commGroupFlag = "N";	
		}
	}		
%>
<%@ include file="../../../Includes/JSPs/ShoppingCart/iRetailCheck.jsp"%>
<%@ include file="../../../Includes/JSPs/Catalog/iScalePrices.jsp"%>
<%
	String scaleCondTable = "<table class=\"data-table\" id=\"scaleTable\"><thead><tr><th>Price</th></tr></thead><tbody>";
	if(scaleResultRet!=null && scaleResultRet.getRowCount()>0)
	{
		for(int s=0;s<scaleResultRet.getRowCount();s++)
		{
			String condVal="0";
			try
			{
				condVal = new java.math.BigDecimal(scaleResultRet.getFieldValueString(s,"CONDVAL")).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
			}
			catch(Exception e){}
			scaleCondTable = scaleCondTable+"<tr><td>&nbsp;$&nbsp;"+condVal+"&nbsp;"+scaleResultRet.getFieldValueString(s,"LONGDESC")+"</td></tr>";
		}
	}
	scaleCondTable = scaleCondTable+"</tbody></table>"; 
%>
<body class=" catalog-product-view catalog-product-view product-pointed-antique-5-piece-place-set categorypath-flatware-sterling-flatware category-sterling-flatware">
<form method="post" name="myFormD" id="product_addtocart_form">
<div id="modal" style="border:0px solid black; background-color:white; padding:1px; font-size:10;width:40%;height:180px; text-align:center; display:none;">
	<ul>
		<li>&nbsp;</li>
		<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
		<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
	</ul>
</div>
<input type="hidden" name="prodIden">
<input type="hidden" name="categoryID" value="<%=categoryID%>">
<input type="hidden" name="categoryDesc" value="<%=categoryDesc%>">
<input type="hidden" name="prodDesc_1" value="<%=prodDesc%>">
<input type="hidden" name="prodCode_1" value="<%=webSKU%>">
<input type="hidden" name="listPrice_1" value="<%=prodPrice%>">
<input type="hidden" name="eanUpc_1" value="<%=eanUpc%>">
<input type="hidden" name="prodCode_D" value="<%=prodCode_D%>">
<input type="hidden" name="mainCatID" value="<%=mainCatID%>">
<input type="hidden" name="mainCatDesc" value="<%=mainCatDesc%>">
<input type="hidden"  id="atpfor" name="atpfor" value="<%=prodCode%>" />
<input type="hidden"  id="atpon" name="atpon" value="<%=atpon%>" />
<input type="hidden"  id="stAtp" name="stAtp" value="<%=session.getValue("shipState")%>" />
<input type="hidden" name="catTypeC" value="<%=catType_C%>">
<input type="hidden" name="catTypeE" value="<%=catType_E%>">

<div class="main-container col1-layout">
<div class="main">
<div class="breadcrumbs">
	<ul>
	<li class="home"><a href="../Misc/ezDashBoard.jsp" title="Go to Home Page">Home</a></li>
	<% if (!mainCatID.startsWith("DXV")) { %>
	<li class="category3"><span>/&nbsp;</span><a href="../Catalog/ezCatalogDisplay.jsp" title="">Products Types</a></li>
	<% }; %>
	<li class="category4"><span>/&nbsp;</span><a href="javascript:getSubCatalogList('<%=mainCatID%>','<%=mainCatDesc%>')" title=""><%=mainCatDesc%></a></li>
	<li class="category5"><span>/&nbsp;</span><a href="javascript:getProductsBC('<%=categoryID%>','<%=categoryDesc%>')" title=""><%=categoryDesc%></a></li>
	<li class="category6"><span>/&nbsp;</span><a href="#" title=""><%=prodDesc%></a></li>
	</ul>
</div>
<div class="col-main">
<div id="messages_product_view"></div>
<div class="product-view">

	<!-- TOP TABS -->

	<div class="product-essential">

		<div class="tabs-container">
		<ul id="tabs">
			<li id="item-details-tab" class="active"><a href="#contentDetail">Item Details</a></li>
	        	<li id="care-and-use-tab"><a href="#contentLinks">Downloads (<%=downCnt%>)</a></li>
<%
		if( prodDetailsRetObjREP!=null && prodDetailsRetObjREP.getRowCount()== 0)
		{
%>
	        	<li id="repair-parts-tab"><a href="#contentParts">Repair Parts (<%=repairCnt%>)</a></li>
<%
		}
%>
	        	<!--<li id="colors-finishes-tab"><a href="#contentColors">Colors/Finishes (<%=finCnt%>)</a></li>-->
	        	
<%				      
			ReturnObjFromRetrieve prodDetailsRetRelComp = null;			

			if("KI".equals(compType) || ("LUMF".equals(compItemType) || "ZERL".equals(compItemType) || "ZLMF".equals(compItemType)))
	        	{
	        	compBool="Y";
			
				EzcParams prodParamsMiscComp = new EzcParams(false);
				EziMiscParams prodParamsComp = new EziMiscParams();

				prodParamsComp.setIdenKey("MISC_SELECT");
				String queryComp="SELECT EPR_PRODUCT_CODE1,EZP_PRODUCT_CODE,EZP_TYPE,EZP_SUB_TYPE,EZP_STATUS,EZP_WEB_SKU,EZP_WEB_PROD_ID,EZP_UPC_CODE,EZP_ERP_CODE,EZP_BRAND,EZP_FAMILY,EZP_MODEL,EZP_COLOR,EZP_FINISH,EZP_SIZE,EZP_LENGTH,EZP_WIDTH,EZP_LENGTH_UOM,EZP_WEIGHT,EZP_WEIGHT_UOM,EZP_VOLUME,EZP_VOLUME_UOM,EZP_STYLE,EZP_NEW_FROM,EZP_NEW_TO,EZP_CURR_PRICE,EZP_CURR_EFF_DATE,EZP_FUTURE_PRICE,EZP_FUTURE_EFF_DATE,EZP_FEATURED,EZP_DISCONTINUED,EZP_DISCONTINUE_DATE,EZP_REPLACES_ITEM,EZP_ALTERNATE1,EZP_ALTERNATE2,EZP_ALTERNATE3,EZP_ATTR1,EZP_ATTR2,EZP_ATTR3,EZP_ATTR4,EZP_ATTR5,EZP_PROD_ATTRS, EZP_SALES_ORG,EPR_PRODUCT_CODE1,EPR_PRODUCT_CODE2,EPR_RELATION_TYPE,EPD_PRODUCT_DESC,EPD_PRODUCT_DETAILS,EPD_PRODUCT_PROP1,EPD_PRODUCT_PROP2,EPD_PRODUCT_PROP3,EPD_PRODUCT_PROP4,EPD_PRODUCT_PROP5,EPD_PRODUCT_PROP6, (select TOP 1 EZA_LINK from EZC_ASSETS,EZC_PRODUCT_ASSETS where EZA_ASSET_ID=EPA_ASSET_ID and EZP_PRODUCT_CODE=EPA_PRODUCT_CODE and EPA_IMAGE_TYPE='TN') EZA_LINK from EZC_PRODUCTS,EZC_PRODUCT_RELATIONS,EZC_PRODUCT_DESCRIPTIONS WHERE EZP_PRODUCT_CODE = EPR_PRODUCT_CODE2 AND EPR_PRODUCT_CODE2 = EPD_PRODUCT_CODE and EPR_PRODUCT_CODE1='"+prodCode+"'  AND EPD_LANG_CODE='EN' and EPR_RELATION_TYPE='SBOM' ";
				prodParamsComp.setQuery(queryComp);

				prodParamsMiscComp.setLocalStore("Y");
				prodParamsMiscComp.setObject(prodParamsComp);
				Session.prepareParams(prodParamsMiscComp);	

				try
				{
					prodDetailsRetRelComp = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(prodParamsMiscComp);
				}
				catch(Exception e){}			
%>	        	
	        	<li id="kit-combo-tab"><a href="#contentComp">Components (<%=prodDetailsRetRelComp.getRowCount()%>)</a></li> 
<%	        	}
%>
	        </ul>
		</div>

		<!-- ITEM DETAILS -->
		<div class="content" id="contentDetail">
		<div class='highlight'>
				<table>
				<tbody>
				<tr>
					<td>
								
						<pre>
						</pre>
					</td>
				</tr>
				<tr>
					
			
					<td>				
						<table>
							<tbody>
							<tr>
								<td>
									<font size='5' color='black'>&nbsp;&nbsp;<%=prodDesc%></font>
								</td>
							</tr>
							<tr>
								<td>
									<span class="grey-item">&nbsp;&nbsp;&nbsp;&nbsp;Product ID: <%=prodCode%> </span>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<span class="grey-item">UPC:<%=prodUPC%> </span>	
								</td>
								
							</tr>
							</tbody>
						</table>
					</td>
				</tr>
				</tbody>
				</table>
		</div>
		<div class="inner-detail">
		
<%			
		String favDtl = prodCode+"~~"+categoryID+"~~CNET";
				
		if(prodDetailsRetObj!=null && prodDetailsRetObj.getRowCount()>0)
		{
%>							
			<div class="no-display">
				<input type="hidden" name="product" value="1300" />
				<input type="hidden" name="related_product" id="related-products-field" value="" />
			</div>
			<div class="product-shop">

			<div class="product-name">
				
			</div>

			
			
			<div>
				
			</div>
			<div class="price-box">			
			

<%			
			String disc = "Y",discActive="";
			if("Z4".equals(discStatus) || "ZF".equals(discStatus)  || "11".equals(discStatus))
				disc = "N";
			else
				discActive="Y";
			if(mktgSite==null || "null".equals(mktgSite) || "".equals(mktgSite))
			{
				mktgSite = brandImgLink;
			}
									
%>									

<%@include file="../ShoppingCart/ezCartItemATPCheck.jsp"%>
			<div class="clearer"></div>

		<div class="input-box">
		
		<ul class="form-list">
				
		<font size=3 color='grey'><strong>OPTIONS</strong></font>
		<hr style="width:97%;height:1px;background-color: #CACACA;" />
				
		<li>			
			<p style="color:black">Brand:  <a href="<%=mktgSite%>" title='See this product on the consumer website' target="_blank">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=prodBrand%></a></p>	
			
		</li>
				
<%		if(prodDetailsRetObjMDL!=null && prodDetailsRetObjMDL.getRowCount()>1 && prodDetailsRetObjMDL.find("EZP_PRODUCT_CODE",prodCode))
		{
%>		
		<li>
		<table>
		<tr>
		<td>
		<p style="color:black">Color / Finish &nbsp;&nbsp;</p>
		</td>
		<td>
		
		<select name="colfin" id="colfin" onChange="colorChange()" style="width:300px">
		
<%			for(int cf=0;cf<prodDetailsRetObjMDL.getRowCount();cf++)
			{
				String colName 	        = prodDetailsRetObjMDL.getFieldValueString(cf,"VALUE2");
				String colProdCode 	= prodDetailsRetObjMDL.getFieldValueString(cf,"EZP_PRODUCT_CODE");
				String colProdPrice 	= eliminateDecimals(prodDetailsRetObjMDL.getFieldValueString(cf,"EZP_CURR_PRICE"));   
				String colDiscStatus 	= nullCheck(prodDetailsRetObjMDL.getFieldValueString(cf,"EZP_STATUS"));
				String statsDisp="";

				if("Z3".equals(colDiscStatus) || "Z2".equals(colDiscStatus) || "Z4".equals(colDiscStatus))
					statsDisp = " -- Discontinued";
				else if("ZM".equals(colDiscStatus))
					statsDisp = "Modification - Contact Customer Care for Ordering";
				else if("ZP".equals(colDiscStatus))
					statsDisp = "Production Hold - ordering is impermissible";
				else if("ZF".equals(colDiscStatus))
					statsDisp = " -- To Be Discontinued";
				else if("11".equals(colDiscStatus))
					statsDisp = " -- New";

				String selected_A = "selected";	
				if(colProdCode.equals(prodCode))
				{
%>		
					<option value="<%=colProdCode%>" <%=selected_A%>><Strong><%=colName%> (<%=prodDetailsRetObjMDL.getFieldValueString(cf,"COLOR")%>) -- List Price: $<%=colProdPrice%><%=statsDisp%></Strong></option>
<%				}
				else
				{
%>		
					<option value="<%=colProdCode%>"><Strong><%=colName%> (<%=prodDetailsRetObjMDL.getFieldValueString(cf,"COLOR")%>) -- List Price: $<%=colProdPrice%><%=statsDisp%></Strong></option>
<%				}
			}
%>		
		</select>
		
		</td>
		</tr>
		
		</table>
		<div id="progress" style="z-index:100;position:absolute;left:280px; top:140px; border:1px solid #EEEDE7; border-radius:7px; background-color:#EEEDE7; padding:1px; font-size:10;width:330px;height:150px; text-align:center; display:none;">
			<ul>
				<li>&nbsp;</li>
				<li><img src="../../Library/images/loading.gif" width="80" height="80" alt=""></li>
				<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
			</ul>
		</div>
<%		}
%>		
		</li>
		<li>
			<p style="color:black">Luxury  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%=luxury%></p>
		</li>
		<li>
			<p style="color:black">Product Line  &nbsp;&nbsp;&nbsp;&nbsp;<%=priceLine%></p>
		</li>
		<li>
			<p style="color:black"><%=commRes%></p>
		</li>
		</ul>	
		</div>
		
<%
		if("".equals(commGroup) || "N/A".equals(commGroup) || commGroup ==null || "null".equals(commGroup) || !cgHMRB.containsKey(commGroup))
		{
			commGroup="";
		}

		if(!"".equals(commGroup) && !"N/A".equals(commGroup) && commGroup!=null && !"null".equals(commGroup))
		{
%>
		<span class="top-price-wrapper"> 
		<span class="regular-price" id="product-price-1310">
<%			 if (commGroup.equals("CS")) 
			{
%>
				<span style="color:red">All Custom Door and Vanity Top Items should be faxed to 1-800-3279387</span>
<%
			} 
			else if (commGroup.equals("QS"))
			{ 
%>
				<span style="color:red">Quick Ship </span>
<%
			}
			else
			{
				commGroup = (String)cgHMRB.get(commGroup);
%>
				<span style="color:red"><%=commGroup%></span>
<%
			} 
%>
		</span>
		</span> 		
<%
		}
%>
		<br>
		
		<font size=3 color='grey'><strong>STATUS</strong></font>
		<hr style="width:100%;height:1px;background-color: #CACACA;" />
		
		<table>
		<tbody>
		<tr>
		<td>
		
<%			
			Hashtable custAttrsHT	= (Hashtable)session.getValue("CUSTATTRS");
			String prepShipTo	= (String)session.getValue("SHIPTO_PREP");

			boolean prdAllowed = true;
			String custAttr ="";
			try
			{
				custAttr	= (String)custAttrsHT.get(atpSOr);
				prdAllowed	= checkAttributes(prodAttr,custAttr);
			}
			catch(Exception e){}
			
			if(prdAllowed)
			{
				if("Y".equals(atpAvailC) && !"Z3".equals(discStatus) && !"Z2".equals(discStatus) && !"Z4".equals(discStatus))
				{
%>
					<span><FONT COLOR="GREEN">In Stock  </FONT>      
<%	
				}
				else if("Z3".equals(discStatus) || "Z2".equals(discStatus) || "Z4".equals(discStatus))
				{
%>
					<span><FONT COLOR="RED">Out of Stock  </FONT>
<%
				}
				else
				{
					if("11".equals(discStatus))  // Requested by Sam on 17/12/2013  subject: New Products
					{
%>
						<span><FONT COLOR="RED">TBD  </FONT> 
<%
					}
					else
					{
%>
						<span><FONT COLOR="RED">Out of Stock  </FONT>  
<%
					}
				}
			}
			else
			{
%>
				<span><FONT COLOR="RED">Not included in your Portfolio or default Ship-To Account</FONT>
<%
			}
%>
		</td>
		<td>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</td>
		<td>
<%			if("Z3".equals(discStatus) || "Z2".equals(discStatus) || "Z4".equals(discStatus))
			{	
%>													
					<p class="cat-num" style="color:red">Discontinued</p>					
<%
			}
			else if("ZM".equals(discStatus))
			{
%>
					<p class="cat-num" style="color:red">Modification - Contact Customer Care for Ordering</p>
<%
			}
			else if("ZP".equals(discStatus))
			{
%>
				<p class="cat-num" style="color:red">Production Hold - ordering is impermissible</p>
<%
			}
			else if("ZF".equals(discStatus))
			{	
%>				
					<p class="cat-num" style="color:red">To Be Discontinued</p>	
<%
			}
			else if("11".equals(discStatus))
			{
%>				
					<p class="cat-num" style="color:red">New</p>	
<%
			}							
%>

		</td>
		<td>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</td>
				
		<td>
		
		</td>
		</tr>
		</tbody>
		</table>
		
<%		if(!("Z3".equals(discStatus) || "Z2".equals(discStatus) || "ZM".equals(discStatus) || "ZP".equals(discStatus)))
		{
%>		
		<br>	
		<div class="product-collateral">
		<div class="box-collateral box-description">
		<font size=3 color='grey'><strong>PRICING</strong></font>
		<hr style="width:100%;height:1px;background-color: #CACACA;" />

<%		//if(finCntBool)
		{
%>
		<span class="top-price-wrapper"><font color='black'>List Price:</font>
		<span class="regular-price" id="product-price-1310">
			<font color='black'>$<%=eliminateDecimals(prodPrice)%></font>
		</span>
		</span>
<%	
		}
		String priceScale="0";
		String shrtDesc = "";
		if(scaleResultRet!=null && scaleResultRet.getRowCount()>0)
		{
			priceScale = scaleResultRet.getFieldValueString(scaleResultRet.getRowCount()-1,"CONDVAL");
			shrtDesc   = scaleResultRet.getFieldValueString(scaleResultRet.getRowCount()-1,"SHORTDESC");
		}
		try
		{
			priceScale = new java.math.BigDecimal(priceScale).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
		}
		catch(Exception e){}
		if(!"NA".equals(scaleResultRet.getFieldValueString(0,"PRODUCT")) && !"0.00".equals(priceScale))
		{
			if(custGroup==null || "null".equals(custGroup) || "".equals(custGroup))
				custGroup = "N/A";
%>	
			<div id="scaleTab" style="width:500px; display:none">
				<h2>Best Price for Product <%=prodCode%> is <font color='red'>$<%=priceScale%></font></h2>
				<h2><%=prodDesc%></h2>
				<br>				
				Based on Ship To: <%=sesShipCode%>
				<br>
				Ship To Location: <%=session.getValue("shipAddr2")%>
				<br>				
				<br>
				<%=scaleCondTable%>

			</div>
<%		}
		else
		{
%>
			<div id="scaleTab" style="width:500px; display:none">
			
			<h2>Best Price for Product <%=prodCode%> is not available</h2>
			
			</div>
			
<%		
		}
%>								
		<input type="hidden" name="cgchk" id="cgchk" value='<%=commGroupFlag%>' class="grid-qty-input">
		<input type="hidden" name="commgrpDesc" id="commgrpDesc" value='<%=cgHMRB.get(commGroup)%>' class="grid-qty-input">
		<input type="hidden" name="commGrp" id="commGrp" value='<%=commGroup%>' class="grid-qty-input">
		
<%		
		if("N/A".equals(discStatus))
		{
			atpAvailC = "Y";
			disc = "N";
		}
		if(("Y".equals(atpAvailC) && "N".equals(disc)))
		{
%>		
			<table>
			<tbody>

			<tr>

			<td valign="bottom">
			<br>
			<label for="qty"><font color='black'>Qty:</font></label>
			<input type="text" size=1 name="atpqty" id="atpqty" value="1" title="Qty" class="grid-qty-input" style="width:24px;height:17px;border-radius:3px;"/>
		
			<div id="ajaxidATP" style="width: 980px; height:320px; display: none; ">	
				<div align=center  style="padding-top:10px;">
					<ul>
						<li>&nbsp;</li>
						<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
						<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
					</ul>
				</div>
			</div>
			</td>
			
			<td >&nbsp;&nbsp;
			</td>
			<td>
			<br>
			<ul id="navbar1" >
			<li><a href="javascript:void()" style="border-radius:3px;"><img src="../../Library/images/actionsicon.png" style="margin-top:3px;" width='17' height='12'><span class="arrow"></span></a>

			<ul style="z-index:10000;border-radius:5px;">
			
<%			if("N".equals(disc) && (commGroupFlag.equals("") || commGroupFlag.equals("Y"))) // do we need prdAllowed check here
			{
%>			
				<li><a href="#"  onClick="javascript:addToCartFav('<%=favDtl%>','<%=prodCode%>','C')"><span>Add to Cart</span></a></li>
			
<%			}
			if("N".equals(disc) && (commGroupFlag.equals("") || commGroupFlag.equals("Y")) ) // do we need prdAllowed check here
			{
				if(!imgBool)
				{
%>
					<li><a href="#" onclick="javascript:addToCartFav('<%=favDtl%>','<%=prodCode%>','V')" >
					<span>Add to Fav.</span></a></li>
				
<%				}
				else
				{
%>
					<li><a href="#" onclick="javascript:addToCartFav('<%=favDtl%>','<%=prodCode%>','D')" >
					<span>Del. from Fav.</span></a></li>
<%				
				}				
			}
%>			
			
			<li><a class="fancybox" href="#ajaxidATP"  onClick="javascript:loadContent('1')" ><span>Current Availability</span></a></li>			
<%
			if("Y".equals(bestPrice))
			{
%>
				<li><a class="fancybox" href="#scaleTab">Best Price</a></li>
<%
			}
%>
			</ul>
			
			</li>
			</ul>
			
			</td>			
			</tr>
			</tbody>
			</table>
<%		}
		else
		{					
%>
			<table>
			<tbody>

			<tr>

			<td valign="bottom">
			<br>
			<label for="qty"><font color='black'>Qty:</font></label>
			<input type="text" size=1 name="atpqty" id="atpqty" value="1" title="Qty" class="grid-qty-input" style="width:24px;height:17px;border-radius:3px;"/>

			<div id="ajaxidATP" style="width: 980px; height:320px; display: none; ">	
				<div align=center  style="padding-top:10px;">
					<ul>
						<li>&nbsp;</li>
						<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
						<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
					</ul>
				</div>
			</div>
			</td>

			<td >&nbsp;&nbsp;
			</td>
			<td>
			<br>
			<ul id="navbar1" >
			<li><a href="javascript:void()" style="border-radius:3px;"><img src="../../Library/images/actionsicon.png" style="margin-top:3px;" width='17' height='12'><span class="arrow"></span></a>

			<ul style="z-index:10000;border-radius:5px;">

			<li><a class="fancybox" href="#ajaxidATP"  onClick="javascript:loadContent('1')" ><span>Current Availability</span></a></li>			
<%
			if("Y".equals(bestPrice))
			{
%>
				<li><a class="fancybox" href="#scaleTab">Best Price</a></li>
<%
			}
%>
			</ul>
			</li>
			</ul>
			</td>			
			</tr>
			</tbody>
			</table>
<%		
		}
%>				
		</div>
		<!--    Price added to view-->
		</div>
<%		
		}
%>

		</div>

	<div class="product-collateral">
	<div class="box-collateral box-description">
	
    <font size=3 color='grey'><strong>DETAILS</strong></font>
    <hr style="width:100%;height:1px;background-color: #CACACA;" />
    
    
<%
	if(prodDet!=null && !"null".equals(prodDet) && !"".equals(prodDet) && !"N/A".equals(prodDet))
	{
		prodDet=prodDet.replaceAll("\\*","<BR><li style=\"list-style-image:url('../../Images/greenDot.png')\"> ");
		prodDet=prodDet.replaceAll("<b>","<BR><li style=\"list-style-image:url('../../Images/greenDot.png')\"> ");
		prodDet=prodDet.replaceAll("&#8226;","<BR><li style=\"list-style-image:url('../../Images/greenDot.png')\"> ");
		prodDet=prodDet.replaceAll("Nominal Dimensions","<BR><BR>Nominal Dimensions"); 
	}
		
	if("N/A".equals(prodDet))
	{
    		prodDet = "No Details available for selected product.";
    		
    	}
    	
    	
%>
       <font color='black'><%=prodDet%></font>
         </div>
		<!--Reviews-->
		</div>
		</div>
<%			String mainSTD="",mainLarge="",mainThumb="";
			int indSTD = 0, indLarge = 0,indThumb = 0;
			if(prodDetailsRetObjDWN!=null && prodDetailsRetObjDWN.getRowCount()>0)
			{
				for(int im=0;im<prodDetailsRetObjDWN.getRowCount();im++)
				{
					String colorFinish = prodDetailsRetObjDWN.getFieldValueString(im,"COLOR");
					//if(colorFinish==null || "null".equals(colorFinish) || colorFinish.length()>3)
						colorFinish = "";
					String imageThumb = prodDetailsRetObjDWN.getFieldValueString(im,"EZA_ASSET_ID");
					if(imageThumb!=null && !"".equals(imageThumb) && !"null".equals(imageThumb))
					{
						indThumb = imageThumb.indexOf(colorFinish+"-TN");
					}
					String imageLarge = prodDetailsRetObjDWN.getFieldValueString(im,"EZA_ASSET_ID");
					if(imageLarge!=null && !"".equals(imageLarge) && !"null".equals(imageLarge))
					{
						indLarge = imageLarge.indexOf(colorFinish+"-LG");
					}
					String imageSTD = prodDetailsRetObjDWN.getFieldValueString(im,"EZA_ASSET_ID");
					if(imageSTD!=null && !"".equals(imageSTD) && !"null".equals(imageSTD))
					{
						indSTD = imageSTD.indexOf(colorFinish+"-ST");
					}

					if("TN".equals(prodDetailsRetObjDWN.getFieldValueString(im,"EPA_IMAGE_TYPE")) && indThumb!=-1)
					{
						mainThumb=nullCheck(prodDetailsRetObjDWN.getFieldValueString(im,"EZA_LINK"));
					}
					if("MAIN".equals(prodDetailsRetObjDWN.getFieldValueString(im,"EPA_IMAGE_TYPE")) && indLarge!=-1)
					{
						mainLarge=nullCheck(prodDetailsRetObjDWN.getFieldValueString(im,"EZA_LINK"));
					}
					if("MAIN".equals(prodDetailsRetObjDWN.getFieldValueString(im,"EPA_IMAGE_TYPE")) && indSTD!=-1 )
					{
						mainSTD=nullCheck(prodDetailsRetObjDWN.getFieldValueString(im,"EZA_LINK"));
					}

					if(!"".equals(mainSTD) && !"".equals(mainLarge) && !"".equals(mainThumb) )
						break;
				}
			}
			
			if("".equals(mainSTD)) 
			{
				mainSTD=noImageCheck("",prodBrand) ;//"../../Images/noimage.gif";
				mainLarge="";
				mainThumb=noImageCheck("",prodBrand) ;//"../../Images/noimage.gif";
			}
%>

<style>
.product-img-box .large{width:100%; max-width:531px; max-height:531px;}
.large { width:335px !important;}

/*set a border on the images to prevent shifting*/
 .thumb {border:2px solid white;height:60px !important; width:50px !important; margin:5px;}
 
 #gal1 {background:transparent; background: #F3F2EB; margin:20px 0 0; padding:10px; display:block; float:left; width:335px;}
 
 /*Change the colour*/
 .active img{border:2px solid #333 !important;}
 
</style>
<div class="product-img-box">
	<img class="large" id="img_01" src="<%=mainSTD%>" data-zoom-image="<%=mainLarge%>" />
		<div id="gal1">
			<a href="#" data-image="<%=mainSTD%>" data-zoom-image="<%=mainLarge%>">
				<img class="thumb" id="img_01" src="<%=mainSTD%>" />
			</a>
<%      	String mainsSTD="",mainsLarge="";
		int indsSTD = 0, indsLarge = 0;
		if(prodDetailsRetObjDWN!=null && prodDetailsRetObjDWN.getRowCount()>0)
		{
			for(int ims=0;ims<prodDetailsRetObjDWN.getRowCount();ims++)
			{
				String imagesLarge = prodDetailsRetObjDWN.getFieldValueString(ims,"EZA_ASSET_ID");
				if(imagesLarge!=null && !"".equals(imagesLarge) && !"null".equals(imagesLarge))
				{
					indsLarge = imagesLarge.indexOf("-ALLG");
				}
				String imagesSTD = prodDetailsRetObjDWN.getFieldValueString(ims,"EZA_ASSET_ID");
				if(imagesSTD!=null && !"".equals(imagesSTD) && !"null".equals(imagesSTD))
				{
					indsSTD = imagesSTD.indexOf("-ALST");
				}

				if("MAIN".equals(prodDetailsRetObjDWN.getFieldValueString(ims,"EPA_IMAGE_TYPE")) && indsLarge!=-1)
				{				
					mainsLarge=nullCheck(prodDetailsRetObjDWN.getFieldValueString(ims,"EZA_LINK"));
				}
				if("MAIN".equals(prodDetailsRetObjDWN.getFieldValueString(ims,"EPA_IMAGE_TYPE")) && indsSTD!=-1)
				{				
					mainsSTD=noImageCheck(prodDetailsRetObjDWN.getFieldValueString(ims,"EZA_LINK"),prodBrand);	
%>				
					<a href="#" data-image="<%=mainsSTD%>" data-zoom-image="<%=mainsSTD%>">
					<img class="thumb" id="img_01" src="<%=mainsSTD%>" />
					</a>
				
<%				}
							
			}
		}
%>
		</div>
<script>
  $("#img_01").elevateZoom({
  			gallery:'gal1',
  			showLens: true,
  			lensShape: "square",
  			lensSize: 600,
  			zoomWindowWidth:530, 
  			zoomWindowHeight:510, 
  			cursor: 'pointer', 
  			galleryActiveClass: 'active', 
  			imageCrossfade: true, 
  			loadingIcon: '../../Library/images/712.GIF'
  			}); 

//pass the images to Fancybox
$("#img_01").bind("click", function(e) {  
  var ez =   $('#img_01').data('elevateZoom');	
	$.fancybox(ez.getGalleryList());
  return false;
});
</script>

		 </div>
		<div class="clearer"></div>		
<%		}
		else
		{
%>		
			<h4>No Item Details Exists for selected Product. </h4>
		
<%		
		}
%>
		</div>
		</div>
		<!--END ITEM DETAILS-->
		<!--SCENE 7 PERSONALIZER-->
		<!--END SCENE 7 PERSONALIZER-->
		<div class="content" id="contentLinks">
		<div class='highlight'>
			<table>
			<tbody>
			<tr>
				<td>

					<pre>
					</pre>
				</td>
			</tr>
			<tr>


				<td>				
					<table>
						<tbody>
						<tr>
							<td>
								<font size='5' color='black'>&nbsp;&nbsp;<%=prodDesc%></font>
							</td>
						</tr>
						<tr>
							<td>
								<span class="grey-item">&nbsp;&nbsp;&nbsp;&nbsp;Product ID: <%=prodCode%> </span>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<span class="grey-item">UPC:<%=prodUPC%> </span>	
							</td>

						</tr>
						</tbody>
					</table>
				</td>
			</tr>
			</tbody>
			</table>
		</div>
		<div class="inner-contentlinks">
			<ul style="list-style-position:inside;width:200px;">
			
<%			if(prodDetailsRetObjDWNN!=null && prodDetailsRetObjDWNN.getRowCount()>0)
			{
%>			
				<h3>PDF Files:</h3><br>
<%				int dwnCnt=0;
				for(int i=0;i<prodDetailsRetObjDWNN.getRowCount();i++)
				{
						
						String linkfrmt = nullCheck(prodDetailsRetObjDWNN.getFieldValueString(i,"EZA_LINK"));
						
						if(linkfrmt.indexOf(".pdf")!=-1)
						{
							dwnCnt++;
%>				
						<li style="list-style-image:url('../../Images/pdficon.png')"><a target="_blank" href="<%=nullCheck(prodDetailsRetObjDWNN.getFieldValueString(i,"EZA_LINK"))%>" >
							<%=nullCheck(prodDetailsRetObjDWNN.getFieldValueString(i,"EPA_SCREEN_NAME"))%>
						    </a>
						</li>
<%						}					
				}
%> 	
				</ul>				
				<ul style="padding-left:90px;list-style-position:inside;width:200px;">
					
<%				int cadCnt=0;		
				for(int i=0;i<prodDetailsRetObjDWNN.getRowCount();i++)
				{
					String linkfrmt = nullCheck(prodDetailsRetObjDWNN.getFieldValueString(i,"EZA_LINK"));
					if(linkfrmt.indexOf(".pdf")==-1 && linkfrmt.indexOf(".zip")!=-1 || linkfrmt.indexOf(".dxf")!=-1 )
					{
						cadCnt++;
						if(cadCnt==1)
						{
%>				
							<h3>CAD Files:</h3><br>
<%						
						}
%>
						<li style="list-style-image:url('../../Images/winraricon.png')"><a target="_blank" href="<%=nullCheck(prodDetailsRetObjDWNN.getFieldValueString(i,"EZA_LINK"))%>" >
							<%=nullCheck(prodDetailsRetObjDWNN.getFieldValueString(i,"EPA_SCREEN_NAME"))%>
						    </a>
						</li>
<%						
					}
					if(cadCnt==20)
					{
%>						
						</ul>
						<ul style="padding-left:90px;list-style-position:inside;width:200px;">
						<h3>CAD Files:</h3><br>
<%
					}
				}
				for(int i=0;i<prodDetailsRetObjDWNN.getRowCount();i++)
				{
					
					String linkfrmt = nullCheck(prodDetailsRetObjDWNN.getFieldValueString(i,"EZA_LINK"));
					if(linkfrmt.indexOf(".pdf")==-1 && linkfrmt.indexOf(".zip")==-1 && linkfrmt.indexOf(".dxf")==-1 && linkfrmt.indexOf(".rfa")!=-1)
					{
						cadCnt++;
%>				
						<li style="list-style-image:url('../../Images/rfaIcon.gif')"><a target="_blank" href="<%=nullCheck(prodDetailsRetObjDWNN.getFieldValueString(i,"EZA_LINK"))%>" >
							<%=nullCheck(prodDetailsRetObjDWNN.getFieldValueString(i,"EPA_SCREEN_NAME"))%>
						    </a>
						</li>
<%
					}
					if(cadCnt==40)
					{
%>						
							</ul>
							<ul style="padding-left:90px;width:200px;">
							<h3>CAD Files:</h3><br>
<%						
					}
				}
			}
			else
			{
%>
				<h4>There are no downloads found.</h4>
<%			}
			
%>							
			</ul>
		</div>
		</div>
<%
		if( prodDetailsRetObjREP!=null && prodDetailsRetObjREP.getRowCount()== 0)
		{
%>

		<div class="content" id="contentParts">
		<div class='highlight'>
			<table>
			<tbody>
			<tr>
				<td>

					<pre>
					</pre>
				</td>
			</tr>
			<tr>


				<td>				
					<table>
						<tbody>
						<tr>
							<td>
								<font size='5' color='black'>&nbsp;&nbsp;<%=prodDesc%></font>
							</td>
						</tr>
						<tr>
							<td>
								<span class="grey-item">&nbsp;&nbsp;&nbsp;&nbsp;Product ID: <%=prodCode%> </span>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<span class="grey-item">UPC:<%=prodUPC%> </span>	
							</td>

						</tr>
						</tbody>
					</table>
				</td>
			</tr>
			</tbody>
			</table>
		</div>
		<div class="inner-contentParts">

		<div class="box-collateral box-related">
<%			
			if(repairCnt>0)
			{
%>			
				<table>
				<tr>
<%	
				int ri=0;
				for(int r=0;r<prodDetailsRetObjREL.getRowCount();r++)
				{
					if("R".equals(prodDetailsRetObjREL.getFieldValueString(r,"EPR_RELATION_TYPE")))
					{
						String imgRep = noImageCheck(prodDetailsRetObjREL.getFieldValueString(r,"EZP_ATTR2"),prodDetailsRetObjREL.getFieldValueString(r,"EZP_BRAND"));
						String repStat = nullCheck(prodDetailsRetObjREL.getFieldValueString(r,"EZP_STATUS"));
						if("N/A".equals(imgRep))
							imgRep="";

						if(ri%3==0 && ri!=0)
						{
%>					
							<tr>
<%
						}
	%>					
						<td>
						<div class="more-views">
						<ol class="mini-products-list" id="wishlist-sidebar">  
						<li class="item">

						<a href="javascript:getProductDetails('<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(r,"EPR_PRODUCT_CODE2"))%>')" 
						title="" class="product-image"><img src="<%=imgRep%>" width="50" height="70" alt="">
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

								<span>List Price:
								<span class="price">$<%=eliminateDecimals(nullCheck(prodDetailsRetObjREL.getFieldValueString(r,"EZP_CURR_PRICE")))%></span>                

								</span>	

							</td>
							</tr>
							<tr><td>
<%
			// 3/30/2014 - For similar products show ATP and add to cart etc ONLY if Products are allowed
			// CHECK for DXV or Exclusivity Indicator now
			Hashtable custAttrsHT	= (Hashtable)session.getValue("CUSTATTRS");
			String prepShipTo	= (String)session.getValue("SHIPTO_PREP");

			boolean prdAllowedRep = true;
			String custAttr ="";
			//ezc.ezcommon.EzLog4j.log("DEBUG:::::::::: MUKESH::::HastTable : " + custAttrsHT,"D");
			
			try
			{
				//get the sales org appropriate for product
				String atpSOrRep = prodDetailsRetObjREL.getFieldValueString(r,"EZP_SALES_ORG");
				custAttr	= (String)custAttrsHT.get(atpSOrRep); 
				String prodAttrRep = prodDetailsRetObjREL.getFieldValueString(r,"EZP_PROD_ATTRS");
				//get the prod. Attribute matrix for Product
				prdAllowedRep	= checkAttributes(prodAttrRep,custAttr);
				ezc.ezcommon.EzLog4j.log("DEBUG:::::::::: MUKESH::::Attributes being checked: Prod Master SO" + atpSOrRep + "Cust Attr" + custAttr+ "-Prod Attr-"+prodAttrRep,"D");
				
			}
			catch(Exception e){}
			
			// ENd if Exclusivity Checks
			// show add to cart div only if allowed
			
			
%>				

<%
				if(!repStat.equals("11") && prdAllowedRep) 
					{
%>
					<label class="grid-qty-label">Qty:</label>
					<input type="text"   name="qty_R<%=r%>"       id="qty_R<%=r%>" 	     value="1" class="grid-qty-input">							

					<input type="hidden" name="prodDesc_R<%=r%>"  id="prodDesc_R<%=r%>"  value="<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(r,"EPD_PRODUCT_DESC"))%>">
					<input type="hidden" name="prodCode_R<%=r%>"  id="prodCode_R<%=r%>"  value="<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(r,"EPR_PRODUCT_CODE2"))%>">
					<input type="hidden" name="listPrice_R<%=r%>" id="listPrice_R<%=r%>" value="<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(r,"EZP_CURR_PRICE"))%>">
					<input type="hidden" name="eanUpc_R<%=r%>"    id="eanUpc_R<%=r%>"    value="<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(r,"EZP_UPC_CODE"))%>">
					<input type="button" title="Add to Cart"  value="Add to Cart" class="button" onclick="javascript:addToCart_D('<%=r%>','R')"/>
<%
				}
				else if(repStat.equals("11")) {
					if ( prdAllowedRep) {
%>															
						<p class="cat-num" style="color:red">New</p>							
<%
					} else {
%>
							<p class="cat-num" style="color:red">New - Not included in your portfolio<br> or Ship-To Account</p>
<%						} 
				}
%>
				</td>
				</tbody>
				</table>
				</div>

			</li>
			</ol>
			</div>
			</td>
<%
						ri = ri+1;
						if(ri%3==0)
						{
%>					
						</tr>
					
<%
						}
					}
				}
%>
			</tr>
			</table>
<%			}
			else
			{
%>			
				<h4>There are no repair parts found.</h4>	
<%			}
%>									
			</div>
		</div>
		</div>
<%
		}
%>
		<!--<div class="content" id="contentColors">
		<div class="inner-contentColors">
		<h2>Colors/Finishes for PROD# <%=prodCode%></h2>
			
			<ul>
<%				if(prodDetailsRetObjMDL!=null && prodDetailsRetObjMDL.getRowCount()>0)
				{
					for(int i=0;i<prodDetailsRetObjMDL.getRowCount();i++)
					{
%>				
						<li><a href="javascript:getProductDetails('<%=nullCheck(prodDetailsRetObjMDL.getFieldValueString(i,"EZP_PRODUCT_CODE"))%>')" title="">
						<%=nullCheck(prodDetailsRetObjMDL.getFieldValueString(i,"VALUE2"))%></a></li>
<%					
					}
				}
				else
				{
%>				
					<h4>There are no Colors/Finishes found.</h4>
<%				
				}
%>
			</ul>
		</div>
		</div>-->
		
<%		if("Y".equals(compBool))
		{
%>		
		<div class="content" id="contentComp">
		<div class='highlight'>
			<table>
			<tbody>
			<tr>
			<td>

				<pre>
				</pre>
			</td>
			</tr>
			<tr>
			<td>				
				<table>
					<tbody>
					<tr>
						<td>
							<font size='5' color='black'>&nbsp;&nbsp;<%=prodDesc%></font>
						</td>
					</tr>
					<tr>
						<td>
							<span class="grey-item">&nbsp;&nbsp;&nbsp;&nbsp;Product ID: <%=prodCode%> </span>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<span class="grey-item">UPC:<%=prodUPC%> </span>	
						</td>

					</tr>
					</tbody>
				</table>
			</td>
			</tr>
			</tbody>
			</table>
		</div>
		<div class="inner-contentComp">
		<div class="box-collateral box-related">								
<%			
			if(prodDetailsRetRelComp!=null && prodDetailsRetRelComp.getRowCount()>0)
			{
%>			
			<table >
			<tr>
			
			
<%			for(int r=0;r<prodDetailsRetRelComp.getRowCount();r++)
			{									
%>											
			<td>
			<div class="more-views">
			<ol class="mini-products-list" id="wishlist-sidebar">  
			<li class="item">

			<a href="javascript:getProductDetails('<%=nullCheck(prodDetailsRetRelComp.getFieldValueString(r,"EPR_PRODUCT_CODE2"))%>')" 
			title="" class="product-image"><img src="<%=noImageCheck(prodDetailsRetRelComp.getFieldValueString(r,"EZA_LINK"),prodDetailsRetRelComp.getFieldValueString(r,"EZP_BRAND"))%>" width="50" height="70" alt="<%=prodDetailsRetRelComp.getFieldValueString(r,"EZP_BRAND")%>">
			</a>
				<div class="product-details">
				<table width=100%>
				<tbody>												
				<tr>
				<td>
				<h4 class="product-name">
					<a href="javascript:getProductDetails('<%=nullCheck(prodDetailsRetRelComp.getFieldValueString(r,"EPR_PRODUCT_CODE2"))%>')" title="">
					<%=nullCheck(prodDetailsRetRelComp.getFieldValueString(r,"EPD_PRODUCT_DESC"))%></a>
				</h4>
				</td>
				</tr>
				<tr><td><span class="grey-item"> PROD &#35; <%=nullCheck(prodDetailsRetRelComp.getFieldValueString(r,"EPR_PRODUCT_CODE2"))%></span></td></tr>
				<tr><td>
					<div class="price-box">
					<span class="top-price-wrapper">List Price:
					<span class="regular-price" id="product-price-1366-related">
					<span class="price">$<%=eliminateDecimals(nullCheck(prodDetailsRetRelComp.getFieldValueString(r,"EZP_CURR_PRICE")))%></span>                
					</span>
					</span>						
					</div>						
				</td></tr>
<%
			// 3/30/2014 - For BOM products show ATP and add to cart etc ONLY if Products are allowed
			// CHECK for DXV or Exclusivity Indicator now
			Hashtable custAttrsHT	= (Hashtable)session.getValue("CUSTATTRS");
			String prepShipTo	= (String)session.getValue("SHIPTO_PREP");

			boolean prdAllowedBom = true;
			String custAttr ="";
			//ezc.ezcommon.EzLog4j.log("DEBUG:::::::::: MUKESH::::HastTable : " + custAttrsHT,"D");
			
			try
			{
				//get the sales org appropriate for product
				String atpSOrBom = prodDetailsRetRelComp.getFieldValueString(r,"EZP_SALES_ORG");
				custAttr	= (String)custAttrsHT.get(atpSOrBom); 
				String prodAttrBom = prodDetailsRetRelComp.getFieldValueString(r,"EZP_PROD_ATTRS");
				//get the prod. Attribute matrix for Product
				prdAllowedBom	= checkAttributes(prodAttrBom,custAttr);
				ezc.ezcommon.EzLog4j.log("DEBUG:::::::::: MUKESH::::Attributes being checked: Prod Master SO" + atpSOrBom + "Cust Attr" + custAttr+ "-Prod Attr-"+prodAttrBom,"D");
				
			}
			catch(Exception e){}
			
			// ENd if Exclusivity Checks
			// Show Cart div only if addition to cart is allowed
			if ( prdAllowedBom) { 
%>				
				
				<tr><td><div class="grid-qty-cont">
					<label class="grid-qty-label">Qty:</label>
					<input type="text" name="qty_C<%=r%>"         id="qty_C<%=r%>" 	    value="1" class="grid-qty-input">
					<input type="hidden" name="prodDesc_C<%=r%>"  id="prodDesc_C<%=r%>"  value="<%=nullCheck(prodDetailsRetRelComp.getFieldValueString(r,"EPD_PRODUCT_DESC"))%>">
					<input type="hidden" name="prodCode_C<%=r%>"  id="prodCode_C<%=r%>"  value="<%=nullCheck(prodDetailsRetRelComp.getFieldValueString(r,"EPR_PRODUCT_CODE2"))%>">
					<input type="hidden" name="listPrice_C<%=r%>" id="listPrice_C<%=r%>" value="<%=nullCheck(prodDetailsRetRelComp.getFieldValueString(r,"EZP_CURR_PRICE"))%>">
					<input type="hidden" name="eanUpc_C<%=r%>"    id="eanUpc_C<%=r%>"    value="<%=nullCheck(prodDetailsRetRelComp.getFieldValueString(r,"EZP_UPC_CODE"))%>">
					<input type="button" title="Add to Cart"  value="Add to Cart" class="button" onclick="javascript:addToCart_D('<%=r%>','C')"/>
				</div>	</td></tr>	
<% } else {%>				
				<tr><td><span><FONT COLOR="RED">Not included in your portfolio or<br>default Ship-To Account</span></td></tr>
<% } %>
				</tbody>
				</table>
				</div>

			</li>			    
			</ol>			
			</div>			
			</td>					
<%						
			}
%>			
			</tr>
			</table>
<%			}
			else
			{
%>			
				<h4>There are no Components found.</h4>	
<%			}
%>									
				
		</div>
		</div>
		</div>
<%		}
%>		
	</div>
	<!-- END TOP TABS -->

	<!-- RELATED TABS -->
	<div class="baRelatedProducts">
	<div id="related-tabs-title">Related Items</div>

	<div class="related-tabs">
		<ul id="tabsRel">
			<li class="active"><a href="#contentRel0">Similar (<%=simiCnt%>)</a></li>
			<li ><a href="#contentRel1">Complementary (<%=compCnt%>)</a></li>
<%
	if(replaceCnt>0)
	{
%>
			<li ><a href="#contentRel2">Replacement (<%=replaceCnt%>)</a></li>
<%
	}
%>
		</ul>
	</div>
			<div class="content" id="contentRel0">
			<div class="box-collateral box-related" style="background: #FFFFFF;">
			<script type="text/javascript">//decorateGeneric($('ul.block-content li'), ['odd','even','first','last'])</script>
			<ul class="block-content additional-related">
<%			

			int adjSimiCnt = 0;
			if(simiCnt>0)
			{
			
				//log4j.log("::::SUREN:::::"+prodDetailsRetObjREL.toEzcString(),"D");
			for(int s=0;s<prodDetailsRetObjREL.getRowCount();s++)
			{
				if("SIMI".equals(prodDetailsRetObjREL.getFieldValueString(s,"EPR_RELATION_TYPE")))
				{
				adjSimiCnt++;
				String adjSimiStr = "odd";
				if(adjSimiCnt==1)
					adjSimiStr = "first odd";
				else if(adjSimiCnt%4==0)
				{
					adjSimiStr = "last even";
					adjSimiCnt = 0;
				}
				else if(adjSimiCnt%2==0)
					adjSimiStr = "even";
%>			
			
				<li class="item row-count-<%=s%> <%=adjSimiStr%>">
				<div class="item-info"> <a href="javascript:getProductDetails('<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(s,"EPR_PRODUCT_CODE2"))%>')" 
				class="product-image"><img src="<%=noImageCheck(prodDetailsRetObjREL.getFieldValueString(s,"EZP_ATTR3"),prodDetailsRetObjREL.getFieldValueString(s,"EZP_BRAND"))%>" width="192" height="215" alt="<%=prodDetailsRetObjREL.getFieldValueString(s,"EZP_BRAND")%>" title="" /></a>
				<div class="product-details">
				<h3 class="product-name">
				
				<a href="javascript:getProductDetails('<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(s,"EPR_PRODUCT_CODE2"))%>')" title="">
				<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(s,"EPD_PRODUCT_DESC"))%></a>
				</h3>

				<!--subtitle attribute-->



				<!-- SKU-->
				<p class="cat-num">SKU # <%=nullCheck(prodDetailsRetObjREL.getFieldValueString(s,"EPR_PRODUCT_CODE2"))%>
				
<%				String discChk =  nullCheck(prodDetailsRetObjREL.getFieldValueString(s,"EZP_STATUS"));
				String prodAtp =  nullCheck(prodDetailsRetObjREL.getFieldValueString(s,"EPR_PRODUCT_CODE2"));
				

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
				String atpProdAvlb   = "";
				float atpRetQtyC=0;
				String atpAvailC = "";
				
				if("DXV".equals(prodDetailsRetObjREL.getFieldValueString(s,"EZP_BRAND")))
				{
					atpProdAvlb = (String)atpMultHM.get(prodAtp);

					try{
						atpRetQtyC = Float.parseFloat(atpProdAvlb);
					}catch(Exception e){
						atpRetQtyC = 0;
					}

					if(atpRetQtyC>=1)
					{
						atpAvailC = "Y";
					}
					else
					{
						atpAvailC = "N";
					}
				}
				
				String atpAvailCC = atpAvailC;
				if("Z4".equals(discChk) || "ZF".equals(discChk) || "11".equals(discChk))
				{
					disc = "N";
				}

				if("N/A".equals(discChk))
				{
					atpAvailC  = "Y";
					disc = "N";

				}
%>
				<div class="price-box">
				<span class="top-price-wrapper">List Price:
				<span class="regular-price" id="product-price-1366-related">
				<span class="price" style="color:#000000;">$<%=eliminateDecimals(nullCheck(prodDetailsRetObjREL.getFieldValueString(s,"EZP_CURR_PRICE")))%></span>                </span>
				</span>

				</div>
				<br>
<%
			// 3/30/2014 - For similar products show ATP and add to cart etc ONLY if Products are allowed
			// CHECK for DXV or Exclusivity Indicator now
			Hashtable custAttrsHT	= (Hashtable)session.getValue("CUSTATTRS");
			String prepShipTo	= (String)session.getValue("SHIPTO_PREP");

			boolean prdAllowedSimi = true;
			String custAttr ="";
			//ezc.ezcommon.EzLog4j.log("DEBUG:::::::::: MUKESH::::HastTable : " + custAttrsHT,"D");
			
			try
			{
				//get the sales org appropriate for product
				String atpSOrSimi = prodDetailsRetObjREL.getFieldValueString(s,"EZP_SALES_ORG");
				custAttr	= (String)custAttrsHT.get(atpSOrSimi); 
				String prodAttrSimi = prodDetailsRetObjREL.getFieldValueString(s,"EZP_PROD_ATTRS");
				//get the prod. Attribute matrix for Product
				prdAllowedSimi	= checkAttributes(prodAttrSimi,custAttr);
				ezc.ezcommon.EzLog4j.log("DEBUG:::::::::: MUKESH::::Attributes being checked: Prod Master SO" + atpSOrSimi + "Cust Attr" + custAttr+ "-Prod Attr-"+prodAttrSimi,"D");
				
			}
			catch(Exception e){}
			
			// ENd if Exclusivity Checks
			// Show Cart div only if addition to cart is allowed
			if ( prdAllowedSimi) { 
%>				
				<div class="add-to-cart">
				
				<table>
				<tbody>
							
				<tr>
				
				<td>
				
				<label for="qty1366">Qty:</label>
				<input type="text" name="qty_S<%=s%>" 		id="qty_S<%=s%>" value="1" title="Qty" class="grid-qty-input" style="width:24px;height:17px;border-radius:3px;">				
				<input type="hidden" name="prodDesc_S<%=s%>" 	id="prodDesc_S<%=s%>"  value="<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(s,"EPD_PRODUCT_DESC"))%>">
				<input type="hidden" name="prodCode_S<%=s%>" 	id="prodCode_S<%=s%>"  value="<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(s,"EPR_PRODUCT_CODE2"))%>">
				<input type="hidden" name="listPrice_S<%=s%>" 	id="listPrice_S<%=s%>" value="<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(s,"EZP_CURR_PRICE"))%>">
				<input type="hidden" name="eanUpc_S<%=s%>" 	id="eanUpc_S<%=s%>"    value="<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(s,"EZP_UPC_CODE"))%>">

<%
					String favDtlS = prodDetailsRetObjREL.getFieldValueString(s,"EPR_PRODUCT_CODE2")+"~~"+categoryID+"~~CNET";
%>
				</td>
							
				<td >&nbsp;&nbsp;
				</td>
				<td style="vertical-align:middle">
				
				<div id="ajaxid_S_<%=s%>" style="width: 900px; height:250px; display: none; ">
					<div align=center  style="padding-top:10px;">
						<ul>
							<li>&nbsp;</li>
							<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
							<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
						</ul>
					</div>
				</div>
				<ul id="navbar1" >
				<li><a href="javascript:void()" style="border-radius:3px;"><img src="../../Library/images/actionsicon.png" style="margin-top:3px;" width='17' height='12'><span class="arrow"></span></a>

				<ul style="z-index:10000;border-radius:5px;">
				
				
				<%if("N".equals(disc)) //"Y".equals(atpAvailC) && 
				{%>	
					<li><a href="#"  onClick="javascript:addToCart_D('<%=s%>','S')"><span>Add to Cart</span></a></li>
					<li><a href="#"  onClick="javascript:addToCartFav('<%=favDtlS%>','<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(s,"EPR_PRODUCT_CODE2"))%>','V')"><span>Add to Fav.</span></a></li>						
				
				<%}%>
					<li><a class="fancybox" href="#ajaxid_S_<%=s%>"  onClick="javascript:loadContentSC('<%=s%>','S')" ><span>Current Availability</span></a></li>
				</ul>

				</li>
				</ul>	
				
				</td>
				<td>&nbsp;&nbsp;
				</td>
				<td>
				
<%				if("DXV".equals(prodDetailsRetObjREL.getFieldValueString(s,"EZP_BRAND")))
				{
					if("Y".equals(atpAvailCC))
					{
%>																					
						<p class="availability out-of-stock"> <span><FONT COLOR="GREEN">IN Stock</FONT> </span> </p>  

<%					}
					else
					{					
%>				
						<p class="availability out-of-stock"><span><FONT COLOR='#C11B17'>NO Stock</FONT></span></p>
<%			
					}
				}
%>			
				</td>				
				</tr>
				</tbody>
				</table>
				
				</div>
<% } else { %>
	<div><span><FONT COLOR='RED'>Not included in your portfolio or<br>default Ship-To Account</font></span></div>
<% } %>

				</div>
				</div>
				</li>
				
<%
				if(adjSimiCnt%4==0)
				{
%>
					</ul>
					<ul class="block-content additional-related">

<%				
				}
				}
			}
			}
			else
			{
%>			
				<h4>There are no Similar products found.</h4>	
<%			}
%>			
			</ul>
			</div>
			</div>
			
		<div class="content" id="contentRel1">
		<div class="box-collateral box-related" style="background: #FFFFFF;">
		<ul class="block-content additional-related">
		
<%			
			int adjCompCnt = 0;
			//ArrayList compAL = new ArrayList();
			if(compCnt>0)
			{
			for(int c=0;c<prodDetailsRetObjREL.getRowCount();c++)
			{
			
				if("COMP".equals(prodDetailsRetObjREL.getFieldValueString(c,"EPR_RELATION_TYPE")))
				{
				adjCompCnt++;
				String adjCompStr = "odd";
				if(adjCompCnt==1)
					adjCompStr = "first odd";
				else if(adjCompCnt%4==0)
				{
					adjCompStr = "last even";
					adjCompCnt = 0;
				}
				else if(adjCompCnt%2==0)
					adjCompStr = "even";
%>		
				<li class="item row-count-<%=c%> <%=adjCompStr%>" >
				<div class="item-info"> <a href="javascript:getProductDetails('<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(c,"EPR_PRODUCT_CODE2"))%>')"
				class="product-image"><img src="<%=noImageCheck(prodDetailsRetObjREL.getFieldValueString(c,"EZP_ATTR3"),prodDetailsRetObjREL.getFieldValueString(c,"EZP_BRAND"))%>" width="192" height="215" alt="<%=prodDetailsRetObjREL.getFieldValueString(c,"EZP_BRAND")%>" title="" /></a>
				<div class="product-details">
				<h3 class="product-name">	
				<a href="javascript:getProductDetails('<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(c,"EPR_PRODUCT_CODE2"))%>')" title="">
				<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(c,"EPD_PRODUCT_DESC"))%></a>
				</h3>

				<!--subtitle attribute-->

				<!-- SKU-->
				
				<p class="cat-num">SKU # <%=nullCheck(prodDetailsRetObjREL.getFieldValueString(c,"EPR_PRODUCT_CODE2"))%>
				
<%				String discChk =  nullCheck(prodDetailsRetObjREL.getFieldValueString(c,"EZP_STATUS"));
				String prodAtp =  nullCheck(prodDetailsRetObjREL.getFieldValueString(c,"EPR_PRODUCT_CODE2"));

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
				String atpProdAvlb   = "";
				float atpRetQtyC=0;
				String atpAvailC = "";
				
				if("DXV".equals(prodDetailsRetObjREL.getFieldValueString(c,"EZP_BRAND")))
				{
					atpProdAvlb = (String)atpMultHM.get(prodAtp);

					try{
						atpRetQtyC = Float.parseFloat(atpProdAvlb);
					}catch(Exception e){
						atpRetQtyC = 0;
					}

					if(atpRetQtyC>=1)
					{
						atpAvailC = "Y";
					}
					else
					{
						atpAvailC = "N";
					}
				}
				
				
				String atpAvailCC = atpAvailC;
				if("Z4".equals(discChk) || "ZF".equals(discChk) || "11".equals(discChk))
				{
					disc = "N";
				}

				if("N/A".equals(discChk))
				{
					atpAvailC  = "Y";
					disc = "N";

				}
%>				
				<div class="price-box">
				<span class="top-price-wrapper">List Price:
				<span class="regular-price" id="product-price-1299-related">
				<span class="price" style="color:#000000;">$<%=eliminateDecimals(nullCheck(prodDetailsRetObjREL.getFieldValueString(c,"EZP_CURR_PRICE")))%></span>                </span>
				</span>

				</div>
				<br>
<%
			// 3/30/2014 - For similar products show ATP and add to cart etc ONLY if Products are allowed
			// CHECK for DXV or Exclusivity Indicator now
			Hashtable custAttrsHT	= (Hashtable)session.getValue("CUSTATTRS");
			String prepShipTo	= (String)session.getValue("SHIPTO_PREP");

			boolean prdAllowedComp = true;
			String custAttr ="";
			//ezc.ezcommon.EzLog4j.log("DEBUG:::::::::: MUKESH::::HastTable : " + custAttrsHT,"D");
			
			try
			{
				//get the sales org appropriate for product
				String atpSOrComp = prodDetailsRetObjREL.getFieldValueString(c,"EZP_SALES_ORG");
				custAttr	= (String)custAttrsHT.get(atpSOrComp); 
				String prodAttrComp = prodDetailsRetObjREL.getFieldValueString(c,"EZP_PROD_ATTRS");
				//get the prod. Attribute matrix for Product
				prdAllowedComp	= checkAttributes(prodAttrComp,custAttr);
				ezc.ezcommon.EzLog4j.log("DEBUG:::::::::: MUKESH::::Attributes being checked: Prod Master SO" + atpSOrComp + "Cust Attr" + custAttr+ "-Prod Attr-"+prodAttrComp,"D");
				
			}
			catch(Exception e){}
			
			// ENd if Exclusivity Checks
			// show add to cart div only if allowed
			if ( prdAllowedComp) { 
			
%>				
				
				<div class="add-to-cart">
				
				<table>
				<tbody>

				<tr>
								
				<td>
				
				<label for="qty1299">Qty:</label>
				<input type="text" name="qty_CO<%=c%>"  	id="qty_CO<%=c%>" 	value="1" title="Qty" class="grid-qty-input" style="width:24px;height:17px;border-radius:3px;">				
				<input type="hidden" name="prodDesc_CO<%=c%>"  	id="prodDesc_CO<%=c%>"  value="<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(c,"EPD_PRODUCT_DESC"))%>">
				<input type="hidden" name="prodCode_CO<%=c%>"  	id="prodCode_CO<%=c%>"  value="<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(c,"EPR_PRODUCT_CODE2"))%>">
				<input type="hidden" name="listPrice_CO<%=c%>" 	id="listPrice_CO<%=c%>" value="<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(c,"EZP_CURR_PRICE"))%>">
				<input type="hidden" name="eanUpc_CO<%=c%>"    	id="eanUpc_CO<%=c%>"    value="<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(c,"EZP_UPC_CODE"))%>">
				
				</div>
<%
				String favDtlCO = prodDetailsRetObjREL.getFieldValueString(c,"EPR_PRODUCT_CODE2")+"~~"+categoryID+"~~CNET";
%>
			</td>
							
			<td >&nbsp;&nbsp;
			</td>
			<td style="vertical-align:middle">
			
			<div id="ajaxid_C_<%=c%>" style="width: 950px; height:280px; display: none; ">
				<div align=center  style="padding-top:10px;">
					<ul>
						<li>&nbsp;</li>
						<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
						<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
					</ul>
				</div>
			</div>
				
			<ul id="navbar1" >
			<li><a href="javascript:void()" style="border-radius:3px;"><img src="../../Library/images/actionsicon.png" style="margin-top:3px;" width='17' height='12'><span class="arrow"></span></a>
			
			<ul style="z-index:10000;border-radius:5px;">
			
<%
			if("N".equals(disc)) //"Y".equals(atpAvailC) && 
			{
%>					
				<li><a href="#"  onClick="javascript:addToCart_D('<%=c%>','CO')"><span>Add to Cart</span></a></li>
				<li><a href="#"  onClick="javascript:addToCartFav('<%=favDtlCO%>','<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(c,"EPR_PRODUCT_CODE2"))%>','V')"><span>Add to Fav.</span></a></li>
<%
			}
%>
				<li><a class="fancybox" href="#ajaxid_C_<%=c%>"  onClick="javascript:loadContentSC('<%=c%>','C')" ><span>Current Availability</span></a></li>

			</ul>
			
			</li>
			</ul>
			</td>
			<td>&nbsp;&nbsp;
			</td>
			<td>
			
<%			if("DXV".equals(prodDetailsRetObjREL.getFieldValueString(c,"EZP_BRAND")))
			{
				if("Y".equals(atpAvailCC))
				{
%>																					
					<p class="availability out-of-stock"> <span><FONT COLOR="GREEN">IN Stock</FONT> </span> </p>  

<%				}
				else
				{					
%>				
					<p class="availability out-of-stock"><span><FONT COLOR='#C11B17'>NO Stock</FONT></span></p>
<%				}
			}
%>			
			</td>			
			</tr>
			</tbody>
			</table>

				</div>
<% } 
else { %>
	<div><span><FONT COLOR='RED'>Not included in your portfolio or<br>default Ship-To Account</font></span></div>
<% } %>
				</div>
				</li>
<%
				if(adjCompCnt%4==0)
				{
%>
					</ul>
					<ul class="block-content additional-related">

<%				
				}
				}
			}
			}
			else
			{
%>			
				<h4>There are no Complementary Items found.</h4>	
<%			}
%>			
		</ul>
		</div>
		</div>

		<div class="content" id="contentRel2">
		<div class="box-collateral box-related" style="background: #FFFFFF;">
		<ul class="block-content additional-related">
		
<%			
			int adjReplCnt = 0;
			if(replaceCnt>0)
			{
			for(int c=0;c<prodDetailsRetObjREL.getRowCount();c++)
			{
			
				if("REPL".equals(prodDetailsRetObjREL.getFieldValueString(c,"EPR_RELATION_TYPE")))
				{
				adjReplCnt++;
				String adjReplStr = "odd";
				if(adjReplCnt==1)
					adjReplStr = "first odd";
				else if(adjReplCnt%4==0)
				{
					adjReplStr = "last even";
					adjReplCnt = 0;
				}
				else if(adjReplCnt%2==0)
					adjReplStr = "even";
%>		
				<li class="item row-count-<%=c%> <%=adjReplStr%>" >
				<div class="item-info"> <a href="javascript:getProductDetails('<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(c,"EPR_PRODUCT_CODE2"))%>')"
				class="product-image"><img src="<%=noImageCheck(prodDetailsRetObjREL.getFieldValueString(c,"EZP_ATTR3"),prodDetailsRetObjREL.getFieldValueString(c,"EZP_BRAND"))%>" width="192" height="215" alt="<%=prodDetailsRetObjREL.getFieldValueString(c,"EZP_BRAND")%>" title="" /></a>
				<div class="product-details">
				<h3 class="product-name">	
				<a href="javascript:getProductDetails('<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(c,"EPR_PRODUCT_CODE2"))%>')" title="">
				<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(c,"EPD_PRODUCT_DESC"))%></a>
				</h3>

				<!--subtitle attribute-->

				<!-- SKU-->
				
				<p class="cat-num">SKU # <%=nullCheck(prodDetailsRetObjREL.getFieldValueString(c,"EPR_PRODUCT_CODE2"))%>
				
<%				String discChk =  nullCheck(prodDetailsRetObjREL.getFieldValueString(c,"EZP_STATUS"));
				String prodAtp =  nullCheck(prodDetailsRetObjREL.getFieldValueString(c,"EPR_PRODUCT_CODE2"));

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
<%				
				}

				String disc = "Y";
				String atpProdAvlb   = "";
				float atpRetQtyC=0;
				String atpAvailC = "";
	
				String atpAvailCC = atpAvailC;
				if("Z4".equals(discChk) || "ZF".equals(discChk) || "11".equals(discChk))
				{
					disc = "N";
				}

				if("N/A".equals(discChk))
				{
					atpAvailC  = "Y";
					disc = "N";

				}
%>				
				<div class="price-box">
				<span class="top-price-wrapper">List Price:
				<span class="regular-price" id="product-price-1299-related">
				<span class="price" style="color:#000000;">$<%=eliminateDecimals(nullCheck(prodDetailsRetObjREL.getFieldValueString(c,"EZP_CURR_PRICE")))%></span>                </span>
				</span>

				</div>
				<br>
				
				<div class="add-to-cart">
				
				<table>
				<tbody>

				<tr>
								
				<td>
				
				<label for="qty1299">Qty:</label>
				<input type="text" name="qty_CO<%=c%>"  	id="qty_CO<%=c%>" 	value="1" title="Qty" class="grid-qty-input" style="width:24px;height:17px;border-radius:3px;">				
				<input type="hidden" name="prodDesc_CO<%=c%>"  	id="prodDesc_CO<%=c%>"  value="<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(c,"EPD_PRODUCT_DESC"))%>">
				<input type="hidden" name="prodCode_CO<%=c%>"  	id="prodCode_CO<%=c%>"  value="<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(c,"EPR_PRODUCT_CODE2"))%>">
				<input type="hidden" name="listPrice_CO<%=c%>" 	id="listPrice_CO<%=c%>" value="<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(c,"EZP_CURR_PRICE"))%>">
				<input type="hidden" name="eanUpc_CO<%=c%>"    	id="eanUpc_CO<%=c%>"    value="<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(c,"EZP_UPC_CODE"))%>">
				
				</div>
<%
				String favDtlCO = prodDetailsRetObjREL.getFieldValueString(c,"EPR_PRODUCT_CODE2")+"~~"+categoryID+"~~CNET";
%>
			</td>
							
			<td >&nbsp;&nbsp;
			</td>
			<td style="vertical-align:middle">
			
			<div id="ajaxid_C_<%=c%>" style="width: 950px; height:280px; display: none; ">
				<div align=center  style="padding-top:10px;">
					<ul>
						<li>&nbsp;</li>
						<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
						<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
					</ul>
				</div>
			</div>
			<ul id="navbar1" >
			<li><a href="javascript:void()" style="border-radius:3px;"><img src="../../Library/images/actionsicon.png" style="margin-top:3px;" width='17' height='12'><span class="arrow"></span></a>
			
			<ul style="z-index:10000;border-radius:5px;">
			
<%
			if("N".equals(disc))  //"Y".equals(atpAvailC) && 
			{
%>					
				<li><a href="#"  onClick="javascript:addToCart_D('<%=c%>','CO')"><span>Add to Cart</span></a></li>
				<li><a href="#"  onClick="javascript:addToCartFav('<%=favDtlCO%>','<%=nullCheck(prodDetailsRetObjREL.getFieldValueString(c,"EPR_PRODUCT_CODE2"))%>','V')"><span>Add to Fav.</span></a></li>
<%
			}
%>
				<li><a class="fancybox" href="#ajaxid_C_<%=c%>"  onClick="javascript:loadContentSC('<%=c%>','C')" ><span>Current Availability</span></a></li>
			</ul>
			
			</li>
			</ul>
			</td>
			<td>&nbsp;&nbsp;
			</td>
			<td>
			
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

				</div>
				</div>
				</li>
<%
				if(adjReplCnt%4==0)
				{
%>
					</ul>
					<ul class="block-content additional-related">

<%				
				}
				}
			}
			}
%>
		</ul>
		</div>
		</div>
		</div>
</div>
</div>
</div>
</div>
</form>


	<!-- END RELATED TABS -->
	<!-- === DISABLED FOR B2C LAUNCH PER BLUEPRINTS === -->
	<!-- === END DISABLED FOR B@C LAUNCH PER BLUEPRINTS === -->
	
<script language="javascript">
(function($){ 
     $.fn.extend({  
         tabify: function() {
			function getHref(el){
				hash = $(el).find('a').attr('href');
				if(hash)
					return hash.substring(0,hash.length-4);
				else
					return false;
				}
		 	function setActive(el){
				$(el).addClass('active');
				if(getHref(el))
					$(getHref(el)).show();
				else
					return false;
				$(el).siblings('li').each(function(){
					$(this).removeClass('active');
					$(getHref(this)).hide();
				});
			}
			return this.each(function() {
				var self = this;
				
				$(this).find('li a').each(function(){
					$(this).attr('href',$(this).attr('href') + '-tab');
				});
				
				function handleHash(){
					if(location.hash)
						setActive($(self).find('a[href=' + location.hash + ']').parent());
				}
				if(location.hash)
					handleHash();
				setInterval(handleHash,100);
				$(this).find('li').each(function(){
					if($(this).hasClass('active'))
						$(getHref(this)).show();
					else
						$(getHref(this)).hide();
				});
            }); 
        } 
    }); 
})(jQuery);
	jQuery(document).ready(function(jQuery){
	
	//to hide zoom on pdf download links in productdetails page
	
					var zc = $(".zoomContainer").html();
					function detachIt() {
					$(".zoomContainer").detach();
					}

					function attachIt() {
					$(zc).appendTo('body');
					}
				(
				
				function(){
				
				
				// add event listener to t
				var el = document.getElementById("item-details-tab");
				el.addEventListener("click", attachIt, false);
				
				var el1 = document.getElementById("care-and-use-tab");
				el1.addEventListener("click", detachIt, false);
				
				var el2 = document.getElementById("repair-parts-tab");
				el2.addEventListener("click", detachIt, false);
				
		})();
	
	//to hide zoom on pdf download links in productdetails page
	
		jQuery('#progress').hide();	
		
		jQuery("#colfin").change(function(){	
		var code = document.myFormD.colfin.value;
		if(code!="")
		{
			jQuery("body").hide()
			jQuery("body").fadeIn(2000);
			jQuery("#progress").show("slow");
			colorChange();    
			return false;
		}
		});

		jQuery('#tabs, #tabsRel').tabify();
		jQuery('#item-details-tab a, #care-and-use-tab a, #repair-parts-tab a, #colors-finishes-tab a,#kit-combo-tab a').click(function(){
		jQuery('.baRelatedProducts, .related-atc').show();
		jQuery('.baRelatedProducts, .related-atc').removeClass('hidden-products');
		});
	});
</script>

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
	public String noImageCheck(String str, String prodBrand)
	{
		String ret = str;

		//ezc.ezcommon.EzLog4j.log("DEBUG:::::::::: MUKESH::::Image : " + ret+ " Brand "+prodBrand,"D");
		if(ret==null || "null".equalsIgnoreCase(ret) || "".equals(ret) || "N/A".equals(ret))
		{
			if (prodBrand.equals("DXV") || prodBrand.equals("7"))
			{
				ret = "http://dxv.blob.core.windows.net/dxv-product-images/DXV_NoImage-01.jpg";
			} 
			else 
			{
				ret = "../../Images/noimage.gif";
			}	
		};	
		return ret;
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
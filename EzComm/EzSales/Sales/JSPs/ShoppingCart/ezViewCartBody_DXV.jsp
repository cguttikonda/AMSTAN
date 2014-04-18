<%@ include file="../../../Includes/JSPs/ShoppingCart/iViewToCartItems.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iMethods.jsp"%>

<style type="text/css">
a {color:#006699; text-decoration:none}
a:hover {color:#ccc; text-decoration:none}
.hidden {visibility:hidden;}

.highlight {
	height: 60px;
	width: 100%;
	background: #e9e9e9;
	background: -webkit-linear-gradient(#e9e9e9, #c0c0c0);
	background: -moz-linear-gradient(#e9e9e9, #c0c0c0);
	background: -ms-linear-gradient(#e9e9e9, #c0c0c0);
	background: -o-linear-gradient(#e9e9e9, #c0c0c0);
	background: linear-gradient(#e9e9e9, #c0c0c0);
}
</style> 

<style type="text/css" media="screen">
	@import "../../Library/Styles/demo_table_jui.css";
	@import "../../Library/Styles/jquery-ui-1.7.2.custom.css";

	/*
	 * Override styles needed due to the mix of three different CSS sources! For proper examples
	 * please see the themes quotetable in the 'Examples' section of this site
	 */
	.dataTables_info { padding-top: 0; }
	.dataTables_paginate { padding-top: 0; }
	.css_right { float: right; }
	#quotetable_wrapper .fg-toolbar { font-size: 0.8em }
	#theme_links span { float: left; padding: 2px 10px; }
	#quotetable { -webkit-box-shadow: 2px 2px 6px #666; box-shadow: 2px 2px 6px #666; border-radius: 5px; }
	#quotetable tbody {
		border-left: 1px solid #AAA;
		border-right: 1px solid #AAA;
	}
	#quotetable thead th:first-child { border-left: 1px solid #AAA; }
	#quotetable thead th:last-child { border-right: 1px solid #AAA; }
</style>
<style>
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

#maskUP {
	position:absolute;
	left:0;
	top:0;
	z-index:9000;
	background-color:#000;
	display:none;
}
#boxesUP .windowUP {
	position:absolute;
	left:0;
	top:0;
	width:980px;
	height:530px;
	display:none;
	z-index:9999;
	padding:20px;
}
#boxesUP #dialogUP {
	width:980px;
	height:542px;
	padding:10px;
	background-color:#000;
}
</style>

<script src="http://code.jquery.com/jquery-latest.js"></script>

<!-- Start of the Styles and Scripts for Hello Bar Solo -->
<link type="text/css" rel="stylesheet" href="../../../Includes/Lib/hellobar-solo/hellobar.css" />
<script type="text/javascript" src="../../../Includes/Lib/hellobar-solo/hellobar.js"></script>
<!-- End of the Styles and Scripts for Hello Bar Solo -->

<script type="text/javascript" src="../../Library/Script/LightBox.js"></script>
<script type="text/javascript" src="../../Library/Script/complete.min.js"></script>
<script type="text/javascript" src="../../Library/Script/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="../../Library/Script/TimeOut/jquery-ui-1.8.23.custom.min.js"></script>
<Script src="../../Library/Script/sisyphus.min.js"></Script>
<Script src="../../Library/Script/popup.js"></Script>

<!-- Add fancyBox -->
<link rel="stylesheet" href="../../Library/Script/jquery.fancybox.css?v=2.0.5" type="text/css" media="screen" />
<script type="text/javascript" src="../../Library/Script/jquery.fancybox.pack.js?v=2.0.5"></script>
<!-- end of fancybox -->

<script>
// Javascript originally by Patrick Griffiths and Dan Webb.
// http://htmldog.com/articles/suckerfish/dropdowns/
sfHover = function() {
	var sfEls = document.getElementById("navbar").getElementsByTagName("li");
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

function happycode()
{
	document.getElementById("atpfor").focus();
	loadAllBGATP();

	document.getElementById("precartDiv").style.display='block';
	document.getElementById("precartUDiv").style.display='block';
}

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
	/*
	 * Initialse DataTables, with no sorting on the 'details' column
	 */
	var sortColNr = 1;

	switch ($('#sort_types').val())
	{
		case "1":
			sortColNr = 11;
			break;
		case "2":
			sortColNr = 12;
			break;
		case "3":
			sortColNr = 13;
			break;
		default:
			sortColNr = 1;
	}

	var oTable = $('#quotetable').dataTable( {

		"fnDrawCallback": function ( oSettings ) {
			if ( oSettings.aiDisplay.length == 0 )
			{
				return;
			}
			var nTrs = $('#quotetable tbody tr#linedatarow');
			var iColspan = nTrs[0].getElementsByTagName('td').length;
			var sLastGroup = "";
			for ( var i=0 ; i<nTrs.length ; i++ )
			{
				var iDisplayIndex = oSettings._iDisplayStart + i;
				var sGroup = oSettings.aoData[ oSettings.aiDisplay[iDisplayIndex] ]._aData[6];
				// THIS CODE ASSUMES THAT 10th Column carries the vendor catalog which is hidden info.
				// Also column 11 has the value of points
				if ( sGroup != sLastGroup )
				{
					var nGroup = document.createElement( 'tr' );
					var nCell = document.createElement( 'td' );
					nCell.colSpan = iColspan-3;
					nCell.className = "group";
					nCell.innerHTML = sGroup;
					nGroup.appendChild( nCell );
					nTrs[i].parentNode.insertBefore( nGroup, nTrs[i] );
					sLastGroup = sGroup;
				}
			}
		} ,  	// end of fnDrawCallback

	      	"bJQueryUI": true,
		"bSort" : true,
		"bPaginate":false,
		"oLanguage": { "sSearch": "Search Cart Items" },
		"bFilter" : true,
		"bStateSave": false,
		"aoColumnDefs": [
			{ "bVisible": true,"aTargets": [ 6 ] },
			{ "bSortable": false, "aTargets": [ 0,1,2,3,4,5,6] },
			{ "bVisible": true, "aTargets": [ 7 ] },
			{ "bVisible": true, "aTargets": [ 8 ] }
		]
	});
	oTable.fnSortListener( document.getElementById('sorter'), 7 );
	oTable.fnSortListener( document.getElementById('sorter2'), 8 );

	$('.fancyframe').fancybox({
		type:'iframe',
		closeBtn:true,
		autoSize:false,
		width:1000,
		height:500,
		scrolling:'Yes'
	});
});

function addToCartFavAct()
{
	if(chkSelect())
	{
		addToCartFav('V','V','V')
	}
}

var req
var stat 
var pcode
function addToCartFav(val,prodcode,stats)
{		
	req=Initialize();
	if (req==null)
	{
		$( "#dialog-notsup" ).dialog('open');
		return;
	}

	var url
	stat=stats
	var disp

	if(stat=="C")
	{
		pcode=document.myForm.atpfor.value;
		if(pcode=="" || pcode=="Search")
	        {		   		   
			$( "#dialog-cart" ).dialog('open');
			return false;
   		}
		var pqty=document.myForm.atpqty.value;
		if(pqty<=0)
		{
			$( "#dialog-qty" ).dialog('open');
			return false;
    		}
    		var quoteLine=document.myForm.quoteLine.value;
		var quoteNo=document.myForm.quoteNo.value;

		if(quoteLine!="" && quoteNo=="")
		{
			$( "#dialog-qNo" ).dialog('open');
			return false;
		}
		if(quoteNo!="" && quoteLine=="")
		{
			$( "#dialog-qLine" ).dialog('open');
			return false;
		}

    		Popup.showModal('modal');
		disp=document.myForm.dispVipProd.value;//'NONE'
		var psku=document.myForm.prodSku.value;
		var pline=document.myForm.poLine.value;
		var quoteNo=document.myForm.quoteNo.value;
		var quoteLine=document.myForm.quoteLine.value;

		url="ezAddCartQuickEntry.jsp";
		url=url+"?atpfor="+pcode+"&atpqty="+pqty+"&dispVipProd="+disp+"&prodSku="+psku+"&poLine="+pline+"&quoteNo="+quoteNo+"&quoteLine="+quoteLine;
	}
	if(stat=="V")	
	{	
		Popup.showModal('modal');
		var chkval = val
		var catid = '<%=categoryID%>'
		var clsid = '<%=categoryID%>'
		pcode = ''

		var chkbox = document.myForm.CheckBox1.length;
		var selCartItems = '';
		if(isNaN(chkbox))
		{
			if(document.myForm.CheckBox1.checked)
			{
				selCartItems = 	document.myForm.favDtl_0.value; 
			}
		}
		else
		{
			var indx = 0;
			for(i=0;i<chkbox;i++)
			{
				var atpProd
				var atpprodqty
				if(document.myForm.CheckBox1[i].checked)
				{
					if(indx==0)
					{
						selCartItems = eval("document.myForm.favDtl_"+[i]).value;
					}
					else
					{
						selCartItems = 	selCartItems+"$$"+eval("document.myForm.favDtl_"+[i]).value;
					}
					indx++;
				}
			}
		}

		url="../Catalog/ezAddProductsFav.jsp";
		url=url+"?chkProds="+selCartItems+"&categoryID="+catid+"&classificationID="+clsid;
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
				var bool='N'
				if(resText.indexOf("NA")!=-1)
				{
					alertCode=''
					reasonCode=' is impermissible in My Cart - contact customer care for ordering'
					alertIcon = '<img src="../../Library/images/icon-error-message.png"/>';
				}
				else if(resText.indexOf("RE")!=-1)
				{
					alertCode=''
					reasonCode=' is impermissible in My Cart - contact customer care for ordering'
					alertIcon = '<img src="../../Library/images/icon-error-message.png"/>';
				}
				else if(resText.indexOf("CS")!=-1)
				{
					alertCode=''
					reasonCode=' is impermissible in My Cart - contact customer care for ordering'
					alertIcon = '<img src="../../Library/images/icon-error-message.png"/>';
				}
				else if(resText.indexOf("NM")!=-1)
				{
					alertCode='could not be added'
					reasonCode=', as Material Code does not exists in Job Quote'
					alertIcon = '<img src="../../Library/images/icon-error-message.png"/>';
				}
				else if(resText.indexOf("NQ")!=-1)
				{
					alertCode='could not be added'
					reasonCode=', as Job Quote does not belong to default Sold-To'
					alertIcon = '<img src="../../Library/images/icon-error-message.png"/>';
				}
				else if(resText.indexOf("NL")!=-1)
				{
					alertCode='could not be added'
					reasonCode=', as Material Code and Line Item of Job Quote does not match'
					alertIcon = '<img src="../../Library/images/icon-error-message.png"/>';
				}
				else if(resText.indexOf("CQ")!=-1)
				{
					alertCode='could not be added'
					reasonCode=', as Cart Qty should not greater than Open Qty of given Job Quote'
					alertIcon = '<img src="../../Library/images/icon-error-message.png"/>';
				}
				else if(resText.indexOf("EQ")!=-1)
				{
					alertCode='could not be added'
					reasonCode=', as Job Quote got expired'
					alertIcon = '<img src="../../Library/images/icon-error-message.png"/>';
				}
				else if(resText.indexOf("JR")!=-1)
				{
					alertCode=''
					reasonCode=' is Impermissible in My Cart (rejected on Job Quote)'
					alertIcon = '<img src="../../Library/images/icon-error-message.png"/>';
				}
				else if(resText.indexOf("PA")!=-1)
				{
					alertCode=''
					reasonCode=' is not included in your portfolio - Please contact ASB for further details'
					alertIcon = '<img src="../../Library/images/icon-error-message.png"/>';
				}
				else
				{
					alertCode='has been successfully added'
					reasonCode=''
					bool='Y'
					alertIcon = '<img src="../../Library/images/icon-success-message.png"/>';
					var currentC = $('#cartcount').text();
					var newC =parseInt(currentC)+1;
					$('#cartcount').text(newC);
				}

				new HelloBar( '<span>'+ alertIcon +' Product ' +pcode+ ' '+alertCode+ '  ' +reasonCode+  '.</span><!--<a href="../ShoppingCart/ezViewCart.jsp">Click to See Your Cart!</a>-->', {
					showWait: 100,
					positioning: 'sticky',
					fonts: 'Arial, Helvetica, sans-serif',
					forgetful: true,
					helloBarLogo : false,
					height : 30
				}, 1.0 );

				Popup.hide('modal');
			}
			if(stat=="V")
			{
				alertIcon = '<img src="../../Library/images/icon-success-message.png"/>';
				new HelloBar( '<span>'+ alertIcon +' Selected Products  have been successfully added to Your Favorites.</span> <a href="../Catalog/ezGetFavProdMain.jsp">Click to See Your Favorites!</a>', {
					showWait: 100,
					positioning: 'sticky',
					fonts: 'Arial, Helvetica, sans-serif',
					forgetful: true,
					helloBarLogo : false,
					height : 30
				}, 1.0 );

				Popup.hide('modal');
			}
		}
		else
		{
			if(req.status == 500)
				alert("Error in adding product(s)");
		}
		if(bool=='Y')
		{
			document.myForm.action="../ShoppingCart/ezViewCart.jsp";
			document.myForm.submit();
		}
		else
		{
			Popup.hide('modal');
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

var xmlhttpA
var getIndA
function loadScalePrice(ind)
{
	getIndA = ind;
	xmlhttpA=GetXmlHttpObjectA();
	if (xmlhttpA==null)
	{
		$( "#dialog-notsup" ).dialog('open');
		return;
	}
	var atpfobj = eval("document.myForm.matId_"+ind)
	var atpdobj = eval("document.myForm.matDesc_"+ind)

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
var bool='Y'
function chkqtyprod()
{
	var atpfor = document.myForm.atpfor.value;
	var atpqty = document.myForm.atpqty.value;

	if(atpfor=="" || atpfor == "Search")
	{
		bool='N'
		$( "#dialog-cart" ).dialog('open');
		return false;
	}

	if(atpqty<=0)
	{
		bool='N'
		$( "#dialog-qty" ).dialog('open');
		return false;
	}
	if(bool=='Y')
	{
		loadContent("N");
	}
}
var xmlhttp
var outStat
function loadContent(atpStat)
{
	outStat = atpStat;
	xmlhttp=GetXmlHttpObject();

	if (xmlhttp==null)
	{
		$( "#dialog-notsup" ).dialog('open');
		return;
	}

	var atpfor = document.myForm.atpfor.value;
	var atpqty = document.myForm.atpqty.value;
	var atpon  = document.myForm.atpon.value;
	var stAtp  = document.myForm.stAtp.value;

	if(atpStat=="N")
	{
		var url="ezATPAjaxLightBoxHome.jsp";
		url=url+"?atpfor="+atpfor+"&atpon="+atpon+"&atpqty="+atpqty+"&stAtp="+stAtp;
	}
	else if(atpStat=="A")
	{
		var url="ezATPAjaxAllOne.jsp";
		url=url+"?atpfor="+atpfor+"&atpon="+atpon+"&atpqty="+atpqty+"&stAtp="+stAtp;
	}

	xmlhttp.onreadystatechange=getOutput;
	xmlhttp.open("GET",url,true);
	xmlhttp.send(null);
}
function getOutput()
{
	if (xmlhttp.readyState==4)
	{
		if(outStat=="N")
		{
			document.getElementById("ajaxid").innerHTML=xmlhttp.responseText;
		}
		else if(outStat=="A")
		{
			document.getElementById("ajaxidAll").innerHTML=xmlhttp.responseText;
		}
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
		$(id).css('top',  winH/2-$(id).height()/2);
		$(id).css('left', winW/2-$(id).width()/2);

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

$(document).ready(function() {
	//select all the a tag with name equal to modal
	$('a[name=modalUP]').click(function(e) {
		//Cancel the link behavior
		e.preventDefault();

		//Get the A tag
		var id = $(this).attr('href');

		//Get the screen height and width
		var maskHeight = $(document).height();
		var maskWidth = $(window).width();

		//Set heigth and width to mask to fill up the whole screen
		$('#maskUP').css({'width':maskWidth,'height':maskHeight});

		//transition effect
		$('#maskUP').fadeIn(1000);
		$('#maskUP').fadeTo("slow",0.8);

		//Get the window height and width
		var winH = $(window).height();
		var winW = $(window).width();

		//Set the popup window to center
		$(id).css('top',  winH/2-$(id).height()/2);
		$(id).css('left', winW/2-$(id).width()/2);

		//transition effect
		$(id).fadeIn(2000);
	});

	//if close button is clicked
	$('.windowUP .closeUP').click(function (e) {
		//Cancel the link behavior
		e.preventDefault();
		$('#maskUP').hide();
		$('.windowUP').hide();
		document.myForm.action="ezViewCart.jsp"; 
		document.myForm.submit();
	});
});

var xmlhttpATP
function loadAllATP(atpStat)
{
	xmlhttpATP=GetXmlHttpObjectATP();

	if (xmlhttpATP==null)
	{
		$( "#dialog-notsup" ).dialog('open');
		return;
	}
	var chkbox = document.myForm.CheckBox1.length;
	chkCount=0
	if(isNaN(chkbox))
	{
		if(document.myForm.CheckBox1.checked)
		{
			chkCount++;
		}
	}
	else
	{
		for(a=0;a<chkbox;a++)
		{
			if(document.myForm.CheckBox1[a].checked)
			{
				chkCount++;
				break;
			}
		}
	}
	if(chkCount==0)
	{
		document.myForm.CheckBoxAll.checked = true;

		if(isNaN(document.myForm.CheckBox1.length))
		{
			document.myForm.CheckBox1.checked = true;
		}
		else
		{
			for(i=0;i<document.myForm.CheckBox1.length;i++)
			{
				document.myForm.CheckBox1[i].checked = true;
			}
		}
	}	

	var atpon  = document.myForm.atpon.value;
	var stAtp  = document.myForm.stAtp.value;

	var chkbox = document.myForm.CheckBox1.length;

	var selCartItems = '';
	if(isNaN(chkbox))
	{
		if(document.myForm.CheckBox1.checked)
		{
			var cartQty  = document.myForm.cartQty_0.value;
			selCartItems = 	document.myForm.allItemsATP_0.value+"¥"+cartQty;
		}
	}
	else
	{
		var indx = 0;
		for(i=0;i<chkbox;i++)
		{
			var cartQty
			var atpProd
			var atpprodqty

			if(document.myForm.CheckBox1[i].checked)
			{
				var ii = document.myForm.CheckBox1[i].value;
				if(indx==0)
				{
					cartQty  = eval("document.myForm.cartQty_"+[ii]).value;
					atpProd  = eval("document.myForm.allItemsATP_"+[ii]).value;
					selCartItems = atpProd+"¥"+cartQty;
				}
				else
				{
					cartQty  = eval("document.myForm.cartQty_"+[ii]).value;
					atpProd  = eval("document.myForm.allItemsATP_"+[ii]).value;
					atpprodqty = atpProd+"¥"+cartQty;
					selCartItems = 	selCartItems+"§"+atpprodqty;
				}
				indx++;
			}
		}
	}
	if(atpStat=="N")
	{
   		var url = "../ShoppingCart/ezATPAllAjaxLightBox.jsp?atpfor="+selCartItems+"&atpon="+atpon+"&stAtp="+stAtp;
   	}
   	else if(atpStat=="A")
   	{
   		var url = "../ShoppingCart/ezATPAjaxAll.jsp?atpfor="+selCartItems+"&atpon="+atpon+"&stAtp="+stAtp;
   	}

	xmlhttpATP.onreadystatechange=getOutputATP;
	xmlhttpATP.open("GET",url,true);
	xmlhttpATP.send(null);
}
function getOutputATP()
{
	if (xmlhttpATP.readyState==4)
	{
		document.getElementById("ajaxAllATP").innerHTML=xmlhttpATP.responseText;
		document.myForm.CheckBoxAll.checked = false;

		if(isNaN(document.myForm.CheckBox1.length))
		{
			document.myForm.CheckBox1.checked = false;
		}
		else
		{
			for(i=0;i<document.myForm.CheckBox1.length;i++)
			{
				document.myForm.CheckBox1[i].checked = false;
			}
		}
	}
}
function GetXmlHttpObjectATP()
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
//bgATP START
var xmlhttpBGATP
function loadAllBGATP()
{
	xmlhttpBGATP=GetXmlHttpObjectBGATP();

	if (xmlhttpBGATP==null)
	{
		$( "#dialog-notsup" ).dialog('open');
		return;
	}

	var atpon  = document.myForm.atpon.value;
	var stAtp  = document.myForm.stAtp.value;
	var chkbox = document.myForm.CheckBox1.length;
	var cType = document.myForm.catType_C.value;
	var uRole = document.myForm.userRole_C.value;
	var selCartItems = '';
	if(isNaN(chkbox))
	{
		var cartQty	= document.myForm.cartQty_0.value;
		var prodStat	= document.myForm.prodStat_0.value;
		var quoteRef	= document.myForm.quoteRef_0.value;

		if(prodStat=='Z2' || prodStat=='Z3' || prodStat=='11' || (prodStat=='ZM' && quoteRef=='Standard') || prodStat=='Z4' || prodStat=='01' || prodStat=='ZR' || prodStat=='ZL' || (prodStat=='ZE' && cType!='FOC') ||  prodStat=='ZD' || prodStat=='ZP')//prodStat=='ZF' || 
		{
			if(!(uRole != 'CU' && cType == 'FOC'))
			{
				selCartItems = 	document.myForm.allItemsATP_0.value+"¥"+cartQty;
			}
		}
	}
	else
	{
		var indx = 0;
		for(i=0;i<chkbox;i++)
		{
			var cartQty  = eval("document.myForm.cartQty_"+[i]).value;
			var atpProd  = eval("document.myForm.allItemsATP_"+[i]).value;
			var prodStat = eval("document.myForm.prodStat_"+[i]).value;
			var quoteRef = eval("document.myForm.quoteRef_"+[i]).value;

			if(prodStat=='Z2' || prodStat=='Z3' || prodStat=='11' || (prodStat=='ZM' && quoteRef=='Standard') || prodStat=='Z4' || prodStat=='01' || prodStat=='ZR' || prodStat=='ZL' || (prodStat=='ZE' && cType!='FOC') ||  prodStat=='ZD' || prodStat=='ZP')//prodStat=='ZF' || 
			{
				if(!(uRole != 'CU' && cType == 'FOC'))
				{
					if(indx==0)
					{
						selCartItems = atpProd+"¥"+cartQty;
					}
					else
					{
						var atpprodqty = atpProd+"¥"+cartQty;
						selCartItems = 	selCartItems+"§"+atpprodqty;
					}
					indx++;
				}
			}
		}
	}
	var url = "../ShoppingCart/ezBGATPCheck.jsp?atpfor="+selCartItems+"&atpon="+atpon+"&stAtp="+stAtp;
	xmlhttpBGATP.onreadystatechange=getOutputBGATP;
	xmlhttpBGATP.open("GET",url,true);
	xmlhttpBGATP.send(null);
}
function getOutputBGATP()
{
	if (xmlhttpBGATP.readyState==4)
	{
		var ajaxRes = xmlhttpBGATP.responseText
		var prdsLen =0;
		var selectedPrdsSplitArr = null;
		if(ajaxRes!="")
		{
			selectedPrdsSplitArr = ajaxRes.split("§");
			prdsLen = selectedPrdsSplitArr.length;
		}

		for(var i=0;i<prdsLen;i++)
		{
			var prodCode  =  selectedPrdsSplitArr[i].split("¥")[0];
			var prodQty   =  selectedPrdsSplitArr[i].split("¥")[1];

			prodCode = trim(prodCode);
			prodQty = trim(prodQty);

			var chkbox = document.myForm.CheckBox1.length;

			if(isNaN(chkbox))
			{
				var matID     = document.myForm.allItemsATP_0.value;
				var reqQty    = document.myForm.cartQty_0.value;
				var lineItem  = document.myForm.lineItem_0.value;
				var price     = document.myForm.listPrice_0.value;

				if(price=='0.00')
					document.myForm.flag_0.src = "../../Library/images/icon-flag.png";

				if(prodCode==matID) 
				{
					if(parseInt(prodQty)<parseInt(reqQty))
					{
						document.myForm.flagATP_0.value = "NOATP";
						document.myForm.flag_0.src = "../../Library/images/icon-flag.png";
					}
				}
			}
			else
			{
				for(j=0;j<chkbox;j++)
				{
					var matID  = eval("document.myForm.allItemsATP_"+[j]).value;
					var reqQty = eval("document.myForm.cartQty_"+[j]).value;
					var price  = eval("document.myForm.listPrice_"+[j]).value;

					if(price=='0.00')
						eval("document.myForm.flag_"+[j]).src = "../../Library/images/icon-flag.png";

					if(prodCode==matID)
					{
						if(parseInt(prodQty)<parseInt(reqQty))
						{
							eval("document.myForm.flagATP_"+[j]).value = "NOATP";
							eval("document.myForm.flag_"+[j]).src = "../../Library/images/icon-flag.png";
						}
					}
				}
			}
		}
	}
}
function GetXmlHttpObjectBGATP()
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

//bgATP END

function trim(str)
{
	str = str.toString();
	var begin = 0;
	var end = str.length - 1;
	while (begin <= end && str.charCodeAt(begin) < 33) { ++begin; }
	while (end > begin && str.charCodeAt(end) < 33) { --end; }
	return str.substr(begin, end - begin + 1);
}
function iframeDisplay(atpStat)
{
	var url;
	var chkbox = document.myForm.CheckBox1.length;
	chkCount=0
	if(isNaN(chkbox))
	{
		if(document.myForm.CheckBox1.checked)
		{
			chkCount++;
		}
	}
	else
	{
		for(a=0;a<chkbox;a++)
		{
			if(document.myForm.CheckBox1[a].checked)
			{
				chkCount++;
				break;
			}
		}
	}
	if(chkCount==0)
	{
		document.myForm.CheckBoxAll.checked = true;

		if(isNaN(document.myForm.CheckBox1.length))
		{
			document.myForm.CheckBox1.checked = true;
		}
		else
		{
			for(i=0;i<document.myForm.CheckBox1.length;i++)
			{
				document.myForm.CheckBox1[i].checked = true;
			}
		}
	}	

	var atpon  = document.myForm.atpon.value;
	var stAtp  = document.myForm.stAtp.value;
	var selCartItems = '';
	if(isNaN(chkbox))
	{
		if(document.myForm.CheckBox1.checked)
		{
			var cartQty  = document.myForm.cartQty_0.value;
			selCartItems = 	document.myForm.allItemsATP_0.value+"¥"+cartQty;
		}
	}
	else
	{
		var indx = 0;
		for(i=0;i<chkbox;i++)
		{
			var cartQty
			var atpProd
			var atpprodqty
			if(document.myForm.CheckBox1[i].checked)
			{
				var ii = document.myForm.CheckBox1[i].value;
				if(indx==0)
				{
					cartQty  = eval("document.myForm.cartQty_"+[ii]).value;
					atpProd  = eval("document.myForm.allItemsATP_"+[ii]).value;
					selCartItems = atpProd+"¥"+cartQty;
				}
				else
				{
					cartQty  = eval("document.myForm.cartQty_"+[ii]).value;
					atpProd  = eval("document.myForm.allItemsATP_"+[ii]).value;
					atpprodqty = atpProd+"¥"+cartQty;
					selCartItems = 	selCartItems+"§"+atpprodqty;
				}
				indx++;
			}
		}
	}

	if(atpStat=="ALLNOR")
	{
		url = "../ShoppingCart/ezATPAllAjaxLightBox.jsp?atpfor="+selCartItems+"&atpon="+atpon+"&stAtp="+stAtp;
		var iframeObj = document.getElementById("getMultiATP");
	}
	else if(atpStat=="ALLNET")
	{
		url = "../ShoppingCart/ezATPAjaxAll.jsp?atpfor="+selCartItems+"&atpon="+atpon+"&stAtp="+stAtp;
		var iframeObj = document.getElementById("getMultiTrack");
   	}

	iframeObj.href = url;
	document.myForm.CheckBoxAll.checked = false;

	if(isNaN(document.myForm.CheckBox1.length))
	{
		document.myForm.CheckBox1.checked = false;
	}
	else
	{
		for(i=0;i<document.myForm.CheckBox1.length;i++)
		{
			document.myForm.CheckBox1[i].checked = false;
		}
	}
}
function iframeDisplayUP()
{
	var url;
	url = "ezPreUploadCart.jsp";
	var iframeObj = document.getElementById("uploadIFrame");
	iframeObj.src = url;
	iframeObj.src = iframeObj.src
}
</script>

<script type="text/javascript">
$(document).ready( function() 
{		
	$(".fancybox").fancybox(
	{
		closeBtn:true	
	});

	$('#quoteNo,#quoteLine').blur(function() {
				  
	});

	$("img.lazy").lazyload({ 
	    effect : "fadeIn"
	});

$(function() {
 	
 	$( "#dialog-cart" ).dialog({
		autoOpen: false,
		resizable: true,
		height:150,
		width:400,
		modal: true,
		buttons: {
			"Ok": function() {
				$( this ).dialog( "close" ); 
			}
		}
	});
	
	$( "#dialog-qty" ).dialog({
		autoOpen: false,
		resizable: true,
		height:150,
		width:400,
		modal: true,
		buttons: {
			"Ok": function() {
				$( this ).dialog( "close" ); 
			}
		}
	});  
	
	$( "#dialog-selchk" ).dialog({
		autoOpen: false,
		resizable: true,
		height:150,
		width:400,
		modal: true,
		buttons: {
			"Ok": function() {
				$( this ).dialog( "close" ); 
			}
		}
	});
	
	$( "#dialog-quick" ).dialog({
		autoOpen: false,
		resizable: true,
		height:150,
		width:400,
		modal: true,
		buttons: {
			"Ok": function() {
				$( this ).dialog( "close" ); 
			}
		}
	});
	
	$( "#dialog-fd" ).dialog({
		autoOpen: false,
		resizable: true,
		height:150,
		width:400,
		modal: true,
		buttons: {
			"Ok": function() {
				$( this ).dialog( "close" ); 
			}
		}
	});
	
	$( "#dialog-ATP" ).dialog({
			autoOpen: false,
			resizable: true,
			height:150,
			width:400,
			modal: true,
			buttons: {
				"Ok": function() {
					$( this ).dialog( "close" ); 
				}
			}
	});
	
	$( "#dialog-notsup" ).dialog({
		autoOpen: false,
		resizable: true,
		height:150,
		width:400,
		modal: true,
		buttons: {
			"Ok": function() {
				$( this ).dialog( "close" ); 
			}
		}
	});
	
	$( "#dialog-quote" ).dialog({
			autoOpen: false,
			resizable: true,
			height:150,
			width:400,
			modal: true,
			buttons: {
				"Ok": function() {
					$( this ).dialog( "close" ); 
				}
			}
	});
	$( "#dialog-qNo" ).dialog({
			autoOpen: false,
			resizable: true,
			height:150,
			width:400,
			modal: true,
			buttons: {
				"Ok": function() {
					$( this ).dialog( "close" ); 
				}
			}
	});
	$( "#dialog-qLine" ).dialog({
			autoOpen: false,
			resizable: true,
			height:150,
			width:400,
			modal: true,
			buttons: {
				"Ok": function() {
					$( this ).dialog( "close" ); 
				}
			}
	});
	$( "#dialog-qNo-num" ).dialog({
			autoOpen: false,
			resizable: true,
			height:150,
			width:400,
			modal: true,
			buttons: {
				"Ok": function() {
					$( this ).dialog( "close" ); 
				}
			}
	});
	$( "#dialog-qLine-num" ).dialog({
			autoOpen: false,
			resizable: true,
			height:150,
			width:400,
			modal: true,
			buttons: {
				"Ok": function() {
					$( this ).dialog( "close" ); 
				}
			}
	});

	$( "#dialog-valid" ).dialog({
		autoOpen: false,
		resizable: true,
		height:150,
		width:400,
		modal: true,
		buttons: {
			"Ok": function() {
			$( this ).dialog( "close" ); 
			}
		}
	});
	
}); // end of function()


} );

function checkAll()
{
	if(document.myForm.CheckBoxAll.checked)
	{
		if(isNaN(document.myForm.CheckBox1.length))
		{
			document.myForm.CheckBox1.checked = true;
		}
		else
		{
			for(i=0;i<document.myForm.CheckBox1.length;i++)
			{
				document.myForm.CheckBox1[i].checked = true;
			}
		}
	}
	else
	{
		if(isNaN(document.myForm.CheckBox1.length))
		{
			document.myForm.CheckBox1.checked = false;
		}
		else
		{
			for(i=0;i<document.myForm.CheckBox1.length;i++)
			{
				document.myForm.CheckBox1[i].checked = false;
			}
		}
	}
}
function checkAl()
{
	document.myForm.CheckBoxAll.checked = true;
	
	if(isNaN(document.myForm.CheckBox1.length))
	{
		document.myForm.CheckBox1.checked = true;
	}
	else
	{
		for(i=0;i<document.myForm.CheckBox1.length;i++)
		{
			document.myForm.CheckBox1[i].checked = true;
		}
	}	
}

function chkSelItem(num)
{
	var chkbox = document.myForm.CheckBox1.length;
	if(isNaN(chkbox))
	{
		document.myForm.CheckBox1.checked=true;
	}
	else
	{
		for(i=0;i<chkbox;i++)
		{
			var chkVal = document.myForm.CheckBox1[i].value;
			if(num==chkVal)
			{
				document.myForm.CheckBox1[i].checked = true;
			}
		}
	}
	return true;
}

function addMoreProducts()
{
	var page = document.myForm.categoryID.value;

	if(page=="null")
		document.myForm.action="../Catalog/ezCatalogDisplay.jsp";
	else
		document.myForm.action="../Catalog/ezProductsDisplay.jsp";

	document.myForm.submit();
}
function removeItem(row)
{
	if(chkSelItem(row))
	{
		Popup.showModal('modal');
		document.myForm.lineNo.value=row;
		document.myForm.action="../ShoppingCart/ezDeleteCartItems.jsp";
		document.myForm.submit();
	}
}
function chkSelect()
{
	var chkbox = document.myForm.CheckBox1.length;
	chkCount=0
	if(isNaN(chkbox))
	{
		if(document.myForm.CheckBox1.checked)
		{
			chkCount++;
		}
	}
	else
	{
		for(a=0;a<chkbox;a++)
		{
			if(document.myForm.CheckBox1[a].checked)
			{
				chkCount++;
				break;
			}
		}
	}
	if(chkCount==0)
	{
		$( "#dialog-selchk" ).dialog('open');
		return false;
	}
	return true;
}
function chkSelectFav()
{
	var chkbox = document.myForm.CheckBox1.length;
	chkCount=0
	if(isNaN(chkbox))
	{
		if(document.myForm.CheckBox1.checked)
		{
			chkCount++;
		}
	}
	else
	{
		for(a=0;a<chkbox;a++)
		{
			if(document.myForm.CheckBox1[a].checked)
			{
				chkCount++;
				break;
			}
		}
	}
	if(chkCount==0)
	{
		return false;
	}
	return true;
}
function removeItemAll()
{
	if(chkSelect())
	{
		Popup.showModal('modal');
		document.myForm.lineNo.value=0;
		document.myForm.action="../ShoppingCart/ezDeleteCartItems.jsp";
		document.myForm.target='_self';
		document.myForm.submit();
	}

}
function updateCart()
{
	var qsCount = 0;
	var focCount = 0;
	var cartRows = document.myForm.cartRows.value;
	var processFurther = 1;
	var qty = 0;
	for (i=0; i<cartRows; i++)
	{	 
		qty = parseInt(document.getElementById("cartQty_"+i).value);

		if(qty == null || qty == '' || qty == '0')
		{
			$( "#dialog-qty" ).dialog('open');
			document.getElementById("cartQty_"+i).focus();
			return;
		}
		
		if ($('input:radio[name=dispVipProd_'+i+']:checked').val() == 'QS')
		{
			qsCount = qsCount + 1;
		}
		if ($('input:radio[id=dispVipProd_'+i+']:checked').val() == 'FOC')
		{
			focCount = focCount + 1;
		}
  	}
  	if (qsCount != cartRows && qsCount != 0)
  	{
		$( "#dialog-quick" ).dialog('open');
		processFurther = 0;
  	}
  	if (focCount != cartRows && focCount != 0)
  	{
		$( "#dialog-fd" ).dialog('open');
		processFurther = 0;
  	}
  	if (processFurther == 1) 
  	{
		Popup.showModal('modal');
		document.myForm.action="../ShoppingCart/ezUpdateCartItems.jsp";
		document.myForm.target='_self';
		document.myForm.submit();
	}
}
function prepareOrder()
{
	var chkbox = document.myForm.CheckBox1.length;
	var qty = 0;
	if(isNaN(chkbox))
	{		
		var flag  = document.myForm.flagATP_0.value;
		var price = document.myForm.listPrice_0.value;
		qty = parseInt(document.getElementById("cartQty_0").value);
		var prdDiv = document.myForm.prodDiv_0.value;

		if(prdDiv=="D1" || prdDiv=="D2" || prdDiv=="D3" || prdDiv=="D4" || prdDiv=="D5" || prdDiv=="D9")
		{
			$( "#dialog-qty" ).dialog('option','title','Item Error');
			$( "#dialog-qty" ).dialog('open').text("Please remove impermissible items from Cart");
			return;
		}

		if(qty == null || qty == '' || qty == '0')
		{
			$( "#dialog-qty" ).dialog('open');
			document.getElementById("cartQty_0").focus();
			return;
		}

		if(flag=='NOATP') 
		{
			$( "#dialog-ATP" ).dialog('open');
			return false;
		}
		if(flag=='NPA') 
		{
			$( "#dialog-ATP" ).dialog('open').text("Please remove the items from cart which are flagged as they not in your Portfolio");
			return false;
		}
		if(price=='0.00' && $('input:radio[id=dispVipProd_0]:checked').val() != 'FOC')
		{
			$( "#dialog-ATP" ).dialog('open').text("Please remove the products with List Price Zero");
			return false;
		}
	}
	else
	{	
		for(j=0;j<chkbox;j++)
		{	
			var flag  = eval("document.myForm.flagATP_"+[j]).value;
			var matATP  = eval("document.myForm.allItemsATP_"+[j]).value;
			var price = eval("document.myForm.listPrice_"+[j]).value;
			qty = parseInt(document.getElementById("cartQty_"+j).value);

			var prdDiv = eval("document.myForm.prodDiv_"+[j]).value;

			if(prdDiv=="D1" || prdDiv=="D2" || prdDiv=="D3" || prdDiv=="D4" || prdDiv=="D5" || prdDiv=="D9")
			{
				$( "#dialog-qty" ).dialog('option','title','Item Error');
				$( "#dialog-qty" ).dialog('open').text("Please remove impermissible items from Cart");
				return;
			}
			
			if(qty == null || qty == '' || qty == '0')
			{
				$( "#dialog-qty" ).dialog('open');
				document.getElementById("cartQty_"+j).focus();
				return false;
			}
			if(flag=='NOATP') 
			{
				$( "#dialog-ATP" ).dialog('open');
				return false;
			}
			if(flag=='NPA') 
			{
				$( "#dialog-ATP" ).dialog('open').text("Please remove the items from cart which are flagged as they not in your Portfolio");
				return false;
			}
			if(price=='0.00' && $('input:radio[id=dispVipProd_'+j+']:checked').val() != 'FOC')
			{
				$( "#dialog-ATP" ).dialog('open').text("Please remove the products with List Price Zero");
				return false;
			}
		}
	 }

	var qsCount = 0;
	var focCount = 0;
	var qsFauCount = 0;
	var cartRows = document.myForm.cartRows.value;
	var processFurther = 1;
	for (i=0; i<cartRows; i++)
	{
		if ($('input:radio[id=dispVipProd_'+i+']:checked').val() == 'QS') {
			qsCount = qsCount + 1;

			var pClass = eval("document.myForm.prodClass_"+[i]).value;
			var pQty = eval("document.myForm.cartQty_"+[i]).value;
			if(pClass=="LUX" || pClass=="COM") {
				qsFauCount = parseFloat(qsFauCount) + parseFloat(pQty);
			}
		}
		if ($('input:radio[id=dispVipProd_'+i+']:checked').val() == 'FOC') {
			focCount = focCount + 1;
		}
	}
  	if (qsFauCount > 10) {
  		$( "#dialog-quick" ).dialog("option", "title", "Quick Ship Faucet Program - Warning");
		$( "#dialog-quick" ).dialog('open').text(' You cannot order more than 10 PIECES under Quick Ship Faucet Program ');
		processFurther = 0;
  	}
	if (qsCount != cartRows && qsCount != 0) {
		$( "#dialog-quick" ).dialog('open');
		processFurther = 0;
  	}
  	if (focCount != cartRows && focCount != 0) {
		$( "#dialog-fd" ).dialog('open');
		processFurther = 0;
  	}

  	if (processFurther == 1) {
		Popup.showModal('modal');

		var cType = document.myForm.catType_C.value;
		var cartRows = document.myForm.cartRows.value;

		if (qsCount > 0) {
			document.myForm.catType_C.value = 'QS';
		}
		if (focCount > 0) {
			document.myForm.catType_C.value = 'FOC';
			document.myForm.action="../Sales/ezPrepareFOCOrder.jsp";
		} else {
			document.myForm.action="../Sales/ezPrepareSalesOrder.jsp";
		}
		document.myForm.target='_self';
		document.myForm.submit();
	}
}


function submitenter(myfield,e)
{
	var keycode;
	if (window.event) keycode = window.event.keyCode;
	else if (e) keycode = e.which;
	else return true;
	
	if (keycode == 13)
	{
		addToCartFav('C','C','C');
		return false;
	}
	else
	   return true;
}

function submitenterQT(evt)
{
	var charCode = (evt.which) ? evt.which : event.keyCode
	  
	  if (charCode > 31 && (charCode < 48 || charCode > 57))
	  {
	  	return false;
	  }
	  else if(charCode==13)
	  {
	  	   addToCartFav('C','C','C');
	  	   return false;
	  }
			
 	 return true;	
}
function allnumeric()  
{   
	var quoteNo = document.myForm.quoteNo;  
	var quoteLine = document.myForm.quoteLine;  
	
	var numbers = /^[0-9]+$/; 
	if(quoteNo.value!="")
	{
		if(quoteNo.value.match(numbers))  
		{  		
			return true;  
		}  
		else  
		{ 
			$( "#dialog-qNo-num" ).dialog('open');
			quoteNo.focus()
			return false;
		}  
	}
	if(quoteLine.value!="")
	{
		if(quoteLine.value.match(numbers))  
		{  		
			return true;  
		}  
		else  
		{ 
			$( "#dialog-qLine-num" ).dialog('open');
			quoteLine.focus()
			return false;
		}  
	}	
}  

function getProductDetails(code)
{
	document.myForm.prodCode_D.value=code;

	document.myForm.action="../Catalog/ezProductDetails.jsp";
	document.myForm.target="_blank";
	document.myForm.submit();
}
function getJobDetails(salesDoc,soldToCode,docStatus)
{
	document.myForm.salDoc.value=salesDoc;
	document.myForm.soldTo.value=soldToCode;
	document.myForm.docStat.value=docStatus;
	document.myForm.fromPage.value='ezViewCart.jsp';

	document.myForm.action="../Quotes/ezJobQuoteDetails.jsp";
	document.myForm.target="_blank";
	document.myForm.submit();
}
function clrtxt()
{
	if(document.myForm.atpfor.value=="Search")
	{
		document.myForm.atpfor.value="";
	}
}
function enttxt()
{
	if(document.myForm.atpfor.value=="")
	{
		document.myForm.atpfor.value="Search";
	}
}
function quoteQtyChk(num) 
{
	var cartQty  = eval("document.myForm.cartQty_"+num).value;
	var quoteQtys = eval("document.myForm.totJobQua_"+num).value;
	var quoteRef = eval("document.myForm.quoteRef_"+num).value;	
	
	if(parseFloat(cartQty)>parseFloat(quoteQtys) && quoteRef!== "Standard")
	{
		$( "#dialog-quote" ).dialog('open');
		eval("document.myForm.cartQty_"+num).value=quoteQtys;
		return false;
	}
}
function alpha(e)
{
	var keycode;
	keycode=event.keyCode?event.keyCode:event.which;
	if ((keycode >= 48 && keycode <= 57)) {
		return true;
	}
	else {
		$( "#dialog-valid" ).dialog('open');
		return false;
	}
	return true;
}
function quoteQtyChkSub(num) 
{
	var cartRows = document.myForm.cartRows.value;
	for (i=0; i<cartRows; i++)
	{
		var cartQty  = eval("document.myForm.cartQty_"+num).value;
		var quoteQty = eval("document.myForm.quoteQty_"+num).value;
		if(cartQty>quoteQty)
		{
			$( "#dialog-quote" ).dialog('open');
			eval("document.myForm.cartQty_"+num).value=quoteQty;
			return false;
		}
	}
}
function hideBtn()
{
	document.getElementById("precartDiv").innerHTML='';
	document.getElementById("precartUDiv").innerHTML='';  
	document.getElementById("updcartDiv").style.display='block';
	document.getElementById("precartDiv").style.display='none';
	document.getElementById("precartUDiv").style.display='none';  
	document.getElementById("uploadUHDiv").style.display='none';
	document.getElementById("updcartUDiv").style.display='block';
}
function downloadErr()
{
	document.myForm.action="ezDownLoadERR.jsp";
	document.myForm.target="_self";
	document.myForm.submit();
}

</script>

<!-- auto complete STARTS-->

<script type="text/javascript">
jQuery(function(){
	var atpforTxt=$("#atpfor").val();
	$("#atpfor").autocomplete("list.jsp");
});

var typewatch = function(){
	var timer = 0;
	return function(callback, ms){
	clearTimeout (timer);
	timer = setTimeout(callback, ms);
	}  
}();
</script>

<%
	String prdError = request.getParameter("prdError");
	if(prdError!=null && "ERROR".equals(prdError))
	{
%>
	<script>
		new HelloBar( '<span><img src="../../Library/images/icon-error-message.png"/> Few product(s) are impermissible in My Cart - contact customer care for ordering .</span><a href="JavaScript:downloadErr()"><font color=red>Click Here</font></a><font> to check the item(s) which are not saved to Cart.</font>', {
			showWait: 100,
			positioning: 'sticky',
			fonts: 'Arial, Helvetica, sans-serif',
			forgetful: true,
			helloBarLogo : false,
			height : 30
		}, 1.0 );
	</script>
<%
	}
%>

<style type="text/css">
.suggestionsBox {
	position: absolute;
	left: 30px;
	top: 200px;
	margin: 0px 0px 0px 0px;
	width: 550px;
	height: 200px;
	overflow:auto;
	background-color: #DCDCDC;
	-moz-border-radius: 4px;
	-webkit-border-radius: 4px;
	border: 2px solid #CCC;
	color: #000;
}
.suggestionList {
	margin: 0px;
	padding: 0px;
}
.suggestionList li {
	margin: 0px 0px 3px 0px;
	padding: 3px;
}
.suggestionList li:hover {
	background-color: #555757;
	color: #8B0000;
}

.search_img{
	background:#ffffff url(../../Library/images/btn-search.png) no-repeat right;
	text-align:left;
}
</style>

<!-- auto complete ENDS-->
<%!
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
<%	
	ezc.record.util.EzOrderedDictionary userAuth_R = Session.getUserAuth();
		
	String enteredCode = request.getParameter("enteredCode");
	String rulesApp    = request.getParameter("rulappl");
	String notAdded    = request.getParameter("notAdded");
	
	String atpon   = request.getParameter("atpon");
	if(atpon==null || "null".equalsIgnoreCase(atpon)) atpon = cMonth_S+"/"+cDate_S+"/"+cYear;
	String catType_C = "";
	try
	{
		catType_C = (String)Cart.getType(0);
	}
	catch(Exception e){}
	if (catType_C == null || catType_C.equals("null")){
		catType_C = "";
	}
	String cartName = "QUICK ADD TO CART";

	if("Q".equals(catType_C)) cartName = "My QS Cart";
	else if("FOC".equals(catType_C)) cartName = "My FOC Cart";
		
	boolean catBool=true;
	String noneStr = "",dispRead="",checkOne="CHECKED";
		
	if(catType_C.equals("C"))
	{
		noneStr = "Custom Item";
	}
	else if(catType_C.equals("Q"))
	{
		noneStr = "Quick Ship Item";
	}
	else if(catType_C.equals("FOC"))
	{
		noneStr = "Free of Charge Item";
	}
%>
<form name="myForm" method="post">
<div class="main-container col2-layout middle account-pages">
<div class="main">
<div class="col-main1 roundedCorners">
<div class="cart">
<div id="modal" style="border:0px solid black; background-color:white; padding:1px; font-size:10;width:40%;height:180px; text-align:center; display:none;">
	<ul>
		<li>&nbsp;</li>
		<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
		<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
	</ul>
</div>
<div style="display:none;">
<div id="dialog-cart" title="Product Empty">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;display:none;"></span>Please select the product.</p>
</div> 
<div id="dialog-qty" title="Item Quantity Error">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;display:none;"></span>Minimum quantity must be 1.</p>
</div>
<div id="dialog-selchk" title="Select Product">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;display:none;"></span>Please select atleast one item.</p>
</div>
<div id="dialog-quick" title="Cannot Mix Quick Ship">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;display:none;"></span>You cannot mix Quick Ship Program with Other Programs. Please fix</p>
</div>
<div id="dialog-fd" title="Cannot Mix Free Of Change Order">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;display:none;"></span>You cannot mix Free Of Change Order with Standard Order. Please fix</p>
</div>
<div id="dialog-notsup" title="Browser Does Not Support">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;display:none;"></span>Your browser does not support Ajax HTTP</p>
</div>

<div id="dialog-quote" title="Item referred from Quote">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;display:none;"></span>Item referred from Quote should not exceed the open Quantity</p>
</div>
<div id="dialog-qNo" title="Item referred from Quote">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;display:none;"></span>Job Quote Number should not be blank </p>
</div>
<div id="dialog-qLine" title="Item referred from Quote">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;display:none;"></span>Job Quote Line Number should not be blank</p>
</div>
<div id="dialog-qNo-num" title="Item referred from Quote">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;display:none;"></span>Job Quote Number should be numeric </p>
</div>
<div id="dialog-qLine-num" title="Item referred from Quote">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;display:none;"></span>Job Quote Line Number should be numeric</p>
</div>
<div id="dialog-ATP" title="Cart Validations">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;display:none;"></span>Please remove the items from cart which are flagged with <img src="../../Library/images/icon-flag.png"> as there is no availability</p>
</div>
<div id="dialog-valid" title="Alert" style="display:none">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Please enter numerics only.</p>
</div>
</div>

<input type="hidden" name="lineNo">
<input type="hidden" name="prodCode_D">
<input type="hidden" name="fromPage" value="<%=request.getParameter("fromPage")%>">
<input type="hidden" name="catType_C" value="<%=catType_C%>">
<input type="hidden" name="webOrdNo" value="<%=webOrdNo%>">
<input type="hidden" name="catBool" value="<%=catBool%>">
<input type="hidden" name="userRole_C" value="<%=userRole%>">

<input type="hidden" name="salDoc">
<input type="hidden" name="soldTo">
<input type="hidden" name="docStat">
<input type="hidden" name="fromPage" value="">

	
	<span class='mycart'><h1><%=cartName%></h1></span>		

<input type="hidden" name="categoryID" value="<%=categoryID%>">

<div class="col1-set">
<div class="info-box">
<strong>Enter Material Code and Quantity to Quickly Add to Cart/Order<br>Mixing Quick Ship Orders with Non Quick Ship will lead to Processing Delays and violation of Quick Ship Program</strong>
<%
	String visHid2 = "block";
	/*
	if((enteredCode != null) && (!enteredCode.equals("")) && !"NA".equals(notAdded))
	{
%>
		<ul class="success-msg"><li><span><%=enteredCode%> added to Cart </span></li></ul>
<%
	}
	else if("NA".equals(notAdded))
	{
%>
		<ul class="error-msg"><span><%=enteredCode%> could NOT be added to Cart </span></li></ul>
<%	
	}
	else
	{
%>
		<ul class="success-msg"><span>Name of material added last through Quick Entry </span></li></ul>
<%
	}
	*/
	
	String dispAjax = "none";
%>
</br>
</div> <!-- info-box-->
<table class="data-table " id="quickaddtable">
<colgroup>
	<col width="1">
	<col width="1">
	<col width="1">
	<col width="1">
	<col width="1">

</colgroup>
<thead>
<tr>
	<th width = "25%" class="a-center">Product (Material#)</th>
	<th width="20%">Qty [EA]<br>My SKU<br>My PO Line</th>
	<th width="20%">Job Quote<br>Job Quote Line</th>
	<th width="20%">Order</th>
	<th width="15%">More Options</th>
</tr>
</thead>
<tbody>
<tr>
	<td class="a-center" width="15%">
		<input size="25" type="text" name="atpfor" autocomplete="off" value="" id="atpfor" Style="border: 1px solid #000000;" class="input_text"/>
	</td>
	<div class="suggestionsBox" id="suggestions" style="display: none;z-index:10000;">
		<div class="suggestionList" id="autoSuggestionsList">
		</div>
	</div>
	
	<td width=10% class="a-center">
	<input name="atpqty" id="atpqty1" size="15" class="input-text-qty" value="1" maxlength="9" onKeyPress="return submitenter(this,event)" onfocus="javascript:$('#suggestions').hide();"/>
	<input name="prodSku" value="" size="15" title="" class="input-text-qty" maxlength="20" onKeyPress="return submitenter(this,event)"></input>
	<input name="poLine" value="" size="15" title="" class="input-text-qty" maxlength="20" onKeyPress="return submitenter(this,event)"></input>
	</td>
	<td width=5% class="a-center">
	<input name="quoteNo" id="quoteNo" value="" size="15" title="" class="input-text-qty" maxlength="10"  onKeyPress="return submitenterQT(event)" onblur="allnumeric()"></input>
	<input name="quoteLine" id="quoteLine" value="" size="15" title="" class="input-text-qty" maxlength="6" onKeyPress="return submitenterQT(event)" onblur="allnumeric()"></input>
	</td>
<%
	String progTypeVal = "N/A";

	if(userAuth_R.containsKey("SUBMIT_ORDER")) progTypeVal = "NONE";
	else if(userAuth_R.containsKey("DISP_ORDER")) progTypeVal = "DISP";
	else if(userAuth_R.containsKey("VIP_ORDER")) progTypeVal = "VIP";
	else if(userAuth_R.containsKey("FOC_ORDER")) progTypeVal = "FOC";
%>
	<input type="hidden" id="dispVipProd" name="dispVipProd" value="<%=progTypeVal%>">

	<div id="ajaxid" style="width: 900px; height:300px; display: none; overflow-x: hidden">
		<div align=center  style="padding-top:10px;">
		<ul>
			<li>&nbsp;</li>
			<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
			<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
		</ul>
		</div>
	</div>
	
	<div id="ajaxidAll" style="width: 1000px; height:500px; display: <%=dispAjax%>; overflow-x: hidden">
		<div align=center  style="padding-top:10px;">
		<ul>
			<li>&nbsp;</li>
			<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
			<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
		</ul>
		</div>
	</div>
	<td>
	<br>
	<button type="button" class="button" value="Add To Cart" title="Add To Cart" onclick="javascript:addToCartFav('C','C','C')">
	<span>Add To Cart</span></button>
	</td>	
	
	<td width="25%">
	<br>		
	
	<ul id="navbar" class="button" style="float:left;">
	  <li><a href="javascript:void()" style="border-radius:3px;"><img src="../../Library/images/actionsicon.png" style="margin-top:3px;" width='17' height='12'><span class="arrow"></span></a>
	    <ul style="z-index:10000;">
	      <li><a class="fancybox" href="#ajaxid" onclick="javascript:chkqtyprod()" ><span>Current Availability</span></a></li>		
<%
		if(userAuth_R.containsKey("EZC_AS_ADV_ATP") && !"3".equals(userType_A))
		{
%>
		      <li><a class="fancybox" href="#ajaxidAll" onclick="javascript:loadContent('A')" ><span>Current Availability [All]</span></a></li>	      	      
<%
		}
%>
	      <li>
	      
	      <div id='uploadUHDiv' style="display:<%=visHid2%>;float: left;">
	      		
	      		<a href="#uploadAtt" class="fancybox">
	      		
	      		<span>Import From Excel</span>
	      		</a>   
	      		
		</div>
		</li>
	    </ul>
	  </li>
	</ul>
	
	</td>
	
	<div id="uploadAtt" style="width:100%; display:none">
		<iframe  width="850px" height="450px" scrolling=no src='accord.jsp#vertabout'></iframe>
	</div>
	
	<input type="hidden"  id="fancyPop" name="fancyPop" value="" />
	<input type="hidden"  id="atpon" name="atpon" value="<%=atpon%>" />
	<input type="hidden"  id="stAtp" name="stAtp" value="<%=session.getValue("shipState")%>" />
</tr>

</tbody>
</table>
</div> <!-- col1-set -->

<div id="boxes">

<div id="dialog" class="window">
<a href="#" class="close"/><font color=white>[x] Close</font></a>


</div>
<div id="mask"></div>
</div>
	
<div class="col1-set">
<div class="info-box">
<%
	String visHid = "none";
	String visHid1 = "none";
	boolean progTypeBol_H = true;
	
	if(Cart!=null && Cart.getRowCount()>0)
	{
		int cartRows = Cart.getRowCount();
%>
<input type="hidden" name="cartRows" value="<%=cartRows%>">
<input type="hidden" name="Cart" value="<%=Cart%>">

		<br>					
		<div class='highlight'>
		<div id="cartname" style="float:left"><span class='mycart'><h1>My Cart</h1></span></div>
		<div style="display:block;float: left;padding-top:15px;padding-left:570px;">
		
		<ul id="navbar">
		<li><a href="javascript:void()" style="padding-top:7px;padding-bottom:5px;">Sort &nbsp;&nbsp;<span class="arrow"></span></a>
		<ul style="z-index:10000;">
		
			<li><a style="cursor:pointer;" id='sorter'><span>By PO Line No</span></a></li>
			<li><a style="cursor:pointer;" id='sorter2'><span>By Price Group</span></a></li>			
		</ul>
		</li>
		</ul>
				
		</div>
		
		<div id='updcartUDiv' style="display:<%=visHid%>;float: right;padding-top:15px">
		<button type="button" title="Update Cart" class="button" onClick="javascript:updateCart()"><span>Update Cart</span></button>
		</div>

		<div id='precartUDiv' style="display:<%=visHid1%>;float: right;padding-top:15px">
		<button type="button" title="Next" class="button" onclick="javascript:prepareOrder()"><span class="right-link">Next</span></button>
		</div>

		</div>	
		<br>
		<table class="data-table" id="quotetable" >
		<thead>
		<tr>
			<th class="a-center" width='12%'><input type="checkbox" name="CheckBoxAll"  onClick="checkAll()" value="">
			&nbsp;&nbsp;&nbsp;
			<ul id="navbar1" style="float:right;">
			  <li><a href="javascript:void()" style="border-radius:3px;"><img src="../../Library/images/actionsicon.png" style="margin-top:3px;" width='17' height='12'><span class="arrow"></span></a>
			    <ul>
			      <li><a href="#" onClick="javascript:removeItemAll()"><span>Delete</span></a></li>
			      <li><a class="fancyframe" id="getMultiATP" href="" onclick="javascript:iframeDisplay('ALLNOR')" ><span>Current Availability</span></a></li>
<%
			if(userAuth_R.containsKey("EZC_AS_ADV_ATP") && !"3".equals(userType_A))
			{
%>
				<li><a class="fancyframe" id="getMultiTrack" href="" onclick="javascript:iframeDisplay('ALLNET')" ><span>Current Availability [All]</span></a></li>
<%
			}
%>
			      <li><a href="javascript:addToCartFavAct()"><span>Add to Favorite</span></a></li>
			    </ul>
			  </li>
			</ul>
			
			</th>
			<th class="a-center" width='17%'>Image<br>Brand</th>
			<th width='30%'>Product Information</th>
			<th width='18%'>Qty [EA]<br>My SKU<br>My PO Line Ref.</th>
<%
		if(catBool)
		{
%>
			<th width='10%'>PO Programs</th>
<%
		}
%>
			<th width='10%'>List Price: LP [USD]
<%
		if("Y".equals(bestPrice))
		{
%>
			<br>Best Price: BP [USD] 
<%
		}
%>
			</th>
			<th width='0px' class="hidden"></th>
			<th width="0px" class="hidden"></th>
			<th width="0px" class="hidden"></th>
			
			<div id="ajaxAllATP" style="width:1000px;height:500px;display:none;overflow-x: hidden">
				<div align=center  style="padding-top:100px;">
					<ul>
						<li>&nbsp;</li>
						<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
						<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
					</ul>
				</div>
			</div>
										
		</tr>
		</thead>
		<tbody>
<%
		java.math.BigDecimal bGTotal_S = new java.math.BigDecimal("0");
		java.util.HashMap totPointsCatHM = new java.util.HashMap();

		for(int i=0;i<cartRows;i++)
		{
			java.math.BigDecimal totItemPointsBD = new java.math.BigDecimal("0");

			String catalog_S = (String)Cart.getVendorCatalog(i);
			String itemPoints_S = (String)Cart.getPoints(i);
			
			if(itemPoints_S==null || "null".equals(itemPoints_S) || "".equals(itemPoints_S) || "N/A".equals(itemPoints_S))
				itemPoints_S = "0";

			if(totPointsCatHM.containsKey(catalog_S))
				totItemPointsBD = new java.math.BigDecimal((String)totPointsCatHM.get(catalog_S));

			totItemPointsBD = totItemPointsBD.add(new java.math.BigDecimal(itemPoints_S));

			totPointsCatHM.put(catalog_S,totItemPointsBD.toString());
		}

		Map sortedMap = new TreeMap(totPointsCatHM);

		Set catCol = sortedMap.entrySet();
		Iterator catColIte = catCol.iterator();

		Hashtable custAttrsHT	= (Hashtable)session.getValue("CUSTATTRS");
		String prepShipTo	= (String)session.getValue("SHIPTO_PREP");

		Hashtable custmrAttrHT	= null;
		if(prepShipTo!=null && !"".equals(prepShipTo) && !"null".equals(prepShipTo))
			custmrAttrHT	= getCustAttrs(prepShipTo,Session);

                while(catColIte.hasNext())
                {
			Map.Entry catColData = (Map.Entry)catColIte.next();

			String cat_Ar = (String)catColData.getKey();
			int ent = 0;
		
		for(int i=0;i<cartRows;i++)
		{
			String quoteRef = "Standard";
			String prodCode_S = (String)Cart.getMatId(i);
			
			String prodCode = (String)Cart.getMatId(i);
		
			String prodDesc_S = (String)Cart.getMaterialDesc(i);
			
			if(prodDesc_S==null || "null".equals(prodDesc_S) || "".equals(prodDesc_S))
				prodDesc_S = "N/A";
			
			String catalog_S = (String)Cart.getVendorCatalog(i);

			if(!cat_Ar.equals(catalog_S))
				continue;

			String eanUpc_S    = (String)Cart.getUPCNumber(i);
			String ordQty_S    = (String)Cart.getOrderQty(i);

			String prodSku_S   = (String)Cart.getCustSku(i);
			String poLine_S    = (String)Cart.getPoLine(i);
			String dispProd_S  = (String)Cart.getCat1(i);
			String prodDiv_S   = (String)Cart.getCat2(i);
			String retExcl_S   = (String)Cart.getCat3(i);

			String salesOrg_S  = (String)Cart.getSalesOrg(i);
			String division_S  = (String)Cart.getDivision(i);
			String distChnl_S  = (String)Cart.getDistChnl(i);
			String ordType_S   = (String)Cart.getOrdType(i);
			String prodStat_S  = (String)Cart.getDiscCode(i);
			String prodClass_S = (String)Cart.getExt1(i);
			String jobQunTot_S = (String)Cart.getExt2(i);
			String prodAttr_S = (String)Cart.getExt3(i);
			String prodStat_SS = prodStat_S;
			
			if("N/A".equals(prodStat_SS))
				prodStat_SS = "";
			
			String brandName = "";
			String imgLink = "";
			String poProgType = "N";
			String poProgDisp = "";
			
			brandName  = (String)Cart.getDiscPer(i); 
			imgLink    = (String)Cart.getCurrency(i); 
			poProgType = (String)Cart.getVarPriceFlag(i);  
				  	
						

			if("QS".equals(poProgType)){
				poProgDisp = "Quick Ship Item";	
				poProgType = "Q";
				}
			else if("CS".equals(poProgType)){
				poProgDisp = "Custom Item";
				poProgType = "C";
			}

			String quote_S     = (String)Cart.getMfrPartNo(i);	    
			String quote_Cust  = (String)Cart.getMfrCode(i);	  
			String ordQty_Q    = "0";
			
			String line_S 	   = (String)Cart.getWeight(i);
			String listPrice_S = (String)Cart.getUnitPrice(i);
			String lineItems_S = (String)Cart.getMaterialNumber(i);
			
			if(listPrice_S==null || "null".equals(listPrice_S) || "".equals(listPrice_S))
				listPrice_S="0.00";

			if(eanUpc_S==null || "null".equals(eanUpc_S))
				eanUpc_S="";	

			if(ordQty_S==null || "null".equals(ordQty_S))
				ordQty_S="0";	 
				
			if(jobQunTot_S==null || "null".equals(jobQunTot_S))
				jobQunTot_S ="0";
												
			if(quote_Cust.equals("N/A"))
			{
				quote_Cust = (String)session.getValue("AgentCode");
			}
			
			boolean prdAllowed = true;
			String custAttr ="";
			try
			{			
				if(custmrAttrHT==null)
				{
					custAttr	= (String)custAttrsHT.get(salesOrg_S);
					prdAllowed	= checkAttributes(prodAttr_S,custAttr);
				}
				else
				{
					custAttr = (String)custmrAttrHT.get(salesOrg_S);

					if(!"".equals(custAttr) && !"null".equals(custAttr))
					{
						prdAllowed = checkAttributes(prodAttr_S,custAttr);
					}
				}
			}
			catch(Exception e){}
			
			if(quote_S!=null && !"null".equals(quote_S) && !"N/A".equals(quote_S)) quoteRef = quote_S+"/"+line_S;
			
			String noneChk  = "";
			String dispChk = "";
			String vipChk = "";
			String focChk = "";
			String qsChk = "";
			String csChk = "";

			if(prodSku_S!=null && "N/A".equals(prodSku_S)) prodSku_S = "";
			if(poLine_S!=null && "N/A".equals(poLine_S)) poLine_S = "";
			
			checkOne = "";
			if(dispProd_S!=null && !"null".equals(dispProd_S)) 
			{
				dispProd_S = dispProd_S.trim();

				if("N/A".equals(dispProd_S) || "PT".equals(dispProd_S)) noneChk = "CHECKED";
				else if("DISP".equals(dispProd_S)) dispChk = "CHECKED";
				else if("VIP".equals(dispProd_S))  vipChk  = "CHECKED";
				else if("FOC".equals(dispProd_S))  focChk  = "CHECKED";
				else if("QS".equals(dispProd_S))   qsChk   = "CHECKED";
				else if("CS".equals(dispProd_S))   csChk   = "CHECKED";
			} else {
				noneChk = "CHECKED";
				dispProd_S = "N/A";
			}
			java.math.BigDecimal bOrdQty_S  = new java.math.BigDecimal(ordQty_S);
			java.math.BigDecimal bquoteQty = new java.math.BigDecimal(ordQty_S);
			java.math.BigDecimal bPrice_S   = new java.math.BigDecimal(listPrice_S);
			java.math.BigDecimal subTotal_S = (bOrdQty_S).multiply(bPrice_S);

			bPrice_S = bPrice_S.setScale(2,java.math.BigDecimal.ROUND_HALF_UP);
			subTotal_S = subTotal_S.setScale(2,java.math.BigDecimal.ROUND_HALF_UP);

			bGTotal_S = bGTotal_S.add(subTotal_S);

			boolean isDXV = false;
			if("CU".equals(userRole) && ("D1".equals(prodDiv_S) || "D2".equals(prodDiv_S) || "D3".equals(prodDiv_S) ||
			   "D4".equals(prodDiv_S) || "D5".equals(prodDiv_S) || "D9".equals(prodDiv_S)))
			{
				isDXV = true;
			}
			else
				prodDiv_S = "";
%>
			<tr style="background-color:white" id="linedatarow">	

			<input type="hidden" name="matId_<%=i%>" value="<%=prodCode_S%>">  
			<input type="hidden" name="matDesc_<%=i%>" value="<%=prodDesc_S%>">
			<input type="hidden" name="venCat_<%=i%>" value="<%=catalog_S%>">
			<input type="hidden" name="reqQty_<%=i%>" value="<%=ordQty_S%>">
			<input type="hidden" name="lineItem_<%=i%>" value="<%=lineItems_S%>">
			<input type="hidden" name="totJobQua_<%=i%>" value="<%=jobQunTot_S%>"> <!-- Total jobquote quantity-->

			<input type="hidden" name="salesOrg_<%=i%>" value="<%=salesOrg_S%>">
			<input type="hidden" name="division_<%=i%>" value="<%=division_S%>">
			<input type="hidden" name="distChnl_<%=i%>" value="<%=distChnl_S%>">
			<input type="hidden" name="ordType_<%=i%>" value="<%=ordType_S%>">
			<input type="hidden" name="prodClass_<%=i%>" value="<%=prodClass_S%>">
			<input type="hidden" name="prodDiv_<%=i%>" value="<%=prodDiv_S%>">

			<td class="a-center" width=5% >
			<input type="hidden" name="allItemsATP_<%=i%>" value="<%=prodCode_S%>"  >
			<input type="hidden" name="prodStat_<%=i%>" value="<%=prodStat_S%>"  >

			<input type="checkbox" name="CheckBox1" value="<%=i%>"  ><br>			
<%
			if(prdAllowed)
			{
%>			
				<img id=flag_<%=i%> name=flag_<%=i%> src="../../Library/images/none.PNG" height="20" width="20"><br>
				<input type="hidden" name="flagATP_<%=i%>" id="flagATP_<%=i%>" value="ATP"  >
<%
			}
			else
			{
%>
				<img id=flag_<%=i%> name=flag_<%=i%> src="../../Library/images/icon-flag.png" height="20" width="20"><br>
				<input type="hidden" name="flagATP_<%=i%>" id="flagATP_<%=i%>" value="NPA"  >
<%
			}
			if(isDXV)
			{
				imgLink = "N/A";
				brandName = "Not Assigned";
%>
				<p class="cat-num" style="color:red">Ordering is Impermissible</p><br><br>
<%
			}
			if("Z3".equals(prodStat_SS) || "Z2".equals(prodStat_SS) || "Z4".equals(prodStat_SS))
			{	
%>													
				<p class="cat-num" style="color:red">Discontinued</p>
<%
			}
			else if("ZM".equals(prodStat_SS) && "Standard".equals(quoteRef))
			{
%>
				<p class="cat-num" style="color:red">Modification<br>Contact Customer Care<br>for Ordering</p>
<%
			}
			else if("ZP".equals(prodStat_SS))
			{
%>
				<p class="cat-num" style="color:red">Production Hold<br>ordering is impermissible</p>				
<%
			}
			else if("ZF".equals(prodStat_SS))
			{	
%>				
				<p class="cat-num" style="color:red">To Be Discontinued</p>
<%				
			}
			else if("11".equals(prodStat_SS))
			{
%>				
				<p class="cat-num" style="color:red">New</p>
<%				
			}							
%>			
			<br><br><br>
<%
			if("Y".equals(rulesApp))
			{
				if(retExcl_S!=null && !"".equals(retExcl_S) && !"null".equals(retExcl_S) && !"N/A".equals(retExcl_S))
				{
%>
					Remove
<%
				}
			}
%>
			</td>
			<td width=17% class="a-center"><br>
<%			if(!"N/A".equals(imgLink))	
			{
%>
				<img class="lazy" src="<%=imgLink%>" data-original="<%=imgLink%>" height="170" width="170">
				<br>
<%			
			}
%>
			<%=brandName%>
			</td >
			<td width=30%><%=prodDesc_S%>
				<br><strong>PROD#</strong><a href="javascript:getProductDetails('<%=prodCode_S%>')" title="<%=prodDesc_S%>"><%=prodCode_S%>&nbsp;</a>
			<br><strong>UPC#</strong><%=eanUpc_S%>
			<br><strong><font color=red><%=poProgDisp%></font></strong>
			</td>
			<td width=18% class="a-center">
			<input name="cartQty_<%=i%>" id="cartQty_<%=i%>" value="<%=bquoteQty%>" size=10 class="input-text-qty" maxlength="9"  onkeypress="return alpha(event)" onblur="quoteQtyChk('<%=i%>')" onkeyup="hideBtn()"></input>
			<input name="prodSku_<%=i%>" id="prodSku_<%=i%>" value="<%=prodSku_S%>" size=10 class="input-text-qty" maxlength="20" onkeyup="hideBtn()"></input>
			<input name="poLine_<%=i%>" id="poLine_<%=i%>" value="<%=poLine_S%>" size=10 class="input-text-qty" maxlength="20" onkeyup="hideBtn()" onkeypress="return alpha(event)"></input>
			</td>
<%
			String favDtl = prodCode_S+"~~"+categoryID+"~~CNET";
			if(catBool)
			{
%>
				<input type="hidden" name="favDtl_<%=i%>" value="<%=favDtl%>">
				<input type="hidden" name="quoteRef_<%=i%>" value="<%=quoteRef%>">
				<td width=16% class="a-left">
<%
			if(!"Standard".equals(quoteRef))
			{
%>
				<input type="hidden" name="quoteQty_<%=i%>" value="<%=bOrdQty_S%>">
				<input type="hidden" name="quote_S_<%=i%>" value="<%=quote_S%>">
				<a href="javascript:getJobDetails('<%=quote_S%>','<%=quote_Cust%>','O')" target="_blank"><%=quoteRef%></a>
<%
			}
			else
			{
				boolean progTypeBol_I = false;
				if(userAuth_R.containsKey("SUBMIT_ORDER")) {
				if("CHECKED".equals(noneChk)) progTypeBol_I = true;
%>
					<input type="radio" id="dispVipProd_<%=i%>" onchange="hideBtn()" name="dispVipProd_<%=i%>" <%=noneChk%> value="NONE" <%=checkOne%> <%=dispRead%>></input>&nbsp;<%=quoteRef%><br>
<%
					checkOne="";
				} if(userAuth_R.containsKey("DISP_ORDER")) {
				if("CHECKED".equals(dispChk)) progTypeBol_I = true;
%>
					<input type="radio" id="dispVipProd_<%=i%>" onchange="hideBtn()" name="dispVipProd_<%=i%>" <%=dispChk%> value="DISP" <%=checkOne%> <%=dispRead%>></input>&nbsp;Display<br>
<%
				checkOne="";
				}
				if(userAuth_R.containsKey("VIP_ORDER")) 
				{
					if("CHECKED".equals(vipChk)) progTypeBol_I = true;
%>
					<input type="radio" id="dispVipProd_<%=i%>" onchange="hideBtn()" name="dispVipProd_<%=i%>" <%=vipChk%> value="VIP" <%=checkOne%> <%=dispRead%>></input>&nbsp;VIP<br>
<% //} if(userAuth_R.containsKey("FOC_ORDER") && !"3".equals(userType_A)) { 
					checkOne="";
				} if(userAuth_R.containsKey("FOC_ORDER")) {
				if("CHECKED".equals(focChk)) progTypeBol_I = true;
%>
					<input type="radio" id="dispVipProd_<%=i%>" onchange="hideBtn()" name="dispVipProd_<%=i%>" <%=focChk%> value="FOC" <%=checkOne%> <%=dispRead%>></input>&nbsp;Free of Charge<br>
<% 
					checkOne="";
				} if("Q".equals(poProgType) && userAuth_R.containsKey("QS_ORDER") && userAuth_R.containsKey("SUBMIT_ORDER")) {
				if("CHECKED".equals(qsChk)) progTypeBol_I = true;
%>
					<input type="radio" id="dispVipProd_<%=i%>" onchange="hideBtn()" name="dispVipProd_<%=i%>" <%=qsChk%> value="QS" <%=checkOne%> <%=dispRead%>></input>&nbsp;Quick Ship<br>
<%
					checkOne="";
				} else if("C".equals(poProgType)) {
				if("CHECKED".equals(csChk)) progTypeBol_I = true;
%>
					<input type="radio" id="dispVipProd_<%=i%>" onchange="hideBtn()" name="dispVipProd_<%=i%>" <%=csChk%> value="CS" <%=checkOne%> <%=dispRead%>></input>&nbsp;Custom
<%
				}
				if(progTypeBol_H && !progTypeBol_I) progTypeBol_H = false;
			}
%>
			</td>
<%
			}
%>
			<td width=16%>
			LP:&nbsp;$<%=bPrice_S%>
			<input type="hidden" name="listPrice_<%=i%>" value="<%=bPrice_S%>">
<%
			if("Y".equals(bestPrice))
			{
%>
				<br><a class="fancybox" href="#scaleid<%=i%>" onclick="javascript:loadScalePrice(<%=i%>)" >
				<span>Best Price</span></a>
				<div id="scaleid<%=i%>" style="width: 500px; display: none; ">
					<div align=center  style="padding-top:10px;">
					<ul>
						<li>&nbsp;</li>
						<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
						<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
					</ul>
					</div>
				</div>
<%
			}
%>
			</td>
			<td width='0px' class="hidden">
<%
			if(cat_Ar.equals(catalog_S) && ent==0)
			{
				String pntspcs = "Pieces";

				if("Marble".equals(catalog_S) 	    ||
				   "Enamel Steel".equals(catalog_S) || 
				   "Acrylux".equals(catalog_S) 	    || 
				   "Chinaware".equals(catalog_S)    || 
				   "Americast & Acrylics (Excludes Acrylux)".equals(catalog_S))
					pntspcs="Points";

				   String pntpcsCon = "0";
				   pntpcsCon = (String)totPointsCatHM.get(catalog_S);

				   if("Pieces".equals(pntspcs))
				   {				   
					   try
					   {
						pntpcsCon = new java.math.BigDecimal(pntpcsCon).setScale(0,java.math.BigDecimal.ROUND_HALF_UP).toString();
					   }
					   catch(Exception e){}
				   }
%>
				<span id='remId'><%=catalog_S%>&nbsp;:&nbsp;<%=pntpcsCon%>&nbsp;<%=pntspcs%></span>
<%
			}												
%>					
			</td>
			<td width='0px' class="hidden"><%=lineItems_S%></td>
			<td width='0px' class="hidden"><%=catalog_S%></td>
		</tr>
<%
		}
		}
%>
	</tbody>
	<tfoot>
	<tr class="last">
	<td colspan="4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
	<td colspan="2">
		<div id='updcartDiv'   style="display:<%=visHid%>;float: right;">
		<button type="button" title="Update Cart" class="button" onClick="javascript:updateCart()"><span>Update Cart</span></button>
		</div>
		<div id='precartDiv'  style="display:<%=visHid1%>;float: right;">
		<button type="button" title="Next" class="button" onclick="javascript:prepareOrder()"><span class="right-link">Next</span></button>
		</div>
	</td>
	</tr>
	</tfoot>
	</table>
<%
	}
	else
	{
%>
		<div class="info-box"><br>
		<ul class="success-msg">
			<li><span>No items added to cart</span></li>
		</ul>
		</div> <!-- info-box-->
<%
	}
%>
</div> <!-- Info box -->
</div> <!-- col1-set -->
</div> <!-- cart -->
</div> <!-- col-main -->
</div> <!--main -->
</div> <!-- main-container col1-layout -->
</form>
<%
	if(progTypeBol_H)
	{
%>
		<script>
		//call after page loaded
		window.onload=happycode ;
		</script>
<%
	}
%>
<script src="../../Library/Script/jquery.lazyload.js" type="text/javascript"></script>
<script  src="../../Library/Script/colResizable-1.3.min.js"></script>
<script type="text/javascript">
jQuery(function(){

	var onSampleResized = function(e){
		var columns = jQuery(e.currentTarget).find("th");
		var msg = "columns widths: ";
		columns.each()
	};

	jQuery("#quotetable").colResizable({
		liveDrag:true,
		gripInnerHtml:"<div class='grip'></div>",
		draggingClass:"dragging",
		onResize:onSampleResized});

});
</script>
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
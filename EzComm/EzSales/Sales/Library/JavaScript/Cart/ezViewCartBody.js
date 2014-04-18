
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

$(document).ready( function() {
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
});



function happycode()
{
	document.getElementById("atpfor").focus();
	loadAllBGATP();

	document.getElementById("precartDiv").style.display='block';
	document.getElementById("precartUDiv").style.display='block';
}


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
	var dxvCount = 0;
	var cartRows = document.myForm.cartRows.value;
	var processFurther = 1;
	for (i=0; i<cartRows; i++)
	{
		if ($('input:radio[id=dispVipProd_'+i+']:checked').val() == 'QS')
		{
			qsCount = qsCount + 1;

			var pClass = eval("document.myForm.prodClass_"+[i]).value;
			var pQty = eval("document.myForm.cartQty_"+[i]).value;
			if(pClass=="LUX" || pClass=="COM")
			{
				qsFauCount = parseFloat(qsFauCount) + parseFloat(pQty);
			}
		}
		if ($('input:radio[id=dispVipProd_'+i+']:checked').val() == 'FOC')
		{
			focCount = focCount + 1;
		}

		var dxvProd = eval("document.myForm.prodDiv_"+[i]).value;

		if (dxvProd == "DXV")
		{
			dxvCount = dxvCount + 1;
		}
	}
  	if (qsFauCount > 10)
  	{
  		$( "#dialog-quick" ).dialog("option", "title", "Quick Ship Faucet Program - Warning");
		$( "#dialog-quick" ).dialog('open').text(' You cannot order more than 10 PIECES under Quick Ship Faucet Program ');
		processFurther = 0;
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
  	if (dxvCount != cartRows && dxvCount != 0)
  	{
  		$( "#dialog-quick" ).dialog("option", "title", "Cannot Mix DXV Products");
		$( "#dialog-quick" ).dialog('open').text(' You cannot mix DXV Products with Other Products. Please fix ');
		processFurther = 0;
  	}

  	if (processFurther == 1)
  	{
		Popup.showModal('modal');

		var cType = document.myForm.catType_C.value;
		var cartRows = document.myForm.cartRows.value;

		if (qsCount > 0)
		{
			document.myForm.catType_C.value = 'QS';
		}
		if (focCount > 0)
		{
			document.myForm.catType_C.value = 'FOC';
			document.myForm.action="../Sales/ezPrepareFOCOrder.jsp";
		}
		else
		{
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


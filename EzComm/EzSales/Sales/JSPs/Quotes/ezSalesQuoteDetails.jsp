<div class="main-container col2-layout middle account-pages">
<div class="main">
<div class="col-main1 roundedCorners">
<div class="page-title">

<!-- Start of the Styles and Scripts for Hello Bar Solo -->
<link type="text/css" rel="stylesheet" href="../../../Includes/Lib/hellobar-solo/hellobar.css" />
<script type="text/javascript" src="../../../Includes/Lib/hellobar-solo/hellobar.js"></script>
<!-- End of the Styles and Scripts for Hello Bar Solo -->
<!-- jQuery for sorting & pagination STARTS here-->

<style type="text/css" media="screen">
	@import "../../Library/Styles/demo_table_jui.css";
	@import "../../Library/Styles/jquery-ui-1.7.2.custom.css";

	/*
	 * Override styles needed due to the mix of three different CSS sources! For proper examples
	 * please see the themes example in the 'Examples' section of this site
	 */
	.dataTables_info { padding-top: 0; }
	.dataTables_paginate { padding-top: 0; }
	.css_right { float: right; }
	#quoteLines_wrapper .fg-toolbar { font-size: 0.8em }
	#theme_links span { float: left; padding: 2px 10px; }
	#quoteLines_wrapper { -webkit-box-shadow: 2px 2px 6px #666; box-shadow: 2px 2px 6px #666; border-radius: 5px; }
	#quoteLines tbody {
		border-left: 1px solid #AAA;
		border-right: 1px solid #AAA;
	}
	#quoteLines thead th:first-child { border-left: 1px solid #AAA; }
	#quoteLines thead th:last-child { border-right: 1px solid #AAA; }
</style>

<script type="text/javascript" src="../../Library/Script/complete.min.js"></script>
<script type="text/javascript" src="../../Library/Script/jquery.dataTables.min.js"></script> 
<script type="text/javascript" src="../../Library/Script/TableTools-2.1.4/js/TableTools.min.js"></script> 

<script  src="../../Library/Script/colResizable-1.3.min.js"></script>
<script type="text/javascript" src="../../Library/Script/jquery-ui-1.8.21.all.min.js"></script> 
<Script src="../../Library/Script/popup.js"></Script> 
<script src="../../Library/Script/jquery.lazyload.js" type="text/javascript"></script>
<script type="text/javascript" src="../../Library/JavaScript/Cart/ezCartAlerts.js"></script>
<script type="text/javascript">
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


/* Formating function for row details */
function fnFormatDetails ( oTable, nTr , detailLines )
{
    var aData = oTable.fnGetData( nTr ); // get the row 
    var sOut = '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">';
    var soNum = aData[1].substring(aData[1].indexOf('>')+1,aData[1].indexOf('/')); //SONum is in a hidden div tag, so take content after div tag
    var soLine = aData[1].substring(aData[1].indexOf('/')+1,aData[1].indexOf('\n'));
    var str = '' + soNum;
    while (str.length < 10) {
            str = '0' + str;
    }
    soNum = str;
    var str2 = '' + soLine;
    while (str2.length < 6) {
            str2 = '0' + str2;
    }
    soLine = str2;
    var ccompName = 'childComponents'+soNum+soLine+'';
    if ($(document.getElementById(ccompName)).val()!=""){
    
    sOut += '<tr><td>This Item is Shipped as following Components:</td><td>'+$(document.getElementById(ccompName)).val()+'</td></tr>';
    sOut += '</table>';
    } else {
    sOut += '<tr><td>No Components for this item</td>'+'</tr>';
    sOut += '</table>';
    }
    return sOut;
}

$(document).ready( function() {
    fnFeaturesInit();
	 /*
	  * Insert a 'details' column to the table
	  */
    var nCloneTh = document.createElement( 'th' );
    var nCloneTd = document.createElement( 'td' );
    var nCloneTd2 = document.createElement( 'td' );
    nCloneTd.innerHTML = '<img src="http://datatables.net/release-datatables/examples/examples_support/details_open.png" id="openimg" name="openimg">';
    var nCloneTdEmpty = document.createElement( 'td' );
    nCloneTdEmpty.innerHTML = '<p></p>';

    $('#quoteLines tbody tr').each( function () {
	var vCol0 = $(this).find('#quotelineinfo:first').text();

	if (vCol0 !="") {
	var soNum = vCol0.substring(0,vCol0.indexOf('/'));
	var soLine = vCol0.substring(vCol0.indexOf('/')+1,vCol0.indexOf('\n'));
	if (soNum != "") {
	var str = '' + soNum;
	while (str.length < 10) {
	    str = '0' + str;
	} 
	}// soNum blank check
	soNum = str;
	if (soLine != "") {
	var str2 = '' + soLine;
	while (str2.length < 6) {
	     str2 = '0' + str2;
	}
	soLine = str2;
	} // soLine blank check
	var ccompName = 'childComponents'+soNum+soLine+'';
	var qSplitName = 'quoteSplit_'+soNum+soLine+'';
	var chkDisName = 'chkDisabled_'+soNum+soLine+'';
	if ($(document.getElementById(ccompName)).val()!=""){
		nCloneTd.innerHTML = '&nbsp;<p align="center"><input type="checkbox" name="CheckBox1" value="'+$(document.getElementById(qSplitName)).val()+'" unchecked '+$(document.getElementById(chkDisName)).val()+'><br><br><img src="http://datatables.net/release-datatables/examples/examples_support/details_open.png" id="openimg" name="openimg"></p>';
		this.insertBefore(  nCloneTd.cloneNode( true ), this.childNodes[0] );
	} else {
		nCloneTdEmpty.innerHTML = '&nbsp;<p align="center"><input type="checkbox" name="CheckBox1" value="'+$(document.getElementById(qSplitName)).val()+'" unchecked '+$(document.getElementById(chkDisName)).val()+'></p>';
		this.insertBefore(  nCloneTdEmpty.cloneNode( true ), this.childNodes[0] );
	};


	} // end vCol0
	else
	{
		var vPointsGroup = $(this).find('#pointsgroup').text();	
		if (vPointsGroup != ""){
			nCloneTdEmpty.innerHTML = '&nbsp;<p align="center"><input type="checkbox" name="CheckBox1" value="'+$(document.getElementById(qSplitName)).val()+'" unchecked '+$(document.getElementById(chkDisName)).val()+'></p>';
			this.insertBefore(  nCloneTdEmpty.cloneNode( true ), this.childNodes[0] );
			//console.log(" Inserted empty column in grouping row");
		}
	}// end else vCol0

    } );


    $(".fancybox").fancybox(
    {
    closeBtn:true,
    afterClose : function() {
	document.getElementById("ajaxAllATP").innerHTML="";
	return;
     },
     beforeLoad : function() {
	if(chkSelect()) {
		return true;
	} else {
	return false;
	}
     }
     }
    );
    $("img.lazy").lazyload({ 
	effect : "fadeIn"
    });
    var oTable = $('#quoteLines').dataTable( {

     "fnDrawCallback": function ( oSettings ) {
	if ( oSettings.aiDisplay.length == 0 )
	{
	    return;
	}

	var nTrs = $('#quoteLines tbody tr#linedatarow');
	var iColspan = nTrs[0].getElementsByTagName('td').length;
	var sLastGroup = "";
	for ( var i=0 ; i<nTrs.length ; i++ )
	{

	    var iDisplayIndex = oSettings._iDisplayStart + i;
	    var sGroup = oSettings.aoData[ oSettings.aiDisplay[iDisplayIndex] ]._aData[12];
	    // THIS CODE ASSUMES THAT 13th Column carries the custmat35 which is hidden info.
	    if ( sGroup != sLastGroup )
	    {
		var nGroup = document.createElement( 'tr' );
		var nCell = document.createElement( 'td' );
		nCell.colSpan = iColspan;
		nCell.className = "group";
		nCell.innerHTML = sGroup;
		nGroup.appendChild( nCell );
		nTrs[i].parentNode.insertBefore( nGroup, nTrs[i] );
		sLastGroup = sGroup;
	    }
	}
	}, // end of fnDrawCallback  <\"H\"Tfr>t<\"F\"ip>
	"bJQueryUI": true,
	"bSort" : true,
	"iDisplayLength": 100,
	"bPaginate":false,
	"oLanguage": { "sSearch": "Search Job Lines" } ,
	"aoColumnDefs": [ 
	      { "bVisible": false, "aTargets": [ 12 ] },
	      { "bSortable": false, "aTargets": [ 0,1,2,4,5,6,7,8,9,10,11 ] }
	    ],
       "sDom": '<"H"Tfr>t<"F"p>',
	  "oTableTools": {
		"sSwfPath": "/AST/EzComm/EzSales/Sales/Library/Script/TableTools-2.1.1/swf/copy_csv_xls_pdf.swf",
		"aButtons": [
			{
				    "sExtends":    "csv",
				    "sButtonText": "Download CSV",
				    "bFooter":false,
				    "mColumns": [ 2, 3 ,4,5,6,7,8,9,10],
				    "sRowSelect": "multi"
			}
		]
	 }
    });

 /* Add event listener for opening and closing details
     * Note that the indicator for showing which row is open is not controlled by DataTables,
     * rather it is done here
     */
$('#openimg').live('click', function () {
	var nTr = $(this).parents('tr')[0];
	if ( oTable.fnIsOpen(nTr) )
	{
	    /* This row is already open - close it */
	    this.src = "http://datatables.net/release-datatables/examples/examples_support/details_open.png";
	    oTable.fnClose( nTr );
	}
	else

	{
	    /* Open this row */
	    this.src = "http://datatables.net/release-datatables/examples/examples_support/details_close.png";
	    oTable.fnOpen( nTr, fnFormatDetails(oTable, nTr, 'hello123'), 'details' );
	}
} );

oTable.fnSortListener( document.getElementById('sorter'), 3 );
oTable.fnSortListener( document.getElementById('sorter2'), 12 );
enableOrDisable();

} );

</script>

<script type="text/javascript">
$(function(){
var onSampleResized = function(e){
	var columns = $(e.currentTarget).find("th");
	var msg = "columns widths: ";
	columns.each()
};
$("#quoteLines").colResizable({
	liveDrag:true,
	gripInnerHtml:"<div class='grip'></div>",
	draggingClass:"dragging",
	onResize:onSampleResized});
});

</script>
<!-- jQuery for sorting & pagination ENDS here -->
<!-- Add fancyBox -->
<link rel="stylesheet" href="../../Library/Script/jquery.fancybox.css?v=2.0.5" type="text/css" media="screen" />
<script type="text/javascript" src="../../Library/Script/jquery.fancybox.pack.js?v=2.0.5"></script>
<!-- end of fancybox -->

<style>

.vdialogpos {
	display: block; 
	z-index: 1002; 
	outline: 0px; 
	position: absolute !important; 
	height: 199.2799997329712px; 
	width: 400px; 
	top: 30% !important; 
	left: 500px;
}
</style>

<script type="text/javascript">
function enableOrDisable()
{	
	var field=document.myForm.CheckBox1;
	var chkbox = document.myForm.CheckBox1.length;
	var chkCount = 0;
	if(isNaN(chkbox))
	{
		if(document.myForm.CheckBox1.disabled == false)
		{
			chkCount++;
		}
	}
	else
	{
		for (i = 0; i < field.length; i++)
		{
			if (document.myForm.CheckBox1[i].disabled == false ){
			chkCount++;
			}
		}
	}	
	if ( chkCount > 0 ) 
	{
		if (isNaN(chkbox)) {
			// Enable CheckBoxAll when there is only ONE row
			if (chkCount>0) 
				document.myForm.CheckBoxAll.disabled = false;
		} else {
		if (chkCount == field.length) {
			// Enable checkboxall when ALL rows as enabled
			document.myForm.CheckBoxAll.disabled = false;
		}
		}
		// Enable Copy to Order if atleast one row is enabled
		if (document.getElementById('copyselected') != null)
		document.getElementById('copyselected').style.visibility='visible';
	} else {
		document.myForm.CheckBoxAll.disabled = true;
		if (document.getElementById('copyselected') != null)
		document.getElementById('copyselected').style.visibility='hidden';
	}
}

function checkAll(field)
{	
	if(document.myForm.CheckBoxAll.checked)
	{	
		for (i = 0; i < field.length; i++)
		{
			if ( document.myForm.CheckBox1[i].disabled == false )
				document.myForm.CheckBox1[i].checked = true ;
		}
	}	
	else
	{	
		for (i = 0; i < field.length; i++)
		{
			if ( document.myForm.CheckBox1[i].disabled == false )
				document.myForm.CheckBox1[i].checked = false ;
		}
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
		$( "#dialog-confirm-select" ).dialog('open');
		return false;
	}
	return true;
}
function getProductDetails(code)
{	
	document.myForm.prodCode_D.value=code;
	document.myForm.action="../Catalog/ezProductDetails.jsp";
	document.myForm.target="_blank";
	document.myForm.submit();
}

function copySelOrderWithQ(){
	$("#dialog-confirm-order").dialog('open');
}

function copySelOrder()
{
	var cRefType = document.myForm.catRefType.value;
	if(chkSelect())
	{
		var selCartItems = '';
		var matCodes='';
		var chkbox = document.myForm.CheckBox1.length;
		if(isNaN(chkbox))
		{
			if(document.myForm.CheckBox1.checked)
			{
				selCartItems = 	document.myForm.CheckBox1.value;

			}
		}
		else
		{
			var indx = 0;
			for(a=0;a<chkbox;a++)
			{				
				if(document.myForm.CheckBox1[a].checked)
				{
					if(indx==0)
					{						
						selCartItems = 	document.myForm.CheckBox1[a].value;
					}	
					else	
					{						
						selCartItems = 	selCartItems+"§"+document.myForm.CheckBox1[a].value;
					}	
					indx++;
				}
			}
		}
		Popup.showModal('modal');
		addToCartFav(selCartItems,'');
	}
}

function chkSelItem(num)
{
	var chkbox = document.myForm.CheckBox1.length;
	chkCount=0
	if(isNaN(chkbox))
	{
		document.myForm.CheckBox1.checked=true;
	}
	else
	{
		document.myForm.CheckBox1[num].checked=true;
	}
	return true;
}
function copyOrder(num,splitOne,matCode)
{	
	var cRefType = document.myForm.catRefType.value;
	if(chkSelItem(num))	
	{
		Popup.showModal('modal');
		addToCartFav(splitOne,matCode);
	}
}

var req
var stat 
var pcode

function addToCartFav(splitMat,matCode)
{		
	req=Initialize();

	if (req==null)
	{
	alert ("Your browser does not support Ajax HTTP");
	return;
	}			
	pcode=matCode
	stat='C'
	if(stat=="C")
	{	
		var custQuote =	document.myForm.custQuote.value;
		url="../ShoppingCart/ezAddCartCopyOrder.jsp";
		url=url+"?CheckBox1="+splitMat+"&custQuote="+custQuote;
	}
	
	if(req!=null)
	{			
		req.onreadystatechange = Process;
		req.open("GET", url, true);
		req.send(null);
	} else {
		Popup.hide('modal');
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
				var flag = true;

				for(i=0;i<myKeys.length;i++)
				{
					var chkKey = myKeys[i].helpKey;

					if(resText.indexOf(chkKey)!=-1)
					{
						alertCode = myKeys[i].helpText;
						alertIcon = '<img src="../../Library/images/icon-error-message.png"/>';
						flag = false;
						break;
					}
				}

				if(flag)
				{
					alertIcon = '<img src="../../Library/images/icon-success-message.png"/>';
					alertCode='has been successfully added to cart.';
					
					var currentC = $('#cartcount').text();
					var newC =parseInt(currentC)+1;
					$('#cartcount').text(newC);

					var chkbox = document.myForm.CheckBox1.length;
					if(isNaN(chkbox))
					{
						if(document.myForm.CheckBox1.checked)
						{
							document.myForm.CheckBox1.disabled=true;
							document.myForm.CheckBox1.checked=false;
						}
					}
					else
					{
						for(a=0;a<chkbox;a++)
						{				
							if(document.myForm.CheckBox1[a].checked)
							{
								document.myForm.CheckBox1[a].disabled=true;
								document.myForm.CheckBox1[a].checked=false;
							}
						}
					}
				}

				new HelloBar( '<span>'+ alertIcon +'Product ' +pcode+ ' '+alertCode+ ' </span><a href="../ShoppingCart/ezViewCart.jsp">Click to See Your Cart!</a>', {

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
			$( "#dialog-confirm-proderror" ).dialog('open');
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
	var atpf = '#prodCode_'+ind;
	var atpq = '#qty_'+ind;

	var atpfor = jQuery(atpf).text().trim();
	var atpqty = jQuery(atpq).text().trim();
	var atpon=document.myForm.atpon.value;
	var stAtp=document.myForm.stAtp.value;


	var url="../ShoppingCart/ezATPAjaxLightBox.jsp";
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

var xmlhttpATP

function loadAllATP()
{
	 xmlhttpATP=GetXmlHttpObjectATP();

	if (xmlhttpATP==null)
	{
		$( "#dialog-notsup" ).dialog('open');
		return;
	}
	var cRefType = document.myForm.catRefType.value;
  			
	if(chkSelect())
	{
		document.getElementById("getMultiATP").href="#ajaxAllATP";
		document.getElementById("getMultiATP").className = "fancybox";
	
		var inittext = "<div align=center  style=\"padding-top:100px;\"> " +
				"<ul>" +
				"<li></li>" +
				"<li><img src=\"../../Library/images/loading.gif\" width=\"100\" height=\"100\" alt=\"\"></li>"+
				"<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>"+
				"</ul></div>";
		document.getElementById("ajaxAllATP").innerHTML=inittext;
		var selCartItems = '';
		var matCodes='';
		var atpf = "";
		var atpq = "";
		
		var atpfor = "";
		var atpqty = "";
		var chkbox = document.myForm.CheckBox1.length;
		if(isNaN(chkbox))
		{
			if(document.myForm.CheckBox1.checked)
			{
				atpf = '#prodCode_'+0;
				atpq = '#qty_'+0;
			
				atpfor = document.myForm.CheckBox1.value.split('¥')[0]
				atpqty = document.myForm.CheckBox1.value.split('¥')[4]
				selCartItems = 	atpfor+"¥"+atpqty;
			}
		}
		else
		{
			var indx = 0;
			for(a=0;a<chkbox;a++)
			{				
				var cartQty
				var atpProd
				var atpprodqty

				if(document.myForm.CheckBox1[a].checked)
				{
					if(indx==0)
					{			
						atpf = '#prodCode_'+indx;
						atpq = '#qty_'+indx;
						atpfor = document.myForm.CheckBox1[a].value.split('¥')[0]
						atpqty = document.myForm.CheckBox1[a].value.split('¥')[4]
						selCartItems = 	atpfor+"¥"+atpqty;
					}	
					else	
					{					
						atpf = '#prodCode_'+a;
						atpq = '#qty_'+a;
						atpfor = jQuery(atpf).text().trim();
						atpqty = jQuery(atpq).text().trim();
						atpfor = document.myForm.CheckBox1[a].value.split('¥')[0]
						atpqty = document.myForm.CheckBox1[a].value.split('¥')[4]
						selCartItems = 	selCartItems+"§"+atpfor+"¥"+atpqty;
					}	
					indx++;
				}
			}
		}
		chkCount=0

		var atpon=document.myForm.atpon.value;
		var stAtp=document.myForm.stAtp.value;

		var chkbox = document.myForm.CheckBox1.length;

		var url = "../ShoppingCart/ezATPAllAjaxLightBox.jsp?atpfor="+selCartItems+"&atpon="+atpon+"&stAtp="+stAtp;

		xmlhttpATP.onreadystatechange=getOutputATP;
		xmlhttpATP.open("GET",url,true);
		xmlhttpATP.send(null);
	} 
	else 
	{
		$("#ajaxAllATP").attr("href","#");
	}
}

function getOutputATP()
{
	if (xmlhttpATP.readyState==4)
	{
		document.getElementById("ajaxAllATP").innerHTML=xmlhttpATP.responseText;
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

$(function() {
$( "#dialog-confirm" ).dialog({
		autoOpen: false,
		resizable: true,
		height:200,
		width:400,
		modal: true,
		buttons: {
			"Ok": function() {
				$( this ).dialog( "close" );
			}
		}
	});
$( "#dialog-confirm-select" ).dialog({
			autoOpen: false,
			resizable: true,
			height:200,
			width:400,
			modal: true,
			buttons: {
				"Ok": function() {
					$( this ).dialog( "close" );
				}
			}
		});
$( "#dialog-confirm-proderror" ).dialog({
		autoOpen: false,
		resizable: true,
		height:200,
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


if ($('#fromPage').val() == 'ezjobQuotesList.jsp' || $('#fromPage').val() == 'ezExpiringJobQuotes.jsp') {
	$( "#dialog-confirm" ).dialog('open');
	$( "#dialog-confirm" ).dialog({ dialogClass: 'vdialogpos' });
} else {
	$( "#dialog-confirm" ).dialog('close');
}
});


</script>

<%@ include file="../../../Includes/JSPs/Quotes/iSalesQuoteDetails.jsp"%>
<%@ include file="../../../Includes/JSPs/ShoppingCart/iCheckCartItems.jsp"%>

<%!
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
<%
	if ((dstat == null) || dstat.equals(null)){
		dstat = "O";
	}
	String atpon   = cMonth_S+"/"+cDate_S+"/"+cYear;
	String jobName 	= retHeader.getFieldValueString(0,"PO_NO");
	String jobType = retHeader.getFieldValueString(0,"DOC_TYPE");
	if (jobType.equalsIgnoreCase("ZIN")) {
		jobType = "Inquiry";
	} else {
		jobType = "Job Quote";
	}	
		
	String valFrom 	= ret.getFieldValueString(0,"QT_VALID_F");
	String valTo 	= ret.getFieldValueString(0,"QT_VALID_T");
	String docDate 	= ret.getFieldValueString(0,"DOC_DATE");
	String backListPage="ezJobQuotes.jsp";
	String statText2 = "OPEN";
	
	
	if("X".equals(dstat))
	{
		backListPage="ezExpiringJobQuotes.jsp";
		statText2 = "OPEN, EXPIRING SOON";
	}
	else if("E".equals(dstat))
	{
		backListPage="ezExpiredJobQuotes.jsp";
		statText2 = "EXPIRED";
	}
	else if("C".equals(dstat))
	{
		backListPage="ezClosedJobQuotes.jsp";
		statText2 = "CLOSED";
	}
	String z001Text = "";
	if (retLineText != null )
	{
		for (int rl=0;rl<retLineText.getRowCount();rl++)
		{
			if (retLineText.getFieldValueString(rl,"TEXT_NO").trim().equals("0001"))//Z001
				z001Text+=retLineText.getFieldValueString(rl,"TEXT")+"\n";
		}
	}
%>
<!-- Style for New Header -->
<style type="text/css">
.highlight {
                height: 65px;
                width: 100%;
		background: #e9e9e9;
		background: -webkit-linear-gradient(#e9e9e9, #c0c0c0);
		background: -moz-linear-gradient(#e9e9e9, #c0c0c0);
		background: -ms-linear-gradient(#e9e9e9, #c0c0c0);
		background: -o-linear-gradient(#e9e9e9, #c0c0c0);
		background: linear-gradient(#e9e9e9, #c0c0c0);
}
.inputBox {
	box-shadow: inset 0px 0px 0px ; 
	-moz-box-shadow: inset 0px 0px 0px ; 
	-webkit-box-shadow: inset 0px 0px 0px ; 
	border: none; 
}
</style>

<!-- en dof style for new header -->
<div id="modal" style="border:0px solid black; background-color:white; padding:1px; font-size:10;width:40%;height:180px; text-align:center; display:none;">
	<ul>
		<li>&nbsp;</li>
		<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
		<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
	</ul>
</div>

	<div class="highlight" style="height:75px" >
	<div style="width: 100%; float: left">
<%
		if (!jobType.equals("")) 
		{
%> 
			<br>&nbsp;<font size="5" color="black"><b><%=jobType.toUpperCase()%></b> </font><br>
<%
		} 
		else 
		{
%>
			<br>&nbsp;<font size="5" color="black"><b>JOB QUOTE</b> </font><br>
<%
		}
%>
		&nbsp;<strong>JOB NAME:</strong>&nbsp;<%=jobName%>&nbsp;<strong>JOB NO.:</strong>&nbsp;<%=(Long.parseLong(salesDoc))%><strong>&nbsp;JOB DATE:</strong>&nbsp;<%=docDate%>&nbsp;
		<strong>VALID FROM:&nbsp;</strong><%=valFrom%>&nbsp;<strong>TO:</strong>&nbsp;
<% 
		if (!(valTo==null) && !(valTo.equals("null"))) 
		{
%>
			<%=valTo%>
<%
		} 
		else 
		{
%>
			N/A
<%
		};
%>

		<br>
		&nbsp;<strong>STATUS:</strong>&nbsp;<%=statText2%> 
		<br>
	</div>
	</div>
	<br>
<% 
	if ( (!(valTo==null)) && (!valTo.equals("null")) ) 
	{ 
		DateFormat formatter1;

		Date todayDate = new Date();
		formatter1 = new SimpleDateFormat("MM/dd/yyyy");

		Date valToDate = (Date)formatter1.parse(valTo); 
		if (valToDate.compareTo(todayDate) <0 ){
			dstat = "E";
		}	
		else
		{
			dstat = "O";
		}
	}
%>

	<div id='backToList' >
	<button type="button" title="Back to List" class="button" onclick="javascript:history.go(-1)"><span>Back to List</span></button>
	</div>

<%
		if ((!"E".equals(dstat) && !"C".equals(dstat)) && (userAuth_R.containsKey("SUBMIT_ORDER"))) 
		{
%>
			<div id='copyselected' name="copyselected">
				<button type="button" title="Copy Selected to Cart" class="button" 
				onclick="javascript:copySelOrder()"><span>Copy Selected to Cart</span></button>
			</div>
<%
		}
%>	
	<div id='loadAtp' >
		<a id="getMultiATP" class="fancybox" href="#" onclick="javascript:loadAllATP()" style="color:white"><button type="button" title="Check Availability" class="button" onclick="javascript:loadAllATP()"><span>Check Availability</span></button></a>
	</div>
	<div id='Sort Button' >
		<button type="button" title="Sort by Line" class="button" id="sorter"><span>Sort by Line No</span></button>
	</div>
	<div id='Sort Button2' >
		<button type="button" title="Sort by Group" class="button" id="sorter2"><span>Sort by Group</span></button>
	</div>
	<br>
</div>
<br>
<% 
	if (!z001Text.trim().equals("")) 
	{
%>
		<Table width="100%" >
		<Tr>
			<Td><label for="jobtext"><strong>Job Notes</strong></label></Td>
		</Tr>
		<Tr>
			<Td>
				<textarea id="jobtext" rows="2" cols="80"><%=z001Text%></textarea>
			</Td>
		</Tr>
		</Table>
		<br>
		<div id="dialog-confirm" title="Job Notes">
			<p id="mymess"><%=z001Text%></p>
		</div>
<%
	}
%>
<div id="dialog-confirm-proderror" title="Error in Product Addition">
	<p>Error in Adding Product. Please try later or contact Administrator</p>
</div>

<div id="dialog-confirm-select" title="Select Products">
	<p>Please Select atleast one Product for desired action</p>
</div>
<div id="dialog-notsup" title="Not Supported">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;display:none;"></span>Your browser does not support this function. Please use a Compatible modern web browser.</p>
</div>
<div class="col1-set">
<div class="info-box">
	
<form name="myForm" method="post">
<input type="hidden" name="prodCode_D"/>
<input type="hidden" name="fromPage" value=<%=fromPage%> id="fromPage" />
<input type="hidden"  id="atpon" name="atpon" value="<%=atpon%>" />
<input type="hidden"  id="stAtp" name="stAtp" value="<%=session.getValue("shipState")%>" />
<input type="hidden" name="catRefType" value="<%=catType_C%>">
<input type="hidden" name="custQuote" value="<%=customer%>">

	<table class="data-table" id="quoteLines">
	<thead>
		<tr>
			<th width=5% class="a-center">  <input type="checkbox" name="CheckBoxAll"  onClick="checkAll(document.myForm.CheckBox1)" value=""></th>
			<th width=15%>Image<br>Brand</th>
			<th>Quote No</th>
			<th>Line No</th>
			<th width=20%>Product Name<br>Product ID</th>
			<th>List [USD]</th>
			<th>Quote <br>Price</th>
			<th>Quote<br>Qty [EA] </th>
			<th>Open<br>Qty [EA]</th>
			<th>Open<br>Value [USD]</th>
			<th>Sub<br>Total [USD]</th>
			<th>Status</th>
			<th>CustMat35</th>
		</tr>
	</thead>
	<tbody>
<%
	java.math.BigDecimal totTax = new java.math.BigDecimal("0");
	int count = retItems.getRowCount();
	String quoteSplit="";
	String cumOpenValue="0",cumSubTotal="0";
	
	Map sortedMap = new TreeMap(catalogHM);
	Set catCol = sortedMap.entrySet();
	Iterator catColIte = catCol.iterator();
	
	while(catColIte.hasNext())
	{ 
		
		Map.Entry catColData = (Map.Entry)catColIte.next();

		String cat_HM = (String)catColData.getKey();
		int ent = 0;

		for(int i=0;i<count;i++)
		{
			String tempSalesDocNumber = "";
			String matno		= retItems.getFieldValueString(i,"ITEM_NO");
			String cust_mat35 	= slsOrdLineRetObj.getFieldValueString(i,"CUST_MAT35");
			String salesDocNo 	= retItems.getFieldValueString(i,"DOC_NO");
			String rejReason 	= retItems.getFieldValueString(i,"REJREASON");

			String strikeTextStartTag = "", strikeTextEndTag = "";
			if(!"".equals(rejReason))
			{
				strikeTextStartTag = "<strike>";
				strikeTextEndTag = "<strike>";
			}	

			if(!cat_HM.equals(cust_mat35))
				continue;

			try
			{
				tempSalesDocNumber = (Long.parseLong(salesDocNo))+"";
			}
			catch(Exception e)
			{
				tempSalesDocNumber = salesDocNo;
			}


			String lineNo 		= retItems.getFieldValueString(i,"LINE_NO");
			String itemDesc		= retItems.getFieldValueString(i,"ITEM_DESC");
			if(itemDesc!=null || !"null".equals(itemDesc) || !"".equals(itemDesc))
			{
				itemDesc = itemDesc.replaceAll("\"","``");
				itemDesc = itemDesc.replaceAll("'","`");
				itemDesc = itemDesc.replaceAll("&","££");
			}
			String eanUPC		= retItems.getFieldValueString(i,"EAN_UPC");
			String custMat          = retItems.getFieldValueString(i,"CUST_MAT");
			String price		= retItems.getFieldValueString(i,"NET_PRICE");
			String itemValue	= retItems.getFieldValueString(i,"VALUE");

			String zztext           = retItems.getFieldValueString(i,"ZZTEXT");
			String itTax            = retItems.getFieldValueString(i,"TAX");
			String requireddate 	= retItems.getFieldValueString(i,"REQUIREDDATE");
			String rejectionres 	= retItems.getFieldValueString(i,"REJREASON");
			String poItemNo 	= retItems.getFieldValueString(i,"PO_ITM_NO");

			String volume = slsOrdLineRetObj.getFieldValueString(i,"VOLUME");
			String parentItem = slsOrdLineRetObj.getFieldValueString(i,"PARENT_ITEM");
			String childComponents = "";
			String childComponentsLineNos = "";
			String parentItemComp = "";
			String itemDescComp = "";
			String matnoComp = "";
			String salesDocNoComp = "";
			String lineNoComp = "";
			String itemQtyComp = "";

			// Find all children and make a table. See if we can do it conditionally based on item category
			for(int itemc=0;itemc<count;itemc++){
				parentItemComp = "";
				itemDescComp = "";
				matnoComp = "";
				salesDocNoComp = "";
				lineNoComp = "";
				parentItemComp =         slsOrdLineRetObj.getFieldValueString(itemc,"PARENT_ITEM");//slsOrdLineRetObj
				itemDescComp                 = retItems.getFieldValueString(itemc,"ITEM_DESC");
				matnoComp                       = retItems.getFieldValueString(itemc,"ITEM_NO");
				salesDocNoComp            = retItems.getFieldValueString(itemc,"DOC_NO");
				lineNoComp                       = retItems.getFieldValueString(itemc,"LINE_NO");
				itemQtyComp = retItems.getFieldValueString(itemc,"QTY");
				if (parentItemComp.equals(lineNo) && salesDocNo.equals(salesDocNoComp) )
				{
					// Components Parent Item # matches the current Line #, and sales order nr is same
					// This component belongs to current line
					childComponents+="" +
					matnoComp 
					+ " " 
					+ itemDescComp
					+ "&nbsp;<br/>";
					childComponentsLineNos+=lineNoComp+":"+itemQtyComp+";";
				}

			 } // end of for itemc loop to get components

			String listPrice = "0";
			String jobQuotePrice = "0",totJobQuotePrice = "0";
			String openQty = "0",totOpenQty="0",reqQty = "0",condExch="0",totOpenValue="0";

			String pricingCondTable = "<table class=\"data-table\"><thead><tr><th>Condition Type</th><th>Value</th></tr></thead><tbody>";

			String schedLinesTable = "<table class=\"data-table\"><thead><tr><th>Schedule Qty</th><th>Required Date</th></tr></thead><tbody>";

			for(int j=0;j<retCond.getRowCount();j++) 
			{
				String condLineNo = retCond.getFieldValueString(j,"ItmNumber");
				String condType = retCond.getFieldValueString(j,"CondType");												

				if(lineNo.equals(condLineNo))
				{						
					if("ZUPR".equals(condType))
					{
						listPrice = retCond.getFieldValueString(j,"Condvalue");

						try
						{
							listPrice = new java.math.BigDecimal(listPrice).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
						}
						catch(Exception e){}
					}
					if("ZJOB".equals(condType))
					{
						jobQuotePrice = retCond.getFieldValueString(j,"Condvalue");
						totJobQuotePrice = retCond.getFieldValueString(j,"CondValue");
						condExch = retCond.getFieldValueString(j,"Conexchrat");

						try
						{
							jobQuotePrice = new java.math.BigDecimal(jobQuotePrice).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
						}
						catch(Exception e){}

						try
						{
							totJobQuotePrice = new java.math.BigDecimal(totJobQuotePrice).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
						}
						catch(Exception e){}

						try
						{
							condExch = new java.math.BigDecimal(condExch).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
						}
						catch(Exception e){}

						pricingCondTable = pricingCondTable+"<tr><td>&nbsp;&nbsp;&nbsp;"+condType+"</td><td >&nbsp;&nbsp;"+jobQuotePrice+"</td></tr>";
					}
					if("PN00".equals(condType)) // For Inquiries
					{
						jobQuotePrice = retCond.getFieldValueString(j,"Condvalue");
						totJobQuotePrice = retCond.getFieldValueString(j,"CondValue");
						condExch = retCond.getFieldValueString(j,"Conexchrat");

						try
						{
							jobQuotePrice = new java.math.BigDecimal(jobQuotePrice).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
						}
						catch(Exception e){}

						try
						{
							totJobQuotePrice = new java.math.BigDecimal(totJobQuotePrice).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
						}
						catch(Exception e){}

						try
						{
							condExch = new java.math.BigDecimal(condExch).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
						}
						catch(Exception e){}

						pricingCondTable = pricingCondTable+"<tr><td>&nbsp;&nbsp;&nbsp;"+condType+"</td><td >&nbsp;&nbsp;"+jobQuotePrice+"</td></tr>";

						// Handling Combo Item 
						//out.println("childComponents -->"+childComponentsLineNos);
						if (!childComponentsLineNos.trim().equals("")) {
							// Current item is parent item. Get the condition values of children
							 String[] tempCompLineArray;
							 tempCompLineArray = childComponentsLineNos.split(";");
							itemValue = "0";
							for(int tmpl =0; tmpl < tempCompLineArray.length ; tmpl++)
							{
								// for EACH component line get the PN00 value by looping at condition table
							for(int crec=0;crec<retCond.getRowCount();crec++)
							{
								String condLineNo1 = retCond.getFieldValueString(crec,"ItmNumber");
								String condType1 = retCond.getFieldValueString(crec,"CondType");
								String tempSONum1 = retCond.getFieldValueString(crec,"DOC_NO");
								String condDesc1 = "";
								String condVal1 = "";

								if(salesDocNo.equals(tempSONum1) && tempCompLineArray[tmpl].substring(0,6).equals(condLineNo1) 
								   && (condType1.equals("PN00")))
								{
									// we found a matching/appropriate Net Value condition
									condVal1 = retCond.getFieldValueString(crec,"Condvalue");
								try
								{
									// set scale to 2, and then add this condition value to existing itemValue

									condVal1 = new java.math.BigDecimal(condVal1).setScale(3,java.math.BigDecimal.ROUND_HALF_UP).toString();

									java.math.BigDecimal condVal1BD = (new  java.math.BigDecimal(condVal1).setScale(2,java.math.BigDecimal.ROUND_HALF_UP));

									// If component qty is a multiple of item qty, multiply condVal1 accordingly
									if (! retItems.getFieldValueString(i,"QTY").equals(tempCompLineArray[tmpl].substring(8)) ) {
										java.math.BigDecimal itemQtyBD = (new  java.math.BigDecimal(retItems.getFieldValueString(i,"QTY")).setScale(2,java.math.BigDecimal.ROUND_HALF_UP));
										java.math.BigDecimal itemQtyCompBD = (new  java.math.BigDecimal(tempCompLineArray[tmpl].substring(7)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP));
										java.math.BigDecimal qtyMultipleBD = itemQtyCompBD.divide(itemQtyBD,3);
										condVal1BD = condVal1BD.multiply(qtyMultipleBD);			
									}	
									// convert current itemValue to BD and then add condVal1BD to it
									//out.println("itemValue>>condVal1BD::"+condVal1BD);
									
									java.math.BigDecimal itemValueBD = new java.math.BigDecimal(itemValue);
									
									itemValueBD = itemValueBD.add(condVal1BD);			

									// set to two digits after Decimal for US

									itemValue = itemValueBD.setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
								}
								catch(Exception e){}
								} // end of salesDocNo.equals(tempSONum1) && tempCompLineArray[tmpl].equals(condLineNo1)
							} // end of crec loop

							} // end of tmpl loop i.e for each component

						// SAP returned itemValue is ignored as per Sam's email on 7/27
						// Calculate Item Value to be displyed on UI as line sub total and to be added to UI subtotal at order level

						java.math.BigDecimal itemQty1 = (new  java.math.BigDecimal(retItems.getFieldValueString(i,"QTY")).setScale(2,java.math.BigDecimal.ROUND_HALF_UP));
						java.math.BigDecimal itemValueBD = new java.math.BigDecimal(itemValue);
						jobQuotePrice = itemValue;
						itemValueBD = itemValueBD.multiply(itemQty1);			
						itemValue = itemValueBD.setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();

						//out.println("Parent Item 2"+parentItem);
						} // if it HAS a child component
					}
				}
			}
			pricingCondTable = pricingCondTable+"</tbody></table>"; 

			for(int s=0;s<retSched.getRowCount();s++) 
			{
				String schdItmNo = retSched.getFieldValueString(s,"ITM_NUM");

				if(lineNo.equals(schdItmNo))
				{						

					schedLinesTable = schedLinesTable+"<tr><td>&nbsp;&nbsp;&nbsp;"+eliminateDecimals(retSched.getFieldValueString(s,"CONFIR_QTY"))+"</td><td >&nbsp;&nbsp;"+retSchedGl.getFieldValueString(s,"REQ_DATE")+"</td></tr>";

				}
			}

			schedLinesTable = schedLinesTable+"</tbody></table>"; 

			String tempLineNo = "";

			try
			{
				tempLineNo = (Long.parseLong(lineNo))+"";
			}
			catch(Exception e)
			{
				tempLineNo = lineNo;
			}

			try
			{
				totTax = totTax.add(new java.math.BigDecimal(itTax));
			}
			catch(Exception e){}

			try
			{
				if(price!=null && !"null".equals(price) && "0.00".equals(price.trim()))
				{
					double subtot = Double.parseDouble(retItems.getFieldValueString(i,"VALUE"));
					double subqty = Double.parseDouble(retItems.getFieldValueString(i,"QTY"));
					java.math.BigDecimal obj = new java.math.BigDecimal(subtot/subqty);
					price = obj.setScale(4,java.math.BigDecimal.ROUND_HALF_UP)+"";;	
				}
			}
			catch(Exception e){price ="0.00"; }

			try
			{
				matno=String.valueOf(Long.parseLong(matno)); 
			}
			catch(Exception e){}

			if(requireddate == null || "null".equals(requireddate) || requireddate.trim().length() >10) requireddate = "";
			totTax = totTax.setScale(2,java.math.BigDecimal.ROUND_HALF_UP);

			 reqQty = retItems.getFieldValueString(i,"QTY");

			if ((parentItem!= null) && (parentItem.equalsIgnoreCase("000000"))) 
			{
				 if (!flowHM.isEmpty() && flowHM.containsKey(tempLineNo)) 
				 {
					openQty= (String)flowHM.get(tempLineNo);		 			 

					try
					{
						totOpenQty = new java.math.BigDecimal(reqQty).subtract(new java.math.BigDecimal(openQty)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
						totOpenValue = new java.math.BigDecimal(totOpenQty).multiply(new java.math.BigDecimal(jobQuotePrice)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
						if("".equals(rejReason))						
							cumOpenValue = new java.math.BigDecimal(cumOpenValue).add(new java.math.BigDecimal(totOpenValue)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();

					}
					catch(Exception e){}
				 }
				 else
				 {		 
					 try
					 {
						totOpenQty = new java.math.BigDecimal(reqQty).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
						totOpenValue = new java.math.BigDecimal(totOpenQty).multiply(new java.math.BigDecimal(jobQuotePrice)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
						if("".equals(rejReason))						
							cumOpenValue = new java.math.BigDecimal(cumOpenValue).add(new java.math.BigDecimal(totOpenValue)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
					 }
					 catch(Exception e){}
				 }

				if("".equals(rejReason))
					cumSubTotal = new java.math.BigDecimal(cumSubTotal).add(new java.math.BigDecimal(itemValue.replaceAll(",",""))).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();

				quoteSplit=matno+"¥"+itemDesc+"¥"+jobQuotePrice+"¥"+eanUPC+"¥"+eliminateDecimals(totOpenQty)+"¥"+salesDoc+"¥"+lineNo;

				if(itemDesc!=null || !"null".equals(itemDesc) || !"".equals(itemDesc))
					itemDesc = itemDesc.replaceAll("££","&");
%>
				<input type="hidden" name="prodDesc_<%=i%>" value='<%=itemDesc%>'>
				<input type="hidden" name="prodCode_<%=i%>" value="<%=matno%>">
				<input type="hidden" name="listPrice_<%=i%>" value="<%=jobQuotePrice%>">
				<input type="hidden" name="eanUpc_<%=i%>" value="<%=eanUPC%>">
				<input type="hidden" name="qty_<%=i%>" value="<%=totOpenQty%>">
				<input type="hidden" name="lineNo_<%=i%>" value="<%=tempLineNo%>">
				<input type="hidden" name="quoteNo_<%=i%>" value="<%=salesDoc%>">
				<input type="hidden" name="quoteSplit_<%=i%>" value="<%=quoteSplit%>">
<%
				//Image and Brand of product
				String brand = "",dchstatus="",mainSTD="";				
				String listPriceOurDB = "0";
				EzcParams prodParamsMiscV = new EzcParams(false);
				EziMiscParams prodParamsV = new EziMiscParams();

				ReturnObjFromRetrieve prodDetailsRetObjV = null;

				prodParamsV.setIdenKey("MISC_SELECT");
				String queryV="SELECT EZP_BRAND,EZP_ATTR2,EZP_ATTR1,EZP_STATUS FROM EZC_PRODUCTS WHERE EZP_PRODUCT_CODE = '"+matno+"'";

				prodParamsV.setQuery(queryV);

				prodParamsMiscV.setLocalStore("Y");
				prodParamsMiscV.setObject(prodParamsV);
				Session.prepareParams(prodParamsMiscV);	

				try
				{
					prodDetailsRetObjV = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(prodParamsMiscV);
				}
				catch(Exception e){}


				String imgLink = "";


				if(prodDetailsRetObjV!=null && prodDetailsRetObjV.getRowCount()>0)
				{
					brand = nullCheck(prodDetailsRetObjV.getFieldValueString(0,"EZP_BRAND"));
					mainSTD   = nullCheck(prodDetailsRetObjV.getFieldValueString(0,"EZP_ATTR2"));
					dchstatus = nullCheck(prodDetailsRetObjV.getFieldValueString(0,"EZP_STATUS"));
				}
%>		
			<tr style="background-color:white" id="linedatarow">

<%
			String chkDisabled = "";
			if(!("0".equals(eliminateDecimals(totOpenQty))) && !eliminateDecimals(totOpenQty).startsWith("-") && 
			  ((!"E".equals(dstat)) && (!"C".equals(dstat)))
			  && (!"Z2".equals(dchstatus)) && (!"Z3".equals(dchstatus)) && (!"ZP".equals(dchstatus)) )//(!"ZM".equals(dchstatus)) && 
			{
				chkDisabled = "";
			} 
			else 
			{ 
				chkDisabled = "disabled";
			}
			if(!"".equals(rejReason))
				chkDisabled = "disabled";				
			if(Cart_C!=null && Cart_C.getRowCount()>0)
			{
				for(int h=0;h<Cart_C.getRowCount();h++)
				{
					String quoteNum_C  = Cart_C.getMfrPartNo(h);
					String quoteLine_C = Cart_C.getWeight(h);
					if(salesDocNo.equals(quoteNum_C) && lineNo.equals(quoteLine_C))
						chkDisabled = "disabled";
				}
			}
%>
		<td id="socell"><div style="display:none" id="quotelineinfo"><%=tempSalesDocNumber%>/<%=tempLineNo%><%="\n"%></div><br>
			<input type="hidden" name="childComponents<%=salesDocNo+""+lineNo%>" id="childComponents<%=salesDocNo+""+lineNo%>" value='<%=childComponents%>'>
			<input type="hidden" name="quoteSplit_<%=salesDocNo+""+lineNo%>" id="quoteSplit_<%=salesDocNo+""+lineNo%>" value='<%=quoteSplit%>'>
			<input type="hidden" name="chkDisabled_<%=salesDocNo+""+lineNo%>" id="chkDisabled_<%=salesDocNo+""+lineNo%>" value='<%=chkDisabled%>'>
<%
			if (!mainSTD.equals("N/A")) 
			{ 
%>
				<img  class="lazy" src="<%=mainSTD%>" data-original="<%=imgLink%>" width="100" height"160"  alt="" />
<%
			}
%>
			<p align="center"><%=brand%></p>
		</td>
		<td><%=tempSalesDocNumber%></td>
		<td><%=strikeTextStartTag%><%=tempLineNo%><%=strikeTextEndTag%></td>
		<td width=20%><%=strikeTextStartTag%><%=itemDesc%><br><a href="javascript:getProductDetails('<%=matno%>')" title='<%=itemDesc%>'>
		<p id="prodCode_<%=i%>"><%=matno%></p></a><%=strikeTextEndTag%></td>
		<td width=7% align="right"><%=strikeTextStartTag%><%=listPrice%><%=strikeTextEndTag%></td>
		<td width=8% align="right">
<%
		if(1 == 0)
		{
%>
			<div class="PRICE<%=tempLineNo%>">
			<a href="#PRICE<%=tempLineNo%>" class="fancybox"><span><%=jobQuotePrice%></span></a>
				</div>
				<div id="PRICE<%=tempLineNo%>" style="width: 400px; display: none;">
				<h2>Pricing Details</h2>
				<br>
				<table>
				<tr>
				<th><%=pricingCondTable%></th>
				</tr>
				</table>
			</div>
<%
		} 
		else
		{
%> 		
			<div class="PRICE<%=tempLineNo%>">
			<%=strikeTextStartTag%><span><%=checkAuth(jobQuotePrice,"VIEW_PRICES",userAuth_R)%></span><%=strikeTextEndTag%>
			</div>
<%
		}
%>
		</td>
		<td width=8% align="right"><%=strikeTextStartTag%><%=eliminateDecimals(retItems.getFieldValueString(i,"QTY"))%><%=strikeTextEndTag%></td>
		<td width=7% align="right"><%=strikeTextStartTag%><p id="qty_<%=i%>"><%=eliminateDecimals(totOpenQty)%></p><%=strikeTextEndTag%></td>
<% 
		NumberFormat nf = NumberFormat.getInstance(Locale.US);
		nf.setMinimumFractionDigits(2);
%>
		<td width=7% align="right"><%=strikeTextStartTag%><%=checkAuth(nf.format(new java.math.BigDecimal(totOpenValue).doubleValue()),"VIEW_PRICES",userAuth_R)%><%=strikeTextEndTag%></td>
		<td width=7% align="right"><%=strikeTextStartTag%><%=checkAuth(nf.format(new java.math.BigDecimal(itemValue).doubleValue()),"VIEW_PRICES",userAuth_R)%><%=strikeTextEndTag%></td>
		
<%		if(!"0".equals(eliminateDecimals(totOpenQty)) && !eliminateDecimals(totOpenQty).startsWith("-") && (!"E".equals(dstat)) && (!"C".equals(dstat))
		   && (!"Z2".equals(dchstatus)) && (!"Z3".equals(dchstatus)) && (!"ZP".equals(dchstatus)) && "".equals(rejReason))//(!"ZM".equals(dchstatus)) && 
		{
%>		
			<td width=5%>Open</td>
<%		}
		else
		{
			if ("E".equals(dstat)) 
			{
%>		
				<td width=5%>Quote<br>Expired&nbsp;</td>
<%			} else 
			{
				if (("Z2".equals(dchstatus)) || ("Z3".equals(dchstatus)) && "".equals(rejReason)) 
				{
%>
					<td width=5%>Discontinued<br>Product&nbsp;
<%		
				}
				else if ("ZM".equals(dchstatus) && "".equals(rejReason)) 
				{
%>
					<td width=5%>Modification<br>Contact Customer Care<br>for Ordering&nbsp;
<%
				}
				else if ("ZP".equals(dchstatus) && "".equals(rejReason)) 
				{
%>
					<td width=5%>Production Hold<br>ordering is impermissible&nbsp;
<%
				}
				else if(!"".equals(rejReason))
				{
%>
					<td width=5%>Rejected&nbsp;								
<%
				}
				else
				{
%>		
					<td width=5%>Closed&nbsp;

<%				} // else of DChstatus check 
			} // else of dstats == E
		} // dstate==E
%>
		<td id="pointsgroup"><%=cust_mat35%></td>
	</tr>
<%
			}
		}		
	} // end of while on Category Map
%>
	</tbody>
	<tfoot>
	<tr>
		<td colspan="9"><h3>Subtotals</h3></td>
		
		<td><%=checkAuth(NumberFormat.getCurrencyInstance(Locale.US).format(new java.math.BigDecimal(cumOpenValue).doubleValue()),"VIEW_PRICES",userAuth_R)%></td>
		<td><%=checkAuth(NumberFormat.getCurrencyInstance(Locale.US).format(new java.math.BigDecimal(cumSubTotal).doubleValue()),"VIEW_PRICES",userAuth_R)%></td>
		<td>&nbsp;</td>
	</tr>
	</tfoot>
	</table>

	</form>
	
</div> <!-- Info box -->
</div> <!-- col1-set -->
</div> <!-- col-main -->
</div> <!--main -->
</div> <!-- main-container col1-layout -->

<%!
	public String nullCheck(String str)
	{
		String ret = str;

		if(ret==null || "null".equalsIgnoreCase(ret) || "".equals(ret))
			ret = "N/A";
		return ret;
	}	
	public String checkAuth(String str,String authKey,ezc.record.util.EzOrderedDictionary userAuth_R)
	{
		String authMess = str;
		if(!userAuth_R.containsKey(authKey)){
			authMess = "Not Authorized";
		}
		return authMess;
	}

%>

<div id="ajaxAllATP" style="width:1000px;height:500px;display:none;overflow-x: hidden">
<div align=center  style="padding-top:100px;">
		<ul>
			<li>&nbsp;</li>
			<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
			<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
		</ul>
	</div>

</div>

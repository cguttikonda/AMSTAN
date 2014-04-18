<%@ include file="../../../Includes/JSPs/Sales/iEditSaveSales.jsp"%>
<%@ include file="../Misc/ezDBMethods.jsp"%>
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
		//ezc.record.util.EzOrderedDictionary userAuth_R = Session.getUserAuth();
		if(!userAuth_R.containsKey(authKey)){
			authMess = "Not Authorized";
		}
		return authMess;
	}
%>
<%
	String negotiateType = request.getParameter("negotiateType");
	String displayOrder = request.getParameter("displayOrder");
%>
<head>
<!-- jQuery for sorting & pagination STARTS here-->
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
	#negsolines_wrapper .fg-toolbar { font-size: 0.8em }
	#theme_links span { float: left; padding: 2px 10px; }
	#negsolines_wrapper { -webkit-box-shadow: 2px 2px 6px #666; box-shadow: 2px 2px 6px #666; border-radius: 5px; }
	#negsolines tbody {
		border-left: 1px solid #AAA;
		border-right: 1px solid #AAA;
	}
	#negsolines thead th:first-child { border-left: 1px solid #AAA; }
	#negsolines thead th:last-child { border-right: 1px solid #AAA; }
	#negsolines .inputBoxEven {
		box-shadow: inset 0px 0px 0px ; 
		-moz-box-shadow: inset 0px 0px 0px ; 
		-webkit-box-shadow: inset 0px 0px 0px ; 
		background-color: #f6f6f6 ;
		border: none; 
	}
	#negsolines .inputBoxOdd {
		box-shadow: inset 0px 0px 0px ; 
		-moz-box-shadow: inset 0px 0px 0px ; 
		-webkit-box-shadow: inset 0px 0px 0px ; 
		background-color: #ffffff ;
		border: none; 
	}
</style>

<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="../../Library/Script/complete.min.js"></script>
<script type="text/javascript" src="../../Library/Script/jquery.dataTables.min.js"></script> 
<script  src="../../Library/Script/colResizable-1.3.min.js"></script>
<script type="text/javascript" src="../../Library/Script/jquery-ui-1.8.21.all.min.js"></script>
<!-- fancy box popup instead of original from rb -->
<link rel="stylesheet" href="../../Library/Script/jquery.fancybox.css?v=2.0.5" type="text/css" media="screen" />
<script type="text/javascript" src="../../Library/Script/jquery.fancybox.pack.js?v=2.0.5"></script>
<!-- end of fancybox -->
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
.smallText {
	font-size: 10px;
	font-style: italic;
	color: #a0a0a0;
	text-transform: capitalize;
}
.ui-button-text-only .ui-button-text { padding: .4em 1em; color:white;}
</style>
<!-- en dof style for new header -->

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
	function wait(msecs)
	{
		
		var start = new Date().getTime();
		var cur = start
		while(cur - start < msecs)
		{
			cur = new Date().getTime();
		}              
	}
	
	/* Formating function for row details */
	function fnFormatDetails ( oTable, nTr , detailLines )
	{
		var aData = oTable.fnGetData( nTr ); // get the row 
		var sOut = '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">';
		//var soNum = aData[1].substring(0,aData[1].indexOf('/')); // Under Assumption that SO Num is first string in column 1 get it in soNum
		//var soNum = aData[1].substring(aData[1].indexOf('>')+1,aData[1].indexOf('/')); //SONum is in a hidden div tag, so take content after div tag
		var soLine = aData[1].substring(aData[1].indexOf('>')+1,aData[1].indexOf('</div>'));
		//console.log('In fnFormatDetails for Line ');
		//console.log(soLine);
		var ccompName = 'childComponents'+soLine+'';
		//console.log("ccompName::"+ccompName);
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
		console.log($.fn.jquery);
		/*
		 * Insert a 'details' column to the table
		 */
		var nCloneTd = document.createElement( 'td' );
		var nCloneTdEmpty = document.createElement( 'td' );

		$('#negsolines tbody tr').each( function () {
			//var vCol0 = $(this).find('#socell:first').text();
			var vCol0 = $(this).find('#solineinfo:first').text();
			//console.log(vCol0);

			if (vCol0 !="") {
				var soLine = vCol0;
				var ccompName = 'childComponents'+soLine+'';

				if ($(document.getElementById(ccompName)).val()!=""){
					//console.log("Inserting column with image");
					nCloneTd.innerHTML = '<img src="http://datatables.net/release-datatables/examples/examples_support/details_open.png" id="openimg" name="openimg">';
					this.insertBefore(  nCloneTd.cloneNode( true ), this.childNodes[0] );
				} else {
					//console.log("Inserting Empty Column");
					nCloneTdEmpty.innerHTML = '<p></p>';
					this.insertBefore(  nCloneTdEmpty.cloneNode( true ), this.childNodes[0] );
				};
			} // end vCol0
			else
			{
				var vPointsGroup = $(this).find('#pointsgroup').text();	
				//console.log(vPointsGroup);
				if (vPointsGroup != ""){
					nCloneTdEmpty.innerHTML = '<p></p>';
					this.insertBefore(  nCloneTdEmpty.cloneNode( true ), this.childNodes[0] );
					//console.log(" Inserted empty column in grouping row");
				}
			}// end else vCol0
		} );

		var oTable = $('#negsolines').dataTable( {

		"fnDrawCallback": function ( oSettings ) {
		if ( oSettings.aiDisplay.length == 0 )
		{
			return;
		}
		var nTrs = $('#negsolines tbody tr#linedatarow');
		var iColspan = nTrs[0].getElementsByTagName('td').length;
		var sLastGroup = "";
		for ( var i=0 ; i<nTrs.length ; i++ )
		{
			var iDisplayIndex = oSettings._iDisplayStart + i;
			//console.log("iDisplayIndex:::"+iDisplayIndex);
			var sGroup = oSettings.aoData[ oSettings.aiDisplay[iDisplayIndex] ]._aData[11];
			var sGroupPoint = oSettings.aoData[ oSettings.aiDisplay[iDisplayIndex] ]._aData[12];
			// THIS CODE ASSUMES THAT 9th Column carries the vendor catalog which is hidden info.
			// Also column 10 has the value of points
			console.log(sGroup);
			console.log(sGroupPoint);
			if ( sGroup != sLastGroup )
			{
				var nGroup = document.createElement( 'tr' );
				var nCell = document.createElement( 'td' );
				nCell.colSpan = iColspan;
				nCell.className = "group";
				nCell.innerHTML = sGroupPoint;
				nGroup.appendChild( nCell );
				nTrs[i].parentNode.insertBefore( nGroup, nTrs[i] );
				sLastGroup = sGroup;
			}
		}
        	} ,  	// end of fnDrawCallback
        	"bJQueryUI": true,
		"bSort" : true,
		"iDisplayLength": 100,
		"bPaginate":false,
		"oLanguage": { "sSearch": "Search PO Lines" } ,
		"aoColumnDefs": [
			{ "bSortable": false, "aTargets": [ 0,1,2,3,4,5,6,7,8,9 ] },
			{ "bVisible": false, "aTargets": [ 10 ] },
			{ "bVisible": false, "aTargets": [ 11 ] },
			{ "bVisible": false, "aTargets": [ 12 ] }
		]
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
		oTable.fnSortListener( document.getElementById('sorter'), 10 );
		oTable.fnSortListener( document.getElementById('sorter2'), 11 );
	});
</script>
<script type="text/javascript">
$(function(){

	var onSampleResized = function(e){
		var columns = $(e.currentTarget).find("th");
		var msg = "columns widths: ";
		columns.each()
	};

	$("#negsolines").colResizable({
		liveDrag:true,
		gripInnerHtml:"<div class='grip'></div>",
		draggingClass:"dragging",
		onResize:onSampleResized});

});
</script>
<!-- jQuery for sorting & pagination ENDS here -->
<script>
	$(document).ready(function() {
		$(".fancybox").fancybox({closeBtn:true}),

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
</script>
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
	  width:500px;
	  height:350px;
	  display:none;
	  z-index:9999;
	  padding:20px;
	}

	#boxes #dialog {
	  width:500px;
	  height:362px;
	  padding:10px;
	  background-color:#fff;
	}

	#input {
	box-shadow: inset 0px 0px 0px ; 
	-moz-box-shadow: inset 0px 0px 0px ; 
	-webkit-box-shadow: inset 0px 0px 0px ; 
	border: none; 
	}
</style>
</head>
<script>
function goBack()
{
	Popup.showModal('modal1');
	var sch = '<%=request.getParameter("fromPage")%>';
	if(sch=='Y')
		document.saveForm.action = "../Search/ezQuickSearchDetailsMain.jsp";
	else
		document.saveForm.action ="ezNegotiatedOrders.jsp?negotiateType=<%=negotiateType%>&ORDERTYPE=N&displayOrder=<%=displayOrder%>";
		
	document.saveForm.submit();

}
function withDraw()
{
	$("#dialog-withdraw").dialog('open');
}
$(function() {
	$( "#dialog-withdraw" ).dialog({
		autoOpen: false,
		resizable: true,
		height:150,
		width:400,
		modal: true,
		buttons: {
			"Ok": function() {
				$( this ).dialog( "close" );
				Popup.showModal('modal1');
				document.saveForm.action ="../Sales/ezWithDrawOrder.jsp";
				document.saveForm.submit(); 
			},
			"Cancel": function() {
				$( this ).dialog( "close" );
			}
		}
	});
});
function submitOrder(type,authChk)
{
	if(authChk=='FAIL')
	{
		$("#dialog-authCheck").dialog('open');
	}
	else
	{
		document.saveForm.status.value=type;
		$(document.getElementById("status")).val(type);
		var replyStat = document.saveForm.repFlag.value;
		//alert("replyStat:::::::"+replyStat)
		//alert("type:::::::"+type)

		if(type=='CART')
		{
			Popup.showModal('modal1');
			document.saveForm.action ="../ShoppingCart/ezAddCartSaveOrder.jsp";
			document.saveForm.submit();
		}
		else if(type=='TRANSFERED')
		{
			$("#dialog-transfer").dialog('open');
			//document.saveForm.action ="../Sales/ezEditSaveSales.jsp";
		}
		else if(type=='NEGOTIATED')
		{
			Popup.showModal('modal1');
			document.saveForm.action ="../Sales/ezEditSaveSales.jsp";
			document.saveForm.submit();
		}
		else if(type=='F' )
		{
			Popup.showModal('modal1');
			document.saveForm.action ="../Sales/ezAddSaveNegotiate.jsp";
			document.saveForm.submit();
		}

		if(type=='R' && replyStat=='Y')
		{
			Popup.showModal('modal1');
			document.saveForm.action ="../Sales/ezAddSaveNegotiate.jsp";
			document.saveForm.submit();
		}
		else if(type=='R' && replyStat=='N')
		{
			alert("Please Enter Rejection Reasons");
			return;
		}	

		if(type=='A' && replyStat=='Y')
		{
			Popup.showModal('modal1');
			document.saveForm.action ="../Sales/ezAddSaveNegotiate.jsp";
			document.saveForm.submit();
		}	
		else if(type=='A' && replyStat=='N')
		{
			alert("Please Reply to the query");
			return;
		}
	}
}
	$(function() {
		$( "#dialog-authCheck" ).dialog({
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
	}); // end of function()
	
	$(function() {
		$( "#dialog-transfer" ).dialog({
			autoOpen: false,
			resizable: true,
			height:150,
			width:400,
			modal: true,
			buttons: {
				"Ok": function() {
					$( this ).dialog( "close" );
					Popup.showModal('modal1');
					document.saveForm.action ="../Sales/ezEditSaveSales.jsp";
					document.saveForm.submit(); 
				},
				"Cancel": function() {
					$( this ).dialog( "close" );
				}
			}
		});
	});

function SaveValues(lineNO)
{
	var query    = document.getElementById("query"+lineNO).value
	var comments = document.getElementById("qComments"+lineNO).value
	//alert("lineNO::::::::"+lineNO+"::::::quesObj.value:::::::"+query+"::::comments:::::"+comments)
	if(comments=='')
	{
		alert("Please Enter Comments and Save")
		return;
	}
	if(query=='')
	{
		alert("Please Select Type")
		return;
	}
	document.getElementById("review1").style.display=""
	document.getElementById("review1_1").style.display=""
	document.getElementById("review_11").style.display="none"
	document.getElementById("review1_11").style.display="none"
	
	document.getElementById("ASK"+lineNO).style.display="none"
	document.getElementById("HIDE"+lineNO).style.display="block"
	
	var qObj 	= eval("document.saveForm.qType"+lineNO)
	var quesObj     = eval("document.saveForm.QComments"+lineNO)
	qObj.value	= query
	quesObj.value	= comments
	//alert("qObj.value::::::::"+qObj.value+"::::::quesObj.value:::::::"+quesObj.value)
	document.saveForm.repFlag.value='Y'

	var comLen = comments.length;
	if(comLen>70)
		comments = comments.substring(0,60)+"....";

	document.getElementById("HIDE"+lineNO).innerHTML = comments;

	event.preventDefault();
	parent.$.fancybox.close();  
	$('saveForm').submit();	
}
function reply(lineNO)
{
	var reply 	= document.getElementById("reply"+lineNO).value
	reply = reply.replace("'","`")
	//alert("reply:::::::"+reply)
	if(reply=='')
	{
		alert("Please Enter Comments and Save")
		return;
	}
	else
	{
		eval("document.saveForm.QComments"+lineNO).value = reply
		document.saveForm.repFlag.value='Y'
	}
	var repLen = reply.length;
	if(repLen>70)
		reply = reply.substring(0,60)+"....";

	document.getElementById("REPLY"+lineNO).innerHTML = reply;

	//event.preventDefault();
	event.returnValue = false;
	parent.$.fancybox.close();  
	$('saveForm').submit();
}
function clearText(lineNO)
{
	document.getElementById("reply"+lineNO).value = "";
	eval("document.saveForm.QComments"+lineNO).value = "";
	document.saveForm.repFlag.value='N';
	var qCom = document.getElementById("qComnts_"+lineNO).value;
	document.getElementById("REPLY"+lineNO).innerHTML = qCom;
}
function closeDialog()
{
	//event.preventDefault();
	event.returnValue = false;
	parent.$.fancybox.close();  
	$('saveForm').submit();
}

var xmlhttpA

function auditTrail()
{
	xmlhttpA=GetXmlHttpObjectA();
	var webOrNo = document.saveForm.webOrNo.value;

	if(xmlhttpA==null)
	{
		alert ("Your browser does not support Ajax HTTP");
		return;
	}

	var url = "../Misc/ezWFAuditTrailList.jsp";
	url=url+"?webOrNo="+webOrNo;

	xmlhttpA.onreadystatechange=getOutputA;
	xmlhttpA.open("GET",url,true);
	xmlhttpA.send(null);
}
function getOutputA()
{
	if(xmlhttpA.readyState==4)
	{
		document.getElementById("auditId").innerHTML=xmlhttpA.responseText;
	}
}
function GetXmlHttpObjectA()
{
	if(window.XMLHttpRequest)
	{
		return new XMLHttpRequest();
	}
	if(window.ActiveXObject)
	{
		return new ActiveXObject("Microsoft.XMLHTTP");
	}
	
	return null;
}
function calNetPrice(ind,multVal)
{
	var len    = $('.productForLen').length;//$(document.getElementById("product")).length; //document.saveForm.product.length;

	//console.log(" In calNetPrice with len = "+len);
	//console.log($(document.getElementById("netPrice_"+ind)).val());
	//console.log($(document.getElementById("totQty_"+ind)).val());
	//console.log($(document.getElementById("netPriceHid_"+ind)).val());
	
	var netVal = $(document.getElementById("netPrice_"+ind)).val();
	var qtyVal = $(document.getElementById("totQty_"+ind)).val();
	var netHVal = $(document.getElementById("netPriceHid_"+ind)).val();

	
	//var netVal = eval("document.saveForm.netPrice_"+ind).value;
	//var qtyVal = eval("document.saveForm.totQty_"+ind).value;
	//var netHVal = eval("document.saveForm.netPriceHid_"+ind).value;

	//var shipHandVal = document.saveForm.shipHandHid.value;
	var shipHandVal = $(document.getElementById("shipHandHid")).val();
	

	var subVal = (parseFloat(qtyVal)*parseFloat(netVal)).toFixed(2);
	if(isNaN(subVal)) subVal = "";
	
	var grandTotal = subVal;

	if(!isNaN(len))
	{
		//console.log("Here with len as "+len);
		grandTotal = 0;
		for(i=0;i<len;i++)
		{
			//var lNo = document.saveForm.lineItem[i].value;
			var lNo = "";

			if(len==1)
				lNo = document.saveForm.lineItem.value;
			else
				lNo = document.saveForm.lineItem[i].value;

			//var lNo = (i+1)*10;//$(document.getElementById("lineItem["+i+"]")).val();
			//console.log("LNo is "+lNo);
			grandTotal += (parseFloat($(document.getElementById("netPrice_"+lNo)).val())*parseFloat($(document.getElementById("totQty_"+lNo)).val()));
		}
	}

	grandTotal = parseFloat(grandTotal).toFixed(2);
	if(isNaN(grandTotal)) grandTotal = "";

	var finalTotal = (parseFloat(grandTotal)+parseFloat(shipHandVal)).toFixed(2);
	if(isNaN(finalTotal)) finalTotal = "";

	var sMulti = ((parseFloat(netVal))/(parseFloat($(document.getElementById("itemListPrice_"+ind)).val())));

	if(isNaN(sMulti))
		sMulti = "";
	else
		sMulti = parseFloat(sMulti).toFixed(2);

	if(multVal=='DEF')
		$(document.getElementById("stdMulti_"+ind)).val('DEF');
	else
		$(document.getElementById("stdMulti_"+ind)).val(sMulti);
	//eval("document.saveForm.stdMulti_"+ind).value = sMulti;

	var iFlag = $(document.getElementById("itemFlag_"+ind)).val(); //eval("document.saveForm.itemFlag_"+ind).value;
	//sMulti = eval("document.saveForm.stdMulti_"+ind).value;

	var defVal = $(document.getElementById("defMultiVal_"+ind)).val();// eval("document.saveForm.defMultiVal_"+ind).value;

	if(parseFloat(netVal)!=parseFloat(netHVal))
	{
		if(iFlag=='VIP')
		{
			if(sMulti!='0.35' && sMulti!=defVal)
			{
				document.getElementById("stdMultiDivHid_"+ind).innerHTML=sMulti;
				$(document.getElementById("stdMultiDivHid_"+ind)).html(sMulti);//document.getElementById("stdMultiDivHid_"+ind).innerHTML=sMulti;
				document.getElementById("stdMultiDiv_"+ind).style.display="none";
				document.getElementById("stdMultiDivHid_"+ind).style.display="block";
			}
			else
			{
				$(document.getElementById("stdMultiDivHid_"+ind)).html("");//document.getElementById("stdMultiDivHid_"+ind).innerHTML="";
				document.getElementById("stdMultiDivHid_"+ind).style.display="none";
				document.getElementById("stdMultiDiv_"+ind).style.display="block";
			}
		}
		else if(iFlag=='DISP')
		{
			if(sMulti!='0.35' && sMulti!='0.25' && sMulti!='0.23' && sMulti!='0.10' && sMulti!=defVal)
			{
				$(document.getElementById("stdMultiDivHid_"+ind)).html(sMulti);//document.getElementById("stdMultiDivHid_"+ind).innerHTML=sMulti;
				document.getElementById("stdMultiDiv_"+ind).style.display="none";
				document.getElementById("stdMultiDivHid_"+ind).style.display="block";
			}
			else
			{
				$(document.getElementById("stdMultiDivHid_"+ind)).html("");//document.getElementById("stdMultiDivHid_"+ind).innerHTML="";
				document.getElementById("stdMultiDivHid_"+ind).style.display="none";
				document.getElementById("stdMultiDiv_"+ind).style.display="block";
			}
		}
	}
	else
	{
		$(document.getElementById("stdMultiDivHid_"+ind)).html("");//document.getElementById("stdMultiDivHid_"+ind).innerHTML="";
		document.getElementById("stdMultiDivHid_"+ind).style.display="none";
		document.getElementById("stdMultiDiv_"+ind).style.display="block";
	}
	//console.log("Sub Val in calNetprice is "+subVal);
	$(document.getElementById("subTotalItem_"+ind)).html("$"+subVal);//document.getElementById("subTotalItem_"+ind).innerHTML=subVal;
	$(document.getElementById("subTotalAll")).html(grandTotal);//document.getElementById("subTotalAll").innerHTML=grandTotal;
	$(document.getElementById("grandTotalAll")).html(finalTotal);//document.getElementById("grandTotalAll").innerHTML=finalTotal;
}
function calMulti(multiObj,ind)
{
	var multVal = multiObj.value;
	var lpVar = "itemListPrice_"+ind+"";
	var lP = $(document.getElementById(lpVar)).val();
	var npVar = "netPrice_"+ind+"";
	var nP = $(document.getElementById(npVar)).val();
	var npHiddenVar = "netPriceHid_"+ind+"";
	var nPHid = $(document.getElementById(npHiddenVar)).val();
	if(multVal!='DEF')
	{
		//var netVal = (parseFloat(eval("document.saveForm.itemListPrice_"+ind).value)*parseFloat(multVal)).toFixed(2);
		var netVal = (parseFloat(lP)*parseFloat(multVal)).toFixed(2);

		if(netVal!='')
		{
			//eval("document.saveForm.netPrice_"+ind).value = netVal;
			$(document.getElementById(npVar)).val(netVal);
			//console.log("Net Price is now "+$(document.getElementById(npVar)).val());
			calNetPrice(ind,multVal);
			actButton();
		}
	}
	else if(multVal=='DEF')
	{
		//var netVal = eval("document.saveForm.netPriceHid_"+ind).value;
		var netVal = nPHid;

		//eval("document.saveForm.netPrice_"+ind).value = netVal;
		$(document.getElementById(npVar)).val(netVal);
		calNetPrice(ind,multVal);
		actButton();
	}
}
function actButton()
{
	var len = $('.productForLen').length;
	var y = true;
	if(!isNaN(len))
	{
		for(i=0;i<len;i++)
		{
			//var lNo = document.saveForm.lineItem[i].value;
			var lNo = "";

			if(len==1)
				lNo = document.saveForm.lineItem.value;
			else
				lNo = document.saveForm.lineItem[i].value;


			var stdVal = $(document.getElementById("stdMulti_"+lNo)).val();

			if(stdVal=='DEF')
				y = false;
		}
	}
	else
	{
		var stdVal = $(document.getElementById("stdMulti_10")).val();

		if(stdVal=='DEF')
			y = false;
	}
	if(eval(y))
	{
		document.getElementById("review_11").style.display="block";
		document.getElementById("review1_11").style.display="block";
	}
	else
	{
		document.getElementById("review_11").style.display="none";
		document.getElementById("review1_11").style.display="none";
	}
}
function resetPrice(ind)
{
	var netHVal = $(document.getElementById("netPriceHid_"+ind)).val();//eval("document.saveForm.netPriceHid_"+ind).value;
	$(document.getElementById("netPrice_"+ind)).val(netHVal);//eval("document.saveForm.netPrice_"+ind).value = netHVal;

	var obj = $('#stdMulti_'+ind+' option');//eval("document.saveForm.stdMulti_"+ind).options;
	//alert( $('#stdMulti_'+ind+' option').length );
	var defVal = $(document.getElementById("defMultiVal_"+ind)).val();//eval("document.saveForm.defMultiVal_"+ind).value;
	//alert (defVal);
	for(j=0;j<obj.length;j++)
	{
		if(obj[j].value=='DEF')
			obj[j].selected = true
	}

	calNetPrice(ind,'DEF');
	actButton();
}
function selStdMulti()
{
	var len    = $('.productForLen').length;//$(document.getElementById("product")).length;//document.saveForm.product.length;
	//var lenNew = $('.productForLen').length;
	console.log(" In selStdMulti with nr of products "+len);
	//console.log($('.lineItemId'));
	if(!isNaN(len))
	{
		for(i=0;i<len;i++)
		{
			var lNo = "";//(i+1)*10;//

			if(len==1)
				lNo = document.saveForm.lineItem.value;
			else
				lNo = document.saveForm.lineItem[i].value;

			var obj = $('#stdMulti_'+lNo+' option');//eval("document.saveForm.stdMulti_"+lNo).options;
			var defVal = $(document.getElementById("defMultiVal_"+lNo)).val();//eval("document.saveForm.defMultiVal_"+lNo).value;

			for(j=0;j<obj.length;j++)
			{
				if(obj[j].value==defVal)
					obj[j].selected = true
			}
		}
	}
	else
	{
		var obj = $('#stdMulti_10'+' option');//eval("document.saveForm.stdMulti_10").options;
		var defVal = $(document.getElementById("defMultiVal_10")).val();//eval("document.saveForm.defMultiVal_10").value;

		for(j=0;j<obj.length;j++)
		{
			if(obj[j].value==defVal)
				obj[j].selected = true
		}
	}
}
function RejectOrder(type,authChk)
{
	if(authChk=='FAIL')
	{
		$("#dialog-authCheck").dialog('open');
	}
	else
	{
		document.saveForm.status.value=type;
		$(document.getElementById("status")).val(type);
		var rejCom = document.getElementById("rejectComments").value.trim();
		$(document.getElementById("rejComments")).val(rejCom);
		if(rejCom=='')
		{
			alert("Please Enter Comments and Submit");
			return;
		}
		else
		{
			//event.preventDefault();
			parent.$.fancybox.close();  
			$('saveForm').submit();

			Popup.showModal('modal1');
			document.saveForm.action ="../Sales/ezAddSaveNegotiate.jsp";
			document.saveForm.submit();
			return false;
		}
	}
}
function openFileAttach(count)
{
	var openFile = $(document.getElementById("fileName_"+count)).val();
	var fVal = openFile.split('*')

	var sFile="";
	for(var i=0;i<fVal.length;i++)
	{
		sFile = sFile+fVal[i]+"/"
	}
	sFile = sFile.substring(0,sFile.length-1)

	document.saveForm.action = "../UploadFiles/ezViewOrSaveDBFile.jsp?fileName="+sFile;
	document.saveForm.target="_blank";
	document.saveForm.submit();
}
function getProductDetails(code)
{
	document.saveForm.prodCode_D.value=code;

	document.saveForm.action="../Catalog/ezProductDetails.jsp";
	document.saveForm.target="_blank";
	document.saveForm.submit();
}
</script>

<%
	int sdHeaderCnt = 0;
		
	String soldToAddress = "";
	String shipToAddress = "";
	String billToAddress = "";
	
	
	Vector types = new Vector();
	Vector names = new Vector();
	types.addElement("date");
	types.addElement("date");
	types.addElement("date");
	names.addElement("PURCH_DATE");
	names.addElement("REQ_DATE");
	names.addElement("ORDER_DATE");
	
	EzGlobal.setColTypes(types);
	EzGlobal.setColNames(names);
	
	ezc.ezparam.ReturnObjFromRetrieve ret = EzGlobal.getGlobal(sdHeader);
	
	Vector types1= new Vector();
	Vector names1= new Vector();
	types1.addElement("date");
	names1.addElement("REQ_DATE");

	EzGlobal.setColTypes(types1);
	EzGlobal.setColNames(names1);
			
	//out.println("sdHeader::::::::::::::::"+sdHeader.toEzcString());
	
	String poNo 	 	= sdHeader.getFieldValueString(0,"PO_NO");
	String modBy 	 	= sdHeader.getFieldValueString(0,"MOD_ID");
	String modifiedOn	= ret.getFieldValueString(0,"ORDER_DATE");
	String webOrderNo	= sdHeader.getFieldValueString(0,"WEB_ORNO"); 
	String createdBy 	= sdHeader.getFieldValueString(0,"CREATE_USERID");
	String poDate	 	= ret.getFieldValueString(0,"PURCH_DATE");
	String reqDate 	 	= ret.getFieldValueString(0,"REQ_DATE");
	String complDlv	 	= sdHeader.getFieldValueString(0,"DLVFLAG");
	String comments 	= sdHeader.getFieldValueString(0,"TEXT2");
	String sys_key	 	= sdHeader.getFieldValueString(0,"SALES_AREA");
	String requestedBy 	= getUserName(Session,createdBy);
	String modBys	 	= getUserName(Session,modBy);
	String reqDat		= "";

	/*String statMsg	= sdHeader.getFieldValueString(0,"STATUS");
	statMsg = statMsg.trim();*/
	
	//out.println("headerTxt::::::::::::::::"+headerTxt);
	if("Y".equals(complDlv))complDlv="on";
	String shipPartnRole = "";
		
	String formatkey_S = (String)session.getValue("formatKey");
	FormatDate fD = new FormatDate();

	java.util.Date statusDate = (java.util.Date)sdHeader.getFieldValue(0,"STATUS_DATE");
	
	String spShipIns	= sdHeader.getFieldValueString(0,"TEXT3");
	String freightType	= sdHeader.getFieldValueString(0,"FREIGHT");
	String Currency		= sdHeader.getFieldValueString(0,"DOC_CURRENCY");
	String promoCode	= sdHeader.getFieldValueString(0,"HEADER_PROMO_CODE");
	String frieghtTotal 	= sdHeader.getFieldValueString(0,"FREIGHT_PRICE");

	//Sold to Address
	
	String soldTo_S		= sdHeader.getFieldValueString(0,"AGENT_CODE");
	String soldName		= sdSoldTo.getFieldValueString(0,"SOTO_NAME");
	String soldStreet	= sdSoldTo.getFieldValueString(0,"SOTO_ADDR1");
	String soldCity		= sdSoldTo.getFieldValueString(0,"SOTO_ADDR2");
	String soldState	= sdSoldTo.getFieldValueString(0,"SOTO_STATE");
	String soldCountry	= sdSoldTo.getFieldValueString(0,"SOTO_COUNTRY");
	String soldZip		= sdSoldTo.getFieldValueString(0,"SOTO_ZIPCODE");
	String soldToPhNum	= sdSoldTo.getFieldValueString(0,"SOTO_PHONE");
	
	if(soldName!=null && !"null".equals(soldName) && !"".equals(soldName.trim()))
		soldToAddress = soldToAddress + soldName +"<br>";
	if(soldStreet!=null && !"null".equals(soldStreet) && !"".equals(soldStreet.trim()))
		soldToAddress = soldToAddress + soldStreet +"<br>";
	if(soldCity!=null && !"null".equals(soldCity) && !"".equals(soldCity.trim()))
		soldToAddress = soldToAddress + soldCity +", ";
	if(soldZip!=null && !"null".equals(soldZip) && !"".equals(soldZip.trim()))
		soldToAddress = soldToAddress + soldZip +"<br>";
	if(soldState!=null && !"null".equals(soldState) && !"".equals(soldState.trim()))
		soldToAddress = soldToAddress + soldState +"<br>";
	if(soldCountry!=null && !"null".equals(soldCountry) && !"".equals(soldCountry.trim()))
		soldToAddress = soldToAddress + soldCountry +"<br>";
	if(soldToPhNum!=null && !"null".equals(soldToPhNum) && !"".equals(soldToPhNum.trim()))
		soldToAddress = soldToAddress + "Tel#:" +soldToPhNum +"<br>";
	
	
	//Ship to Address
	
	String shipTo_S		= sdShipTo.getFieldValueString(0,"SHIP_TO_CODE");
	String shipName		= sdShipTo.getFieldValueString(0,"SHTO_NAME");
	String shipStreet	= sdShipTo.getFieldValueString(0,"SHTO_ADDR1");
	String shipCity		= sdShipTo.getFieldValueString(0,"SHTO_ADDR2");
	String shipState	= sdShipTo.getFieldValueString(0,"SHTO_STATE");
	String shipCountry	= sdShipTo.getFieldValueString(0,"SHTO_COUNTRY");
	String shipZip		= sdShipTo.getFieldValueString(0,"SHTO_ZIPCODE");
	String shipToPhNum	= sdShipTo.getFieldValueString(0,"SHTO_PHONE");
	
	if(shipTo_S!=null && !"null".equals(shipTo_S) && !"".equals(shipTo_S.trim()))
		shipToAddress = shipToAddress + shipTo_S +"<br>";
	if(shipName!=null && !"null".equals(shipName) && !"".equals(shipName.trim()))
		shipToAddress = shipToAddress + shipName +"<br>";
	if(shipStreet!=null && !"null".equals(shipStreet) && !"".equals(shipStreet.trim()))
		shipToAddress = shipToAddress + shipStreet +"<br>";
	if(shipCity!=null && !"null".equals(shipCity) && !"".equals(shipCity.trim()))
		shipToAddress = shipToAddress + shipCity +", ";
	if(shipZip!=null && !"null".equals(shipZip) && !"".equals(shipZip.trim()))
		shipToAddress = shipToAddress + shipZip +" ";
	if(shipState!=null && !"null".equals(shipState) && !"".equals(shipState.trim()))
		shipToAddress = shipToAddress + shipState +" ";
	if(shipCountry!=null && !"null".equals(shipCountry) && !"".equals(shipCountry.trim()))
		shipToAddress = shipToAddress + shipCountry +"<br>";
	if(shipToPhNum!=null && !"null".equals(shipToPhNum) && !"".equals(shipToPhNum.trim()))
		shipToAddress = shipToAddress + "Tel#:" +shipToPhNum +"<br>";
	
	if(shipName==null || "null".equalsIgnoreCase(shipName)) shipName = "";
	if(shipStreet==null || "null".equalsIgnoreCase(shipStreet)) shipStreet = "";
	if(shipCity==null || "null".equalsIgnoreCase(shipCity)) shipCity = "";
	if(shipZip==null || "null".equalsIgnoreCase(shipZip)) shipZip = "";
	if(shipState==null || "null".equalsIgnoreCase(shipState)) shipState = "";
	if(shipCountry==null || "null".equalsIgnoreCase(shipCountry)) shipCountry = "";

	String dropShipTo = "NO";

	if(shipTo_S.endsWith("9999")) dropShipTo = "YES";

	//Bill To Address
	
	String billToName	= sdHeader.getFieldValueString(0,"BILLTO_NAME");
	String billToAddr1	= sdHeader.getFieldValueString(0,"BILLTO_ADDR1");
	String billToAddr2	= sdHeader.getFieldValueString(0,"BILLTO_ADDR2");
	String billToStreet	= sdHeader.getFieldValueString(0,"BILLTO_STREET");
	String billToCity	= sdHeader.getFieldValueString(0,"BILLTO_CITY");
	String billToState	= sdHeader.getFieldValueString(0,"BILLTO_STATE");
	String billToPHNO	= sdHeader.getFieldValueString(0,"BILLTO_PHONE");
	String billToZipCode	= sdHeader.getFieldValueString(0,"BILLTO_PIN");
	
	String carrierName 	= sdHeader.getFieldValueString(0,"SHIPPING_METHOD");
	String carrierId 	= sdHeader.getFieldValueString(0,"CARRIER_ACC");
	String dvToAct	 	= sdHeader.getFieldValueString(0,"TO_ACT");
	String dvActBy	 	= sdHeader.getFieldValueString(0,"ACT_BY");

	if(carrierName==null || "null".equalsIgnoreCase(carrierName)) carrierName = "";
	if(carrierId==null || "null".equalsIgnoreCase(carrierId)) carrierId = "";
	if(billToName==null || "null".equalsIgnoreCase(billToName)) billToName = "";
	if(billToAddr1==null || "null".equalsIgnoreCase(billToAddr1)) billToAddr1 = "";
	if(billToAddr2==null || "null".equalsIgnoreCase(billToAddr2)) billToAddr2 = "";
	if(billToStreet==null || "null".equalsIgnoreCase(billToStreet)) billToStreet = "";
	if(billToCity==null || "null".equalsIgnoreCase(billToCity)) billToCity = "";
	if(billToState==null || "null".equalsIgnoreCase(billToState)) billToState = "";
	if(billToZipCode==null || "null".equalsIgnoreCase(billToZipCode)) billToZipCode = "";
	if(dvActBy==null || "null".equalsIgnoreCase(dvActBy)) dvActBy = "";
	if("".equals(frieghtTotal.trim())) frieghtTotal = "0";

	String dvActBy_S = dvActBy;

	if(!"CU".equals(userRole) && "CUST".equals(dvActBy)) dvActBy_S = "APPR";

	String complDlv_C	= sdHeader.getFieldValueString(0,"DLVFLAG"); //ESDH_COMPL_DLV needed to be added in query
	//billToAddress = billToName+","+","+billToAddr1+","+billToAddr1+billToStreet+","+billToCity+","+billToState+","+billToZipCode;
	String dlvCheck 	= "";
	if("Y".equals(complDlv_C)) dlvCheck="checked";
	
	/*session.putValue("PODATE_PREP",poDate);

	session.putValue("SOLDTO_PREP",soldTo_S);
	session.putValue("COMMENTS_PREP",comments);

	session.putValue("SHIPCOMP_PREP",complDlv);
	session.putValue("SHIPMETHOD_PREP",carrierName);
	session.putValue("DESDATE_PREP",reqDate);
	session.putValue("CARRNAME_PREP",carrierName);
	session.putValue("CARRID_PREP",carrierId);
	session.putValue("BNAME_PREP",billToName);
	session.putValue("BSTREET_PREP",billToStreet);
	session.putValue("BCITY_PREP",billToCity);
	session.putValue("BSTATE_PREP",billToState);
	session.putValue("BZIPCODE_PREP",billToZipCode);

	session.putValue("SHIPTO_PREP",shipTo);*/	
	
	//Contact details

	String conDetails 	= sdHeader.getFieldValueString(0,"TEXT1");
	String remarks	 	= sdHeader.getFieldValueString(0,"TEXT2");

	String shAttn	= "";
	String shPhone1	= "";
	String shPhone2	= "";
	String shFax	= "";
	
	try
	{
		StringTokenizer conDetails_ST = new StringTokenizer(conDetails,"¥");
		
		shAttn 	 = conDetails_ST.nextToken();
		shPhone1 = conDetails_ST.nextToken();
		shPhone2 = conDetails_ST.nextToken();
		shFax	 = conDetails_ST.nextToken();
	}
	catch(Exception e){}
	
	if("N/A".equals(shAttn)) shAttn = "";
	if("N/A".equals(shPhone1)) shPhone1 = "";
	if("N/A".equals(shPhone2)) shPhone2 = "";
	if("N/A".equals(shFax)) shFax = "";
	String WEB_ORNO = (retLines.getFieldValueString(0,"WEB_ORNO")).trim();
	EzcParams mainParamsNeg= new EzcParams(false);
	EziMiscParams miscParamsNeg = new EziMiscParams();

	
	boolean editNegDtl = false;
	boolean editNegDtl1 = false;		
			
	/*********** Negotiation Details Start******/
		
		Hashtable quesHash = null;
		Hashtable ansHash  = null;
		Hashtable noQHash  = null;	
		ArrayList replSpList = null;
		mainParamsNeg= new EzcParams(false);
		miscParamsNeg = new EziMiscParams();
		boolean dispBool = false;
		String modiBy	 = "";
		String currId	 = Session.getUserId();		

		ReturnObjFromRetrieve retNegOrderDtl = null;		
		miscParamsNeg.setIdenKey("MISC_SELECT");
		miscParamsNeg.setQuery("SELECT * FROM EZC_ORDER_NEGOTIATE WHERE EON_ORDER_NO = '"+WEB_ORNO+"' ORDER BY EON_CREATED_ON DESC");

		mainParamsNeg.setLocalStore("Y");
		mainParamsNeg.setObject(miscParamsNeg);
		Session.prepareParams(mainParamsNeg);	

		try
		{		
			ezc.ezcommon.EzLog4j.log("miscParams.getQuery()::::::::"+miscParams.getQuery() ,"I");
			retNegOrderDtl = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsNeg);
		}
		catch(Exception e)
		{
			out.println("Exception in Getting Data"+e);
		}
		if(retNegOrderDtl!=null && retNegOrderDtl.getRowCount()>0)
		{
			String negItemNO = "";
			String negIndex	 = "";
			String negQType	 = "";
			String negQCat	 = "";
			String negText	 = "";
			String negCat	 = "";
			String negCreatedBy = "";
			String createdOn = "";
			quesHash = new Hashtable();
			ansHash  = new Hashtable();
			noQHash  = new Hashtable();
			replSpList=new ArrayList();
			Vector tempVec	   = new Vector();
			int negDtlCnt	   = retNegOrderDtl.getRowCount();
			int naCnt = 0;
			
			types = new Vector();
			names = new Vector();
			
			types.addElement("date");
			names.addElement("EON_CREATED_ON");
			
			EzGlobal.setColTypes(types);
			EzGlobal.setColNames(names);
			ezc.ezparam.ReturnObjFromRetrieve retNegDate = EzGlobal.getGlobal(retNegOrderDtl);
			for(int n=0;n<negDtlCnt;n++)
			{
				negItemNO	= retNegOrderDtl.getFieldValueString(n,"EON_ITEM_NO");
				negIndex	= retNegOrderDtl.getFieldValueString(n,"EON_INDEX_NO");
				negQType	= retNegOrderDtl.getFieldValueString(n,"EON_TYPE");
				negText		= retNegOrderDtl.getFieldValueString(n,"EON_TEXT");
				negCat		= retNegOrderDtl.getFieldValueString(n,"EON_QUESTION_TYPE");
				negCreatedBy	= retNegOrderDtl.getFieldValueString(n,"EON_CREATED_BY");
				createdOn	= retNegDate.getFieldValueString(n,"EON_CREATED_ON");
				String tempIndex= negItemNO+""+negIndex;
				modiBy 		= retNegOrderDtl.getFieldValueString(0,"EON_MODIFIED_BY");

				if("N/A".equals(negCat))
					naCnt++;
				
				if("Q".equals(negQType)) 
				{
					//if(!("N/A".equals(negCat)))
					{
						quesHash.put(negItemNO+""+negIndex,negText+"##"+negCat+"##"+negCreatedBy+"##"+createdOn+"##"+negIndex);
					
						if((tempVec.contains(negItemNO)))
							noQHash.put(negItemNO,tempIndex+"#"+noQHash.get(negItemNO));
						else
						{
							tempVec.add(negItemNO);
							noQHash.put(negItemNO,tempIndex);
						}
					}
					
					ezc.ezcommon.EzLog4j.log("noQHash::::::::"+noQHash ,"I");
						
				}	
				if("A".equals(negQType) )
					ansHash.put(negItemNO+""+negIndex,negText+"##"+negCat+"##"+modiBy+"##"+createdOn+"##"+negIndex);
					
			}
			if(negDtlCnt==naCnt)
				replSpList.add(WEB_ORNO);

			ezc.ezcommon.EzLog4j.log("quesHash::::::::"+quesHash.size() ,"I");
			ezc.ezcommon.EzLog4j.log("noQHash::::out LOOP::::"+noQHash ,"I");
			ezc.ezcommon.EzLog4j.log("dispBool::::out LOOP::::"+dispBool ,"I");
			ezc.ezcommon.EzLog4j.log("replSpList::::::::"+replSpList ,"I");
			ezc.ezcommon.EzLog4j.log("ansHash::::::::"+ansHash.size() ,"I");
		
		}
		
		if("CU".equals(userRole.trim()) && (quesHash.size())==(ansHash.size()) )
			editNegDtl = true;
		else if(!"CU".equals(userRole.trim()) && ((quesHash.size())!=(ansHash.size())) )
			editNegDtl1 = true;	

		/*String statMsg="ORDER IS PENDING FOR APPROVAL";
		if(!editNegDtl && "CU".equals(userRole.trim()))
			statMsg = "Order is with American Standard for pending Approval . Please contact Customer Care if you have follow on questions.";
		if("CLOSED".equals(negotiateType))
			statMsg="Closed";*/
		
		String statMsg="";			
		if("CU".equals(userRole) && "INPROCESS".equals(negotiateType))
			statMsg = "Order is with American Standard for pending Approval . Please contact Customer Care if you have follow on questions.";
		if(!"CU".equals(userRole) && "INPROCESS".equals(negotiateType))
			statMsg="Order is pending for approval";
			
		if("CU".equals(userRole) && "ACCEPTED".equals(negotiateType))
			statMsg = "Action has been taken by ASB";
		if(!"CU".equals(userRole) && "ACCEPTED".equals(negotiateType))
			statMsg="Action has been taken";
			
		if("CLOSED".equals(negotiateType))
			statMsg="Closed";
			
	/*********** Negotiation Details End******/

	//out.println("userRole::::::::::::::::::::"+userRole);	

%>
<body>
<form name="saveForm" method='post'>
<div id="dialog-authCheck" title="No Authorization" style="display:none">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>You are not authorized to perform this action.<br>Please contact Administrator requesting Authorization Key.</p>
</div>
<div id="modal1" style="border:0px solid black; background-color:white; padding:1px; font-size:10;width:40%;height:180px; text-align:center; display:none;">
	<ul>
		<li>&nbsp;</li>
		<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
		<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
	</ul>
</div>
<div class="main-container col2-left-layout middle account-pages">
<div class="main">
<div class="col-main1 roundedCorners">
<div class="page-title">
	<div class="highlight" style="height:90px" >
	<div style="width: 100%; float: left">
		<br><font size="5" color="black"><b>&nbsp;&nbsp;ORDER IN REVIEW</b> </font><br>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>PO ID:</strong>&nbsp;<%=poNo%><strong> PO DATE:</strong>&nbsp;<%=poDate%><strong> REQUESTED BY:</strong>&nbsp;<%=requestedBy%>
<%
	if(!(modBy.equals(createdBy)))
	{
%>
		<br>&nbsp;&nbsp;&nbsp;&nbsp;<strong> ACTION TAKEN BY:</strong>&nbsp;<%=modBys%><strong> ACTION TAKEN ON:</strong>&nbsp;<%=modifiedOn%>
<%
	}
%>
		<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>STATUS:</strong> <%=statMsg%><br>
	</div>
	</div><br>
<div id="dialog-withdraw" title="Confirmation">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Are you sure you want to withdraw this Order?</p>
</div>		

<div id="dialog-transfer" title="Confirmation">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Are you sure you want to submit this order?</p>
</div>

<input type="hidden" name="singleList" value="Y">
<input type="hidden" name="prodCode_D">
<input type="hidden" name="sys_key" value="<%=sys_key%>">

	<div id='backToList' >
	<button type="button" title="Back" class="button" 
	onclick="javascript:goBack()"><span class="left-link">Back</span></button>
	</div>
<%
	if("CU".equals(userRole) && !"CLOSED".equals(negotiateType) && !"INPROCESS".equals(negotiateType))
	{
%>
	<div id='copyToCart' style="float:left">
		<button type="button" title="Edit in Cart" class="button" onclick="javascript:submitOrder('CART','PASS')"><span>Replenish items</span></button>
		<button type="button" title="With Draw" class="button" onclick="javascript:withDraw()"><span>Withdraw</span></button>
	</div>
<%
	}
%>
	<div id='Sort Button' style="width: 83px !important; display: inline-block; float: left;">
		<ul id="navbar" style="width: 100px; display: inline;">
			<li><a href="javascript:void()" style="padding-top:7px;padding-bottom:5px;">Sort &nbsp;&nbsp;<span class="arrow"></span></a>
			<ul>
				<li><a style="cursor:pointer;" id='sorter'><span>By Line No</span></a></li>
				<li><a style="cursor:pointer;" id='sorter2'><span>By Group</span></a></li>
			</ul>
			</li>
		</ul>
	</div>
<%
	String fromNeg = request.getParameter("fromNeg");
	if(!"Y".equals(fromNeg) )
	{
%>
		<!-----Hidden Values for Serach order ----->
		<input type="hidden" name="PONO" value="<%=request.getParameter("PONO")%>">
		<input type="hidden" name="fromDate" value="<%=request.getParameter("fromDate")%>">
		<input type="hidden" name="toDate" value="<%=request.getParameter("toDate")%>">
		<input type="hidden" name="orderType" value="<%=request.getParameter("orderType")%>">
		<input type="hidden" name="proCodeDesc" value="<%=request.getParameter("prdCODE")%>">
		<input type="hidden" name="SAPSO" value="<%=request.getParameter("SAPSO")%>">
		<input type="hidden" name="UPC" value="<%=request.getParameter("UPC")%>">
		<input type="hidden" name="parentSol" value="<%=request.getParameter("parentSol")%>">
		<input type="hidden" name="selSoldTo" value="<%=request.getParameter("selSoldTo")%>">
		<input type="hidden" name="shipTo" value="<%=request.getParameter("shipTo")%>">
		<input type="hidden" name="orderType" value="<%=request.getParameter("orderType")%>">
		<input type="hidden" name="ordStat" value="<%=request.getParameter("ordStat")%>">
		<input type="hidden" name="tempSoldTo" value="<%=request.getParameter("tempSoldTo")%>">
		<input type="hidden" name="webSrch" value="Y">
		<!----------------- End ------->
<%
	}

	boolean dispFlag_S = false;
	boolean vipFlag_S = false;

	java.util.HashMap catalogHM = new java.util.HashMap();

	String imageMatId = "";
	if(retLinesCount>0)
	{
		for(int i=0;i<retLinesCount;i++)
		{
			String catalog_S	= retLines.getFieldValueString(i,"VENDOR_CATALOG");
			String itemPoints	= retLines.getFieldValueString(i,"POINTS");
			String itemPointsGRP	= retLines.getFieldValueString(i,"POINTS_GROUP");
			String matno	 	= retLines.getFieldValueString(i,"PROD_CODE");

			if(("PTSAM".equals(matno) || "PTSCH".equals(matno) || "PIECES".equals(matno)))
				continue;			

			String vipFlag_L 	= retLines.getFieldValueString(i,"VIP_FLAG");
			String dispFlag_L 	= retLines.getFieldValueString(i,"DISPLAY_FLAG");

			if("Y".equals(dispFlag_L))
				dispFlag_S = true;
			if("Y".equals(vipFlag_L))
				vipFlag_S = true;

			if("".equals(imageMatId))
				imageMatId = matno;
			else
				imageMatId = imageMatId+"','"+matno;

			if(!catalogHM.containsKey(catalog_S))
			{
				catalogHM.put(catalog_S,itemPoints);
			}
			else
			{
				String volume_H = (String)catalogHM.get(catalog_S);
				volume_H = new java.math.BigDecimal(itemPoints).add(new java.math.BigDecimal(volume_H)).setScale(4,java.math.BigDecimal.ROUND_HALF_UP).toString();
				catalogHM.put(catalog_S,volume_H);
			}
		}
	}

	String authChk_SO = "FAIL";
	String authChk_DO = "FAIL";
	String authChk_VO = "FAIL";
	String authChk_AO = "FAIL";
	String authChk_VA = "FAIL";
	String authChk_DA = "FAIL";
	String authChk_VD = "FAIL";

	ezc.record.util.EzOrderedDictionary userAuth_R = Session.getUserAuth();

	if(userAuth_R.containsKey("SUBMIT_ORDER")) authChk_SO = "PASS";
	if(userAuth_R.containsKey("DISP_ORDER")) authChk_DO = "PASS";
	if(userAuth_R.containsKey("VIP_ORDER")) authChk_VO = "PASS";
	if(userAuth_R.containsKey("APPR_ORDER")) authChk_AO = "PASS";
	if(userAuth_R.containsKey("VIP_APPR")) authChk_VA = "PASS";
	if(userAuth_R.containsKey("DISP_APPR")) authChk_DA = "PASS";

	//out.println("negotiateType:::::::::::::"+negotiateType+":::::editNegDtl::::::"+editNegDtl+":::::quesHash.size():::::"+quesHash.size()+":::::ansHash.size():::::"+ansHash.size());
	if(sdHeaderCnt==0 && !"CLOSED".equals(negotiateType))
	{
%>
		<!--&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:submitOrder('NEW')"><span>Save as Template</span></a>-->
<%
		if("CU".equals(userRole))
		{
			if("".equals(dvActBy) && ("REJECTED".equals(negotiateType) || "INPROCESS".equals(negotiateType) || "ACCEPTED".equals(negotiateType)))
			{
				if(editNegDtl)
				{
%>
					<!-- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:submitOrder('F')" id="review1" style="display:none"><span>Submit for Review</span></a> -->
					<div id='review1' style="display:none;float:left">
						<button type="button" title="Submit My Question" class="button" 
						onclick="javascript:submitOrder('F','<%=authChk_SO%>')"><span>Submit My Question</span></button>
					</div>

<%
					//if("INPROCESS".equals(negotiateType))
					if("ACCEPTED".equals(negotiateType))
					{
%>
					<div id='review_11' style="float:left">
						<button type="button" title="Submit to ASB" class="button" 
						onclick="javascript:submitOrder('TRANSFERED','<%=authChk_SO%>')"><span class="right-link">Submit to ASB</span></button>
					</div>

<%
					}
				}
			}
			else if("APPR".equals(dvActBy))
			{
				if(vipFlag_S && "PASS".equals(authChk_VO))
					authChk_VD = "PASS";
				else if(vipFlag_S && "FAIL".equals(authChk_VO))
					authChk_VD = "FAIL";
				if(dispFlag_S && "PASS".equals(authChk_DO))
					authChk_VD = "PASS";
				else if(dispFlag_S && "FAIL".equals(authChk_DO))
					authChk_VD = "FAIL";
%>
				<div id='review_11' style="float:left">
					<button type="button" title="Submit to ASB" class="button" 
					onclick="javascript:submitOrder('TRANSFERED','<%=authChk_VD%>')"><span class="right-link">Submit to ASB</span></button>
				</div>
				
<%
			}
		}
		else if(!"CU".equals(userRole))
		{
			if("".equals(dvActBy) && editNegDtl1 && (!"REJECTED".equals(negotiateType)))
			{
%>
				<div id='accept' style="float:left">
					<button type="button" title="Submit My Response" class="button" 
					onclick="javascript:submitOrder('A','<%=authChk_AO%>')"><span>Submit My Response</span></button>
				</div>
				<!--<div id='reject' style="float:left">
					<button type="button" title="Reject" class="button" 
					onclick="javascript:submitOrder('R','<%//=authChk_AO%>')"><span>Reject</span></button>
				</div>-->
<%
			}
			else if("CUST".equals(dvActBy) && (!"REJECTED".equals(negotiateType)))//&& loginUser.equalsIgnoreCase(dvToAct) 
			{
				if(vipFlag_S && "PASS".equals(authChk_VA))
					authChk_VD = "PASS";
				else if(vipFlag_S && "FAIL".equals(authChk_VA))
					authChk_VD = "FAIL";
				if(dispFlag_S && "PASS".equals(authChk_DA))
					authChk_VD = "PASS";
				else if(dispFlag_S && "FAIL".equals(authChk_DA))
					authChk_VD = "FAIL";
%>
				<div id='reject' style="float:left">
				<a class="fancybox" href="#REJECT" >
					<button type="button" title="Reject" class="button" ><span>Reject</span></button>
				</a>
				</div>
				<div id='review_11' style="display:none;float:left">
					<button type="button" title="Submit My Response" class="button" 
					onclick="javascript:submitOrder('NEGOTIATED','<%=authChk_VD%>')"><span class="right-link">Submit My Response</span></button>
				</div>
<%
			}
%>
			<div id="REJECT" style="display:none">
			<h2>Please Enter Comments</h2>
			<br>
			<ul class="form-list">
			<li>
				<div class="input-box">
					&nbsp;<textarea name="rejectComments" id="rejectComments" cols="80" rows="5"></textarea>
				</div>
			</li>
			<li>
				<button class="button" onClick="javasript:RejectOrder('R','<%=authChk_VD%>')">Submit</button>
			</li>
			</ul>
			</div>
			<div id='audit' style="float:left">
				<a class="fancybox" href="#auditId" onclick="javascript:auditTrail()">
				<button type="button" title="Audit" class="button" 
				onclick="javascript:auditTrail()"><span>Audit</span></button></a>
			</div>
<%
		}
		if(noOfDocs>0)
		{
%>
		<div id='POAttachments' style="float:left">
			<a class="fancybox" href="#POATTACHMENTS<%=poNo%>">
			<button type="button" title="Attachments" class="button"><span>Attachments</span></button></a>
		</div>
<%
		}
	}
%>
</div>
<div id="auditId" style="width: 900px; height:200px; display: none; "></div>
<br>
<div class="col3-set">
	<div class="col-1">
	<div class="info-box">
		<h2 class="sub-title">Shipping Address</h2>
		<p><%=shipToAddress%></p>
<%
	if("REJECTED".equals(sdHeader.getFieldValueString(0,"STATUS")))
	{
%>
		<strong>COMMENTS</strong><br>
		<p><%=conDetails%></p>
<%
	}
%>
	</div>
	</div>
	<div class="col-2">
	<div class="info-box">
		<h2 class="sub-title">Sold To Address</h2>
		<p><%=soldToAddress%></p>
	</div>
	</div>
	<!-- Col 2 of Order Header -->
<%@ include file="../../../Includes/JSPs/Misc/iShipMethods.jsp"%>
	<div class="col-3">
	<div class="info-box">
		<h2 class="sub-title">Shipping Method </h2>
		<% if (dlvCheck.equals("checked=checked")) { %>
			<p><strong>Deliver Together:</strong>&nbsp;Yes<br>
		<% } %>
<%
		String  eddFl	= "N";
		if("01/01/1900".equals(reqDate))
		{
			reqDate = fD.getStringFromDate(new Date(),"/",fD.MMDDYYYY);
		}
		else
		{
			eddFl	= "Y";
%>
			<strong>Desired Ship Date:</strong>&nbsp;<%=reqDate%><br>
<%
		}
%>		
		<strong>Shipping Mode:</strong>&nbsp;<%=shipMethodHM.get(carrierName)%><br>
<%
	if(!"".equals(carrierName) && !"STD".equals(carrierName))
	{
		if("CLTL".equals(carrierName))
		{
			shipPartnRole = "ZF";
			carrierName = "271578";
		} else {
			shipPartnRole = "ZC";
		}

		if ("STD".equals(carrierName))
		{
			shipPartnRole="";billToName = "";billToState = "";billToZipCode = "";billToAddress = "";billToCity = "";billToStreet = "";
		}	
%>
		<strong>BILLING DETAILS WITH SHIPPER</strong><br>
		A/c with Carrier: <%=carrierId%><br>
		<%=billToName%><br>
		<%=billToStreet%><br>
		<%=billToCity%>&nbsp;&nbsp; <%=billToState%> <%=billToZipCode%> 
<%
	}
	//else
	//{
%>
		<!--A/c with Carrier: N/A<br>
		<strong>BILLING DETAILS WITH SHIPPER</strong><br>N/A-->
<%
	//}
%>
		</p>
	</div>
	</div> <!-- Col 3 of Order Header -->
</div> <!-- End of header Column 3 Set -->
<br>
<div class="col3-set">
	<div class="col-1">
	<div class="info-box">
		<h2 class="sub-title"></h2>
	</div>
	</div>
	<div class="col-2">
	<div class="info-box">
		<h2 class="sub-title"></h2>
	</div>
	</div>
	<div class="col-3">
	<div class="info-box">
		<h2 class="sub-title"></h2>
	</div>
	</div>

</div>
<div id="boxes">
	<div id="dialog" class="window">
		<a href="#" class="close"/><font color=black>[x] Close</font></a>
		<iframe id="AttachFiles" width="500" height="350"></iframe>
	</div>
<% if (!comments.trim().equals("")) { %>
<h2 class="sub-title">General Notes</h2>
<p><textarea id="headertext" rows="2" cols="80" readonly><%=comments%></textarea></p>
<div id="mask"></div>
<% } %>
</div>
<div>
<%
	String userType_N  = (String)session.getValue("UserType");
	if("2".equals(userType_N))
	{
%>
<!--		Select Multiplier : 
		<select id="multi" name="multi">
		    <option val="0.10">0.10</option>
		    <option val="0.23">0.23</option>
		    <option val="0.25">0.25</option>
		    <option val="0.35">0.35</option>
		</select>-->
<%
	}
%>

</div>
<input type="hidden" name="poDate" id="poDate" value='<%=poDate%>'>
<input type="hidden" name="soldTo_S" id="soldTo_S" value='<%=soldTo_S%>'>
<input type="hidden" name="complDlv_C" id="complDlv_C" value='<%=complDlv_C%>'>
<input type="hidden" name="carrierName" id="carrierName" value='<%=carrierName%>'>
<input type="hidden" name="reqDate" id="reqDate" value='<%=reqDate%>'>
<input type="hidden" name="carrierId" id="carrierId" value='<%=carrierId%>'>
<input type="hidden" name="billToName" id="billToName" value='<%=billToName%>'>
<input type="hidden" name="billToStreet" id="billToStreet" value='<%=billToStreet%>'>
<input type="hidden" name="billToCity" value='<%=billToCity%>'>
<input type="hidden" name="billToState" value='<%=billToState%>'>
<input type="hidden" name="billToZipCode" value='<%=billToZipCode%>'>
<input type="hidden" name="billToAddress" value="<%=billToAddress%>">
<input type="hidden" name="incoTerms_O" value="">
<input type="hidden" name="custGrp5" value="">
<input type="hidden" name="custCondGrp3" value="">

<input type="hidden" name="shipTo_S" value='<%=shipTo_S%>'>
<input type="hidden" name="poNumber" value="<%=poNo%>">
<input type="hidden" name="webOrNo" value="<%=soNum%>">
<input type="hidden" name="promoCode" value="<%=promoCode%>">
<input type="hidden" name="dvToAct" value="<%=dvToAct%>">
<input type="hidden" name="dvActBy" value="<%=dvActBy_S%>">
<input type="hidden" name="dropShipTo" value="<%=dropShipTo%>">

<input type="hidden" name="desiredDate" value="<%=reqDate%>">
<input type="hidden" name="expectedDel" value="<%=reqDate%>">
<input type="hidden" name="expEDDFlag" value="N">
<input type="hidden" name="complDlv" value="<%=complDlv%>">
<input type="hidden" name="shipComplete" value="<%=complDlv%>">
<input type="hidden" name="Currency" value="<%=Currency%>">
<input type="hidden" name="shipMethod" value="<%=carrierName%>">
<input type="hidden" name="comments" value="<%=comments%>">
<input type="hidden" name="createdBy" value="<%=createdBy%>">

<input type="hidden" name="shipPartnRole" value="<%=shipPartnRole%>">
<input type="hidden" name="soldToCode" value="<%=soldTo_S%>">
<input type="hidden" name="shipToCode" value="<%=shipTo_S%>">

<input type="hidden" name="soldToName" value="<%=soldName%>">
<input type="hidden" name="soldToStreet" value="<%=soldStreet%>">
<input type="hidden" name="soldToCity" value="<%=soldCity%>">
<input type="hidden" name="soldToState" value="<%=soldState%>">
<input type="hidden" name="soldToCountry" value="<%=soldCountry%>">
<input type="hidden" name="soldToZipCode" value="<%=soldZip%>">
<input type="hidden" name="soldToPhNum" value="N/A">
<input type="hidden" name="soldToEmail" value="N/A">

<input type="hidden" name="shipToName" value="<%=shipName%>">
<input type="hidden" name="shipToStreet" value="<%=shipStreet%>">
<input type="hidden" name="shipToCity" value="<%=shipCity%>">
<input type="hidden" name="shipToState" value="<%=shipState%>">
<input type="hidden" name="shipToCountry" value="<%=shipCountry%>">
<input type="hidden" name="shipToZipCode" value="<%=shipZip%>">
<input type="hidden" name="shipToZip" value="<%=shipZip%>">
<input type="hidden" name="shipToPhNum" value="N/A">
<input type="hidden" name="status" id="status">
<input type="hidden" name="rejComments" id="rejComments">

<input type="hidden" name="quesHash" value="<%=quesHash.size()%>">
<input type="hidden" name="ansHash" value="<%=ansHash.size()%>">
<input type="hidden" name="negotiateType" value="<%=negotiateType%>">

<input type="hidden" name="dispFlag_S" value="<%=dispFlag_S%>">
<input type="hidden" name="vipFlag_S" value="<%=vipFlag_S%>">
<input type="hidden" name="eddFlag" value="<%=eddFl%>">

<%
	if(replSpList.size()>0)
	{
%>	
		<input type="hidden" name="repFlag" value="Y">
<%
	}else{
%>
		<input type="hidden" name="repFlag" value="N">
<%	
	}
%>


<div class="col1-set">
<div class="info-box"><br>
<!--<Table width="100%" border=0>
<Tr>
<Th>
	<Table><Tr>
	<Th align=left>
		<div class="ATTACHFILE">
		<a class="fancybox" href="#ATTACHFILE"><button type="button" class="button btn-update"><span>Attach</span></button></a></div>
		<div id="ATTACHFILE" style="display:none">
		<%//@ include file="../UploadFiles/ezAttachFile.jsp"%>
		<h2>File Attachment</h2>
		<br>
		<table>
			<tr><th align=center>Choose a file to attach</th></tr>
			<tr><td align=left><input type="file" value="" name="f1" onPropertyChange="setFname(1)" style="border: solid 1px black;width:100%"/></td></tr>
			<tr><th align=center>Add the file to the list</th></tr>
			<tr><td align=left><input type="button" name="done" value="Attach" onClick="funClose()"/></td></tr>
		</table>
		</div>
	</Th>
	<Th align=right><button type="button" onClick="funRemove()" class="button btn-update"><span>Remove</span></button></Th>
	</Tr></Table>
</Th>
</Tr>
<Tr>
	<Td>&nbsp;</Td>
</Tr>
<Tr>
	<Td><select name="attachs" style="width:100%" size=5 ondblclick="funOpenFile()"></select></Td>
</Tr>
</Table><br>-->
<Table width="100%" border=0>
<Tr>
<%
	if(noOfDocs>0)
	{
%>
		<div id="POATTACHMENTS<%=poNo%>" style="width: 400px; display: none; ">
		<h2>Attachments for PO: <%=poNo%></h2>
<%
		for(int acount=0;acount<retUploadDocs.getRowCount();acount++)
		{
			String openFile = retUploadDocs.getFieldValueString(acount,"SERVERFILENAME");
%>
			<a href="javascript:openFileAttach(<%=acount%>)"><%=retUploadDocs.getFieldValueString(acount,"CLIENTFILENAME")%></a>
			<input type="hidden" name="fileName_<%=acount%>" id="fileName_<%=acount%>" value="<%=openFile%>">
			<br>
<%
		}
%>
		</div>
<%
	}
%>
</Tr>
</Table>
</div>
</div>
<div class="col1-set">
<div class="info-box">
<%
	if(sdHeaderCount>0 && retLinesCount>0)
	{
%>	
		<table class="data-table" id="negsolines">
		<thead>
		<tr>
		<th width="4%" class="a-center">&nbsp;</th>
		<th width="10%" class="a-center">Brand</th>
		<th width="13%" class="a-center">Product Information</th>
		<th width="10%" class="a-center">PO Program</th>
		<th width="10%" class="a-center">List Price</th>
		<th width="10%" class="a-center">Multiplier</th>
		<th width="10%" class="a-center">Net Price</th>
		<th width="10"% class="a-center">Questions/<br>Responses</th>
		<th width="10%" class="a-center">Order Qty</th>
		<th width="10%" class="a-center">SubTotal</th>
		<th width="1%">custItemNo</th>
		<th width="1%">Grouping</th>
		<th width="1%">Points</th>
		</tr>
		</thead>
		<tbody>
<%
		//Image and Brand of product

		Hashtable imageMatHash = new Hashtable();

		if(!"".equals(imageMatId))
		{
			EzcParams prodParamsMiscDWN = new EzcParams(false);
			EziMiscParams prodParamsDWN = new EziMiscParams();

			ReturnObjFromRetrieve prodDetailsRetObjDWN = null;

			prodParamsDWN.setIdenKey("MISC_SELECT");
			String queryDWN=
			"SELECT EZP_BRAND, EZP_CURR_PRICE , EZP_PRODUCT_CODE,SUBSTRING(EZP_PRODUCT_CODE,PATINDEX('%.%',EZP_PRODUCT_CODE)+1,(LEN(EZP_PRODUCT_CODE))) COLOR,EPA_IMAGE_TYPE,EPA_SCREEN_NAME,EZA_ASSET_ID,EZA_MIME_TYPE,EZA_LINK "+
			"FROM EZC_PRODUCTS "+
			"LEFT JOIN "+
			" ( EZC_PRODUCT_ASSETS INNER JOIN EZC_ASSETS ON EPA_ASSET_ID=EZA_ASSET_ID AND EPA_IMAGE_TYPE='MAIN' ) "+
			" ON EPA_PRODUCT_CODE = EZP_PRODUCT_CODE " +
			" WHERE EZP_PRODUCT_CODE IN ('"+imageMatId+"') ORDER by EPA_SCREEN_NAME desc";

			prodParamsDWN.setQuery(queryDWN);

			prodParamsMiscDWN.setLocalStore("Y");
			prodParamsMiscDWN.setObject(prodParamsDWN);
			Session.prepareParams(prodParamsMiscDWN);	

			try
			{
				prodDetailsRetObjDWN = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(prodParamsMiscDWN);
			}
			catch(Exception e){}	

			int indSTD = 0;

			if(prodDetailsRetObjDWN!=null && prodDetailsRetObjDWN.getRowCount()>0)
			{
				for(int im=0;im<prodDetailsRetObjDWN.getRowCount();im++)
				{
					String mainSTD="";
					String prodCodeImg = prodDetailsRetObjDWN.getFieldValueString(im,"EZP_PRODUCT_CODE");
					String brand = prodDetailsRetObjDWN.getFieldValueString(im,"EZP_BRAND");
					String imageSTD = prodDetailsRetObjDWN.getFieldValueString(im,"EZA_ASSET_ID");
					String colorFinish = prodDetailsRetObjDWN.getFieldValueString(im,"COLOR");

					if(colorFinish==null || "null".equals(colorFinish) || colorFinish.length()>3)
						colorFinish = "";

					if(imageSTD!=null && !"".equals(imageSTD) && !"null".equals(imageSTD))
					{
						indSTD = imageSTD.indexOf(colorFinish+"-ST");
					}
					if("MAIN".equals(prodDetailsRetObjDWN.getFieldValueString(im,"EPA_IMAGE_TYPE")) && indSTD!=-1 )
					{				
						mainSTD=nullCheck(prodDetailsRetObjDWN.getFieldValueString(im,"EZA_LINK"));
						imageMatHash.put(prodCodeImg,brand+"§§"+mainSTD);
					}
					else
					{
						mainSTD="NA";

						if(!imageMatHash.containsKey(prodCodeImg))
							imageMatHash.put(prodCodeImg,brand+"§§"+mainSTD);
					}
				}
			}
		}
		//Image and Brand of product


		java.math.BigDecimal grandTotal =new java.math.BigDecimal("0");
		Hashtable SoValueHT = new Hashtable();
		Vector SOVector = new Vector();
		String webOrdNo ="";
		//out.println(retLines.toEzcString());

		ReturnObjFromRetrieve quesRetObj = null;

		mainParamsNeg = new EzcParams(false);
		miscParamsNeg = new EziMiscParams();

		miscParamsNeg.setIdenKey("MISC_SELECT");

		String query = "SELECT VALUE1,VALUE2 FROM EZC_VALUE_MAPPING WHERE MAP_TYPE='QUESTION'";

		miscParamsNeg.setQuery(query);

		mainParamsNeg.setLocalStore("Y");
		mainParamsNeg.setObject(miscParamsNeg);
		Session.prepareParams(mainParamsNeg);	

		try
		{
			quesRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsNeg);
		}
		catch(Exception e){}

		HashMap QuCatHash = new HashMap();

		if(quesRetObj!=null && quesRetObj.getRowCount()>0)
		{
			for(int qu=0;qu<quesRetObj.getRowCount();qu++)
			{
				String quesID = quesRetObj.getFieldValueString(qu,"VALUE1");
				String quesDesc = quesRetObj.getFieldValueString(qu,"VALUE2");

				if(!QuCatHash.containsKey(quesID))
					QuCatHash.put(quesID,quesDesc);
			}
		}

		//out.println("catalogHM::::"+catalogHM);
		Map sortedMap = new TreeMap(catalogHM);

		Set catCol = sortedMap.entrySet();
		Iterator catColIte = catCol.iterator();
		while(catColIte.hasNext())
		{
			Map.Entry catColData = (Map.Entry)catColIte.next();

			String cat_HM = (String)catColData.getKey();
			int ent = 0;
			for(int i=0;i<retLinesCount;i++)
			{
				String venCatalog 	= retLines.getFieldValueString(i,"VENDOR_CATALOG");
				if(!cat_HM.equals(venCatalog))
					continue;
				
				webOrdNo 		= retLines.getFieldValueString(i,"WEB_ORNO");
				String itemLineNo 	= retLines.getFieldValueString(i,"SO_LINE_NO");
				String itemDiv	 	= retLines.getFieldValueString(i,"DIVISION");
				String itemDC	 	= retLines.getFieldValueString(i,"DISCTCHANNEL");
				String itemSalesOrg 	= retLines.getFieldValueString(i,"SALESORG");
				String prdCode	 	= retLines.getFieldValueString(i,"PROD_CODE");
				String prdDesc	 	= retLines.getFieldValueString(i,"PROD_DESC");
				String dsrQty	 	= retLines.getFieldValueString(i,"DESIRED_QTY");
				String prdUom	 	= retLines.getFieldValueString(i,"UOM");
				String commQty	 	= retLines.getFieldValueString(i,"COMMITED_QTY");
				String rqyDate	 	= retLines.getFieldValueString(i,"REQ_DATE");
				String listPrice 	= new java.math.BigDecimal(retLines.getFieldValueString(i,"DESIRED_PRICE")).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString(); //List price
				String commPrice 	= new java.math.BigDecimal(retLines.getFieldValueString(i,"COMMIT_PRICE")).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString(); // Nett Price
				String netValue		= new java.math.BigDecimal(retLines.getFieldValueString(i,"ITEM_NET_VALUE")).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();; //need to be added in source o/p
				String stanPrice 	= new java.math.BigDecimal(retLines.getFieldValueString(i,"LIST_PRICE")).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
				String currency 	= retLines.getFieldValueString(i,"CURRENCY");
				String plant	 	= retLines.getFieldValueString(i,"PLANT");
				String itemRemarks	= retLines.getFieldValueString(i,"REMARKS");
				String ItemCat	 	= retLines.getFieldValueString(i,"ITEM_CATEGORY");
				String netPrice	 	= retLines.getFieldValueString(i,"NET_PRICE");
				String custMat	 	= retLines.getFieldValueString(i,"CUST_MAT");
				String vipFalg	 	= retLines.getFieldValueString(i,"VIP_FLAG");
				String dispFlag	 	= retLines.getFieldValueString(i,"DISPLAY_FLAG");
				String splFlag	 	= retLines.getFieldValueString(i,"QUICKSHIP_FLAG");
				String quoteRefNo 	= retLines.getFieldValueString(i,"QUOTE_REF_NO");
				String quoteLineNo 	= retLines.getFieldValueString(i,"QUOTE_LINE_NO");
				String points	 	= retLines.getFieldValueString(i,"POINTS");
				String pointsGrp 	= retLines.getFieldValueString(i,"POINTS_GROUP");
				String custSku		= retLines.getFieldValueString(i,"CUST_SKU");
				String custPoLine	= retLines.getFieldValueString(i,"CUST_PO_LINENO");
				String refQstNo		= retLines.getFieldValueString(i,"REF_QUESTION_NO");
				String orderType	= retLines.getFieldValueString(i,"ORDER_TYPE");
				if(orderType!=null && !"null".equals(orderType))orderType = orderType.trim();
				String eanUPC		= retLines.getFieldValueString(i,"ITEM_UPC"); //UPC
				String itemListPrice	= retLines.getFieldValueString(i,"ITEM_LIST_PRICE");
				String stdMultiplier	= retLines.getFieldValueString(i,"ITEM_MULTIPLIER");
				String itemWeight	= retLines.getFieldValueString(i,"ITEM_WEIGHT"); 
				String itemPoints	= retLines.getFieldValueString(i,"POINTS");
				String itemPointsGRP	= retLines.getFieldValueString(i,"POINTS_GROUP");
				String backEndItem	= retLines.getFieldValueString(i,"BACK_END_ITEM");
				String kitComp		= retLines.getFieldValueString(i,"ITEM_FREIGHT_INS");
				String qsItem_A		= retLines.getFieldValueString(i,"NOTES");
				String pntspcs = "pcs";

				if(plant!=null && !"null".equals(plant))
					plant = plant.trim();
				if("N/A".equals(plant))
					plant = itemDiv;

				String splitKey 	= orderType+"¥"+itemSalesOrg+"¥"+itemDiv+"¥"+itemDC+"¥"+plant;

				String childComponents = "";
				if(kitComp!=null && !"0".equals(kitComp))
				{
					ReturnObjFromRetrieve retBomMat = null;

					mainParamsNeg = new EzcParams(false);
					miscParamsNeg = new EziMiscParams();

					miscParamsNeg.setIdenKey("MISC_SELECT");
					miscParamsNeg.setQuery("SELECT EZP_PRODUCT_CODE,EZP_UPC_CODE,EPD_PRODUCT_DESC FROM EZC_PRODUCTS,EZC_PRODUCT_DESCRIPTIONS WHERE EZP_PRODUCT_CODE=EPD_PRODUCT_CODE AND EPD_LANG_CODE='EN' AND EZP_PRODUCT_CODE IN (SELECT EPR_PRODUCT_CODE2 FROM EZC_PRODUCT_RELATIONS WHERE EPR_PRODUCT_CODE1='"+prdCode+"' AND EPR_RELATION_TYPE='SBOM')");

					mainParamsNeg.setLocalStore("Y");
					mainParamsNeg.setObject(miscParamsNeg);
					Session.prepareParams(mainParamsNeg);	

					try
					{
						retBomMat = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsNeg);
					}
					catch(Exception e){}

					int bCnt = 0;
					if(retBomMat!=null)
						bCnt = retBomMat.getRowCount();

					for(int cnt=0;cnt<bCnt;cnt++)
					{
						String prodDesc_B 	= retBomMat.getFieldValueString(cnt,"EPD_PRODUCT_DESC");
						String matId_B 		= retBomMat.getFieldValueString(cnt,"EZP_PRODUCT_CODE");
						childComponents+=" " + matId_B + " " + prodDesc_B + "&nbsp;<br/>";
						childComponents = childComponents.trim();
						childComponents = childComponents.replaceAll("\'","`");
					}
				}

				/*String pointsFromEdit = (String)session.getValue(itemPointsGRP);
				if(pointsFromEdit==null || "null".equals(pointsFromEdit) || "".equals(pointsFromEdit))
				{
					session.putValue(itemPointsGRP,itemPoints);
				}
				else
				{
					try
					{
						pointsFromEdit = new java.math.BigDecimal(pointsFromEdit).add(new java.math.BigDecimal(itemPoints)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
					}
					catch(Exception e){}

					session.putValue(itemPointsGRP,pointsFromEdit);
				}

				log4j.log("dummy check itemPointsGRP>>>>>>>>"+itemPointsGRP,"D");
				log4j.log("dummy check session.getValue(itemPointsGRP)>>>>>>>>"+session.getValue(itemPointsGRP),"D");*/
				if(SOVector.contains(webOrdNo))
				{
					try{
						SoValueHT.put(webOrdNo,Double.parseDouble((String)SoValueHT.get(webOrdNo))+Double.parseDouble(netValue)+"");
					}catch(Exception e){
					}	
				}else{
					SOVector.addElement(webOrdNo);

					SoValueHT.put(webOrdNo,netValue);
				}			

				String tPNo		= "";
				String prodNoUD 	= "";	
				String dispChk		= "";
				String vipChk		= "Standard";
				String diable		= "";
				String itemMfrPartNo 	= "";

				if(custMat!=null && !"null".equals(custMat) && !"".equals(custMat.trim()))
				{
					try
					{
						tPNo = Integer.parseInt(custMat)+"";
						prodNoUD = custMat;
						prodNoUD=prodNoUD.trim();
					}
					catch(Exception e)
					{ 
						tPNo = custMat;
						prodNoUD = custMat;
						prodNoUD=prodNoUD.trim();
					}
				}
				else
				{
					try
					{
						tPNo = Integer.parseInt(prdCode)+"";
						prodNoUD = prdCode;
						prodNoUD=prodNoUD.trim();
					}
					catch(Exception e)
					{ 
						tPNo = prdCode;
						prodNoUD = prdCode; 
						prodNoUD=prodNoUD.trim();
					}
				}
				String tqty = dsrQty;

				try
				{
					tqty = tqty.substring(0,tqty.indexOf('.'));
				}
				catch(Exception e){}			

				String itemFlag = "N/A";

				if(quoteRefNo!=null && !"N/A".equals(quoteRefNo) && !"N/A".equals(quoteLineNo))quoteRefNo = quoteRefNo+"/"+quoteLineNo;
				if("Y".equals(vipFalg)){
					//vipChk="checked";
					//diable="disabled";
					vipChk="Vip";
					itemFlag="VIP";
				}	
				if("Y".equals(dispFlag)){
					//dispChk="checked";
					//diable="disabled";
					vipChk="Display";
					itemFlag="DISP";
				}
				if("Y".equals(splFlag))
				{
					vipChk="Quick Ship";
				}
				if(custSku==null || "".equals(custSku) || "null".equals(custSku))custSku = "";
				if(custPoLine==null || "".equals(custPoLine.trim()) || "null".equals(custPoLine.trim()))custPoLine = "";
				if(custPoLine!=null || !"".equals(custPoLine.trim()) || !"null".equals(custPoLine.trim()))custPoLine = custPoLine.trim();

				netValue = (new java.math.BigDecimal(commPrice).multiply(new java.math.BigDecimal(tqty))).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
				grandTotal = (grandTotal.add(new java.math.BigDecimal(netValue)));
%>

<%
			if(cat_HM.equals(venCatalog))// && ent==0)
			{
				ent++;
				

				if("Enamel Steel".equals(venCatalog) || 
					   "Acrylux".equals(venCatalog) 	    || 
					   "Chinaware".equals(venCatalog)    || 
					   "Americast & Acrylics (Excludes Acrylux)".equals(venCatalog) ||
		   			   "Marble".equals(venCatalog))
						pntspcs="points";

				if("Repair Parts".equals(venCatalog) || "DXV Chinaware".equals(venCatalog) || "DXV Faucets".equals(venCatalog) ||
				   "DXV Furniture".equals(venCatalog) || "DXV Tubs".equals(venCatalog) || 
				   "DXV Sinks (Non-CW)".equals(venCatalog) || "DXV Repair Parts".equals(venCatalog))
						pntspcs="$";
			}
%>			
			<tr id="linedatarow">
<%
			String imgInfo = (String)imageMatHash.get(prdCode);
			String brand_Img = "";
			String mainSTD_Img = "";

			try
			{
				brand_Img = imgInfo.split("§§")[0];
			}
			catch(Exception e){}

			try
			{
				mainSTD_Img = imgInfo.split("§§")[1];

				if("NA".equals(mainSTD_Img)) mainSTD_Img = "";
			}
			catch(Exception e){mainSTD_Img = "";}
%>
				<td><div style="display:none" id="solineinfo"><%=itemLineNo%></div><br>
				<!--<img  src="<%=mainSTD_Img%>" width="100" height"160" alt="" />-->
				<p align="center"><%=brand_Img%></p>
				</td>
				<td><%=prdDesc%>
				<br><strong>Product:</strong>&nbsp;<a href="javascript:getProductDetails('<%=tPNo.trim()%>')" title="<%=tPNo.trim()%>"><%=tPNo.trim()%></a>
				<br><strong>UPC:</strong>&nbsp;<%=eanUPC%>
<%
				if(custSku!=null && !"N/A".equals(custSku))
				{
%>
				<br><strong>My SKU:</strong>&nbsp;<%=custSku%>
<%
				}
				if(custPoLine!=null && !"N/A".equals(custPoLine))
				{
%>
				<br><strong>My PO Line:</strong>&nbsp;<%=custPoLine%>
<%
				}

				if(!"CU".equals(userRole))
				{
%>
					<br>
					<strong>Doc Info:</strong>&nbsp;<%=orderType%>/<%=itemSalesOrg%>/<%=itemDC%>/<%=itemDiv%>
<%
				}
%>
				</td>

				<td class="a-center"><%=vipChk%>
				<% if ( !(quoteRefNo.equals("N/A")) && !(quoteRefNo.equals(""))) { %>
				<strong>Quote#&nbsp;</strong><%=quoteRefNo%>
				<% } %>
				</td>
				<td >
				&nbsp;$<%=itemListPrice%>
				<input type="hidden" name="itemListPrice_<%=itemLineNo%>" id ="itemListPrice_<%=itemLineNo%>" value="<%=itemListPrice%>">
				</td>
				<td>
				<span id="stdMultiDiv_<%=itemLineNo%>">
<%
			String defMultiVal = stdMultiplier;
			//if("N/A".equals(stdMultiplier) || "".equals(stdMultiplier))
			{
				try
				{
					defMultiVal = ((new java.math.BigDecimal(commPrice)).divide((new java.math.BigDecimal(itemListPrice)),2,java.math.BigDecimal.ROUND_HALF_UP)).toString();
				}
				catch(Exception e)
				{
					defMultiVal = "DEF";
				}
			}

			if(!"CU".equals(userRole) && "CUST".equals(dvActBy))
			{
				if(!"Standard".equals(vipChk))
				{
%>
					<select name="stdMulti_<%=itemLineNo%>" id="stdMulti_<%=itemLineNo%>" onChange="calMulti(this,<%=itemLineNo%>)">
					<option value="DEF" selected>-Sel-</option>
<%
					if("Vip".equals(vipChk))
					{
						if(!"0.35".equals(defMultiVal) && !"DEF".equals(defMultiVal))
						{
%>
						<!--<option value="<%//=defMultiVal%>">-Sel-</option>-->
<%
						}
%>
						<option value="0.35">0.35</option>
<%
					}
					else if("Display".equals(vipChk))
					{
						if(!"0.25".equals(defMultiVal) && !"0.10".equals(defMultiVal) && !"DEF".equals(defMultiVal))
						{
%>
						<!--<option value="<%//=defMultiVal%>">-Sel-</option>-->
<%
						}
%>
						<option value="0.10">0.10</option>
						<option value="0.23">0.23</option>
						<option value="0.25">0.25</option>
						<option value="0.35">0.35</option>
<%
					}
%>
					</select>
					<!--<input type="text" size="4" name="stdMulti_<%//=itemLineNo%>" value="<%//=stdMultiplier%>">-->
<%
				}
				else
				{
%>
				<input type="hidden" name="stdMulti_<%=itemLineNo%>" id="stdMulti_<%=itemLineNo%>" value="<%=stdMultiplier%>"><%=stdMultiplier%>
<%
				}
			}
			else
			{
				//String tStdMulti = stdMultiplier;
				String tStdMulti = defMultiVal;
				if("CU".equals(userRole) && !"Standard".equals(vipChk) && "CUST".equals(dvActBy)) tStdMulti = "TBD";
%>
				<input type="hidden" name="stdMulti_<%=itemLineNo%>" id="stdMulti_<%=itemLineNo%>" value="<%=tStdMulti%>"><%=checkAuth(tStdMulti,"VIEW_PRICES",userAuth_R)%>
				<input type="hidden" name="stdMultiChng_<%=itemLineNo%>" id="stdMultiChng_<%=itemLineNo%>" value="Y">
<%
			}
%>
				<input type="hidden" name="defMultiVal_<%=itemLineNo%>" id="defMultiVal_<%=itemLineNo%>" value="<%=defMultiVal%>">
				</span>
				<span id="stdMultiDivHid_<%=itemLineNo%>" id="stdMultiDivHid_<%=itemLineNo%>" style="display:none">
				</span>
				</td>
				<td>$
<%
			if(!"CU".equals(userRole) && "CUST".equals(dvActBy))
			{
				if(!"Standard".equals(vipChk))
				{
					String classInput = "inputBoxEven";
					if(i%2==0)
						classInput = "inputBoxOdd";
%>
				<!--<input type="text" size="4" name="netPrice_<%=itemLineNo%>" value="<%=commPrice%>" readonly onBlur="calNetPrice(<%=itemLineNo%>)" onKeyPress="calNetPrice(<%=itemLineNo%>)" onKeyUp="calNetPrice(<%=itemLineNo%>)">-->
				<input type="text" class="<%=classInput%>" size="4" id="netPrice_<%=itemLineNo%>" name="netPrice_<%=itemLineNo%>"  value="<%=commPrice%>" readonly>
				<input type="hidden" name="netPriceHid_<%=itemLineNo%>" id="netPriceHid_<%=itemLineNo%>" value="<%=commPrice%>">
				<br><a href="javascript:resetPrice(<%=itemLineNo%>)"><span>Reset</span></a>
<%
				}
				else
				{
%>
				<input type="hidden" id ="netPrice_<%=itemLineNo%>" name="netPrice_<%=itemLineNo%>" value="<%=commPrice%>"><%=commPrice%>
<%
				}
			}
			else
			{
				String tNetPrice = commPrice;
				if("CU".equals(userRole) && !"Standard".equals(vipChk) && "CUST".equals(dvActBy)) tNetPrice = "TBD";
%>
				<input type="hidden" id="netPrice_<%=itemLineNo%>" name="netPrice_<%=itemLineNo%>"  value="<%=commPrice%>"><%=checkAuth(tNetPrice,"VIEW_PRICES",userAuth_R)%>
				<input type="hidden" name="netPriceChng_<%=itemLineNo%>" id="netPriceChng_<%=itemLineNo%>" value="Y">
<%
			}
%>
				</td>
					<!--*******Hidden fields for adding to cart START *******-->
					<input type="hidden" name="weborno" value="<%=webOrdNo.trim()%>">
					<input type="hidden" name="webOrdNo<%=itemLineNo%>" value="<%=webOrdNo.trim()%>">
					<input type="hidden" name="itemLineNo" value="<%=itemLineNo%>">
					<input type="hidden" name="itemDiv<%=itemLineNo%>" value="<%=itemDiv%>">
					<input type="hidden" name="itemDC<%=itemLineNo%>" value="<%=itemDC%>">
					<input type="hidden" name="itemSalesOrg<%=itemLineNo%>" value="<%=itemSalesOrg%>">
					<input type="hidden" name="tPNo<%=itemLineNo%>" value="<%=tPNo%>">
					<input type="hidden" name="prdDesc<%=itemLineNo%>" value='<%=prdDesc%>'>
					<input type="hidden" name="prdUom<%=itemLineNo%>" value="<%=prdUom%>">
					<input type="hidden" name="quantity<%=itemLineNo%>" value="<%=tqty%>">
					<input type="hidden" name="rqyDate<%=itemLineNo%>" value="<%=rqyDate%>">
					<input type="hidden" name="venCatalog<%=itemLineNo%>" value="<%=venCatalog%>">
					<input type="hidden" name="vipFalg<%=itemLineNo%>" value="<%=vipFalg%>">
					<input type="hidden" name="dispFlag<%=itemLineNo%>" value="<%=dispFlag%>">
					<input type="hidden" name="splFlag<%=itemLineNo%>" value="<%=splFlag%>">
					<input type="hidden" name="quoteRefNo<%=itemLineNo%>" value="<%=quoteRefNo%>">
					<input type="hidden" name="quoteLineNo<%=itemLineNo%>" value="<%=quoteLineNo%>">
					<input type="hidden" name="points<%=itemLineNo%>" value="<%=points%>">
					<input type="hidden" name="pointsGrp<%=itemLineNo%>" value="<%=pointsGrp%>">
					<input type="hidden" name="custSku<%=itemLineNo%>" value="<%=custSku%>">
					<input type="hidden" name="custPoLine<%=itemLineNo%>" value="<%=custPoLine.trim()%>">
					<input type="hidden" name="orderType<%=itemLineNo%>" value="<%=orderType.trim()%>">
					<input type="hidden" name="eanUPC<%=itemLineNo%>" value="<%=eanUPC%>">
					<input type="hidden" name="listPrice<%=itemLineNo%>" value="<%=itemListPrice%>">
					<!--*******Hidden fields for adding to cart END *******-->	

					<!--*******Hidden fields for adding to OrderCreation START *******-->
					<input type="hidden" name="webOrdNo" value="<%=webOrdNo.trim()%>">
					<input type="hidden" name="lineValue" value="<%=netValue%>">
					<input type="hidden" name="listPrice" value="<%=itemListPrice%>">
					<input type="hidden" name="stdMultiplier" value="<%=stdMultiplier%>">
					<input type="hidden" id="product" name="product" value="<%=prodNoUD%>" class="productForLen">
					<input type="hidden" name="prodDesc" value="<%=prdDesc%>">
					<input type="hidden" name="custprodCode" value="<%=prodNoUD%>">
					<input type="hidden" name="orderType" value="<%=orderType%>">
					<input type="hidden" name="pack" value="<%=prdUom%>">
					<input type="hidden" name="ItemCat" value="<%=ItemCat%>">
					<input type="hidden" name="commitedQty" value="<%=tqty%>">
					<input type="hidden" name="UomQty" value="0">
					<input type="hidden" name="itemListPrice" value="<%=commPrice%>">
					<input type="hidden" name="itemVenCatalog" value="<%=venCatalog%>">
					<input type="hidden" name="itemMfrPart" value="<%=prodNoUD%>">
					<input type="hidden" name="itemMfrNr"   value="N/A">
					<input type="hidden" name="itemEanUPC" value="<%=eanUPC%>">
					<input type="hidden" name="itemMatId" value="<%=prodNoUD%>">
					<input type="hidden" name="itemLineItem" value="<%=itemLineNo%>">
					<input type="hidden" name="itemMmFlag" value="VC">
					<input type="hidden" name="itemDiscCode" value="N/A">
					<input type="hidden" name="itemMfrCode" value="N/A">
					<input type="hidden" name="itemWeight" value="<%=itemWeight%>">
					<input type="hidden" name="quoteNum" value="<%=quoteRefNo%>">
					<input type="hidden" name="lineNum" value="<%=quoteLineNo%>">
					<input type="hidden" name="itemPromoCode" value="">
					<input type="hidden" name="itemCnetProd" value="<%=qsItem_A%>">
					<input type="hidden" name="vendCatalog" value="<%=venCatalog%>">
					<input type="hidden" name="delSchQty" value="<%=tqty%>">
					<input type="hidden" name="delSchDate" value="<%=reqDate%>">
					<input type="hidden" name="splitKey" value="<%=splitKey%>">
					<input type="hidden" name="dispFlag" value="<%=dispFlag%>">
					<input type="hidden" name="vipFlag" value="<%=vipFalg%>">
					<input type="hidden" name="qsFlag" value="<%=splFlag%>">
					<input type="hidden" name="itemCustSku" value="<%=custSku%>"> 
					<input type="hidden" name="itemPoLine" value="<%=custPoLine%>"> 
					<input type="hidden" name="tempLineNo" value="<%=itemLineNo%>">	
					<input type="hidden" name="itemPoints" value="<%=itemPoints%>"> 
					<input type="hidden" name="itemPlant"  value="<%=plant%>">
					<input type="hidden" name="splitItemNo"  value="<%=backEndItem%>">
					<input type="hidden" name="kitComp"  value="<%=kitComp%>">
					<input type="hidden" name="itemClass"  value="N/A">

					<input type="hidden" name="itemFlag_<%=itemLineNo%>" id="itemFlag_<%=itemLineNo%>" value="<%=itemFlag%>">
					<input type="hidden" name="childComponents<%=itemLineNo%>" id="childComponents<%=itemLineNo%>" value='<%=childComponents%>'>
					<input type="hidden" name="listPriceF_<%=itemLineNo%>" value="<%=stanPrice%>">

					<!--*******Hidden fields for adding to OrderCreation END *******-->

					<!---*******Hidden Values to Set for Q&A Start**********---------->
						<input type="hidden" name="QComments<%=itemLineNo%>">
						<input type="hidden" id = "lineItem" name="lineItem"  value="<%=itemLineNo%>" class="lineItemId" >
					<!---*******Hidden Values to Set for Q&A End**********---------->
					<!-- Hidden value to handle array -->
					<input type="hidden" id = "lineItem_<%=itemLineNo%>" name="lineItem_<%=itemLineNo%>"  value="<%=itemLineNo%>">
					<!-- End of lineItem array -->
<%
				String questionHTML = "";
				String QKey ="";
				String AKey ="";
				if(noQHash!=null && noQHash.size()>0 && noQHash.containsKey(itemLineNo))
				{
					String tempQues	= (String)noQHash.get(itemLineNo);
					String reply="";
					//questionHTML= "<table class=\"data-table\">";
					String questionHTML_Temp = "<table class=\"data-table\"><tr><th>S No.</th><th>Questions and Responses</th></tr>";
					if(!"".equals(tempQues) && !"null".equals(tempQues))
					{
						int rSpan = 1;
						if(!"CU".equals(userRole)) rSpan = 2;

						if(tempQues.indexOf("#")!=-1)
						{
							String [] QArray = tempQues.split("#");
							int QArrayLen	 = QArray.length;
							for(int q=0;q<QArrayLen;q++)
							{
								QKey = (String)quesHash.get(QArray[q]);
								AKey = (String)ansHash.get(QArray[q]);

								QKey = ((QKey == null) || (("").equals(QKey)) || ("null".equalsIgnoreCase(QKey)))?"":QKey;
								AKey = ((AKey == null) || (("").equals(AKey)) || ("null".equalsIgnoreCase(AKey)))?"":AKey;
								if(!"".equals(AKey))reply =AKey;
								if(!"".equals(QKey) && !"null".equals(QKey) && !"N/A".equals(QKey.split("##")[1]))
								{
									if("".equals(AKey))
									{
										int indNo = 0;
										try
										{
											indNo = Integer.parseInt(QKey.split("##")[4])+1;
										}
										catch(Exception e){}
										questionHTML_Temp = questionHTML_Temp+"<tr><th rowspan="+rSpan+">"+indNo+"</th>";
										questionHTML_Temp = questionHTML_Temp+"<th><h3><p>"+QuCatHash.get(QKey.split("##")[1])+"&nbsp;:&nbsp;<small class=\"smallText\">Asked by "+QKey.split("##")[2]+"&nbsp;, on &nbsp;"+QKey.split("##")[3]+"</small></p></h3>"+QKey.split("##")[0]+"</th></tr>";
										if(!"CU".equals(userRole))
										{
											questionHTML_Temp = questionHTML_Temp+"<tr><th>Enter your Response in the below area";
											questionHTML_Temp = questionHTML_Temp+"<br><textarea name=\"reply\" id=\"reply"+itemLineNo+"\" cols=\"10\" rows=\"5\"></textarea>";
											questionHTML_Temp = questionHTML_Temp+"<br><input type=\"button\" label=\"Submit\"  value=\"Save\" onClick=\"reply("+itemLineNo+")\"></input>";
											questionHTML_Temp = questionHTML_Temp+"&nbsp;<input type=\"button\" label=\"Clear\"  value=\"Clear\" onClick=\"clearText("+itemLineNo+")\"></input>";
											questionHTML_Temp = questionHTML_Temp+"&nbsp;<input type=\"button\" label=\"Close\"  value=\"Close\" onClick=\"closeDialog()\"></input></th></tr>";
										}
									}
									else
									{
										int indNo = 0;
										try
										{
											indNo = Integer.parseInt(AKey.split("##")[4])+1;
										}
										catch(Exception e){}
										questionHTML = questionHTML+"<tr><th rowspan=2>"+indNo+"</th><th><h3><p><small class=\"smallText\">Replied by &nbsp;"+AKey.split("##")[2]+"&nbsp;,on &nbsp;"+AKey.split("##")[3]+"</small></p></h3>"+AKey.split("##")[0]+"</th></tr>";
										questionHTML = questionHTML+"<tr><th><h3><p>"+QuCatHash.get(QKey.split("##")[1])+"&nbsp;:&nbsp;<small class=\"smallText\">Asked by "+QKey.split("##")[2]+"&nbsp;,on &nbsp;"+QKey.split("##")[3]+"</small></p></h3>"+QKey.split("##")[0]+"</th></tr>";
									}
								}	

								//out.println("QKey::::::::::::::"+QKey+":::::AKey::::::"+AKey);
							}
							//questionHTML = questionHTML+"</table>";
							//if("".equals(AKey) && !"CU".equals(userRole))questionHTML = questionHTML+"<br><input type=\"button\" label=\"Submit\"  value=\"Save\" onClick=\"reply("+itemLineNo+")\"></input>";
						}
						else
						{
							QKey = (String)quesHash.get(tempQues);
							AKey = (String)ansHash.get(tempQues);
							QKey = ((QKey == null) || (("").equals(QKey)) || ("null".equalsIgnoreCase(QKey)))?"":QKey;
							AKey = ((AKey == null) || (("").equals(AKey)) || ("null".equalsIgnoreCase(AKey)))?"":AKey;
							if(!"".equals(AKey))reply =AKey;
							if(!"".equals(QKey) && !"null".equals(QKey) && !"N/A".equals(QKey.split("##")[1]))
							{
								if("".equals(AKey))
								{
									int indNo = 0;
									try
									{
										indNo = Integer.parseInt(QKey.split("##")[4])+1;
									}
									catch(Exception e){}
									questionHTML_Temp = questionHTML_Temp+"<tr><th rowspan="+rSpan+">"+indNo+"</th>";
									questionHTML_Temp = questionHTML_Temp+"<th><h3><p>"+QuCatHash.get(QKey.split("##")[1])+"&nbsp;:&nbsp;<small class=\"smallText\">Asked by "+QKey.split("##")[2]+"&nbsp;,on &nbsp;"+QKey.split("##")[3]+"</small></p></h3>"+QKey.split("##")[0]+"</th></tr>";
									if(!"CU".equals(userRole))
									{
										questionHTML_Temp = questionHTML_Temp+"<tr><th>Enter your Response in the below area";
										questionHTML_Temp = questionHTML_Temp+"<br><textarea name=\"reply\" id=\"reply"+itemLineNo+"\" cols=\"10\" rows=\"5\"></textarea>";
										questionHTML_Temp = questionHTML_Temp+"<br><input type=\"button\" label=\"Submit\"  value=\"Save\" onClick=\"reply("+itemLineNo+")\"></input>";
										questionHTML_Temp = questionHTML_Temp+"&nbsp;<input type=\"button\" label=\"Clear\"  value=\"Clear\" onClick=\"clearText("+itemLineNo+")\"></input>";
										questionHTML_Temp = questionHTML_Temp+"&nbsp;<input type=\"button\" label=\"Close\"  value=\"Close\" onClick=\"closeDialog()\"></input></th></tr>";
									}	
								}
								else
								{
									int indNo = 0;
									try
									{
										indNo = Integer.parseInt(AKey.split("##")[4])+1;
									}
									catch(Exception e){}
									questionHTML = questionHTML+"<tr><th rowspan=2>"+indNo+"</th><th><h3><p><small class=\"smallText\">Replied by &nbsp;"+AKey.split("##")[2]+"&nbsp;,on &nbsp;"+AKey.split("##")[3]+"</small></p></h3>"+AKey.split("##")[0]+"</th></tr>";
									questionHTML = questionHTML+"<tr><th><h3><p>"+QuCatHash.get(QKey.split("##")[1])+"&nbsp;:&nbsp;<small class=\"smallText\">Asked by "+QKey.split("##")[2]+"&nbsp;,on &nbsp;"+QKey.split("##")[3]+"</small></p></h3>"+QKey.split("##")[0]+"</th></tr>";
								}
								//questionHTML = questionHTML+"</table>";
								//if("".equals(AKey) && !"CU".equals(userRole))questionHTML = questionHTML+"<br><input type=\"button\" label=\"Submit\"  value=\"Save\" onClick=\"reply("+itemLineNo+")\"></input>";
								//questionHTML = questionHTML+"<table class=\"data-table\"><thead><tr><th>Comments</th><thead></thead><tbody><tr>"+reply+"</tbody></table>";
							}
							else
							{
								questionHTML_Temp = "";
								questionHTML = "<table class=\"data-table\"><thead><tr><th>No Queries To Display.</th></tr></thead>";
							}
						}

						//out.println("questionHTML::::::::::::::"+questionHTML);


					}

					questionHTML = questionHTML_Temp+questionHTML+"</table>";
					if(!"null".equals(QKey) && !"".equals(QKey))
					{
%>
						<input type="hidden" name="qType<%=itemLineNo%>" value="<%=QKey.split("##")[1]%>"> 
<%				
					}
				}
				else{
					questionHTML = "<table class=\"data-table\"><thead><tr><th>No Queries To Display.</th></tr></thead></table>";
%>
					<input type="hidden" name="qType<%=itemLineNo%>"> 
<%
				}
%>			
				<td>

<%
				String qComnts = (String)QKey.split("##")[0];

				try
				{
					qComnts = (String)AKey.split("##")[0];

					if(qComnts==null || "null".equalsIgnoreCase(qComnts) || "".equals(qComnts))
						qComnts = (String)QKey.split("##")[0];
				}
				catch(Exception e)
				{
					qComnts = (String)QKey.split("##")[0];
				}
				int qComLen = qComnts.length();
				if(qComLen>70)
					qComnts = qComnts.substring(0,60)+"....";

				if("CU".equals(userRole)  )
				{

%>			
					<div class="VIEW<%=itemLineNo%>">
						<a class="fancybox" href="#VIEW<%=itemLineNo%>" >
<%
					if(!"null".equals(QKey) && !"".equals(QKey))
					{
%>				
						<span id="ASK<%=itemLineNo%>" style="display:none"><%=qComnts%></span><!--<input type=button value=Ask> -->
						<span id="HIDE<%=itemLineNo%>"><span><%=qComnts%></span></span><!-- <input type=button value=View> -->
<%
					}else{
%>				
						<span id="ASK<%=itemLineNo%>" ><%=qComnts%></span><!--<input type=button value=Ask> -->
						<span id="HIDE<%=itemLineNo%>" style="display:none"><%=qComnts%></span><!-- <input type=button value=View> -->
<%
					}
%>				
					</a>

					</div>	
					<div id="VIEW<%=itemLineNo%>" style="display:none">
					<!--
					<div class="VIEW<%=itemLineNo%>"><a href="ezNegotiateOrderDetails.jsp#"><span>Click to <br>Ask or View</span></a></div>
					<div id="VIEW<%=itemLineNo%>" style="display:none">
					-->
<%
					if("ACCEPTED".equals(negotiateType))
					{
%>			 	
						<h2>Questions/Responses</h2>
						<p><ul style="list-style-type:square;list-style-position:inside;">
							<li>Ask Customer Care a question(s).</li>
							<li>Customer Care will review and respond back.</li>
							<li>Once you receive a response, you can submit the PO to ASB.</li>
						</ul></p>
						<br>
						<ul class="form-list">
						<li><label for="noteType" class="required">Question Type<em>*</em> </label>
							<div class="input-box">
							<select name="query" id="query<%=itemLineNo%>">
<%
							if(quesRetObj!=null && quesRetObj.getRowCount()>0)
							{
								for(int qu=0;qu<quesRetObj.getRowCount();qu++)
								{
									String quesID = quesRetObj.getFieldValueString(qu,"VALUE1");
									String quesDesc = quesRetObj.getFieldValueString(qu,"VALUE2");
%>
									<option value="<%=quesID%>"><%=quesDesc%></option>
<%
								}
							}
%>
							</select>
							</div>
						</li>
						<li>
							<label for="ponumber" class="required">Question<em>*</em> </label>
							<div class="input-box">
								<textarea name="quesComments" id="qComments<%=itemLineNo%>" cols="80" rows="5"></textarea>
							</div>
						</li>
						<li>
							<input type="button" label="Submit" text="Save and Back" value="Save" onClick="SaveValues('<%=itemLineNo%>')"></input>
						</li>
						</ul>
<%
					}
					if(!"".equals(QKey) && !"null".equals(QKey))
					{
%>				
						<h2>Questions/Responses</h2>
						<%=questionHTML%>				

<%
					}
				}
				else if(!"CU".equals(userRole))
				{
%>
					<div class="VIEW<%=itemLineNo%>">
					<a class="fancybox" href="#VIEW<%=itemLineNo%>"><span id="REPLY<%=itemLineNo%>"><%=qComnts%></span></a>
					</div>
					<div id="VIEW<%=itemLineNo%>" style="width:800px; display:none">
					<h2>Questions/Responses</h2>
					<br>
					<%=questionHTML%>
					</div>	
<%
				}
%>
				<input type="hidden" name="qComnts_<%=itemLineNo%>" id="qComnts_<%=itemLineNo%>" value="<%=qComnts%>">
				</td>
				<td class="a-right"><%=tqty%>&nbsp;
				<input type="hidden" name="totQty_<%=itemLineNo%>" id="totQty_<%=itemLineNo%>" value="<%=tqty%>"></td>
				<td class="a-right">
<%
				String tItemVal = netValue;
				if("CU".equals(userRole) && !"Standard".equals(vipChk) && "CUST".equals(dvActBy)) tItemVal = "TBD";
%>
				<div id="subTotalItem_<%=itemLineNo%>">$<%=checkAuth(tItemVal,"VIEW_PRICES",userAuth_R)%></div></td>
				<td ><%=itemLineNo%></td>
				<td ><%=venCatalog%></td>
				<% if (pntspcs.equals("$")) { %>
				<td id="pointsgroup" ><%=venCatalog%></td>	<!--:<%=pntspcs%><%=(String)catalogHM.get(venCatalog)%>-->
				<%  } else { %>
				<td id="pointsgroup" ><%=venCatalog%>:<%=(String)catalogHM.get(venCatalog)%>&nbsp;<%=pntspcs%></td>
				<% } %>					

				</tr>
<%
			}
		}	
		String soValueBD="0";
		soValueBD = (String)SoValueHT.get(webOrdNo);

		try
		{
			soValueBD = new java.math.BigDecimal(soValueBD).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
		}
		catch(Exception e){
			soValueBD = (String)SoValueHT.get(webOrdNo);
		}		

		//String tTotItemVal = soValueBD.toString();
		String tTotItemVal = grandTotal.setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
		String tFrVal = frieghtTotal.toString();

		if("CU".equals(userRole) && "CUST".equals(dvActBy))
		{
			tTotItemVal = "TBD";
			tFrVal = "TBD";
		}
%>		
			
		</tbody>
		<tfoot>
		<tr>
			<td colspan="9" align="right"><h3>SubTotal</h3></td>
			<td class="a-right">$<span id="subTotalAll"><%=checkAuth(tTotItemVal,"VIEW_PRICES",userAuth_R)%></span>&nbsp;</td>
		</tr>
		<tr>
			<td colspan="9" align="right"><h3>Shipping and Handling</h3></td>
			<td class="a-right">$<span id="shipHand"><%=checkAuth(tFrVal,"VIEW_PRICES",userAuth_R)%></span>&nbsp;
			<input type="hidden" name="shipHandHid" id="shipHandHid" value="<%=tFrVal%>">
			<input type="hidden" name="freightTotal" id="freightTotal" value="<%=frieghtTotal%>"></td>
		</tr>
<%
		//soValueBD = (new java.math.BigDecimal(soValueBD).add(new java.math.BigDecimal(frieghtTotal))).toString();
		soValueBD = (grandTotal.add(new java.math.BigDecimal(frieghtTotal))).toString();

		String tGTotVal = soValueBD.toString();
		if("CU".equals(userRole) && "CUST".equals(dvActBy)) tGTotVal = "TBD";
%>	
		<tr>
			<td colspan="9" align="right"><h3>Grand Total</h3></td>
			<td class="a-right">$<span id="grandTotalAll"><%=checkAuth(tGTotVal,"VIEW_PRICES",userAuth_R)%></span>&nbsp;
			<input type="hidden" name="grandTotalHid" value="<%=tGTotVal%>"></td>
		</tr>
		<!--<tr>
			<td colspan="9" class="a-right last"><h3>Total No. of Lines in Order : <%//=retLinesCount%></h3></td>
		</tr>-->
	</tfoot>
	</table>
	<p><br>
	<div id='backToList' >
	<button type="button" title="Back" class="button" 
	onclick="javascript:goBack()"><span class="left-link">Back</span></button>
	</div>
<%
	if("CU".equals(userRole) && !"CLOSED".equals(negotiateType) && !"INPROCESS".equals(negotiateType))
	{
%>
	<div id='copyToCart' style="float:left">
		<button type="button" title="Edit in Cart" class="button" onclick="javascript:submitOrder('CART','PASS')"><span>Replenish items</span></button>
		<button type="button" title="With Draw" class="button" onclick="javascript:withDraw()"><span>Withdraw</span></button>
	</div>
<%
	}

	if(sdHeaderCnt==0 && !"CLOSED".equals(negotiateType))
	{
%>
		<!--&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:submitOrder('NEW')"><span>Save as Template</span></a>-->
<%
		if("CU".equals(userRole))
		{
			if("".equals(dvActBy) && ("REJECTED".equals(negotiateType) || "INPROCESS".equals(negotiateType) || "ACCEPTED".equals(negotiateType)))
			{
				if(editNegDtl)	
				{
%>
					<div id='review1_1' style="display:none;float:left">
						<button type="button" title="Submit My Question" class="button" 
						onclick="javascript:submitOrder('F','<%=authChk_SO%>')"><span>Submit My Question</span></button>
					</div>
<%
					//if("INPROCESS".equals(negotiateType))
					if("ACCEPTED".equals(negotiateType))
					{
%>
						<div id='review1_11' style="float:left">
							<button type="button" title="Submit to ASB" class="button" 
							onclick="javascript:submitOrder('TRANSFERED','<%=authChk_SO%>')"><span class="right-link">Submit to ASB</span></button>
						</div>
<%
					}
				}
			}
			else if("APPR".equals(dvActBy))
			{
%>
				<div id='review1_11' style="float:left">
					<button type="button" title="Submit to ASB" class="button" 
					onclick="javascript:submitOrder('TRANSFERED','<%=authChk_VD%>')"><span class="right-link">Submit to ASB</span></button>
				</div>
<%
			}
		}
		else if(!"CU".equals(userRole))
		{
			if("".equals(dvActBy) && editNegDtl1 && (!"REJECTED".equals(negotiateType)))
			{
%>
				<div id='accept_1' style="float:left">
					<button type="button" title="Submit My Response" class="button" 
					onclick="javascript:submitOrder('A','<%=authChk_AO%>')"><span>Submit My Response</span></button>
				</div>
				<!--<div id='reject_1' style="float:left">
					<button type="button" title="Reject" class="button" 
					onclick="javascript:submitOrder('R','<%=authChk_AO%>')"><span>Reject</span></button>
				</div>-->
<%
			}
			else if("CUST".equals(dvActBy) && (!"REJECTED".equals(negotiateType)))//&& loginUser.equalsIgnoreCase(dvToAct) 
			{
%>
				<div id='reject_1' style="float:left">
				<a class="fancybox" href="#REJECT" >
					<button type="button" title="Reject" class="button" ><span>Reject</span></button>
				</a>
				</div>
				<div id='review1_11' style="display:none;float:left">
					<button type="button" title="Submit My Response" class="button" 
					onclick="javascript:submitOrder('NEGOTIATED','<%=authChk_VD%>')"><span>Submit My Response</span></button>
				</div>
<%		
			}
%>
			<div id='audit' style="float:left">
				<a class="fancybox" href="#auditId" onclick="javascript:auditTrail()">
				<button type="button" title="Audit" class="button" 
				onclick="javascript:auditTrail()"><span>Audit</span></button></a>
			</div>
<%
		}
		if(noOfDocs>0)
		{
%>
		<div id='POAttachments' style="float:left">
			<a class="fancybox" href="#POATTACHMENTS<%=poNo%>">
			<button type="button" title="Attachments" class="button"><span>Attachments</span></button></a>
		</div>
<%
		}
	}
%>
	</p>
	</table>
	<br><br>
<%
	}
%>
<script>
	//selStdMulti()
</script>

</div> <!-- Info box -->
</div> <!-- col1-set -->
</div> <!-- col-main -->
</div> <!--main -->
</div> <!-- main-container col1-layout -->
</form>
</body>
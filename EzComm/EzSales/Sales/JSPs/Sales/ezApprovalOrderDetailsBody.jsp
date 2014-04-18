<%@ include file="../../../Includes/JSPs/Sales/iEditSaveSales.jsp"%>
<%!
	public static String replaceString(String theString,String from,String to)
	{
		int go=0;
		String ret=theString;
		while (ret.indexOf(from,go)>=0)
		{
			go=ret.indexOf(from,go);
			ret=ret.substring(0,go)+to+ret.substring(go+from.length());
			go=go+to.length();
		}
		return ret;
	}
	public String nullCheck(String str)
	{
		String ret = str;

		if(ret==null || "null".equalsIgnoreCase(ret) || "".equals(ret))
			ret = "N/A";
		return ret;
	}	
%>
<%
	String negotiateType = request.getParameter("negotiateType_A");

	String authChk_SO = "FAIL";
	String authChk_FO = "FAIL";

	ezc.record.util.EzOrderedDictionary userAuth_R = Session.getUserAuth();

	if(userAuth_R.containsKey("FOC_ORDER")) authChk_SO = "PASS";
	if(userAuth_R.containsKey("FOC_APPR")) authChk_FO = "PASS";
%>
<head>
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
	#focorder_wrapper .fg-toolbar { font-size: 0.8em }
	#theme_links span { float: left; padding: 2px 10px; }
	#focorder_wrapper { -webkit-box-shadow: 2px 2px 6px #666; box-shadow: 2px 2px 6px #666; border-radius: 5px; }
	#focorder tbody {
		border-left: 1px solid #AAA;
		border-right: 1px solid #AAA;
	}
	#focorder thead th:first-child { border-left: 1px solid #AAA; }
	#focorder thead th:last-child { border-right: 1px solid #AAA; }
</style>
<style type="text/css">
.a, .b, .c1, .c2 {border:solid thin #DDD}
.bh {	padding:5px;
	border:1px solid #ddd;
	font-weight:bold;
	white-space:nowrap;}
.a {display:table}
.bh {display:table-header-group}
.b {display:table-row}
.c1, .c2 {display:table-cell}
.bhc1, .bhc2 {display:table-cell;background-color:lightgray}
</style>


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
</script>

<script type="text/javascript" src="../../Library/Script/complete.min.js"></script>
<script type="text/javascript" src="../../Library/Script/jquery.dataTables.min.js"></script> 
<script type="text/javascript" src="../../Library/Script/jquery.dataTables.rowGrouping.js"></script>
<script  src="../../Library/Script/colResizable-1.3.min.js"></script>
<script type="text/javascript" src="../../Library/Script/jquery-ui-1.8.21.all.min.js"></script>

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
		/*
		 * Insert a 'details' column to the table
		 */
		var nCloneTh = document.createElement( 'th' );
		var nCloneTd = document.createElement( 'td' );
		var nCloneTd2 = document.createElement( 'td' );
		var nCloneTdEmpty = document.createElement( 'td' );

		$('#focorder thead tr').each( function () {
			// Do not insert empty column in pricing data/condition tables..
			//if ($(this).attr("id") != "condtablehdrrow") {
			//this.insertBefore( nCloneTh, this.childNodes[0] );
			//console.log(" Inserting header column ");
			//}
		} );
		$('#focorder tfoot tr').each( function () {
			//console.log("in footer");
			//this.insertBefore( nCloneTdEmpty, this.childNodes[0] );
		} );
		$('#focorder tbody tr').each( function () {
			//var vCol0 = $(this).find('#socell:first').text();
			var vCol0 = $(this).find('#solineinfo:first').text();
			//console.log(vCol0);

			if (vCol0 !="") {
				var soLine = vCol0;
				var ccompName = 'childComponents'+soLine+'';

				if ($(document.getElementById(ccompName)).val()!=""){
					//console.log("Inserting column with image");
					nCloneTd.innerHTML = '&nbsp;<p align="center"><img src="http://datatables.net/release-datatables/examples/examples_support/details_open.png" id="openimg" name="openimg"></p>';
					this.insertBefore(  nCloneTd.cloneNode( true ), this.childNodes[0] );
				} else {
					//console.log("Inserting Empty Column");
					nCloneTdEmpty.innerHTML = '&nbsp;<p align="center"></p>';
					this.insertBefore(  nCloneTdEmpty.cloneNode( true ), this.childNodes[0] );
				};
			} // end vCol0
			else
			{
				var vPointsGroup = $(this).find('#pointsgroup').text();	
				//console.log(vPointsGroup);
				if (vPointsGroup != ""){
					nCloneTdEmpty.innerHTML = '&nbsp;<p align="center"></p>';
					this.insertBefore(  nCloneTdEmpty.cloneNode( true ), this.childNodes[0] );
					//console.log(" Inserted empty column in grouping row");
				}
			}// end else vCol0
		} );

		$(".fancybox").fancybox({closeBtn:true});

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

		/*
		 * Initialse DataTables, with no sorting on the 'details' column
		 */
		var sortColNr = 1;

		switch ($('#sort_types').val()){
			case "1":
				sortColNr = 7;
				break;
			case "2":
				sortColNr = 8;
				break;
			case "3":
				sortColNr = 9;
				break;
			default:
				sortColNr = 1;
		}

		var oTable = $('#focorder').dataTable( {

		"fnDrawCallback": function ( oSettings ) {
		if ( oSettings.aiDisplay.length == 0 )
		{
			return;
		}
		var nTrs = $('#focorder tbody tr#linedatarow');
		var iColspan = nTrs[0].getElementsByTagName('td').length;
		//console.log("iColspan::"+iColspan);
		var sLastGroup = "";
		for ( var i=0 ; i<nTrs.length ; i++ )
		{
			var iDisplayIndex = oSettings._iDisplayStart + i;
			//console.log("iDisplayIndex:::"+iDisplayIndex);
			var sGroup = oSettings.aoData[ oSettings.aiDisplay[iDisplayIndex] ]._aData[9];
			var sGroupPoint = oSettings.aoData[ oSettings.aiDisplay[iDisplayIndex] ]._aData[10];
			// THIS CODE ASSUMES THAT 10th Column carries the vendor catalog which is hidden info.
			// Also column 11 has the value of points
			//console.log(sGroup);
			//console.log(sGroupPoint);
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
		"oLanguage": { "sSearch": "Search PO Lines" },
		"aoColumnDefs": [
			{ "bSortable": false, "aTargets": [ 0,1,2,3,4,5,6,7 ] },
			{ "bVisible": false, "aTargets": [ 8 ] },
			{ "bVisible": false, "aTargets": [ 9 ] },
			{ "bVisible": false, "aTargets": [ 10 ] }
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
		oTable.fnSortListener( document.getElementById('sorter'), 8 );
		oTable.fnSortListener( document.getElementById('sorter2'), 9 );
	} );
</script>

<script type="text/javascript">
$(function(){
	var onSampleResized = function(e){
		var columns = $(e.currentTarget).find("th");
		var msg = "columns widths: ";
		columns.each()
	};

	$("#focorder").colResizable({
		liveDrag:true,
		gripInnerHtml:"<div class='grip'></div>",
		draggingClass:"dragging",
		onResize:onSampleResized});
});
</script>

<!-- jQuery for sorting & pagination ENDS here -->
<!-- fancy box popup instead of original from rb -->

<!-- Add fancyBox -->
<link rel="stylesheet" href="../../Library/Script/jquery.fancybox.css?v=2.0.5" type="text/css" media="screen" />
<script type="text/javascript" src="../../Library/Script/jquery.fancybox.pack.js?v=2.0.5"></script>

<!-- end of fancybox -->
<!-- Drop down menu on Cancel etc -->
<!-- Style for New Header -->

<Script src="../../Library/Script/popup.js"></Script> 
<!--<script type="text/javascript" src="../../Library/Script/LightBox.js"></script>-->

<!-- Start of the Styles and Scripts for Hello Bar Solo -->
<link type="text/css" rel="stylesheet" href="../../../Includes/Lib/hellobar-solo/hellobar.css" />
<script type="text/javascript" src="../../../Includes/Lib/hellobar-solo/hellobar.js"></script>
<!-- End of the Styles and Scripts for Hello Bar Solo -->

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
</style>
<style>
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
</style>
<%
	String fromPage = request.getParameter("fromPage");
	if("Y".equals(fromPage) )
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
		<input type="hidden" name="orderinforadio" value="<%=request.getParameter("selOrds")%>">
		<input type="hidden" name="webSrch" value="Y">
		<input type="hidden" name="singleList" value="Y">
		
		<!----------------- End ------->
<%
	}
%>	
<script>
	function funReOrder()
	{
		Popup.showModal('modal1');
		document.saveForm.target="_self";
		document.saveForm.action="../ShoppingCart/ezAddCartRepeatOrder.jsp";
		document.saveForm.submit();
	}
	function goBack()
	{
		var sch = '<%=request.getParameter("fromPage")%>'
		if(sch=='Y')
			document.saveForm.action = "../Search/ezQuickSearchDetailsMain.jsp"
		else	
			document.saveForm.action ="ezOrdersForApproval.jsp?negotiateType=<%=negotiateType%>&ORDERTYPE=A";
		document.saveForm.submit();
	}
	function submitOrder(type)
	{
		document.saveForm.status.value=type
		var replyStat = document.saveForm.repFlag.value
		//alert("replyStat:::::::"+replyStat)
		//alert("type:::::::"+type)

		if(type=='CART')
			document.saveForm.action ="../ShoppingCart/ezAddCartSaveOrder.jsp"
		else if(type=='TRANSFERED')	
			document.saveForm.action ="../Sales/ezAddSaveSales.jsp"
		else if(type=='F' )
			document.saveForm.action ="../Sales/ezAddSaveNegotiate.jsp"		
		if(type=='R' && replyStat=='Y')
		{
			document.saveForm.action ="../Sales/ezAddSaveNegotiate.jsp"
		}
		else if(type=='R' && replyStat=='N')
		{
			alert("Please Enter Rejection Reasons")
			return;
		}	
		if(type=='A' && replyStat=='Y')
		{
			document.saveForm.action ="../Sales/ezAddSaveNegotiate.jsp"
		}	
		else if(type=='A' && replyStat=='N')
		{
			alert("Please Reply to the query")
			return;
		}	

		document.saveForm.submit()

	}
	function actionOnOrder(type,authChk)
	{
		if(authChk=='FAIL')
		{
			$("#dialog-authCheck").dialog('open');
			return false;
		}
		else
		{
			document.saveForm.status.value = type;
			if(type=='R') //type=='A' || 
			{
				$("#dialog-confirm1").dialog('open').text("Are you sure to reject the order?");
			}
			else if(type=='TRANSFERED')
			{
				var selSoldTo = document.saveForm.selSoldToInfo.value;
				if(selSoldTo=="")
				{
					$( "#dialog-alert" ).dialog('open').text("Please select FD Expense Account");
					return false;
				}
				else
				{
					document.saveForm.shipToCode.value="0999999999";
					document.saveForm.dropShipTo.value="YES";

					$("#dialog-confirm").dialog('open').text("Are you sure to approve the order?");
				}
			}
		}
	}
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
		document.getElementById("review").style.display=""
		document.getElementById("review1").style.display=""
		document.getElementById("review_1").style.display="none"
		document.getElementById("review_11").style.display="none"

		document.getElementById("ASK"+lineNO).style.display="none"
		document.getElementById("HIDE"+lineNO).style.display=""

		var qObj 	= eval("document.saveForm.qType"+lineNO)
		var quesObj     = eval("document.saveForm.QComments"+lineNO)
		qObj.value	= query
		quesObj.value	= comments
		//alert("qObj.value::::::::"+qObj.value+"::::::quesObj.value:::::::"+quesObj.value)
		document.saveForm.repFlag.value='Y'
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
	}
	function selectedSoldTo()
	{
		var selSoldTo = document.saveForm.selSoldToInfo.value;

		if(selSoldTo!="")
		{
			soldAddr	= selSoldTo.split('¥')[0]
			soldStreet	= selSoldTo.split('¥')[1]
			soldCity	= selSoldTo.split('¥')[2]
			soldState	= selSoldTo.split('¥')[3]
			soldCountry	= selSoldTo.split('¥')[4]
			soldZip		= selSoldTo.split('¥')[5]
			soldPhNum	= selSoldTo.split('¥')[6]
			soldCode	= selSoldTo.split('¥')[7]

			document.saveForm.soldToName.value = soldAddr
			document.saveForm.soldToStreet.value = soldStreet
			document.saveForm.soldToCity.value = soldCity
			document.saveForm.soldToState.value = soldState	
			document.saveForm.soldToCountry.value = soldCountry
			document.saveForm.soldToZipCode.value = soldZip
			document.saveForm.soldToPhNum.value = soldPhNum
			document.saveForm.soldToCode.value = soldCode

			var soldInfo = soldAddr+"<br>"+soldStreet+"<br>"+soldCity+" "+soldState+", "+soldZip+" "+soldCountry;
			document.getElementById("divSoldToSel").innerHTML = soldInfo;
			document.getElementById("divSoldToSel").style.display="block";
		}
		else
		{
			document.getElementById("divSoldToSel").innerHTML = "";
			document.getElementById("divSoldToSel").style.display="none";
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
	function selDefCatL1()
	{
		var defCat1 = document.saveForm.defCat1.value;

		if(defCat1!="")
			selDefCatLevels(defCat1,"defCat2");
	}
	function selDefCatL2()
	{
		var defCat2 = document.saveForm.defCat2.value;

		if(defCat2!="")
			selDefCatLevels(defCat2,"defCat3");
	}
	var defCat;
	var defFlag;
	function selDefCatLevels(val1,val2)
	{
		defCat = val1;
		defFlag = val2;

		Popup.showModal('modal1');

		if(typeof XMLHttpRequest != "undefined")
		{
			xmlHttp = new XMLHttpRequest();
		}
		else if(window.ActiveXObject)
		{
			xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		if(xmlHttp==null)
		{
			Popup.hide('modal1');
			alert("Browser does not support XMLHTTP Request")
			return;
		}

		if(xmlHttp!=null)
		{
			var url = "ezGetDefCategories.jsp?defCat="+defCat+"&defFlag="+defFlag;
			xmlHttp.onreadystatechange = process2;
			xmlHttp.open("GET", url, true);
			xmlHttp.send(null);
		}
		else
			Popup.hide('modal1');
	}
	function process2()
	{
		if(xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
		{
			Popup.hide('modal1');

			if(defFlag=='defCat1')
			{
				document.getElementById("defCat1").innerHTML=xmlHttp.responseText
				document.getElementById("defCat2").innerHTML=""
				document.getElementById("defCat3").innerHTML=""
			}
			else if(defFlag=='defCat2')
			{
				document.getElementById("defCat2").innerHTML=xmlHttp.responseText
				document.getElementById("defCat3").innerHTML=""
			}
			else if(defFlag=='defCat3')
				document.getElementById("defCat3").innerHTML=xmlHttp.responseText
		}
	}
	function getProductDetails(code)
	{
		document.saveForm.prodCode_D.value=code;

		document.saveForm.action="../Catalog/ezProductDetails.jsp";
		document.saveForm.target="_blank";
		document.saveForm.submit();
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
		$( "#dialog-confirm" ).dialog({
			autoOpen: false,
			resizable: true,
			height:200,
			width:400,
			modal: true,
			buttons: {
				"Ok": function() {
					$( this ).dialog( "close" );

					Popup.showModal('modal1');
					document.saveForm.action ="../Sales/ezEditSaveSales.jsp";
					document.saveForm.target="_self";
					document.saveForm.submit();
				},
				"Cancel": function() {
					$( this ).dialog( "close" );
				}
			}
		});
		$( "#dialog-confirm1" ).dialog({
			autoOpen: false,
			resizable: true,
			height:200,
			width:400,
			modal: true,
			buttons: {
				"Ok": function() {
					$( this ).dialog( "close" );

					Popup.showModal('modal1');
					document.saveForm.action ="../Sales/ezAddSaveApproval.jsp";
					document.saveForm.target="_self";
					document.saveForm.submit();
				},
				"Cancel": function() {
					$( this ).dialog( "close" );
				}
			}
		});
		$( "#dialog-alert" ).dialog({
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
</script>
</head>
<body>
<form name="saveForm" id="saveForm" method='post' >
<div class="main-container col2-left-layout middle account-pages">
<div class="main">
<div class="col-main1 roundedCorners">
<div class="page-title">
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
	
	String poNo 	 = sdHeader.getFieldValueString(0,"PO_NO");
	String webOrderNo= sdHeader.getFieldValueString(0,"WEB_ORNO"); 
	String createdBy = sdHeader.getFieldValueString(0,"CREATE_USERID");
	String poDate	 = ret.getFieldValueString(0,"PURCH_DATE");
	String reqDate 	 = ret.getFieldValueString(0,"REQ_DATE");
	String complDlv	 = sdHeader.getFieldValueString(0,"DLVFLAG");
	String comments = sdHeader.getFieldValueString(0,"TEXT2");
	String sys_key	 = sdHeader.getFieldValueString(0,"SALES_AREA");
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

	if(frieghtTotal==null || "null".equalsIgnoreCase(frieghtTotal) || "".equals(frieghtTotal.trim())) frieghtTotal = "0";

	//Sold to Address
	
	String soldTo_S		= sdHeader.getFieldValueString(0,"AGENT_CODE");
	String soldName		= sdSoldTo.getFieldValueString(0,"SOTO_NAME");
	String soldStreet	= sdSoldTo.getFieldValueString(0,"SOTO_ADDR1");
	String soldCity		= sdSoldTo.getFieldValueString(0,"SOTO_ADDR2");
	String soldState	= sdSoldTo.getFieldValueString(0,"SOTO_STATE");
	String soldCountry	= sdSoldTo.getFieldValueString(0,"SOTO_COUNTRY");
	String soldZip		= sdSoldTo.getFieldValueString(0,"SOTO_ZIPCODE");
	
	if(soldName!=null && !"null".equals(soldName) && !"".equals(soldName.trim()))
		soldToAddress = soldToAddress + soldName +"<br>";
	if(soldStreet!=null && !"null".equals(soldStreet) && !"".equals(soldStreet.trim()))
		soldToAddress = soldToAddress + soldStreet +"<br>";
	if(soldCity!=null && !"null".equals(soldCity) && !"".equals(soldCity.trim()))
		soldToAddress = soldToAddress + soldCity +", ";
	if(soldZip!=null && !"null".equals(soldZip) && !"".equals(soldZip.trim()))
		soldToAddress = soldToAddress + soldZip +" ";
	if(soldState!=null && !"null".equals(soldState) && !"".equals(soldState.trim()))
		soldToAddress = soldToAddress + soldState +" ";
	if(soldCountry!=null && !"null".equals(soldCountry) && !"".equals(soldCountry.trim()))
		soldToAddress = soldToAddress + soldCountry +"<br>";
	//if(soldToPhNum!=null && !"null".equals(soldToPhNum) && !"".equals(soldToPhNum.trim()))
		//soldToAddress = soldToAddress + soldToPhNum +"<br>";
	
	
	//Ship to Address
	
	String shipTo_S		= sdShipTo.getFieldValueString(0,"SHIP_TO_CODE");
	String shipName		= sdShipTo.getFieldValueString(0,"SHTO_NAME");
	String shipStreet	= sdShipTo.getFieldValueString(0,"SHTO_ADDR1");
	String shipCity		= sdShipTo.getFieldValueString(0,"SHTO_ADDR2");
	String shipState	= sdShipTo.getFieldValueString(0,"SHTO_STATE");
	String shipCountry	= sdShipTo.getFieldValueString(0,"SHTO_COUNTRY");
	String shipZip		= sdShipTo.getFieldValueString(0,"SHTO_ZIPCODE");
	
	//if(shipTo_S!=null && !"null".equals(shipTo_S) && !"".equals(shipTo_S.trim()))
	//	shipToAddress = shipToAddress + shipTo_S +"<br>";
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
		shipToAddress = shipToAddress + shipCountry +" ";
	
	if(shipName==null || "null".equalsIgnoreCase(shipName)) shipName = "";
	if(shipStreet==null || "null".equalsIgnoreCase(shipStreet)) shipStreet = "";
	if(shipCity==null || "null".equalsIgnoreCase(shipCity)) shipCity = "";
	if(shipZip==null || "null".equalsIgnoreCase(shipZip)) shipZip = "";
	if(shipState==null || "null".equalsIgnoreCase(shipState)) shipState = "";
	if(shipCountry==null || "null".equalsIgnoreCase(shipCountry)) shipCountry = "";
	
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
		
	if(carrierName==null || "null".equalsIgnoreCase(carrierName)) carrierName = "";
	if(carrierId==null || "null".equalsIgnoreCase(carrierId)) carrierId = "";
	if(billToName==null || "null".equalsIgnoreCase(billToName)) billToName = "";
	if(billToAddr1==null || "null".equalsIgnoreCase(billToAddr1)) billToAddr1 = "";
	if(billToAddr2==null || "null".equalsIgnoreCase(billToAddr2)) billToAddr2 = "";
	if(billToStreet==null || "null".equalsIgnoreCase(billToStreet)) billToStreet = "";
	if(billToCity==null || "null".equalsIgnoreCase(billToCity)) billToCity = "";
	if(billToState==null || "null".equalsIgnoreCase(billToState)) billToState = "";
	if(billToZipCode==null || "null".equalsIgnoreCase(billToZipCode)) billToZipCode = "";
	if(billToPHNO==null || "null".equalsIgnoreCase(billToPHNO)) billToPHNO = "";

	if(!"".equals(billToPHNO))
		shipToAddress = shipToAddress + "<br>Tel#:" +billToPHNO +"<br>";
	
	String complDlv_C	= sdHeader.getFieldValueString(0,"DLVFLAG"); //ESDH_COMPL_DLV needed to be added in query
	billToAddress = billToName+","+","+billToAddr1+","+billToAddr1+billToStreet+","+billToCity+","+billToState+","+billToZipCode;
	String dlvCheck 	= "";
	if("Y".equals(complDlv_C)) dlvCheck="checked";

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

		String negItemNO = "";
		String negIndex	 = "";
		String negQType	 = "";
		String negQCat	 = "";
		String negText	 = "";
		String negCat	 = "";
		String negCreatedBy = "";
		String createdOn = "";
		String ordStatus = "";
		String ordShipText = "";

		if(retNegOrderDtl!=null && retNegOrderDtl.getRowCount()>0)
		{
			quesHash = new Hashtable();
			ansHash  = new Hashtable();
			noQHash  = new Hashtable();
			replSpList=new ArrayList();
			Vector tempVec	   = new Vector();
			int negDtlCnt	   = retNegOrderDtl.getRowCount();
			
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
				ordStatus	= retNegOrderDtl.getFieldValueString(n,"EON_STATUS");
				ordShipText	= retNegOrderDtl.getFieldValueString(n,"EON_EXT1");
				String tempIndex= negItemNO+""+negIndex;
				modiBy 		= retNegOrderDtl.getFieldValueString(0,"EON_MODIFIED_BY");
				if("N/A".equals(negCat))
					replSpList.add(WEB_ORNO);
				
				if("Q".equals(negQType)) 
				{
					//if(!("N/A".equals(negCat)))
					{
						quesHash.put(negItemNO+""+negIndex,negText+"##"+negCat+"##"+negCreatedBy+"##"+createdOn);	
					
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
					ansHash.put(negItemNO+""+negIndex,negText+"##"+negCat+"##"+negCreatedBy+"##"+createdOn);
					
			}
			ezc.ezcommon.EzLog4j.log("quesHash::::::::"+quesHash ,"I");
			ezc.ezcommon.EzLog4j.log("noQHash::::out LOOP::::"+noQHash ,"I");
			ezc.ezcommon.EzLog4j.log("dispBool::::out LOOP::::"+dispBool ,"I");
			ezc.ezcommon.EzLog4j.log("replSpList::::::::"+replSpList ,"I");
			ezc.ezcommon.EzLog4j.log("ansHash::::::::"+ansHash ,"I");
		
		}
		
		if("CU".equals(userRole.trim()) && (quesHash.size()+"").equals(ansHash.size()+"") )
			editNegDtl = true;
		else if(!"CU".equals(userRole.trim()) && (!(quesHash.size()+"").equals(ansHash.size()+"")) )
			editNegDtl1 = true;	
		String statMsg="ORDER IS PENDING FOR APPROVAL";
		if(!editNegDtl && "CU".equals(userRole.trim()))
			statMsg = "Order is with American Standard for pending Approval . Please contact Customer Care if you have follow on questions.";

		if("FOCREJECTED".equals(ordStatus)) statMsg = "REJECTED";
		else if("FOCACCEPTED".equals(ordStatus) || "FOCAPPROVED".equals(ordStatus)) statMsg = "APPROVED";
		
	/*********** Negotiation Details End******/
	
	//out.println("userRole::::::::::::::::::::"+userRole);	
	//out.println("ordStatus::::::::::::::::::::"+ordStatus);

	ReturnObjFromRetrieve fdActRetObj = null;

	EzcParams focParamsMisc = new EzcParams(false);
	EziMiscParams focParams = new EziMiscParams();

	String purposeOrder = negQType;
	String reasonCode = negCat;
	String approver = negIndex;

	//if(approver==null || "null".equalsIgnoreCase(approver) || "".equals(approver))
	{
		if(purposeOrder!=null && !"".equals(purposeOrder)) purposeOrder = purposeOrder.trim();

		focParams.setIdenKey("MISC_SELECT");

		String query = "SELECT VALUE2 FROM EZC_VALUE_MAPPING WHERE MAP_TYPE='PURPTOAPPR' AND VALUE1='"+purposeOrder+"' AND VALUE2='"+currId+"'";

		focParams.setQuery(query);

		focParamsMisc.setLocalStore("Y");
		focParamsMisc.setObject(focParams);
		Session.prepareParams(focParamsMisc);	

		try
		{
			ReturnObjFromRetrieve fdAppRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(focParamsMisc);
			if(fdAppRetObj!=null && fdAppRetObj.getRowCount()>0)
				approver = fdAppRetObj.getFieldValueString(0,"VALUE2");
		}
		catch(Exception e){}
	}

	if(approver!=null && !"null".equalsIgnoreCase(approver) && !"".equals(approver))
	{
		approver = approver.trim();

		focParams.setIdenKey("MISC_SELECT");

		String query = "SELECT VALUE2 FROM EZC_VALUE_MAPPING WHERE MAP_TYPE='APPRTOACCT' AND VALUE1='"+approver+"'";

		focParams.setQuery(query);

		focParamsMisc.setLocalStore("Y");
		focParamsMisc.setObject(focParams);
		Session.prepareParams(focParamsMisc);	

		try
		{
			fdActRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(focParamsMisc);
		}
		catch(Exception e){}
	}

	if(fdActRetObj!=null)
	{
		String soldTo_A = "";

		for(int i=0;i<fdActRetObj.getRowCount();i++)
		{
			String tempSold_A = fdActRetObj.getFieldValueString(i,"VALUE2");
			tempSold_A = "0000000000"+tempSold_A;
			tempSold_A = tempSold_A.substring(tempSold_A.length()-10,tempSold_A.length());

			if("".equals(soldTo_A))
				soldTo_A = tempSold_A;
			else
				soldTo_A = soldTo_A+"','"+tempSold_A;
		}
		focParams.setIdenKey("MISC_SELECT");

		String query = "SELECT DISTINCT A.*, B.* FROM EZC_CUSTOMER A , EZC_CUSTOMER_ADDR B WHERE A.EC_PARTNER_FUNCTION IN ('AG') AND A.EC_ERP_CUST_NO IN ('"+soldTo_A+"') AND B.ECA_LANG = 'EN' AND A.EC_NO = B.ECA_NO";

		focParams.setQuery(query);

		focParamsMisc.setLocalStore("Y");
		focParamsMisc.setObject(focParams);
		Session.prepareParams(focParamsMisc);	

		try
		{
			fdActRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(focParamsMisc);
		}
		catch(Exception e){}
	}

	String defCat1 = sdHeader.getFieldValueString(0,"DEFCAT_L1");
	String defCat2 = sdHeader.getFieldValueString(0,"DEFCAT_L2");
	String defCat3 = sdHeader.getFieldValueString(0,"DEFCAT_L3");

	if(defCat1==null || "null".equalsIgnoreCase(defCat1)) defCat1 = request.getParameter("defCat1");
	if(defCat2==null || "null".equalsIgnoreCase(defCat2)) defCat2 = request.getParameter("defCat2");
	if(defCat3==null || "null".equalsIgnoreCase(defCat3)) defCat3 = request.getParameter("defCat3");

	ReturnObjFromRetrieve retObjDefCat = null;
	ReturnObjFromRetrieve retObjDefCond = null;
	boolean showDefCat = false;

	if(purposeOrder!=null && !"null".equalsIgnoreCase(purposeOrder) && !"".equals(purposeOrder))
	{
		focParams.setIdenKey("MISC_SELECT");

		String query = "SELECT MAP_TYPE,VALUE1 FROM EZC_VALUE_MAPPING WHERE MAP_TYPE='DEFCOND' AND VALUE1='"+purposeOrder+"'";

		focParams.setQuery(query);

		focParamsMisc.setLocalStore("Y");
		focParamsMisc.setObject(focParams);
		Session.prepareParams(focParamsMisc);	

		try
		{
			retObjDefCond = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(focParamsMisc);
		}
		catch(Exception e){}

		if(retObjDefCond!=null && retObjDefCond.getRowCount()>0)
			showDefCat = true;
	}

	/*
	if(purposeOrder!=null && "Missing Parts".equals(purposeOrder))
	{
		if(reasonCode!=null && ("F07".equals(reasonCode) || "F14".equals(reasonCode))) showDefCat = true;
	}
	if(purposeOrder!=null && "Warranty Replacement".equals(purposeOrder))
	{
		if(reasonCode!=null && ("F07".equals(reasonCode) || "F13".equals(reasonCode))) showDefCat = true;
	}
	*/

	if(showDefCat)
	{
		focParams.setIdenKey("MISC_SELECT");

		String query = "SELECT MAP_TYPE,VALUE1,VALUE2 FROM EZC_VALUE_MAPPING WHERE MAP_TYPE IN ('DEFCATL1','DEFCATL2','DEFCATL3')";

		focParams.setQuery(query);

		focParamsMisc.setLocalStore("Y");
		focParamsMisc.setObject(focParams);
		Session.prepareParams(focParamsMisc);	

		try
		{
			retObjDefCat = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(focParamsMisc);
		}
		catch(Exception e){}
	}

	boolean toApprFOC = false;
	if(approver.equalsIgnoreCase(loginUser) || negIndex.equalsIgnoreCase(loginUser)) toApprFOC = true;
%>
	<div class="highlight" style="height:75px" >
	<div class="printE" style="float:right; display:none;">
		<img src="../../Library/Styles/logorevised.png" height="55px" width="237px">
	</div>
	<div style="width: 100%; float: left">
		<br><font size="5" color="black"><b>&nbsp;&nbsp;FD ORDER</b> </font><br>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>PO ID:</strong>&nbsp;<%=poNo%><strong> PO DATE:</strong>&nbsp;<%=poDate%><br>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>STATUS:</strong> <%=statMsg%><br>
	</div>
	</div><br>
	<button type="button" title="Back" class="button" onclick="javascript:history.go(-1)"><span class="left-link noprint">Back</span></button>
<%
	if("FOCREJECTED".equals(ordStatus))
	{
%>
	<button type="button" title="Replenish Items" class="button" onclick="javascript:funReOrder()"><span>Replenish Items</span></button>
<%
	}
	if(sdHeaderCnt==0)
	{
		if(!"CU".equals(userRole) && editNegDtl1 && (!"REJECTED".equals(negotiateType)))
		{
%>
			<button type="button" title="Reject" class="button" onclick="javascript:submitOrder('R','<%=authChk_FO%>')">
			<span >Reject</span></button>
			<button type="button" title="Accept" class="button" onclick="javascript:submitOrder('A','<%=authChk_FO%>')">
			<span class="right-link">Accept</span></button>
<%
		}
		else if(!"CU".equals(userRole))
		{
			//out.println("::"+loginUser+"::");
			//out.println("::"+createdBy+"::");
			//out.println("---"+negIndex);
			if("FORAPPROVAL".equals(ordStatus) && toApprFOC) // MB for FOC orders accept or reject only if one is approver
			{
%>
				<button type="button" title="Reject" class="button" onclick="javascript:actionOnOrder('R','<%=authChk_FO%>')">
				<span >Reject</span></button>
				<button type="button" title="Approve" class="button" onclick="javascript:actionOnOrder('TRANSFERED','<%=authChk_FO%>')">
				<span class="right-link">Approve</span></button>
<%
			}
			createdBy = createdBy.trim();

			//if("FOCAPPROVED".equals(ordStatus) && createdBy.equalsIgnoreCase(loginUser)) // MB --> for FOC orders, approver cannot be the one to post to SAP
			//{
%>
				<!--<button type="button" title="Submit to ASB" class="button" onclick="javascript:actionOnOrder('TRANSFERED','<%//=authChk_SO%>')" id="review_1">
				<span class="right-link">Submit to ASB</span></button>-->
<%
			//}
		}
	}
	String attachFile = "";
	if(noOfDocs>0)
	{
%>
		<div id='POAttachments' style="float:left">
			<a class="fancybox" href="#POATTACHMENTS<%=poNo%>">
			<button type="button" title="Attachments" class="button"><span>Attachments</span></button></a>
		</div>
		<div id="POATTACHMENTS<%=poNo%>" style="width: 400px; display: none; ">
		<h2>Attachments for PO: <%=poNo%></h2>
<%
		for(int acount=0;acount<retUploadDocs.getRowCount();acount++)
		{
			String openFile = retUploadDocs.getFieldValueString(acount,"SERVERFILENAME");
			String clientFileName = retUploadDocs.getFieldValueString(acount,"CLIENTFILENAME");

			if("".equals(attachFile))
				attachFile = openFile+"§"+clientFileName;
			else
				attachFile = attachFile+"$$"+openFile+"§"+clientFileName;
%>
			<a href="javascript:openFileAttach(<%=acount%>)"><%=clientFileName%></a>
			<input type="hidden" name="fileName_<%=acount%>" id="fileName_<%=acount%>" value="<%=openFile%>">
			<br>
<%
		}
%>
		</div>
<%
	}
	if(!"".equals(attachFile)) attachFile = replaceString(attachFile,"\\","¥");
	//out.println("attachFile>>"+replaceString(attachFile,"¥","/"));
%>
<input type="hidden" name="attachFile" value="<%=attachFile%>">
<br><br><br>
</div>
<div class="col3-set">
	<div class="col-1">
	<div class="info-box">
		<h2 class="sub-title">shipping Address</h2>
		<p><%=shipToAddress%></p>
	</div>
	</div>
	<div class="col-2">
	<div class="info-box">
		<h2 class="sub-title"><label class="required">FD Exp. Int A/c code<em>*</em></label></h2>
		<!--<p><%=soldToAddress%></p>-->
		<div class="input-box">
		<div style="padding-bottom:10px">
		<select id="selSoldToInfo" name="selSoldToInfo" style="width:100%;" onChange="selectedSoldTo()" required>
		<option value="">------Select------</option>
<%
		String selSoldName 	= "";
		String selSoldAddr1	= "";
		String selSoldCity 	= "";
		String selSoldState 	= "";
		String selSoldCountry 	= "";
		String selSoldZipCode	= "";
		String selSoldPhNum 	= "";
		String selSoldEmail 	= "";

		if(fdActRetObj!=null)
		{
			java.util.ArrayList fdAct_AL = new java.util.ArrayList();

			for(int i=0;i<fdActRetObj.getRowCount();i++)
			{
				String blockCode_A 	= fdActRetObj.getFieldValueString(i,"ECA_EXT1");
				if(blockCode_A==null || "null".equalsIgnoreCase(blockCode_A)) blockCode_A = "";

				if(!"BL".equalsIgnoreCase(blockCode_A))
				{

				String soldToCode_A 	= fdActRetObj.getFieldValueString(i,"EC_ERP_CUST_NO");
				String soldToName_A 	= fdActRetObj.getFieldValueString(i,"ECA_NAME");

				if(fdAct_AL.contains(soldToCode_A))
					continue;

				fdAct_AL.add(soldToCode_A);

				String selected_A = "";

				if(soldTo_S!=null && soldTo_S.equals(soldToCode_A))
					selected_A	= "selected";

				selSoldName 	= fdActRetObj.getFieldValueString(i,"ECA_NAME");
				selSoldAddr1	= fdActRetObj.getFieldValueString(i,"ECA_ADDR_1");
				selSoldCity 	= fdActRetObj.getFieldValueString(i,"ECA_CITY");
				selSoldState 	= fdActRetObj.getFieldValueString(i,"ECA_DISTRICT");
				selSoldCountry 	= fdActRetObj.getFieldValueString(i,"ECA_COUNTRY");
				selSoldZipCode	= fdActRetObj.getFieldValueString(i,"ECA_POSTAL_CODE");
				selSoldPhNum 	= fdActRetObj.getFieldValueString(i,"ECA_PHONE");
				selSoldEmail 	= fdActRetObj.getFieldValueString(i,"ECA_EMAIL");

				selSoldAddr1 	= (selSoldAddr1==null || "null".equals(selSoldAddr1)|| "".equals(selSoldAddr1))?"":selSoldAddr1;
				selSoldCity 	= (selSoldCity==null || "null".equals(selSoldCity)|| "".equals(selSoldCity))?"":selSoldCity;// for city
				selSoldState 	= (selSoldState==null || "null".equals(selSoldState) || "".equals(selSoldState))?"":selSoldState;
				selSoldCountry 	= (selSoldCountry==null || "null".equals(selSoldCountry)|| "".equals(selSoldCountry))?"":selSoldCountry.trim();
				selSoldZipCode 	= (selSoldZipCode==null || "null".equals(selSoldZipCode)|| "".equals(selSoldZipCode))?"":selSoldZipCode;
				selSoldPhNum 	= (selSoldPhNum==null || "null".equals(selSoldPhNum)|| "".equals(selSoldPhNum))?"":selSoldPhNum;
				selSoldEmail 	= (selSoldEmail==null || "null".equals(selSoldEmail)|| "".equals(selSoldEmail))?"":selSoldEmail;

				String soldParams = selSoldName+"¥"+selSoldAddr1+"¥"+selSoldCity+"¥"+selSoldState+"¥"+selSoldCountry+"¥"+selSoldZipCode+"¥"+selSoldPhNum+"¥"+soldToCode_A;
%>
				<option value="<%=soldParams%>" <%=selected_A%>><%=soldToCode_A%>(<%=soldToName_A%>)</option>
<%
				}
			}
		}
%>
		</select>
		</div>
		<div id="divSoldToSel" style="display:none">
		</div>
		</div>
	</div>
	</div>
	<!-- Col 2 of Order Header -->
	<div class="col-3">
	<div class="info-box">
		<h2 class="sub-title">Shipping Method </h2>
		<p><input type="checkbox" name="shipComplete" value="yes" <%=dlvCheck%> disabled> Ship Complete(Restrictions Apply<em>*</em>)</input><br>
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
			Desired Ship Date  : <%=reqDate%> <br>
<%
		}
%>
		<!--  : Best Way <br>-->
<%
	if(!"".equals(carrierName) && !"STD".equals(carrierName))
	{
		if ("STD".equals(carrierName))
		{
			shipPartnRole="";billToName = "";billToState = "";billToZipCode = "";billToAddress = "";billToCity = "";billToStreet = "";
		}	
%>
		Shipping Mode  : <%=carrierName%> <br>
		A/c with Carrier: <%=carrierId%><br>
		<strong>BILLING DETAILS WITH SHIPPER</strong><br>
		<%=billToName%><br>
		<%=billToStreet%><br>
		<%=billToCity%>&nbsp;&nbsp; <%=billToState%> <%=billToZipCode%> 
<%
	}
	//else
	//{
%>
		<!--Shipping Mode  : Standard <br>
		A/c with Carrier: N/A<br>
		<strong>BILLING DETAILS WITH SHIPPER</strong><br>
		N/A-->
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
		<h2 class="sub-title">FOC Details</h2>
		<p>
			<strong>Purpose of Order</strong><br><%=negQType%><br>
			<strong>Reason Code</strong><br><%=negCat%><br>
			<strong>Chosen Approver</strong><br><%=negIndex%><br>
		</p>
	</div>
	</div>
	<div class="col-2">
	<div class="info-box">
		<h2 class="sub-title">Explanation</h2>
		<p><%=negText%></p>
	</div>
	<div class="info-box">
		<h2 style="font-size:15px;padding-top:10px">Shipping Text</h2>
		<p><%=ordShipText%></p>
	</div>
	</div>
	<!-- Col 2 of Order Header -->
	<div class="col-3">
	<div class="info-box">
		<h2 class="sub-title">Defect Categories</h2>
		<ul class="form-list">
<%
		if(showDefCat)
		{
%>
		<li style="padding-top: 10px">
			<label for="defCat1" class="required">Category Level 1</label>
			<div class="input-box">
			<div>
			<select id="defCat1" name="defCat1" title="Category Level 1" onChange="selDefCatL1()">
			<option value="">------Select------</option>
<%
			if(retObjDefCat!=null)
			{
				for(int i=0;i<retObjDefCat.getRowCount();i++)
				{
					String mapType = retObjDefCat.getFieldValueString(i,"MAP_TYPE");
					if("DEFCATL1".equals(mapType))
					{
						String value1 = retObjDefCat.getFieldValueString(i,"VALUE1");
						String value2 = retObjDefCat.getFieldValueString(i,"VALUE2");

						String selected_A = "";

						if(defCat1!=null && defCat1.equals(value1))
							selected_A	= "selected";
%>
						<option value="<%=value1%>" <%=selected_A%>><%=value1%></option>
<%
					}
				}
			}
%>
			</select>
			</div>
			</div>
		</li>
		<li>
			<label for="defCat2" class="required">Category Level 2</label>
			<div class="input-box">
			<div>
			<select id="defCat2" name="defCat2" title="Category Level 2" onChange="selDefCatL2()">
			<option value="">------Select------</option>
<%
			if(retObjDefCat!=null)
			{
				for(int i=0;i<retObjDefCat.getRowCount();i++)
				{
					String mapType = retObjDefCat.getFieldValueString(i,"MAP_TYPE");
					String value1 = retObjDefCat.getFieldValueString(i,"VALUE1");

					if("DEFCATL2".equals(mapType) && defCat1.equals(value1))
					{
						String value2 = retObjDefCat.getFieldValueString(i,"VALUE2");

						String selected_A = "";

						if(defCat2!=null && defCat2.equals(value2))
							selected_A	= "selected";
%>
						<option value="<%=value2%>" <%=selected_A%>><%=value2%></option>
<%
					}
				}
			}
%>
			</select>
			</div>
			</div>
		</li>
		<li>
			<label for="defCat3" class="required">Category Level 3</label>
			<div class="input-box">
			<div>
			<select id="defCat3" name="defCat3" title="Category Level 3">
			<option value="">------Select------</option>
<%
			if(retObjDefCat!=null)
			{
				for(int i=0;i<retObjDefCat.getRowCount();i++)
				{
					String mapType = retObjDefCat.getFieldValueString(i,"MAP_TYPE");
					String value1 = retObjDefCat.getFieldValueString(i,"VALUE1");
					if("DEFCATL3".equals(mapType) && defCat2.equals(value1))
					{
						String value2 = retObjDefCat.getFieldValueString(i,"VALUE2");

						String selected_A = "";

						if(defCat3!=null && defCat3.equals(value2))
							selected_A	= "selected";
%>
						<option value="<%=value2%>" <%=selected_A%>><%=value2%></option>
<%
					}
				}
			}
%>
			</select>
			</div>
			</div>
		</li>
<%
		}
		else
		{
%>
		<li style="padding-top: 10px">N/A</li>
<%
		}
%>
		</ul>
	</div>
	</div> <!-- Col 3 of Order Header -->
</div> <!-- End of header Column 3 Set -->
<br>
<div class="col3-set">
	<div class="col-1">
	<div class="info-box">
		<h2 class="sub-title" style="padding-top:10px"></h2>
	</div>
	</div>
	<div class="col-2">
	<div class="info-box">
		<h2 class="sub-title" style="padding-top:10px"></h2>
	</div>
	</div>
	<div class="col-3">
	<div class="info-box">
		<h2 class="sub-title" style="padding-top:10px"></h2>
	</div>
	</div>
</div>	

<input type="hidden" name="toAct" value='<%=negCreatedBy%>'>
<input type="hidden" name="purOfOrder" value='<%=negQType%>'>
<input type="hidden" name="reasonCode" value='<%=negCat%>'>
<input type="hidden" name="explanation" value='<%=negText%>'>
<input type="hidden" name="prodCode_D">
<input type="hidden" name="sys_key" value="<%=sys_key%>">
<input type="hidden" name="catType_C" value="FOC">
<input type="hidden" name="eddFlag" value="<%=eddFl%>">

<div id="dialog-confirm" title="Confirmation" style="display:none">
</div>
<div id="dialog-confirm1" title="Confirmation" style="display:none">
</div>
<div id="dialog-alert" title="Alert" style="display:none">
</div>
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

<input type="hidden" name="poDate" value='<%=poDate%>'>
<input type="hidden" name="soldTo_S" value='<%=soldTo_S%>'>
<input type="hidden" name="complDlv_C" value='<%=complDlv_C%>'>
<input type="hidden" name="carrierName" value='<%=carrierName%>'>
<input type="hidden" name="reqDate" value='<%=reqDate%>'>
<input type="hidden" name="carrierId" value='<%=carrierId%>'>
<input type="hidden" name="billToName" value='<%=billToName%>'>
<input type="hidden" name="billToStreet" value='<%=billToStreet%>'>
<input type="hidden" name="billToCity" value='<%=billToCity%>'>
<input type="hidden" name="billToState" value='<%=billToState%>'>
<input type="hidden" name="billToZipCode" value='<%=billToZipCode%>'>
<input type="hidden" name="billToAddress" value='<%=negText%>'>
<input type="hidden" name="incoTerms_O" value="">
<input type="hidden" name="custGrp5" value="">
<input type="hidden" name="custCondGrp3" value="">

<input type="hidden" name="shipTo_S" value='<%=shipTo_S%>'>
<input type="hidden" name="poNumber" value="<%=poNo%>">

<input type="hidden" name="desiredDate" value="<%=reqDate%>">
<input type="hidden" name="expectedDel" value="<%=reqDate%>">
<input type="hidden" name="expEDDFlag" value="N">
<input type="hidden" name="complDlv" value="<%=complDlv%>">
<input type="hidden" name="Currency" value="<%=Currency%>">
<input type="hidden" name="shipMethod" value="<%=carrierName%>">
<input type="hidden" name="comments" value="<%=comments%>">
<input type="hidden" name="shipInst" value="<%=ordShipText%>">

<input type="hidden" name="shipPartnRole" value="N/A">
<input type="hidden" name="soldToCode" value="<%=soldTo_S%>">
<input type="hidden" name="shipToCode" value="<%=shipTo_S%>">
<input type="hidden" name="dropShipTo">

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
<input type="hidden" name="shipToPhNum" value="<%=billToPHNO%>">

<input type="hidden" name="shipToZip" value="<%=shipZip%>">
<input type="hidden" name="shipToPhone" value="<%=billToPHNO%>">

<input type="hidden" name="status">

<input type="hidden" name="quesHash" value="<%=quesHash.size()%>">
<input type="hidden" name="ansHash" value="<%=ansHash.size()%>">
<input type="hidden" name="negotiateType" value="<%=negotiateType%>">
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
</div>
</div>
<div class="col1-set">
<div class="info-box">
<%
	if(sdHeaderCount>0 && retLinesCount>0)
	{
%>	
		<!--<h2 class="sub-title">Items Ordered </h2>-->
		<table class="data-table" id="focorder">
		<thead>
		<tr>
		<th width="4%" class="a-center">&nbsp</th>
		<th width="13%" class="a-center">Brand</th>
		<th width="19%" class="a-center">Product Information</th>
		<th width="12%" class="a-center">List Price</th>
		<th width="12%" class="a-center">Multiplier</th>
		<th width="12%" class="a-center">Landed Cost</th>
		<th width="12%" class="a-center">Order Qty</th>
		<th width="13%" class="a-center">SubTotal</th>
		<th width="1%" id='custItemNo'></th>
		<th width="1%" id='custmat35'></th>
		<th width="1%" id='custmat35pts'></th>
		</tr>
		</thead>
		<tbody>
<%
		int colSCnt = 7;

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
		HashMap QuCatHash = new HashMap();
		QuCatHash.put("01","Special Shipping Instruction");
		QuCatHash.put("02","General Order Processor Note");
		QuCatHash.put("03","----------------------------");
		QuCatHash.put("04","Line Pricing Multiplier");
		QuCatHash.put("05","Freight Allowance");
		QuCatHash.put("06","Quick Ship Program");
		QuCatHash.put("07","Display Items on Order");
		QuCatHash.put("08","Other");

		//out.println("catalogHM::::"+catalogHM);
		Map sortedMap = new TreeMap(catalogHM);

		Set catCol = sortedMap.entrySet();
		Iterator catColIte = catCol.iterator();
		while(catColIte.hasNext())
		{
			Map.Entry catColData = (Map.Entry)catColIte.next();

			String cat_HM = (String)catColData.getKey();
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
				String stanPrice 	= new java.math.BigDecimal(retLines.getFieldValueString(i,"LIST_PRICE")).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString(); // Standard Price for FOC (ZFOC)
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
				String itemPlant	= retLines.getFieldValueString(i,"PLANT");
				if(itemPlant!=null && !"null".equals(itemPlant))itemPlant = itemPlant.trim();
				String splitKey 	= orderType+"¥"+itemSalesOrg+"¥"+itemDiv+"¥"+itemDC+"¥"+itemPlant;
				String itemPoints	= retLines.getFieldValueString(i,"POINTS");
				String itemPointsGRP	= retLines.getFieldValueString(i,"POINTS_GROUP");
				String backEndItem	= retLines.getFieldValueString(i,"BACK_END_ITEM");
				String kitComp		= retLines.getFieldValueString(i,"ITEM_FREIGHT_INS");

				String pointsFromEdit = (String)session.getValue(itemPointsGRP);
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
				log4j.log("dummy check session.getValue(itemPointsGRP)>>>>>>>>"+session.getValue(itemPointsGRP),"D");
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
				String vipChk		= "";
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
				if(quoteRefNo!=null && !"N/A".equals(quoteRefNo) && !"N/A".equals(quoteLineNo))quoteRefNo = quoteRefNo+"/"+quoteLineNo;
				if("Y".equals(vipFalg)){
					vipChk="checked";
					diable="disabled";
				}	
				if("Y".equals(dispFlag)){
					dispChk="checked";
					diable="disabled";
				}	
				if(custSku==null || "".equals(custSku) || "null".equals(custSku))custSku = "";
				if(custPoLine==null || "".equals(custPoLine.trim()) || "null".equals(custPoLine.trim()))custPoLine = "";
				if(custPoLine!=null || !"".equals(custPoLine.trim()) || !"null".equals(custPoLine.trim()))custPoLine = custPoLine.trim();

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

				String pntspcs = "pcs";
				if(cat_HM.equals(venCatalog))
				{
					if("Enamel Steel".equals(venCatalog) || 
						   "Acrylux".equals(venCatalog) || 
						   "Chinaware".equals(venCatalog) || 
						   "Americast & Acrylics (Excludes Acrylux)".equals(venCatalog) ||
						   "Marble".equals(venCatalog))
							pntspcs="points";

					if("Repair Parts".equals(venCatalog) || "DXV Chinaware".equals(venCatalog) || "DXV Faucets".equals(venCatalog) ||
					   "DXV Furniture".equals(venCatalog) || "DXV Tubs".equals(venCatalog) || 
					   "DXV Sinks (Non-CW)".equals(venCatalog) || "DXV Repair Parts".equals(venCatalog))
							pntspcs="$";
				}
%>
				<tr style="background-color:white" id="linedatarow">
				<td><div style="display:none" id="solineinfo"><%=itemLineNo%></div>
				<br>
				<!--<img  src="<%=mainSTD_Img%>" width="100" height"160"  alt="" />-->
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
%>
				<br>
				<strong>Doc Info:</strong>&nbsp;<%=orderType%>/<%=itemSalesOrg%>/<%=itemDC%>/<%=itemDiv%>
				</td>
				<td>&nbsp;$<%=itemListPrice%>

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
				<input type="hidden" name="eanUpc<%=itemLineNo%>" value="<%=eanUPC%>">
				<input type="hidden" name="listPrice<%=itemLineNo%>" value="<%=itemListPrice%>">
				<input type="hidden" name="poItems" value="<%=itemLineNo%>">
				<input type="hidden" name="prodCode<%=itemLineNo%>" value="<%=prodNoUD%>">
				<input type="hidden" name="prodDesc<%=itemLineNo%>" value="<%=prdDesc%>">
				<input type="hidden" name="division<%=itemLineNo%>" value="<%=itemDiv%>">
				<input type="hidden" name="distChannel<%=itemLineNo%>" value="<%=itemDC%>">
				<input type="hidden" name="salesOrg<%=itemLineNo%>" value="<%=itemSalesOrg%>">
				<!--*******Hidden fields for adding to cart END *******-->	

				<!--*******Hidden fields for adding to OrderCreation START *******-->
				<input type="hidden" name="webOrdNo" value="<%=webOrdNo.trim()%>">
				<input type="hidden" name="lineValue" value="<%=netValue%>">
				<input type="hidden" name="listPrice" value="<%=itemListPrice%>">
				<input type="hidden" name="stdMultiplier" value="<%=stdMultiplier%>">
				<input type="hidden" name="product" value="<%=prodNoUD%>">
				<input type="hidden" name="prodDesc" value="<%=prdDesc%>">
				<input type="hidden" name="custprodCode" value="<%=prodNoUD%>">
				<input type="hidden" name="orderType" value="<%=orderType%>">
				<input type="hidden" name="pack" value="<%=prdUom%>">
				<input type="hidden" name="ItemCat" value="<%=ItemCat%>">
				<input type="hidden" name="commitedQty" value="<%=tqty%>">
				<input type="hidden" name="UomQty" value="0">
				<input type="hidden" name="itemListPrice" value="<%=itemListPrice%>">
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
				<input type="hidden" name="itemCnetProd" value="N/A">
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
				<input type="hidden" name="itemPlant"  value="<%=itemPlant%>">
				<input type="hidden" name="splitItemNo"  value="<%=backEndItem%>">
				<input type="hidden" name="kitComp"  value="<%=kitComp%>">
				<input type="hidden" name="itemClass"  value="N/A">

				<input type="hidden" name="stdMulti_<%=itemLineNo%>" value="N/A">
				<input type="hidden" name="netPrice_<%=itemLineNo%>" value="<%=commPrice%>">
				<input type="hidden" name="listPriceF_<%=itemLineNo%>" value="<%=stanPrice%>">
				<input type="hidden" name="stdMultiChng_<%=itemLineNo%>" value="N/A">
				<input type="hidden" name="netPriceChng_<%=itemLineNo%>" value="N/A">
				<input type="hidden" name="itemFlag_<%=itemLineNo%>" value="N/A">
				<input type='hidden' name='childComponents<%=itemLineNo%>' id='childComponents<%=itemLineNo%>' value='<%//=childComponents%>'>

				<!--*******Hidden fields for adding to OrderCreation END *******-->

				<!---*******Hidden Values to Set for Q&A Start**********---------->
				<input type="hidden" name="QComments<%=itemLineNo%>">
				<input type="hidden" name="lineItem"  value="<%=itemLineNo%>">
				<!---*******Hidden Values to Set for Q&A End**********---------->
			</td>
<%
			if(!"CU".equals(userRole) && toApprFOC)
			{
				commPrice = stanPrice;
				netValue = (new java.math.BigDecimal(commPrice)).multiply(new java.math.BigDecimal(tqty)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
				grandTotal = (grandTotal).add(new java.math.BigDecimal(netValue)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP);
			}
%>
			<td>&nbsp;<%=stdMultiplier%></td>
			<td>&nbsp;$<%=commPrice%></td>
			<td>&nbsp;<%=tqty%></td>
			<td>&nbsp;$<%=netValue%></td>
			<td ><%=itemLineNo%></td>
			<td ><%=venCatalog%></td>
<%
			if (pntspcs.equals("$")) { 
%>
			<td id="pointsgroup" ><%=venCatalog%></td>	<!--:<%=pntspcs%><%=(String)catalogHM.get(venCatalog)%>-->
<%
			} else { 
%>
			<td id="pointsgroup" ><%=venCatalog%>:<%=(String)catalogHM.get(venCatalog)%>&nbsp;<%=pntspcs%></td>
<% 			
			} 
%>
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

		if(!"CU".equals(userRole) && toApprFOC)
		{
			soValueBD = grandTotal.toString();
		}
%>
		</tbody>
		<tfoot>
		<tr>
			<td colspan="<%=colSCnt%>" align="right"><h3>SubTotal</h3></td>
			<td>$<%=soValueBD%></td>
		</tr>
		<tr>
			<td colspan="<%=colSCnt%>" align="right"><h3>Shipping and Handling</h3></td>
			<td>$<%=frieghtTotal%></td>
		</tr>
<%
		soValueBD = ((new java.math.BigDecimal(soValueBD)).add(new java.math.BigDecimal(frieghtTotal))).toString();
%>	
		<tr>
			<td colspan="<%=colSCnt%>" align="right"><h3>Grand Total</h3></td>
			<td>$<%=soValueBD%></td>
		</tr>
		<!--<tr>
			<td colspan="<%=(colSCnt+1)%>" class="a-right last"><h3>Total No. of Lines in Order : <%=retLinesCount%></h3></td>
		</tr>-->
	</tfoot>
	</table>
	<br>
<script>
	selectedSoldTo()
</script>
	<p>
	<button type="button" title="Back" class="button" onclick="javascript:history.go(-1)"><span class="left-link noprint">Back</span></button>
<%
	if("FOCREJECTED".equals(ordStatus))
	{
%>
	<button type="button" title="Replenish Items" class="button" onclick="javascript:funReOrder()"><span>Replenish Items</span></button>
<%
	}
	if(sdHeaderCnt==0)
	{
		if(!"CU".equals(userRole) && editNegDtl1 && (!"REJECTED".equals(negotiateType)))
		{
%>		
			<button type="button" title="Reject" class="button" onclick="javascript:submitOrder('R','<%=authChk_FO%>')">
			<span >Reject</span></button>
			<button type="button" title="Accept" class="button" onclick="javascript:submitOrder('A','<%=authChk_FO%>')">
			<span class="right-link">Accept</span></button>
<%		
		}
		else if(!"CU".equals(userRole))
		{
			if("FORAPPROVAL".equals(ordStatus) && toApprFOC) 
			{
			
%>
				<button type="button" title="Reject" class="button" onclick="javascript:actionOnOrder('R','<%=authChk_FO%>')">
				<span >Reject</span></button>
				<button type="button" title="Approve" class="button" onclick="javascript:actionOnOrder('TRANSFERED','<%=authChk_FO%>')">
				<span class="right-link">Approve</span></button>
<%
			}

			//if("FOCAPPROVED".equals(ordStatus) && createdBy.equalsIgnoreCase(loginUser)) 
			//{
%>
				<!--<button type="button" title="Submit to ASB" class="button" onclick="javascript:actionOnOrder('TRANSFERED','<%//=authChk_SO%>')" id="review_11">
				<span class="right-link">Submit to ASB</span></button>-->
<%
			//}
		}
	}
%>
	</p>		
	<br><br>
	</table>
<%
	}
%>	

</div> <!-- Info box -->
</div> <!-- col1-set -->
</div> <!-- col-main -->
</div> <!--main -->
</div> <!-- main-container col1-layout -->
</form>
</body>
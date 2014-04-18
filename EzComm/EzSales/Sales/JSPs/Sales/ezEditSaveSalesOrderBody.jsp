<%@ include file="../../../Includes/JSPs/Sales/iEditSaveSales.jsp"%>
<%@ include file="../../../Includes/JSPs/ShoppingCart/iCheckCartItems.jsp"%>



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
	#savedOrders_wrapper .fg-toolbar { font-size: 0.8em }
	#theme_links span { float: left; padding: 2px 10px; }
	#savedOrders_wrapper { -webkit-box-shadow: 2px 2px 6px #666; box-shadow: 2px 2px 6px #666; border-radius: 5px; }
	#savedOrders tbody {
		border-left: 1px solid #AAA;
		border-right: 1px solid #AAA;
	}
	#savedOrders thead th:first-child { border-left: 1px solid #AAA; }
	#savedOrders thead th:last-child { border-right: 1px solid #AAA; }
</style>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="../../Library/Script/complete.min.js"></script>
<script type="text/javascript" src="../../Library/Script/jquery.dataTables.min.js"></script> 

<script  src="../../Library/Script/colResizable-1.3.min.js"></script>
 
<!-- fancy box popup instead of original from rb -->
<link rel="stylesheet" href="../../Library/Script/jquery.fancybox.css?v=2.0.5" type="text/css" media="screen" />
<script type="text/javascript" src="../../Library/Script/jquery.fancybox.pack.js?v=2.0.5"></script>
<!-- end of fancybox -->
<!-- Style for New Header -->
<style type="text/css">
.highlight {
                height: 65px;
                width: 940px;
		background: #e9e9e9;
		background: -webkit-linear-gradient(#e9e9e9, #c0c0c0);
		background: -moz-linear-gradient(#e9e9e9, #c0c0c0);
		background: -ms-linear-gradient(#e9e9e9, #c0c0c0);
		background: -o-linear-gradient(#e9e9e9, #c0c0c0);
		background: linear-gradient(#e9e9e9, #c0c0c0);
}
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
	/* Formating function for row details */
	function fnFormatDetails ( oTable, nTr , detailLines )
	{
	    var aData = oTable.fnGetData( nTr ); // get the row 
	    var sOut = '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">';
	    //var soNum = aData[1].substring(0,aData[1].indexOf('/')); // Under Assumption that SO Num is first string in column 1 get it in soNum
	    var soNum = aData[1].substring(aData[1].indexOf('>')+1,aData[1].indexOf('/')); //SONum is in a hidden div tag, so take content after div tag
	    var soLine = aData[1].substring(aData[1].indexOf('/')+1,aData[1].indexOf('\n'));
	    /*var str = '' + soNum;
	    while (str.length < 10) {
		    str = '0' + str;
	    }
	    soNum = str;
	    var str2 = '' + soLine;
	    while (str2.length < 6) {
		    str2 = '0' + str2;
	    }
	    soLine = str2;
	    console.log(str);*/
	    console.log('In fnFormatDetails for Line ');
	    console.log(soLine);
	    var ccompName = 'childComponents'+soNum+soLine+'';
	  console.log("ccompName:::IN FUNCTION"+ccompName);
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
	    nCloneTd.innerHTML = '<img src="../../Library/images/details_open.png" id="openimg" name="openimg">';
	    var nCloneTdEmpty = document.createElement( 'td' );
	    nCloneTdEmpty.innerHTML = '<p></p>';

	      $('#savedOrders tbody tr').each( function () {
	    	//var vCol0 = $(this).find('#socell:first').text();
	    	var vCol0 = $(this).find('#solineinfo:first').text();
	    	console.log("vCol0:::::"+vCol0);
	    	
	    	if (vCol0 !="") {
	    	var soNum = vCol0.substring(0,vCol0.indexOf('/'));
		var soLine = vCol0.substring(vCol0.indexOf('/')+1,vCol0.indexOf('\n'));
		console.log("soNum::::::"+soNum);
		console.log(soLine);
		/*if (soNum != "") {
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
		} // soLine blank check*/
		var ccompName = 'childComponents'+soNum+soLine+'';
		console.log("ccompName:::::"+ccompName);
		
		if ($(document.getElementById(ccompName)).val()!=""){
			console.log("Inserting column with image");
			this.insertBefore(  nCloneTd.cloneNode( true ), this.childNodes[0] );
		} else {
			console.log("Inserting Empty Column");
			this.insertBefore(  nCloneTdEmpty.cloneNode( true ), this.childNodes[0] );
		};
		
		
		} // end vCol0
		else
		{
			var vPointsGroup = $(this).find('#pointsgroup').text();	
			//console.log(vPointsGroup);
			if (vPointsGroup != ""){
				this.insertBefore(  nCloneTdEmpty.cloneNode( true ), this.childNodes[0] );
				//console.log(" Inserted empty column in grouping row");
			}
		}// end else vCol0
		
	    } );
	
			
	       var oTable = $('#savedOrders').dataTable( {
	    
	      "fnDrawCallback": function ( oSettings ) {
		if ( oSettings.aiDisplay.length == 0 )
		{
		    return;
		}
		var nTrs = $('#savedOrders tbody tr#linedatarow');
		var iColspan = nTrs[0].getElementsByTagName('td').length;
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
		"bSort" : false,
		"iDisplayLength": 100,
		"bPaginate":false,
		"oLanguage": { "sSearch": "Search PO Lines" } ,
		"aoColumnDefs": [ 
		      { "bVisible": false, "aTargets": [ 1 ] },
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
	            this.src = "../../Library/images/details_open.png";
	            oTable.fnClose( nTr );
	        }
	        else
	        {
	            /* Open this row */
	            this.src = "../../Library/images//details_close.png";
	            oTable.fnOpen( nTr, fnFormatDetails(oTable, nTr, 'hello123'), 'details' );
	        }
    	      } );	    
	    
	 
    	      
	} );

</script>


<script type="text/javascript">
$(function(){

	var onSampleResized = function(e){
		var columns = $(e.currentTarget).find("th");
		var msg = "columns widths: ";
		columns.each()
	};

	$("#savedOrders").colResizable({
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
</style>
<script>
function goBack()
{
	var sch = '<%=request.getParameter("fromPage")%>'
	if(sch=='Y')
		document.saveForm.action = "../Search/ezQuickSearchDetailsMain.jsp"
	else
		document.saveForm.action ="ezSavedOrders.jsp?displayOrder=N"
	document.saveForm.submit()

}
function getProductDetails(code)
{
	document.saveForm.prodCode_D.value=code;
	document.saveForm.action="../Catalog/ezProductDetails.jsp";
	document.saveForm.target = "_blank"
	document.saveForm.submit();
}
function submitOrder(type)
{

	var catType=document.saveForm.catTypeE.value;
	
	document.saveForm.status.value=type
	Popup.showModal('modal1');
	if(type=='CART')
		document.saveForm.action ="../ShoppingCart/ezAddCartSaveOrder.jsp"
	if(type=='TRANSFERED')	
		document.saveForm.action ="../Sales/ezAddSaveSales.jsp"
	if(type=='NEGOTIATED')	
		document.saveForm.action ="../Sales/ezAddSaveSales.jsp"	
	if(type=='DEL')	
		document.saveForm.action ="../Sales/ezDelSavedTemp.jsp"				

	document.saveForm.submit()


}
function SaveValues(lineNO)
{
	alert(lineNO)
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

	document.getElementById("ASK"+lineNO).style.display="none"
	document.getElementById("HIDE"+lineNO).style.display=""
	
	var qObj 	= eval("document.saveForm.qType"+lineNO)
	var quesObj     = eval("document.saveForm.QComments"+lineNO)
	qObj.value	= query
	quesObj.value	= comments
	alert("qObj.value::::::::"+qObj.value+"::::::quesObj.value:::::::"+quesObj.value)
}
function funReply(lineNO,type)
{
	if(type=='R')
	{
		var reply 	= document.getElementById("reply"+lineNO).value
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
	if(type=='M')
	{
		var reply 	= document.getElementById("modQuery"+lineNO).value
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
	//alert(document.saveForm.QComments+lineNO.value)
}
function funGetDocs(webOrdNo,tempName)
{
	//alert("webOrdNo:::::"+webOrdNo)
	
	if(isNaN(webOrdNo))
	{
		alert("No Orders to List")
		return;
	}
	document.saveForm.refOrdNo.value=webOrdNo
	document.saveForm.tempName.value=tempName
	document.saveForm.action ="../Search/ezQuickSearchDetailsMain.jsp"		
	document.saveForm.submit()	
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
</script>
<form name="saveForm" method='post'>
<div class="main-container col2-left-layout middle account-pages">
<div class="main">
<div class="col-main1 roundedCorners">
<div class="page-title">

<div id="modal1" style="border:0px solid black; background-color:white; padding:1px; font-size:10;width:40%;height:180px; text-align:center; display:none;">
	<ul>
		<li>&nbsp;</li>
		<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
		<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
	</ul>
</div>
<input type="hidden" name="catTypeE" value="<%=catType_C%>">
<input type="hidden" name="fromDetails" value="Y">
<input type="hidden" name="subUser" value="<%=request.getParameter("subUser")%>">
<input type="hidden" name="prodCode_D">
<%
	String fromSave = request.getParameter("fromSave");
	if(!"Y".equals(fromSave) )
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
		<input type="hidden" name="singleList" value="Y">
		<!----------------- End ------->
<%
	}
%>	





<%
	//if(authorisedUsres.contains(authCheck))
	{
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
	
	ezc.ezparam.ReturnObjFromRetrieve ret2 = EzGlobal.getGlobal(retLines);
	Vector types2= new Vector();
	Vector names2= new Vector();
	types2.addElement("date");
	names2.addElement("PROMISE_FULL_DATE");

	EzGlobal.setColTypes(types2);
	EzGlobal.setColNames(names2);	
	
	//out.println(sdHeader.toEzcString());
	String poNo 	 = sdHeader.getFieldValueString(0,"PO_NO");
	String webOrderNo= sdHeader.getFieldValueString(0,"WEB_ORNO"); 
	String createdBy = sdHeader.getFieldValueString(0,"CREATE_USERID");
	String poDate	 = ret.getFieldValueString(0,"PURCH_DATE");
	String reqDate 	 = ret.getFieldValueString(0,"REQ_DATE");
	String complDlv	 = sdHeader.getFieldValueString(0,"DLVFLAG");
	String desiredDate= ret.getFieldValueString(0,"REQ_DATE");
	if("Y".equals(complDlv))complDlv="on";
	String shipPartnRole = "";
	String comments	= sdHeader.getFieldValueString(0,"TEXT2");
		
	String formatkey_S = (String)session.getValue("formatKey");
	FormatDate fD = new FormatDate();

	java.util.Date statusDate = (java.util.Date)sdHeader.getFieldValue(0,"STATUS_DATE");
	
	String spShipIns	= sdHeader.getFieldValueString(0,"TEXT3");
	//out.println("spShipIns::::::"+spShipIns);
	String freightType	= sdHeader.getFieldValueString(0,"FREIGHT");
	String Currency		= sdHeader.getFieldValueString(0,"DOC_CURRENCY");
	String promoCode	= sdHeader.getFieldValueString(0,"HEADER_PROMO_CODE");
	String frieghtTotal 	= sdHeader.getFieldValueString(0,"FREIGHT_PRICE");
	String tempName 	= sdHeader.getFieldValueString(0,"TEMPLATE_NAME");

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
		soldToAddress = soldToAddress + soldZip +"<br>";
	if(soldState!=null && !"null".equals(soldState) && !"".equals(soldState.trim()))
		soldToAddress = soldToAddress + soldState +"<br>";
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
	//out.println(sdShipTo.toEzcString());
	
	if(shipName!=null && !"null".equals(shipName) && !"".equals(shipName.trim()))
		shipToAddress = shipToAddress + shipName +"<br>";
	if(shipStreet!=null && !"null".equals(shipStreet) && !"".equals(shipStreet.trim()))
		shipToAddress = shipToAddress + shipStreet +"<br>";
	if(shipCity!=null && !"null".equals(shipCity) && !"".equals(shipCity.trim()))
		shipToAddress = shipToAddress + shipCity +", ";
	if(shipState!=null && !"null".equals(shipState) && !"".equals(shipState.trim()))
		shipToAddress = shipToAddress +"&nbsp;"+ shipState ;
	if(shipZip!=null && !"null".equals(shipZip) && !"".equals(shipZip.trim()))
		shipToAddress = shipToAddress +"&nbsp;"+ shipZip ;	
	if(shipCountry!=null && !"null".equals(shipCountry) && !"".equals(shipCountry.trim()))
		shipToAddress = shipToAddress +"&nbsp;"+ shipCountry ;
	//if(shipToPhNum!=null && !"null".equals(shipToPhNum) && !"".equals(shipToPhNum.trim()))
		//shipToAddress = shipToAddress + "Tel#:"+ shipToPhNum ;
	
	if(shipName==null || "null".equalsIgnoreCase(shipName)) shipName = "";
	if(shipStreet==null || "null".equalsIgnoreCase(shipStreet)) shipStreet = "";
	if(shipCity==null || "null".equalsIgnoreCase(shipCity)) shipCity = "";
	if(shipZip==null || "null".equalsIgnoreCase(shipZip)) shipZip = "";
	if(shipState==null || "null".equalsIgnoreCase(shipState)) shipState = "";
	if(shipCountry==null || "null".equalsIgnoreCase(shipCountry)) shipCountry = "";
	if(tempName==null || "null".equalsIgnoreCase(tempName) || "".equals(tempName.trim())) tempName = "";

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
	boolean VFLAG = false;
	for(int r=0;r<retLinesCount;r++)
	{
		String vipF = retLines.getFieldValueString(r,"VIP_FLAG");
		String disF = retLines.getFieldValueString(r,"DISPLAY_FLAG");
		if(!"".equals(vipF) && !"".equals(disF) && !"null".equalsIgnoreCase(vipF) && !"null".equalsIgnoreCase(disF))
		{
			VFLAG = true;
			break;
		}	
			
	}
	String WEB_ORNO = (retLines.getFieldValueString(0,"WEB_ORNO")).trim();
	EzcParams mainParamsNeg= new EzcParams(false);
	EziMiscParams miscParamsNeg = new EziMiscParams();
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
		
		}
		
		
	/*********** Negotiation Details End******/	
	/*********** Reference Document Count Start******/	
	
		String docCount="";
		String dispMsg = "";
		mainParamsNeg= new EzcParams(false);
		miscParamsNeg = new EziMiscParams();
		ReturnObjFromRetrieve orderRefRet = null;		
		miscParamsNeg.setIdenKey("MISC_SELECT");
		miscParamsNeg.setQuery("SELECT COUNT(*) DOC_COUNT FROM EZC_SALES_DOC_HEADER WHERE ESDH_STATUS='TRANSFERED' AND ESDH_SAVE_FLAG='"+WEB_ORNO+"'");

		mainParamsNeg.setLocalStore("Y");
		mainParamsNeg.setObject(miscParamsNeg);
		Session.prepareParams(mainParamsNeg);	

		try
		{		
			ezc.ezcommon.EzLog4j.log("miscParams.getQuery()::::::::"+miscParams.getQuery() ,"I");
			orderRefRet = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsNeg);
		}
		catch(Exception e)
		{
			out.println("Exception in Getting Data"+e);
		}
		if(orderRefRet!=null && orderRefRet.getRowCount()>0)
			docCount = orderRefRet.getFieldValueString(0,"DOC_COUNT");
		if("0".equals(docCount))	
			docCount ="No";
		
	/*********** Reference Document Count End******/		
	
%>
	<!--<h2>PO #: <%//=poNo%></h2>-->
	<div class="highlight" style="height:75px;width:100%" >
		<div style="width: 625px; float: left">
			<br>&nbsp;<font size="5" color="black"><b>SAVED ORDER/TEMPLATE</b> </font><br>
<%
			if(!"".equals(tempName))
			{
%>			
			&nbsp;<strong>TEMPLATE ID:</strong>&nbsp;<%=tempName%>
<%
			}
%>
			<strong> PO NO:</strong>&nbsp;<%=poNo%> <strong>PO DATE:</strong>&nbsp;<%=poDate%><br>
		</div>
				
		<!--<div style="width: 145px; float: right ">
			&nbsp;&nbsp;&nbsp;<div id="noprint">
			<ul id="navbar">
			<li><a href="javascript:void()">Order Actions&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="arrow"></span></a>
			<ul>
			<li id='CopyToCart'><a href="javascript:submitOrder('CART')"><span>Edit in Cart</span></a></li>
			
			<% if ((retUploadDocs != null) && (noOfDocs> 0 )) { %>
			<li id="POAttachments"><a class="fancybox" href="#POATTACHMENTS<%=poNo%>">Attachments</a></li>
			<div id="POATTACHMENTS<%=poNo%>" style="width: 400px; display: none; ">
			<h2>Attachments for PO: <%=poNo%></h2>
			<% for (int acount=0;acount<noOfDocs;acount++) { %>
			<a href="../UploadFiles/ezViewFile.jsp?filePath=<%=retUploadDocs.getFieldValueString(acount,"SERVERFILENAME")%>"</a>
			<br>
			<% } %>
			</div>
			<% } %>				
			
			<li id="DeleteTemplate"><a href="javascript:submitOrder('DEL')"><span>Delete Template</span></a></li>

			</ul>
			</li>
			</ul>
			</div>
			</td>
		</div>	
		<div style="width: 100px; float: right">
			<ul id="navbar">
				<li><span class="larrow"></span>&nbsp;&nbsp;<a href="javascript: goBack()">Go to Search</a>
			</li>
			</ul>
		</div>-->
	</div>
	<br>
	<div id="divAction" style="display:block">
		<button type="button" title="Back" class="button" onclick="javascript:goBack()">
		<span>Back</span></button>		

		<button type="button" title="Copy to Cart" class="button" onclick="javascript:submitOrder('CART')">
		<span >Edit in Cart</span></button>
<%
		if(noOfDocs>0)
		{
%>
		<div id='POAttachments' style="float:left">
			<a class="fancybox" href="#POATTACHMENTS<%=poNo%>">
			<button type="button" title="Attachments" class="button"><span>Attachments</span></button></a>
		</div>
<%
		}	
		
%>
		<button type="button" title="Delete Template" class="button" onclick="javascript:submitOrder('DEL')">
		<span>Delete Template</span></button>			
	</div>
	<br>
<%
	if(!"".equals(tempName))
	{
%>
	<h3>
		<br><a href=javascript:funGetDocs('<%=WEB_ORNO%>','<%=tempName%>')><font style="color:red"><%=docCount%>&nbsp;&nbsp; </font></a>order(s) have been created using the template <%=tempName%>	
	</h3>
<%
	}
%>
</div>
<br>
<div id="auditId" style="width: 900px; height:200px; display: none; "></div>
<div class="col3-set">
	<div class="col-1">
	<div class="info-box">
		<h2 class="sub-title" style="padding-top:10px">Shipping Address</h2>
		<p><%=shipToAddress%></p>
	</div>
	</div>
	<div class="col-2">
	<div class="info-box">
		<h2 class="sub-title" style="padding-top:10px">Sold To Address</h2>
		<p><%=soldToAddress%></p>
	</div>
	</div>
	<!-- Col 2 of Order Header -->
<%@ include file="../../../Includes/JSPs/Misc/iShipMethods.jsp"%>
	<div class="col-3">
	<div class="info-box">
		<h2 class="sub-title" style="padding-top:10px">Shipping Method </h2>
<%
		if(dlvCheck.equals("checked=checked"))
		{
%>
			<p><strong>Deliver Together:</strong>&nbsp;Yes<br>
<%
		}
%>
		<strong>Shipping Mode:</strong>&nbsp;<%=shipMethodHM.get(carrierName)%><br>
<%
	if(!"".equals(carrierName) && !"STD".equals(carrierName))
	{
%>
		<strong>BILLING DETAILS WITH SHIPPER</strong><br>
		A/c with Carrier: <%=carrierId%><br>
		<%=billToName%><br>
		<%=billToStreet%><br>
		<%=billToCity+","%> <%=billToState%> <%=billToZipCode%> 
<%
	}
	//else
	//{
%>
		<!--Shipping Mode  : Standard <br>-->
		<!--A/c with Carrier: N/A<br>
		<strong>BILLING DETAILS WITH SHIPPER</strong><br>
		N/A-->
<%
	//}
%>
		</p>
	</div>
	</div> <!-- Col 3 of Order Header -->
</div> <!-- End of header Column 3 Set -->
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
<!--<div id="boxes">
	<div id="dialog" class="window">
		<a href="#" class="close"/><font color=black>[x] Close</font></a>
		<iframe id="AttachFiles" width="500" height="350"></iframe>
	</div>

	<h2 class="sub-title">External Header Text</h2>
	<p><textarea id="headertext" rows="2" cols="80" readonly><%=comments%></textarea></p>
</div>-->

<Table width="100%" border=0>
<Tr>
	<% if (!comments.trim().equals("")) {%>
	<Td><label for="headertext"><strong>General Notes</strong></label></Td>
	<% } %>
	<% if (!spShipIns.trim().equals("") && !"NONE".equalsIgnoreCase(spShipIns)) { %>
	<Td><label for="shipInst"><strong>Order Shipping Instructions</strong></label></Td>
	<% } %>
</Tr>
<Tr>
	<Td>
		<% if (!comments.trim().equals("")) { %>
		<textarea id="headertext" rows="2" cols="80"><%=comments%></textarea>
		<% } %>
	</Td>
	<Td>
		<% if (!spShipIns.equals("") && !"NONE".equalsIgnoreCase(spShipIns)) { %>
		<textarea id="headertext" rows="2" cols="80"><%=spShipIns%></textarea>
		<% } %>
	</Td>
</Tr>
</Table>

<%
	String attachFile = "";
	if(noOfDocs>0)
	{
%>
		<div id="POATTACHMENTS<%=poNo%>" style="width: 400px; display: none; ">
		<h2>Attachments for PO: <%=poNo%></h2>
<%
		for(int acount=0;acount<retUploadDocs.getRowCount();acount++)
		{
			String openFile = retUploadDocs.getFieldValueString(acount,"SERVERFILENAME");
			String clientFileName = retUploadDocs.getFieldValueString(acount,"CLIENTFILENAME");

			if("".equals(attachFile))
				attachFile = clientFileName;
			else
				attachFile = attachFile+"$$"+clientFileName;
%>
			<a href="javascript:openFileAttach(<%=acount%>)"><%=attachFile%></a>
			<input type="hidden" name="fileName_<%=acount%>" id="fileName_<%=acount%>" value="<%=openFile%>">
			<br>
<%
		}
%>
		</div>
<%
	}
%>
<input type="hidden" name="attachFile" value="<%=attachFile%>">
<% if (carrierName.equals("STD")) { shipPartnRole="";billToName = "";billToState = "";billToZipCode = "";billToAddress = "";billToCity = "";billToStreet = "";} %>
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
<input type="hidden" name="shipTo_S" value='<%=shipTo_S%>'>
<input type="hidden" name="poNumber" value="<%=poNo%>">
<input type="hidden" name="webOrdNo" value = "<%=WEB_ORNO%>">

<input type="hidden" name="desiredDate" value="<%=poDate%>">
<input type="hidden" name="complDlv" value="<%=complDlv%>">
<input type="hidden" name="Currency" value="<%=Currency%>">
<input type="hidden" name="shipMethod" value="<%=carrierName%>">
<input type="hidden" name="comments" value="<%=comments%>">

<input type="hidden" name="shipPartnRole" value="N/A">
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
<input type="hidden" name="shipToPhNum" value="N/A">
<input type="hidden" name="status">
<input type="hidden" name="refOrdNo">
<input type="hidden" name="tempName">
<input type="hidden" name="fromPage" value="Save">
<!--<div class="col1-set">
<div class="info-box"><br>
<Table width="100%" border=0>
<Tr>
<Th>
	<Table><Tr>
	<Th align=left>
		<div class="ATTACHFILE">
		<a class="fancybox" href="#ATTACHFILE">
			<button type="button" class="button btn-update">
				<span>Attach</span>
			</button>
		</a>
		</div>
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
</Table><br>
</div>
</div>-->
<br><br>
<div class="col1-set">
<div class="info-box">
<%
	ezc.record.util.EzOrderedDictionary userAuth_R = Session.getUserAuth();

	Map sortedMap = null;
	Set catCol = null;
	java.util.HashMap catalogHM = new java.util.HashMap();
	if(sdHeaderCount>0 && retLinesCount>0)
	{
%>	
		<!--<h2 class="sub-title">Items Ordered </h2>-->
		<table class="data-table" id="savedOrders">
		<thead>
		<tr>
<%
			int colSCnt = 10;
			///if(!"CU".equals(userRole))
			{
				colSCnt = 11;
%>
				<!--<th width=15%> Split Info</th>-->
<%
			}
%>
			<th width="4%"></th>
			<th ></th>
			<th> Image </th>
			<th  width=15%>Product Information</th>
			<!--<th>UPC Code</th>
			<th>SKU#</th> -->
			<th  width=15% align="center">PO Program</th>
			<!-- <th>Disp.</th> -->
			<th width="15%">Net Price[NP]<br>Multiplier[MULT]<br>List Price[LP]</th>
			<!--<th  width=15% align="center" nowrap>List [USD]</th>
			<th  width=10% align="center">Multiplier</th>
			<th  width=10% align="center" nowrap>Netted Price</th>-->
			<th  width=10% align="center">Order Qty[OQ]</th>
			<th  width=15% align="center">Question/Comments</th>
			<th  width=10% align="center">SubTotal</th>
			
			<th width="1%" id='VenCatalog'></th>
			<th width="1%" id='VenCatPts'></th>
			
			
			
		</tr>
		</thead>
		
		<tbody>
		
		
<%
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
		//ArrayList catalogList = new ArrayList();
		
		for(int i=0;i<retLinesCount;i++)
		{
			String catalog_S	 = retLines.getFieldValueString(i,"VENDOR_CATALOG");
			String itemPoints	= retLines.getFieldValueString(i,"POINTS");
			String itemPointsGRP	= retLines.getFieldValueString(i,"POINTS_GROUP");
			String matno	 	= retLines.getFieldValueString(i,"PROD_CODE");
			
			if(("PTSAM".equals(matno) || "PTSCH".equals(matno) || "PIECES".equals(matno)))
				continue;			
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
		sortedMap = new TreeMap(catalogHM);

		catCol = sortedMap.entrySet();
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
				String splitKey 	= orderType+"¥"+itemSalesOrg+"¥"+itemDiv+"¥"+itemDC;
				String itemPoints	= retLines.getFieldValueString(i,"POINTS");
				String itemPointsGRP	= retLines.getFieldValueString(i,"POINTS_GROUP");
				String kitComp		= retLines.getFieldValueString(i,"ITEM_FREIGHT_INS");
				String pntspcs = "pcs";
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
				if(quoteRefNo!=null && !"N/A".equals(quoteRefNo) && !"N/A".equals(quoteLineNo))quoteRefNo = quoteRefNo+"/"+quoteLineNo;
				if("Y".equals(vipFalg)){
					//vipChk="checked";
					//diable="disabled";
					vipChk="Vip";
				}	
				if("Y".equals(dispFlag)){

					//dispChk="checked";
					//diable="disabled";
					vipChk="Display";
				}	
				if(custSku==null || "".equals(custSku) || "null".equals(custSku))custSku = "";
				if(custPoLine==null || "".equals(custPoLine.trim()) || "null".equals(custPoLine.trim()))custPoLine = "";
				if(custPoLine!=null || !"".equals(custPoLine.trim()) || !"null".equals(custPoLine.trim()))custPoLine = custPoLine.trim();
			
%>
				<!--*******Hidden Values to Set for Q&A Start*******----->
				<input type="hidden" name="QComments<%=itemLineNo%>">
				<input type="hidden" name="lineItem"  value="<%=itemLineNo%>">
				<!--*******Hidden Values to Set for Q&A End*******----->

<%
				if(cat_HM.equals(venCatalog) && ent==0)
				{
					ent++;
					

					if("Enamel Steel".equals(venCatalog) || 
					   "Acrylux".equals(venCatalog) 	    || 
					   "Chinaware".equals(venCatalog)    || 
					   "Americast & Acrylics (Excludes Acrylux)".equals(venCatalog) ||
		   			   "Marble".equals(venCatalog))
						pntspcs="points";
					if("Repair Parts".equals(venCatalog)) 
						pntspcs="$";	
%>
					
<%
				}
%>			

			<tr style="background-color:white" id="linedatarow">
			
			<input type='hidden' name='childComponents<%=webOrdNo.trim()+""+itemLineNo%>' id='childComponents<%=webOrdNo.trim()+""+itemLineNo%>' value='<%=childComponents%>'>
			
			<td width=10% align="center" id="socell"><div style="display:none" id="solineinfo"><%=webOrdNo.trim()%>/<%=itemLineNo%><%="\n"%></div></td>
<%
			//Image and Brand of product

			EzcParams prodParamsMiscDWN = new EzcParams(false);
			EziMiscParams prodParamsDWN = new EziMiscParams();

			ReturnObjFromRetrieve prodDetailsRetObjDWN = null;

			prodParamsDWN.setIdenKey("MISC_SELECT");
			//String queryDWN="SELECT EZP_BRAND, EZP_CURR_PRICE , EPA_PRODUCT_CODE,SUBSTRING(EPA_PRODUCT_CODE,PATINDEX('%.%',EPA_PRODUCT_CODE)+1,(LEN(EPA_PRODUCT_CODE))) COLOR,EPA_IMAGE_TYPE,EPA_SCREEN_NAME,EZA_ASSET_ID,EZA_MIME_TYPE,EZA_LINK FROM EZC_ASSETS,EZC_PRODUCT_ASSETS,EZC_PRODUCTS WHERE EPA_ASSET_ID=EZA_ASSET_ID AND EPA_PRODUCT_CODE = EZP_PRODUCT_CODE AND EPA_PRODUCT_CODE='"+prdCode+"' and EPA_IMAGE_TYPE='MAIN' order by EPA_SCREEN_NAME desc";
			String queryDWN=
			"SELECT EZP_BRAND, EZP_CURR_PRICE , EZP_PRODUCT_CODE,SUBSTRING(EZP_PRODUCT_CODE,PATINDEX('%.%',EZP_PRODUCT_CODE)+1,(LEN(EZP_PRODUCT_CODE))) COLOR,EPA_IMAGE_TYPE,EPA_SCREEN_NAME,EZA_ASSET_ID,EZA_MIME_TYPE,EZA_LINK "+
			"FROM EZC_PRODUCTS "+
			"LEFT JOIN "+
			" ( EZC_PRODUCT_ASSETS INNER JOIN EZC_ASSETS ON EPA_ASSET_ID=EZA_ASSET_ID AND EPA_IMAGE_TYPE='MAIN' ) "+
			" ON EPA_PRODUCT_CODE = EZP_PRODUCT_CODE " +
			" WHERE EZP_PRODUCT_CODE='"+prdCode+"' ORDER by EPA_SCREEN_NAME desc";

			prodParamsDWN.setQuery(queryDWN);

			prodParamsMiscDWN.setLocalStore("Y");
			prodParamsMiscDWN.setObject(prodParamsDWN);
			Session.prepareParams(prodParamsMiscDWN);	

			try
			{
				prodDetailsRetObjDWN = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(prodParamsMiscDWN);
			}
			catch(Exception e){}	
			String mainSTD="",mainLarge="",mainThumb="";
			int indSTD = 0, indLarge = 0,indThumb = 0;
			String brand = "";
			String listPriceOurDB = "0";

			if(prodDetailsRetObjDWN!=null && prodDetailsRetObjDWN.getRowCount()>0)
			{
				listPriceOurDB = prodDetailsRetObjDWN.getFieldValueString(0,"EZP_CURR_PRICE");	
				brand = prodDetailsRetObjDWN.getFieldValueString(0,"EZP_BRAND");	
				for(int im=0;im<prodDetailsRetObjDWN.getRowCount();im++)
				{
					String imageSTD = prodDetailsRetObjDWN.getFieldValueString(im,"EZA_ASSET_ID");
					String colorFinish = prodDetailsRetObjDWN.getFieldValueString(im,"COLOR");
					if(colorFinish==null || "null".equals(colorFinish) || colorFinish.length()>3)
						colorFinish = "";

					if(imageSTD!=null && !"".equals(imageSTD) && !"null".equals(imageSTD))
					{
						indSTD = imageSTD.indexOf(colorFinish+"-ST");
					}
					String imageLarge = prodDetailsRetObjDWN.getFieldValueString(im,"EZA_ASSET_ID");
					if(imageLarge!=null && !"".equals(imageLarge) && !"null".equals(imageLarge))
					{
						indLarge = imageLarge.indexOf(colorFinish+"-LG");
					}					
					String imageThumb = prodDetailsRetObjDWN.getFieldValueString(im,"EZA_ASSET_ID");
					if(imageThumb!=null && !"".equals(imageThumb) && !"null".equals(imageThumb))
					{
						indThumb = imageThumb.indexOf(colorFinish+"-SU");
					}

					if("MAIN".equals(prodDetailsRetObjDWN.getFieldValueString(im,"EPA_IMAGE_TYPE")) && indSTD!=-1 )
					{				
						mainSTD=nullCheck(prodDetailsRetObjDWN.getFieldValueString(im,"EZA_LINK"));					
					}
					if("MAIN".equals(prodDetailsRetObjDWN.getFieldValueString(im,"EPA_IMAGE_TYPE")) && indLarge!=-1)
					{				
						mainLarge=nullCheck(prodDetailsRetObjDWN.getFieldValueString(im,"EZA_LINK"));					
					}
					if("ZOOM".equals(prodDetailsRetObjDWN.getFieldValueString(im,"EPA_IMAGE_TYPE")) && indThumb!=-1)
					{				
						mainThumb=nullCheck(prodDetailsRetObjDWN.getFieldValueString(im,"EZA_LINK"));					
					}

				}
			}

			if("".equals(mainSTD))
			{
				//mainSTD="../../Images/noimage.gif";
				//mainLarge="../../Images/noimage.gif";
				//mainThumb="../../Images/noimage.gif";
			}
%>			
			
<%
	
			//if(!"CU".equals(userRole))
			{
%>	
			
				<!--<td width=15%>
				Doc Type <strong><%=orderType%></strong><br>
				Sales Org. <strong><%=itemSalesOrg%></strong><br>
				Division <strong><%=itemDiv%></strong><br>
				Dist Chnl <strong><%=itemDC%></strong>
				</td>-->
<%
			}
%>				
				
				<td><br>
<%
				if("Y".equals((String)session.getValue("SHOWIMAGES")))
				{
					//out.println(session.getValue("SHOWIMAGES"));
%>				
					<img  src="<%=mainSTD%>" width="100" height"160" alt="" />
<%
				}
%>				
				<p align="center"><%=brand%></p>
				</td>
				
				<td  width=15%>
					<%=prdDesc%>
					<br><strong>Product:</strong>&nbsp;<a target="_blank" href="javascript:getProductDetails('<%=tPNo.trim()%>')" title="<%=prdDesc%>" ><%=tPNo.trim()%></a>
					<br><strong>UPC#</strong>&nbsp;<%=eanUPC%>
					<br><strong>My SKU#</strong>&nbsp;<%=custSku%>
					<br><strong>My PO Line#</strong>&nbsp;<%=custPoLine%>
<%
				if(!"CU".equals(userRole))
				{
%>
					<br>
					<strong>Doc Info:</strong>&nbsp;<%=orderType%>/<%=itemSalesOrg%>/<%=itemDC%>/<%=itemDiv%>
					</td>
<%
				}
%>					
				</td>

				<td width=15% align="center" ><%=vipChk%>
				<% if ( !(quoteRefNo.equals("N/A")) && !(quoteRefNo.equals(""))) { %>
				<strong>Quote#&nbsp;</strong><%=quoteRefNo%>
				<% } %>
				</td>
				<td width=15% align="center">
				<Strong>NP:&nbsp;</Strong>$<%=checkAuth(commPrice,"VIEW_PRICES",userAuth_R)%><br>
				<Strong>MULT:&nbsp;</Strong><%=checkAuth(stdMultiplier,"VIEW_PRICES",userAuth_R)%><br>
				<Strong>LP:&nbsp;</Strong>$<%=itemListPrice%>
				</td>
				<!--<td width=10% align="right"><%//=stdMultiplier%></td>
				<td width=10% align="center"><%//=commPrice%></td>-->
				<td width=10% align="right"><strong>OQ:</strong><%=tqty%></td>
<%			
	String questionHTML = "";
	String QKey ="";
	String AKey ="";	
	if(noQHash!=null && noQHash.size()>0 && noQHash.containsKey(itemLineNo))
	{
		String tempQues	= (String)noQHash.get(itemLineNo);
		String reply="";
		questionHTML= "<table >";
		String questionHTML_Temp = "<table >";
		if(!"".equals(tempQues) && !"null".equals(tempQues))
		{
			if(tempQues.indexOf("#")!=-1)
			{
				String [] QArray = tempQues.split("#");
				int QArrayLen	 = QArray.length;
				for(int q=0;q<QArrayLen;q++)
				{
					QKey = (String)quesHash.get(QArray[q]);
					AKey = (String)ansHash.get(QArray[q]);

					QKey = ((QKey == null) || (("").equals(QKey)) || ("null".equalsIgnoreCase(QKey)))?"":QKey;
					AKey = ((AKey == null) || (("").equals(AKey)) || ("null".equalsIgnoreCase(QKey)))?"":AKey;
					if(!"".equals(AKey))reply =AKey;
					if(!"".equals(QKey) && !"null".equals(QKey) && !"N/A".equals(QKey.split("##")[1]))
					{
						if("".equals(AKey))
						{
							questionHTML_Temp = questionHTML_Temp+"<thead><tr><th>Query by &nbsp;&nbsp;&nbsp;<font color=\"red\">"+QKey.split("##")[2]+"</font>&nbsp; on <font color=\"red\">"+QuCatHash.get(QKey.split("##")[1])+"</font>&nbsp; dated <font color=\"red\">"+QKey.split("##")[3]+"</font></th></tr></thead>";
							questionHTML_Temp = questionHTML_Temp+"<tbody><tr><th><textarea name=\"reply\" id=\"modQuery"+itemLineNo+"\" cols=\"10\" rows=\"5\" >"+QKey.split("##")[0]+"</textarea></th></th></tr></tbody>";
							questionHTML_Temp = questionHTML_Temp+"<tfoot></tfoot></table><br><input type=\"button\" label=\"Submit\"  value=\"Save\" onClick=\"funReply("+itemLineNo+",'M')\"></input>";
							if(!"CU".equals(userRole))
							{
								questionHTML_Temp = questionHTML_Temp+"<tr><th>Enter your Reply/Comments in the below area</th></tr>";
								questionHTML_Temp = questionHTML_Temp+"<tr><th><textarea name=\"reply\" id=\"reply"+itemLineNo+"\" cols=\"10\" rows=\"5\"></textarea></th></tr>";
								questionHTML_Temp = questionHTML_Temp+"<tfoot></tfoot></table><br><input type=\"button\" label=\"Submit\"  value=\"Save\" onClick=\"funReply("+itemLineNo+",'R')\"></input>";
							}	
						}
						else
						{
							questionHTML = questionHTML+"<thead><tr><th>Query by &nbsp;&nbsp;&nbsp;<font color=\"red\">"+QKey.split("##")[2]+"</font>&nbsp; on <font color=\"red\">"+QuCatHash.get(QKey.split("##")[1])+"</font>&nbsp; dated <font color=\"red\">"+QKey.split("##")[3]+"</font></th></tr></thead>";
							questionHTML = questionHTML+"<tbody><tr><th>"+QKey.split("##")[0]+"</th></tr></tbody>";
							questionHTML = questionHTML+"<br><thead><th>Reply/Comments by ";
							questionHTML = questionHTML+"&nbsp;&nbsp;&nbsp;<font color=\"red\">"+AKey.split("##")[2]+"</font>&nbsp; on <font color=\"red\">"+QuCatHash.get(AKey.split("##")[1])+"</font>&nbsp; dated <font color=\"red\">"+AKey.split("##")[3]+"</font></Th></Thead>";
							questionHTML = questionHTML+"<tbody><tr><th>"+AKey.split("##")[0]+"</th></tr></tbody>";
						}
					}	

					//out.println("QKey::::::::::::::"+QKey+":::::AKey::::::"+AKey);
				}
				questionHTML = questionHTML+"<tfoot></tfoot></table>";
				
				//if("".equals(AKey) && !"CU".equals(userRole))questionHTML = questionHTML+"<br><input type=\"button\" label=\"Submit\"  value=\"Save\" onClick=\"funReply("+itemLineNo+")\"></input>";
			}
			else
			{
				QKey = (String)quesHash.get(tempQues);
				AKey = (String)ansHash.get(tempQues);
				QKey = ((QKey == null) || (("").equals(QKey)) || ("null".equalsIgnoreCase(QKey)))?"":QKey;
				AKey = ((AKey == null) || (("").equals(AKey)) || ("null".equalsIgnoreCase(QKey)))?"":AKey;
				if(!"".equals(AKey))reply =AKey;
				if(!"".equals(QKey) && !"null".equals(QKey) && !"N/A".equals(QKey.split("##")[1]))
				{
					if("".equals(AKey))
					{
						questionHTML_Temp = questionHTML_Temp+"<thead><tr><th>Query by &nbsp;&nbsp;&nbsp;<font color=\"red\">"+QKey.split("##")[2]+"</font>&nbsp; on <font color=\"red\">"+QuCatHash.get(QKey.split("##")[1])+"</font>&nbsp; dated <font color=\"red\">"+QKey.split("##")[3]+"</font></th></tr></thead>";
						questionHTML_Temp = questionHTML_Temp+"<tbody><tr><th><textarea name=\"reply\" id=\"modQuery"+itemLineNo+"\" cols=\"10\" rows=\"5\" >"+QKey.split("##")[0]+"</textarea></th></th></tr></tbody>";
						questionHTML_Temp = questionHTML_Temp+"<tfoot></tfoot></table><br><input type=\"button\" label=\"Submit\"  value=\"Save\" onClick=\"funReply("+itemLineNo+",'M')\"></input>";
						if(!"CU".equals(userRole))
						{
							questionHTML_Temp = questionHTML_Temp+"<tr><th>Enter your Reply/Comments in the below area</th></tr>";
							questionHTML_Temp = questionHTML_Temp+"<tr><th><textarea name=\"reply\" id=\"reply"+itemLineNo+"\" cols=\"10\" rows=\"5\"></textarea></th></tr>";
							questionHTML_Temp = questionHTML_Temp+"<tfoot></tfoot></table><br><input type=\"button\" label=\"Submit\"  value=\"Save\" onClick=\"funReply("+itemLineNo+",'R')\"></input>";
						}	
					}
					else
					{
						questionHTML = questionHTML+"<thead><tr><th>Query by &nbsp;&nbsp;&nbsp;<font color=\"red\">"+QKey.split("##")[2]+"</font>&nbsp; on <font color=\"red\">"+QuCatHash.get(QKey.split("##")[1])+"</font>&nbsp; dated <font color=\"red\">"+QKey.split("##")[3]+"</font></th></tr></thead>";
						questionHTML = questionHTML+"<tbody><tr><th>"+QKey.split("##")[0]+"</th></tr></tbody>";
						questionHTML = questionHTML+"<br><thead><th>Reply/Comments by ";
						questionHTML = questionHTML+"&nbsp;&nbsp;&nbsp;<font color=\"red\">"+AKey.split("##")[2]+"</font>&nbsp; on <font color=\"red\">"+QuCatHash.get(AKey.split("##")[1])+"</font>&nbsp; dated <font color=\"red\">"+AKey.split("##")[3]+"</font></Th></Thead>";
						questionHTML = questionHTML+"<tbody><tr><th>"+AKey.split("##")[0]+"</th></tr></tbody>";
					}
					questionHTML = questionHTML+"</table>";
					//if("".equals(AKey) && !"CU".equals(userRole))questionHTML = questionHTML+"<br><input type=\"button\" label=\"Submit\"  value=\"Save\" onClick=\"funReply("+itemLineNo+")\"></input>";
					//questionHTML = questionHTML+"<table><thead><tr><th>Comments</th><thead></thead><tbody><tr>"+reply+"</tbody><tfoot></tfoot></table>";
				}
				else
				{
					questionHTML = "<table ><thead><tr><th>No Queries To Display.</th></tr></thead><tfoot></tfoot></table>";
				}
			}

			//out.println("questionHTML::::::::::::::"+questionHTML);


		}

		questionHTML = questionHTML_Temp+questionHTML;
		//questionHTML = " TEMPORARY CHECK BY MB";
		if(!"null".equals(QKey) && !"".equals(QKey))
		{
%>
		<input type="hidden" name="qType<%=itemLineNo%>" value="<%=QKey.split("##")[1]%>"> 
<%				
					}
				}
		else{
			questionHTML = "No Queries To Display";
%>	
			<input type="hidden" name="qType<%=itemLineNo%>"> 
<%
				}
%>			
		<td align='center'>

<%			
		String qComnts = (String)QKey.split("##")[0];
		//out.println("qComnts:::::"+qComnts);
		int qComLen = qComnts.length();
		if(qComLen>70)
			qComnts = qComnts.substring(0,60)+"....";	
		if("".equals(qComnts))	qComnts = "N/A";
		if("CU".equals(userRole))
		{
			if("".equals(QKey))
			{

%>			
				<div class="VIEW<%=itemLineNo%>">
					<a class="fancybox" href="#VIEW<%=itemLineNo%>" >
<%
				if(!"null".equals(QKey) && !"".equals(QKey))
				{
%>				
					<span id="ASK<%=itemLineNo%>" style="display:none"><%=qComnts%></span><!--<input type=button value=Ask> -->
					<span id="HIDE<%=itemLineNo%>"> <%=qComnts%></span><!--<input type=button value=View> -->
<%
				}else{
%>				
					<span id="ASK<%=itemLineNo%>" ><%=qComnts%></span><!--<input type=button value=Ask> -->
					<span id="HIDE<%=itemLineNo%>" style="display:none"> <%=qComnts%></span><!--<input type=button value=View> -->
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
				<h2>Question/Comment</h2>
				<p>Ask a Question or Enter Special Instructions for American Standard .A pricing or credit query may delay processing of your order till the query is answered.</p>
				<br>

				<ul class="form-list">
				<li><label for="noteType" class="required">Query/Note Type<em>*</em> </label>
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
					<label for="ponumber" class="required">Text<em>*</em> </label>
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
				<div class="VIEW<%=itemLineNo%>">
				<a class="fancybox" href="#VIEW<%=itemLineNo%>"><span align="center"><%=qComnts%></span></a>
				</div>
				<div id="VIEW<%=itemLineNo%>" style="width:800px; display:none">
				<h2>Question/Comments</h2>
				<br>
				<%=questionHTML%>
				</div>				

<%
			}
		}
		else if(!"CU".equals(userRole))
		{
%>			
			
			<div class="VIEW<%=itemLineNo%>">
			<a class="fancybox" href="#VIEW<%=itemLineNo%>"><span align="center"><%=qComnts%></span></a>
			</div>
			<div id="VIEW<%=itemLineNo%>" style="width:800px; display:none">
			<h2>Question/Comments</h2>
			<br>
			<%=questionHTML%>
			</div>	
<%
				}
%>			


		</td>			

			
			<td width=10% align="right"><%=checkAuth(netValue,"VIEW_PRICES",userAuth_R)%></td>
			
			<td width="1%"><%=venCatalog%></td>
			<% if (pntspcs.equals("$")) { %>
			<td id="pointsgroup" ><%=venCatalog%>:<%=pntspcs%><%=(String)catalogHM.get(venCatalog)%></td>
			<%  } else { %>
			<td id="pointsgroup" ><%=venCatalog%>:<%=(String)catalogHM.get(venCatalog)%>&nbsp;<%=pntspcs%></td>
			<% } %>					
		</tr>			
<%

			}
		}

		String soValueBD="0";
		soValueBD = (String)SoValueHT.get(webOrdNo);
		if(frieghtTotal.length()==1 )
			frieghtTotal="0";
		try
		{
			soValueBD = new java.math.BigDecimal(soValueBD).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
		}
		catch(Exception e){
			soValueBD = (String)SoValueHT.get(webOrdNo);
		}
%>		
		</tbody>
		
		<tfoot>
			<tr>
				<td colspan="8" align="right"><h3>SubTotal</h3></td>
				<td>$<%=checkAuth(soValueBD,"VIEW_PRICES",userAuth_R)%></td>
			</tr>
			<tr>
				<td colspan="8" align="right"><h3>Shipping and Handling</h3></td>
				<td>$<%=checkAuth(frieghtTotal,"VIEW_PRICES",userAuth_R)%></td>
			</tr>
<%
		soValueBD = (new java.math.BigDecimal(soValueBD).add(new java.math.BigDecimal(frieghtTotal))).toString();
%>
			<tr>
				<td colspan="8" align="right"><h3>Grand Total</h3></td>
				<td>$<%=checkAuth(soValueBD,"VIEW_PRICES",userAuth_R)%></td>
			</tr>
			<!--<tr>
				<td colspan="8" class="a-right last"><h3>Total No. of Lines in Order : <%=retLinesCount%></h3></td>
			</tr>-->
		</tfoot>
	</table>
	<br>

<%
	}
	/********* Building Hidden fields as DataTables will not support hidden fields declared in its Tags(Thead,Tbody,Tfoot)******/
	sortedMap = new TreeMap(catalogHM);

	catCol = sortedMap.entrySet();
	Iterator hiddenIte = catCol.iterator();
	while(hiddenIte.hasNext())
	{
		Map.Entry catColData = (Map.Entry)hiddenIte.next();

		String cat_HM = (String)catColData.getKey();
		int ent = 0;		
		for(int i=0;i<retLinesCount;i++)
		{
			String venCatalog 	= retLines.getFieldValueString(i,"VENDOR_CATALOG");

			if(!cat_HM.equals(venCatalog))
				continue;

			String webOrdNo 	= retLines.getFieldValueString(i,"WEB_ORNO");
			String itemLineNo 	= retLines.getFieldValueString(i,"SO_LINE_NO");
			String itemDiv	 	= retLines.getFieldValueString(i,"DIVISION");
			String itemDC	 	= retLines.getFieldValueString(i,"DISCTCHANNEL");
			String itemSalesOrg 	= retLines.getFieldValueString(i,"SALESORG");
			String prdCode	 	= retLines.getFieldValueString(i,"PROD_CODE");
			String prdDesc	 	= retLines.getFieldValueString(i,"PROD_DESC");
			String dsrQty	 	= retLines.getFieldValueString(i,"DESIRED_QTY");
			String prdUom	 	= retLines.getFieldValueString(i,"UOM");
			String custMat	 	= retLines.getFieldValueString(i,"CUST_MAT");
			String vipFalg	 	= retLines.getFieldValueString(i,"VIP_FLAG");
			String dispFlag	 	= retLines.getFieldValueString(i,"DISPLAY_FLAG");
			String splFlag	 	= retLines.getFieldValueString(i,"QUICKSHIP_FLAG");
			String custSku		= retLines.getFieldValueString(i,"CUST_SKU");
			String custPoLine	= retLines.getFieldValueString(i,"CUST_PO_LINENO");
			String orderType	= retLines.getFieldValueString(i,"ORDER_TYPE");
			if(orderType!=null && !"null".equals(orderType))orderType = orderType.trim();
			String eanUPC		= retLines.getFieldValueString(i,"ITEM_UPC"); //UPC
			String itemListPrice	= retLines.getFieldValueString(i,"ITEM_LIST_PRICE");
			String tPNo		= "";
			String prodNoUD 	= "";	
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
			if(custSku==null || "".equals(custSku) || "null".equals(custSku))custSku = "";
			if(custPoLine==null || "".equals(custPoLine.trim()) || "null".equals(custPoLine.trim()))custPoLine = "";
			if(custPoLine!=null || !"".equals(custPoLine.trim()) || !"null".equals(custPoLine.trim()))custPoLine = custPoLine.trim();

%>
			<!--*******Hidden fields for adding to cart START *******-->	
			<input type="hidden" name="itemLineNo" value="<%=itemLineNo%>">
			<input type="hidden" name="itemDiv<%=itemLineNo%>" value="<%=itemDiv%>">
			<input type="hidden" name="itemDC<%=itemLineNo%>" value="<%=itemDC%>">
			<input type="hidden" name="itemSalesOrg<%=itemLineNo%>" value="<%=itemSalesOrg%>">
			<input type="hidden" name="tPNo<%=itemLineNo%>" value="<%=tPNo.trim()%>">
			<input type="hidden" name="prdDesc<%=itemLineNo%>" value='<%=prdDesc%>'>
			<input type="hidden" name="prdUom<%=itemLineNo%>" value="<%=prdUom%>">
			<input type="hidden" name="quantity<%=itemLineNo%>" value="<%=tqty%>">
			<input type="hidden" name="vipFalg<%=itemLineNo%>" value="<%=vipFalg%>">
			<input type="hidden" name="dispFlag<%=itemLineNo%>" value="<%=dispFlag%>">
			<input type="hidden" name="splFlag<%=itemLineNo%>" value="<%=splFlag%>">
			<input type="hidden" name="custSku<%=itemLineNo%>" value="<%=custSku%>">
			<input type="hidden" name="custPoLine<%=itemLineNo%>" value="<%=custPoLine.trim()%>">
			<input type="hidden" name="orderType<%=itemLineNo%>" value="<%=orderType.trim()%>">
			<input type="hidden" name="eanUPC<%=itemLineNo%>" value="<%=eanUPC%>">
			<input type="hidden" name="listPrice<%=itemLineNo%>" value="<%=itemListPrice%>">
			<!--*******Hidden fields for adding to cart END *******-->	
<%
		}
	}
 }	
%>	


</div> <!-- Info box -->
</div> <!-- col1-set -->
</div> <!-- col-main -->
</div> <!--main -->
</div> <!-- main-container col1-layout -->
</form>
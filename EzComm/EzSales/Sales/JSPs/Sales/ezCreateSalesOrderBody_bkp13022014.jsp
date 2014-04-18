<%@ include file="../../../Includes/JSPs/ShoppingCart/iCheckCartItems.jsp"%>
<%@ include file="../../../Includes/JSPs/Sales/iSimulateSalesOrderMulti.jsp"%>
<%@ include file="../Misc/ezTaxCodesAndDesc.jsp"%>
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
<%
	String soldToAddress = "";
	String shipToAddress = "";

	String dispAuth = (String)session.getValue("DISPAUTH");
	String vipAuth = (String)session.getValue("VIPAUTH");

	String webOrdNo = request.getParameter("webOrdNo");
	String soldToName = request.getParameter("soldToName");
	String soldToStreet = request.getParameter("soldToStreet");
	String soldToCity = request.getParameter("soldToCity");
	String soldToState = request.getParameter("soldToState");
	String soldToCountry = request.getParameter("soldToCountry");
	String soldToZipCode = request.getParameter("soldToZipCode");
	String soldToPhNum = request.getParameter("soldToPhNum");
	String soldToEmail = request.getParameter("soldToEmail");

	String shipToName = request.getParameter("shipToName");
	String shipToStreet = request.getParameter("shipToStreet");
	String shipToCity = request.getParameter("shipToCity");
	String shipToState = request.getParameter("shipToState");
	String shipToCountry = request.getParameter("shipToCountry");
	String shipToZipCode = request.getParameter("shipToZip");
	String shipToPhNum = request.getParameter("shipToPhone");

	if(soldToName!=null && !"null".equals(soldToName) && !"".equals(soldToName.trim()))
	{
		soldToName = soldToName.replaceAll("\'","`");
		soldToAddress = soldToAddress + soldToName +"<br>";
	}
	if(soldToStreet!=null && !"null".equals(soldToStreet) && !"".equals(soldToStreet.trim()))
	{
		soldToStreet = soldToStreet.replaceAll("\'","`");
		soldToAddress = soldToAddress + soldToStreet +"<br>";
	}
	if(soldToCity!=null && !"null".equals(soldToCity) && !"".equals(soldToCity.trim()))
	{
		soldToCity = soldToCity.replaceAll("\'","`");
		soldToAddress = soldToAddress + soldToCity +", ";
	}
	if(soldToZipCode!=null && !"null".equals(soldToZipCode) && !"".equals(soldToZipCode.trim()))
	{
		soldToZipCode = soldToZipCode.replaceAll("\'","`");
		soldToAddress = soldToAddress + soldToZipCode +" ";
	}
	if(soldToState!=null && !"null".equals(soldToState) && !"".equals(soldToState.trim()))
		soldToAddress = soldToAddress + soldToState +" ";
	if(soldToCountry!=null && !"null".equals(soldToCountry) && !"".equals(soldToCountry.trim()))
		soldToAddress = soldToAddress + soldToCountry +"<br>";
	if(soldToPhNum!=null && !"null".equals(soldToPhNum) && !"".equals(soldToPhNum.trim()))
	{
		soldToPhNum = soldToPhNum.replaceAll("\'","`");
		soldToAddress = soldToAddress + "Tel#:" +soldToPhNum +"<br>";
	}

	if(shipToName!=null && !"null".equals(shipToName) && !"".equals(shipToName.trim()))
	{
		shipToName = shipToName.replaceAll("\'","`");
		shipToAddress = shipToAddress + shipToName +"<br>";
	}
	if(shipToStreet!=null && !"null".equals(shipToStreet) && !"".equals(shipToStreet.trim()))
	{
		shipToStreet = shipToStreet.replaceAll("\'","`");
		shipToAddress = shipToAddress + shipToStreet +"<br>";
	}
	if(shipToCity!=null && !"null".equals(shipToCity) && !"".equals(shipToCity.trim()))
	{
		shipToCity = shipToCity.replaceAll("\'","`");
		shipToAddress = shipToAddress + shipToCity +", ";
	}
	if(shipToZipCode!=null && !"null".equals(shipToZipCode) && !"".equals(shipToZipCode.trim()))
	{
		shipToZipCode = shipToZipCode.replaceAll("\'","`");
		shipToAddress = shipToAddress + shipToZipCode +" ";
	}
	if(shipToState!=null && !"null".equals(shipToState) && !"".equals(shipToState.trim()))
		shipToAddress = shipToAddress + shipToState +" ";
	if(shipToCountry!=null && !"null".equals(shipToCountry) && !"".equals(shipToCountry.trim()))
		shipToAddress = shipToAddress + shipToCountry +" ";
	if(shipToPhNum!=null && !"null".equals(shipToPhNum) && !"".equals(shipToPhNum.trim()))
	{
		shipToPhNum = shipToPhNum.replaceAll("\'","`");
		shipToAddress = shipToAddress + "<br>Tel#:" +shipToPhNum +"<br>";
	}
	String purposeOrder 	= request.getParameter("purposeOrder");
	String reasonCode 	= request.getParameter("reasonCode");
	String explanation 	= request.getParameter("explanation");
	String approver 	= request.getParameter("approver");
	String defCat1	 	= request.getParameter("defCat1");
	String defCat2 		= request.getParameter("defCat2");
	String defCat3 		= request.getParameter("defCat3");
	String focApprover 	= request.getParameter("focApprover");

	if(purposeOrder==null || "null".equalsIgnoreCase(purposeOrder)) purposeOrder = "";
	if(reasonCode==null || "null".equalsIgnoreCase(reasonCode)) reasonCode = "";
	if(explanation==null || "null".equalsIgnoreCase(explanation)) explanation = "";
	if(approver==null || "null".equalsIgnoreCase(approver)) approver = "";
	if(defCat1==null || "null".equalsIgnoreCase(defCat1)) defCat1 = "";
	if(defCat2==null || "null".equalsIgnoreCase(defCat2)) defCat2 = "";
	if(defCat3==null || "null".equalsIgnoreCase(defCat3)) defCat3 = "";
	if(focApprover==null || "null".equalsIgnoreCase(focApprover)) focApprover = "N";

	if(!"".equals(explanation))
	{
		explanation = explanation.replaceAll("\'","`");
		billToAddress = explanation.trim();
	}

	if(!"".equals(comments)) comments = comments.replaceAll("\'","`");
	if(!"".equals(shipInst)) shipInst = shipInst.replaceAll("\'","`");

	String loginUserId = Session.getUserId();
	loginUserId = loginUserId.trim();
	loginUserId = loginUserId.toUpperCase();

	String Currency = itemoutTable.getFieldValueString(0,"Currency");

	session.putValue("PURP_PREP",purposeOrder);
	session.putValue("REASON_PREP",reasonCode);
	session.putValue("EXPL_PREP",explanation);
	session.putValue("APPR_PREP",approver);
	session.putValue("DEFCAT1_PREP",defCat1);
	session.putValue("DEFCAT2_PREP",defCat2);
	session.putValue("DEFCAT3_PREP",defCat3);

	session.putValue("PONUM_PREP",poNumber);
	session.putValue("PODATE_PREP",poDate);

	session.putValue("SOLDTO_PREP",soldToCode);
	session.putValue("COMMENTS_PREP",comments);
	session.putValue("SHIPINST_PREP",shipInst);

	session.putValue("SHIPMETHOD_PREP",shipMethod);
	session.putValue("DESDATE_PREP",desiredDate);
	session.putValue("CARRNAME_PREP",carrierName);
	session.putValue("CARRID_PREP",carrierId);
	session.putValue("BNAME_PREP",billToName);
	session.putValue("BSTREET_PREP",billToStreet);
	session.putValue("BCITY_PREP",billToCity);
	session.putValue("BSTATE_PREP",billToState);
	session.putValue("BZIPCODE_PREP",billToZipCode);
	session.putValue("CARRUSE_PREP",useMyCarrier);
	session.putValue("ISRESID_PREP",isResidential);

	session.putValue("SHIPTO_PREP",shipToCode);
	session.putValue("SHIPNA_PREP",shipToName);
	session.putValue("SHIPSR_PREP",shipToStreet);
	session.putValue("SHIPCT_PREP",shipToCity);
	session.putValue("SHIPZC_PREP",shipToZipCode);
	session.putValue("SHIPST_PREP",shipToState);
	session.putValue("SHIPCN_PREP",shipToCountry);
	session.putValue("SHIPPH_PREP",shipToPhNum);

	session.putValue("PROMO_PREP",promoCode);
	
	/************ Questions/Comments from saved order Start *******/
	HashMap QuCatHash = new HashMap();
	QuCatHash.put("01","Special Shipping Instruction");
	QuCatHash.put("02","General Order Processor Note");
	QuCatHash.put("03","----------------------------");
	QuCatHash.put("04","Line Pricing Multiplier");
	QuCatHash.put("05","Freight Allowance");
	QuCatHash.put("06","Quick Ship Program");
	QuCatHash.put("07","Display Items on Order");
	QuCatHash.put("08","Other");		

	EzcParams mainParamsNeg= new EzcParams(false);
	EziMiscParams miscParamsNeg = new EziMiscParams();	
	Vector types = new Vector();
	Vector names = new Vector();

	Hashtable quesHash = null;
	Hashtable ansHash  = null;
	Hashtable noQHash  = null;	
	ArrayList replSpList = null;	
	if(webOrdNo!=null && !"null".equals(webOrdNo))	
	{
		mainParamsNeg= new EzcParams(false);
		miscParamsNeg = new EziMiscParams();
		boolean dispBool = false;
		String modiBy	 = "";
		String currId	 = Session.getUserId();

		ReturnObjFromRetrieve retNegOrderDtl = null;		
		miscParamsNeg.setIdenKey("MISC_SELECT");
		miscParamsNeg.setQuery("SELECT * FROM EZC_ORDER_NEGOTIATE WHERE EON_ORDER_NO = '"+webOrdNo+"' ORDER BY EON_CREATED_ON DESC");

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
					replSpList.add(webOrdNo);

				if("Q".equals(negQType)) 
				{
					quesHash.put(negItemNO+""+negIndex,negText+"##"+negCat+"##"+negCreatedBy+"##"+createdOn);	

					if((tempVec.contains(negItemNO)))
						noQHash.put(negItemNO,tempIndex+"#"+noQHash.get(negItemNO));
					else
					{
						tempVec.add(negItemNO);
						noQHash.put(negItemNO,tempIndex);
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
	}

	String apprEmail = "";
	if(approver==null || "null".equalsIgnoreCase(approver) || "".equals(approver))
	{
		mainParamsNeg= new EzcParams(false);
		miscParamsNeg = new EziMiscParams();

		miscParamsNeg.setIdenKey("MISC_SELECT");

		String query = "SELECT VALUE2 FROM EZC_VALUE_MAPPING WHERE MAP_TYPE='FDPURPTOEMAIL' AND VALUE1='"+purposeOrder+"'";

		miscParamsNeg.setQuery(query);

		mainParamsNeg.setLocalStore("Y");
		mainParamsNeg.setObject(miscParamsNeg);
		Session.prepareParams(mainParamsNeg);	

		try
		{
			ReturnObjFromRetrieve fdAppRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsNeg);
			if(fdAppRetObj!=null && fdAppRetObj.getRowCount()>0)
				apprEmail = fdAppRetObj.getFieldValueString(0,"VALUE2");
		}
		catch(Exception e){}
	}

	/************ Questions/Comments from saved order End *******/
%>
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
	#socreate_wrapper .fg-toolbar { font-size: 0.8em }
	#theme_links span { float: left; padding: 2px 10px; }
	#socreate_wrapper { -webkit-box-shadow: 2px 2px 6px #666; box-shadow: 2px 2px 6px #666; border-radius: 5px; }
	#socreate tbody {
		border-left: 1px solid #AAA;
		border-right: 1px solid #AAA;
	}
	#socreate thead th:first-child { border-left: 1px solid #AAA; }
	#socreate thead th:last-child { border-right: 1px solid #AAA; }
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
		var soLine = aData[1].substring(aData[1].indexOf('>')+1,aData[1].indexOf('</div>'));
		var ccompName = 'childComponents'+soLine+'';
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

		$('#socreate thead tr').each( function () {
			// Do not insert empty column in pricing data/condition tables..
			//if ($(this).attr("id") != "condtablehdrrow") {
			//this.insertBefore( nCloneTh, this.childNodes[0] );
			//console.log(" Inserting header column ");
			//}
		} );
		$('#socreate tfoot tr').each( function () {
			//console.log("in footer");
			//this.insertBefore( nCloneTdEmpty, this.childNodes[0] );
		} );
		$('#socreate tbody tr').each( function () {
			var vCol0 = $(this).find('#solineinfo:first').text();

			if (vCol0 !="") {
				var soLine = vCol0;
				var ccompName = 'childComponents'+soLine+'';

				if ($(document.getElementById(ccompName)).val()!=""){
					nCloneTd.innerHTML = '&nbsp;<p align="center"><input type="checkbox" name="CheckBox1" value="'+soLine+'" unchecked ><br><br><img src="http://datatables.net/release-datatables/examples/examples_support/details_open.png" id="openimg" name="openimg"></p>';
					this.insertBefore(  nCloneTd.cloneNode( true ), this.childNodes[0] );
				} else {
					nCloneTdEmpty.innerHTML = '&nbsp;<p align="center"><input type="checkbox" name="CheckBox1" value="'+soLine+'" unchecked ></p>';
					this.insertBefore(  nCloneTdEmpty.cloneNode( true ), this.childNodes[0] );
				};
			} // end vCol0
			else
			{
				var vPointsGroup = $(this).find('#pointsgroup').text();	
				if (vPointsGroup != ""){
					nCloneTdEmpty.innerHTML = '&nbsp;<p align="center"><input type="checkbox" name="CheckBox1" value="'+soLine+'" unchecked ></p>';
					this.insertBefore(  nCloneTdEmpty.cloneNode( true ), this.childNodes[0] );
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

		var oTable = $('#socreate').dataTable( {

		"fnDrawCallback": function ( oSettings ) {
		if ( oSettings.aiDisplay.length == 0 )
		{
			return;
		}
		var nTrs = $('#socreate tbody tr#linedatarow');
		var iColspan = nTrs[0].getElementsByTagName('td').length;
		var sLastGroup = "";
		for ( var i=0 ; i<nTrs.length ; i++ )
		{
			var iDisplayIndex = oSettings._iDisplayStart + i;
			var sGroup = oSettings.aoData[ oSettings.aiDisplay[iDisplayIndex] ]._aData[12];
			var sGroupPoint = oSettings.aoData[ oSettings.aiDisplay[iDisplayIndex] ]._aData[13];
			// THIS CODE ASSUMES THAT 10th Column carries the vendor catalog which is hidden info.
			// Also column 11 has the value of points
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
			{ "bSortable": false, "aTargets": [ 0,1,2,3,4,5,6,7,8,9,10 ] },
			{ "bVisible": false, "aTargets": [ 11 ] },
			{ "bVisible": false, "aTargets": [ 12 ] },
			{ "bVisible": false, "aTargets": [ 13 ] }
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
		oTable.fnSortListener( document.getElementById('sorter'), 11 );
		oTable.fnSortListener( document.getElementById('sorter2'), 12 );
	} );
</script>
	
<script type="text/javascript">
$(function(){
	var onSampleResized = function(e){
		var columns = $(e.currentTarget).find("th");
		var msg = "columns widths: ";
		columns.each()
	};

	$("#socreate").colResizable({
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
<style>
#darkbox {
   position: absolute;
   top: 0px;
   left: 0px;
   opacity: 0.6;
   filter:alpha(opacity=60);
   background: #000;
}

#content {
   position: absolute;
   z-index: 1001;
   background: #fff;
   border: 10px solid #FFF;
   width: 250px;
   height: 100px;
}
#content #main_content {
   overflow: auto;
   width: 250px;
   height:100px;
}

</style>
<script type="text/javascript">

// Black overlay element
var darkbox;
// Content box
var content;

// FUNCTIONS
function saveTemp()
{
	window.scrollTo(0,0); // horizontal and vertical scroll increments
	window.onscroll = scroll_box;
	// Create elements
	darkbox = document.createElement('div');
	content = document.createElement('div');

	// Style them with the existing ids
	darkbox.id = 'darkbox';
	content.id = 'content';

	// FILL CONTENT BOX
	// Have the close button
	// The main content

	content.innerHTML  += '<html><body><form name="saveForm"><div id="main_content" ><h1><b><font size=3px align=center>Enter Template Name:</font></b></h1><input type="text" name="tempName" value=""><br><br><input type="button" name="OK" value="Ok" onClick="agree()">&nbsp;&nbsp;&nbsp;<a  href="javascript:closeBox();"><input type="button" name="Close" value="Cancel"></a></form></body></html>';
	// Add these elements to the body

	document.body.appendChild(darkbox);
	document.body.appendChild(content);

	// Calciulate coordinates and such
	var pos_top = document.documentElement.scrollTop
	var pos_left = document.documentElement.scrollLeft;
	var screen_width = document.documentElement.clientWidth;
	var screen_height = document.documentElement.clientHeight;

	// Place the "darkbox" element and give it the size

	darkbox.style.top = pos_top + 'px';
	darkbox.style.left = pos_left + 'px';
	darkbox.style.height = '200%';
	darkbox.style.width = screen_width + 'px';

	// Now place the content box at the center
	content.style.left = (pos_left + (screen_width / 2.0) - (content.offsetWidth / 2.0)) + 'px';
	content.style.top = '60%' //(pos_top + (screen_height / 2.0) - (content.offsetHeight / 2.0)) + 'px';
}
function agree()
{
	var name= document.saveForm.tempName.value
	document.generalForm.templateName.value=name
	if(document.saveForm.tempName.value!='')
	{
		Popup.showModal('modal1');
		document.generalForm.status.value='NEW'
		document.generalForm.action="../Sales/ezAddSaveSales.jsp"
		document.generalForm.submit();
		document.body.removeChild(darkbox);
		document.body.removeChild(content);
	}		
}

function scroll_box ()
{
	// If "Darkbox" open
	if(darkbox != null)
	{
		// Find new topmost, leftmost position w.r.t the current viewport
		// Also find new window size

		var pos_top = document.documentElement.scrollTop
		var pos_left = document.documentElement.scrollLeft;
		var screen_width = document.documentElement.clientWidth;
		var screen_height = document.documentElement.clientHeight;

		// Positions elements accordingly
		darkbox.style.top = pos_top + 'px';
		darkbox.style.left = pos_left + 'px';
		darkbox.style.height = '200%';
		darkbox.style.width = screen_width + 'px';

		content.style.left = (pos_left + (screen_width / 2.0) - (content.offsetWidth / 2.0)) + 'px';
		content.style.top = '60%';//(pos_top + (screen_height / 2.0) - (content.offsetHeight / 2.0)) + 'px';
	}
}

function closeBox()
{
	// Delete elements
	document.body.removeChild(darkbox);
	document.body.removeChild(content);
}

function checkAll(field)
{
	if(document.generalForm.CheckBoxAll.checked)
	{
		if(isNaN(field.length))
		{
			document.generalForm.CheckBox1.checked = true;
		}
		else
		{
			for(i=0;i<field.length;i++)
			{
				document.generalForm.CheckBox1[i].checked = true ;
			}
		}
	}
	else
	{
		if(isNaN(field.length))
		{
			document.generalForm.CheckBox1.checked = false;
		}
		else
		{
			for(i=0;i<field.length;i++)
			{
				document.generalForm.CheckBox1[i].checked = false;
			}
		}
	}
}
function chkSelItem(num)
{
	var chkbox = document.generalForm.CheckBox1.length;
	if(isNaN(chkbox))
	{
		document.generalForm.CheckBox1.checked=true;
	}
	else
	{
		for(i=0;i<chkbox;i++)
		{
			var chkVal = document.generalForm.CheckBox1[i].value;
			if(num==chkVal)
			{
				document.generalForm.CheckBox1[i].checked=true;
			}
		}
	}
	return true;
}

function goBack()
{
	Popup.showModal('modal1');

	var cType = document.generalForm.catType_C.value;

	if(cType=='FOC')
		document.generalForm.action="../Sales/ezPrepareFOCOrder.jsp";
	else
		document.generalForm.action="../Sales/ezPrepareSalesOrder.jsp"

	document.generalForm.submit();
}
function submitOrder(status,authChk)
{
	if(authChk=='FAIL')
	{
		parent.$.fancybox.close();
		$("#dialog-authCheck").dialog('open');
	}
	else
	{
		var textMsg = "Are you sure you want to submit the order?";

		if(status=='NEW')
		{
			textMsg = "Are you sure you want to save the order?";

			var tName = document.getElementById("tempName").value.trim();
			if(tName=='')
			{
				alert("Please Enter Template Name");
				return;
			}
			else
			{
				document.generalForm.templateName.value=tName;
				event.preventDefault();
				parent.$.fancybox.close();
				$('generalForm').submit();
			}
		}
		var cType = document.generalForm.catType_C.value;
		var edMsg = document.generalForm.quickEddMsg.value;

		if(edMsg=='Y')
			textMsg = "Expected Delivery Is Not Applicable For This Order.\n\n\n"+textMsg;

		if(cType=='FOC')
			document.generalForm.shipToCode.value="0999999999";


		document.generalForm.status.value=status
		document.generalForm.webNO.value="<%=webOrdNo%>"

		$("#dialog-confirm1").dialog('open').text(textMsg);
	}
}
function saveOrder()
{
	Popup.showModal('modal1');
	document.generalForm.status.value='NEW'
	document.generalForm.action="../Sales/ezAddSaveSales.jsp"
	document.generalForm.submit();
}

function deleteItem()
{
	var chkbox = document.generalForm.CheckBox1.length;
	var itemChk = false;
	if(isNaN(chkbox))
	{
		if(document.generalForm.CheckBox1.checked)
			itemChk = true;
	}
	else
	{
		for(i=0;i<chkbox;i++)
		{
			if(document.generalForm.CheckBox1[i].checked)
				itemChk = true;
		}
	}

	if(eval(itemChk))
	{
		Popup.showModal('modal1');

		document.generalForm.action="../ShoppingCart/ezDeleteCartItems.jsp";
		document.generalForm.submit();
	}
	else
	{
		$("#dialog-deleteItem").dialog('open');
	}
}
$(function() {
	$( "#dialog-deleteItem" ).dialog({
		autoOpen: false,
		resizable: true,
		height:200,
		width:400,
		modal: true,
		buttons: {
			"Ok": function() {
				$( this ).dialog( "close" );

				document.generalForm.CheckBoxAll.checked = true;
				checkAll(document.generalForm.CheckBox1)

				Popup.showModal('modal1');

				document.generalForm.action="../ShoppingCart/ezDeleteCartItems.jsp";
				document.generalForm.submit();
			},
			"Cancel": function() {
				$( this ).dialog( "close" );
			}
		}
	});
	$( "#dialog-confirm1" ).dialog({
		autoOpen: false,
		resizable: true,
		height:150,
		width:400,
		modal: true,
		buttons: {
			"Ok": function() {
				$( this ).dialog( "close" );

				Popup.showModal('modal1');
				document.generalForm.action="../Sales/ezAddSaveSales.jsp"
				document.generalForm.submit();
			},
			"Cancel": function() {
				$( this ).dialog( "close" );
			}
		}
	});
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
function getProductDetails(code)
{
	document.generalForm.prodCode_D.value=code;

	document.generalForm.action="../Catalog/ezProductDetails.jsp";
	document.generalForm.target="_blank";
	document.generalForm.submit();
}
function funAttach()
{
	var iframeObj = document.getElementById("AttachFiles");
}
function SaveValues(lineNO)
{		
	var flagList = document.generalForm.flagList.value;
	var query    = document.getElementById("query"+lineNO).value;
	var comments = document.getElementById("qComments"+lineNO).value;
	comments = comments.replace("'","`")
	if(comments=="")
	{
		alert("Enter Comments")
		return;
	}
	if(query=="")
	{
		alert("Select Type")
		return;
	}		
	if(flagList==0)
	{
		document.getElementById("review").style.display=""
		document.getElementById("review_1").style.display="none"
		document.getElementById("review1").style.display=""
		document.getElementById("review_11").style.display="none"
	}	
	document.getElementById("ASK"+lineNO).style.display="none"
	document.getElementById("HIDE"+lineNO).style.display="block"
	var qObj 	= eval("document.generalForm.qType"+lineNO)
	var quesObj     = eval("document.generalForm.QComments"+lineNO)
	qObj.value	= query
	quesObj.value	= comments
	document.generalForm.NegFlag.value="Y"
	var comLen = comments.length;
	if(comLen>70)
		comments = comments.substring(0,60)+"....";

	document.getElementById("HIDE"+lineNO).innerHTML = comments;

	event.returnValue = false;
	parent.$.fancybox.close();  
	$('generalForm').submit();
}
function showRePrice()
{
	var rCnt = <%=rCount%>;
	var cFlag = false;

	for(var i=0;i<rCnt;i++)
	{
		var lNo = document.getElementsByName("lineItem")[i].value;

		var valDTTxt = eval("document.generalForm.docType_"+lNo).value;
		var valDTHid = eval("document.generalForm.docTypeHid_"+lNo).value;

		if((valDTTxt.toUpperCase())!=(valDTHid.toUpperCase()))
		{
			cFlag = true;
			break;
		}

		var valSOTxt = eval("document.generalForm.salesOrg_"+lNo).value;
		var valSOHid = eval("document.generalForm.salesOrgHid_"+lNo).value;

		if(!isNaN(valSOTxt) && !isNaN(valSOHid) && (parseFloat(valSOTxt))!=(parseFloat(valSOHid)))
		{
			cFlag = true;
			break;
		}

		var valDVTxt = eval("document.generalForm.division_"+lNo).value;
		var valDVHid = eval("document.generalForm.divisionHid_"+lNo).value;

		if(!isNaN(valDVTxt) && !isNaN(valDVHid) && (parseFloat(valDVTxt))!=(parseFloat(valDVHid)))
		{
			cFlag = true;
			break;
		}

		var valDCTxt = eval("document.generalForm.distChnl_"+lNo).value;
		var valDCHid = eval("document.generalForm.distChnlHid_"+lNo).value;

		if(!isNaN(valDCTxt) && !isNaN(valDCHid) && (parseFloat(valDCTxt))!=(parseFloat(valDCHid)))
		{
			cFlag = true;
			break;
		}

		var valSMTxt = eval("document.generalForm.stdMulti_"+lNo).value;
		var valSMHid = eval("document.generalForm.stdMultiHid_"+lNo).value;

		if(!isNaN(valSMTxt) && !isNaN(valSMHid) && (parseFloat(valSMTxt))!=(parseFloat(valSMHid)))
		{
			cFlag = true;
			eval("document.generalForm.stdMultiChng_"+lNo).value = "Y";
			break;
		}

		var valNPTxt = eval("document.generalForm.netPrice_"+lNo).value;
		var valNPHid = eval("document.generalForm.netPriceHid_"+lNo).value;

		if(!isNaN(valNPTxt) && !isNaN(valNPHid) && (parseFloat(valNPTxt))!=(parseFloat(valNPHid)))
		{
			cFlag = true;
			eval("document.generalForm.netPriceChng_"+lNo).value = "Y";
			break;
		}
	}

	if(!cFlag)
	{
		document.getElementById("divAction").style.display="block";
		document.getElementById("divProcess").style.display="none";
		document.getElementById("divAction1").style.display="block";
		document.getElementById("divProcess1").style.display="none";
	}
	else
	{
		document.getElementById("divAction").style.display="none";
		document.getElementById("divProcess").style.display="block";
		document.getElementById("divAction1").style.display="none";
		document.getElementById("divProcess1").style.display="block";
	}
}
function processAgain()
{
	Popup.showModal('modal1');

	document.generalForm.updateFlag.value="Y";
	document.generalForm.action="../Sales/ezCreateSalesOrder.jsp";
	document.generalForm.submit();
}
function KeySubmit()
{
	if (event.keyCode==13)
		agree()
}
function changePrices(obj,multi)
{
	var multiplier; 
	var e = document.getElementById("stdMulti_"+multi);
	var strUser = e.options[e.selectedIndex].value;
	alert("strUser"+strUser);
}
</script>
<body>
<form name="generalForm" method="post" >
<div id="dialog-deleteItem" title="Delete Product(s)" style="display:none">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Are you sure you want to delete all the items?</p>
</div>
<div id="dialog-confirm1" title="Confirmation" style="display:none">
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
<div class="main-container col2-layout middle account-pages">
<div class="main">
<div class="col-main1 roundedCorners">
<div class="page-title">
	<div class='highlight'>
		<table>
		<tbody>
		<tr>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td>
			<table>
				<tbody>
				<tr>
					<td>
						<font size='5' color='black'>&nbsp;&nbsp;REVIEW AND CONFIRM ORDER</font>
					</td>
				</tr>
				<tr>
					<td>
						<span class="grey-item">&nbsp;&nbsp;&nbsp;&nbsp;<strong>PO #:</strong> <%=poNumber%></span>
						<span class="grey-item">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>PO Date:</strong> <%=poDate%></span>
					</td>
				</tr>
				</tbody>
			</table>
			</td>
		</tr>
		</tbody>
		</table>
	</div>

<input type="hidden" name="lineNo">
<input type="hidden" name="setEDDFlag" value="<%=eDDFlag%>">
<input type="hidden" name="fromPage" value="ezCreateSalesOrder.jsp">
<input type="hidden" name="status">
<input type="hidden" name="templateName">
<input type="hidden" name="webNO">
<input type="hidden" name="updateFlag">
<input type="hidden" name="NegFlag">
<input type="hidden" name="catType_C" value="<%=catType_C%>">
<input type="hidden" name="dispFlag_S" value="<%=dispFlag_S%>">
<input type="hidden" name="vipFlag_S" value="<%=vipFlag_S%>">
<%
	if(retStrucCnt>0)
	{
%>
	<ul class="error-msg">
	<li>
<%
		if(msg !=null && !"null".equals(msg) && msg.trim().length() !=0)
			out.println("Error:"+msg);
		else
			out.println("Prices not defined");
%>
	</li>
	</ul>
	<br>
<%
	}
%>
	<div style="padding-left:2px;padding-top:10px"><p>
		<ul style="list-style-type:square;list-style-position:inside;">
		<li >Please check the order Status periodically for recent updates/activities.</li>
		<li >Cancellation must be received 3 business days prior to expected Ship Date.</li>
		<li >Orders for Custom Products cannot be cancelled.</li>
		<li >Customers cancelling orders for shower doors after 24 hours of entry will be charged a $75 cancellation fee per door panel.</li>
		</ul>
	</p>
	</div>
	<br>
	<div id="divAction" style="display:block">
		<button type="button" title="Back" class="button" onclick="javascript:goBack()">
		<span class="left-link">Back</span></button>
		<a class="fancybox" href="#ATTACHEDFILES">
		<button type="button" class="button btn-update"><span>Attach Docs</span></button>
		</a>
<%
	String authChk_SO = "FAIL";
	String authChk_VIP = "FAIL";
	String authChk_DISP = "FAIL";
	String authChk_FOC = "FAIL";
	String authChk_VD = "FAIL";
	String authChk_FOCAPPR = "FAIL";
	String authChk_TEMP = "FAIL";

	ezc.record.util.EzOrderedDictionary userAuth_R = Session.getUserAuth();

	if(userAuth_R.containsKey("SUBMIT_ORDER")) authChk_SO = "PASS";
	if(userAuth_R.containsKey("VIP_ORDER")) authChk_VIP = "PASS";
	if(userAuth_R.containsKey("DISP_ORDER")) authChk_DISP = "PASS";
	if(userAuth_R.containsKey("FOC_ORDER")) authChk_FOC = "PASS";
	if(userAuth_R.containsKey("FOC_APPR")) authChk_FOCAPPR = "PASS";
	if(userAuth_R.containsKey("SO_TEMPLATE")) authChk_TEMP = "PASS";

	boolean dispOrderByInt = false;

	if((dispFlag_S || vipFlag_S) && !"CU".equals(userRole) && userAuth_R.containsKey("DISP_ORDER"))
	{
		dispOrderByInt = true;
		authChk_SO = "PASS";
	}

	boolean focOrder = false;
	boolean focOrderByRep = false;
	if(!"CU".equals(userRole) || "FOC".equals(catType_C)) focOrder = true;
	else if("CU".equals(userRole) && !"FOC".equals(catType_C)) focOrderByRep = true;

	ReturnObjFromRetrieve quesRetObj = null;

	if(focOrderByRep)
	{
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
	}

	if(retStrucCnt==0)
	{
		if(!"FOC".equals(catType_C))
		{
%>
			<div id='save' style="float:left">
				<a class="fancybox" href="#SAVE" >
					<button type="button" title="Save Template" class="button" ><span>Save Template</span></button>
				</a>
			</div>
			<div id="SAVE" style="display:none">
			<h2>Please Enter Template Name</h2>
			<br>
			<ul class="form-list">
			<li>
				<div class="input-box">
					&nbsp;<input type="text" name="tempName" id="tempName" maxlength="60">
				</div>
			</li>
			<li>
				<input type="button" label="Submit" text="Submit" value="Submit" onClick="submitOrder('NEW','<%=authChk_TEMP%>')"></input>
			</li>
			</ul>
			</div>			
<%
		}
		if("CU".equals(userRole))
		{
%>
			<!--<button type="button" title="Save for Internal Review" class="button" onclick="javascript:saveOrder()">
			<span>Save for Internal Review</span></button>-->
<%
		}
		if("FOC".equals(catType_C))
		{
			if("Y".equals(focApprover) || loginUserId.equals(approver))
			{
%>
				<button type="button" title="Submit to ASB" class="button" onclick="javascript:submitOrder('TRANSFERED','<%=authChk_FOCAPPR%>')">
				<span class="right-link">Submit to ASB</span></button>
<%
			}
			else
			{
%>
				<button type="button" title="Submit for Approval" class="button" onclick="javascript:submitOrder('SUBMITTED','<%=authChk_FOC%>')">
				<span class="right-link">Submit for Approval</span></button>
<%
			}
		}
		else if(!(dispFlag_S || vipFlag_S) && "CU".equals(userRole))
		{
%>
			<button type="button" title="Submit My Question" class="button" onclick="javascript:submitOrder('NEGOTIATED','<%=authChk_SO%>')" id="review" style="display:none">
			<span class="right-link">Submit My Question</span></button>
			<button type="button" title="Submit to ASB" class="button" onclick="javascript:submitOrder('TRANSFERED','<%=authChk_SO%>')" id="review_1">
			<span class="right-link">Submit to ASB</span></button>
<%
		}
		else if((dispFlag_S || vipFlag_S) && "CU".equals(userRole))
		{
			if(vipFlag_S && "PASS".equals(authChk_VIP))
				authChk_VD = "PASS";
			else if(vipFlag_S && "FAIL".equals(authChk_VIP))
				authChk_VD = "FAIL";
			if(dispFlag_S && "PASS".equals(authChk_DISP))
				authChk_VD = "PASS";
			else if(dispFlag_S && "FAIL".equals(authChk_DISP))
				authChk_VD = "FAIL";
%>
			<button type="button" title="Submit for Review" class="button" onclick="javascript:submitOrder('NEGOTIATED','<%=authChk_VD%>')">
			<span class="right-link">Submit for Review</span></button>
<%
		}
		else if(!"CU".equals(userRole))
		{
%>
			<button type="button" title="Submit to ASB" class="button" onclick="javascript:submitOrder('TRANSFERED','<%=authChk_SO%>')">
			<span class="right-link">Submit to ASB</span></button>
<%
		}
	}
%>
	</div>
	<div id="divProcess" style="display:none">
		<button type="button" title="Back" class="button" onclick="javascript:goBack()">
		<span class="left-link">Back</span></button>
		<button type="button" title="Re Pricing" class="button" onclick="javascript:processAgain()">
		<span>Re Pricing</span></button>
	</div>
	<div id='Sort Button'>
		<ul id="navbar">
			<li><a href="javascript:void()" style="padding-top:7px;padding-bottom:5px;">Sort &nbsp;&nbsp;<span class="arrow"></span></a>
			<ul>
				<li><a style="cursor:pointer;" id='sorter'><span>By PO Line No</span></a></li>
				<li><a style="cursor:pointer;" id='sorter2'><span>By Price Group</span></a></li>
			</ul>
			</li>
		</ul>
	</div>
	<br><br>
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
<%
	if("FOC".equals(catType_C))
	{
%>
		<h2 class="sub-title">FD Exp. Int A/c code</h2>
		<p><%=soldToAddress%></p>
<%
	}
	else
	{
%>
		<h2 class="sub-title">Sold To Address</h2>
		<p><%=soldToAddress%></p>
<%
	}
	if(!"".equals(promoCode))
	{
%>
		<h2 class="sub-title">Promo Code : <%=promoCode%></h2>
<%
	}
%>
	</div>
	</div>
	<!-- Col 2 of Order Header -->
<%@ include file="../../../Includes/JSPs/Misc/iShipMethods.jsp"%>
	<div class="col-3">
	<div class="info-box">
<%
	String expectedDel = "";

	if("FOC".equals(catType_C))
	{
%>
		<h2 class="sub-title">Approver</h2>
<%
		if(!"".equals(approver))
		{
%>
			<strong>Approver:</strong>&nbsp;<%=approver%><br>
<%
		}
		if(!"".equals(defCat1))
		{
%>
			<h2 class="sub-title" style="border-top:none">Defect Categories</h2>
			<strong>Category 1:</strong>&nbsp;<%=defCat1%><br>
<%
		}
		if(!"".equals(defCat2))
		{
%>
			<strong>Category 2:</strong>&nbsp;<%=defCat2%><br>
<%
		}
		if(!"".equals(defCat3))
		{
%>
			<strong>Category 3:</strong>&nbsp;<%=defCat3%><br>
<%
		}
	}
	else
	{
%>
		<h2 class="sub-title">Shipping Method </h2>
<%
		if(dlvCheck.equals("checked=checked"))
		{
%>
		<p><strong>Deliver Together:</strong>&nbsp;<span id="shipComp_S">Yes</span><br>
<%
		}
		if(desiredDate!=null && !"null".equalsIgnoreCase(desiredDate) && !"".equals(desiredDate))
		{
			expectedDel = desiredDate;
%>
			<strong>Expected Delivery Date:</strong>&nbsp;<%=desiredDate%><br>
<%
		}
		String shipName_M = (String)shipMethodHM.get(carrierName);
		if(shipName_M==null || "null".equalsIgnoreCase(shipName_M) || "".equals(shipName_M)) shipName_M = "N/A";
%>
		<strong>Shipping Mode:</strong>&nbsp;<%=shipName_M%><br>
<%
		if(useMyCarrier!=null && "YES".equals(useMyCarrier))
		{
%>
		<strong>BILLING DETAILS WITH SHIPPER</strong><br>
		A/c with Carrier: <%=carrierId%><br>
		<%=billToName%><br>
		<%=billToStreet%><br>
		<%=billToCity+","%> <%=billToState%> <%=billToZipCode%> 
<%
		}
	}
	String quickEddMsg = "N";
	if("Z1".equals(itemOrdType_C) && desiredDate!=null && !"null".equalsIgnoreCase(desiredDate) && !"".equals(desiredDate))
	{
		expectedDel = "";
		quickEddMsg = "Y";
	}
	if(desiredDate==null || "null".equalsIgnoreCase(desiredDate) || "".equals(desiredDate))
	{
		//desiredDate = poDate;
		desiredDate = FormatDate.getStringFromDate(new Date(),"/",FormatDate.MMDDYYYY);
	}
%>
		</p>
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
<input type="hidden" name="quickEddMsg" value="<%=quickEddMsg%>">
<input type="hidden" name="expectedDel" value="<%=expectedDel%>">
<input type="hidden" name="poNumber" value="<%=poNumber%>">
<input type="hidden" name="poDate" value="<%=poDate%>">
<input type="hidden" name="desiredDate" value="<%=desiredDate%>">
<input type="hidden" name="selSoldTo" value="<%=soldToCode%>">
<input type="hidden" name="selShipTo" value="<%=shipToCode%>">
<input type="hidden" name="Currency" value="<%=Currency%>">
<input type="hidden" name="shipMethod" value="<%=shipMethod%>">
<input type="hidden" name="comments" value="<%=comments%>">
<input type="hidden" name="shipInst" value="<%=shipInst%>">
<% if (shipMethod.equals("STD")) { shipPartnRole = "";billToName = "";billToState = "";billToZipCode = "";billToAddress = "";billToCity = "";billToStreet = "";} %>
<input type="hidden" name="shipPartnRole" value="<%=shipPartnRole%>">
<input type="hidden" name="soldToCode" value="<%=soldToCode%>">
<input type="hidden" name="shipToCode" value="<%=shipToCode%>">
<input type="hidden" name="promoCode" value="<%=promoCode%>">
<input type="hidden" name="soldToIncoTerm" value="<%=soldToIncoTerm%>">

<input type="hidden" name="soldToName" value="<%=soldToName%>">
<input type="hidden" name="soldToStreet" value="<%=soldToStreet%>">
<input type="hidden" name="soldToCity" value="<%=soldToCity%>">
<input type="hidden" name="soldToState" value="<%=soldToState%>">
<input type="hidden" name="soldToCountry" value="<%=soldToCountry%>">
<input type="hidden" name="soldToZipCode" value="<%=soldToZipCode%>">
<input type="hidden" name="soldToPhNum" value="<%=soldToPhNum%>">
<input type="hidden" name="soldToEmail" value="<%=soldToEmail%>">

<input type="hidden" name="shipToName" value="<%=shipToName%>">
<input type="hidden" name="shipToStreet" value="<%=shipToStreet%>">
<input type="hidden" name="shipToCity" value="<%=shipToCity%>">
<input type="hidden" name="shipToState" value="<%=shipToState%>">
<input type="hidden" name="shipToCountry" value="<%=shipToCountry%>">
<input type="hidden" name="shipToZipCode" value="<%=shipToZipCode%>">
<input type="hidden" name="shipToPhNum" value="<%=shipToPhNum%>">
<input type="hidden" name="carrierName" value="<%=carrierName%>">
<input type="hidden" name="dvToAct" value="<%=dvToAct%>">
<input type="hidden" name="dvActBy" value="<%=dvActBy%>">
<input type="hidden" name="dropShipTo" value="<%=dropShipTo%>">
<input type="hidden" name="isResidential" value="<%=isResidential%>">

<input type="hidden" name="shipToZip" value="<%=shipToZipCode%>">
<input type="hidden" name="shipToPhone" value="<%=shipToPhNum%>">

<input type="hidden" name="carrierId" value="<%=carrierId%>">
<input type="hidden" name="incoTerms_O" value="<%=incoTerms_O%>">
<input type="hidden" name="custGrp5" value="<%=custGrp5%>">
<input type="hidden" name="custCondGrp3" value="<%=custCondGrp3%>">

<input type="hidden" name="billToName" value="<%=billToName%>">
<input type="hidden" name="billToStreet" value="<%=billToStreet%>">
<input type="hidden" name="billToCity" value="<%=billToCity%>">
<input type="hidden" name="billToState" value="<%=billToState%>">
<input type="hidden" name="billToZipCode" value="<%=billToZipCode%>">
<input type="hidden" name="billToCountry" value="US">
<input type="hidden" name="billToAddress" value="<%=billToAddress%>">

<input type="hidden" name="purposeOrder" value="<%=purposeOrder%>">
<input type="hidden" name="reasonCode" value="<%=reasonCode%>">
<input type="hidden" name="explanation" value="<%=explanation%>">
<input type="hidden" name="approver" value="<%=approver%>">
<input type="hidden" name="apprEmail" value="<%=apprEmail%>">
<input type="hidden" name="defCat1" value="<%=defCat1%>">
<input type="hidden" name="defCat2" value="<%=defCat2%>">
<input type="hidden" name="defCat3" value="<%=defCat3%>">

<input type="hidden" name="prodCode_D">
<input type="hidden" name="cartRows" value="<%=rCount%>">

<div id="ATTACHEDFILES" style="width: 100%; display:none">
	<iframe id="AttachFiles" src="../UploadFiles/ezAttachFile.jsp?actType=A" width="500" height="380" scrolling="no"></iframe>
</div>

<div class="col1-set">
<div class="info-box">
<Table width="100%" border=0>
<%
	if("FOC".equals(catType_C))
	{
%>
	<Tr>
<%
		if(!"".equals(explanation))
		{
%>
		<Td><strong>Explanation</strong></Td>
<%
		}
		if(!"".equals(shipInst))
		{
%>
		<Td><strong>Shipping Text</strong></Td>
<%
		}
%>
	</Tr>
	<Tr>
<%
		if(!"".equals(explanation))
		{
%>
		<Td>
			<textarea cols="80" rows="3" readonly><%=explanation%></textarea>
		</Td>
<%
		}
		if(!"".equals(shipInst))
		{
%>
		<Td>
			<textarea cols="80" rows="3" readonly><%=shipInst%></textarea>
		</Td>
<%
		}
%>
	</Tr>
<%
	}
	else
	{
%>
	<Tr>
<%
		if(!"".equals(comments))
		{
%>
		<Td><strong>General Info</strong></Td>
<%
		}
		if(!"".equals(shipInst))
		{
%>
		<Td><strong>Order Shipping Instructions</strong></Td>
<%
		}
%>
	</Tr>
	<Tr>
<%
		if(!"".equals(comments))
		{
%>
		<Td>
			<textarea cols="80" rows="3" readonly><%=comments%></textarea>
		</Td>
<%
		}
		if(!"".equals(shipInst))
		{
%>
		<Td>
			<textarea cols="80" rows="3" readonly><%=shipInst%></textarea>
		</Td>
<%
		}
%>
	</Tr>
<%
	}
%>
</Table><br>
</div>
</div>

<div class="col1-set">
<div class="info-box">
	<!--<h2 class="sub-title">Items Ordered </h2>-->
	<table class="data-table" id="socreate">
	<thead>
	<tr>
		<th width="4%" class="a-center"><a href="#" onClick="javascript:deleteItem()">
		<img style="valign:bottom" src="../../Images/Common/delete_icon.gif" height="20" width="20" border=0  style='cursor:hand' title="Delete Selected, Back to My Cart"></a><br>
		<input type="checkbox" name="CheckBoxAll"  onClick="checkAll(document.generalForm.CheckBox1)" value=""></th>
		<th width="8%" class="a-center">Brand</th>
<%
	int colSCnt = 10;
	if(focOrder)//!"CU".equals(userRole)
	{
		colSCnt = 10;
%>
		<th width="14%" class="a-center"> Split Info</th>
<%
	}
%>
		<th width="16%" class="a-center">Product Information</th>
		<th width="8%" class="a-center">PO Program</th>
		<th width="8%" class="a-center">List Price</th>
		<th width="8%" class="a-center">Multiplier</th>
		<th width="8%" class="a-center">Net Price</th>
<%
		if(focOrderByRep)//"CU".equals(userRole)
		{
%>		
			<th width="14%" class="a-center">Questions/<br>Responses</th>
<%
		}
%>		
		<th width="8%" class="a-center">Order Qty</th>
		<th width="8%" class="a-center">Confirm Qty<br>Exp Delv Date</th>
		<th width="7%" class="a-center">SubTotal</th>
		<th width="1%" id='custItemNo'></th>
		<th width="1%" id='custmat35'></th>
		<th width="1%" id='custmat35pts'></th>
	</tr>
	</thead>
	<tbody>
<%
	String splitKey_LG = "";
	java.math.BigDecimal totalItemsValue = new java.math.BigDecimal("0");
	java.math.BigDecimal freightTotal = new java.math.BigDecimal("0");
	java.math.BigDecimal freightHD00 = new java.math.BigDecimal("0");
	java.math.BigDecimal miscHandFee_B = new java.math.BigDecimal("0.00");
	java.math.BigDecimal miscHandFee_H = new java.math.BigDecimal("0.00");
	java.math.BigDecimal grandTotal =new java.math.BigDecimal("0");

	java.util.ArrayList catalogList = new java.util.ArrayList();
	java.util.ArrayList plantList = new java.util.ArrayList();

	if(rCount>0)
	{

	String imageMatId = "";
	for(int i=0;i<rCount;i++)
	{
		String catalog_S = (String)viewCart.getVendorCatalog(i);
		String matId_S = viewCart.getMatId(i);

		if("".equals(imageMatId))
			imageMatId = matId_S;
		else
			imageMatId = imageMatId+"','"+matId_S;

		if(!catalogList.contains(catalog_S))
			catalogList.add(catalog_S);
	}
	//out.println(catalogList);
	java.util.Collections.sort(catalogList);

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

	int lCnt = 0;
	boolean matRep = false;
	for(int ar=0;ar<catalogList.size();ar++)
	{
		String cat_Ar = (String)catalogList.get(ar);
		int ent = 0;

		for(int h=0;h<rCount;h++)
		{
			String itemVenCatalog 	= viewCart.getVendorCatalog(h);

			if(!cat_Ar.equals(itemVenCatalog))
				continue;

			String itemBrand	= viewCart.getBrand(h);
			String itemListPrice	= viewCart.getUnitPrice(h);
			String itemLineItem 	= viewCart.getMaterialNumber(h);
			String itemMfrNr   	= "N/A";
			String itemEanUPC  	= viewCart.getUPCNumber(h);
			String itemMmFlag  	= viewCart.getMatId(h).trim();
			String itemDiscCode 	= viewCart.getDiscCode(h);
			String itemMfrCode  	= viewCart.getMfrCode(h);
			String itemMfrPartNo	= viewCart.getMfrPartNo(h);
			String itemWeight 	= viewCart.getWeight(h);
			String itemOrgPrice 	= viewCart.getOrgPrice(h);
			String itemCnetProd	= viewCart.getVarPriceFlag(h);
			String itemOrdQty	= viewCart.getOrderQty(h);

			String itemDisp		= viewCart.getCat1(h);
			String itemVip		= viewCart.getCat2(h);
			String itemCat3		= viewCart.getCat3(h);
			String itemRefType	= viewCart.getType(h);
			String itemCustSku	= viewCart.getCustSku(h);
			String itemPoLine	= viewCart.getPoLine(h);
			String itemSalesOrg	= viewCart.getSalesOrg(h);
			String itemDivision	= viewCart.getDivision(h);
			String itemDistChnl	= viewCart.getDistChnl(h);
			String itemOrdType	= viewCart.getOrdType(h);
			String itemVolume	= viewCart.getVolume(h);
			String itemPoints	= viewCart.getPoints(h);
			String itemClass	= viewCart.getExt1(h);
			String itemComp	  	= viewCart.getKitComp(h);

			String stdMultiChng_I = "N";
			String netPriceChng_I = "N";

			String stdMultiChng_R = request.getParameter("stdMultiChng_"+itemLineItem);
			String netPriceChng_R = request.getParameter("netPriceChng_"+itemLineItem);

			if(stdMultiChng_R!=null && !"null".equalsIgnoreCase(stdMultiChng_R) && !"".equals(stdMultiChng_R))
				stdMultiChng_I = stdMultiChng_R;

			if(netPriceChng_R!=null && !"null".equalsIgnoreCase(netPriceChng_R) && !"".equals(netPriceChng_R))
				netPriceChng_I = netPriceChng_R;

			if("N/A".equals(itemPoints)) itemPoints = "0";

			if(("TPB".equals(soldToIncoTerm) || "PCO".equals(soldToIncoTerm)) && ("OR".equals(itemOrdType)))
				itemOrdType = "OR";//ZLTL

			if(!("DISP".equals(itemDisp) || "VIP".equals(itemDisp) || "FOC".equals(itemDisp) || "QS".equals(itemDisp) || "CS".equals(itemDisp)))
			{
				if(("25".equals(itemVip) || "26".equals(itemVip)) && !"".equals(ordCustGrp))
					itemOrdType = ordCustGrp;

				if(!"".equals(expOrdType))
					itemOrdType = expOrdType;

				if(expShipMethod && prodInStock && ("1002".equals(itemSalesOrg) || "1004".equals(itemSalesOrg)))
				{
					itemOrdType = "Z1";
				}

				if(!"".equals(ordOverVal))
					itemOrdType = ordOverVal;
			}

			if(!("56".equals(itemBrand) || "36".equals(itemBrand) || "5L".equals(itemBrand) || "55".equals(itemBrand)))
				itemBrand = itemDivision;

			String splitKey		= itemOrdType+"¥"+itemSalesOrg+"¥"+itemDivision+"¥"+itemDistChnl+"¥"+itemBrand;

			String dispChk 	= "Standard";
			String vipChk 	= "";
			String dispFlag = "";
			String vipFlag 	= "";
			String qsFlag   = "";

			String tPNo	= "";
			String prodNoUD = "";

			if(itemDisp!=null)
			{
				if("DISP".equals(itemDisp))
				{
					dispChk = "Display";
					dispFlag = "Y";
				}
				else if("VIP".equals(itemDisp))
				{
					dispChk = "Vip";
					vipFlag = "Y";
				}
				else if("QS".equals(itemDisp))
				{
					dispChk = "Quick Ship";
					qsFlag  = "Y";

					if("LUX".equals(itemClass) || "COM".equals(itemClass))
						qsFlag  = "F";	// for quick ship faucet items
				}
				else if("FOC".equals(itemDisp))
				{
					dispChk = "Free of Charge";
				}
			}

			String prodCode     = "";
			String custprodCode = "";
			String prodDesc     = "";
			String prodUom      = "";
			String prodQty      = "";
			String ItemCat      = "";
			String subTot       = "";
			String plant 	    = "";
			String matId        = "";
			String mfrPart      = "";
			String mfrNr        = "";
			String eanUPC       = "";
			String lineNo       = "";
			String lineItem     = "";
			String matChnge	    = "";

			for(int i=0;i<itemOutCnt;i++)
			{
				String splitKeyChk = itemoutTable.getFieldValueString(i,"SplitKey");

				matId        = itemoutTable.getFieldValueString(i,"MatEntrd");
				lineItem     = itemoutTable.getFieldValueString(i,"PoItmNo");

				if(!"000000".equals(itemoutTable.getFieldValueString(i,"HgLvItem")))
					continue;

				if(splitKey.equals(splitKeyChk) && itemMmFlag.equals(matId) && itemLineItem.equals(lineItem))
				{
					prodCode     = itemoutTable.getFieldValueString(i,"Material");
					custprodCode = itemoutTable.getFieldValueString(i,"CustMat");
					prodDesc     = itemoutTable.getFieldValueString(i,"ShortText");
					prodUom      = itemoutTable.getFieldValueString(i,"SalesUnit");
					prodQty      = itemoutTable.getFieldValueString(i,"ReqQty");
					ItemCat      = itemoutTable.getFieldValueString(i,"ItemCat");
					subTot       = itemoutTable.getFieldValueString(i,"NetValue1");
					plant 	     = itemoutTable.getFieldValueString(i,"Plant");
					mfrPart      = itemoutTable.getFieldValueString(i,"MfrPart");
					mfrNr        = itemoutTable.getFieldValueString(i,"MfrNr");
					eanUPC       = itemoutTable.getFieldValueString(i,"EanUPC");
					lineNo       = itemoutTable.getFieldValueString(i,"Number");
				}
			}
			lineItem = itemLineItem;

			if(!plantList.contains(plant))
				plantList.add(plant);

			if(itemMmFlag!=null && !"null".equals(itemMmFlag) && !"".equals(itemMmFlag.trim()))
			{
				if(!itemMmFlag.equals(prodCode))
					matChnge = prodCode;

				try
				{
					tPNo = Integer.parseInt(itemMmFlag)+"";
					prodNoUD = itemMmFlag;
				}
				catch(Exception e)
				{
					tPNo = itemMmFlag;
					prodNoUD = itemMmFlag;
				}
			}

			java.math.BigDecimal bUpricetemp = new java.math.BigDecimal("0");
			if("".equals(prodQty)) prodQty = "0";

			try
			{
				bUpricetemp = new java.math.BigDecimal(Double.parseDouble(subTot)/Double.parseDouble(prodQty));
			}
			catch(Exception e){}

			String tqty = prodQty;

			try
			{
				tqty = tqty.substring(0,tqty.indexOf('.'));
			}
			catch(Exception e){}

			java.math.BigDecimal bPrice = null;
			java.math.BigDecimal bQty = new java.math.BigDecimal(prodQty.toString());

			bPrice = bQty.multiply(bUpricetemp);
			String itemValue = bPrice.setScale(2,java.math.BigDecimal.ROUND_HALF_UP)+"";

			String condVal = "0";
			String listPrice = "0";
			String price_N = "0";
			String price_NJ = "0";
			String stdMultiplier = "0";
			String freight = "0";
			String miscHFee = "0";
			String tempLineNo = "";
			String condType	= "";

			String pricingCondTable = "<table class=\"data-table\" id=\"PRICETABLE-"+lineItem+"\"><thead><tr id=\"condtablehdrrow\"><th>Condition Type</th><th>Condition Desc.</th><th>Value</th></tr></thead><tbody>";

			for(int j=0;j<retCond.getRowCount();j++)
			{
				String condLineNo = retCond.getFieldValueString(j,"ItmNumber");
				condType = retCond.getFieldValueString(j,"CondType");
				String splitKeyChk = retCond.getFieldValueString(j,"SplitKey");

				String condDesc = "";

				if(taxCond.get(condType)!=null && !"null".equals(taxCond.get(condType)))
					condDesc = (String)taxCond.get(condType);

				if(lineNo.equals(condLineNo) && splitKey.equals(splitKeyChk))
				{
					try
					{
						tempLineNo = (Long.parseLong(lineNo))+splitKeyChk;
					}
					catch(Exception e)
					{
						tempLineNo = lineNo+splitKeyChk;
					}

					condVal = retCond.getFieldValueString(j,"Condvalue");

					try
					{
						condVal = new java.math.BigDecimal(condVal).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
					}
					catch(Exception e){}

					if(condType!=null && !"".equals(condType) && !"null".equals(condType))
						pricingCondTable = pricingCondTable+"<tr><th>&nbsp;"+condType+"</th><th >"+condDesc+"</th><th>&nbsp;"+condVal+"</th></tr>";

					if("ZUPR".equals(condType))
					{
						listPrice = retCond.getFieldValueString(j,"Condvalue");

						try
						{
							listPrice = new java.math.BigDecimal(listPrice).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
						}
						catch(Exception e){}
					}
					if("PN00".equals(condType))
					{
						price_N = retCond.getFieldValueString(j,"Condvalue");

						try
						{
							price_N = new java.math.BigDecimal(price_N).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
						}
						catch(Exception e){}
					}
					if(!"".equals(promoCode))
					{
						if("ZPMQ".equals(condType))
						{
							stdMultiplier = retCond.getFieldValueString(j,"Condvalue");

							try
							{
								stdMultiplier = ((new java.math.BigDecimal(stdMultiplier)).divide((new java.math.BigDecimal("100")),2,java.math.BigDecimal.ROUND_HALF_UP)).toString();
							}
							catch(Exception e){}
						}
					}
					else
					{
						if("ZUSM".equals(condType) || "ZMUL".equals(condType) || "Z706".equals(condType) || "ZPML".equals(condType))
						{
							stdMultiplier = retCond.getFieldValueString(j,"Condvalue");

							try
							{
								stdMultiplier = ((new java.math.BigDecimal(stdMultiplier)).divide((new java.math.BigDecimal("100")),2,java.math.BigDecimal.ROUND_HALF_UP)).toString();
							}
							catch(Exception e){}
						}
					}
					if("ZUFM".equals(condType) || "ZHTT".equals(condType) || "ZFHL".equals(condType) || "ZCRT".equals(condType) || "ZFRT".equals(condType) || "ZHD0".equals(condType) || "HD00".equals(condType))
					{
						if("HD00".equals(condType) || "ZCRT".equals(condType))
							freight = retCond.getFieldValueString(j,"CondValue");
						else
							freight = retCond.getFieldValueString(j,"Condvalue");

						try
						{
							freight = new java.math.BigDecimal(freight).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
							freightTotal = freightTotal.add(new java.math.BigDecimal(freight));
						}
						catch(Exception e){}

						if("HD00".equals(condType))
						{
							freight = retCond.getFieldValueString(j,"CondValue");
							try
							{
								freight = new java.math.BigDecimal(freight).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
								freightHD00 = freightHD00.add(new java.math.BigDecimal(freight));
							}
							catch(Exception e){}
						}
					}
					if("ZMSC".equals(condType))
					{
						miscHFee = retCond.getFieldValueString(j,"Condvalue");

						try
						{
							miscHFee = new java.math.BigDecimal(miscHFee).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
							miscHandFee_B = miscHandFee_B.add(new java.math.BigDecimal(miscHFee));
						}
						catch(Exception e){}
					}
					if("ZMSC".equals(condType) && "D".equals(retCond.getFieldValueString(j,"Condorigin")))
					{
						splitKey_LG = splitKeyChk;
						try
						{
							miscHandFee_H = new java.math.BigDecimal(retCond.getFieldValueString(j,"Condvalue")).setScale(2,java.math.BigDecimal.ROUND_HALF_UP);
						}
						catch(Exception e){}
					}
					if("ZJOB".equals(condType) || "PN00".equals(condType))
					{
						if("PN00".equals(condType))
						{
							itemValue = (new java.math.BigDecimal(price_N).setScale(2,java.math.BigDecimal.ROUND_HALF_UP)).toString();
						}
						else
						{
							price_NJ = retCond.getFieldValueString(j,"Condvalue");
							itemValue = (new java.math.BigDecimal(price_NJ).setScale(2,java.math.BigDecimal.ROUND_HALF_UP)).toString();
						}

						java.math.BigDecimal itemQty1 = (new java.math.BigDecimal(prodQty).setScale(2,java.math.BigDecimal.ROUND_HALF_UP));
						java.math.BigDecimal itemValueBD = new java.math.BigDecimal(itemValue);
						itemValueBD = itemValueBD.multiply(itemQty1);			
						itemValue = itemValueBD.setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
					}
				}
			}

			pricingCondTable = pricingCondTable+"</tbody></table>"; 

			String confQty = "";
			String confDate = "";

			for(int ds=0;ds<retSchedCnt;ds++)
			{
				String splitKeyChk 	= retSched.getFieldValueString(ds,"SplitKey");
				String schedSONum 	= retSched.getFieldValueString(ds,"DocNumber");
				String schedSOLine	= retSched.getFieldValueString(ds,"ItmNumber");
				String schedSOSchLine 	= retSched.getFieldValueString(ds,"SchedLine");
				String schedConfQty 	= retSched.getFieldValueString(ds,"ConfirQty");

				Date cdtObj = (Date)retSched.getFieldValue(ds,"ReqDate");
				DateFormat formatter2 = new SimpleDateFormat("MM/dd/yyyy");
				String cdtStr = formatter2.format(cdtObj);
				String tStr = schedSONum+schedSOLine;

				if(desShipDate.after(cdtObj))
				{
					confDate = "YES";
				}

				if(lineNo.equals(schedSOLine) && splitKey.equals(splitKeyChk))
				{
					if(!schedConfQty.equals("0.000") && !schedConfQty.equals("0"))
					{
						if("".equals(confQty))
							confQty = eliminateDecimals(schedConfQty)+"<br>"+cdtStr;
						else
							confQty = confQty+"<br>"+eliminateDecimals(schedConfQty)+"<br>"+cdtStr;
					}
				}
			}

			/**************Kit Codes*************/

			String listPrice_B = "0";
			String priceB_N = "0";
			String priceB_NJ = "0";
			String stdMultiplier_B = "0";
			String freight_B = "0";
			String miscHFee_B = "0";
			String tempLineNo_B = "";
			String condType_B = "";

			String hgLvItem     = "";
			String childComponents = "";

			int bCnt = 0;

			String[] prodDesc_Bom 	 = new String[itemOutCnt];
			String[] matId_Bom	 = new String[itemOutCnt];
			String[] eanUPC_Bom	 = new String[itemOutCnt];
			String[] lineNo_Bom	 = new String[itemOutCnt];
			String[] prodQty_Bom	 = new String[itemOutCnt];
			String[] subTot_Bom	 = new String[itemOutCnt];

			for(int i=0;i<itemOutCnt;i++)
			{
				String splitKeyChk = itemoutTable.getFieldValueString(i,"SplitKey");
				hgLvItem     = itemoutTable.getFieldValueString(i,"HgLvItem");

				if(splitKey.equals(splitKeyChk) && lineNo.equals(hgLvItem))
				{
					prodDesc_Bom[bCnt] = itemoutTable.getFieldValueString(i,"ShortText");
					matId_Bom[bCnt]    = itemoutTable.getFieldValueString(i,"Material");
					eanUPC_Bom[bCnt]   = itemoutTable.getFieldValueString(i,"EanUPC");
					lineNo_Bom[bCnt]   = itemoutTable.getFieldValueString(i,"Number");
					prodQty_Bom[bCnt]  = itemoutTable.getFieldValueString(i,"ReqQty");
					subTot_Bom[bCnt]   = itemoutTable.getFieldValueString(i,"NetValue1");

					prodDesc_Bom[bCnt]=prodDesc_Bom[bCnt].replaceAll("\'","`");
					prodDesc_Bom[bCnt]=prodDesc_Bom[bCnt].replaceAll("\"","``");

					childComponents+=""+matId_Bom[bCnt]+" "+prodDesc_Bom[bCnt]+"&nbsp;<br/>";

					String lineNo_B 	= lineNo_Bom[bCnt];
					String prodQty_B 	= prodQty_Bom[bCnt];
					String subTot_B 	= subTot_Bom[bCnt];

					try
					{
						prodQty_B = prodQty_B.substring(0,prodQty_B.indexOf('.'));
					}
					catch(Exception e){}

					String itemValue_B = subTot_B;

					for(int j=0;j<retCond.getRowCount();j++)
					{
						String condLineNo = retCond.getFieldValueString(j,"ItmNumber");
						condType_B = retCond.getFieldValueString(j,"CondType");
						String splitKeyChk_B = retCond.getFieldValueString(j,"SplitKey");

						if(lineNo_B.equals(condLineNo) && splitKey.equals(splitKeyChk_B))
						{
							try
							{
								tempLineNo_B = (Long.parseLong(lineNo_B))+splitKeyChk_B;
							}
							catch(Exception e)
							{
								tempLineNo_B = lineNo_B+splitKeyChk_B;
							}

							if("ZUPR".equals(condType_B))
							{
								try
								{
									listPrice_B = ((new java.math.BigDecimal(listPrice_B)).add(new java.math.BigDecimal(retCond.getFieldValueString(j,"Condvalue")))).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
								}
								catch(Exception e){}
							}
							if("PN00".equals(condType_B))
							{
								try
								{
									priceB_N = ((new java.math.BigDecimal(priceB_N)).add((new java.math.BigDecimal(retCond.getFieldValueString(j,"Condvalue"))))).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
								}
								catch(Exception e){}
							}
							if(!"".equals(promoCode))
							{
								if("ZPMQ".equals(condType))
								{
									stdMultiplier_B = retCond.getFieldValueString(j,"Condvalue");

									try
									{
										stdMultiplier_B = ((new java.math.BigDecimal(stdMultiplier_B)).divide((new java.math.BigDecimal("100")),2,java.math.BigDecimal.ROUND_HALF_UP)).toString();
									}
									catch(Exception e){}
								}
							}
							else
							{
								if("ZUSM".equals(condType_B) || "ZMUL".equals(condType_B) || "Z706".equals(condType_B) || "ZPML".equals(condType_B))
								{
									stdMultiplier_B = retCond.getFieldValueString(j,"Condvalue");

									try
									{
										stdMultiplier_B = ((new java.math.BigDecimal(stdMultiplier_B)).divide((new java.math.BigDecimal("100")),2,java.math.BigDecimal.ROUND_HALF_UP)).toString();
									}
									catch(Exception e){}
								}
							}
							if("ZUFM".equals(condType_B) || "ZHTT".equals(condType_B) || "ZFHL".equals(condType_B) || "ZCRT".equals(condType_B) || "ZFRT".equals(condType_B) || "ZHD0".equals(condType_B) || "HD00".equals(condType_B))
							{
								if("HD00".equals(condType_B) || "ZCRT".equals(condType_B))
									freight_B = retCond.getFieldValueString(j,"CondValue");
								else
									freight_B = retCond.getFieldValueString(j,"Condvalue");

								try
								{
									freight_B = new java.math.BigDecimal(freight_B).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
									freightTotal = freightTotal.add(new java.math.BigDecimal(freight_B));
								}
								catch(Exception e){}

								if("HD00".equals(condType_B))
								{
									freight_B = retCond.getFieldValueString(j,"CondValue");
									try
									{
										freight_B = new java.math.BigDecimal(freight_B).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
										freightHD00 = freightHD00.add(new java.math.BigDecimal(freight_B));
									}
									catch(Exception e){}
								}
							}
							if("ZMSC".equals(condType))
							{
								miscHFee_B = retCond.getFieldValueString(j,"Condvalue");

								try
								{
									miscHFee_B = new java.math.BigDecimal(miscHFee_B).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
									miscHandFee_B = miscHandFee_B.add(new java.math.BigDecimal(miscHFee_B));
								}
								catch(Exception e){}
							}
							if("ZJOB".equals(condType_B) || "PN00".equals(condType_B))
							{
								if("PN00".equals(condType_B))
								{
									itemValue_B = (new java.math.BigDecimal(retCond.getFieldValueString(j,"Condvalue")).setScale(2,java.math.BigDecimal.ROUND_HALF_UP)).toString();
								}
								else
								{
									priceB_NJ = retCond.getFieldValueString(j,"Condvalue");
									price_NJ = ((new java.math.BigDecimal(price_NJ)).add((new java.math.BigDecimal(priceB_NJ)))).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
									itemValue_B = (new java.math.BigDecimal(priceB_NJ).setScale(2,java.math.BigDecimal.ROUND_HALF_UP)).toString();
								}

								java.math.BigDecimal itemQty1 = (new java.math.BigDecimal(prodQty).setScale(2,java.math.BigDecimal.ROUND_HALF_UP));
								itemValue = ((new java.math.BigDecimal(itemValue)).add(new java.math.BigDecimal(itemValue_B).multiply(itemQty1))).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();

								java.math.BigDecimal itemValueBD = new java.math.BigDecimal(itemValue_B);
								itemValueBD = itemValueBD.multiply(itemQty1);			
							}
						}
					}

					bCnt++;
				}
			}

			if(!"0".equals(listPrice_B)) listPrice = listPrice_B;
			if(!"0".equals(priceB_N)) price_N = priceB_N;

			/**************Kit Codes*************/

			String orderType = "OR";

			String pntspcs = "Pieces";
			if(cat_Ar.equals(itemVenCatalog))// && ent==0)
			{
				ent++;
				pntspcs = "Pieces";

				if("Enamel Steel".equals(itemVenCatalog) || 
				   "Acrylux".equals(itemVenCatalog) 	    || 
				   "Chinaware".equals(itemVenCatalog)    || 
				   "Americast & Acrylics (Excludes Acrylux)".equals(itemVenCatalog))
				   	pntspcs="points";

				if("Repair Parts".equals(itemVenCatalog))
					pntspcs="$";
			}
			String imgInfo = (String)imageMatHash.get(itemMmFlag);
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
			<tr style="background-color:white" id="linedatarow">
			<td><div style="display:none" id="solineinfo"><%=itemLineItem%></div>
			<br>
			<p align="center"><%=brand_Img%></p>
			</td>
<%
			if(focOrder)//!"CU".equals(userRole)
			{
				if("FOC".equals(catType_C) || dispOrderByInt)
				{
%>
					<td>
					<ul>
						<li><strong>DocType</strong> <input type="hidden" name="docType_<%=lineItem%>" value="<%=itemOrdType%>"><%=itemOrdType%>
						<input type="hidden" name="docTypeHid_<%=lineItem%>" value="<%=itemOrdType%>"></li>
					</ul>
					<ul>
						<li><strong>SalesOrg</strong> <input type="hidden" name="salesOrg_<%=lineItem%>" value="<%=itemSalesOrg%>"><%=itemSalesOrg%>
						<input type="hidden" name="salesOrgHid_<%=lineItem%>" value="<%=itemSalesOrg%>"></li>
					</ul>
					<ul>
						<li><strong>Division</strong> <input type="hidden" name="division_<%=lineItem%>" value="<%=itemDivision%>"><%=itemDivision%>
						<input type="hidden" name="divisionHid_<%=lineItem%>" value="<%=itemDivision%>"></li>
					</ul>
					<ul>
						<li><strong>DistChnl</strong> <input type="hidden" name="distChnl_<%=lineItem%>" value="<%=itemDistChnl%>"><%=itemDistChnl%>
						<input type="hidden" name="distChnlHid_<%=lineItem%>" value="<%=itemDistChnl%>"></li>
					</ul>
					</td>
<%
				}
				else
				{
%>
					<td>
					<ul>
						<li class="a-left"><strong>DocType</strong>&nbsp;<input style="text-transform: uppercase" type="text" name="docType_<%=lineItem%>" size="1" maxlength="4" value="<%=itemOrdType%>" onBlur="showRePrice()" onKeyPress="showRePrice()" onKeyUp="showRePrice()">
						<input type="hidden" name="docTypeHid_<%=lineItem%>" value="<%=itemOrdType%>"></li>
					</ul>
					<ul>
						<li class="a-left"><strong>SalesOrg</strong><input style="text-transform: uppercase" type="text" name="salesOrg_<%=lineItem%>" size="1" maxlength="4" value="<%=itemSalesOrg%>" onBlur="showRePrice()" onKeyPress="showRePrice()" onKeyUp="showRePrice()">
						<input type="hidden" name="salesOrgHid_<%=lineItem%>" value="<%=itemSalesOrg%>"></li>
					</ul>
					<ul>
						<li class="a-left"><strong>Division</strong>&nbsp;&nbsp;<input style="text-transform: uppercase" type="text" name="division_<%=lineItem%>" size="1" maxlength="4" value="<%=itemDivision%>" onBlur="showRePrice()" onKeyPress="showRePrice()" onKeyUp="showRePrice()">
						<input type="hidden" name="divisionHid_<%=lineItem%>" value="<%=itemDivision%>"></li>
					</ul>
					<ul>
						<li class="a-left"><strong>DistChnl</strong>&nbsp;&nbsp;<input type="hidden" name="distChnl_<%=lineItem%>" value="<%=itemDistChnl%>"><%=itemDistChnl%>
						<input type="hidden" name="distChnlHid_<%=lineItem%>" value="<%=itemDistChnl%>"></li>
					</ul>
					</td>
<%
				}
			}
%>
				<td><%=prodDesc%>
<%
				prodDesc=prodDesc.replaceAll("\'","`");
				prodDesc=prodDesc.replaceAll("\"","``");

				if(!"".equals(matChnge))
				{
%>
					<br><strong><font color=red>Alternate Product:</font></strong><br><a href="javascript:getProductDetails('<%=matChnge%>')" title="<%=matChnge%>"><%=matChnge%></a>
<%
					if(!matRep)
					{
						matRep = true;
%>
						<script>
						new HelloBar( '<span>Products marked in RED below have been replaced with an alternate. Please review before proceeding.</span>', {
								showWait: 1000,
								positioning: 'sticky',
								fonts: 'Arial, Helvetica, sans-serif',
								forgetful: true,
								helloBarLogo : false,
								barColor : '#eb593c',
								height : 30
						}, 1.0 );
						</script>
<%
					}
				}
%>
				<br><strong>Product:</strong><br><a href="javascript:getProductDetails('<%=tPNo%>')" title="<%=tPNo%>"><%=tPNo%></a>
				<br><strong>UPC:</strong><br><%=eanUPC%>
<%
				if(itemCustSku!=null && !"N/A".equals(itemCustSku))
				{
%>
					<br><strong>My SKU:</strong>&nbsp;<%=itemCustSku%>
<%
				}
				if(itemPoLine!=null && !"N/A".equals(itemPoLine))
				{
%>
					<br><strong>My PO Line:</strong>&nbsp;<%=itemPoLine%>
<%
				}
%>
				</td>
				<td class="a-center">
<%
				boolean netPrice_Q = true;
				boolean chngMulti = false;
				if(!(itemMfrPartNo.equals("N/A")) && !(itemMfrPartNo.equals("")))
				{
					price_N = itemListPrice;
					stdMultiplier = "N/A";
					itemValue = ((new java.math.BigDecimal(itemListPrice)).multiply(new java.math.BigDecimal(tqty))).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
%>
					<strong>Quote#&nbsp;</strong><br><%=itemMfrPartNo%>/<br><%=itemWeight%>
<%
				}
				else
				{
%>				
					<%=dispChk%>
					  				
<%				}
				if("0".equals(stdMultiplier) || "N/A".equals(stdMultiplier))
				{
					netPrice_Q = false;
					chngMulti = true;
					stdMultiplier = "N/A";
				}
%>
				</td>
				<td class="price">$<%=listPrice%></td>
				<td class="price">
<%
				if(focOrder)//!"CU".equals(userRole)
				{
					if(chngMulti)
					{
%>
					<input type="hidden" name="stdMulti_<%=lineItem%>" id="stdMulti_<%=lineItem%>" value="<%=stdMultiplier%>"><%=stdMultiplier%>
<%
					}
					else
					{
						if("FOC".equals(catType_C))
						{
%>
						<input type="hidden" name="stdMulti_<%=lineItem%>" id="stdMulti_<%=lineItem%>" value="<%=stdMultiplier%>"><%=stdMultiplier%>
<%
						}
						else
						{
%>
						<!--<input style="text-transform: uppercase" type="text" name="stdMulti_<%=lineItem%>" id="stdMulti_<%=lineItem%>" size="1" maxlength="6" value="<%=stdMultiplier%>" onBlur="showRePrice()" onKeyPress="showRePrice()" onKeyUp="showRePrice()">-->
							<select name="stdMulti_<%=lineItem%>" id="stdMulti_<%=lineItem%>" onChange="changePrices(this,'<%=lineItem%>')">
								<option value="0.10">0.10</option>
								<option value="0.23">0.23</option>
								<option value="0.25">0.25</option>
								<option value="0.35">0.35</option>
							</select>
<%
						}
					}
%>
					<input type="hidden" name="stdMultiHid_<%=lineItem%>" id="stdMultiHid_<%=lineItem%>" value="<%=stdMultiplier%>">
					<input type="hidden" name="stdMultiChng_<%=lineItem%>" id="stdMultiChng_<%=lineItem%>" value="<%=stdMultiChng_I%>">
<%
				}
				else
				{
					String tStdMulti = stdMultiplier;
					if("Y".equals(dispFlag) || "Y".equals(vipFlag)) tStdMulti = "TBD";
%>
				<input type="hidden" name="stdMulti_<%=lineItem%>" id="stdMulti_<%=lineItem%>" value="<%=stdMultiplier%>"><%=checkAuth(tStdMulti,"VIEW_PRICES",userAuth_R)%>
<%
				}
%>
				</td><td class="price">$
<%
				if(focOrder)//!"CU".equals(userRole)
				{
					if(netPrice_Q)
					{
%>
					<input type="hidden" name="netPrice_<%=lineItem%>" id="netPrice_<%=lineItem%>" value="<%=price_N%>"><%=price_N%>
<%
					}
					else
					{
						if("FOC".equals(catType_C) || dispOrderByInt)
						{
%>
						<input type="hidden" name="netPrice_<%=lineItem%>" id="netPrice_<%=lineItem%>" value="<%=price_N%>"><%=price_N%>
<%
						}
						else
						{
%>
						<input type="text" size="4" name="netPrice_<%=lineItem%>" id="netPrice_<%=lineItem%>" value="<%=price_N%>" onBlur="showRePrice()" onKeyPress="showRePrice()" onKeyUp="showRePrice()">
<%
						}
					}
%>
					<input type="hidden" name="netPriceHid_<%=lineItem%>" id="netPriceHid_<%=lineItem%>" value="<%=price_N%>">
					<input type="hidden" name="netPriceChng_<%=lineItem%>" id="netPriceChng_<%=lineItem%>" value="<%=netPriceChng_I%>">
					<div class="PRICE<%=tempLineNo%>"><a class="fancybox" href="#PRICE<%=tempLineNo%>"><span>Pricing Details</span></a></div>
						<div id="PRICE<%=tempLineNo%>" style="display:none">
						<h2>Pricing Details</h2>
						<br><%=pricingCondTable%>
					</div>
<%
				}
				else
				{
					String tNetPrice = price_N;
					if("Y".equals(dispFlag) || "Y".equals(vipFlag)) tNetPrice = "TBD";
%>
				<input type="hidden" name="netPrice_<%=lineItem%>" id="netPrice_<%=lineItem%>" value="<%=price_N%>"><%=checkAuth(tNetPrice,"VIEW_PRICES",userAuth_R)%>
<%
				}
%>
					<input type="hidden" name="lineValue" value="<%=itemValue%>">
					<input type="hidden" name="listPrice" value="<%=listPrice%>">
					<input type="hidden" name="stdMultiplier" value="<%=stdMultiplier%>">
					<input type="hidden" name="product" value="<%=prodNoUD%>">
					<input type="hidden" name="prodDesc" value="<%=prodDesc%>">
					<input type="hidden" name="custprodCode" value="<%=prodNoUD%>">
					<input type="hidden" name="orderType" value="<%=orderType%>">
					<input type="hidden" name="pack" value="<%=prodUom%>">
					<input type="hidden" name="ItemCat" value="<%=ItemCat%>">
					<input type="hidden" name="commitedQty" value="<%=tqty%>">
					<input type="hidden" name="UomQty" value="0">
					<input type="hidden" name="itemListPrice" value="<%=price_N%>">
					<input type="hidden" name="itemVenCatalog" value="<%=itemVenCatalog%>">
					<input type="hidden" name="itemMfrPart" value="<%=prodNoUD%>">
					<input type="hidden" name="itemMfrNr"   value="<%=itemMfrNr%>">
					<input type="hidden" name="itemEanUPC" value="<%=itemEanUPC%>">
					<input type="hidden" name="itemMatId" value="<%=matId%>">
					<input type="hidden" name="itemLineItem" value="<%=itemLineItem%>">
					<input type="hidden" name="itemMmFlag" value="<%=itemMmFlag%>">
					<input type="hidden" name="itemDiscCode" value="<%=itemDiscCode%>">
					<input type="hidden" name="itemMfrCode" value="<%=itemMfrCode%>">
					<input type="hidden" name="itemWeight" value="<%=itemWeight%>">
					<input type="hidden" name="quoteNum" value="<%=itemMfrPartNo%>">
					<input type="hidden" name="lineNum" value="<%=itemWeight%>">
					<input type="hidden" name="itemPromoCode" value="">
					<input type="hidden" name="itemCnetProd" value="<%=itemCnetProd%>">
					<input type="hidden" name="vendCatalog" value="<%=itemVenCatalog%>">
					<input type="hidden" name="delSchQty" value="<%=tqty%>">
					<input type="hidden" name="delSchDate" value="<%=desiredDate%>">
					<input type="hidden" name="splitKey" value="<%=splitKey%>">
					<input type="hidden" name="dispFlag" value="<%=dispFlag%>">
					<input type="hidden" name="vipFlag" value="<%=vipFlag%>">
					<input type="hidden" name="qsFlag" value="<%=qsFlag%>">
					<input type="hidden" name="itemDisp" value="<%=itemDisp%>">
					<input type="hidden" name="itemVip" value="<%=itemVip%>">
					<input type="hidden" name="itemCat3" value="<%=itemCat3%>">
					<input type="hidden" name="itemRefType" value="<%=itemRefType%>">
					<input type="hidden" name="itemCustSku" value="<%=itemCustSku%>"> 
					<input type="hidden" name="itemPoLine" value="<%=itemPoLine%>"> 
					<input type="hidden" name="itemVolume" value="<%=itemVolume%>"> 
					<input type="hidden" name="itemPoints" value="<%=itemPoints%>"> 
					<input type="hidden" name="tempLineNo" value="<%=tempLineNo%>">
					<input type="hidden" name="itemPlant"  value="<%=itemBrand%>">
					<input type="hidden" name="itemComp"  value="<%=itemComp%>">
					<input type="hidden" name="itemClass"  value="<%=itemClass%>">
					<input type="hidden" name="splitItemNo"  value="<%=lineNo%>">
					<input type="hidden" name="kitComp"  value="<%=bCnt%>">

					<input type="hidden" name="itemFlag_<%=lineItem%>" value="<%=itemDisp%>">
					<input type="hidden" name="childComponents<%=itemLineItem%>" id="childComponents<%=itemLineItem%>" value="<%=childComponents%>">

					<!----   Hidden Values to Set for Q&A Start----->
					<input type="hidden" name="qType<%=lineItem%>"> 
					<input type="hidden" name="QComments<%=lineItem%>">
					<input type="hidden" name="lineItem" value="<%=lineItem%>">
					<!----   Hidden Values to Set for Q&A End----->

					<!----   Hidden Values to Set for Delete Item from Cart Start----->
					<input type="hidden" name="matId_<%=lineItem%>" value="<%=itemMmFlag%>">
					<input type="hidden" name="venCat_<%=lineItem%>" value="<%=itemVenCatalog%>">
					<input type="hidden" name="reqQty_<%=lineItem%>" value="<%=itemOrdQty%>">
					<input type="hidden" name="lineItem_<%=lineItem%>" value="<%=itemLineItem%>">
					<!----   Hidden Values to Set for Delete Item from Cart End----->
				</td>
<%			
			String questionHTML = "";
			String QKey ="";
			String AKey ="";	
			if(noQHash!=null && noQHash.size()>0 && noQHash.containsKey(lineItem))
			{
				String tempQues	= (String)noQHash.get(lineItem);
				
				QKey = (String)quesHash.get(tempQues);
				AKey = (String)ansHash.get(tempQues);
					//out.println("QKey::::::::"+QKey);
				QKey = ((QKey == null) || (("").equals(QKey)) || ("null".equalsIgnoreCase(QKey)))?"":QKey;
				AKey = ((AKey == null) || (("").equals(AKey)) || ("null".equalsIgnoreCase(QKey)))?"":AKey;
			}	
				
		
			if(focOrderByRep)//"CU".equals(userRole)
			{
%>			
				<td>
				<div class="VIEW<%=lineItem%>">
				<a class="fancybox" href="#VIEW<%=lineItem%>" >
<%
				if(!"null".equals(QKey) && !"".equals(QKey))
				{
%>				
					<span id="ASK<%=lineItem%>" style="display:none"><input type=button value=Ask> </span>
					<span id="HIDE<%=lineItem%>"> <input type=button value=View> </span>
<%
				}else{
%>				
					<span id="ASK<%=lineItem%>" ><input type=button value=Ask> </span>
					<span id="HIDE<%=lineItem%>" style="display:none"> <input type=button value=View> </span>
<%
				}
%>				
				</a>
				</div>
				<div id="VIEW<%=lineItem%>" style="display:none">
				<h2>Question/Comment</h2>
				<p><ul style="list-style-type:square;list-style-position:inside;">
					<li>Ask Customer Care a question(s).</li>
					<li>Customer Care will review and respond back.</li>
					<li>Once you receive a response, you can submit the PO to ASB.</li>
				</ul></p>
				<br>
				<ul class="form-list">
				<li><label for="noteType" class="required">Question Type<em>*</em> </label>
					<div class="input-box">
					<select name="query" id="query<%=lineItem%>">
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
						<textarea name="quesComments" Style="border: 1px solid #000000;" id="qComments<%=lineItem%>"  cols="80" rows="5"><%=QKey.split("##")[0]%></textarea>
					</div>
				</li>
				<li>
					<input type="button" label="Submit" text="Save and Back" value="Save" onClick="SaveValues('<%=lineItem%>')"></input>
				</li>
				</ul>
				</td>
<%
				
			}
%>			
			<td class="price"><%=tqty%></td>
			<td class="price">
<%
			if("YES".equals(confDate))
			{
%>
				<strong><font color="red"><%=confQty%></font></strong>
<%
			}
			else
			{
%>
				<%=confQty%>
<%
			}

			totalItemsValue	= totalItemsValue.add(new java.math.BigDecimal(itemValue));
			String tItemVal = itemValue;

			if("CU".equals(userRole) && ("Y".equals(dispFlag) || "Y".equals(vipFlag))) tItemVal = "TBD";
%>
			</td>
			<td class="price">$<%=checkAuth(tItemVal,"VIEW_PRICES",userAuth_R)%></td>
			<td width="1%"><%=itemLineItem%></td>
			<td width="1%"><%=itemVenCatalog%></td>
<%
			if(pntspcs.equals("$"))
			{
%>
				<td id="pointsgroup"><%=itemVenCatalog%>:<%=pntspcs%><%=(String)totPointsCatHT.get(itemVenCatalog)%></td>
<%
			}
			else
			{
%>
				<td id="pointsgroup"><%=itemVenCatalog%>:<%=(String)totPointsCatHT.get(itemVenCatalog)%>&nbsp;<%=pntspcs%></td>
<%
			}
%>
			</tr>
<%
			lCnt++;
		}
	}
	}

	String tTotItemVal = totalItemsValue.toString();
	String tFrVal = freightTotal.toString();

	if("CU".equals(userRole) && (dispFlag_S || vipFlag_S))
	{
		tTotItemVal = "TBD";
		tFrVal = "TBD";
	}
%>
	</tbody>
	<tfoot>
	<tr>
		<td colspan="<%=colSCnt%>" align="right"><h3>SubTotal</h3></td>
		<td class="price">$<%=checkAuth(tTotItemVal,"VIEW_PRICES",userAuth_R)%></td>
	</tr>
	<tr>
		<td colspan="<%=colSCnt%>" align="right"><h3>Shipping and Handling (Additional Shipping Charges may be added at the time of Shipment)</h3></td>
		<td class="price"><%=checkAuth(tFrVal,"VIEW_PRICES",userAuth_R)%></td>
	</tr>
	<tr>
		<td colspan="<%=colSCnt%>" align="right"><h3>Lift Gate Charges</h3></td>
		<td class="price"><%=checkAuth(miscHandFee_H.toString(),"VIEW_PRICES",userAuth_R)%>
		<input type="hidden" name="miscHandFee" value="<%=miscHandFee_H.toString()%>">
		<input type="hidden" name="miscSplitKey" value="<%=splitKey_LG%>"></td>
	</tr>
<%
	if("COMMENTED".equals(userRole))// Commented as per the Sam's request
	{
%>
	<tr>
		<td colspan="<%=colSCnt%>" align="right"><h3>Misc. Handling Fee &nbsp;&nbsp;&nbsp;&nbsp;
<%
		int splitCnt = uProdOrderType.size();
		if(splitCnt>1)
		{
%>
			<select name="miscSplitKey" id="miscSplitKey">
<%
			for(int us=0;us<uProdOrderType.size();us++)
			{
				String splitInfo = (String)uProdOrderType.get(us);
				String splitInfoDesc = splitInfo.replaceAll("¥","/");
				String div56 = splitInfoDesc.substring((splitInfoDesc.lastIndexOf("/")+1),splitInfoDesc.length());

				if("56".equals(div56) || "36".equals(div56) || "5L".equals(div56) || "55".equals(div56))
					div56 = "Division: "+div56;
				else
					div56 = "";

				splitInfoDesc = splitInfoDesc.substring(0,splitInfoDesc.lastIndexOf("/"));
%>
				<option value="<%=splitInfo%>"><%=splitInfoDesc%> <%=div56%></option>
<%
			}
%>
			</select>&nbsp;&nbsp;(OrdType / SalesOrg / Division / DistChnl)
<%
		}
		else
		{
%>
		<input type="hidden" name="miscSplitKey" value="<%=(String)uProdOrderType.get(0)%>">
<%
		}
%>
		</h3>
		</td>
		<td class="price" nowrap>$<input type="text" name="miscHandFee" value="0.00" size="6" style="width:80%;text-align:right" onBlur="showRePrice()" onKeyPress="showRePrice()" onKeyUp="showRePrice()">
		<input type="hidden" name="miscHandFeeHid" value="0.00">
		<input type="hidden" name="miscHandFeeChng" value="N"></td>
	</tr>
<%
	}

	grandTotal = grandTotal.add(totalItemsValue);
	grandTotal = grandTotal.add(freightTotal);
	grandTotal = grandTotal.add(miscHandFee_H);

	String tGTotVal = grandTotal.toString();

	if("CU".equals(userRole) && (dispFlag_S || vipFlag_S)) tGTotVal = "TBD";
%>
	<tr>
		<td colspan="<%=colSCnt%>" align="right"><h3>Grand Total</h3></td>
		<td class="price">$<%=checkAuth(tGTotVal,"VIEW_PRICES",userAuth_R)%></td>
	</tr>
	<!--<tr>
		<td colspan="<%=(colSCnt+1)%>" class="a-right last"><h3>Total No. of Lines in Order : <%=rCount%></h3></td>
	</tr>-->
	</tfoot>
	</table>
<%
	if("X".equals(dlvChk) && plantList.size()>1)
	{
		complDlv = "off";
%>
<div id="dialog-confirm" title="Delivery Together Alert">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Order cannot be delivered together</p>
</div>
<script type="text/javascript">
	$(function() {

  	$( "#dialog-confirm" ).dialog({
  		resizable: false,
  		height:200,
  		modal: true,
  		buttons: {
  			"Ok": function() {
  				$(this).dialog("close");
  				document.getElementById("shipComp_S").innerHTML="No";
  			}
  		}
	  	});
	});
</script>
<%
	}
	session.putValue("SHIPCOMP_PREP",complDlv);
%>
<input type="hidden" name="flagList" value="<%=flagList.size()%>">
<input type="hidden" name="freightTotal" value="<%=freightHD00%>">
<input type="hidden" name="shipComplete" value="<%=complDlv%>">
<input type="hidden" name="complDlv" value="<%=complDlv%>">
	<br>
	<p>
	<div id="divAction1" style="display:block">
		<button type="button" title="Back" class="button" onclick="javascript:goBack()">
		<span class="left-link">Back</span></button>
		<a class="fancybox" href="#ATTACHEDFILES">
		<button type="button" class="button btn-update"><span>Attach Docs</span></button>
		</a>
<%
	if(retStrucCnt==0)
	{
%>
		<!--<button type="button" title="Save as Template" class="button" onclick="javascript:saveTemp()">
		<span>Save as Template</span></button>-->
<%
		if(!"FOC".equals(catType_C))
		{
%>
		<div id='save' style="float:left">
			<a class="fancybox" href="#SAVE" >
				<button type="button" title="Save Template" class="button" ><span>Save Template</span></button>
			</a>
		</div>
<%
		}
		if("CU".equals(userRole))
		{
%>
			<!--<button type="button" title="Save for Internal Review" class="button" onclick="javascript:saveOrder()">
			<span>Save for Internal Review</span></button>-->
<%
		}
		if("FOC".equals(catType_C))
		{
			if("Y".equals(focApprover) || loginUserId.equals(approver))
			{
%>
				<button type="button" title="Submit to ASB" class="button" onclick="javascript:submitOrder('TRANSFERED','<%=authChk_FOCAPPR%>')">
				<span class="right-link">Submit to ASB</span></button>
<%
			}
			else
			{
%>
				<button type="button" title="Submit for Approval" class="button" onclick="javascript:submitOrder('SUBMITTED','<%=authChk_FOC%>')">
				<span class="right-link">Submit for Approval</span></button>
<%
			}
		}
		else if(!(dispFlag_S || vipFlag_S) && "CU".equals(userRole))
		{
%>
			<button type="button" title="Submit My Question" class="button" onclick="javascript:submitOrder('NEGOTIATED','<%=authChk_SO%>')" id="review1" style="display:none">
			<span class="right-link">Submit My Question</span></button>
			<button type="button" title="Submit to ASB" class="button" onclick="javascript:submitOrder('TRANSFERED','<%=authChk_SO%>')" id="review_11">
			<span class="right-link">Submit to ASB</span></button>
<%
		}
		else if((dispFlag_S || vipFlag_S) && "CU".equals(userRole))
		{
%>
			<button type="button" title="Submit for Review" class="button" onclick="javascript:submitOrder('NEGOTIATED','<%=authChk_VD%>')">
			<span class="right-link">Submit for Review</span></button>
<%
		}	
		else if(!"CU".equals(userRole)){
%>
			<button type="button" title="Submit to ASB" class="button" onclick="javascript:submitOrder('TRANSFERED','<%=authChk_SO%>')">
			<span class="right-link">Submit to ASB</span></button>
<%
		}
	}
%>
	</div>
	<div id="divProcess1" style="display:none">
		<button type="button" title="Back" class="button" onclick="javascript:goBack()">
		<span class="left-link">Back</span></button>
		<button type="button" title="Re Pricing" class="button" onclick="javascript:processAgain()">
		<span>Re Pricing</span></button>
	</div>
	</p>
	<br><br>

</div> <!-- Info box -->
</div> <!-- col1-set -->
</div> <!-- col-main -->
</div> <!--main -->
</div> <!-- main-container col1-layout -->
</form>

</body>
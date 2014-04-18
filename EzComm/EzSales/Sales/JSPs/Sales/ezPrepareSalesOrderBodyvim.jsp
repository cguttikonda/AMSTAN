<%@ include file="ezCartRulesApply.jsp"%>
<%
	java.util.ArrayList uProdOrderType = new java.util.ArrayList();

	String itemSalesOrg_C = "";
	String itemDivision_C = "";
	String itemDistChnl_C = "";
	String itemOrdType_C = "";
	String itemBrand_C = "";

	String splitKey_S = "";
	boolean multiOrders = false;

	if(Cart!=null && Cart.getRowCount()>0)
	{
		int cartRows = Cart.getRowCount();

		for(int h=0;h<cartRows;h++)
		{
			itemBrand_C       = Cart.getBrand(h);
			itemSalesOrg_C 	  = Cart.getSalesOrg(h);
			itemDivision_C    = Cart.getDivision(h);
			itemDistChnl_C    = Cart.getDistChnl(h);
			itemOrdType_C     = Cart.getOrdType(h);

			if(!"56".equals(itemBrand_C))
				itemBrand_C = itemDivision_C;

			splitKey_S = itemOrdType_C+"е"+itemSalesOrg_C+"е"+itemDivision_C+"е"+itemDistChnl_C+"е"+itemBrand_C;

			if(!uProdOrderType.contains(splitKey_S))
			{
				uProdOrderType.add(splitKey_S);
			}
		}
	}

	if(uProdOrderType.size()>1)
		multiOrders = true;
%>
<style>

#input {

box-shadow: inset 0px 0px 0px ; 
-moz-box-shadow: inset 0px 0px 0px ; 
-webkit-box-shadow: inset 0px 0px 0px ; 
border: none; 

#error {
	color:red;
	font-size:10px;
	display:none;
}
.needsfilled {
	background:red;
	color:white;
}
   
}
</style>
<script type="text/javascript" src="http://jqueryjs.googlecode.com/files/jquery-1.3.2.min.js"></script>

<link rel="stylesheet" type="text/css" href="../../Library/Styles/formalize.css">
<script type="text/javascript" src="../../Library/Script/jquery.formalize.js"></script>
<script type="text/javascript" src="../../Library/Script/jquery.validate.js"></script>
<!--<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.9/jquery.validate.min.js"></script>-->
<%
	/*EzcParams promoParamsMisc = new EzcParams(false);
	EziMiscParams promoParams = new EziMiscParams();

	ReturnObjFromRetrieve promoCodeRetObj = null;
	promoParams.setIdenKey("MISC_SELECT");

	String query = "SELECT VALUE1,VALUE2 FROM EZC_VALUE_MAPPING WHERE MAP_TYPE='PROMOCODE'";

	promoParams.setQuery(query);

	promoParamsMisc.setLocalStore("Y");
	promoParamsMisc.setObject(promoParams);
	Session.prepareParams(promoParamsMisc);

	try
	{
		promoCodeRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(promoParamsMisc);
	}
	catch(Exception e){}*/

	String poNumber 	= (String)session.getValue("PONUM_PREP");
	String poDate 		= (String)session.getValue("PODATE_PREP");
	String selSoldTo 	= (String)session.getValue("SOLDTO_PREP");
	String comments 	= (String)session.getValue("COMMENTS_PREP");
	String complDlv 	= (String)session.getValue("SHIPCOMP_PREP");
	String shipMethod	= (String)session.getValue("SHIPMETHOD_PREP");
	String desiredDate 	= (String)session.getValue("DESDATE_PREP");
	String carrierName 	= (String)session.getValue("CARRNAME_PREP");
	String carrierId 	= (String)session.getValue("CARRID_PREP");
	String billToName 	= (String)session.getValue("BNAME_PREP");
	String billToStreet 	= (String)session.getValue("BSTREET_PREP");
	String billToCity 	= (String)session.getValue("BCITY_PREP");
	String billToState 	= (String)session.getValue("BSTATE_PREP");
	String billToZipCode 	= (String)session.getValue("BZIPCODE_PREP");
	String selShipToCode 	= (String)session.getValue("SHIPTO_PREP");
	String promoCode 	= (String)session.getValue("PROMO_PREP");
	String shipInst 	= (String)session.getValue("SHIPINST_PREP");

	String fromPage		= request.getParameter("fromPage");
	/*out.println("selSoldTo:::::::::::::::::::::::"+selSoldTo);
	out.println("complDlv:::::::::::::::::::::::"+complDlv);
	out.println("shipMethod:::::::::::::::::::::::"+shipMethod);
	out.println("desiredDate:::::::::::::::::::::::"+desiredDate);
	out.println("carrierName:::::::::::::::::::::::"+carrierName);
	out.println("carrierId:::::::::::::::::::::::"+carrierId);
	out.println("billToName:::::::::::::::::::::::"+billToName);
	out.println("billToStreet:::::::::::::::::::::::"+billToStreet);
	out.println("billToCity:::::::::::::::::::::::"+billToCity);
	out.println("billToState:::::::::::::::::::::::"+billToState);
	out.println("billToZipCode:::::::::::::::::::::::"+billToZipCode);
	out.println("selShipToCode:::::::::::::::::::::::"+selShipToCode);*/

%>
<%@ include file="../../../Includes/JSPs/Misc/iStatesRetObj.jsp"%>
<%
	java.util.HashMap shipMethodHM = new java.util.HashMap();

	shipMethodHM.put("STD","Best Way");
	shipMethodHM.put("CLTL","Customer's LTL Carrier");
	shipMethodHM.put("UP1A","UPS NextDay Air Early");
	shipMethodHM.put("UP1B","UPS Next Day Air");
	shipMethodHM.put("UP1C","UPS Next Day Air Saver");
	shipMethodHM.put("UP2B","UPS 2nd Day Air AM");
	shipMethodHM.put("UP2C","UPS 2nd Day Air");
	shipMethodHM.put("UP3C","UPS 3 Day Select");
	shipMethodHM.put("UPGC","UPS Ground (UPGC)");
	shipMethodHM.put("FE1A","Fedex First Overnight");
	shipMethodHM.put("FE1B","Fedex Priority Overnight");
	shipMethodHM.put("FE1C","Fedex Standard Overnight");
	shipMethodHM.put("FE2B","Fedex 2Day AM");
	shipMethodHM.put("FE2C","Fedex 2Day");
	shipMethodHM.put("FE3C","Fedex Express Saver");
	shipMethodHM.put("FEGC","Fedex Ground");
	shipMethodHM.put("FEHC","Fedex Home Delivery");
	shipMethodHM.put("UIUC","UPS Express Critical");
	shipMethodHM.put("UIPA","UPS WorldWide Express Plus");
	shipMethodHM.put("UIPB","UPS Worldwid Express");
	shipMethodHM.put("UIPC","UPS Worldwide Saver");
	shipMethodHM.put("UIEC","UPS Worldwide Expedited");
	shipMethodHM.put("UIGC","UPS Worldwide Standard");
	shipMethodHM.put("FIUC","Fedex International NextFlight");
	shipMethodHM.put("FIPC","Fedex International Priority");
	shipMethodHM.put("FIEC","Fedex International Economy");
	shipMethodHM.put("FIGC","Fedex International Ground");

	String sysKey = (String)session.getValue("SalesAreaCode");


	if(poNumber==null || "null".equalsIgnoreCase(poNumber))
	{
		poNumber = request.getParameter("poNumber");

		if(poNumber==null || "null".equalsIgnoreCase(poNumber)) poNumber = "";
	}
	if(poDate==null || "null".equalsIgnoreCase(poDate) || "".equals(poDate))
	{
		poDate = request.getParameter("poDate");

		if(poDate==null || "null".equalsIgnoreCase(poDate) || "".equals(poDate))
			poDate = FormatDate.getStringFromDate(new Date(),"/",FormatDate.MMDDYYYY);
	}
	if(desiredDate==null || "null".equalsIgnoreCase(desiredDate))
	{
		desiredDate = request.getParameter("desiredDate");

		if(desiredDate==null || "null".equalsIgnoreCase(desiredDate)) desiredDate = "";
	}
	if(promoCode==null || "null".equalsIgnoreCase(promoCode))
	{
		promoCode = request.getParameter("promoCode");

		if(promoCode==null || "null".equalsIgnoreCase(promoCode)) promoCode = "";
	}
	

	ReturnObjFromRetrieve retsoldto_A = (ReturnObjFromRetrieve)UtilManager.getUserCustomers(sysKey);
	//out.println("retsoldto_A::::"+retsoldto_A.toEzcString());
%>
<Script src="../../Library/Script/popup.js"></Script> 
<script type="text/javascript">
	function selectedShipTos()
	{
		//alert()
		var selShipTo=document.generalForm.selShipToInfo.value
		//alert(selShipTo)
		shipAddr	= selShipTo.split('е')[0]
		shipStreet	= selShipTo.split('е')[1]
		shipCity	= selShipTo.split('е')[2]
		shipState	= selShipTo.split('е')[3]
		shipCountry	= selShipTo.split('е')[4]
		shipZip		= selShipTo.split('е')[5]
		shipPhNum	= selShipTo.split('е')[6]
		shipCode	= selShipTo.split('е')[7]

		document.generalForm.shipToName.value = shipAddr
		document.generalForm.shipToStreet.value	= shipStreet
		document.generalForm.shipToCity.value = shipCity
		document.generalForm.shipToState.value = shipState	
		document.generalForm.shipToCountry.value = shipCountry
		document.generalForm.shipToZip.value = shipZip
		//document.generalForm.shipToPhone.value = shipPhNum
		document.generalForm.selShipTo.value = shipCode

		var tShipTo = shipCode.substring((shipCode.length)-4,shipCode.length);

		if(tShipTo=='9999')
		{
			document.getElementById("divShipToText").innerHTML = "";
			document.getElementById("divShipToText").style.display="none";
			document.getElementById("divShipToEnt").style.display="block";
		}
		else
		{
			if(selShipTo=='еееееее')
			{
				document.getElementById("divShipToText").innerHTML = "";
			}
			else
			{
				var shipInfo = "<br>"+shipAddr+"<br>"+shipStreet+"<br>"+shipCity+" "+shipState+", "+shipZip+" "+shipCountry;

				document.getElementById("divShipToText").innerHTML = shipInfo;
			}

			document.getElementById("divShipToText").style.display="block";
			document.getElementById("divShipToEnt").style.display="none";
		}

		/*
		if ($('#selShipToInfo').val() != $('#onetimeshipto').val() ){
			 $("#shipToName").attr("disabled",true);
			 $("#shipToStreet").attr("disabled",true);
			 $("#shipToCity").attr("disabled",true);
			 $("#shipToState").attr("disabled",true);
			 $("#shipToCountry").attr("disabled",true);
			 $("#shipToZip").attr("disabled",true);
			 
			 
		} else {
			 $("#shipToName").attr("disabled",false);
			 $("#shipToStreet").attr("disabled",false);
			 $("#shipToCity").attr("disabled",false);
			 $("#shipToState").attr("disabled",false);
			 $("#shipToCountry").attr("disabled",false);
			 $("#shipToZip").attr("disabled",false);
			 
		
		}
		*/
	}
	function selectedSoldTos()
	{
		document.generalForm.action="../Sales/ezPrepareSalesOrder.jsp";
		document.generalForm.submit();
	}
	function goToCart(rulesapp)
	{
		document.generalForm.rulappl.value = rulesapp;
		document.generalForm.action="../ShoppingCart/ezViewCart.jsp";
		document.generalForm.submit();
	}
	
	
	function selShipMethod()
	{
		var flag = document.generalForm.shipMethod.value;

		if(flag=='STD'){
			document.getElementById("divBillTo").style.display="none";
			document.getElementById("divuseyourcarrier").style.display="none";
			document.generalForm.billToState.value="";
		}
		else
			document.getElementById("divuseyourcarrier").style.display="block";
	}
	function selUseMyCarrier()
	{
		var flag = document.generalForm.useMyCarrier.value;

		if(flag=='NO'){
			document.getElementById("divBillTo").style.display="none";
			document.generalForm.billToState.value="";
		}
		else
			document.getElementById("divBillTo").style.display="block";
	}


	var xmlhttp;
	function getPricing()
	{
		xmlhttp = GetXmlHttpObject();

		if(xmlhttp==null)
		{
			alert ("Your browser does not support Ajax HTTP");
			return;
		}

		Popup.showModal('modal');

		var poNumber = document.generalForm.poNumber.value;
		var selSoldTo= document.generalForm.selSoldTo.value;
		var selShipTo= document.generalForm.selShipTo.value;

		var url="../Sales/ezPONumCheck.jsp";
		url=url+"?poNumber="+poNumber+"&selSoldTo="+selSoldTo+"&selShipTo="+selShipTo;

		if(xmlhttp!=null)
		{
			xmlhttp.onreadystatechange=Process;
			xmlhttp.open("GET",url,true);
			xmlhttp.send(null);
		}
		else
			Popup.hide('modal');
	}
	function Process()
	{
		if(xmlhttp.readyState==4)
		{
			var resText = xmlhttp.responseText;
			var resultText	= resText.split("##");
			var poExists	= resultText[1];

			Popup.hide('modal');

			var y = false;
			if(poExists=='X')
			{
				var z = confirm("Entered PO Number is already exists.\nPlease confirm");

				if(eval(z))
				{
					y = true;
				}
			}
			else
			{
				y = true;
			}

			if(eval(y))
			{
				Popup.showModal('modal');

				document.generalForm.action="../Sales/ezCreateSalesOrder.jsp";
				document.generalForm.submit();
			}
		}
	}
	function GetXmlHttpObject()
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
</script>
<script type="text/javascript">
$.validator.setDefaults({
	submitHandler: function() { getPricing(); }
});
$.validator.addMethod("valueNotEquals", function(value, element, arg){
	var shipCode = document.generalForm.selShipTo.value;
	var tShipTo = shipCode.substring((shipCode.length)-4,shipCode.length);
	/*if(tShipTo=='9999')
	{
		$("input[name='shipToPhone']").rules("add", {required:true});
	}*/

	return arg != value;
}, "Value must not equal arg.");
$.validator.addMethod("myCarrierNotEquals", function(value, element, arg){
	if(value!='STD')
	{
		var myCarr = document.generalForm.useMyCarrier.value;
		if(myCarr=='YES')
		{
			$("input[name='carrierId']").rules("add", {required:true});
			$("input[name='billToName']").rules("add", {required:true});
			$("input[name='billToStreet']").rules("add", {required:true});
			$("input[name='billToCity']").rules("add", {required:true});
			$("input[name='billToZipCode']").rules("add", {required:true});
		}
		return arg != value;
	}
	else
		return arg == value;
}, "Value must not equal arg.");
$().ready(function() {
	// validate signup form on keyup and submit
	$("#generalForm").validate({
		rules: {
			poNumber: "required",
			poDate: {
				required: true,
				date: true
			},
			selShipToInfo: { valueNotEquals: "еееееее" },
			shipToName: "required",
			shipToState: "required",
			shipToStreet: "required",
			shipToCity: "required",
			shipToZip: "required",
		},
		messages: {
			poNumber: "<font color=red>Please enter PO Number</font>",
			poDate: "<font color=red>Please enter PO Date</font>",
			selShipToInfo: { valueNotEquals: "<font color=red>Please select Ship To ID</font>"},
			shipToName: "<font color=red>Please provide Name</font>",
			shipToState: "<font color=red>Please provide State</font>",
			shipToStreet: "<font color=red>Please provide Street</font>",
			shipToCity: "<font color=red>Please provide City</font>",
			shipToZip: "<font color=red>Please provide Zipcode</font>",
			//shipToPhone: "<font color=red>Please provide Phone No</font>",
			carrierId: "<font color=red>Please provide Carrier ID/font>";
		}
	});
});
</script>
<form name="generalForm" id="generalForm" method="post" >
<input type=hidden name="rulappl">
<input type=hidden name="rulesCust">
<input type=hidden name="webOrdNo" value="<%=request.getParameter("webOrdNo")%>">
<div id="modal" style="border:0px solid black; background-color:white; padding:1px; font-size:10;width:40%;height:180px; text-align:center; display:none;">
	<ul>
		<li>&nbsp;</li>
		<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
		<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
	</ul>
</div>
<div class="main-container col2-layout middle account-pages">
<div class="main">
<div class="col-main1">
	<div class="page-title">
		<h1> Confirm Header Information </h1>
	</div>		
	<div class="col2-set">
		<div class="col-1">
			<button type="button" title="Back to Cart" class="button btn-cart" onClick="javascript:goToCart('<%=rulesApply%>')"><span><span>Back to Cart</span></span></button>
		</div>
		
<%
		if(!"Y".equals(rulesApply))
		{
%>
			<div class="col-2">
				<button type="submit" name="submit" title="To Pricing" class="button btn-cart" ><span><span>To Pricing</span></span></button>
			</div>
<%		}
%>
	</div>
<%
	if("Y".equals(rulesApply))
	{
%>
	<div class="info-box">		
	<ul class="error-msg"><span>Some of the Items in the Cart are Exclusive to default Sold To. 
	Please Go to Cart and Remove the Items which are Exclusive and continue. (OR) Please select the previous Sold To to continue.</span></li></ul>			
	</div> 
<%
	}
%>
<br>
<div class="col2-set">
<div class="col-1">
<div class="info-box">
	<h2 class="legend" style="background-color:#EEEDE7">Purchase Order Info </h2>
	<p>Enter your PO Information here. It is critical for searching Orders quickly</p>
	<ul class="form-list">
		<li><label for="ponumber" class="required">PO Number<em>*</em></label>
			<div class="input-box">
				<input type="text" id="poNumber" name="poNumber"  maxlength="20" style="width:100%" value="<%=poNumber%>">
			</div>
		</li>
		<li><label for="podate" class="required">PO Date<em>*</em></label>
			<div class="input-box">
				<input type="text" id="poDate" name="poDate"  size="12" value="<%=poDate%>" readonly><%=getDateImage("poDate")%>
			</div>
		</li>
		<li><label for="desiredDate" >Expected Delivery Date</label>
			<div class="input-box">
				<input type="text" id="desiredDate" name="desiredDate" size="12" value="<%=desiredDate%>" readonly><%=getDateImage("desiredDate")%>
			</div>
		</li>
<%
	String dlvCheck = "";
	String disabled = "";

	if(multiOrders)
		disabled = "disabled=disabled";
	else
	{
		if(complDlv!=null && ("on".equalsIgnoreCase(complDlv) || "Y".equals(complDlv)))
			dlvCheck = "checked=checked";
		else if(request.getParameter("shipComplete")!=null && !"null".equalsIgnoreCase(request.getParameter("shipComplete")))
			dlvCheck = "checked=checked";
	}
%>
		<li>
			<label for="desiredDate" >Deliver Together<br>(Restrictions Apply<em>*</em>)</label>
			<div class="input-box">
				<input class="input-checkbox" type="checkbox" id="shipComplete" name="shipComplete" <%=dlvCheck%> <%=disabled%>></input>
			</div>
		</li>
	</ul>
	<h2 class="legend" style="background-color:#EEEDE7">Sold To Address </h2>
	<!--<div class="layerednav-top-searchsoldto"><a href="javascript:void(0)"><span>Search</span></a></div>-->
		<div id="layerednav-top-searchsoldto-content" style="display:none">
		<h3>Search Criteria</h3>
		<p> Enter Search Criteria and hit Search. Once results are presented click on any row to copy to your current screen</p>
		<br>
		<ul class="form-list">
			<li>
				<label for="shipdate" >Name </label>
				<div class="input-box">
					<input class="input-text" type="text" id="soldtofirstname" name="soldtofirstname"  size="30" value="AC*">
				</div>
			</li>
			<li>
				<label for="shipdate" >First Name </label>
				<div class="input-box">
					<input class="input-text date" type="text" id="soldtofirstname" name="soldtofirstname"  size="10" value="">
				</div>
			</li>
			<li>
				<label for="shipdate" >Search Term 1 </label>
				<div class="input-box">
					<input class="input-text date" type="text" id="searchterm1" name="searchterm1"  size="10" value="">
				</div>
			</li>
			<li>
				<label for="shipdate" >Search Term 2 </label>
				<div class="input-box">
					<input class="input-text date" type="text" id="soldtofirstname" name="searchterm2"  size="10" value="">
				</div>
			</li>
			<li>
				<label for="shipdate" >Street</label>
				<div class="input-box">
					<input class="input-text date" type="text" id="soldtofirstname" name="soldtofirstname"  size="10" value="">
				</div>
			</li>
			<li>
				<label for="shipdate" >City </label>
				<div class="input-box">
					<input class="input-text date" type="text" id="soldtofirstname" name="soldtofirstname"  size="10" value="">
				</div>
			</li>
			<li>
				<label for="shipdate" >Zip Code </label>
				<div class="input-box">
					<input class="input-text date" type="text" id="soldtofirstname" name="soldtofirstname"  size="10" value="">
				</div>
			</li>
			<li>
				<label for="shipdate" >Country </label>
				<div class="input-box">
					<input class="input-text date" type="text" id="soldtofirstname" name="soldtofirstname"  size="10" value="US">
				</div>
			</li>
			<li>
				<label for="shipdate" >State </label>
				<div class="input-box">
				<div class="selector" id="users-shipto-ids"><span>TX-Texas</span>
					<select id="users-soldto" name="users-soldto" title="Soldto" defaultvalue="TX" >
						<option value></option>
						<option value="AL">AL-ALABAMA</option>
						<option value="TX">TX-TEXAS</option>
						<option value="NJ">NJ-NEW JERSEY</option>
						<option value="PA">PA-PENNSYLVANIA</option>
					</select>
				</div>
				</div>
			</li>
			<li>
				<div class="input-box">
					<input class="input-button" type="button" id="getresults" name="getresults"  size="10" value="Clear Criteria">
					<input class="input-button" type="button" id="getresults" name="getresults"  size="10" value="Get Results">
				</div>
			</li>
		</ul>
		<br>
		<table>
		<tr>
			<th>Customer</th>
			<th>Name</th>
			<th>First name</th>
			<th>Street</th>
			<th>House</th>
			<th>Postal Code</th>
			<th>City</th>
			<th>Search Term 1</th>
			<th>Search Term 2</th>
			<th>Country</th>
		</tr>
		<tr>
			<td>&nbsp;102400000</td>
			<td>&nbsp;A C PLBG SUPPLY CO-BAYTOWN </td>
			<td>&nbsp;</td>
			<td>&nbsp;PO BOX 690253</td>
			<td>&nbsp;</td>
			<td>&nbsp;77269</td>
			<td>&nbsp;HOUSTON</td>
			<td>&nbsp;ACPLB BAYT</td>
			<td>&nbsp;</td>
			<td>&nbsp;US</td>
		</tr>
		</table>
		<div class="know-close-button"><a href="javascript:void(0)">[ x ] Close</a></div>
	</div>
	<script type="text/javascript">
	var viewport = document.viewport.getDimensions();
		$$('.layerednav-top-searchsoldto a').invoke('observe', 'click' ,function(){
			Dialog.info($('layerednav-top-searchsoldto-content').innerHTML, { className: "magento know", width:800, height:600, zIndex: 99999, recenterAuto:false, autoresize:false, top:160, left: viewport.width/2 - 300, onShow:function(){
			$$('.overlay_magento.know', '.know-close-button a').invoke('observe','click',function(){
			Dialog.closeInfo()
			});
		} });
	});
	</script>
	<ul class="form-list">
<%
	if(!"S".equals(fromPage))
	{
		if(request.getParameter("selSoldTo")!=null) selSoldTo = request.getParameter("selSoldTo");
		
		
		 
		if(selSoldTo==null || "null".equalsIgnoreCase(selSoldTo) || "".equals(selSoldTo.trim()))
			selSoldTo = (String)session.getValue("AgentCode");
	}
	
	if(comments==null || "null".equalsIgnoreCase(comments))
	{
		comments = request.getParameter("comments");

		if(comments==null || "null".equalsIgnoreCase(comments)) comments = "";
	}
	if(shipInst==null || "null".equalsIgnoreCase(shipInst))
	{
		shipInst = request.getParameter("shipInst");

		if(shipInst==null || "null".equalsIgnoreCase(shipInst)) shipInst = "";
	}

	String selSoldName 	= "";
	String selSoldAddr1	= "";
	String selSoldCity 	= "";
	String selSoldState 	= "";
	String selSoldCountry 	= "";
	String selSoldZipCode	= "";
	String selSoldPhNum 	= "";
	String selSoldEmail 	= "";
	String soldToIncoTerm 	= "";
%>
	<li>
		<label for="soldtoname" >Sold To ID </label>
		<div class="input-box">
		<div>
		<select name="selSoldTo" onChange="selectedSoldTos()">
<%
		if(retsoldto_A!=null)
		{
			for(int i=0;i<retsoldto_A.getRowCount();i++)
			{
				String soldToCode_A 	= retsoldto_A.getFieldValueString(i,"EC_ERP_CUST_NO");
				String soldToName_A 	= retsoldto_A.getFieldValueString(i,"ECA_NAME");

				String selected_A = "";

				if(selSoldTo.equals(soldToCode_A))
				{
					selected_A	= "selected";
					selSoldName 	= retsoldto_A.getFieldValueString(i,"ECA_NAME");
					selSoldAddr1	= retsoldto_A.getFieldValueString(i,"ECA_ADDR_1");
					selSoldCity 	= retsoldto_A.getFieldValueString(i,"ECA_CITY");
					selSoldState 	= retsoldto_A.getFieldValueString(i,"ECA_DISTRICT");
					selSoldCountry 	= retsoldto_A.getFieldValueString(i,"ECA_COUNTRY");
					selSoldZipCode	= retsoldto_A.getFieldValueString(i,"ECA_POSTAL_CODE");
					selSoldPhNum 	= retsoldto_A.getFieldValueString(i,"ECA_PHONE");
					selSoldEmail 	= retsoldto_A.getFieldValueString(i,"ECA_EMAIL");
					soldToIncoTerm	= retsoldto_A.getFieldValueString(i,"ECA_INCOTERMS");

					selSoldAddr1 	= (selSoldAddr1==null || "null".equals(selSoldAddr1)|| "".equals(selSoldAddr1))?"":selSoldAddr1;
					selSoldCity 	= (selSoldCity==null || "null".equals(selSoldCity)|| "".equals(selSoldCity))?"":selSoldCity;// for city
					selSoldState 	= (selSoldState==null || "null".equals(selSoldState) || "".equals(selSoldState))?"":selSoldState;
					selSoldCountry 	= (selSoldCountry==null || "null".equals(selSoldCountry)|| "".equals(selSoldCountry))?"":selSoldCountry.trim();
					selSoldZipCode 	= (selSoldZipCode==null || "null".equals(selSoldZipCode)|| "".equals(selSoldZipCode))?"":selSoldZipCode;
					selSoldPhNum 	= (selSoldPhNum==null || "null".equals(selSoldPhNum)|| "".equals(selSoldPhNum))?"":selSoldPhNum;
					selSoldEmail 	= (selSoldEmail==null || "null".equals(selSoldEmail)|| "".equals(selSoldEmail))?"":selSoldEmail;
					soldToIncoTerm 	= (soldToIncoTerm==null || "null".equals(soldToIncoTerm)|| "".equals(soldToIncoTerm))?"":soldToIncoTerm;
				}
%>
				<option value="<%=soldToCode_A%>" <%=selected_A%>><%=soldToName_A%> : <%=soldToCode_A%></option>
<%
			}
		}
%>
		</select>
		</div>

<input type="hidden" name="soldToName" value="<%=selSoldName%>">
<input type="hidden" name="soldToStreet" value="<%=selSoldAddr1%>">
<input type="hidden" name="soldToCity" value="<%=selSoldCity%>">
<input type="hidden" name="soldToState" value="<%=selSoldState%>">
<input type="hidden" name="soldToCountry" value="<%=selSoldCountry%>">
<input type="hidden" name="soldToZipCode" value="<%=selSoldZipCode%>">
<input type="hidden" name="soldToPhNum" value="<%=selSoldPhNum%>">
<input type="hidden" name="soldToEmail" value="<%=selSoldEmail%>">
<input type="hidden" name="soldToIncoTerm" value="<%=soldToIncoTerm%>">

			<br><%=selSoldName%><br>
			<%=selSoldAddr1%><br>
			<%=selSoldCity%> <%=selSoldState%> <%=selSoldZipCode%> <%=selSoldCountry%>
		</div>
	</li>
	</ul>
<%
	String catalog_areaSA = sysKey;
	String selSoldToSA = selSoldTo;
%>
<%@ include file="../../../Includes/JSPs/SwitchAccount/iGetShipTo.jsp"%>
<%
	/*UtilManager.setSysKeyAndSoldTo(sysKey,selSoldTo);
	ReturnObjFromRetrieve  listShipTos_ent = (ReturnObjFromRetrieve)UtilManager.getListOfShipTos(selSoldTo);
	UtilManager.setSysKeyAndSoldTo(sysKey,(String)session.getValue("AgentCode"));*/

	//if(selShipToCode==null || "null".equalsIgnoreCase(selShipToCode) || "".equals(selShipToCode.trim()) || "еееееее".equals(selShipToCode))
		//selShipToCode = (String)session.getValue("ShipCode");

	String shipToName = "";
	String shipAddr1 = "";
	String shipAddr2 = "";
	String shipState = "";
	String shipCountry = "";
	String shipZip = "";
	String shipPhNum = "";
	String selShipParams = "еееееее";
%>
	<h2 class="legend" style="background-color:#EEEDE7">Ship To Address </h2>
	<ul class="form-list">
	<li>
		<label for="soldtoname" class="required">Ship To ID<em>*</em></label>
		<div class="input-box">
		<div>
		<select name="selShipToInfo" id="selShipToInfo" onChange="selectedShipTos()">
			<option value="еееееее">------Select------</option>
<%
		int listShipCnt = listShipTosCS.getRowCount();
		for(int l=0;l<listShipCnt;l++)
		{
			String shipToCode = listShipTosCS.getFieldValueString(l,"EC_PARTNER_NO");

			shipToName 	= listShipTosCS.getFieldValueString(l,"ECA_NAME");
			shipAddr1  	= listShipTosCS.getFieldValueString(l,"ECA_ADDR_1"); //Street
			shipAddr2  	= listShipTosCS.getFieldValueString(l,"ECA_CITY");
			shipState  	= listShipTosCS.getFieldValueString(l,"ECA_STATE");
			shipCountry  	= listShipTosCS.getFieldValueString(l,"ECA_COUNTRY");
			shipZip    	= listShipTosCS.getFieldValueString(l,"ECA_PIN");
			shipPhNum    	= listShipTosCS.getFieldValueString(l,"ECA_PHONE");

			shipAddr1 	= (shipAddr1==null || "null".equals(shipAddr1)|| "".equals(shipAddr1))?"N/A":shipAddr1;
			shipAddr2 	= (shipAddr2==null || "null".equals(shipAddr2)|| "".equals(shipAddr2))?"N/A":shipAddr2;// for city
			shipState 	= (shipState==null || "null".equals(shipState) || "".equals(shipState))?"N/A":shipState;
			shipCountry 	= (shipCountry==null || "null".equals(shipCountry)|| "".equals(shipCountry))?"N/A":shipCountry.trim();
			shipZip 	= (shipZip==null || "null".equals(shipZip)|| "".equals(shipZip))?"N/A":shipZip;
			shipPhNum 	= (shipPhNum==null || "null".equals(shipPhNum)|| "".equals(shipPhNum))?"N/A":shipPhNum;

			String shipParams = shipToName+"е"+shipAddr1+"е"+shipAddr2+"е"+shipState+"е"+shipCountry+"е"+shipZip+"е"+shipPhNum+"е"+shipToCode;

			String selected_A = "";
			String onetime_A = "";

			String tempShip = shipToCode.substring(shipToCode.length()-4,shipToCode.length());

			if((listShipCnt==1) || ((listShipCnt==2) && !"9999".equals(tempShip)))
			{
				selected_A = "selected";
				selShipParams = shipParams;
			}

			if(selShipToCode!=null && selShipToCode.equals(shipToCode))
			{
				selected_A = "selected";
				selShipParams = shipParams;
			}
			if (shipToCode.endsWith("9999")){
				onetime_A = "id=\"onetimeshipto\" name=\"onetimeshipto\"";
				shipToName = "Drop Ship";
			}
%>
			<option value="<%=shipParams%>" <%=selected_A%> <%=onetime_A%>><%=shipToName%> : <%=shipToCode%></option>
<%
		}

	String defShipToName = "N/A";
	String defShipAddr1 = "N/A";
	String defShipAddr2 = "N/A";
	String defShipState = "N/A";
	String defShipCountry = "N/A";
	String defShipZip = "N/A";
	String defShipPhNum = "N/A";
	String defShipToCode = "N/A";

	try
	{
		defShipToName  = selShipParams.split("е")[0];
		defShipAddr1   = selShipParams.split("е")[1];
		defShipAddr2   = selShipParams.split("е")[2];
		defShipState   = selShipParams.split("е")[3];
		defShipCountry = selShipParams.split("е")[4];
		defShipZip     = selShipParams.split("е")[5];
		defShipPhNum   = selShipParams.split("е")[6];
		defShipToCode  = selShipParams.split("е")[7];
	}
	catch(Exception e){}
%>
		</select>
		<input type="hidden" name="selShipTo" value="<%=defShipToCode%>">
		<input type="hidden" name="shipToCountry" value="<%=defShipCountry%>">
		</div>
		<div id="divShipToText" style="display:none">
		</div>
		</div>
	</li>
	<div id="divShipToEnt" style="display:none">
	<li>
		<label for="shipToName" class="required">Ship To Name<em>*</em> </label>
		<div class="input-box">
			<input type="text" id="shipToName" name="shipToName" style="width:100%" value="<%=defShipToName%>">
		</div>
	</li>
	<li>
		<label for="shipToStreet" class="required">Street 1<em>*</em></label>
		<div class="input-box">
			<input type="text" id="shipToStreet" name="shipToStreet" style="width:100%" value="<%=defShipAddr1%>">
		</div>
	</li>
	<li>
		<label for="city-state-zip" class="required">City<em>*</em></label>
		<div class="input-box">
			<input type="text" id="shipToCity" name="shipToCity" style="width:100%" value="<%=defShipAddr2%>">
		</div>
		<label for="city-state-zip" class="required">State<em>*</em></label>
		<div class="input-box">
			<select name="shipToState" id="shipToState">
<%
			if(stateRetRes!=null)
			{
				for(int i=0;i<stateRetRes.getRowCount();i++)
				{
					String shipToStateCode 	= stateRetRes.getFieldValueString(i,"STATECODE");
					String shipToStateName 	= stateRetRes.getFieldValueString(i,"STATENAME");

					String selected_A = "selected";

					if(defShipState.equals(shipToStateCode))
					{
%>
						<option value="<%=shipToStateCode%>" <%=selected_A%>><%=shipToStateName%></option>
<%
					}
					else
					{
%>
						<option value="<%=shipToStateCode%>" ><%=shipToStateName%></option>
<%
					}
				}
			}
%>
			</select>
			<!--<input type="text" id="shipToState" name="shipToState" value="<%=defShipState%>">-->
		</div>
		<label for="city-state-zip" class="required">Zip<em>*</em></label>
		<div class="input-box">
			<input type="text" id="shipToZip" name="shipToZip" style="width:100%" value="<%=defShipZip%>">
		</div>
	</li>
	</div>
	<!--<li>
		<label for="shipToPhone" class="required">Phone </label>
		<div class="input-box">
			<input type="text" id="shipToPhone" name="shipToPhone" style="width:100%" value="<%//=defShipPhNum%>">
		</div>
	</li>-->
		<li>
			<label for="promocode" class="required">Promo Code</label>
			<div class="input-box">
				<input type="text" id="promoCode" name="promoCode" style="width:100%" maxlength=2 value="<%=promoCode%>">
			<!--<div>
			<select id="promoCode" name="promoCode" title="Promo-Code">
			<option value="">------Select------</option>-->
<%
			/*for(int i=0;i<promoCodeRetObj.getRowCount();i++)
			{
				String pCodeVal = promoCodeRetObj.getFieldValueString(i,"VALUE1");
				String pCodeDesc = promoCodeRetObj.getFieldValueString(i,"VALUE2");

				String selected_A = "";

				if(promoCode!=null && promoCode.equals(pCodeVal))
					selected_A	= "selected";*/
%>
				<!--<option value="<%//=pCodeVal%>" <%//=selected_A%>><%//=pCodeDesc%></option>-->
<%
			//}
%>
			<!--</select>
			</div>-->
			</div>
		</li>
	
	</ul>
</div> <!-- info-box -->
</div> <!-- col1 -->
<script>
	selectedShipTos()
</script>
<div class="col-2">
<div class="info-box">
<%
	if(shipMethod==null || "null".equalsIgnoreCase(shipMethod) || "".equals(shipMethod.trim()))
	{
		shipMethod = request.getParameter("shipMethod");

		if(shipMethod==null || "null".equalsIgnoreCase(shipMethod) || "".equals(shipMethod.trim())) shipMethod = "STD";
	}
	if(carrierName==null || "null".equalsIgnoreCase(carrierName)) carrierName = "";
	if(carrierId==null || "null".equalsIgnoreCase(carrierId))
	{
		carrierId = request.getParameter("carrierId");

		if(carrierId==null || "null".equalsIgnoreCase(carrierId)) carrierId = "";
	}
	if(billToName==null || "null".equalsIgnoreCase(billToName))
	{
		billToName = request.getParameter("billToName");

		if(billToName==null || "null".equalsIgnoreCase(billToName)) billToName = "";
	}
	if(billToStreet==null || "null".equalsIgnoreCase(billToStreet))
	{
		billToStreet = request.getParameter("billToStreet");

		if(billToStreet==null || "null".equalsIgnoreCase(billToStreet)) billToStreet = "";
	}
	if(billToCity==null || "null".equalsIgnoreCase(billToCity))
	{
		billToCity = request.getParameter("billToCity");

		if(billToCity==null || "null".equalsIgnoreCase(billToCity)) billToCity = "";
	}
	if(billToState==null || "null".equalsIgnoreCase(billToState))
	{
		billToState = request.getParameter("billToState");

		if(billToState==null || "null".equalsIgnoreCase(billToState)) billToState = "";
	}
	if(billToZipCode==null || "null".equalsIgnoreCase(billToZipCode))
	{
		billToZipCode = request.getParameter("billToZipCode");

		if(billToZipCode==null || "null".equalsIgnoreCase(billToZipCode)) billToZipCode = "";
	}
	
%>
<h2 class="legend" style="background-color:#EEEDE7">Shipping Info </h2>
<p>Enter Desired Shipping Method here.If you wish to use your account with carrier, provide details.</p>
	<ul class="form-list">
	<li>
		<label for="shipMethod" class="required">Shipping Method<em>*</em> </label>
		<div class="input-box">
		<div>
		<select name="shipMethod" id="shipMethod" title="shipping-method" onChange="selShipMethod()">
<%
		Map sortedMap = new TreeMap(shipMethodHM);

		Set shipCol = sortedMap.entrySet();
		Iterator shipColIte = shipCol.iterator();

                while(shipColIte.hasNext())
                {
			Map.Entry shipColData = (Map.Entry)shipColIte.next();

			String shipMethodCode = (String)shipColData.getKey();
			String shipMethodDesc = (String)shipColData.getValue();

			String selected_A = "";

			if(shipMethod.equals(shipMethodCode))
				selected_A = "selected";
%>
			<option value="<%=shipMethodCode%>" <%=selected_A%>><%=shipMethodDesc%></option>
<%
		}
%>
		</select>
		</div>
		</div>
	</li>
	</ul>
<%
	String selected_N = "selected";
	String selected_Y = "";
	String visHid = "none";
	String visHid1 = "none";

	if(!"STD".equals(shipMethod))
	{
		visHid1 = "block";

		if(!"".equals(carrierId))
		{
			visHid = "block";
			selected_N = "";
			selected_Y = "selected";
		}
	}
%>
	<div id="divuseyourcarrier" style="display:<%=visHid1%>">
	<ul class="form-list">
	<li>
		<label for="useMyCarrier" class="required">Use My Carrier's<br>Billing Account<em>*</em> </label>
		<div class="input-box">
		<div>
		<select id="useMyCarrier" name="useMyCarrier" title="use-carrier" onChange="selUseMyCarrier()" STYLE="width: 60px">
			<option value="NO" <%=selected_N%>>No</option>
			<option value="YES" <%=selected_Y%>>Yes</option>
		</select>
		</div>
		</div>
	</li>
	</ul>
	</div>

	<div id="divBillTo" style="display:<%=visHid%>">
	<ul class="form-list">
	<!--<li>
		<label for="carrierName" >Carrier Name</label>
		<div class="input-box">
			<input type="text" id="carrierName" name="carrierName" style="width:100%" value="<%//=carrierName%>">
		</div>
	</li>-->
	<li>
		<label for="carrierId" class="required">Carrier A/c ID<em>*</em></label>
		<div class="input-box">
			<input type="text" id="carrierId" name="carrierId" style="width:100%" value="<%=carrierId%>">
		</div>
	</li>
	<li>
		<label for="billToName" class="required">Bill To Name<em>*</em></label>
		<div class="input-box">
			<input type="text" id="billToName" name="billToName" style="width:100%" value="<%=billToName%>">
		</div>
	</li>
	<li>
		<label for="billToStreet" class="required">Street 1<em>*</em> </label>
		<div class="input-box">
			<input type="text" id="billToStreet" name="billToStreet" style="width:100%" value="<%=billToStreet%>">
		</div>
	</li>
	<li>
		<label for="billToCity" class="required">City<em>*</em> </label>
		<div class="input-box">
			<input type="text" id="billToCity" name="billToCity" style="width:100%" value="<%=billToCity%>">
		</div>
	</li>
	<li>
		<label for="billToState" class="required">State<em>*</em> </label>
		<div class="input-box">
		<div>
		<select id="billToState" name="billToState" title="Bill To State">
<%
	if(stateRetRes!=null)
	{
		for(int i=0;i<stateRetRes.getRowCount();i++)
		{
			String shipToStateCode 	= stateRetRes.getFieldValueString(i,"STATECODE");
			String shipToStateName 	= stateRetRes.getFieldValueString(i,"STATENAME");

			String selected_A = "selected";

			if(billToState.equals(shipToStateCode))
			{
%>
				<option value="<%=shipToStateCode%>" <%=selected_A%>><%=shipToStateName%></option>
<%
			}
			else
			{
%>
				<option value="<%=shipToStateCode%>" ><%=shipToStateName%></option>
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
		<label for="billToZipCode" class="required">ZipCode<em>*</em> </label>
		<div class="input-box">
			<input type="text" id="billToZipCode" name="billToZipCode" style="width:100%" value="<%=billToZipCode%>">
		</div>
	</li>
	</ul>
	</div>
	<h2 class="legend" style="background-color:#EEEDE7">General Info </h2>
	<ul class="form-list">
	<li>
		<div class="textarea" id="headertext">
			<textarea name="comments" cols="80" rows="3" style="width:100%"><%=comments%></textarea>
		</div>
	</li>
	</ul>
	<h2 class="legend" style="background-color:#EEEDE7" >Shipping Instructions </h2>
	<ul class="form-list">
	<li>
		<div class="textarea" id="shipInst">
			<textarea name="shipInst" cols="80" rows="3" style="width:100%"><%=shipInst%></textarea>
		</div>
	</li>
	</ul>
</div> <!-- info-box -->
</div> <!-- col2 -->
</div> <!-- col2-set -->
	<div class="col2-set">
		<div class="col-1">
			<button type="button" title="Back to Cart" class="button btn-cart" onClick="javascript:goToCart('<%=rulesApply%>')"><span><span>Back to Cart</span></span></button>
		</div>
		
<%
		if(!"Y".equals(rulesApply))
		{
%>
			<div class="col-2">
				<button type="submit" name="submit" title="To Pricing" class="button btn-cart" ><span><span>To Pricing</span></span></button>
			</div>
<%		}
%>
	</div>

	
</div>
<!-- <div>-->
</div> <!-- col-main -->
</div> <!--main -->
</div> <!-- main-container col1-layout -->
</form>
<script type="application/javascript">
/*
Created 09/27/09										
Questions/Comments: jorenrapini@gmail.com						
COPYRIGHT NOTICE		
Copyright 2009 Joren Rapini
*/

	

$(document).ready(function(){
	// Place ID's of all required fields here.
	required = ["carrierId", "billToName", "billToStreet","billToCity","billToState","billToZipCode"];
	// If using an ID other than #email or #error then replace it here
	email = $("#email");
	errornotice = $("#error");
	// The text to show up within a field when it is incorrect
	emptyerror = "Please fill out this field.";
	emailerror = "Please enter a valid e-mail.";

	$("#generalForm").submit(function(){	
		//Validate required fields
		for (i=0;i<required.length;i++) {
			var input = $('#'+required[i]);
			if ((input.val() == "") || (input.val() == emptyerror)) {
				input.addClass("needsfilled");
				input.val(emptyerror);
				errornotice.fadeIn(750);
			} else {
				input.removeClass("needsfilled");
			}
		}
		// Validate the e-mail.
		if (!/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/.test(email.val())) {
			email.addClass("needsfilled");
			email.val(emailerror);
		}

		//if any inputs on the page have the class 'needsfilled' the form will not submit
		if ($(":input").hasClass("needsfilled")) {
			return false;
		} else {
			errornotice.hide();
			return true;
		}
	});
	
	// Clears any fields in the form when the user clicks on them
	$(":input").focus(function(){		
	   if ($(this).hasClass("needsfilled") ) {
			$(this).val("");
			$(this).removeClass("needsfilled");
	   }
	});
});	
</script>

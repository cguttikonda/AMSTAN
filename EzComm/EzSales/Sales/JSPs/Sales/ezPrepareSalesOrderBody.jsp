<%@ include file="ezCartRulesApply.jsp"%>
<%
	java.util.ArrayList uProdOrderType = new java.util.ArrayList();

	String itemSalesOrg_C = "";
	String itemDivision_C = "";
	String itemDistChnl_C = "";
	String itemOrdType_C = "";
	String itemBrand_C = "";
	String itemProgType_C = "";
	String itemClass_C = "";
	String quoteSoldTo = "";

	String splitKey_S = "";
	boolean multiOrders = false;
	boolean quickShip = false;

	int cartRows = 0;

	if(Cart!=null && Cart.getRowCount()>0)
	{
		cartRows = Cart.getRowCount();

		for(int h=0;h<cartRows;h++)
		{
			itemBrand_C       = Cart.getBrand(h);
			itemSalesOrg_C 	  = Cart.getSalesOrg(h);
			itemDivision_C    = Cart.getDivision(h);
			itemDistChnl_C    = Cart.getDistChnl(h);
			itemOrdType_C     = Cart.getOrdType(h);
			itemProgType_C	  = Cart.getCat1(h);
			itemClass_C	  = Cart.getExt1(h);

			if("QS".equals(itemProgType_C) && ("LUX".equals(itemClass_C) || "COM".equals(itemClass_C)))
				quickShip = true;

			String itemCust_C = Cart.getMfrCode(h);

			if(!"N/A".equals(itemCust_C)) quoteSoldTo = itemCust_C;

			if(!("56".equals(itemBrand_C) || "36".equals(itemBrand_C) || "5L".equals(itemBrand_C) || "55".equals(itemBrand_C)))
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
<style type="text/css">
#input {
	box-shadow: inset 0px 0px 0px ; 
	-moz-box-shadow: inset 0px 0px 0px ; 
	-webkit-box-shadow: inset 0px 0px 0px ; 
	border: none; 
}

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
<link rel="stylesheet" type="text/css" href="../../Library/Styles/formalize.css">
<script type="text/javascript" src="../../Library/Script/jquery.formalize.js"></script>
<!--<script type="text/javascript" src="../../Library/Script/jquery.validate.js"></script>
<link rel="stylesheet" type="text/css" href="../../Library/Styles/Alerts/jquery.alerts.css">
<script type="text/javascript" src="../../Library/Script/Alerts/jquery.alerts.js"></script>-->
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
	String useMyCarrier	= (String)session.getValue("CARRUSE_PREP");
	String isResidential	= (String)session.getValue("ISRESID_PREP");
	String carrierId 	= (String)session.getValue("CARRID_PREP");
	String billToName 	= (String)session.getValue("BNAME_PREP");
	String billToStreet 	= (String)session.getValue("BSTREET_PREP");
	String billToCity 	= (String)session.getValue("BCITY_PREP");
	String billToState 	= (String)session.getValue("BSTATE_PREP");
	String billToZipCode 	= (String)session.getValue("BZIPCODE_PREP");
	String selShipToCode 	= (String)session.getValue("SHIPTO_PREP");
	String promoCode 	= (String)session.getValue("PROMO_PREP");
	String shipInst 	= (String)session.getValue("SHIPINST_PREP");

	String defShipToName 	= (String)session.getValue("SHIPNA_PREP");
	String defShipAddr1 	= (String)session.getValue("SHIPSR_PREP");
	String defShipAddr2 	= (String)session.getValue("SHIPCT_PREP");
	String defShipState 	= (String)session.getValue("SHIPST_PREP");
	String defShipCountry 	= (String)session.getValue("SHIPCN_PREP");
	String defShipZip 	= (String)session.getValue("SHIPZC_PREP");
	String defShipPhNum 	= (String)session.getValue("SHIPPH_PREP");
	String defShipToCode 	= (String)session.getValue("SHIPTO_PREP");

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
<%@ include file="../../../Includes/JSPs/Misc/iShipMethods.jsp"%>
<%
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
	

	ReturnObjFromRetrieve retsoldto_A = (ReturnObjFromRetrieve)session.getValue("retsoldto_A_Ses");//(ReturnObjFromRetrieve)UtilManager.getUserCustomers(sysKey);
	//out.println("retsoldto_A::::"+retsoldto_A.toEzcString());
	ezc.ezcommon.EzLog4j.log("retsoldto_A>>>"+retsoldto_A.toEzcString(),"D");
%>
<Script src="../../Library/Script/popup.js"></Script> 
<script type="text/javascript">

	var xmlhttpAttr;
	function checkdefShipto()
	{
		var defShip	= '<%=sesShipTo%>';
		var selSoldTo	= document.generalForm.selSoldTo.value;
		var selShipTo	= document.generalForm.selShipToInfo.value;
		shipCode	= selShipTo.split('е')[7];

		//if(defShip != shipCode)
		{
			xmlhttpAttr=GetXmlHttpObject();

			if (xmlhttpAttr==null)
			{
				$( "#dialog-alert" ).dialog("option", "title", "Browser Does Not Support");
				$( "#dialog-alert" ).dialog('open').text("Your browser does not support Ajax HTTP");
				return;
			}

			var url="../Misc/ezAttributeCheck.jsp";
			url=url+"?shipToCode="+shipCode+"&soldToCode="+selSoldTo;

			xmlhttpAttr.onreadystatechange=getOutput;
			xmlhttpAttr.open("GET",url,true);
			xmlhttpAttr.send(null);
		}
	}
	function getOutput()
	{
		if (xmlhttpAttr.readyState==4)
		{
			var resText = xmlhttpAttr.responseText;
			var resultText	= resText.split("##");
			var allowed	= resultText[1];

			if(allowed=='X')
			{
				var textMsg = 'One or more items in Cart may be flagged with "Not allowed in your Portfolio"! Click on the OK button if you want to change the Ship To?';
				$("#dialog-changeShipTo").dialog('open').text(textMsg);
			}
		}
	}

	function selectedShipTos()
	{
		var selShipTo=document.generalForm.selShipToInfo.value
		shipAddr	= selShipTo.split('е')[0]
		shipStreet	= selShipTo.split('е')[1]
		shipCity	= selShipTo.split('е')[2]
		shipState	= selShipTo.split('е')[3]
		shipCountry	= selShipTo.split('е')[4]
		shipZip		= selShipTo.split('е')[5]
		shipPhNum	= selShipTo.split('е')[6]
		shipCode	= selShipTo.split('е')[7]

		var accGroup = selShipTo.split('е')[8];	//shipCode.substring((shipCode.length)-4,shipCode.length);

		document.generalForm.shipToName.value = shipAddr
		document.generalForm.shipToStreet.value	= shipStreet
		document.generalForm.shipToCity.value = shipCity
		document.generalForm.shipToState.value = shipState	
		document.generalForm.shipToCountry.value = shipCountry
		document.generalForm.shipToZip.value = shipZip
		document.generalForm.shipToPhone.value = shipPhNum
		document.generalForm.selShipTo.value = shipCode
		document.generalForm.accGroup.value = accGroup

		if(accGroup=='CPDA')
		{
			document.getElementById("divShipToText").innerHTML = "";
			document.getElementById("divShipToText").style.display="none";
			document.getElementById("divShipToEnt").style.display="block";
			//document.getElementById("selShipToInfo").setCustomValidity('');

			var isResH = document.generalForm.isResHid.value;
			if(isResH=="NOSEL") isResH = "";

			if(isResH=="")
			{
				document.generalForm.shipToName.value = "";
				document.generalForm.shipToStreet.value	= "";
				document.generalForm.shipToCity.value = "";
				document.generalForm.shipToState.value = "";
				document.generalForm.shipToCountry.value = "";
				document.generalForm.shipToZip.value = "";
				document.generalForm.shipToPhone.value = "";
			}

			document.generalForm.isResidential.value = isResH;

			if(document.generalForm.isResidential.value=='')
				document.getElementById("isResidential").setCustomValidity('Please select the Residential');
			//else
				//document.getElementById("isResidential").setCustomValidity('');
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
			document.generalForm.isResidential.value = "";

			document.getElementById("divShipToText").style.display="block";
			document.getElementById("divShipToEnt").style.display="none";
		}

	}
	function selResidential()
	{
		if(document.generalForm.isResidential.value=='')
			document.getElementById("isResidential").setCustomValidity('Please select the Residential');
		else
			document.getElementById("isResidential").setCustomValidity('');
	}
	function selectedSoldTos()
	{
		Popup.showModal('modal');

		document.generalForm.action="../Sales/ezPrepareSalesOrder.jsp";
		document.generalForm.submit();
	}
	function goToCart(rulesapp)
	{
		Popup.showModal('modal');

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
			//document.generalForm.billToState.value="";
		}
		else
		{
			document.getElementById("divuseyourcarrier").style.display="block";

			var useCarr = document.generalForm.useMyCarrier.value;

			if(useCarr=='YES')
			{
				document.getElementById("divBillTo").style.display="block";
			}
		}
		selUseMyCarrier();
	}
	function selUseMyCarrier()
	{
		var flag = document.generalForm.useMyCarrier.value;
		var flag1 = document.generalForm.shipMethod.value;

		if(flag=='NO' || flag1=='STD')
		{
			document.getElementById("divBillTo").style.display="none";
			//document.generalForm.billToState.value="";
			document.getElementById("carrierId").setCustomValidity('');
			document.getElementById("billToName").setCustomValidity('');
			document.getElementById("billToStreet").setCustomValidity('');
			document.getElementById("billToCity").setCustomValidity('');
			document.getElementById("billToState").setCustomValidity('');
			document.getElementById("billToZipCode").setCustomValidity('');
		}
		else if(flag=='YES' && flag1!='STD')
		{
			document.getElementById("divBillTo").style.display="block";
			if(document.generalForm.carrierId.value=='')
				document.getElementById("carrierId").setCustomValidity('Please enter Carrier ID');
			else
				document.getElementById("carrierId").setCustomValidity('');
			if(document.generalForm.billToName.value=='')
				document.getElementById("billToName").setCustomValidity('Please enter Bill To Name');
			else
				document.getElementById("billToName").setCustomValidity('');
			if(document.generalForm.billToStreet.value=='')
				document.getElementById("billToStreet").setCustomValidity('Please enter Bill To Street');
			else
				document.getElementById("billToStreet").setCustomValidity('');
			if(document.generalForm.billToCity.value=='')
				document.getElementById("billToCity").setCustomValidity('Please enter Bill To City');
			else
				document.getElementById("billToCity").setCustomValidity('');
			if(document.generalForm.billToState.value=='')
				document.getElementById("billToState").setCustomValidity('Please enter Bill To State');
			else
				document.getElementById("billToState").setCustomValidity('');
			if(document.generalForm.billToZipCode.value=='')
				document.getElementById("billToZipCode").setCustomValidity('Please enter Bill To Zipcode');
			else
				document.getElementById("billToZipCode").setCustomValidity('');
		}
	}
	function openSearch(searchType)
	{
		var selSoldTo='';
		if(searchType=='SHIPTO')
			selSoldTo = document.generalForm.selSoldTo.value
		window.open("ezSearchPOP.jsp?searchType="+searchType+"&selSoldTo="+selSoldTo+"&chkBlock=Y",'name','height=475,width=800,left=200,top=100,location=no,resizable=no,scrollbars=no,toolbar=no,status=yes,z-lock=yes');
	}


	var xmlhttp;
	function getPricing()
	{
		var y = validateForm();

		if(eval(y))
		{
			xmlhttp = GetXmlHttpObject();

			if(xmlhttp==null)
			{
				alert ("Your browser does not support Ajax HTTP");
				return;
			}

			Popup.showModal('modal');

			var poNumber = document.generalForm.poNumber.value;
			var poDate   = document.generalForm.poDate.value;
			var selSoldTo= document.generalForm.selSoldTo.value;
			var selShipTo= document.generalForm.selShipTo.value;

			var url="../Sales/ezPONumCheck.jsp";
			//url=url+"?poNumber="+poNumber+"&selSoldTo="+selSoldTo+"&selShipTo="+selShipTo;
			var strVal="poNumber="+poNumber+"&poDate="+poDate+"&selSoldTo="+selSoldTo+"&selShipTo="+selShipTo;

			/*if(xmlhttp!=null)
			{
				xmlhttp.onreadystatechange=Process;
				xmlhttp.open("GET",url,true);
				xmlhttp.send(null);
			}*/
			if(xmlhttp!=null)
			{
				xmlhttp.onreadystatechange = Process;
				xmlhttp.open("POST", url, true);
				xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
				xmlhttp.send(strVal);
			}
			else
				Popup.hide('modal');
		}
	}
	function Process()
	{
		if(xmlhttp.readyState==4)
		{
			var resText = xmlhttp.responseText;
			var resultText	= resText.split("##");
			var poExists	= resultText[1];

			Popup.hide('modal');

			if(poExists=='X')
			{
				$( "#dialog-poexists" ).dialog('open');
			}
			else
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
	function validateForm()
	{
		var poNum 	= document.generalForm.poNumber.value;
		var shToInfo 	= document.generalForm.selShipToInfo.value;
		var isResid	= document.generalForm.isResidential.value;
		var shName 	= document.generalForm.shipToName.value;
		var shStreet 	= document.generalForm.shipToStreet.value;
		var shCity 	= document.generalForm.shipToCity.value;
		var shState 	= document.generalForm.shipToState.value;
		var shZip 	= document.generalForm.shipToZip.value;
		var shPhone 	= document.generalForm.shipToPhone.value;
		var accGroup	= document.generalForm.accGroup.value;
		var useMyCar 	= document.generalForm.useMyCarrier.value;
		var shMethod	= document.generalForm.shipMethod.value;

		if(trim(poNum)=="")
		{
			$( "#dialog-alert" ).dialog('open').text("Please enter PO Number");
			return false;
		}
		if(shToInfo=="еееееее")
		{
			$( "#dialog-alert" ).dialog('open').text("Please select Ship to ID");
			return false;
		}
		if(accGroup=="CPDA")
		{
			if(isResid=="")
			{
				$( "#dialog-alert" ).dialog('open').text("Please select the Residential");
				return false;
			}
			if(trim(shName)=="")
			{
				$( "#dialog-alert" ).dialog('open').text("Please enter Ship to Name");
				return false;
			}
			if(trim(shStreet)=="")
			{
				$( "#dialog-alert" ).dialog('open').text("Please enter Ship to Street");
				return false;
			}
			if(trim(shCity)=="")
			{
				$( "#dialog-alert" ).dialog('open').text("Please enter Ship to City");
				return false;
			}
			if(shState=="")
			{
				$( "#dialog-alert" ).dialog('open').text("Please select Ship to State");
				return false;
			}
			if(trim(shZip)=="")
			{
				$( "#dialog-alert" ).dialog('open').text("Please enter Ship to Zip");
				return false;
			}
			else if(!(trim(shZip).length==5 || trim(shZip).length==10))
			{
				$( "#dialog-alert" ).dialog('open').text("Zip code should be 5 or 10 digits");
				return false;
			}
			if(trim(shPhone)=="")
			{
				$( "#dialog-alert" ).dialog('open').text("Please enter Ship to Phone");
				return false;
			}
		}
		if(shMethod=="")
		{
			$( "#dialog-alert" ).dialog('open').text("Please select Shipping Method");
			return false;
		}
		else if(shMethod!="STD")
		{
			if(useMyCar=="YES")
			{
				if(trim(document.generalForm.carrierId.value)=='')
				{
					$( "#dialog-alert" ).dialog('open').text("Please enter Carrier ID");
					return false;
				}
				if(trim(document.generalForm.billToName.value)=='')
				{
					$( "#dialog-alert" ).dialog('open').text("Please enter Bill To Name");
					return false;
				}
				if(trim(document.generalForm.billToStreet.value)=='')
				{
					$( "#dialog-alert" ).dialog('open').text("Please enter Bill To Street");
					return false;
				}
				if(trim(document.generalForm.billToCity.value)=='')
				{
					$( "#dialog-alert" ).dialog('open').text("Please enter Bill To City");
					return false;
				}
				if(trim(document.generalForm.billToState.value)=='')
				{
					$( "#dialog-alert" ).dialog('open').text("Please enter Bill To State");
					return false;
				}
				if(trim(document.generalForm.billToZipCode.value)=='')
				{
					$( "#dialog-alert" ).dialog('open').text("Please enter Bill To Zipcode");
					return false;
				}
			}
		}
		return true;
	}
	function trim(str)
	{
		str = str.toString();
		var begin = 0;
		var end = str.length - 1;
		while (begin <= end && str.charCodeAt(begin) < 33) { ++begin; }
		while (end > begin && str.charCodeAt(end) < 33) { --end; }
		return str.substr(begin, end - begin + 1);
	}

$(function() {
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
});
</script>
<script type="text/javascript">
/*$.validator.setDefaults({
	submitHandler: function() { getPricing(); }
});
$.validator.addMethod("valueNotEquals", function(value, element, arg){
	return arg != value;
}, "Value must not equal arg.");*/

$(function() {
 	var cCnt = document.generalForm.cartCnt.value;
 	console.log("Attempt dialog confirm");
 	console.log(cCnt);
  	
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
	$( "#dialog-changeShipTo" ).dialog({
		autoOpen: false,
		resizable: true,
		height:164,
		width:584,
		modal: true,
		buttons: {
			"OK": function() {
				$( this ).dialog( "close" );
			}
		}
	});

  	$( "#dialog-poexists" ).dialog({
	  		autoOpen: false,
	  		resizable: true,
	  		height:200,
	  		width:400,
	  		modal: true,
	  		buttons: {
	  			"Correct It": function() {
	  				$( this ).dialog( "close" );
	  			},
	  			"Continue": function() {
					$( this ).dialog( "close" );
					Popup.showModal('modal');
					document.generalForm.action="../Sales/ezCreateSalesOrder.jsp";
					document.generalForm.submit();
	  			}
	  		}
	  	});

	if(cCnt==0)
	{
		$( "#dialog-confirm" ).dialog('open');
	}
	else
	{
		$( "#dialog-confirm" ).dialog('close');
	}
}); // end of function()




/*$().ready(function() {
	// validate signup form on keyup and submit

	var cCnt = document.generalForm.cartCnt.value;

	if(cCnt==0)
	{*/
		
		//jAlert('Please add the products to cart for placing an order','Alert Dialog');
		/*$(function() {
			$( "#dialog-confirm" ).dialog({
				resizable: false,
				height:200,
				modal: true,
				buttons: {
					"Ok": function() {
						$( this ).dialog( "close" );
					}
				}
			});
		});*/
	/*}
	else
	{
		$("#generalForm").validate({
			rules: {
				poNumber: "required",
				poDate: {
					required: true,
					date: true
				},
				selShipToInfo: { valueNotEquals: "еееееее" },
				isResidential: {
					required: "#onetimeshipto:selected"
				},
				shipToName: {
					required: "#onetimeshipto:selected"
				},
				shipToState: {
					required: "#onetimeshipto:selected"
				},
				shipToStreet: {
					required: "#onetimeshipto:selected"
				},
				shipToCity: {
					required: "#onetimeshipto:selected"
				},
				shipToZip: {
					required: "#onetimeshipto:selected"
				},
				shipToPhone: {
					required: "#onetimeshipto:selected"
				},
				carrierId: {
					required: "#selectedYes:selected"
				},
				billToName: {
					required: "#selectedYes:selected"
				},
				billToStreet: {
					required: "#selectedYes:selected"
				},
				billToCity: {
					required: "#selectedYes:selected"
				},
				billToState: {
					required: "#selectedYes:selected"
				},
				billToZipCode: {
					required: "#selectedYes:selected"
				}
			},
			messages: {
				poNumber: "<font color=red>Please enter PO Number</font>",
				poDate: "<font color=red>Please enter PO Date</font>",
				selShipToInfo: { valueNotEquals: "<font color=red>Please select Ship To ID</font>"},
				isResidential: "<font color=red>Please select Residential Status</font>",
				shipToName: "<font color=red>Please provide Name</font>",
				shipToState: "<font color=red>Please provide State</font>",
				shipToStreet: "<font color=red>Please provide Street</font>",
				shipToCity: "<font color=red>Please provide City</font>",
				shipToZip: "<font color=red>Please provide Zipcode</font>",
				shipToPhone: "<font color=red>Please provide Phone No</font>",
				carrierId: "<font color=red>Please enter Carrier ID</font>",
				billToName: "<font color=red>Please enter Bill To Name</font>",
				billToStreet: "<font color=red>Please enter Bill To Street</font>",
				billToCity: "<font color=red>Please enter Bill To City</font>",
				billToState: "<font color=red>Please enter Bill To State</font>",
				billToZipCode: "<font color=red>Please enter Bill To Zipcode</font>"
			}
		});
	}
});*/
</script>
<form name="generalForm" id="generalForm" method="post" >
<input type=hidden name="rulappl">
<input type=hidden name="rulesCust">
<input type=hidden name="webOrdNo" value="<%=request.getParameter("webOrdNo")%>">
<input type=hidden name="cartCnt" value="<%=cartRows%>">
<input type=hidden name="accGroup">
<div id="modal" style="border:0px solid black; background-color:white; padding:1px; font-size:10;width:40%;height:180px; text-align:center; display:none;">
	<ul>
		<li>&nbsp;</li>
		<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
		<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
	</ul>
</div>
<div style="display:none;">
<div id="dialog-alert" title="Alert">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;display:none;"></span>Please fill out this field.</p>
</div>
</div>
<div class="main-container col2-layout middle account-pages">
<div class="main">
<div id="dialog-confirm" title="Empty Cart" style="display:none">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Please add the products to cart for placing an order</p>
</div>
<div id="dialog-poexists" title="PO Number Check" style="display:none">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Your account shows same PO number, PO date and ship-to exists in ASB system. Please choose appropriate action.</p>
</div>
<div id="dialog-changeShipTo" title="Confirmation" style="display:none"></Div>
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
						<font size='5' color='black'>&nbsp;&nbsp;CONFIRM HEADER INFO</font>
					</td>
				</tr>
				</tbody>
			</table>
			</td>
		</tr>
		</tbody>
		</table>
	</div>
</div>
<br>
	<div class="col2-set">
		<div class="col-1">
			<button type="button" title="Back" class="button btn-black" onclick="javascript:goToCart('<%=rulesApply%>')"><span class="left-link">Back</span></button>
		</div>
		
<%
		if(!"Y".equals(rulesApply) && cartRows>0)
		{
%>
			<div class="col-2">
				<button type="button" title="Next" class="button btn-black" onclick="getPricing()"><span class="right-link">Next</span></button>
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
	<p style="padding-top: 10px;padding-bottom: 10px;">Enter your PO Information here. It is critical for searching Orders quickly</p>
	<ul class="form-list">
		<li><label for="ponumber" class="required">PO Number<em>*</em></label>
			<div class="input-box">
				<input style="text-transform: uppercase" type="text" id="poNumber" name="poNumber"  maxlength="20" style="width:100%" value="<%=poNumber%>" required>
			</div>
		</li>
		<li><label for="podate" class="required">PO Date<em>*</em></label>
			<div class="input-box">
				<input type="text" id="poDate" name="poDate"  size="12" value="<%=poDate%>" readonly required><%=getDateImage("poDate")%>
			</div>
		</li>
<%
		String showNAMsg = "";
		String showEDD = "";
		if("QS".equals(itemProgType_C) || "Z1".equals(itemOrdType_C))
		{
			desiredDate = "";
			showNAMsg = "<font color='red'><br>(Not Applicable)</font>";
		}
		else
		{
			showEDD = getDateImageFromTomorrow("desiredDate");
		}
%>
		<li><label for="desiredDate" >Expected Delivery Date<%=showNAMsg%></label>
			<div class="input-box">
				<input type="text" id="desiredDate" name="desiredDate" size="12" value="<%=desiredDate%>" readonly><%=showEDD%>
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
	<li style="padding-top: 10px">
		<label for="soldtoname" >Sold To ID </label>
		<div class="input-box" style="width:290px !important;">
		<div>
		<select name="selSoldTo" onChange="selectedSoldTos()">
<%
		boolean qCustomer = false;
		if(retsoldto_A!=null)
		{
			if(!"".equals(quoteSoldTo))
			{
				selSoldTo = quoteSoldTo;
				qCustomer = true;
			}

			for(int i=0;i<retsoldto_A.getRowCount();i++)
			{
				String blockCode_A 	= retsoldto_A.getFieldValueString(i,"ECA_EXT1");
				if(blockCode_A==null || "null".equalsIgnoreCase(blockCode_A)) blockCode_A = "";

				if(!"BL".equalsIgnoreCase(blockCode_A))
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
					if(!qCustomer)
					{
%>
					<option value="<%=soldToCode_A%>" <%=selected_A%>><%=soldToName_A%> : <%=soldToCode_A%></option>
<%
					}
					else if(qCustomer && "selected".equals(selected_A))
					{
%>
					<option value="<%=soldToCode_A%>" <%=selected_A%>><%=soldToName_A%> : <%=soldToCode_A%></option>
<%
					}
				}
			}
		}
%>
		</select>
<%
		if(!qCustomer)
		{
%>
		<a href="javascript:openSearch('SOLDTO')"><img height="20px" width="20px" src="../../Images/search2.png"></a>
<%
		}
%>
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
	String dropShipName = "";

	if(defShipToName==null || "null".equalsIgnoreCase(defShipToName))
	{
		defShipToName = request.getParameter("shipToName");
		if(defShipToName==null || "null".equalsIgnoreCase(defShipToName)) defShipToName = "";
	}
	if(defShipAddr1==null || "null".equalsIgnoreCase(defShipAddr1))
	{
		defShipAddr1 = request.getParameter("shipToStreet");
		if(defShipAddr1==null || "null".equalsIgnoreCase(defShipAddr1)) defShipAddr1 = "";
	}
	if(defShipAddr2==null || "null".equalsIgnoreCase(defShipAddr2))
	{
		defShipAddr2 = request.getParameter("shipToCity");
		if(defShipAddr2==null || "null".equalsIgnoreCase(defShipAddr2)) defShipAddr2 = "";
	}
	if(defShipState==null || "null".equalsIgnoreCase(defShipState))
	{
		defShipState = request.getParameter("shipToState");
		if(defShipState==null || "null".equalsIgnoreCase(defShipState)) defShipState = "";
	}
	if(defShipCountry==null || "null".equalsIgnoreCase(defShipCountry))
	{
		defShipCountry = request.getParameter("shipToCountry");
		if(defShipCountry==null || "null".equalsIgnoreCase(defShipCountry)) defShipCountry = "";
	}
	if(defShipZip==null || "null".equalsIgnoreCase(defShipZip))
	{
		defShipZip = request.getParameter("shipToZip");
		if(defShipZip==null || "null".equalsIgnoreCase(defShipZip)) defShipZip = "";
	}
	if(defShipPhNum==null || "null".equalsIgnoreCase(defShipPhNum))
	{
		defShipPhNum = request.getParameter("shipToPhone");
		if(defShipPhNum==null || "null".equalsIgnoreCase(defShipPhNum)) defShipPhNum = "";
	}
	if(defShipToCode==null || "null".equalsIgnoreCase(defShipToCode))
	{
		defShipToCode = request.getParameter("selShipTo");
		if(defShipToCode==null || "null".equalsIgnoreCase(defShipToCode)) defShipToCode = "";
	}
%>
	<h2 class="legend" style="background-color:#EEEDE7">Ship To Address </h2>
	<ul class="form-list">
	<li style="padding-top: 10px">
		<label for="soldtoname" class="required">Ship To ID<em>*</em></label>
		<div class="input-box" style="width:290px !important;">
		<div>
		<select name="selShipToInfo" id="selShipToInfo" onChange="selectedShipTos(); checkdefShipto();" onKeyDown="selectedShipTos(); checkdefShipto();">
			<option value="еееееее">------Select------</option>
<%
		int listShipCnt = listShipTosCS.getRowCount();
		for(int l=0;l<listShipCnt;l++)
		{
			String blockCode_A 	= listShipTosCS.getFieldValueString(l,"ECA_EXT1");
			if(blockCode_A==null || "null".equalsIgnoreCase(blockCode_A)) blockCode_A = "";

			if(!"BL".equalsIgnoreCase(blockCode_A))
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
				shipState 	= (shipState==null || "null".equals(shipState) || "".equals(shipState))?"":shipState;
				shipCountry 	= (shipCountry==null || "null".equals(shipCountry)|| "".equals(shipCountry))?"":shipCountry.trim();
				shipZip 	= (shipZip==null || "null".equals(shipZip)|| "".equals(shipZip))?"N/A":shipZip;
				shipPhNum 	= (shipPhNum==null || "null".equals(shipPhNum)|| "".equals(shipPhNum))?"N/A":shipPhNum;
				dropShipName	= shipToName;

				//String tempShip = shipToCode.substring(shipToCode.length()-4,shipToCode.length());
				String tempShip = listShipTosCS.getFieldValueString(l,"ECA_ACCOUNT_GROUP");

				//if(shipToCode.endsWith("9999"))	shipToName = "";
				if("CPDA".equalsIgnoreCase(tempShip))	shipToName = "";

				String shipParams = shipToName+"е"+shipAddr1+"е"+shipAddr2+"е"+shipState+"е"+shipCountry+"е"+shipZip+"е"+shipPhNum+"е"+shipToCode+"е"+tempShip;

				String selected_A = "";
				String onetime_A = "";

				if((listShipCnt==1) || ((listShipCnt==2) && !"CPDA".equalsIgnoreCase(tempShip)))
				{
					selected_A = "selected";
					selShipParams = shipParams;
				}

				if("CPDA".equalsIgnoreCase(tempShip))
				{
					onetime_A = "id=\"onetimeshipto\" name=\"onetimeshipto\"";
					dropShipName = "Drop Ship";
					shipParams = defShipToName+"е"+defShipAddr1+"е"+defShipAddr2+"е"+defShipState+"е"+defShipCountry+"е"+defShipZip+"е"+defShipPhNum+"е"+shipToCode+"е"+tempShip;
					//shipParams = "еееееее"+shipToCode+"е"+tempShip;
				}
				if(selShipToCode!=null && selShipToCode.equals(shipToCode))
				{
					selected_A = "selected";
					selShipParams = shipParams;
				}
%>
				<option value="<%=shipParams%>" <%=selected_A%> <%=onetime_A%>><%=dropShipName%> : <%=shipToCode%></option>
<%
			}
		}

	try
	{
		if("".equals(defShipToName))
		{
			defShipToName = selShipParams.split("е")[0];
		}
		if("".equals(defShipAddr1))
		{
			defShipAddr1 = selShipParams.split("е")[1];
		}
		if("".equals(defShipAddr2))
		{
			defShipAddr2 = selShipParams.split("е")[2];
		}
		if("".equals(defShipState))
		{
			defShipState = selShipParams.split("е")[3];
		}
		if("".equals(defShipCountry))
		{
			defShipCountry = selShipParams.split("е")[4];
		}
		if("".equals(defShipZip))
		{
			defShipZip = selShipParams.split("е")[5];
		}
		if("".equals(defShipPhNum))
		{
			defShipPhNum = selShipParams.split("е")[6];
		}
		if("".equals(defShipToCode))
		{
			defShipToCode = selShipParams.split("е")[7];
		}
	}
	catch(Exception e){}
%>
		</select>
		<a class="fancybox" href="javascript:openSearch('SHIPTO')"><img height="20px" width="20px" src="../../Images/search2.png"></a>
		<input type="hidden" name="selShipTo" value="<%=defShipToCode%>">
		<input type="hidden" name="shipToCountry" value="<%=defShipCountry%>">
		</div>
		<div id="divShipToText"> <!--style="display:none"-->
		</div>
		</div>
	</li>
	<div id="divShipToEnt" style="display:none">
<%
	if(isResidential==null || "null".equalsIgnoreCase(isResidential))
	{
		isResidential = request.getParameter("isResidential");

		if(isResidential==null || "null".equalsIgnoreCase(isResidential)) isResidential = "";
	}

	String selected_SN = "selected";
	String selected_RN = "";
	String selected_RY = "";

	if("YES".equals(isResidential))
	{
		selected_SN = "";
		selected_RN = "";
		selected_RY = "selected";
	}
	else if("NO".equals(isResidential))
	{
		selected_SN = "";
		selected_RN = "selected";
		selected_RY = "";
	}
%>
	<li>
		<input type="hidden" name="isResHid" value="<%=isResidential%>">
		<label for="isResidential" class="required">Is It Residential<em>*</em> </label>
		<div class="input-box">
		<div>
		<select id="isResidential" name="isResidential" title="Is-It-Residential" STYLE="width: 90px" onchange="selResidential()">//onchange="selUseMyCarrier()" 
			<option value="" <%=selected_SN%>>--Select--</option>
			<option value="YES" <%=selected_RY%>>Yes</option>
			<option value="NO" <%=selected_RN%>>No</option>
		</select>
		</div>
		</div>
	</li>
	<li>
		<label for="shipToName" class="required">Ship To Name<em>*</em> </label>
		<div class="input-box">
			<input type="text" id="shipToName" name="shipToName" style="width:100%" maxlength="100" value="<%=defShipToName%>" required>
		</div>
	</li>
	<li>
		<label for="shipToStreet" class="required">Street 1<em>*</em></label>
		<div class="input-box">
			<input type="text" id="shipToStreet" name="shipToStreet" style="width:100%" maxlength="100" value="<%=defShipAddr1%>" required>
		</div>
	</li>
	<li>
		<label for="city-state-zip" class="required">City<em>*</em></label>
		<div class="input-box">
			<input type="text" id="shipToCity" name="shipToCity" style="width:100%" maxlength="40" value="<%=defShipAddr2%>" required>
		</div>
	</li>
	<li>
		<label for="city-state-zip" class="required">State<em>*</em></label>
		<div class="input-box">
			<select name="shipToState" id="shipToState" required>
<%
			if(stateRetRes!=null)
			{
				for(int i=0;i<stateRetRes.getRowCount();i++)
				{
					String shipToStateCode 	= stateRetRes.getFieldValueString(i,"STATECODE");
					String shipToStateName 	= stateRetRes.getFieldValueString(i,"STATENAME");

					String selected_A = "selected";

					if(defShipState!=null && defShipState.equals(shipToStateCode))
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
	</li>
	<li>
		<label for="city-state-zip" class="required">Zip<em>*</em></label>
		<div class="input-box">
			<input type="text" id="shipToZip" name="shipToZip" style="width:100%" maxlength="20" value="<%=defShipZip%>" required>
		</div>
	</li>
	<li>
		<label for="shipToPhone" class="required">Phone<em>*</em></label>
		<div class="input-box">
			<input type="text" id="shipToPhone" name="shipToPhone" style="width:100%" maxlength="16" value="<%=defShipPhNum%>" required>
		</div>
	</li>
	</div>
	<!--<li>
		<label for="shipToPhone" class="required">Phone </label>
		<div class="input-box">
			<input type="text" id="shipToPhone" name="shipToPhone" style="width:100%" value="<%//=defShipPhNum%>">
		</div>
	</li>-->
		<h2 class="legend" style="background-color:#EEEDE7">Promotions </h2>
		<li style="padding-top: 10px">
			<label for="promocode" class="required">Promo Code</label>
			<div class="input-box">
				<input style="text-transform: uppercase" type="text" id="promoCode" name="promoCode" style="width:100%" maxlength=2 value="<%=promoCode%>">
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
<div class="col-2">
<div class="info-box">
<%
	if(shipMethod==null || "null".equalsIgnoreCase(shipMethod) || "".equals(shipMethod.trim()))
	{
		shipMethod = request.getParameter("shipMethod");

		if(shipMethod==null || "null".equalsIgnoreCase(shipMethod) || "".equals(shipMethod.trim())) shipMethod = "STD";
	}
	if(carrierName==null || "null".equalsIgnoreCase(carrierName)) carrierName = "";
	if(useMyCarrier==null || "null".equalsIgnoreCase(useMyCarrier))
	{
		useMyCarrier = request.getParameter("useMyCarrier");

		if(useMyCarrier==null || "null".equalsIgnoreCase(useMyCarrier)) useMyCarrier = "";
	}
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
<p style="padding-top: 10px;padding-bottom: 10px;">Enter Desired Shipping Method here. If you wish to use your account with carrier, provide details.  <font color=red>Any order placed after 11:00 AM EST for premium services (other than "Best Way") ships next day. The estimated delivery date displayed may differ.</font></p>
	<ul class="form-list">
	<li>
		<label for="shipMethod" class="required">Shipping Method<em>*</em> </label>
		<div class="input-box">
		<div>
		<select id="shipMethod" name="shipMethod" title="shipping-method" onChange="selShipMethod()">
<%
		Map sortedMap = new TreeMap(shipMethodHM);

		Set shipCol = sortedMap.entrySet();
		Iterator shipColIte = shipCol.iterator();

		ArrayList quickShip_M = new ArrayList();
		if(quickShip)
		{
%>
			<option value="">------Select------</option>
<%
			quickShip_M.add("FEGC");
			quickShip_M.add("FE1C");
			quickShip_M.add("FE2C");
			quickShip_M.add("UPGC");
			quickShip_M.add("UP1C");
			quickShip_M.add("UP2C");
		}

                while(shipColIte.hasNext())
                {
			Map.Entry shipColData = (Map.Entry)shipColIte.next();

			String shipMethodCode = (String)shipColData.getKey();
			String shipMethodDesc = (String)shipColData.getValue();

			String selected_A = "";

			if(shipMethod.equals(shipMethodCode))
				selected_A = "selected";

			if(quickShip)
			{
				if(quickShip_M.contains(shipMethodCode))
				{
%>
				<option value="<%=shipMethodCode%>" <%=selected_A%>><%=shipMethodDesc%></option>
<%
				}
			}
			else
			{
%>
			<option value="<%=shipMethodCode%>" <%=selected_A%>><%=shipMethodDesc%></option>
<%
			}
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

		if("YES".equals(useMyCarrier))
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
		<select id="useMyCarrier" name="useMyCarrier" title="use-carrier" onchange="selUseMyCarrier();" STYLE="width: 60px">
			<option value="NO" <%=selected_N%>>No</option>
			<option value="YES" id="selectedYes" <%=selected_Y%>>Yes</option>
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
			<input type="text" id="carrierId" name="carrierId" style="width:100%" maxlength="10" value="<%=carrierId%>" onblur="selUseMyCarrier();">
		</div>
	</li>
	<li>
		<label for="billToName" class="required">Bill To Name<em>*</em></label>
		<div class="input-box">
			<input type="text" id="billToName" name="billToName" style="width:100%" maxlength="20" value="<%=billToName%>" onblur="selUseMyCarrier();">
		</div>
	</li>
	<li>
		<label for="billToStreet" class="required">Street 1<em>*</em> </label>
		<div class="input-box">
			<input type="text" id="billToStreet" name="billToStreet" style="width:100%" maxlength="20" value="<%=billToStreet%>" onblur="selUseMyCarrier();">
		</div>
	</li>
	<li>
		<label for="billToCity" class="required">City<em>*</em> </label>
		<div class="input-box">
			<input type="text" id="billToCity" name="billToCity" style="width:100%" maxlength="40" value="<%=billToCity%>" onblur="selUseMyCarrier();">
		</div>
	</li>
	<li>
		<label for="billToState" class="required">State<em>*</em> </label>
		<div class="input-box">
		<div>
		<select id="billToState" name="billToState" title="Bill To State" onchange="selUseMyCarrier();">
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
			<input type="text" id="billToZipCode" name="billToZipCode" style="width:100%" maxlength="10" value="<%=billToZipCode%>" onblur="selUseMyCarrier();">
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
	<h2 class="legend" style="background-color:#EEEDE7" >Order Shipping Instructions </h2>
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
<script>
	selectedShipTos()
	checkdefShipto()
	selShipMethod()
</script>
<br>
	<div class="col2-set">
		<div class="col-1">
			<button type="button" title="Back" class="button btn-black" onclick="javascript:goToCart('<%=rulesApply%>')"><span class="left-link">Back</span></button>
		</div>
		
<%
		if(!"Y".equals(rulesApply) && cartRows>0)
		{
%>
			<div class="col-2">
				<button type="button" title="Next" class="button btn-black" onclick="getPricing()"><span class="right-link">Next</span></button>
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
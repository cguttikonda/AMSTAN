<%@ page import ="ezc.customer.invoice.params.*" %>
<%@ page import ="ezc.ezparam.*,ezc.client.*,java.util.*"%>
<!-- Style for New Header -->
<style type="text/css">
.highlight {
		height: 80px;
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
  	String canReqType = request.getParameter("canReqType");
  	String fromPage   = request.getParameter("fromPage");
  	String requestor = "";//request.getParameter("requestor");
	String reqdate = "";//request.getParameter("reqdate");

	ReturnObjFromRetrieve valueMapObj = null;

	ezc.ezparam.EzcParams valueMapMainParams = new ezc.ezparam.EzcParams(false);
	EziMiscParams valueMapMiscParams = new EziMiscParams();
	valueMapMiscParams.setIdenKey("MISC_SELECT");
	String valueMapQuery="SELECT * from EZC_VALUE_MAPPING WHERE MAP_TYPE='REJREASONS'";
	valueMapMiscParams.setQuery(valueMapQuery);
	valueMapMainParams.setLocalStore("Y");
	valueMapMainParams.setObject(valueMapMiscParams);
	Session.prepareParams(valueMapMainParams);	

	try
	{
		valueMapObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(valueMapMainParams);
	}
	catch(Exception e){out.println("Exception in Reading Value Mapping Table"+e);}

  	Hashtable rejReasonHT = new Hashtable();

	if(valueMapObj!=null && valueMapObj.getRowCount()>0)
	{
		for (int vm=0;vm<valueMapObj.getRowCount();vm++)
		{
			String reasCode = valueMapObj.getFieldValueString(vm,"VALUE1");
			String reasDesc = valueMapObj.getFieldValueString(vm,"VALUE2");
			rejReasonHT.put(reasCode,reasDesc);
		} // end for vm
	} // end if valueMapObj

 	String cancellationId = request.getParameter("cancellationId");
	ReturnObjFromRetrieve retCancelReqObj = null;

	ezc.ezparam.EzcParams reqMainParams = new ezc.ezparam.EzcParams(false);
	EziMiscParams reqMiscParams = new EziMiscParams();
	reqMiscParams.setIdenKey("MISC_SELECT");
	String query="SELECT (SELECT DISTINCT ESCI_BACK_END_ORDER + ' ' as [text()] FROM EZC_SO_CANCEL_ITEMS WHERE ESCI_ID = ESCH_ID FOR XML PATH('')) RGAID,ESCH_TYPE, ESCH_PO_NUM,ESCH_SO_NUM,ESCH_SOLD_TO,ESCH_SYSKEY,(SELECT TOP 1 EU_FIRST_NAME+' '+EU_LAST_NAME FROM EZC_USERS WHERE EU_ID=ESCH_CREATED_BY) ESCH_CREATED_BY,ESCH_CREATED_BY USER_ID,ESCH_CREATED_ON,ESCH_STATUS, ESCH_ID,ESCH_CONTACT_NAME, ESCH_CONTACT_EMAIL, ESCH_CONTACT_PHONE, ESCH_CUST_TEXT, ESCH_REASON,ESCH_SAP_REASON,ESCH_INCO_TERM1,ESCH_INCO_TERM2,ESCH_SHIPPING_PARTNER,ESCH_SHIP_TO,ESCH_SHIP_TO_RES,ESCH_SHIP_TO_NAME,ESCH_SHIP_TO_STREET1,ESCH_SHIP_TO_STREET2,ESCH_SHIP_TO_CITY,ESCH_SHIP_TO_STATE,ESCH_SHIP_TO_ZIP,ESCH_SHIP_TO_PHONE,ESCH_SHIP_TO_COUNTRY,ESCH_HEADER_FEES_TYPE,ESCH_HEADER_FEES_VALUE,ESCH_INTERNAL_TEXT,ESCH_APPROVER_NOTE,ESCH_EXPIRE_ON, ESCI_SO_NUM,ESCI_SO_ITEM,ESCI_MAT_CODE,ESCI_MAT_DESC,ESCI_QUANTITY,ESCI_REJ_REASON,ESCI_COMMENTS,ESCI_TYPE,ESCI_STATUS,ESCI_EXT1,ESCI_EXT2,ESCI_EXT3,ESCI_RET_MAT,ESCI_RET_QTY,ESCI_RETMAT_NP,ESCI_SO_SORG,ESCI_SO_DCH,ESCI_SO_DIV,ESCI_INV_NUM,ESCI_INV_ITEM,ESCI_PLANT,ESCI_BACK_END_ORDER FROM EZC_SO_CANCEL_ITEMS, EZC_SO_CANCEL_HEADER WHERE  ESCI_ID = "+cancellationId+" AND ESCI_ID = ESCH_ID" ;//ESCI_STATUS = '"+canReqType+"' AND 
	reqMiscParams.setQuery(query);
	reqMainParams.setLocalStore("Y");
	reqMainParams.setObject(reqMiscParams);
	Session.prepareParams(reqMainParams);	

	try
	{
		retCancelReqObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(reqMainParams);
	}
	catch(Exception e){}

	int retCancelReqObjCnt =0;
	String soldToCode = "";
	String rejectNotes = "";

	if(retCancelReqObj!=null)
	{
		retCancelReqObjCnt = retCancelReqObj.getRowCount();
		requestor = retCancelReqObj.getFieldValueString(0,"USER_ID");
		reqdate = retCancelReqObj.getFieldValueString(0,"ESCH_CREATED_ON");
		soldToCode = retCancelReqObj.getFieldValueString(0,"ESCH_SOLD_TO");
		canReqType = retCancelReqObj.getFieldValueString(0,"ESCH_STATUS");
		rejectNotes = retCancelReqObj.getFieldValueString(0,"ESCH_APPROVER_NOTE");

		if (requestor == null || requestor.equals("null")){
			requestor = "";
		}	
		if (reqdate == null) {
			Date dateNow = new Date ();
			SimpleDateFormat format = new SimpleDateFormat("MM/dd/yyyy hh:mm a");  
			reqdate = format.format(dateNow);
		}
	}
%>
<!--<script src="http://code.jquery.com/jquery-latest.js"></script>-->
<script type="text/javascript" src="../../Library/Script/complete.min.js"></script>
<script type="text/javascript" src="../../Library/Script/jquery-ui-1.8.21.all.min.js"></script>

<!-- fancy box popup instead of original from rb -->
<link rel="stylesheet" href="../../Library/Script/jquery.fancybox.css?v=2.0.5" type="text/css" media="screen" />
<script type="text/javascript" src="../../Library/Script/jquery.fancybox.pack.js?v=2.0.5"></script>
<!-- end of fancybox -->

<link rel="stylesheet" type="text/css" href="../../Library/Styles/formalize.css">
<script type="text/javascript" src="../../Library/Script/jquery.formalize.js"></script>
<!--<script type="text/javascript" src="../../Library/Script/jquery.validate.js"></script>-->

<Script src="../../Library/Script/popup.js"></Script>
<Script src="../../Library/Script/sisyphus.min.js"></Script>
<Script src="../../Library/Script/html5shiv.js"></Script>

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
<script type="text/javascript">
function getProductDetails(code)
{
	document.generalForm.prodCode_D.value=code;

	document.generalForm.action="../Catalog/ezProductDetails.jsp";
	document.generalForm.target="_blank";
	document.generalForm.submit();
}
function funSubmitCR(actionType)
{
	var lStat = actionType;

	document.generalForm.actionType.value=lStat;	//actionType;

	if(actionType=='R')
	{
		var aNote = document.getElementById("rejRCComments").value;
		aNote = aNote.replace("'","`")
		aNote = aNote.trim();
		if(aNote=='')
		{
			alert("Please Enter Your Comments");
			return;
		}
		else
		{
			document.getElementById("rejRCComments").value = aNote;
			document.generalForm.rejRCCom.value = aNote;
		}
	}
	Popup.showModal('modal1');
	document.generalForm.action="ezProcessSubmittedReqMain.jsp";
	document.generalForm.submit();
	parent.$.fancybox.close();
}
function funSubmit(actionType)
{

	var y = validateForm();

	if(eval(y))
	{	
		var len = <%=retCancelReqObjCnt%>;
		var lStat = actionType;

		if(actionType=='A')
		{
			if(!isNaN(len))
			{
				for(i=0;i<len;i++)
				{
					var lNo = "";

					if(len==1)
						lNo = document.generalForm.lineId.value;
					else
						lNo = document.generalForm.lineId[i].value;

					lStat = eval("document.generalForm.lineStatus"+lNo).value;

					if(lStat=='A')
						break;
				}
			}
		}

		document.generalForm.actionType.value=lStat;	//actionType;

		Popup.showModal('modal1');
		document.generalForm.action="ezProcessSubmittedReqMain.jsp";
		document.generalForm.submit();
	}	
}
function validateForm()
{
	var selShipToInfo 	= document.generalForm.selShipToInfo.value;
	var shipToName 		= document.generalForm.shipToName.value;
	var shipToStreet 	= document.generalForm.shipToStreet.value;
	var shipToCity 		= document.generalForm.shipToCity.value;
	var shipToState 	= document.generalForm.shipToState.value;
	var shipToZip 		= document.generalForm.shipToZip.value;
	var shipToPhone 	= document.generalForm.shipToPhone.value;
	var orderReason 	= document.generalForm.orderReason.value;
	var lineId 		= document.generalForm.lineId;
	var isResidential 	= document.generalForm.isResidential.value;
	var accGroup = selShipToInfo.split('е')[8];

	if(selShipToInfo=="еееееее")
	{
		$( "#dialog-alert" ).dialog('open').text("Please select Ship To ID");
		document.generalForm.selShipToInfo.focus();
		return false;
	}
	if(accGroup=='CPDA')
	{
		if(isResidential=="")
		{
			$( "#dialog-alert" ).dialog('open').text("Please Select Residential Status");
			document.generalForm.isResidential.focus();
			return false;
		}
		if(shipToName=="")
		{
			$( "#dialog-alert" ).dialog('open').text("Please Provide Name");
			document.generalForm.shipToName.focus();
			return false;
		}
		if(shipToStreet=="")
		{
			$( "#dialog-alert" ).dialog('open').text("Please Provide Street");
			document.generalForm.shipToStreet.focus();
			return false;
		}	
		if(shipToCity=="")
		{
			$( "#dialog-alert" ).dialog('open').text("Please Provide City");
			document.generalForm.shipToCity.focus();
			return false;
		}	
		if(shipToState=="")
		{
			$( "#dialog-alert" ).dialog('open').text("Please Provide State");
			document.generalForm.shipToState.focus();
			return false;
		}
		if(shipToZip=="")
		{
			$( "#dialog-alert" ).dialog('open').text("Please Provide Zipcode");
			document.generalForm.shipToZip.focus();
			return false;
		}
		if(shipToPhone=="")
		{
			$( "#dialog-alert" ).dialog('open').text("Please Provide Phone Number");
			document.generalForm.shipToPhone.focus();
			return false;
		}
	}	
	if(orderReason=="")
	{
		$( "#dialog-alert" ).dialog('open').text("Please Select Order Reason");
		document.generalForm.orderReason.focus();
		return false;
	}

	for(a=0;a<lineId.length;a++)
	{
		var line = lineId[a].value;

		var lineStatus = eval("document.generalForm.lineStatus"+line);
		var retMat = eval("document.generalForm.retMat_"+line);

		if(retMat.value == "")
		{
			$( "#dialog-alert" ).dialog('open').text("Please Enter Material Returned");
			retMat.focus();
			return false;
		}
		if(lineStatus.value == "")
		{
			$( "#dialog-alert" ).dialog('open').text("Please Select Status");
			lineStatus.focus();
			return false;
		}
	}
		
	return true;
}
function funPrintRGA(rgaId)
{
	document.generalForm.rgaNumber.value = rgaId;

	document.generalForm.action = "ezRGAPrint.jsp";
	document.generalForm.target = "_parent";
	document.generalForm.submit();
}
function funBackSubmit()
{
<%
	if("P".equals(canReqType) && !"Y".equals(fromPage))
	{
%>
		document.generalForm.action = 'ezCancellationRequestsMain.jsp';
<%
	}
	else if("A".equals(canReqType) && !"Y".equals(fromPage))
	{
%>
		document.generalForm.action = 'ezProcessedRequestsMain.jsp';
<%
	}
	else if(("R".equals(canReqType) || "CA".equals(canReqType)) && !"Y".equals(fromPage))
	{
%>
		document.generalForm.action = 'ezRejectedRequestsMain.jsp';
<%
	}
	else if("Y".equals(fromPage))
	{
%>
		document.generalForm.action = '../Search/ezQuickSearchDetailsMain.jsp';
<%
	}
%>	
	Popup.showModal('modal1');
	document.generalForm.submit();
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

	var accGroup = selShipTo.split('е')[8]; //shipCode.substring((shipCode.length)-4,shipCode.length);

	document.generalForm.shipToName.value = shipAddr
	document.generalForm.shipToStreet.value	= shipStreet
	document.generalForm.shipToCity.value = shipCity
	document.generalForm.shipToState.value = shipState	
	document.generalForm.shipToCountry.value = shipCountry
	document.generalForm.shipToZip.value = shipZip
	document.generalForm.shipToPhone.value = shipPhNum
	document.generalForm.selShipTo.value = shipCode

	if(accGroup=='CPDA')
	{
		document.getElementById("divShipToText").innerHTML = "";
		document.getElementById("divShipToText").style.display="none";
		document.getElementById("divShipToEnt").style.display="block";
		document.getElementById("selShipToInfo").setCustomValidity('');
		document.generalForm.dropShipTo.value = "YES";

		if(document.generalForm.isResidential.value=='')
			document.getElementById("isResidential").setCustomValidity('Please select the Residential');
		else
			document.getElementById("isResidential").setCustomValidity('');
	}
	else
	{
		document.generalForm.dropShipTo.value = "NO";
		if(selShipTo=='еееееее')
		{
			document.getElementById("divShipToText").innerHTML = "";
			document.getElementById("selShipToInfo").setCustomValidity('Please select Ship To ID');
		}
		else
		{
			var shipInfo = "<br>"+shipAddr+"<br>"+shipStreet+"<br>"+shipCity+" "+shipState+", "+shipZip+" "+shipCountry+"<br>"+shipPhNum;
			document.getElementById("divShipToText").innerHTML = shipInfo;
			document.getElementById("selShipToInfo").setCustomValidity('');
		}

		document.getElementById("divShipToText").style.display="block";
		document.getElementById("divShipToEnt").style.display="none";
	}
}
function openSearch(searchType)
{
	var selSoldTo='';
	if(searchType=='SHIPTO')
		selSoldTo = document.generalForm.soldTo.value
	window.open("ezSearchPOP.jsp?searchType="+searchType+"&selSoldTo="+selSoldTo,'name','height=475,width=800,left=200,top=100,location=no,resizable=no,scrollbars=no,toolbar=no,status=yes,z-lock=yes');
}
function stockFeeItemLevel(stockObj,lItem)
{
	alert("test");
	var len = <%=retCancelReqObjCnt%>;
	var feeType	= document.getElementById("restockFeesType").value;
	var sTot 	= document.getElementById("subTotalAll").innerHTML;
	var perVal = 0;
	
	var rVal 	= (document.getElementById("restockFees").value).trim();
	if(rVal=='') rVal = "0.00";

	if(feeType=='PER')
	{
		alert("test");
		
		for (i=0; i<len; i++)
		{	 
			var npLItemVal	= document.getElementById("retMatNVal_"+lItem).value;
			var stockFee	= document.getElementById("stockFee_"+lItem).value;
		
			perVal = ((parseFloat(npLItemVal)*parseFloat(stockFee))/parseFloat("100")).toFixed(2);
			alert(perVal);
		}

		var nVal = (parseFloat(sTot)-parseFloat(perVal)).toFixed(2);		
		if(!isNaN(nVal))
		{
			document.getElementById("reStockTotalFee").innerHTML = perVal;
			document.getElementById("grandTotalAll").innerHTML = nVal;
		}
	}
	else if(feeType=='AMT')
	{
		var nVal = (parseFloat(sTot)-parseFloat(stockFee)).toFixed(2);

		if(!isNaN(nVal))
		{
			document.getElementById("reStockTotalFee").innerHTML = parseFloat(stockFee).toFixed(2);
			document.getElementById("grandTotalAll").innerHTML = nVal;
		}
	}

}
function updateNVal(npObj,ind)
{
	var npVal 	= npObj.value;
	var retQtyVar 	= "retQty_"+ind+"";
	var npVar 	= "retMatNVal_"+ind+"";
	var npDispVar 	= "retMatNValDisp_"+ind+"";
	var npHid	= "retMatNPHid_"+ind+"";

	var npHidVal	= document.getElementById(npHid).value;

	document.getElementById("retMatNP_"+ind).setCustomValidity('');
	if(npVal=='')
	{
		document.getElementById("retMatNP_"+ind).setCustomValidity('Please enter the Net Price');
		npVal = "0.00";
	}

	var retQtyVal 	= document.getElementById(retQtyVar).value;
	var netVal 	= (parseFloat(retQtyVal)*parseFloat(npVal)).toFixed(2);

	//if(!isNaN(netVal)) netVal = "0.00";

	if(netVal!='')
	{
		document.getElementById(npVar).value=netVal;
		document.getElementById(npDispVar).value=netVal;
		document.getElementById(npDispVar).innerHTML=netVal;

		var grandTotal = netVal;
		var len = <%=retCancelReqObjCnt%>;

		if(!isNaN(len))
		{
			grandTotal = 0;
			for(i=0;i<len;i++)
			{
				var lNo = "";

				if(len==1)
					lNo = document.generalForm.lineId.value;
				else
					lNo = document.generalForm.lineId[i].value;

				var lStat = eval("document.generalForm.lineStatus"+lNo).value;

				if(lStat=='A')
				{
					var mNetPrice = (document.getElementById("retMatNP_"+lNo).value).trim();
					if(mNetPrice=='') mNetPrice = "0.00";

					grandTotal += (parseFloat(mNetPrice)*parseFloat(document.getElementById("retQty_"+lNo).value));
				}
			}
		}
		document.getElementById("subTotalAll").innerHTML = parseFloat(grandTotal).toFixed(2);
		calRestockFee();
	}
}
function calRestockFee()
{
	var rType = document.getElementById("restockFeesType").value;
	var rVal = (document.getElementById("restockFees").value).trim();
	var sTot = document.getElementById("subTotalAll").innerHTML;

	if(rVal=='') rVal = "0.00";

	if(rType=='PER')
	{
		var perVal = ((parseFloat(sTot)*parseFloat(rVal))/parseFloat("100")).toFixed(2);
		var nVal = (parseFloat(sTot)-parseFloat(perVal)).toFixed(2);

		if(!isNaN(nVal))
		{
			document.getElementById("reStockTotalFee").innerHTML = perVal;
			document.getElementById("grandTotalAll").innerHTML = nVal;
		}
	}
	else if(rType=='AMT')
	{
		var nVal = (parseFloat(sTot)-parseFloat(rVal)).toFixed(2);

		if(!isNaN(nVal))
		{
			document.getElementById("reStockTotalFee").innerHTML = parseFloat(rVal).toFixed(2);
			document.getElementById("grandTotalAll").innerHTML = nVal;
		}
	}
}
function actionOnLine(lineId)
{
	updateNVal(eval("document.generalForm.retMatNP_"+lineId),lineId)
	var lStat = eval("document.generalForm.lineStatus"+lineId).value;

	if(lStat=='A' || lStat=='R')
	{
		$.fancybox({
			type : "inline",
			href : "#NOTES"+lineId
		});
	}
	if(lStat=='A')
	{
		if(eval("document.generalForm.itemPlant_"+lineId).value=='')
			document.getElementById("itemPlant_"+lineId).setCustomValidity('Please select the Plant');
		if(eval("document.generalForm.retMatNP_"+lineId).value=='')
			document.getElementById("retMatNP_"+lineId).setCustomValidity('Please enter the Net Price');
		if(eval("document.generalForm.retQty_"+lineId).value=='')
			document.getElementById("retQty_"+lineId).setCustomValidity('Please enter the Quantity');
		if(eval("document.generalForm.invoiceNum_"+lineId).value!='' && eval("document.generalForm.invoiceItm_"+lineId).value=='')
			document.getElementById("invoiceItm_"+lineId).setCustomValidity('Please enter the Invoice Item');
		if(eval("document.generalForm.invoiceNum_"+lineId).value!='')
		{
			var numbers = /^[0-9]+$/;
			if(!(eval("document.generalForm.invoiceNum_"+lineId).value.match(numbers)))
				document.getElementById("invoiceNum_"+lineId).setCustomValidity('Please enter the Numeric Value');
			else
				document.getElementById("invoiceNum_"+lineId).setCustomValidity('');
		}
	}
	else
	{
		document.getElementById("itemPlant_"+lineId).setCustomValidity('');
		document.getElementById("retMatNP_"+lineId).setCustomValidity('');
		document.getElementById("retQty_"+lineId).setCustomValidity('');
		document.getElementById("invoiceItm_"+lineId).setCustomValidity('');
		document.getElementById("invoiceNum_"+lineId).setCustomValidity('');
	}
}
function selPlant(lineId)
{
	if(eval("document.generalForm.itemPlant_"+lineId).value=='')
		document.getElementById("itemPlant_"+lineId).setCustomValidity('Please select the Plant');
	else
		document.getElementById("itemPlant_"+lineId).setCustomValidity('');
}
function chkInvNum(lineId)
{
	var invNum = eval("document.generalForm.invoiceNum_"+lineId).value;
	if(invNum!='')
	{
		var numbers = /^[0-9]+$/;
		if(!(invNum.match(numbers)))
			document.getElementById("invoiceNum_"+lineId).setCustomValidity('Please enter the Numeric Value');
		else
			document.getElementById("invoiceNum_"+lineId).setCustomValidity('');
	}
	else
		document.getElementById("invoiceNum_"+lineId).setCustomValidity('');
}
function chkInvItem(lineId)
{
	if(eval("document.generalForm.invoiceNum_"+lineId).value!='' && eval("document.generalForm.invoiceItm_"+lineId).value=='')
		document.getElementById("invoiceItm_"+lineId).setCustomValidity('Please enter the Invoice Item');
	else
		document.getElementById("invoiceItm_"+lineId).setCustomValidity('');
}
function selResidential()
{
	if(document.generalForm.isResidential.value=='')
		document.getElementById("isResidential").setCustomValidity('Please select the Residential');
	else
		document.getElementById("isResidential").setCustomValidity('');
}
function resetPrice(lineId)
{
	var netHVal = $(document.getElementById("retMatNPHid_"+lineId)).val();
	$(document.getElementById("retMatNP_"+lineId)).val(netHVal);

	updateNVal(eval("document.generalForm.retMatNP_"+lineId),lineId)
}
function resetQty(lineId)
{
	var netHVal = $(document.getElementById("retHQty_"+lineId)).val();
	$(document.getElementById("retQty_"+lineId)).val(netHVal);

	updateNVal(eval("document.generalForm.retMatNP_"+lineId),lineId)
}
function saveApprNote(lineId)
{
	var aNote = document.getElementById("apprNotes"+lineId).value;
	aNote = aNote.replace("'","`")
	if(aNote=='')
	{
		alert("Please Enter Notes and Save")
		return;
	}
	else
	{
		eval("document.generalForm.itemApprNotes"+lineId).value = aNote;
	}
	var anLen = aNote.length;
	if(anLen>70)
		aNote = aNote.substring(0,60)+"....";

	document.getElementById("apprCommentsDisp_"+lineId).innerHTML = aNote;

	//event.preventDefault();
	parent.$.fancybox.close();
	$('generalForm').submit();
	return false;
}
function clearText(lineId)
{
	document.getElementById("apprNotes"+lineId).value = "";
	eval("document.generalForm.itemApprNotes"+lineId).value = "";

	var aHNote = document.getElementById("itemApprNotesHid"+lineId).value;
	document.getElementById("apprCommentsDisp_"+lineId).innerHTML = aHNote;
}
function closeDialog()
{
	//event.preventDefault();
	parent.$.fancybox.close();
	$('generalForm').submit();
	return false;
}
function checkEvent(evt)
{
	var charCode = (evt.which) ? evt.which : event.keyCode;

	if(charCode > 31 && (charCode < 48 || charCode > 57))
	{
		return false;
	}

	return true;
}
function allnumeric(lineId)
{
	var retQty = eval("document.generalForm.retQty_"+lineId);
	var retHQty = eval("document.generalForm.retHQty_"+lineId);

	var numbers = /^[0-9]+$/;
	if(retQty.value!="")
	{
		document.getElementById("retQty_"+lineId).setCustomValidity('');

		if(parseFloat(retQty.value)>parseFloat(retHQty.value))
		{
			alert("Returned quantity should not exceed the requested quantity by Customer");
			retQty.value="";
		}
		else if(parseFloat(retQty.value)=='0')
		{
			alert("Returned quantity cannot not be zero");
			retQty.value="";
		}
		else
		{
			if(retQty.value.match(numbers))
			{
				updateNVal(eval("document.generalForm.retMatNP_"+lineId),lineId)
				return true;
			}
			else
			{
				alert("Please enter the numeric values");
				retQty.value="";
				retQty.focus();
				return false;
			}
		}
	}
	else
	{
		alert("Please enter the numeric values");
		retQty.focus();
		return false;
	}
}
</script>

<Script type="text/javascript">
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
</Script>

<form name="generalForm" id="generalForm" method="post" >
<div id="dialog-alert" title="Alert">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;display:none;"></span>Please fill out this field.</p>
</div>
<div class="main-container col2-layout middle account-pages">
<div class="main">
<div class="col-main1 roundedCorners">
<div class="page-title">

<input type="hidden" name="cancellationId" value='<%=cancellationId%>'>
<input type="hidden" name="actionType" value=''>
<input type="hidden" name="soldTo" value='<%=soldToCode%>'>
<input type="hidden" name="requestor" value='<%=requestor%>'>
<input type="hidden" name="requestorName" value=<%=retCancelReqObj.getFieldValueString(0,"ESCH_CREATED_BY")%>>
<input type="hidden" name="reqdate" value='<%=reqdate%>'>
<input type="hidden" name="prodCode_D" >
<input type="hidden" name="fromPage" >
<input type="hidden" name="crType" value = <%=request.getParameter("crType")%>>
<input type="hidden" name="rType" value=<%=request.getParameter("rType")%>>
<input type="hidden" name="poNumber" value=<%=retCancelReqObj.getFieldValueString(0,"ESCH_PO_NUM")%>>
<input type="hidden" name="rgaNumber">
<input type="hidden" name="rejRCCom">

<!------- Search Order Page hidden fields ------->
<input type="hidden" name="PONO" value="<%=request.getParameter("PONO")%>">
<input type="hidden" name="fromDate" value="<%=request.getParameter("fromDate")%>">
<input type="hidden" name="toDate" value="<%=request.getParameter("toDate")%>">
<input type="hidden" name="proCodeDesc" value="<%=request.getParameter("prdCODE")%>">
<input type="hidden" name="SAPSO" value="<%=request.getParameter("SAPSO")%>">
<input type="hidden" name="UPC" value="<%=request.getParameter("UPC")%>">
<input type="hidden" name="parentSol" value="<%=request.getParameter("selParent")%>">
<input type="hidden" name="selSoldTo" value="<%=request.getParameter("selSoldTo")%>">
<input type="hidden" name="shipTo" value="<%=request.getParameter("shipTo")%>">
<input type="hidden" name="orderType" value="<%=request.getParameter("orderType")%>">
<input type="hidden" name="ordStat" value="<%=request.getParameter("ordStat")%>">
<input type="hidden" name="selOrds" value="Returns">
<input type="hidden" name="orderinforadio" value="<%=request.getParameter("radioSelect")%>">
<input type="hidden" name="singleList" value="Y">
<!------- Search Order Page hidden fields End------->

<div id="modal1" style="border:0px solid black; background-color:white; padding:1px; font-size:10;width:40%;height:180px; text-align:center; display:none;">
	<ul>
 		<li>&nbsp;</li>
 		<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
 		<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
 	</ul>
</div>

<div class="highlight" >
<div class="printE" style="float:right; display:none;">
	<img src="../../Library/Styles/logorevised.png" height="55px" width="237px">
	</div>
<br>
<font size="5" color="black">
<% 
	if (crType.equals("C") || crType.equals("RC")) 
	{
%>
		<b>&nbsp;VIEW CANCELLATION REQUEST</b>
<% 
	} else {
%> 
		<b>&nbsp;VIEW RGA</b>
<% 	
	}
%>
</font>

<br>
&nbsp;<strong> PO NO:</strong>&nbsp;<%=retCancelReqObj.getFieldValueString(0,"ESCH_PO_NUM")%>
&nbsp;<strong> REQUEST ID:</strong>&nbsp;<%=cancellationId%>
&nbsp;<strong> REQUESTED ON:</strong>&nbsp;<%=(formatDate.getStringFromDate((java.util.Date)retCancelReqObj.getFieldValue(0,"ESCH_CREATED_ON"),"/",formatDate.MMDDYYYY))%>
&nbsp;<strong> REQUESTED BY:</strong>&nbsp;<%=retCancelReqObj.getFieldValueString(0,"ESCH_CREATED_BY")%>
<br>&nbsp;<strong> STATUS:</strong>&nbsp;

<%
	String inStatus = canReqType;//request.getParameter("canReqType");
 	String printStatus = "IN ASB CANCELLATIONS PROCESSING ";

 	if (inStatus != null && !inStatus.equals("null")) { 
		if ("RGA".equals(crType))  	
			printStatus = "IN ASB QUEUE: PENDING";			
		if (inStatus.equals("CA")) 
			printStatus = "ACCEPTED BY CUSTOMER";
		if (inStatus.equals("A") && "RGA".equals(crType)) 
			printStatus = "IN CUSTOMER QUEUE";
		if (inStatus.equals("A") && !"RGA".equals(crType)) 
			printStatus = "APPROVED";
		if (inStatus.equals("R")) 
			printStatus = "REJECTED";
	}

	String disabled = "";

	if("RGA".equals(crType))
	{
		if("CU".equals(userRole))
		{
			disabled = "disabled";
		}
		else
		{
			if("A".equals(canReqType) || "CA".equals(canReqType) || "R".equals(canReqType))
			{
				disabled = "disabled";
			}
		}
	}
%>
<%=printStatus%>
</div>
</div>
<br>

<br>
<%@ include file="../../../Includes/JSPs/Misc/iStatesRetObj.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iShipMethods.jsp"%>
<%
	String selShipToCode = retCancelReqObj.getFieldValueString(0,"ESCH_SHIP_TO");
	String addlInfo	= nullCheck(retCancelReqObj.getFieldValueString(0,"ESCH_CUST_TEXT"),"N/A");
	String invNotes	= nullCheck(retCancelReqObj.getFieldValueString(0,"ESCH_INTERNAL_TEXT"),"N/A");

	if("N/A".equals(addlInfo)) addlInfo = "";
	if("N/A".equals(invNotes)) invNotes = "";

 	if(selShipToCode==null || "null".equalsIgnoreCase(selShipToCode) || "".equals(selShipToCode))
 		selShipToCode 	= request.getParameter("shipToCode");//(String)session.getValue("SHIPTO_PREP");

 	String isResidential	= retCancelReqObj.getFieldValueString(0,"ESCH_SHIP_TO_RES");
 
 	String defShipToName 	= retCancelReqObj.getFieldValueString(0,"ESCH_SHIP_TO_NAME");
 	String defShipAddr1 	= retCancelReqObj.getFieldValueString(0,"ESCH_SHIP_TO_STREET1");
 	String defShipAddr2 	= retCancelReqObj.getFieldValueString(0,"ESCH_SHIP_TO_CITY");
 	String defShipState 	= retCancelReqObj.getFieldValueString(0,"ESCH_SHIP_TO_STATE");
 	String defShipCountry 	= retCancelReqObj.getFieldValueString(0,"ESCH_SHIP_TO_COUNTRY");
 	String defShipZip 	= retCancelReqObj.getFieldValueString(0,"ESCH_SHIP_TO_ZIP");
 	String defShipPhNum 	= retCancelReqObj.getFieldValueString(0,"ESCH_SHIP_TO_PHONE");
 	String defShipToCode 	= selShipToCode;
 	String selSoldName 	= "";
 	String selSoldAddr1	= "";
 	String selSoldCity 	= "";
 	String selSoldState 	= "";
 	String selSoldCountry 	= "";
 	String selSoldZipCode	= "";
 	String selSoldPhNum 	= "";
 	String selSoldEmail 	= "";
 	String soldToIncoTerm 	= "";
 	String shipAddress	= "";

 	String sysKey = (String)session.getValue("SalesAreaCode");
 	String catalog_areaSA = sysKey;
 	String selSoldToSA = soldToCode;

 	ReturnObjFromRetrieve retsoldto_A = (ReturnObjFromRetrieve)UtilManager.getUserCustomers(sysKey);
 	String soldToInfo = "";
 	String payerInfo = "";
 	if(retsoldto_A!=null)
 	{
 		for(int i=0;i<retsoldto_A.getRowCount();i++)
 		{
 			String soldToCode_A 	= retsoldto_A.getFieldValueString(i,"EC_ERP_CUST_NO");
 			String soldToName_A 	= retsoldto_A.getFieldValueString(i,"ECA_NAME");
 
 			String selected_A = "";
 
 			if(soldToCode.equals(soldToCode_A))
 			{
 				soldToInfo+=soldToCode+"<br>";
 
 				soldToInfo+=retsoldto_A.getFieldValueString(i,"ECA_NAME")+"<br>";
 
 				soldToInfo+=retsoldto_A.getFieldValueString(i,"ECA_ADDR_1")+"<br>";
 
 				soldToInfo+=retsoldto_A.getFieldValueString(i,"ECA_CITY")+"&nbsp;";
 				if ((retsoldto_A.getFieldValueString(i,"ECA_DISTRICT") != null) && (retsoldto_A.getFieldValueString(i,"ECA_DISTRICT") != "null"))
 				soldToInfo+=retsoldto_A.getFieldValueString(i,"ECA_DISTRICT")+"<br>";
 				if ((retsoldto_A.getFieldValueString(i,"ECA_POSTAL_CODE") != null) && (retsoldto_A.getFieldValueString(i,"ECA_POSTAL_CODE") != "null"))
 				soldToInfo+=retsoldto_A.getFieldValueString(i,"ECA_POSTAL_CODE")+"<br>";

 				break;
 			}
 		}
 	}
  	if(crType.equals("RGA"))
 	{
%>
		<%@ include file="../../../Includes/JSPs/SwitchAccount/iGetShipTo.jsp"%>
<%
		String shipToName = "";
		String shipAddr1 = "";
		String shipAddr2 = "";
		String shipState = "";
		String shipCountry = "";
		String shipZip = "";
		String shipPhNum = "";
		String selShipParams = "еееееее";
		String dropShipName = "";

		if(defShipToCode==null || "null".equalsIgnoreCase(defShipToCode))
		{
			defShipToCode = request.getParameter("selShipTo");
			if(defShipToCode==null || "null".equalsIgnoreCase(defShipToCode)) defShipToCode = "";
		}
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

		if(defShipToCode!=null && !"null".equals(defShipToCode) && !"".equals(defShipToCode.trim()))
			shipAddress = shipAddress + defShipToCode +"<br>";
		if(defShipToName!=null && !"null".equals(defShipToName) && !"".equals(defShipToName.trim()))
			shipAddress = shipAddress + defShipToName +"<br>";
		if(defShipAddr1!=null && !"null".equals(defShipAddr1) && !"".equals(defShipAddr1.trim()))
			shipAddress = shipAddress + defShipAddr1 +"<br>";
		if(defShipAddr2!=null && !"null".equals(defShipAddr2) && !"".equals(defShipAddr2.trim()))
			shipAddress = shipAddress + defShipAddr2 +"<br>";
		if(defShipState!=null && !"null".equals(defShipState) && !"".equals(defShipState.trim()))
			shipAddress = shipAddress + defShipState +", ";
		if(defShipCountry!=null && !"null".equals(defShipCountry) && !"".equals(defShipCountry.trim()))
			shipAddress = shipAddress + defShipCountry +"&nbsp;";
		if(defShipZip!=null && !"null".equals(defShipZip) && !"".equals(defShipZip.trim()))
			shipAddress = shipAddress + defShipZip +" ";
		if(defShipPhNum!=null && !"null".equals(defShipPhNum) && !"".equals(defShipPhNum.trim()))
			shipAddress = shipAddress +"Tel#:" + defShipPhNum +"<br>";
%>
<div class="col3-set">
	<div class="col-1">
	<div class="info-box">
		<h2 class="sub-title" style="padding-top:10px">Sold To Address</h2>
			<p><%=soldToInfo%></p>
			<input type="hidden" name="soldToCode" id="soldToCode" value="<%=soldToCode%>"> </input>
		<h2 style="padding-top:10px;font-size:15px;color:#202020">Ship From</h2>
		<ul class="form-list">
		<li style="padding-top: 10px">
			<label for="selShipToInfo" class="required">Ship From ID<em>*</em></label>
			<div class="input-box" style="width:290px !important;">
			<div>
			<select name="selShipToInfo" id="selShipToInfo" onChange="selectedShipTos()" onKeyDown="selectedShipTos()" <%=disabled%> required>
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
				shipState 	= (shipState==null || "null".equals(shipState) || "".equals(shipState))?"":shipState;
				shipCountry 	= (shipCountry==null || "null".equals(shipCountry)|| "".equals(shipCountry))?"":shipCountry.trim();
				shipZip 	= (shipZip==null || "null".equals(shipZip)|| "".equals(shipZip))?"N/A":shipZip;
				shipPhNum 	= (shipPhNum==null || "null".equals(shipPhNum)|| "".equals(shipPhNum))?"N/A":shipPhNum;
				dropShipName	= shipToName;

				String tempShip = listShipTosCS.getFieldValueString(l,"ECA_ACCOUNT_GROUP");
	
				if("CPDA".equalsIgnoreCase(tempShip))	shipToName = "";
	
				String shipParams = shipToName+"е"+shipAddr1+"е"+shipAddr2+"е"+shipState+"е"+shipCountry+"е"+shipZip+"е"+shipPhNum+"е"+shipToCode+"е"+tempShip;
	
				String selected_A = "";
				String onetime_A = "";

				if((listShipCnt==1) || ((listShipCnt==2) && !"CPDA".equalsIgnoreCase(tempShip)))
				{
					selected_A = "selected";
					selShipParams = shipParams;
				}
	
				if(selShipToCode!=null && selShipToCode.equals(shipToCode))
				{
					selected_A = "selected";
					selShipParams = shipParams;
				}
				if("CPDA".equalsIgnoreCase(tempShip))
				{
					onetime_A = "id=\"onetimeshipto\" name=\"onetimeshipto\"";
					dropShipName = "Drop Ship";
					shipParams = defShipToName+"е"+defShipAddr1+"е"+defShipAddr2+"е"+defShipState+"е"+defShipCountry+"е"+defShipZip+"е"+defShipPhNum+"е"+shipToCode+"е"+tempShip;
				}
%>
				<option value="<%=shipParams%>" <%=selected_A%> <%=onetime_A%>><%=dropShipName%> : <%=shipToCode%></option>
<%
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
<%
		if("".equals(disabled))
		{
%>
			<a href="javascript:openSearch('SHIPTO')"><img height="20px" width="20px" src="../../Images/search2.png"></a>
<%
		}
%>
			<input type="hidden" name="selShipTo" value="<%=defShipToCode%>">
			<input type="hidden" name="shipToCountry" value="<%=defShipCountry%>">
			<input type="hidden" name="dropShipTo">
			</div>
			<div id="divShipToText" style="display:none">
			</div>
			</div>
		</li>
		<div id="divShipToEnt" style="display:none">
<%
		if(isResidential==null || "null".equalsIgnoreCase(isResidential))
		{
			isResidential = request.getParameter("useMyCarrier");
	
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
			<label for="isResidential" class="required">Is It Residential<em>*</em> </label>
			<div class="input-box">
			<div>
			<select id="isResidential" name="isResidential" title="Is-It-Residential" STYLE="width: 90px" <%=disabled%> onchange="selResidential()">//onchange="selUseMyCarrier()" 
				<option value="" <%=selected_SN%>>--Select--</option>
				<option value="YES" <%=selected_RY%>>Yes</option>
				<option value="NO" <%=selected_RN%>>No</option>
			</select>
			</div>
			</div>
		</li>
		<li>
			<label for="shipToName" class="required">Ship From Name<em>*</em> </label>
			<div class="input-box">
				<input type="text" id="shipToName" name="shipToName" style="width:100%" value="<%=defShipToName%>" <%=disabled%> required>
				<input type="hidden" id="shipToNameH" name="shipToNameH" value="<%=defShipToName%>">
			</div>
		</li>
		<li>
			<label for="shipToStreet" class="required">Street 1<em>*</em></label>
			<div class="input-box">
				<input type="text" id="shipToStreet" name="shipToStreet" style="width:100%" value="<%=defShipAddr1%>" <%=disabled%> required>
				<input type="hidden" id="shipToStreetH" name="shipToStreetH" value="<%=defShipAddr1%>">
			</div>
		</li>
		<li>
			<label for="city-state-zip" class="required">City<em>*</em></label>
			<div class="input-box">
				<input type="text" id="shipToCity" name="shipToCity" style="width:100%" value="<%=defShipAddr2%>" <%=disabled%> required>
				<input type="hidden" id="shipToCityH" name="shipToCityH" value="<%=defShipAddr2%>">
			</div>
		</li>
		<li>
			<label for="city-state-zip" class="required">State<em>*</em></label>
			<div class="input-box">
				<select name="shipToState" id="shipToState" <%=disabled%> required>
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
				<input type="hidden" id="shipToStateH" name="shipToStateH" value="<%=defShipState%>">
			</div>
		</li>
		<li>
			<label for="city-state-zip" class="required">Zip<em>*</em></label>
			<div class="input-box">
				<input type="text" id="shipToZip" name="shipToZip" style="width:100%" value="<%=defShipZip%>" <%=disabled%> required>
				<input type="hidden" id="shipToZipH" name="shipToZipH" value="<%=defShipZip%>">
			</div>
		</li>
		<li>
			<label for="shipToPhone" class="required">Phone<em>*</em></label>
			<div class="input-box">
				<input type="text" id="shipToPhone" name="shipToPhone" style="width:100%" value="<%=defShipPhNum%>" <%=disabled%> required>
				<input type="hidden" id="shipToPhoneH" name="shipToPhoneH" value="<%=defShipPhNum%>">
			</div>
		</li>
		</div> <!-- conditional/hidden div for drop ship related -->
		</ul>
	</div>
	</div>
	<div class="col-2">
	<div class="info-box">
		<h2 class="sub-title" style="padding-top:10px">Customer RGA Contact</h2>
		<ul class="form-list">
		<li style="padding-top: 10px">
			<label for="contactName" class="required">Customer RGA Contact Name<em>*</em> </label>
			<div class="input-box">
				<input type="text" disabled id="contactName" name="contactName" style="width:100%" value="<%=retCancelReqObj.getFieldValueString(0,"ESCH_CONTACT_NAME")%>">
			</div>
		</li>
		<li>
			<label for="contactEmail" class="required">Customer RGA Contact Email<em>*</em> </label>
			<div class="input-box">
				<input type="text" disabled id="contactEmail" name="contactEmail" style="width:100%" value="<%=retCancelReqObj.getFieldValueString(0,"ESCH_CONTACT_EMAIL")%>">
			</div>
		</li>
		<li>
			<label for="contactPhone" class="required">Customer RGA Contact Phone<em>*</em> </label>
			<div class="input-box">
				<input type="text" disabled id="contactPhone" name="contactPhone" style="width:100%" value="<%=retCancelReqObj.getFieldValueString(0,"ESCH_CONTACT_PHONE")%>">
			</div>
		</li>
	</div> <!-- infobox -->
	</div> <!-- Col 2 of Order Header -->
	<div class="col-3">
	<div class="info-box">
		<h2 class="sub-title" style="padding-top:10px">Reasons and Terms</h2>
		<strong> Reason: </strong><%=toDisplaStr(retCancelReqObj.getFieldValueString(0,"ESCH_REASON"))%><br>
		<input type="hidden" name="returnReason" id="returnReason" value="<%=retCancelReqObj.getFieldValueString(0,"ESCH_REASON")%>"></input>
		<ul class="form-list">
<%
		String	sapOrdReason	= nullCheck(retCancelReqObj.getFieldValueString(0,"ESCH_SAP_REASON"),"N/A");
		String	forwardAgent	= nullCheck(retCancelReqObj.getFieldValueString(0,"ESCH_SHIPPING_PARTNER"),"N/A");
		String	incoTerm1	= nullCheck(retCancelReqObj.getFieldValueString(0,"ESCH_INCO_TERM1"),"N/A");
		String	incoTerm2	= nullCheck(retCancelReqObj.getFieldValueString(0,"ESCH_INCO_TERM2"),"N/A");

		String	reStkType	= nullCheck(retCancelReqObj.getFieldValueString(0,"ESCH_HEADER_FEES_TYPE"),"N/A");
		String	reStkVal 	= nullCheck(retCancelReqObj.getFieldValueString(0,"ESCH_HEADER_FEES_VALUE"),"N/A");

		Date curDate = new Date();
		curDate.setDate(curDate.getDate()+14);

		String expireOn = formatDate.getStringFromDate(curDate,"/",formatDate.MMDDYYYY);
		if("N/A".equals(reStkVal)) reStkVal = "0.00";

		String expDateChk 	= (formatDate.getStringFromDate((java.util.Date)retCancelReqObj.getFieldValue(0,"ESCH_EXPIRE_ON"),"/",formatDate.MMDDYYYY));
		if(!"01/01/1900".equals(expDateChk))
			expireOn = expDateChk;

		if(!"CU".equals(userRole))
		{
			java.util.HashMap ordReasonHM = new java.util.HashMap();

			ordReasonHM.put("01","01 GPR - Refsd/ Undelvrble-not A/S error");
			ordReasonHM.put("02","02 GPR - Accomodation");
			ordReasonHM.put("03","03 GPR - A/S O/E error-color");
			ordReasonHM.put("04","04 GPR - A/S O/E error-item");
			ordReasonHM.put("05","05 GPR - A/S O/E error-qty");
			ordReasonHM.put("06","06 GPR - A/S Ship error-color");
			ordReasonHM.put("07","07 GPR - A/S Ship error-item");
			ordReasonHM.put("08","08 GPR - A/S Ship error-qty");
			ordReasonHM.put("09","09 GPR - A/S error-wrong prod-in-box");
			ordReasonHM.put("10","10 GPR - Buyer's Remorse");
			ordReasonHM.put("11","11 GPR - Buyback Program");
			ordReasonHM.put("12","12 GPR - Unauthorized-itm/qty/color");
			ordReasonHM.put("13","13 GPR - O/E Wrong Cust");
			ordReasonHM.put("14","14 GPR - O/E Duplicate Order");
			ordReasonHM.put("15","15 GPR - Customer order wrong product");
			ordReasonHM.put("16","16 GPR - Shipped Cancelled Order(Ship)");
			ordReasonHM.put("16A","16A GPR - Shipped Cancelled Order (C/S)");
			ordReasonHM.put("16B","16B GPR - Customer Cancellation");
			ordReasonHM.put("17","17 GPR - A/S Ship Error - Delivery Time");
			ordReasonHM.put("18","18 GPR - A/S Ship Error - Wrong Customer");
			ordReasonHM.put("19","19 GPR - A/S Ship Error - Duplicat Order");
			ordReasonHM.put("19A","19A GPR - Exception");
			ordReasonHM.put("50J","50J Pricing-A/S Sales Dept Error");

			String selIn1 = "",selIn2 = "",selIn3 = "";

			if(("FFA-ORIGIN").equals(incoTerm1+"-"+incoTerm2)) selIn1 = "selected";
			else if(("CFO-Collect").equals(incoTerm1+"-"+incoTerm2)) selIn2 = "selected";
			else if(("CPT-Origin").equals(incoTerm1+"-"+incoTerm2)) selIn3 = "selected";

			String selFa1 = "",selFa2 = "",selFa3 = "",selFa4 = "",selFa5 = "";

			if(("OVNT").equals(forwardAgent)) selFa1 = "selected";
			else if(("RDWY").equals(forwardAgent)) selFa2 = "selected";
			else if(("FDXG").equals(forwardAgent)) selFa3 = "selected";
			else if(("OTH").equals(forwardAgent)) selFa4 = "selected";
			else selFa5 = "selected";

			String selRs1 = "",selRs2 = "";

			if(("PER").equals(reStkType)) selRs1 = "selected";
			else if(("AMT").equals(reStkType)) selRs2 = "selected";
%>
		<li>
			<label for="orderReason" class="required">SAP Order Reason<em>*</em></label>
			<div class="input-box">
			<select name="orderReason" id="orderReason" <%=disabled%> required>
			<option value="">------Select------</option>
<%
			Map sortedMap = new TreeMap(ordReasonHM);

			Set ordRCol = sortedMap.entrySet();
			Iterator ordRColIte = ordRCol.iterator();

			while(ordRColIte.hasNext())
			{
				Map.Entry ordRColData = (Map.Entry)ordRColIte.next();

				String ordRCode = (String)ordRColData.getKey();
				String ordRDesc = (String)ordRColData.getValue();

				String selected_A = "";

				if(sapOrdReason!=null && sapOrdReason.equals(ordRCode))
					selected_A = "selected";
%>
				<option value="<%=ordRCode%>" <%=selected_A%>><%=ordRDesc%></option>
<%
			}
%>
			</select>
			</div>
		</li>		
		<li>
			<label for="incoTerm" class="required">Inco Term<em>*</em></label>
			<div class="input-box">
			<select name="incoTerm" id="incoTerm" <%=disabled%>>
				<option value="FFA-ORIGIN"  <%=selIn1%>>FFA/Origin(Prepaid)</option>
				<option value="CFO-Collect" <%=selIn2%>>CFO/Collect(Collect)</option>
				<option value="CPT-Origin"  <%=selIn3%>>CPT/Origin</option>
			</select>
			</div>
		</li>
		<li>
			<label for="forwardingAgent" class="required">Forwarding Agent</label>
			<div class="input-box">
			<select name="forwardingAgent" id="forwardingAgent" <%=disabled%>>
				<option value="SEL" <%=selFa5%>>------Select------</option>
				<option value="OVNT" <%=selFa1%>>UPS Freight</option>
				<option value="RDWY" <%=selFa2%>>Roadway</option>
				<option value="FDXG" <%=selFa3%>>Fed-ex Ground</option>
				<option value="OTH" <%=selFa4%>>Other</option>
			</select>
			</div>
		</li>
		<li>
			<label for="restockFees" >Restock Fees</label>
			<div class="input-box">
			<table>
			<tr>
			<td width="50%">
			<select name="restockFeesType" id="restockFeesType" onChange="calRestockFee()" style="width:100%" <%=disabled%>>
				<option value="PER" <%=selRs1%>>% </option>
				<option value="AMT" <%=selRs2%>>Amount </option>
			</select>
			</td>
			<td width="50%">
				<input type="text" id="restockFees" name="restockFees" style="width:100%" value="<%=reStkVal%>" onBlur="calRestockFee()" onKeyPress="calRestockFee()" onKeyUp="calRestockFee()" <%=disabled%>>
			</td>
			</tr>
			</table>
			</div>
		</li>
		<li>
			<label for="expireOn" >Approval Expires on</label>
			<div class="input-box">
				<input type="text" id="expireOn" name="expireOn" size="12" value="<%=expireOn%>" readonly <%=disabled%>>
<%
				if("".equals(disabled))
				{
%>
				<%=getDateImageFromToday("expireOn")%>
<%
				}
%>
			</div>
		</li>
<%
		}
		else
		{
			String incoTermStr = incoTerm1+"-"+incoTerm2;
%>
			<input type="hidden" id="incoTerm" name="incoTerm" value="<%=incoTermStr%>">
			<input type="hidden" id="orderReason" name="orderReason" value="<%=sapOrdReason%>">
			<input type="hidden" id="forwardingAgent" name="forwardingAgent" value="<%=forwardAgent%>">
			<input type="hidden" id="restockFeesType" name="restockFeesType" value="<%=reStkType%>">
			<input type="hidden" id="restockFees" name="restockFees" value="<%=reStkVal%>">
			<input type="hidden" id="invNotes" name="invNotes" value="<%=invNotes%>">
			<input type="hidden" id="expireOn" name="expireOn" value="<%=expireOn%>">
<%
			if(!"01/01/1900".equals(expireOn))
			{
%>
			<li>
				<label for="expireOn" >ASB Approval Expires on :</label>
				<div class="input-box"><%=expireOn%></div>
			</li>
<%
			}
		}
%>
		</ul>
	</div>
	</div> <!-- Col 3 of Order Header -->
</div> <!-- End of header Column 3 Set -->
<%
	String readOnlyText = "";
	String retHText = nullCheck(retCancelReqObj.getFieldValueString(0,"ESCH_APPROVER_NOTE"),"N/A");
	if("N/A".equals(retHText)) retHText = "";

	boolean showHText = true;

	if("CU".equals(userRole))
	{
		readOnlyText = "readonly";

		if("".equals(retHText)) showHText = false;
	}


		if(showHText)
		{
%>
			<div class="col-1">
			<div class="info-box">
				<h2 class="sub-title" style="padding-top:10px;border: none !important;">Header Notes to Customer</h2>
				<textarea rows="4" cols="50" name="retHText" id="retHText" <%=readOnlyText%> <%=disabled%>><%=retHText%></textarea>
			</div>
			</div>
			<br>
<%
		}
		if(!"CU".equals(userRole))
		{
%>
			<div class="col2-set">
				<div class="col-1">
				<div class="info-box">
					<h2 class="sub-title" style="padding-top:10px">Additional Information From Customer</h2>
					<textarea rows="4" cols="50" name="retText" id="retText" readonly <%=disabled%>><%=addlInfo%></textarea>
				</div>
				</div>
				<div class="col-2">
				<div class="info-box">
					<h2 class="sub-title" style="padding-top:10px">Invoice Notes</h2>
					<textarea rows="4" cols="50" name="invNotes" id="invNotes" <%=disabled%>><%=invNotes%></textarea>
				</div>
				</div>
			</div>	
<%
		}
		else
		{
%>
			<div class="col1-set">
				<div class="col-1">
				<div class="info-box">
					<h2 class="sub-title" style="padding-top:10px">Additional Information From Customer</h2>
					<textarea rows="4" cols="50" name="retText" id="retText" readonly <%=disabled%>><%=addlInfo%></textarea>
				</div>
				</div>
			</div>
<%
		}
	}
	else
	{
		if (crType.equals("C") || crType.equals("RC"))
		{
%>
			<!--<div class="col3-set">
				<div class="col-1">
				<div class="info-box">
					<h2 class="sub-title" style="padding-top:10px">Sold To Address</h2>
					<p></p>
				</div>
				</div>
				<div class="col-2">
				<div class="info-box">
					<h2 class="sub-title" style="padding-top:10px">Ship To Address</h2>
					<p></p>
				</div>
				</div>
				<div class="col-3">
				<div class="info-box">
					<h2 class="sub-title" style="padding-top:10px"></h2>
				</div>
				</div>
			</div>-->
<%
		}
	}

	if (crType.equals("C") || crType.equals("RC"))
	{
		if(rejectNotes!=null && !"null".equalsIgnoreCase(rejectNotes) && !"".equals(rejectNotes))
		{
%>
			<div class="col-1">
			<div class="info-box">
				<h2 class="sub-title" style="padding-top:10px;border: none !important;">REASON FOR REJECTION</h2>
				<textarea rows="4" cols="50" name="retHText" id="retHText" readOnly disabled><%=rejectNotes%></textarea>
			</div>
			</div>				
<%
		}
	}
%>
<br>
	<div id="divAction" style="display:block;float:left">
		<button type="button" title="Back" class="button" onclick="javascript:funBackSubmit()">
		<span class="left-link">Back to List</span></button>
	</div>
<%	
	if (userAuth_R.containsKey(authToCheck)) {
		if (crType.equals("RGA")) {
			if(!"CU".equals(userRole) && !"A".equals(inStatus) && !"R".equals(inStatus) && !"CA".equals(inStatus))
			{
%>
				<div id="divAction2" style="display:block;float:right">
					<button type="button" title="Submit Changes to Customer" class="button" onClick="funSubmit('A')"><span class="right-link">Submit Changes to Customer</span></button>
				</div>
<%
			}
	} else {
		if(!"CU".equals(userRole) && !"A".equals(inStatus) && !"R".equals(inStatus) && !"CA".equals(inStatus))
		{
%>
			<div id="divAction2" style="display:block;float:right">
			<a class="fancybox" href="#REJREASON">
				<button type="button" class="button" title="Reject CR"><span><span class="right-link">Reject Cancellation</span></span></button>
			</a>
			<button type="button" title="Accept CR" class="button" onclick="javascript:funSubmitCR('A')">
			<span class="right-link">Accept Cancellation</span></button>
			</div>
			<div id="REJREASON" style="display:none">
				<h2>Rejection Reason</h2>
				<br>
				<ul class="form-list">
				<li>
					<div class="input-box">
						&nbsp;<textarea name="rejRCComments" id="rejRCComments" cols="80" rows="5"></textarea>
					</div>
				</li>
				<li>
					<input type="button" label="Reject" text="Reject" value="Reject" onClick="javascript:funSubmitCR('R')"></input>
				</li>
				</ul>
			</div>
<% 
		}  // CU and status check
	}
	
	String rgaNumber = retCancelReqObj.getFieldValueString(0,"RGAID");
	if(rgaNumber!=null && !"null".equalsIgnoreCase(rgaNumber) && !"".equals(rgaNumber) && rgaNumber.trim().length()>=10)
	{
%>
		<div id='Sort Button' style="width: 120px !important; display: inline-block; float: left;">
		<ul id="navbar" style="width: 100px; display: inline;">
			<li><a href="javascript:void()" style="padding-top:7px;padding-bottom:5px;">Print RGA &nbsp;&nbsp;<span class="arrow"></span></a>
			<ul>
<%
			ArrayList rgaArrayList = new ArrayList();
			for(int i=0;i<retCancelReqObjCnt;i++)
			{
				rgaNumber = retCancelReqObj.getFieldValueString(i,"ESCI_BACK_END_ORDER");//RGAID
				rgaNumber = rgaNumber.trim();
				if(rgaArrayList.contains(rgaNumber))
					continue;

				rgaArrayList.add(rgaNumber);
%>
				<li><a style="cursor:pointer;" onclick="javascript:funPrintRGA('<%=rgaNumber%>')"><span><%=rgaNumber%></span></a></li>
<%
			}
%>
			</ul>
			</li>
		</ul>
		</div>
<%
	}
	if("CU".equals(userRole) && "A".equals(inStatus) && "RGA".equals(crType))
	{
		Date curDate_C = new Date();
		Date expDate = (java.util.Date)retCancelReqObj.getFieldValue(0,"ESCH_EXPIRE_ON");
		expDate.setHours(23);
		expDate.setMinutes(59);
		expDate.setSeconds(59);
%>
		<div id="divAction2" style="display:block;float:right">
		<button type="button" title="Withdraw Request" class="button" onclick="javascript:funSubmit('R')">
		<span class="right-link">Withdraw Request</span></button>
<%
		if(curDate_C.compareTo(expDate)<=0)
		{
%>
		<button type="button" title="Accept ASB Terms" class="button" onclick="javascript:funSubmit('CA')" id="acceptRGA" style="display:none">
		<span class="right-link">Accept ASB Terms</span></button>
<%
		}
%>
		</div>
<%
	}
	}

 	boolean showButton = false;
 	if(retCancelReqObjCnt>0)
 	{
		int colCnt = 4;
%>
		<%@ include file="../../../Includes/JSPs/Sales/iGetRGAPlants.jsp"%>
		<br>
		<div class="col1-set">
		<div class="info-box"><br><br>
		<table class="data-table" id="quickatp">
		<thead>
		<tr>
		<th > Image <br> Brand </th>
		<th width=15%>Product Info</th>
<%
		if (crType.equals("C") || crType.equals("RC"))
		{
%>
			<th width=10%>Quantity</th>
			<th width=25%>Rejection Reason</th>
			<th width=20%>Comments</th>
<%
		}
		else
		{
			colCnt = 8;
%>
			<th width=25%>Material Returned</th>
			<th width=10%>Ordered Qty</th>
			<th width=20%>Net Price</th>
			<th width=20%>Status</th>
			<th width=20%>Approver Notes</th>
			<th width=20%>Qty Returned</th>
			<th width=20%>Net Value</th>
<%
		}
%>
		</tr>
		</thead>
		<tbody>
<%
		java.math.BigDecimal grandTotal = new java.math.BigDecimal("0");
		java.math.BigDecimal restockFee = new java.math.BigDecimal("0.00");

		String brand="";
		for(int i=0;i<retCancelReqObjCnt;i++)
		{
			String soNum = retCancelReqObj.getFieldValueString(i,"ESCI_SO_NUM");
			String soItem = retCancelReqObj.getFieldValueString(i,"ESCI_SO_ITEM");
			String rejReasonCode = retCancelReqObj.getFieldValueString(i,"ESCI_REJ_REASON");
			String matno = retCancelReqObj.getFieldValueString(i,"ESCI_MAT_CODE");
				matno = matno.trim();
			String apprComments = retCancelReqObj.getFieldValueString(i,"ESCI_COMMENTS");

			//Image and Brand of product

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
			" WHERE EZP_PRODUCT_CODE='"+matno+"' ORDER by EPA_SCREEN_NAME desc";

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


			if(prodDetailsRetObjDWN!=null && prodDetailsRetObjDWN.getRowCount()>0)
			{
				//listPriceOurDB = prodDetailsRetObjDWN.getFieldValueString(0,"EZP_CURR_PRICE");	
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
						mainSTD=nullCheck(prodDetailsRetObjDWN.getFieldValueString(im,"EZA_LINK"),"N/A");					
					}
					if("MAIN".equals(prodDetailsRetObjDWN.getFieldValueString(im,"EPA_IMAGE_TYPE")) && indLarge!=-1)
					{				
						mainLarge=nullCheck(prodDetailsRetObjDWN.getFieldValueString(im,"EZA_LINK"),"N/A");					
					}
					if("ZOOM".equals(prodDetailsRetObjDWN.getFieldValueString(im,"EPA_IMAGE_TYPE")) && indThumb!=-1)
					{				
						mainThumb=nullCheck(prodDetailsRetObjDWN.getFieldValueString(im,"EZA_LINK"),"N/A");
					}

				}
 			
 			}
			if("".equals(mainSTD)) 
			{
				//mainSTD="../../Images/noimage.gif";
				//mainLarge="../../Images/noimage.gif";
				//mainThumb="../../Images/noimage.gif";
			}

		String invStr = nullCheck(retCancelReqObj.getFieldValueString(i,"ESCI_INV_NUM"),"")+"/"+nullCheck(retCancelReqObj.getFieldValueString(i,"ESCI_INV_ITEM"),"");
%>
 		<tr>
			<td valign="top" style="vertical-align:top"><br>
			<img  src="<%=mainSTD%>" width="100" height"160"  alt="" />
			<p align="center"><%=brand%></p>
			</td>
			<td width=15% valign="top" style="vertical-align:top"><strong>Product#</strong>&nbsp;
			<a href="javascript:getProductDetails('<%=matno%>')" title="<%=retCancelReqObj.getFieldValueString(i,"ESCI_MAT_DESC")%>" ><%=matno%></a>
			<br><%=retCancelReqObj.getFieldValueString(i,"ESCI_MAT_DESC")%>
			<br><strong>Ref#</strong>&nbsp;<%=soNum%>/<%=soItem%>
			<br>
<%
		String parentCode = nullCheck(retCancelReqObj.getFieldValueString(i,"ESCI_EXT1"),"");
		if(!"".equals(parentCode))
		{
%>
		<strong>KIT/Combo Item#</strong>&nbsp;<%=parentCode%><br>
<%
		}

		String itemPlant = nullCheck(retCancelReqObj.getFieldValueString(i,"ESCI_PLANT"),"");
		String lineId = retCancelReqObj.getFieldValueString(i,"ESCI_SO_NUM")+retCancelReqObj.getFieldValueString(i,"ESCI_SO_ITEM");
		String itemSalesOrg = retCancelReqObj.getFieldValueString(i,"ESCI_SO_SORG");

		if(crType.equals("RGA"))
		{
		if(!"CU".equals(userRole))
		{
		String invNum = nullCheck(retCancelReqObj.getFieldValueString(i,"ESCI_INV_NUM"),"");
		String invItm = nullCheck(retCancelReqObj.getFieldValueString(i,"ESCI_INV_ITEM"),"");

		try
		{
			invNum = (Long.parseLong(invNum))+"";
		}
		catch(Exception e)
		{
			invNum = nullCheck(retCancelReqObj.getFieldValueString(i,"ESCI_INV_NUM"),"");
		}
		try
		{
			invItm = (Long.parseLong(invItm))+"";
		}
		catch(Exception e)
		{
			invItm = nullCheck(retCancelReqObj.getFieldValueString(i,"ESCI_INV_ITEM"),"");
		}
%>
		<br><span style="float:right"><strong>Invoice#</strong>&nbsp;<input type="text" size="8" maxlength="10" style="text-align:right" name="invoiceNum_<%=lineId%>" id="invoiceNum_<%=lineId%>" value="<%=invNum%>" onKeyPress="return checkEvent(event)" onBlur="chkInvNum('<%=lineId%>')" <%=disabled%>></span>
		<span style="float:right"><strong>Invoice LI#</strong>&nbsp;<input type="text" size="8" maxlength="6" style="text-align:right" name="invoiceItm_<%=lineId%>" id="invoiceItm_<%=lineId%>" value="<%=invItm%>" onKeyPress="return checkEvent(event)" onBlur="chkInvItem('<%=lineId%>')" pattern="[0-9]+" <%=disabled%>></span>
<%
		}
		else
		{
%>
		<br><strong>Invoice#</strong>&nbsp;<%=invStr%>
		<input type="hidden" name="invoiceNum_<%=lineId%>" id="invoiceNum_<%=lineId%>" value="<%=nullCheck(retCancelReqObj.getFieldValueString(i,"ESCI_INV_NUM"),"")%>">
		<input type="hidden" name="invoiceItm_<%=lineId%>" id="invoiceItm_<%=lineId%>" value="<%=nullCheck(retCancelReqObj.getFieldValueString(i,"ESCI_INV_ITEM"),"")%>">
		<input type="hidden" name="itemPlant_<%=lineId%>" id="itemPlant_<%=lineId%>" value="<%=itemPlant%>">
<%
		}
		}
%>
		</td>
<%
		if(crType.equals("C") || crType.equals("RC"))
		{
%>
			<td width=10% valign="top" style="vertical-align:top"><%=retCancelReqObj.getFieldValueString(i,"ESCI_QUANTITY")%></td>
			<td width=15% valign="top" style="vertical-align:top"><%=rejReasonHT.get(retCancelReqObj.getFieldValueString(i,"ESCI_REJ_REASON"))%></td>
			<td width=25% valign="top" style="vertical-align:top"><%=retCancelReqObj.getFieldValueString(i,"ESCI_COMMENTS")%></td>
<%
		}
		if(crType.equals("RGA"))
		{ 
			String retMat = retCancelReqObj.getFieldValueString(i,"ESCI_RET_MAT");
			String retQty = retCancelReqObj.getFieldValueString(i,"ESCI_RET_QTY");
			String retMatNP = retCancelReqObj.getFieldValueString(i,"ESCI_RETMAT_NP");
			String lineStatus = retCancelReqObj.getFieldValueString(i,"ESCI_STATUS");

			if("R".equals(lineStatus)) retQty = "0";

			java.math.BigDecimal itemQty1 = (new  java.math.BigDecimal(retQty));
			java.math.BigDecimal itemValueBD = new java.math.BigDecimal(retMatNP);
			itemValueBD = itemValueBD.multiply(itemQty1);			
			String retMatNVal = itemValueBD.setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();

			String sel_R = "",sel_A = "",sel_P = "selected",custStat = "In Review";

			if("A".equals(lineStatus))
			{
				custStat = "Accepted";
				sel_R = "";
				sel_A = "selected";
				sel_P = "";
				grandTotal = (grandTotal.add(new java.math.BigDecimal(retMatNVal)));
				showButton = true;
			}
			else if("R".equals(lineStatus) || "A".equals(inStatus))
			{
				custStat = "Rejected";
				sel_R = "selected";
				sel_A = "";
				sel_P = "";
			}
			String stockFeeVal = "0.00";
			if(!"CU".equals(userRole))
			{
%>
			<td width=20% valign="top" style="vertical-align:top">
			<input type="text" size="10" maxlength="18" style="text-align:right" name="retMat_<%=lineId%>" id="retMat_<%=lineId%>" value="<%=retMat%>" <%=disabled%> required>
			<input type="hidden" name="retMatAct_<%=lineId%>" id="retMatAct_<%=lineId%>" value="<%=matno.trim()%>"></td>
			<td width=10% valign="top" style="vertical-align:top"><%=retCancelReqObj.getFieldValueString(i,"ESCI_QUANTITY")%></td>
			<td width=20% valign="top" style="vertical-align:top">
				<input type="text" size="4" id="retMatNP_<%=lineId%>" name="retMatNP_<%=lineId%>" value="<%=retMatNP%>" style="text-align:right" onBlur="updateNVal(this,'<%=lineId%>')" onKeyPress="updateNVal(this,'<%=lineId%>')" onKeyUp="updateNVal(this,'<%=lineId%>')" <%=disabled%>></input>
				<input type="hidden" name="retMatNPHid_<%=lineId%>" id="retMatNPHid_<%=lineId%>" value="<%=retMatNP%>">
<%
				if("".equals(disabled))
				{
%>
				<br><a href="javascript:resetPrice('<%=lineId%>')"><span>Reset</span></a>
<%
				}
%>
			<input type="text" size="4" id="stockFee_<%=lineId%>" name="stockFee_<%=lineId%>" value="<%=stockFeeVal%>" style="text-align:right" onBlur="stockFeeItemLevel(this,'<%=lineId%>')" onKeyPress="stockFeeItemLevel(this,'<%=lineId%>')" onKeyUp="stockFeeItemLevel(this,'<%=lineId%>')" <%=disabled%>></input>
			</td>
			<td width=20% valign="top">
				<select name="lineStatus<%=lineId%>" id="lineStatus<%=lineId%>" onChange="actionOnLine('<%=lineId%>')" <%=disabled%> required>
					<option value="" <%=sel_P%>>In Review</option>
					<option value="A" <%=sel_A%>>Accepted</option>
					<option value="R" <%=sel_R%>>Rejected</option>
				</select>
<%
				if(!"CU".equals(userRole))
				{
%>
				<br><br><strong>Plant#</strong>&nbsp;
				<select name="itemPlant_<%=lineId%>" id="itemPlant_<%=lineId%>" onChange="selPlant('<%=lineId%>')" style="width:100%" <%=disabled%>>
				<option value="">-Select-</option>
<%
					for(int j=0;j<retObjPlants.getRowCount();j++)
					{
						String plantCode = retObjPlants.getFieldValueString(j,"PLANTCODE").trim();
						String selected_A = "";
						if(plantCode.equals(itemPlant)) selected_A = "selected";
%>
							<option value="<%=plantCode%>" <%=selected_A%>><%=plantCode%></option>
<%
					}
%>
				</select>
<%
				}
%>
			</td>
			<td width=20% valign="top" style="vertical-align:top">
				<a class="fancybox" href="#NOTES<%=lineId%>">
				<span id='apprCommentsDisp_<%=lineId%>'><%=nullCheck(apprComments,"N/A")%><span></a>
			</td>
<%
			if("P".equals(canReqType))
			{
%>
			<div id="NOTES<%=lineId%>" style="display:none">
				<h2>Approver Notes</h2>
				<br>
				<ul class="form-list">
				<li>
					<div class="input-box">
						&nbsp;<textarea name="apprNotes<%=lineId%>" id="apprNotes<%=lineId%>" cols="80" rows="5"></textarea>
					</div>
				</li>
				<li>
					<input type="button" label="Save" text="Save" value="Save" onClick="saveApprNote('<%=lineId%>')"></input>
					<input type="button" label="Clear" text="Clear" value="Clear" onClick="clearText('<%=lineId%>')"></input>
					<input type="button" label="Close" text="Close" value="Close" onClick="closeDialog()"></input>
				</li>
				</ul>
			</div>
<%
			}
			else
			{
%>
			<div id="NOTES<%=lineId%>" style="display:none">
				<h2>Approver Notes</h2>
				<br><%=nullCheck(apprComments,"N/A")%>
			</div>
<%
			}
%>
			<td width=20% valign="top" style="vertical-align:top">
				<input type="text" size="4" name="retQty_<%=lineId%>" id="retQty_<%=lineId%>" style="text-align:right" value=<%=retQty%> onKeyPress="return checkEvent(event)" onBlur="allnumeric('<%=lineId%>')" <%=disabled%>></input>
				<input type="hidden" name="retHQty_<%=lineId%>" id="retHQty_<%=lineId%>" value=<%=retQty%>>
<%
				if("".equals(disabled))
				{
%>
				<br><a href="javascript:resetQty('<%=lineId%>')"><span>Reset</span></a>
<%
				}
%>
			</td>
<%
			}
			else
			{
			String sapRGANum = retCancelReqObj.getFieldValueString(i,"ESCI_BACK_END_ORDER");

			if(sapRGANum!=null && !"".equals(sapRGANum) && "A".equals(lineStatus))
				lineStatus = "POSTEDTOSAP";
%>
			<td width=20% valign="top" style="vertical-align:top"><%=retMat%>
			<input type="hidden" name="retMat_<%=lineId%>" id="retMat_<%=lineId%>" value="<%=retMat%>">
			<input type="hidden" name="retMatAct_<%=lineId%>" id="retMatAct_<%=lineId%>" value="<%=matno.trim()%>"></td>
			<td width=10% valign="top" style="vertical-align:top"><%=retCancelReqObj.getFieldValueString(i,"ESCI_QUANTITY")%></td>
			<td width=20% valign="top" style="vertical-align:top"><%=retMatNP%>
			<input type="hidden" name="retMatNP_<%=lineId%>" id="retMatNP_<%=lineId%>" value="<%=retMatNP%>"></td>
			<td width=20% valign="top"><%=custStat%>
				<!--<select name="lineStatusHid<%=lineId%>" id="lineStatusHid<%=lineId%>" <%=disabled%>>
					<option value="P" <%=sel_P%>>In Review</option>
					<option value="A" <%=sel_A%>>Accepted</option>
					<option value="R" <%=sel_R%>>Rejected</option>
				</select>-->
			<input type="hidden" name="lineStatus<%=lineId%>" id="lineStatus<%=lineId%>" value="<%=lineStatus%>">
			</td>
			<td width=20% valign="top" style="vertical-align:top"><span id='apprCommentsDisp_<%=lineId%>'><%=nullCheck(apprComments,"N/A")%><span></td>
			<td width=20% valign="top" style="vertical-align:top">
			<input type="hidden" name="retQty_<%=lineId%>" id="retQty_<%=lineId%>" value=<%=retQty%>><%=retQty%></td>
<%
			}
%>
			<td width=20% valign="top" style="vertical-align:top" class="price"><input id='retMatNVal_<%=lineId%>' type="hidden" value=<%=retMatNVal%>></input><span id='retMatNValDisp_<%=lineId%>'><%=retMatNVal%><span></td>

			<input type='hidden' name="lineId" id="lineId" value="<%=lineId%>">
			<input type='hidden' name='retMat' value= '<%=matno%>'>
			<input type='hidden' name='retQty' value= '<%=retQty%>'>
			<input type='hidden' name='retPrice' value= '<%=retMatNP%>'>
			<input type='hidden' name='retSorg' value= '<%=retCancelReqObj.getFieldValueString(i,"ESCI_SO_SORG")%>'>
			<input type='hidden' name='retDch' value= '<%=retCancelReqObj.getFieldValueString(i,"ESCI_SO_DCH")%>'>
			<input type='hidden' name='retDiv' value= '<%=retCancelReqObj.getFieldValueString(i,"ESCI_SO_DIV")%>'>

			<input type="hidden" name="itemApprNotes<%=lineId%>">
			<input type="hidden" name="itemApprNotesHid<%=lineId%>" id="itemApprNotesHid<%=lineId%>" value="<%=nullCheck(apprComments,"N/A")%>">
<%
		}
%>
		<input type='hidden' name='soNum' value= '<%=soNum%>'>
		<input type='hidden' name='soItem' value= '<%=soItem%>'>
		<input type='hidden' name='rejReasonCode' value= '<%=rejReasonCode%>'>
		<input type='hidden' name='rejComments' value= '<%=retCancelReqObj.getFieldValueString(i,"ESCI_COMMENTS")%>'>
		</tr>
<%
 	}

	String tSubItemVal = grandTotal.setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
	String tTotItemVal = (grandTotal.subtract(restockFee)).toString();
%>
 	</tbody>
<%
	if("RGA".equals(crType) && (!"CU".equals(userRole) || !"P".equals(canReqType)))
	{
%>
 	<tfoot>
 	<tr>
 		<th colspan="<%=colCnt%>">Sub Total</th>
 		<th class="price">$<span id="subTotalAll"><%=tSubItemVal%></span></th>
 	</tr>
 	<tr>
 		<th colspan="<%=colCnt%>">Restock Fees</th>
 		<th class="price">$<span id="reStockTotalFee"><%=restockFee%></span></th>
 	</tr>
 	<tr>
 		<th colspan="<%=colCnt%>">Total Returned(SubTotal less Restock)</th>
 		<th class="price">$<span id="grandTotalAll"><%=tTotItemVal%></span></th>
 	</tr>
 	</tfoot>
<%
	}
	else
	{
%>
		<input type="hidden" id="subTotalAll">
		<input type="hidden" id="reStockTotalFee">
		<input type="hidden" id="grandTotalAll">
<%
	}
%>
 	</table>
</div>
</div>
<script>
selectedShipTos()
calRestockFee()
<%
	if(showButton)
	{
%>
		document.getElementById("acceptRGA").style.display="block";
<%
	}
%>
</script>
<%
 	}
%>
</div>
</div>
</div>
</form>
<%!
	public String nullCheck(String str,String str1)
	{
		String ret = str;

		if(ret==null || "null".equalsIgnoreCase(ret) || "".equals(ret))
			ret = str1;
		return ret;
	}
	public String toDisplaStr(String str)
	{
		String ret = "Other";
		
		if (str!= null){
			if (str.equals("10"))
				ret="Accomodation";
			if (str.equals("20"))
				ret="American Standard Error";
		}
		return ret;
	}
%>
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
</style>
<%@ page import ="ezc.customer.invoice.params.*" %>
<%@ page import ="ezc.ezparam.*,ezc.client.*,java.util.*"%>
<%
	String salesOrder 	= request.getParameter("salesOrder");
	String soldToCode 	= request.getParameter("soldToCode");

 	String poNumber 	= request.getParameter("PurchaseOrder");
 	String cancelAllItems 	= request.getParameter("CancelAllItems");

 	String poItems[] = request.getParameterValues("poItems");

 	int selecedItemsCnt = 0;

 	if(poItems!=null)
 		selecedItemsCnt = poItems.length;
%>
<link rel="stylesheet" type="text/css" href="../../Library/Styles/formalize.css">
<script type="text/javascript" src="../../Library/Script/jquery.formalize.js"></script>
<script type="text/javascript" src="../../Library/Script/jquery.validate.js"></script>
<Script src="../../Library/Script/popup.js"></Script>
<Script>
	function funSubmit()
 	{
		var itemsLen = document.generalForm.poItems.length;
		var y = true;

		if(!isNaN(itemsLen))
		{
			for(var i=0;i<itemsLen;i++)
			{
				poItem 		= document.generalForm.poItems[i].value;
				poItemMatDesc 	= (eval("document.generalForm.prodDesc"+poItem)).value;
				reasonRejObj 	= eval("document.generalForm.reasonForRej"+poItem)

				reasonRejVal = reasonRejObj.value;

				if(trim(reasonRejVal) == '')
				{
					y = false;
					$( "#dialog-alert" ).dialog('open').text("Please select Reason For Cancellation for Item "+poItemMatDesc);
					//alert("Please select Reason For Cancellation for Item "+poItemMatDesc);
					//reasonRejObj.focus();
					return;
				}
			}
		}
		else
		{
			poItem 		= document.generalForm.poItems.value;
			poItemMatDesc 	= (eval("document.generalForm.prodDesc"+poItem)).value;
			reasonRejObj 	= eval("document.generalForm.reasonForRej"+poItem)

			reasonRejVal = reasonRejObj.value;

			if(trim(reasonRejVal) == '')
			{
				y = false;
				$( "#dialog-alert" ).dialog('open').text("Please select Reason For Cancellation for Item "+poItemMatDesc);
				//alert("Please select Reason For Cancellation for Item "+poItemMatDesc);
				//reasonRejObj.focus();
				return;
			}
		}
		if(eval(y))
		{
			Popup.showModal('modal1');
			document.generalForm.requestType='C';
			document.generalForm.action="ezProcessCancelRequestMain.jsp";
			document.generalForm.submit();
		}
 	}
 	function funSubmitRGA()
 	{
 		var y = validateRGAForm();
 		if(eval(y))
 		{
			Popup.showModal('modal1');
			document.generalForm.requestType='R';
			document.generalForm.action="ezProcessCancelRequestMain.jsp";
			document.generalForm.submit();
		}
	}
	function validateRGAForm()
	{
		var shToInfo 	= document.generalForm.selShipToInfo.value;
		var isResid	= document.generalForm.isResidential.value;
		var shName 	= document.generalForm.shipToName.value;
		var shStreet 	= document.generalForm.shipToStreet.value;
		var shCity 	= document.generalForm.shipToCity.value;
		var shState 	= document.generalForm.shipToState.value;
		var shZip 	= document.generalForm.shipToZip.value;
		var shPhone 	= document.generalForm.shipToPhone.value;
		var accGroup	= document.generalForm.accGroup.value;
		var conName 	= document.generalForm.contactName.value;
		var conEmail 	= document.generalForm.contactEmail.value;
		var conPhone 	= document.generalForm.contactPhone.value;
		var retReason	= document.generalForm.returnReason.value;

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
		if(trim(conName)=="")
		{
			$( "#dialog-alert" ).dialog('open').text("Please enter Contact Name");
			return false;
		}
		if(trim(conEmail)=="")
		{
			$( "#dialog-alert" ).dialog('open').text("Please enter Contact Email");
			return false;
		}
		if(trim(conPhone)=="")
		{
			$( "#dialog-alert" ).dialog('open').text("Please enter Contact Phone");
			return false;
		}
		if(retReason=="")
		{
			$( "#dialog-alert" ).dialog('open').text("Please select Reason");
			return false;
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
	function funBackSubmit()
	{
		Popup.showModal('modal1');
		document.generalForm.action = 'ezSalesOrderDetails.jsp';
		document.generalForm.submit();
	}
	function getProductDetails(code)
	{
		document.generalForm.prodCode_D.value=code;
		document.generalForm.action="../Catalog/ezProductDetails.jsp";
		document.generalForm.target = "_blank"
		document.generalForm.submit();
	}
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

		var accGroup = selShipTo.split('е')[8]; //shipCode.substring((shipCode.length)-4,shipCode.length);

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
	}
	function openSearch(searchType)
	{
		var selSoldTo='';
		if(searchType=='SHIPTO')
			selSoldTo = document.generalForm.soldTo.value
		window.open("ezSearchPOP.jsp?searchType="+searchType+"&selSoldTo="+selSoldTo,'name','height=475,width=800,left=200,top=100,location=no,resizable=no,scrollbars=no,toolbar=no,status=yes,z-lock=yes');
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
</Script>
<Script type="text/javascript">
/*$.validator.setDefaults({
	submitHandler: function() { funSubmitRGA(); }
});
$.validator.addMethod("valueNotEquals", function(value, element, arg){
	return arg != value;
}, "Value must not equal arg.");

$(document).ready(function() {
	$("#generalForm").validate({
		rules: {
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
			contactName: "required",
			contactEmail: "required",
			contactPhone: "required",
			returnReason: "required"
		},
		messages: {
			selShipToInfo: { valueNotEquals: "<font color=red>Please select Ship To ID</font>"},
			isResidential: "<font color=red>Please select Residential Status</font>",
			shipToName: "<font color=red>Please provide Name</font>",
			shipToState: "<font color=red>Please provide State</font>",
			shipToStreet: "<font color=red>Please provide Street</font>",
			shipToCity: "<font color=red>Please provide City</font>",
			shipToZip: "<font color=red>Please provide Zipcode</font>",
			shipToPhone: "<font color=red>Please provide Phone No</font>",
			contactName: "<font color=red>Please enter Contact Name</font>",
			contactEmail: "<font color=red>Please enter Contact Email</font>",
			contactPhone: "<font color=red>Please enter Contact Phone</font>",
			returnReason: "<font color=red>Please select Reason</font>"
		}
	});
});*/
</Script>
<form name="generalForm" id="generalForm" method="post">
<input type='hidden' name='PurchaseOrder' value='<%=poNumber%>'>
<input type='hidden' name='salesOrder' value='<%=salesOrder%>'>
<input type='hidden' name='soldTo' value='<%=soldToCode%>'>
<input type='hidden' name='shipTo' value='<%=request.getParameter("shipToCode")%>'>
<input type="hidden" name="prodCode_D">
<input type="hidden" name="requestType" value='C'>
<input type="hidden" name="accGroup">
<input type="hidden" name="soldTo_Name" value="<%=request.getParameter("soldTo_Name")%>">
<input type="hidden" name="cancOrRGA" value="<%=cancOrRGA%>">

<input type="hidden" name="shipToName" value="<%=request.getParameter("partToName")%>">
<input type="hidden" name="shipToStreet" value="<%=request.getParameter("partToStreet")%>">
<input type="hidden" name="shipToCity" value="<%=request.getParameter("partToCity")%>">
<input type="hidden" name="shipToState" value="<%=request.getParameter("partToRegion")%>">
<input type="hidden" name="shipToZip" value="<%=request.getParameter("partToPostCode")%>">
<input type="hidden" name="shipToPhone" value="<%=request.getParameter("partToTel")%>">
<input type="hidden" name="shipToCountry" value="<%=request.getParameter("partToCountry")%>">

<%
	if(selecedItemsCnt>0)
	{

	String dispHeader = "No Items Selected";
	if(selecedItemsCnt>0)
		dispHeader = "PO : "+poNumber;
%>
<div id="modal1" style="border:0px solid black; background-color:white; padding:1px; font-size:10;width:40%;height:180px; text-align:center; display:none;">
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
<div class="col-main1 roundedCorners">
<div class="page-title">
	<div class="highlight" >
	<br>&nbsp;
	<font size="5" color="black">
	<% if (cancOrRGA.equals("C")){ %>
	<b> CONFIRM CANCELLATION INFO </b>
	<% } else { %>
	<b> CONFIRM RGA REQUEST </b>
	<% } %>
	</font>
	<br>&nbsp;
	<strong> PO NO:</strong>&nbsp;<%=poNumber%>
	</div>
</div>
<br>
<% if (cancOrRGA.equals("RGA")){ %>
<br>
<%@ include file="../../../Includes/JSPs/Misc/iStatesRetObj.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iShipMethods.jsp"%>
<%
	String selShipToCode 	= request.getParameter("shipToCode");//(String)session.getValue("SHIPTO_PREP");
	//out.println("Selected Ship to from prevPage-->"+selShipToCode);
	String isResidential	= (String)session.getValue("ISRESID_PREP");

	String defShipToName 	= (String)session.getValue("SHIPNA_PREP");
	String defShipAddr1 	= (String)session.getValue("SHIPSR_PREP");
	String defShipAddr2 	= (String)session.getValue("SHIPCT_PREP");
	String defShipState 	= (String)session.getValue("SHIPST_PREP");
	String defShipCountry 	= (String)session.getValue("SHIPCN_PREP");
	String defShipZip 	= (String)session.getValue("SHIPZC_PREP");
	String defShipPhNum 	= (String)session.getValue("SHIPPH_PREP");
	String defShipToCode 	= (String)session.getValue("SHIPTO_PREP");
	String selSoldName 	= "";
	String selSoldAddr1	= "";
	String selSoldCity 	= "";
	String selSoldState 	= "";
	String selSoldCountry 	= "";
	String selSoldZipCode	= "";
	String selSoldPhNum 	= "";
	String selSoldEmail 	= "";
	String soldToIncoTerm 	= "";


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
		defShipToCode = request.getParameter("shipToCode");
		if(defShipToCode==null || "null".equalsIgnoreCase(defShipToCode)) defShipToCode = "";
	}
%>
<div class="col3-set">
	<div class="col-1">
	<div class="info-box">
		<h2 class="sub-title" style="padding-top:10px">Sold To Address</h2>
			<br><p><%=soldToInfo%></p>
		<h2 style="padding-top:10px;font-size:15px;color:#202020">Ship From</h2>
		<ul class="form-list">
		<li style="padding-top: 10px">
			<label for="selShipToInfo" class="required">Ship From ID<em>*</em></label>
			<div class="input-box" style="width:290px !important;">
			<div>
			<select name="selShipToInfo" id="selShipToInfo" onChange="selectedShipTos()" onKeyDown="selectedShipTos()">
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
	
				shipAddr1 	= (shipAddr1==null || "null".equals(shipAddr1)|| "".equals(shipAddr1))?"":shipAddr1;
				shipAddr2 	= (shipAddr2==null || "null".equals(shipAddr2)|| "".equals(shipAddr2))?"":shipAddr2;// for city
				shipState 	= (shipState==null || "null".equals(shipState) || "".equals(shipState))?"":shipState;
				shipCountry 	= (shipCountry==null || "null".equals(shipCountry)|| "".equals(shipCountry))?"":shipCountry.trim();
				shipZip 	= (shipZip==null || "null".equals(shipZip)|| "".equals(shipZip))?"":shipZip;
				shipPhNum 	= (shipPhNum==null || "null".equals(shipPhNum)|| "".equals(shipPhNum))?"":shipPhNum;
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
			<a href="javascript:openSearch('SHIPTO')"><img height="20px" width="20px" src="../../Images/search2.png"></a>
			<input type="hidden" name="selShipTo" value="<%=defShipToCode%>">
			<input type="hidden" name="shipToCountry" value="<%=defShipCountry%>">
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
			<select id="isResidential" name="isResidential" title="Is-It-Residential" STYLE="width: 90px">//onchange="selUseMyCarrier()" 
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
				<input type="text" id="shipToName" name="shipToName" maxlength="40" style="width:100%" value="<%=defShipToName%>">
			</div>
		</li>
		<li>
			<label for="shipToStreet" class="required">Street 1<em>*</em></label>
			<div class="input-box">
				<input type="text" id="shipToStreet" name="shipToStreet" maxlength="40" style="width:100%" value="<%=defShipAddr1%>">
			</div>
		</li>
		<li>
			<label for="city-state-zip" class="required">City<em>*</em></label>
			<div class="input-box">
				<input type="text" id="shipToCity" name="shipToCity" maxlength="40" style="width:100%" value="<%=defShipAddr2%>">
			</div>
		</li>
		<li>
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
				<input type="text" id="shipToZip" name="shipToZip" maxlength="15" style="width:100%" value="<%=defShipZip%>">
			</div>
		</li>
		<li>
			<label for="shipToPhone" class="required">Phone<em>*</em></label>
			<div class="input-box">
				<input type="text" id="shipToPhone" name="shipToPhone" maxlength="20" style="width:100%" value="<%=defShipPhNum%>">
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
				<input type="text" id="contactName" name="contactName" maxlength="50" style="width:100%" value="">
			</div>
		</li>
		<li>
			<label for="contactEmail" class="required">Customer RGA Contact Email<em>*</em> </label>
			<div class="input-box">
				<input type="text" id="contactEmail" name="contactEmail" maxlength="50" style="width:100%" value="">
			</div>
		</li>
		<li>
			<label for="contactPhone" class="required">Customer RGA Contact Phone<em>*</em> </label>
			<div class="input-box">
				<input type="text" id="contactPhone" name="contactPhone" maxlength="14" style="width:100%" value="">
			</div>
		</li>
		</ul>
	</div> <!-- infobox -->
	</div> <!-- Col 2 of Order Header -->
	<div class="col-3">
	<div class="info-box">
		<h2 class="sub-title" style="padding-top:10px">Reasons and Terms</h2>
		<ul class="form-list">
		<li style="padding-top: 10px">
		<label for="returnReason" class="required">Reason<em>*</em></label>
		<div class="input-box">
		<select name="returnReason" id="returnReason">
			<option value="">------Select------</option>
			<option value="10">Accomodation</option>
			<option value="20">American Standard Error</option>
			<!--<option value="20">Warranty</option>
			<option value="30">Wrong Shipment</option>
			<option value="40">Breakages in Transit</option>
			<option value="50">Defective</option>-->
		</select>
		</div>
		</li>		
		<% if(!"CU".equals(userRole)){ %>
		<li>
			<label for="orderReason" class="required">SAP Order Reason<em>*</em></label>
			<div class="input-box">
			<select name="orderReason" id="orderReason">
			<option value="">------Select------</option>
			<option value="01">01 GPR - Refsd/ Undelvrble-not A/S error</option>
			<option value="02">02 GPR - Accomodation</option>
			<option value="03">03 GPR - A/S O/E error-color</option>
			<option value="04">04 GPR - A/S O/E error-item</option>
			<option value="05">05 GPR - A/S O/E error-qty</option>
			<option value="06">06 GPR - A/S Ship error-color</option>
			<option value="07">07 GPR - A/S Ship error-item</option>
			<option value="08">08 GPR - A/S Ship error-qty</option>
			<option value="09">09 GPR - A/S error-wrong prod-in-box</option>
			<option value="10">10 GPR - Buyer's Remorse</option>
			<option value="11">11 GPR - Buyback Program</option>
			<option value="12">12 GPR - Unauthorized-itm/qty/color</option>
			<option value="13">13 GPR - O/E Wrong Cust</option>
			<option value="14">14 GPR - O/E Duplicate Order</option>
			<option value="15">15 GPR - Customer order wrong product</option>
			<option value="16">16 GPR - Shipped Cancelled Order(Ship)</option>
			<option value="16A">16A GPR - Shipped Cancelled Order (C/S) </option>
			<option value="16B">16B GPR - Customer Cancellation</option>
			<option value="17">17 GPR - A/S Ship Error - Delivery Time</option>
			<option value="18">18 GPR - A/S Ship Error - Wrong Customer</option>
			<option value="19">19 GPR - A/S Ship Error - Duplicat Order</option>
			<option value="19A">19A GPR - Exception</option>
			</select>
			</div>
		</li>		
		<li>
			<label for="incoTerm" class="required">Inco Term<em>*</em></label>
			<div class="input-box">
			<select name="incoTerm" id="incoTerm">
			<option value="FFA-ORIGIN" >FFA/Origin(Prepaid) </option>
			<option value="CFO-Collect" >CFO/Collect(Collect) </option>
			<option value="CPT-Origin" >CPT/Origin</option>
			
			</select>
			</div>
		</li>
		<li>
			<label for="forwardingAgent" class="required">Forwarding Agent<em>*</em></label>
			<div class="input-box">
			<select name="forwardingAgent" id="forwardingAgent">
			<option value="OVNT" >UPS Freight </option>
			<option value="RDWY" >Roadway </option>
			<option value="FDXG" >Fed-ex Ground </option>
			</select>
			</div>
		</li>
		<li>
			<label for="restockFees" >Restock Fees</label>
			<div class="input-box">
				<input type="text" id="restockFees" name="restockFees" style="width:100%" value="0.00">
			</div>
			</div>
		</li>
		<% } %>
		</ul>
		
		
	</div>
	</div> <!-- Col 3 of Order Header -->
</div> <!-- End of header Column 3 Set -->
<!--
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
-->
<% if(!"CU".equals(userRole)){ %>
<div class="col2-set">
	<div class="col-1">
	<div class="info-box">
		<h2 class="sub-title" style="padding-top:10px">Additional Information From Customer</h2>
		<textarea rows="4" cols="50" name="retText" id="retText"></textarea>
		<br>
	</div>
	</div>
	<div class="col-2">
	<div class="info-box">
		<h2 class="sub-title" style="padding-top:10px">Invoice Notes</h2>
			<textarea rows="4" cols="50" name="invNotes" id="invNotes"></textarea>
	</div>
	</div>
</div>	
<% } else { %>
<div class="col1-set">
	<div class="col-1">
	<div class="info-box">
		<h2 class="sub-title" style="padding-top:10px">Additional Information From Customer</h2>
		<textarea rows="4" cols="50" name="retText" id="retText"></textarea>
		<br>
	</div>
	</div>
</div>
<% } %>
<% } %>
<br>
<div id="divAction" style="display:block;float:left">
	<button type="button" title="Back" class="button" onclick="javascript:funBackSubmit()">
	<span class="left-link">Back to Order</span></button>
</div>
<div id="divAction2" style="display:block;float:right">
<% 
	if (cancOrRGA.equals("C"))
	{
%>
		<input type="hidden" name="selShipTo"  value='<%=request.getParameter("shipToCode")%>'>
		<input type="hidden" name="poDate"  value='<%=request.getParameter("poDate")%>'>
		<button type="button" title="Cancel" class="button" onclick="javascript:funSubmit()">
		<span class="right-link" >Submit to Cancel</span></button>
<% 
	} else {
%>
		<input type="hidden" name="poDate"  value='<%=request.getParameter("poDate")%>'>
		<button type="button" title="Submit RGA" class="button btn-black" onclick="javascript:funSubmitRGA()">
		<span class="right-link" >Submit RGA Request</span></button>
<% 
	}
%>
</div>
<br>
<div class="col1-set">
<div class="info-box"><br>

	<table class="data-table" id="cancelLines">
	<thead>
	<tr>
	<th> Image <br> Brand </th>
	<!-- <th width=8%>SO No. / Item</th> -->
	<th width=30%>Product Info</th>
	<!--<th width=30%>Description</th> -->
	<th width=10%>Quantity</th>
	<% if (cancOrRGA.equals("C")){ %>
	<th width=25%>Rejection Reason</th>
	<th width=20%>Comments</th>
	<% }  else { %>
	<th width=25%>Material Returned</th>
	<th width=20%>Net Price</th>
	<th width=20%>Qty Returned</th>
	<th width=20%>Net Value</th>
	<% } %>
	</tr>
	</thead>
	<tbody>
	
<%
	String showImages = (String)session.getValue("SHOWIMAGES");
	ReturnObjFromRetrieve valueMapObj = null;

	ezc.ezparam.EzcParams valueMapMainParams = new ezc.ezparam.EzcParams(false);
	EziMiscParams valueMapMiscParams = new EziMiscParams();
	valueMapMiscParams.setIdenKey("MISC_SELECT");
	String valueMapQuery="SELECT * from EZC_VALUE_MAPPING WHERE MAP_TYPE='REJREASONS'";
	valueMapMiscParams.setQuery(valueMapQuery);
	valueMapMainParams.setLocalStore("Y");
	valueMapMainParams.setObject(valueMapMiscParams);
	Session.prepareParams(valueMapMainParams);	
	try{	valueMapObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(valueMapMainParams);
	}
	catch(Exception e){out.println("Exception in Reading Value Mapping Table"+e);}

	for(int i=0;i<poItems.length;i++)
	{
		String poItemStr = poItems[i];

		String cancelType	=  request.getParameter("cancelType"+poItemStr);
		String selForCancaellation = request.getParameter("selForCancaellation"+poItemStr);

		if (cancOrRGA.equals("C")){
		// Case of Cancellations
		if("N".equals(selForCancaellation) && !"Y".equals(cancelAllItems)) // If Item is not selected and Cancel Order is selected.
			continue;
			
		if("C".equals(selForCancaellation) || "RGA".equals(cancelType))	// If Item is already cancelled || Request for RGA selected.
			continue;
		} else {
		// Case of RGAs
		if("N".equals(selForCancaellation) || "C".equals(selForCancaellation))	// If Item is NOT SELECTED. IN RGA, there is NO RGA ALL OPTION 
			continue;
		}

		String prodCode  	= request.getParameter("prodCode"+poItemStr);
		String prodDesc  	= request.getParameter("prodDesc"+poItemStr);
		String quantity  	= request.getParameter("quantity"+poItemStr);
		String salesOrderItem  	= request.getParameter("salesOrderItems"+poItemStr);
		String prodtnurl 	= request.getParameter("prodtnurl"+poItemStr);
		String prodbrand 	= request.getParameter("prodbrand"+poItemStr);
		String retQty		= request.getParameter("retQtyHRGA"+poItemStr);
		String retMat		= request.getParameter("retMatHRGA"+poItemStr);
		String retMatNP 	= request.getParameter("retMatNP"+poItemStr);
		String retInvNo 	= request.getParameter("retInvNo"+poItemStr);
		String salesOrg 	= request.getParameter("salesOrg"+poItemStr);
		String distChannel 	= request.getParameter("distChannel"+poItemStr);
		String division 	= request.getParameter("division"+poItemStr);
		String retRGAComp 	= request.getParameter("retRGAComp"+poItemStr);

		boolean compBol = true;

		if(retRGAComp!=null && (retRGAComp.indexOf("е"))!=-1)
			compBol = false;

		// Also handle retQtyComp and retMatComp . Format would be retMatComp+SoNo+parentLineNo+compLineNo 

		salesOrderItem		= salesOrderItem.replaceAll("#","/");

		if(compBol)
		{
%>
		<tr>
			<td style="vertical-align:top">
			<% if ("Y".equals(showImages)) { %>
			<img  src="<%=prodtnurl%>" width="100" height"160"  alt="" />
			<% } %>
			<p align="center"><%=prodbrand%></p>
			</td>
			<!--<td width=8%></td> -->
			<td width=7% style="vertical-align:top"><strong>Product#</strong>&nbsp;<a target="_blank" href="javascript:getProductDetails('<%=prodCode.trim()%>')" title="<%=prodDesc%>" ><%=prodCode%></a><br>
			<%=prodDesc%><br>
			<strong>Ref#</strong>&nbsp;<%=salesOrderItem%>
			<br><strong>Invoice#</strong>&nbsp;<%=retInvNo%></td>
			<td width=10% align='right' style="vertical-align:top"><%=quantity%></td>
			<% if (cancOrRGA.equals("C")){ %>
			<td width=25% style="vertical-align:top">
			<Select name='reasonForRej<%=poItemStr%>'>
			<Option value="">--Select Reason--</Option>
			<% } %>
			<%
			if (cancOrRGA.equals("C")){
			if(valueMapObj!=null && valueMapObj.getRowCount()>0)
			{
				for (int vm=0;vm<valueMapObj.getRowCount();vm++) {
					String reasCode = valueMapObj.getFieldValueString(vm,"VALUE1");
					String reasDesc = valueMapObj.getFieldValueString(vm,"VALUE2");
			%>
					<Option value='<%=reasCode%>'><%=reasDesc%></Option>
			<%
				} // end for vm
			} // end if valueMapObj
			
			%>
					

			</Select>
			</td>
			<td width=20% valign="top" style="vertical-align:top"><input type='text' name='comments<%=poItemStr%>' maxlength='400'></td>
			<% }  // end of if cancOrRGA check %>
			<% if (cancOrRGA.equals("RGA")){ 
				java.math.BigDecimal itemQty1 = (new  java.math.BigDecimal(retQty));
				java.math.BigDecimal itemValueBD = new java.math.BigDecimal(retMatNP);
				itemValueBD = itemValueBD.multiply(itemQty1);			
				String retMatNVal = itemValueBD.setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
			%>
			<td width=20% valign="top" style="vertical-align:top"><%=retMat%></td>
			<% if(!"CU".equals(userRole)){ %>
			<td width=20% valign="top" style="vertical-align:top"><input type="text" id="retMatNP<%=poItemStr%>" name="retMatNP<%=poItemStr%>" value="<%=retMatNP%>"></input></td>
			<% } else {  %>
			<td width=20% valign="top" style="vertical-align:top"><%=retMatNP%></td>
			<% } %>
			<td width=20% valign="top" style="vertical-align:top"><%=retQty%></td>
			<td width=20% valign="top" style="vertical-align:top"><%=retMatNVal%></td>
			<% } %>
			<input type='hidden' name='poItems' value='<%=poItemStr%>'>
			<input type='hidden' name='prodCode<%=poItemStr%>' value='<%=prodCode%>'>
			<input type='hidden' name='prodDesc<%=poItemStr%>' value='<%=prodDesc%>'>
			<input type='hidden' name='quantity<%=poItemStr%>' value='<%=quantity%>'>
			<input type='hidden' name='salesOrderItem<%=poItemStr%>' value='<%=salesOrderItem%>'>
			<input type='hidden' name='cancelType<%=poItemStr%>' value='<%=cancelType%>'>
			<input type='hidden' name='prodtnurl<%=poItemStr%>' value='<%=prodtnurl%>'>
			<input type='hidden' name='prodbrand<%=poItemStr%>' value='<%=prodbrand%>'>
			<input type='hidden' name='retQty<%=poItemStr%>' value='<%=retQty%>'>
			<input type='hidden' name='retMat<%=poItemStr%>' value='<%=retMat%>'>
			<input type='hidden' name='retMatNP<%=poItemStr%>' value='<%=retMatNP%>'>
			<input type='hidden' name='retInvNo<%=poItemStr%>' value='<%=retInvNo%>'>
			<input type='hidden' name='salesOrg<%=poItemStr%>' value='<%=salesOrg%>'>
			<input type='hidden' name='division<%=poItemStr%>' value='<%=division%>'>
			<input type='hidden' name='distChannel<%=poItemStr%>' value='<%=distChannel%>'>
			<input type='hidden' name='parentCode<%=poItemStr%>' value=''>
			
		</tr>
<%
		}
		else
		{
			java.util.Hashtable compInfoHT = new java.util.Hashtable();
			java.util.StringTokenizer retRGACompST = null;
			if(retRGAComp!=null && (retRGAComp.indexOf("з"))!=-1)
			{
				java.util.StringTokenizer retRGACompST1 = new java.util.StringTokenizer(retRGAComp,"з");

				if(retRGACompST1!=null)
				{
					while(retRGACompST1.hasMoreElements())
					{
						String retRGACompStr = (String)retRGACompST1.nextElement();

						retRGACompST = new java.util.StringTokenizer(retRGACompStr,"е");

						while(retRGACompST.hasMoreElements())
						{
							String val1 = (String)retRGACompST.nextElement();
							String val2 = (String)retRGACompST.nextElement();
							String val3 = (String)retRGACompST.nextElement();
							String val4 = (String)retRGACompST.nextElement();
							String val5 = (String)retRGACompST.nextElement();
							String val6 = (String)retRGACompST.nextElement();
							String val7 = (String)retRGACompST.nextElement();
							compInfoHT.put(val7,val1+"е"+val2+"е"+val3+"е"+val4+"е"+val5+"е"+val6);
						}
					}
				}
			}
			else
			{
				retRGACompST = new java.util.StringTokenizer(retRGAComp,"е");

				while(retRGACompST.hasMoreElements())
				{
					String val1 = (String)retRGACompST.nextElement();
					String val2 = (String)retRGACompST.nextElement();
					String val3 = (String)retRGACompST.nextElement();
					String val4 = (String)retRGACompST.nextElement();
					String val5 = (String)retRGACompST.nextElement();
					String val6 = (String)retRGACompST.nextElement();
					String val7 = (String)retRGACompST.nextElement();
					compInfoHT.put(val7,val1+"е"+val2+"е"+val3+"е"+val4+"е"+val5+"е"+val6);
				}
			}
			Enumeration compEnum_Keys = compInfoHT.keys();
			for(int cnt=0;cnt<compInfoHT.size();cnt++)
			{
				String compEnum = (String)compEnum_Keys.nextElement();
				String retVal = (String)compInfoHT.get(compEnum);

				poItemStr = compEnum+"";
				retMat = retVal.split("е")[0];
				retQty = retVal.split("е")[1];
				retMatNP = retVal.split("е")[2];
				prodDesc = retVal.split("е")[3];
				prodCode = retVal.split("е")[4];
				String parentCode = retVal.split("е")[5];
				salesOrderItem = poItemStr.substring(0,10)+"/"+poItemStr.substring(10);
%>
		<tr>
			<td style="vertical-align:top">
			<% if ("Y".equals(showImages)) { %>
			<img  src="<%=prodtnurl%>" width="100" height"160"  alt="" />
			<% } %>
			<p align="center"><%=prodbrand%></p>
			</td>
			<!--<td width=8%></td> -->
			<td width=7% style="vertical-align:top"><strong>Product#</strong>&nbsp;<a target="_blank" href="javascript:getProductDetails('<%=prodCode.trim()%>')" title="<%=prodDesc%>" ><%=prodCode%></a><br>
			<%=prodDesc%><br>
			<strong>Ref#</strong>&nbsp;<%=salesOrderItem%>
			<br><strong>Invoice#</strong>&nbsp;<%=retInvNo%>
			<br><strong>Ordered Item#</strong>&nbsp;<%=parentCode%></td>
			<td width=10% align='right' style="vertical-align:top"><%=quantity%></td>
			<% if (cancOrRGA.equals("C")){ %>
			<td width=25% style="vertical-align:top">
			<Select name='reasonForRej<%=poItemStr%>'>
			<Option value="">--Select Reason--</Option>
			<% } %>
			<%
			if (cancOrRGA.equals("C")){
			if(valueMapObj!=null && valueMapObj.getRowCount()>0)
			{
				for (int vm=0;vm<valueMapObj.getRowCount();vm++) {
					String reasCode = valueMapObj.getFieldValueString(vm,"VALUE1");
					String reasDesc = valueMapObj.getFieldValueString(vm,"VALUE2");
			%>
					<Option value='<%=reasCode%>'><%=reasDesc%></Option>
			<%
				} // end for vm
			} // end if valueMapObj
			
			%>
					

			</Select>
			</td>
			<td width=20% valign="top" style="vertical-align:top"><input type='text' name='comments<%=poItemStr%>' maxlength='400'></td>
			<% }  // end of if cancOrRGA check %>
			<% if (cancOrRGA.equals("RGA")){ 
				java.math.BigDecimal itemQty1 = (new  java.math.BigDecimal(retQty));
				java.math.BigDecimal itemValueBD = new java.math.BigDecimal(retMatNP);
				itemValueBD = itemValueBD.multiply(itemQty1);			
				String retMatNVal = itemValueBD.setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
			%>
			<td width=20% valign="top" style="vertical-align:top"><%=retMat%></td>
			<% if(!"CU".equals(userRole)){ %>
			<td width=20% valign="top" style="vertical-align:top"><input type="text" id="retMatNP<%=poItemStr%>" name="retMatNP<%=poItemStr%>" value="<%=retMatNP%>"></input></td>
			<% } else {  %>
			<td width=20% valign="top" style="vertical-align:top"><%=retMatNP%></td>
			<% } %>
			<td width=20% valign="top" style="vertical-align:top"><%=retQty%></td>
			<td width=20% valign="top" style="vertical-align:top"><%=retMatNVal%></td>
			<% } %>
			<input type='hidden' name='poItems' value='<%=poItemStr%>'>
			<input type='hidden' name='prodCode<%=poItemStr%>' value='<%=prodCode%>'>
			<input type='hidden' name='prodDesc<%=poItemStr%>' value='<%=prodDesc%>'>
			<input type='hidden' name='quantity<%=poItemStr%>' value='<%=quantity%>'>
			<input type='hidden' name='salesOrderItem<%=poItemStr%>' value='<%=salesOrderItem%>'>
			<input type='hidden' name='cancelType<%=poItemStr%>' value='<%=cancelType%>'>
			<input type='hidden' name='prodtnurl<%=poItemStr%>' value='<%=prodtnurl%>'>
			<input type='hidden' name='prodbrand<%=poItemStr%>' value='<%=prodbrand%>'>
			<input type='hidden' name='retQty<%=poItemStr%>' value='<%=retQty%>'>
			<input type='hidden' name='retMat<%=poItemStr%>' value='<%=retMat%>'>
			<input type='hidden' name='retMatNP<%=poItemStr%>' value='<%=retMatNP%>'>
			<input type='hidden' name='retInvNo<%=poItemStr%>' value='<%=retInvNo%>'>
			<input type='hidden' name='salesOrg<%=poItemStr%>' value='<%=salesOrg%>'>
			<input type='hidden' name='division<%=poItemStr%>' value='<%=division%>'>
			<input type='hidden' name='distChannel<%=poItemStr%>' value='<%=distChannel%>'>
			<input type='hidden' name='parentCode<%=poItemStr%>' value='<%=parentCode%>'>
			
		</tr>
<%
			}
		}
	}
%>
	</tbody>
	</table>
</div>
</div>
<script>
	selectedShipTos()
</script>
<%
	}
%>
</div>
</div>
</div>
</form>
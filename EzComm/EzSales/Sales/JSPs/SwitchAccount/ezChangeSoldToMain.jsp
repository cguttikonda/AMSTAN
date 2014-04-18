<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>

<%@ page import = "ezc.ezparam.*" %>
<%@ page import="ezc.ezparam.*,ezc.ezbasicutil.*,java.util.*" %>
<%@ page import="ezc.customer.invoice.params.*,ezc.ezmisc.params.*,ezc.ezadmin.ezadminutils.params.*" %>
<%@ page import="java.text.*,ezc.ezsap.*,ezc.client.*,ezc.ezutil.FormatDate" %>

<%@ include file="../../../Includes/JSPs/SwitchAccount/iChangeSoldTo.jsp"%>
<%
	String sysKeyDesc ="";
	String sysKeyVal ="";
	if(session.getValue("SCList")!= null)
		session.removeValue("SCList");
	if(session.getValue("customers") != null)
		session.removeValue("customers");

	session.putValue("CRI_CUST_SAS",retcatarea);
	if((soldtoRows==1) && (catareaRows == 1))
	{
		String tempSoldTo = retsoldto.getFieldValueString(0,"EC_ERP_CUST_NO");

		if(tempSoldTo.indexOf("&")>=0)
			tempSoldTo = tempSoldTo.replaceAll("&","@");	 
	}

	String selSoldTo = request.getParameter("selSoldTo");

	if(selSoldTo==null || "null".equalsIgnoreCase(selSoldTo) || "".equals(selSoldTo))
		selSoldTo = (String)session.getValue("AgentCode");

	String selShipTo = request.getParameter("selShipTo");

	if(selShipTo==null || "null".equalsIgnoreCase(selShipTo) || "".equals(selShipTo))
		selShipTo = (String)session.getValue("ShipCode");

	String selSoldName 	= "";
	String selSoldAddr1	= "";
	String selSoldCity 	= "";
	String selSoldState 	= "";
	String selSoldCountry 	= "";
	String selSoldZipCode	= "";
	String selSoldPhNum 	= "";
	String selSoldEmail 	= "";
%> 

<style>
	#input {
		box-shadow: inset 0px 0px 0px ; 
		-moz-box-shadow: inset 0px 0px 0px ; 
		-webkit-box-shadow: inset 0px 0px 0px ; 
		border: none; 
	}
</style>
<link href="../../Library/Styles/dd.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>
<script type="text/javascript" src="../../Library/Script/jquery-ui-1.8.21.all.min.js"></script>
<script type="text/javascript" src="../../Library/Styles/jquery.dd.js"></script>
<Script src="../../Library/Script/popup.js"></Script>
<script type="text/javascript">
$(function() 
{
	$( "#dialog-confirm1" ).dialog({
		autoOpen: false,
		resizable: true,
		height:164,
		width:584,
		modal: true,
		buttons: {
			"Ok": function() {
				$( this ).dialog( "close" );
				Popup.showModal('modal1');
				document.myForm.action="../SwitchAccount/ezSaveDefaultSoldToMain.jsp"
				document.myForm.submit();
			},
			"Cancel": function() {
				$( this ).dialog( "close" );
			}
		}
	});

	$( "#dialog-changeShip" ).dialog({
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
function save()
{
	var textMsg = "Are you sure you want to change the Default Ship To?";
	$("#dialog-confirm1").dialog('open').text(textMsg);
}

var xmlhttp

function checkdefShipto()
{
	var defShip	= '<%=sesShipTo%>';
	var selSoldTo	= document.myForm.selSoldTo.value;
 	var selShipTo	= document.myForm.selShipTo.value;
 	shipCode	= selShipTo.split('#')[7];
	var cartCnt	= '<%=cartCnt%>';

	if(cartCnt>0 && defShip != shipCode)
	{
		xmlhttp=GetXmlHttpObject();

		if (xmlhttp==null)
		{
			$( "#dialog-changeShip" ).dialog("option", "title", "Browser Does Not Support");
			$( "#dialog-changeShip" ).dialog('open').text("Your browser does not support Ajax HTTP");
			return;
		}

		var url="../Misc/ezAttributeCheck.jsp";
		url=url+"?shipToCode="+shipCode+"&soldToCode="+selSoldTo;

		xmlhttp.onreadystatechange=getOutput;
		xmlhttp.open("GET",url,true);
		xmlhttp.send(null);
	}
	else
	{
		save();
	}
}
function getOutput()
{
	if (xmlhttp.readyState==4)
	{
		var resText = xmlhttp.responseText;
		var resultText	= resText.split("##");
		var allowed	= resultText[1];

		if(allowed=='Y')
		{
			save();
		}
		else
		{
			var textMsg = 'One or more items in Cart may be flagged with "Not Allowed in Your Portfolio or Default Ship-To"! Click on the OK button if you want to change the default Ship To?';
			$("#dialog-confirm1").dialog('open').text(textMsg);
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

function selectedSoldTos()
{
	document.myForm.action="ezChangeSoldTo.jsp"
	document.myForm.submit();
}
function selectedShipTos()
{
 	var selShipTo=document.myForm.selShipTo.value
 	//alert(selShipTo)
 	shipName	= selShipTo.split('#')[0]
	shipStreet	= selShipTo.split('#')[1]
	shipCity	= selShipTo.split('#')[2]
	shipState	= selShipTo.split('#')[3]
	shipCountry	= selShipTo.split('#')[4]
	shipZip		= selShipTo.split('#')[5]
	shipPhNum	= selShipTo.split('#')[6]
	shipCodes	= selShipTo.split('#')[7]

	document.myForm.selShipTo_S.value 	= shipCodes 
	document.myForm.shipToName.value 	= shipName
	document.myForm.shipToStreet.value	= shipStreet
	document.myForm.shipToCity.value 	= shipCity
	document.myForm.shipToState.value 	= shipState
	document.myForm.shipToCountry.value 	= shipCountry
	document.myForm.shipToZip.value 	= shipZip
	document.myForm.shipToPhone.value 	= shipPhNum
}
</script>
<body onLoad="selectedShipTos()">
<form name="myForm"  method="post" >
<input type="hidden" name="selShipTo_S" value="">
<input type="hidden" name="CatalogArea" value="<%=session.getValue("SalesAreaCode")%>">
<div class="main-container col2-layout middle account-pages">
<div class="main">
<div class="col-main1 roundedCorners">
<div class="page-title">

<h2>Switch SoldTo</h2>
<div class="welcome-msg">
<H3>
	<p>myASB2B.com will use the selected sold to and ship to information to pre-populate address (for Availability check) and during Order Creation.</p>
	<p>It will NOT limit your ability to override the selection when performing actions in the portal. </p>
</H3>
</div>

<ul class="form-list">
<li>
	<label for="soldtoname" >Sold To ID </label>
	<div class="input-box">
	<select name="selSoldTo" onChange="selectedSoldTos();" style="width:400px;">
<%
	retsoldtoSA = (ReturnObjFromRetrieve)session.getValue("retsoldto_A_Ses");
	if(retsoldtoSA!=null)
	{
		for(int i=0;i<retsoldtoSA.getRowCount();i++)
		{
			String soldToCode_A 	= retsoldtoSA.getFieldValueString(i,"EC_ERP_CUST_NO");
			String soldToName_A 	= retsoldtoSA.getFieldValueString(i,"ECA_NAME");

			String selected_A = "selected";

			if(selSoldTo.equals(soldToCode_A))
			{
				catalog_areaSA  = retsoldtoSA.getFieldValueString(i,"EC_SYS_KEY");
				selSoldToSA 	= soldToCode_A;
%>
				<option value="<%=soldToCode_A%>" <%=selected_A%>><%=soldToName_A%> : <%=soldToCode_A%></option>
<%
			}
			else
			{
%>
				<option value="<%=soldToCode_A%>" ><%=soldToName_A%> : <%=soldToCode_A%></option>
<%
			}
		}
	}
%>
	</select>
	</div>
</li>
<%@ include file="../../../Includes/JSPs/SwitchAccount/iGetShipTo.jsp"%>
<li>
	<label for="shiptoname" >Ship To ID </label>
	<div class="input-box">
	<select name="selShipTo" onChange="selectedShipTos()"  style="width:400px;">	
<%
	String shipToName = "";
	String shipAddr1 = "";
	String shipAddr2 = "";
	String shipState = "";
	String shipCountry = "";
	String shipZip = "";
	String shipPhNum = "";
	int sl=0;
	if(listShipTosCS!=null)
	{
		for(int l=0;l<listShipTosCS.getRowCount();l++)
		{
			String tempShip = listShipTosCS.getFieldValueString(l,"ECA_ACCOUNT_GROUP");
			if("CPDA".equalsIgnoreCase(tempShip))
				continue;

			String shipToCode_A 	= listShipTosCS.getFieldValueString(l,"EC_PARTNER_NO");
			String shipToName_A 	= listShipTosCS.getFieldValueString(l,"ECA_NAME");
			shipAddr1  		= listShipTosCS.getFieldValueString(l,"ECA_ADDR_1"); //Street
			shipAddr2  		= listShipTosCS.getFieldValueString(l,"ECA_CITY");
			shipState  		= listShipTosCS.getFieldValueString(l,"ECA_STATE");
			shipCountry  		= listShipTosCS.getFieldValueString(l,"ECA_COUNTRY");
			shipZip    		= listShipTosCS.getFieldValueString(l,"ECA_PIN");
			shipPhNum    		= listShipTosCS.getFieldValueString(l,"ECA_PHONE");

			shipAddr1 	= (shipAddr1==null || "null".equals(shipAddr1)|| "".equals(shipAddr1))?"":shipAddr1;
			shipAddr2 	= (shipAddr2==null || "null".equals(shipAddr2)|| "".equals(shipAddr2))?"":shipAddr2;// for city
			shipState 	= (shipState==null || "null".equals(shipState) || "".equals(shipState))?"":shipState;
			shipCountry 	= (shipCountry==null || "null".equals(shipCountry)|| "".equals(shipCountry))?"":shipCountry.trim();
			shipZip 	= (shipZip==null || "null".equals(shipZip)|| "".equals(shipZip))?"":shipZip;
			shipPhNum 	= (shipPhNum==null || "null".equals(shipPhNum)|| "".equals(shipPhNum))?"":shipPhNum;

			String shipParams = shipToName_A+"#"+shipAddr1+"#"+shipAddr2+"#"+shipState+"#"+shipCountry+"#"+shipZip+"#"+shipPhNum+"#"+shipToCode_A;

			String selected_A = "selected";

			if(selShipToSA.equals(shipToCode_A))
			{
				sl=l;
%>
				<option value="<%=shipParams%>" <%=selected_A%>><%=shipToName_A%> : <%=shipToCode_A%></option>
<%
			}
			else
			{
%>
				<option value="<%=shipParams%>" ><%=shipToName_A%> : <%=shipToCode_A%></option>
<%
			}

			shipToName 	= listShipTosCS.getFieldValueString(sl,"ECA_NAME");
			shipAddr1  	= listShipTosCS.getFieldValueString(sl,"ECA_ADDR_1"); //Street
			shipAddr2  	= listShipTosCS.getFieldValueString(sl,"ECA_CITY");
			shipState  	= listShipTosCS.getFieldValueString(sl,"ECA_STATE");
			shipCountry  	= listShipTosCS.getFieldValueString(sl,"ECA_COUNTRY");
			shipZip    	= listShipTosCS.getFieldValueString(sl,"ECA_PIN");
			shipPhNum    	= listShipTosCS.getFieldValueString(sl,"ECA_PHONE");

			shipAddr1 	= (shipAddr1==null || "null".equals(shipAddr1)|| "".equals(shipAddr1))?"":shipAddr1;
			shipAddr2 	= (shipAddr2==null || "null".equals(shipAddr2)|| "".equals(shipAddr2))?"":shipAddr2;// for city
			shipState 	= (shipState==null || "null".equals(shipState) || "".equals(shipState))?"":shipState;
			shipCountry 	= (shipCountry==null || "null".equals(shipCountry)|| "".equals(shipCountry))?"":shipCountry.trim();
			shipZip 	= (shipZip==null || "null".equals(shipZip)|| "".equals(shipZip))?"":shipZip;
			shipPhNum 	= (shipPhNum==null || "null".equals(shipPhNum)|| "".equals(shipPhNum))?"":shipPhNum;
		}
	}
%>
	</select>
	</div>
</li>
<br>
<li>
	<h2>Ship To Addrress:</h2>
</li>
<li>
	<label for="shipToName">Ship To Name: </label>
	<div class="input-box">
		<input type="text"  id="input"  name="shipToName" value="<%=shipToName%>" size=50 readonly>
	</div>
</li>
<li>
	<label for="shipToStreet">Street: </label>
	<div class="input-box">
		<input type="text"  id="input"  name="shipToStreet" value="<%=shipAddr1%>" readonly>
	</div>
</li>
<li>
	<label for="city-state-zip">City/ State/ Zip: </label>
	<div class="input-box">
		<input type="text"  id="input"  name="shipToCity" value="<%=shipAddr2%>" readonly>
		<input type="text"  id="input"  name="shipToState" value="<%=shipState%>" readonly>
		<input type="text"  id="input"  name="shipToZip" value="<%=shipZip%>" readonly>
		<input type="hidden" name="shipToCountry">
	</div>
</li>
<li>
	<label for="shipToPhone">Phone: </label>
	<div class="input-box">
		<input type="text"  id="input" name="shipToPhone" value="<%=shipPhNum%>" readonly>
	</div>
</li>
</ul>
</div>
<div id="dialog-confirm1" title="Confirmation" style="display:none"></Div>
<div id="dialog-changeShip" title="Confirmation" style="display:none"></Div>
<div class="buttons-set form-buttons">
	<p class="back-link"><a href="../Misc/ezDashBoard.jsp"><small>&laquo; </small>Go Home</a></p>
	<button type="button" class="button" onClick="checkdefShipto();"><span><span>Save</span></span></button>
</div>
<div class="col1-set">
<div class="info-box">
</div> <!-- Info box -->
</div> <!-- col1-set -->
</div> <!-- col-main -->
</div> <!--main -->
</div> <!-- main-container col1-layout -->
<div id="modal1" style="width: 500px; height:180px; display: none; ">
<div align=center  style="padding-top:10px;">
	<ul>
		<li>&nbsp;</li>
		<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
		<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
	</ul>
</div>
</div>
</form>
<script language="javascript" type="text/javascript">
$(document).ready(function() {
	try {
		oHandler = $(".mydds").msDropDown().data("dd");
		$("#ver").html($.msDropDown.version);
	} catch(e) {
		alert("Error: "+e.message);
	}
});
</script>
</body>
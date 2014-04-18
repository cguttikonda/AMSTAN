<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iStatesRetObj.jsp"%>
<%!
	public ezc.ezparam.ReturnObjFromRetrieve getListOfSoldTos(String partCode,String partName,String partStreet,String partCity,String partState,String site_S)
	{
		String[] retCols = new String[]{"SHIPCODE","SHIPNAME","SHIPSTREET","SHIPCITY","SHIPSTATE","SHIPCOUNTRY","SHIPPOSTCODE","SHIPPHONE","ACCGROUP"};
		ezc.ezparam.ReturnObjFromRetrieve retObjShipTo = new ezc.ezparam.ReturnObjFromRetrieve(retCols);

		com.sap.mw.jco.JCO.Function functionPlant = null;
		com.sap.mw.jco.JCO.Client clientPlant = null;

		String skey_S = "999";

		String queryStr = "KTOKD NE 'CPDA' AND AUFSD NE '01'";//,'0002'

		if(!"".equals(nullCheck(partCode)))
			queryStr = queryStr + " AND KUNNR LIKE '%"+partCode+"%'";
		if(!"".equals(nullCheck(partName)))
			queryStr = queryStr + " AND NAME1 LIKE '%"+partName.toUpperCase()+"%'";
		if(!"".equals(nullCheck(partStreet)))
			queryStr = queryStr + " AND STRAS LIKE '%"+partStreet.toUpperCase()+"%'";
		if(!"".equals(nullCheck(partCity)))
			queryStr = queryStr + " AND ORT01 LIKE '%"+partCity.toUpperCase()+"%'";
		if(!"".equals(nullCheck(partState)))
			queryStr = queryStr + " AND REGIO LIKE '%"+partState.toUpperCase()+"%'";

		try
		{
			functionPlant = ezc.sapconnection.EzSAPHandler.getFunction("RFC_READ_TABLE",site_S+"~"+skey_S);
			clientPlant = ezc.sapconnection.EzSAPHandler.getSAPConnection(site_S+"~"+skey_S);

			com.sap.mw.jco.JCO.ParameterList paramIn    = functionPlant.getImportParameterList();
			com.sap.mw.jco.JCO.ParameterList paramTable = functionPlant.getTableParameterList();

			com.sap.mw.jco.JCO.Table fields  = paramTable.getTable("FIELDS");

			paramIn.setValue("KNA1","QUERY_TABLE");
			paramIn.setValue("¥","DELIMITER");
			paramIn.setValue("100","ROWCOUNT");

			fields.appendRow();
			fields.setValue("KUNNR","FIELDNAME");
			fields.appendRow();
			fields.setValue("NAME1","FIELDNAME");
			fields.appendRow();
			fields.setValue("STRAS","FIELDNAME");
			fields.appendRow();
			fields.setValue("ORT01","FIELDNAME");
			fields.appendRow();
			fields.setValue("REGIO","FIELDNAME");
			fields.appendRow();
			fields.setValue("LAND1","FIELDNAME");
			fields.appendRow();
			fields.setValue("PSTLZ","FIELDNAME");
			fields.appendRow();
			fields.setValue("TELF1","FIELDNAME");
			fields.appendRow();
			fields.setValue("KTOKD","FIELDNAME");

			com.sap.mw.jco.JCO.Table options  = paramTable.getTable("OPTIONS");

			options.appendRow();
			options.setValue(queryStr,"TEXT");

			try
			{
				clientPlant.execute(functionPlant);
			}
			catch(Exception e)
			{
				ezc.ezcommon.EzLog4j.log("Exception while executing RFC call RFC_READ_TABLE in ezSearchShipToPOP.jsp>>"+e,"I");
			}

			com.sap.mw.jco.JCO.ParameterList  paramOut = functionPlant.getExportParameterList();
			com.sap.mw.jco.JCO.Table 	  fieldsOut = functionPlant.getTableParameterList().getTable("DATA");

			int fieldsOutCount = fieldsOut.getNumRows();

			if(fieldsOutCount>0)
			{
				do
				{
					String plantStr = (String)fieldsOut.getValue("WA");

					String shipCode = "";
					String shipName = "";
					String shipStreet = "";
					String shipCity = "";
					String shipState = "";
					String shipCountry = "";
					String shipPostCode = "";
					String shipPhone = "";
					String accGroup = "";

					try
					{
						shipCode = plantStr.split("¥")[0];
					}
					catch(Exception e){}
					try
					{
						shipName = plantStr.split("¥")[1];
					}
					catch(Exception e){}
					try
					{
						shipStreet  = plantStr.split("¥")[2];
					}
					catch(Exception e){}
					try
					{
						shipCity = plantStr.split("¥")[3];
					}
					catch(Exception e){}
					try
					{
						shipState = plantStr.split("¥")[4];
					}
					catch(Exception e){}
					try
					{
						shipCountry  = plantStr.split("¥")[5];
					}
					catch(Exception e){}
					try
					{
						shipPostCode = plantStr.split("¥")[6];
					}
					catch(Exception e){}
					try
					{
						shipPhone = plantStr.split("¥")[7];
					}
					catch(Exception e){}
					try
					{
						accGroup = plantStr.split("¥")[8];
					}
					catch(Exception e){}

					retObjShipTo.setFieldValue("SHIPCODE",shipCode);
					retObjShipTo.setFieldValue("SHIPNAME",shipName);
					retObjShipTo.setFieldValue("SHIPSTREET",shipStreet);
					retObjShipTo.setFieldValue("SHIPCITY",shipCity);
					retObjShipTo.setFieldValue("SHIPSTATE",shipState);
					retObjShipTo.setFieldValue("SHIPCOUNTRY",shipCountry);
					retObjShipTo.setFieldValue("SHIPPOSTCODE",shipPostCode);
					retObjShipTo.setFieldValue("SHIPPHONE",shipPhone);
					retObjShipTo.setFieldValue("ACCGROUP",accGroup);

					retObjShipTo.addRow();
				}
				while(fieldsOut.nextRow());
			}
		}
		catch(Exception e)
		{
			ezc.ezcommon.EzLog4j.log("Exception while getting plant codes from SAP ::::"+e,"I");
		}
		finally
		{
			if (clientPlant!=null)
			{
				ezc.ezcommon.EzLog4j.log("R E L E A S I N G   C L I E N T .... ","I");
				com.sap.mw.jco.JCO.releaseClient(clientPlant);
				clientPlant = null;
				functionPlant=null;
			}
		}
		//out.println("retObjShipTo::"+retObjShipTo.toEzcString());

		return retObjShipTo;
	}
	public String nullCheck(String str)
	{
		String ret = str;

		if(ret==null || "null".equalsIgnoreCase(ret) || "".equals(ret))
			ret = "";
		else
			ret = ret.trim();

		return ret;
	}
%>
<%
	String soldLable = "ShipTo Id";

	String partCode = request.getParameter("partCode");
	String partName = request.getParameter("partName");
	String partStreet = request.getParameter("partStreet");
	String partCity = request.getParameter("partCity");
	String partState = request.getParameter("partState");

	partCode = nullCheck(partCode);
	partName = nullCheck(partName);
	partStreet = nullCheck(partStreet);
	partCity = nullCheck(partCity);
	partState = nullCheck(partState);

	boolean searchChk = false;
	if(!"".equals(partCode) || !"".equals(partName) || !"".equals(partStreet) || !"".equals(partCity) || !"".equals(partState))
		searchChk = true;

	String site_S = (String)session.getValue("Site");

	ezc.ezparam.ReturnObjFromRetrieve retObjPart = null;
	if(searchChk)
		retObjPart = (ezc.ezparam.ReturnObjFromRetrieve)getListOfSoldTos(partCode,partName,partStreet,partCity,partState,site_S);

%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Search</title>
<%@ include file="../../../Includes/Lib/ezCommonHead.jsp"%>
</head>
<body style="background:#EEEDE7 !important">
<div class="wrapper container" id="top-of-page">
	<noscript>
	&lt;div class="noscript"&gt;
		&lt;div class="noscript-inner"&gt;
		&lt;p&gt;&lt;strong&gt;JavaScript seem to be disabled in your browser.&lt;/strong&gt;&lt;/p&gt;
		&lt;p&gt;You must have JavaScript enabled in your browser to utilize the functionality of this website.&lt;/p&gt;
		&lt;/div&gt;
	&lt;/div&gt;
 	</noscript>
<div class="page">
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
	#example_wrapper .fg-toolbar { font-size: 0.8em }
	#theme_links span { float: left; padding: 2px 10px; }
	#example_wrapper { -webkit-box-shadow: 2px 2px 6px #666; box-shadow: 2px 2px 6px #666; border-radius: 5px; }
	#example tbody {
		border-left: 1px solid #AAA;
		border-right: 1px solid #AAA;
	}
	#example thead th:first-child { border-left: 1px solid #AAA; }
	#example thead th:last-child { border-right: 1px solid #AAA; }
</style>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="../../Library/Script/complete.min.js"></script>
<script type="text/javascript" src="../../Library/Script/jquery.dataTables.min.js"></script> 
<script type="text/javascript" src="../../Library/Script/TableTools-2.1.1/js/TableTools.min.js"></script> 
<script  src="../../Library/Script/colResizable-1.3.min.js"></script>
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

	$(document).ready( function() {
		fnFeaturesInit();
		$('#example').dataTable( {
			"bJQueryUI": true,
			"sPaginationType": "full_numbers",
			"bStateSave":true,
			"bSort" : true
			
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
	$("#example").colResizable({
		liveDrag:true,
		gripInnerHtml:"<div class='grip'></div>",
		draggingClass:"dragging",
		onResize:onSampleResized
	});
});
</script>

<!-- jQuery for sorting & pagination ENDS here -->

<link rel="stylesheet" type="text/css" href="../../Library/Styles/formalize.css">
<script type="text/javascript" src="../../Library/Script/jquery.formalize.js"></script>
<link rel="stylesheet" type="text/css" href="../../Library/Styles/Alerts/jquery.alerts.css">
<script type="text/javascript" src="../../Library/Script/Alerts/jquery.alerts.js"></script>
<script type="text/javascript" src="../../Library/Script/jquery-ui-1.8.21.all.min.js"></script>
<Script src="../../Library/Script/popup.js"></Script> 
<Script language="JavaScript" src="../../Library/JavaScript/Misc/Trim.js"></Script>
<script language = "JavaScript">
function searchUser()
{
	var partCode = document.myForm.partCode.value;
	var partName = document.myForm.partName.value;
	var partStreet = document.myForm.partStreet.value;
	var partCity = document.myForm.partCity.value;
	var partState = document.myForm.partState.value;

	if(partCode=="" && partName=="" && partStreet=="" && partCity=="" && partState=="")
	{
		$("#dialog-search").dialog('open');
	}
	else if(partCode!="" || partName!="" || partStreet!="" || partCity!="" || partState!="" )
	{
		Popup.showModal('modal1');
		document.myForm.action="ezSearchShipToPOP.jsp";
		document.myForm.submit();
	}	
}
function submitenterpostatus(myfield,e)
{
	var keycode;
	if (window.event) keycode = window.event.keyCode;
	else if (e) keycode = e.which;
	else return true;

	if (keycode == 13)
	{
		searchUser()  
	}
}
function getShipToValue(val)
{
	//opener.document.generalForm.selShipToInfo.value=val
	//window.opener.selectedShipTos()

	var selShipTo=val
	//alert(selShipTo)
	shipAddr	= selShipTo.split('¥')[0]
	shipStreet	= selShipTo.split('¥')[1]
	shipCity	= selShipTo.split('¥')[2]
	shipState	= selShipTo.split('¥')[3]
	shipCountry	= selShipTo.split('¥')[4]
	shipZip		= selShipTo.split('¥')[5]
	shipPhNum	= selShipTo.split('¥')[6]
	shipCode	= selShipTo.split('¥')[7]
	accGroup	= selShipTo.split('¥')[8]

	if(shipCountry=="BR") shipCountry = "PR";

	//var shipVal = shipCode+'('+shipAddr+')';
	//var select = opener.document.getElementById("selShipToInfo");
	//select.options[select.options.length] = new Option(shipVal,selShipTo);

	//opener.document.generalForm.selShipToInfo.value = "0999999999";//selShipTo
	opener.document.generalForm.shipToName.value = shipAddr
	opener.document.generalForm.shipToStreet.value	= shipStreet
	opener.document.generalForm.shipToCity.value = shipCity
	opener.document.generalForm.shipToState.value = shipState
	opener.document.generalForm.shipToCountry.value = shipCountry
	opener.document.generalForm.shipToZip.value = shipZip
	opener.document.generalForm.shipToPhone.value = shipPhNum
	opener.document.generalForm.selShipTo.value = "0999999999";//shipCode
	opener.document.generalForm.accGroup.value = accGroup

	//opener.document.getElementById("selShipToInfo").setCustomValidity('');

	window.close();
}
function showAlert()
{
	$("#dialog-showAlert").dialog('open');
}
function doClear()
{
	document.getElementById("myForm").reset()
}
$(function() {
	$( "#dialog-search" ).dialog({
		autoOpen: false,
		resizable: false,
		height:150,
		width:300,
		modal: true,
		buttons: {
			"Ok": function() {
				$( this ).dialog( "close" );
			}
		}
	});
	$( "#dialog-showAlert" ).dialog({
		autoOpen: false,
		resizable: false,
		height:150,
		width:300,
		modal: true,
		buttons: {
			"Ok": function() {
				$( this ).dialog( "close" );
			}
		}
	});
}); // end of function()
</script>
<Style>
#change tr:hover {
	background-color: #ccc;
	cursor: pointer;
}
</Style>
<body scroll=auto onLoad="document.myForm.partCode.focus()">
<form name=myForm id="myForm" method=post >
<div id="dialog-search" title="Enter Search" style="display:none">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Please enter a search criteria.</p>
</div>
<div id="dialog-showAlert" title="Block Alert" style="display:none">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Selected account has been blocked.</p>
</div>
<div id="modal1" style="border:0px solid black; background-color:white; padding:1px; font-size:10;width:40%;height:180px; text-align:center; display:none;">
	<ul>
		<li>&nbsp;</li>
		<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
		<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
	</ul>
</div>
<div class="main-container col2-layout middle account-pages">
<div class="main" style="width:auto !important;">
<div class="col-main roundedCorners" style="width:680px !important; margin-left:30px;">
	<table class="data-table" id="quickatp">
	<thead>
		<th colspan=2 align ="center"><h2> Search Criteria </h2></th>
	</thead>	
	<tbody>
	<Tr>
		<Td><Strong><%=soldLable%></Strong></Td>
		<Td><input type="text" name="partCode" maxlength="10" size="40" value="<%=partCode%>" onKeyPress="return submitenterpostatus(this,event)"></Td>
	</Tr>	
	<Tr>
		<Td><Strong>Name </Strong></Td>
		<Td><input type="text" name="partName" maxlength="15" size="40" value="<%=partName%>" onKeyPress="return submitenterpostatus(this,event)"></Td>
	</Tr>	
	<Tr>
		<Td><Strong>Address</Strong></Td>
		<Td><input type="text" name="partStreet" maxlength="40" size="40" value="<%=partStreet%>" onKeyPress="return submitenterpostatus(this,event)"></Td>
	</Tr>		
	<Tr>
		<Td><Strong>City</Strong></Td>
		<Td><input type="text" name="partCity" maxlength="16" size="40" value="<%=partCity%>" onKeyPress="return submitenterpostatus(this,event)"></Td>
	</Tr>
	<Tr>
		<Td><Strong>State</Strong></Td>
		<style>
		select, select[size="0"], select[size="1"] {background-image:url(data:image/png;base64,R0lGODlhDQAEAIAAAAAAAP8A/yH5BAEHAAEALAAAAAANAAQAAAILhA+hG5jMDpxvhgIAOw==) !important; background-repeat: no-repeat !important; background-position: right center !important; padding-right: 20px !important;}
		</style>
		<Td><select name="partState" width="400px">
			<option value="" >---Select--- </option>
<%
			if(stateRetRes!=null)
			{
				for(int i=0;i<stateRetRes.getRowCount();i++)
				{
					String shipToStateCode 	= stateRetRes.getFieldValueString(i,"STATECODE");
					String shipToStateName 	= stateRetRes.getFieldValueString(i,"STATENAME");
%>
					<option value="<%=shipToStateCode%>" ><%=shipToStateName%></option>
<%
				}
			}
%>
		</select>
		</Td>
	</Tr>
	</tbody>
	</table>
	<br>
	<div>
		<button type="button" class="button btn-black" title="Clear" onclick="doClear()"><span>Clear</span></button>
		<button type="button" class="button btn-black" title="Search" onclick="searchUser()"><span>Search</span></button>
	</div>
	<br><br>
<%
	if(retObjPart!=null && retObjPart.getRowCount()==0)
	{
%>
		<div class="block" style="padding-left:0px; width:100%;">
		<div class="block-title">
			<strong><span>NO results for the search criteria</span></strong>
		</div>
		</div>
<%
	}
%>
	<table class="data-table" id="example">
	<thead>
		<th><%=soldLable%></th>
		<th>Name</th>
		<th>Address</th>
		<th>City</th>
		<th>State</th>
	</thead>
<%
	Vector chkSoldTo = new Vector();
	if(retObjPart!=null && retObjPart.getRowCount()>0)
	{
	//out.println("retObjPart>>"+retObjPart.toEzcString());
%>
		<tbody id="change">
<%
		for(int i=0;i<retObjPart.getRowCount();i++)
		{
			String soldToId = retObjPart.getFieldValueString(i,"SHIPCODE");
			String partnerCode = retObjPart.getFieldValueString(i,"SHIPCODE");

			soldToId = nullCheck(retObjPart.getFieldValueString(i,"SHIPNAME"))+"¥"+nullCheck(retObjPart.getFieldValueString(i,"SHIPSTREET"))+"¥"+nullCheck(retObjPart.getFieldValueString(i,"SHIPCITY"))+"¥"+nullCheck(retObjPart.getFieldValueString(i,"SHIPSTATE"))+"¥"+nullCheck(retObjPart.getFieldValueString(i,"SHIPCOUNTRY").trim())+"¥"+nullCheck(retObjPart.getFieldValueString(i,"SHIPPOSTCODE"))+"¥"+nullCheck(retObjPart.getFieldValueString(i,"SHIPPHONE"))+"¥"+nullCheck(retObjPart.getFieldValueString(i,"SHIPCODE"))+"¥"+nullCheck(retObjPart.getFieldValueString(i,"ACCGROUP"));

			String callFunc = "getShipToValue('"+soldToId+"')";

			if(chkSoldTo.contains(partnerCode))
				continue;
			else	
				chkSoldTo.add(partnerCode);
%>
			<tr>
				<td onClick="<%=callFunc%>"><%=partnerCode%></td>
				<td onClick="<%=callFunc%>"><%=retObjPart.getFieldValueString(i,"SHIPNAME")%></td>
				<td onClick="<%=callFunc%>"><%=retObjPart.getFieldValueString(i,"SHIPSTREET")%></td>
				<td onClick="<%=callFunc%>"><%=retObjPart.getFieldValueString(i,"SHIPCITY")%></td>
				<td onClick="<%=callFunc%>"><%=retObjPart.getFieldValueString(i,"SHIPSTATE")%></td>
			</tr>
<%
		}
%>
		</tbody>
<%
	}
%>
	</table>
	<script>
<%
	if(!"".equals(partState))
	{
%>
		document.myForm.state.partState = '<%=partState%>'	
<%
	}
%>
	</script>
</div>
</div>
</body>
</html>
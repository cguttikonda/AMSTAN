<%@ include file="../../../Includes/JSPs/Lables/iQuickSearch_Lables.jsp"%>
<%@ include file="../../../Includes/JSPs/Search/iGetSearchUsers.jsp"%>
<%
	String fromDate   = request.getParameter("fromDate");
	String toDate 	  = request.getParameter("toDate");

	if(fromDate==null || "null".equalsIgnoreCase(fromDate)) fromDate = fMonth_S+"/"+fDate_S+"/"+fyear;
	if(toDate==null   || "null".equalsIgnoreCase(toDate)) toDate = cMonth_S+"/"+cDate_S+"/"+cYear;
%>
<div class="main-container col2-left-layout middle account-pages">
<div class="hly-perftop"></div>
<div class="main">
<div class="col-main1 roundedCorners">
<div class="my-account">
<div class="dashboard">
<%
	String sType	= request.getParameter("orderType");

	String PONO 	= request.getParameter("PONO");
	PONO = (PONO==null || "null".equals(PONO))?"":PONO;

	String proCodeDesc = request.getParameter("proCodeDesc");
	proCodeDesc = (proCodeDesc==null || "null".equals(proCodeDesc))?"":proCodeDesc;

	String SAPSO = request.getParameter("SAPSO");
	SAPSO = (SAPSO==null || "null".equals(SAPSO))?"":SAPSO;

	String UPC = request.getParameter("UPC");
	UPC = (UPC==null || "null".equals(UPC))?"":UPC;

	String orderType = request.getParameter("orderType");

	String selected = "";
	if(orderType!=null && !"".equals(orderType) && !"null".equals(orderType)) selected = "selected";

	String AgentCode = (String)session.getValue("AgentCode");
	String ordStat = request.getParameter("ordStat");
	String ordType = request.getParameter("ordType");
%>
<script src="../../Library/JavaScript/Misc/Trim.js"></script>
<Script src="../../Library/Script/popup.js"></Script>
<script>
function doSubmit()
{
	obj = document.myForm;
	if(funTrim(obj.PONO.value)=="" && funTrim(obj.SAPSO.value)=="" && funTrim(obj.prdCODE.value)=="" && funTrim(obj.selSoldTo.value)=="")
	{
		alert("Please enter any serach criteria for order search.");
		return;
	}
	else
	{
   		Popup.showModal('modal1');
   		obj.submit();
   	}
}
function keySubmit()
{
	if(event.keyCode==13)
	{
		Popup.showModal('modal1');
		doSubmit();
	}
}
function doClear()
{
	document.getElementById("userForm").reset();
}
function getChilds()
{
	Popup.showModal('modal1');

	document.myForm.action="ezQuickSearchMain.jsp";
	document.myForm.submit();
}
function getShipTos()
{
	Popup.showModal('modal1');
	var soldTo = document.myForm.selSoldTo.value;

	if(soldTo=='A')
	{
		document.myForm.shipTo.value="A";
		document.getElementById("hideShip").style.display = 'none';
	}

	document.myForm.action="ezQuickSearchMain.jsp";
	document.myForm.submit();
}
function getShipTosH()
{
	document.getElementById("hideShip").style.display = 'none';
}
function selectDisplay(btnValue)
{
	if(btnValue == "Orders")
	{
		document.getElementById('Orders').innerHTML='<select  id="ordStat" name="ordStat" onChange="checkStatus(this.value)"> <option value="A">All</option><option value="INPROCESS">In Negotiation</option><option value="REJECTED">Rejected by ASB</option><option value="NEW">Template</option><option value="SAS">Submitted to ASB </option></select>';
<%
		if("CM".equals(userRole))
		{
%>
			document.getElementById('Orders').innerHTML='<select  id="ordStat" name="ordStat" onChange="checkStatus(this.value)"> <option value="A">All</option><option value="INPROCESS">In Negotiation</option><option value="REJECTED">Rejected by ASB</option><option value="NEW">Template</option><option value="SAS">Submitted to ASB </option><option value="SUBMITTED">Saved for Internal Review</option></select>';
<%
		}
%>
		document.getElementById("Status").style.display  = '';
		document.getElementById("soHide").style.display  = '';
		document.getElementById("soHide1").style.display = '';	
		document.getElementById("poHide").style.display  = '';
		document.getElementById("poHide1").style.display = '';	
		document.getElementById("poStat").innerText = "PO Status"
	}
	else if(btnValue == "Cancel")
	{
		 document.getElementById('Orders').innerHTML='<select  id="ordStat" name="ordStat" ><option value="P">ASB Queue</option><option  value="A">Approved</option><option  value="R">Rejected</option></select>';
		 document.getElementById("Status").style.display  = 'none';
		 document.getElementById("soHide").style.display  = 'none';
		 document.getElementById("soHide1").style.display = 'none';
 		 document.getElementById("poHide1").value = '';
 		 document.getElementById("poStat").innerText = "Request Status"
	}
	else if(btnValue == "Returns")
	{
		 document.getElementById('Orders').innerHTML='<select  id="ordStat" name="ordStat" ><option  value="P">ASB Queue</option><option value="A">Customer Queue</option><option  value="R">Closed</option></select>';
		 document.getElementById("Status").style.display  = 'none';
		 document.getElementById("soHide").style.display  = 'none';
		 document.getElementById("soHide1").style.display = 'none';
		 document.getElementById("poHide1").value = '';
		 document.getElementById("poStat").innerText = "Request Status"
	}
}
function checkStatus(status)
{
	if(status=="SAS")
		document.getElementById('orderType').disabled = false;
	else
		document.getElementById('orderType').disabled = true;
}
function openSearch(searchType)
{
	var selSoldTo='';
	if(searchType=='SHIPTO')
		selSoldTo = document.myForm.selSoldTo.value;
	window.open("../Sales/ezSearchPOP.jsp?searchType="+searchType+"&selSoldTo="+selSoldTo+"&chkBlock=Y&fromPage=Y",'name','height=475,width=800,left=200,top=100,location=no,resizable=no,scrollbars=no,toolbar=no,status=yes,z-lock=yes');
}
function funHideParent()
{
	var userType = "<%=(String)session.getValue("UserRole")%>";
	//alert(userType)
	if(userType=="CU")
		document.getElementById("parentTr").style.display = 'none';
}
</script>
<!-- auto complete STARTS-->
<script type="text/javascript" src="../../Library/Script/jquery.js"></script>
<script type="text/javascript">
jQuery(function(){
	//var atpforTxt=$("#atpfor").val();
	$("#prdCODE").autocomplete("../ShoppingCart/list.jsp");
});
</script>
<style type="text/css">
.suggestionsBox {
	position: absolute;
	left: 450px;
	top: 695px;
	margin: 0px 0px 0px 0px;
	width: 550px;
	height: 200px;
	overflow:auto;
	background-color: #DCDCDC;
	-moz-border-radius: 4px;
	-webkit-border-radius: 4px;
	border: 2px solid #CCC;
	color: #000;
}
.suggestionList {
	margin: 0px;
	padding: 0px;
}
.suggestionList li {
	margin: 0px 0px 3px 0px;
	padding: 3px;
	cursor: pointer;
}
.suggestionList li:hover {
	background-color: #555757;
	color: #8B0000;
}
.search_img{
	background:#ffffff url(../../Library/images/btn-search.png) no-repeat right;
	text-align:left;
}
.account-pages .my-account h3 {margin:0px !important}
</style>
<!-- auto complete ENDS-->
<body scroll=no >
<form name="myForm" id="userForm" action="../Search/ezQuickSearchDetailsMain.jsp" method="post" onSubmit="return false" >
<input type="hidden" name="setSub">
<input type="hidden" name="srType" value="Y">
<input type="hidden" name="webSrch" value="Y">
<div id="modal1" style="border:0px solid black; background-color:white; padding:1px; font-size:10;width:40%;height:180px; text-align:center; display:none;">
	<ul>
		<li>&nbsp;</li>
		<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
		<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
	</ul>
</div>
<div class="block" style="padding-left:0px; width:100%;">
	<div class="block-title"><strong><span>Order Search</span></strong></div>
</div>
<div class="welcome-msg">
	<!--<font color='red'><p>Search is limited to Orders accepted by American Standard.If you have NOT yet received Order Acknowledgment from American Standard, use Order Link "In Negotiation" or "Saved Orders" to locate your order. </p></font>-->
</div>
<div class="col1-set">
<div class="info-box">
<!--  New Table Start border:1px solid green; border-spacing:2px; border-collapse:collapse; --> 
<table width="600"  style=" background-color:#fff;" class="data-table" id="quickatp">
	<!--<tr >
		<th colspan="3" scope="col" style="font-weight:none;"><h3>Purchase Order Search</h3></th>
	</tr>-->
	<tr class="AdvSearchH3bgcolor">
		<td colspan="3"><nobr><h3 class="AdvSearchH3styles">Account Info</center></h3></nobr></td>
	</tr>
<%
	if(!"3".equals(userType))
	{
%>
	<tr id="parentTr">
		<td  style="font-weight:bold;"><nobr>Parent</nobr></td>
		<td style="width:50% !important;">
		<select name="parentSol" id ="parentSol" title="parentSol" style="width:400px;" defaultvalue="" onChange="getChilds()">
			<option value="">---Select---</option>
<%
			retParentSoldTo.sort(new String[]{"ECA_COMPANY_NAME"},true);
			//out.println(retParentSoldTo.toEzcString());
			for(int ps=0;ps<retParentSoldTo.getRowCount();ps++)
			{
				String bPartner = retParentSoldTo.getFieldValueString(ps,"EBPC_BUSS_PARTNER");
				bPartner = bPartner.trim();
				//out.println("bPartner:::::::::::::::::::::"+bPartner+":::::selParent::::::"+selParent);
				if (bPartner.equals("20011") || bPartner.equals("21108"))
					continue;

				String bpName  = retParentSoldTo.getFieldValueString(ps,"ECA_COMPANY_NAME");

				if(bPartner.equals(selParent.trim()))
				{
%>
					<option selected value='<%=bPartner%>'><%=bpName%></option>
<%
				}
				else
				{
%>
					<option value='<%=bPartner%>'><%=bpName%></option>
<%
				}
			}
%>
		</select>
		</td>
	</tr>
<%
	}
%>
	<tr>
	<td  style="font-weight:bold;"><nobr><b>Sold To</b></nobr></td>
	<td style="width:50% !important;">
	<select name="selSoldTo" id ="soldTo" title="soldTo" style="width:400px;" defaultvalue="" onChange="getShipTos()">
<%
	//if("CU".equals((String)session.getValue("UserRole")))
	if(selParent!=null && !"null".equalsIgnoreCase(selParent) && !"".equals(selParent))
	{
%>
		<option value="A">ALL</option>
<%
	}

	String tempSoldTo ="";
	String tempShipTo ="";

	if(retChildSoldTo!=null && retChildSoldTo.getRowCount()>0)
	{
		retChildSoldTo.sort(new String[]{"ECA_COMPANY_NAME"},true);
		//out.println("retChildSoldTo>>"+retChildSoldTo.toEzcString());
		for(int s=0;s<retChildSoldTo.getRowCount();s++)
		{
			String blockCode_A 	= retChildSoldTo.getFieldValueString(s,"ECA_EXT1");
			if(blockCode_A==null || "null".equalsIgnoreCase(blockCode_A)) blockCode_A = "";

			if(!"BL".equalsIgnoreCase(blockCode_A))
			{
				String soldToCode = retChildSoldTo.getFieldValueString(s,"EC_ERP_CUST_NO");
				String soldToName  = retChildSoldTo.getFieldValueString(s,"ECA_COMPANY_NAME");

				if("".equals(tempSoldTo))
				{
					tempSoldTo = soldToCode;
%>
					<!--<option value='<%//=soldToCode%>'>All</option>-->
<%
				}
				else
					tempSoldTo = tempSoldTo+"$$"+soldToCode;

				if(selSol.equals(soldToCode))
				{
%>
					<option selected value='<%=soldToCode%>'><%=soldToName%>&nbsp;(<%=soldToCode%>)</option>
<%
				}
				else
				{
%>
					<option value='<%=soldToCode%>'><%=soldToName%>&nbsp;(<%=soldToCode%>)</option>
<%
				}
			}
		}
	}
	else
	{
		ReturnObjFromRetrieve retsoldto_A = (ReturnObjFromRetrieve)session.getValue("retsoldto_A_Ses");
		if(retsoldto_A!=null && retsoldto_A.getRowCount()>0)
		{
			retsoldto_A.sort(new String[]{"ECA_COMPANY_NAME"},true);
			Vector assSoldTo = new Vector();
			for(int ss=0;ss<retsoldto_A.getRowCount();ss++)
			{
				String blockCode_A 	= retsoldto_A.getFieldValueString(ss,"ECA_EXT1");
				if(blockCode_A==null || "null".equalsIgnoreCase(blockCode_A)) blockCode_A = "";

				if(!"BL".equalsIgnoreCase(blockCode_A))
				{
					String soldToCode = retsoldto_A.getFieldValueString(ss,"EC_ERP_CUST_NO");
					String soldToName  = retsoldto_A.getFieldValueString(ss,"ECA_COMPANY_NAME");
					if(assSoldTo.contains(soldToCode) || soldToCode==null || "null".equals(soldToCode) || soldToName==null || "null".equals(soldToName))
						continue;
					else
						assSoldTo.add(soldToCode);
					//if(soldToCode==null || "null".equals(soldToCode) || soldToName==null || "null".equals(soldToName))continue;

					if("".equals(tempSoldTo))
						tempSoldTo = soldToCode;
					else
						tempSoldTo = tempSoldTo+"$$"+soldToCode;

					if(selSol.equals(soldToCode))
					{
%>
						<option selected value='<%=soldToCode%>'><%=soldToName%>&nbsp;(<%=soldToCode%>)</option>
<%
					}
					else
					{
%>
						<option value='<%=soldToCode%>'><%=soldToName%>&nbsp;(<%=soldToCode%>)</option>
<%
					}
				}
			}
		}
	}
	//if("CU".equals((String)session.getValue("UserRole")))
	{
%>
		<input type="hidden" name="tempSoldTo" value="<%=tempSoldTo%>">
<%
	}
%>
	</select>
	<a href="javascript:openSearch('SOLDTO')"><img height="20px" width="20px" src="../../Images/search2.png"></a>
	</td>
	</tr>
	<tr id="hideShip">
		<td style="font-weight:bold;"><nobr><b>Ship To</b></nobr></td>
		<td>
		<select  name="shipTo" id ="shipTo" title="shipTo" style="width:400px;" defaultvalue="">
		<option value="A">ALL</option>
<%
		if(retShipTo!=null && retShipTo.getRowCount()>0)
		{
			retShipTo.sort(new String[]{"ECA_COMPANY_NAME"},true);
			ArrayList byPassShips = new ArrayList();
			for(int s=0;s<retShipTo.getRowCount();s++)
			{
				String shipToCode = retShipTo.getFieldValueString(s,"EC_PARTNER_NO");
				String shipToName = retShipTo.getFieldValueString(s,"ECA_COMPANY_NAME");
				String accGrp     = retShipTo.getFieldValueString(s,"ECA_ACCOUNT_GROUP");

				if(byPassShips.contains(shipToCode))
					continue;
				else
					byPassShips.add(shipToCode);

				if("".equals(tempShipTo))
					tempShipTo = shipToCode;
				else
					tempShipTo = tempShipTo+"$$"+shipToCode;

				if(!"CPDA".equalsIgnoreCase(accGrp))
				{
					if(selShip.equals(shipToCode))
					{
%>
						<option selected value='<%=shipToCode%>'><%=shipToName%>&nbsp;(<%=shipToCode%>)</option>
<%
					}
					else
					{
%>
						<option value='<%=shipToCode%>'><%=shipToName%>&nbsp;(<%=shipToCode%>)</option>
<%
					}
				}
			}
			byPassShips.clear();
			if(dropShips.size()>0)
			{
				for(int m=0;m<dropShips.size();m++)
				{
					if(byPassShips.contains(dropShips.get(m)))
						continue;
					else
						byPassShips.add(dropShips.get(m));
%>
					<option value='<%=dropShips.get(m)%>'>Drop Ship&nbsp;(<%=dropShips.get(m)%>)</option>
<%
				}
			}
		}
		else
		{
%>
			<option value=''>No Ship To Assigned for the selected Sold To</option>
<%
		}
%>
		<input type="hidden" name="tempShipTo" value="<%=tempShipTo%>">
		</select>
		<a href="javascript:openSearch('SHIPTO')"><img height="20px" width="20px" src="../../Images/search2.png"></a>
		</td>
	</tr>
	<tr class="AdvSearchH3bgcolor">
		<td colspan="3"><nobr><h3 class="AdvSearchH3styles">Order Info<span style="color:#ffffff;"> &nbsp;&nbsp; Orders: <input name="orderinforadio"   id="orderinforadio" type="radio" value="Orders" onClick="selectDisplay('Orders')" /> &nbsp;&nbsp; Cancellation Requests: <input name="orderinforadio" id="orderinforadio" type="radio" value="Cancel" onClick="selectDisplay('Cancel')"/> &nbsp;&nbsp; Return Requests: <input name="orderinforadio" id="orderinforadio" type="radio" value="Returns" onClick="selectDisplay('Returns')"/></span></h3></nobr></td>
	</tr>
	<tr>
		<td colspan="2">
		<table width="100%">
			<tr>
			<td width="33%" style="font-weight:bold;" id="poHide"><b>PO ID</b></td>
			<td width="33%" style="font-weight:bold;"><b>PO Date From</b></td>
			<td width="33%" style="font-weight:bold;"><b>PO Date To</b></td>
			</tr>
			<tr>
			<td id="poHide1"><input type="text" name="PONO" value="<%=PONO%>"></td>
			<td><input type="text" size="12" id="fromDate" name="fromDate" value="<%=fromDate%>" readonly /><%=getDateImage("fromDate")%></td>
			<td><input type="text" size="12" id="toDate" name="toDate" value="<%=toDate%>" readonly /><%=getDateImage("toDate")%></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td style="font-weight:bold;" id="poStat">PO Status</td>
		<td>
		<div id="Orders">
		<select  name="ordStat" title="orderStatus" style="width:200px"   defaultvalue="" onChange="checkStatus(this.value)">
			<option value='A' 	 >All</option>
			<option value='INPROCESS'>In Negotiation</option>
			<option value='REJECTED' >Rejected by ASB</option>
			<option value='SAS'      >Submitted to ASB </option>
<%
			if("CM".equals(userRole))
			{
%>
				<option value='SUBMITTED'>Saved for Internal Review</option>
<%
			}
%>
			<option value='NEW'      >Template</option>
		</select>
		</div>
		</td>
	</tr>
	<tr id="Status">
		<td style="font-weight:bold;"><b>Shipping Status</b></td>
		<td width="50%">
		<select  name="orderType" id ="orderType" title="orderType" style=" width:200px;" defaultvalue="" disabled >
			<option value='A'  >All</option>
			<option value='O'  >Open</option>
			<option value='C'  >Closed</option>
			<!--<option value='NEW' >Saved Templates</option>
			<option value='NEGOTIATED'>Negotiated</option>-->

		</select>
		</td>
	</tr>
	<tr id="soHide">
		<td width="50%" style="font-weight:bold;"><b>Product ID</b> (Product Id, Desc.)</td>
		<td style="font-weight:bold;"><b>PO Reference Number</b> (SAP Order #)</td>
	</tr>
	<tr id="soHide1">
		<td><input size="20" type="text" name="prdCODE" value="<%=proCodeDesc%>" autocomplete="off" value="" id="prdCODE" class="search_img"/></td>
		<td><input type="text" name="SAPSO" value="<%=SAPSO%>"></td>
	</tr>
	<tr style="background-color:#FFC20E;">
		<td><button type="button" title="Submit" class="button btn-update" onclick="javascript:doSubmit()"><span>Submit</span></button></td>
		<td><button type="button" title="Clear" class="button btn-update" onclick="javascript:doClear()"><span>Clear</span></button></td>
	</tr>
</table>
<!-- New Table End -->
</div>
</div>
<br>
<div class="suggestionsBox" id="suggestions" style="display: none;">
<div class="suggestionList" id="autoSuggestionsList">
</div>
</div>
</body>
</form>
</div>
</div>
</div>
</div>
</div>
<script>
	//funHideParent()
	var obj     = document.myForm.orderType.options
	var obj1    = document.myForm.ordStat.options
	var radioChk= document.myForm.orderinforadio
	var orderType = '<%=orderType%>'
	var ordStat = '<%=ordStat%>'
	var radChk  = '<%=request.getParameter("orderinforadio")%>'
	var userType  = '<%=userRole%>'
	if(orderType!='' && orderType!='null')
	{
		for(j=0;j<obj.length;j++)
		{
			if(obj[j].value==orderType)
				obj[j].selected = true
		}
	}
	if(ordStat!='' && ordStat!='null')
	{
		for(i=0;i<obj1.length;i++)
		{
			if(obj1[i].value==ordStat)
			{
				obj1[i].selected = true
				if(ordStat=='SAS')
					checkStatus('SAS');
			}
		}
	}
	if(radChk=='Orders' || radChk=='null')
		radioChk[0].checked = true
	else if(radChk=='Returns')
	{
		radioChk[2].checked = true
		selectDisplay(radChk)
		obj1    = document.myForm.ordStat.options
		for(j=0;j<obj1.length;j++)
		{
			if(obj1[j].value==ordStat)
				obj1[j].selected = true
		}
	}
	else if(radChk=='Cancel')
	{
		radioChk[1].checked = true
		selectDisplay(radChk)
		obj1    = document.myForm.ordStat.options
		for(j=0;j<obj1.length;j++)
		{
			if(obj1[j].value==ordStat)
				obj1[j].selected = true
		}
	}

	var selSol = '<%=selSol%>'
	if(selSol!='')
		document.myForm.selSoldTo.value=selSol
	if(selSol=="A")
		getShipTosH()
</script>
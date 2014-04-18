<jsp:useBean id="BPManager" class="ezc.client.EzBussPartnerManager" scope="session"></jsp:useBean>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"></jsp:useBean>
<jsp:useBean id="AUM" class="ezc.ezadmin.ezadminutils.client.EzAdminUtilsManager" scope="session" />
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%@ page import = "ezc.ezparam.*,ezc.ezadmin.ezadminutils.params.*,java.util.*" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iStatesRetObj.jsp"%>
<%
	String chkBlock = request.getParameter("chkBlock");

	if(chkBlock==null || "null".equalsIgnoreCase(chkBlock) || "".equals(chkBlock)) chkBlock = "N";

	String fromPage = request.getParameter("fromPage");
	String ordType = request.getParameter("ordType");
	String searchType = request.getParameter("searchType");
	String soldLable = "SoldTo Id";
	if(searchType!=null && "SHIPTO".equalsIgnoreCase(searchType))
		soldLable = "ShipTo Id ";
	String selectedSoldTo = request.getParameter("selSoldTo");
	//out.println("selectedSoldTo::::"+selectedSoldTo);
	String soldTo = request.getParameter("soldToId");
	if(soldTo==null || "null".equals(soldTo))soldTo = "";
	String soldToName = request.getParameter("soldToName");
	if(soldToName==null || "null".equals(soldToName))soldToName = "";
	String city = request.getParameter("city");
	if(city==null || "null".equals(city))city = "";
	String addr = request.getParameter("addr");
	if(addr==null || "null".equals(addr))addr = "";
	String state = request.getParameter("state");
	if(state==null || "null".equals(state))state = "";
	//out.println("soldTo::::"+soldTo+"soldToName::::"+soldToName);
	//out.println("city::::"+city+"addr::::"+addr);
	//out.println("fromPage::::"+fromPage);
	boolean searchChk = false;
	if((soldTo!="" && !"".equals(soldTo)) || (soldToName!="" && !"".equals(soldToName)) || (city!="" && !"".equals(city)) || (addr!="" && !"".equals(addr)) || (state!="" && !"".equals(state)))
		searchChk = true;

%>
<%!
	public ReturnObjFromRetrieve getListOfSoldTos(String custNO,String name,String addr,String city,String state,String busPartner,String userRole,ezc.session.EzSession Session,String sysKey, String searchType, String selectedSoldTo,String ordType)
	{
		

		String partFunction = "AG";
		if(searchType!=null && "SHIPTO".equalsIgnoreCase(searchType))
			partFunction = "WE";
		
		ezc.ezparam.ReturnObjFromRetrieve retObjMisc =null;
		ezc.ezparam.EzcParams mainParamsMisc= new ezc.ezparam.EzcParams(false);
		
		ezc.ezmisc.params.EziMiscParams miscParams = new ezc.ezmisc.params.EziMiscParams();
		ezc.ezmisc.client.EzMiscManager ezMiscManager = new ezc.ezmisc.client.EzMiscManager();
		miscParams.setIdenKey("MISC_SELECT");
		String query="Select A.*, B.ECA_NO, B.ECA_NAME, B.ECA_COMPANY_NAME,B.ECA_ERP_UPDATE_FLAG, B.ECA_PHONE, B.ECA_ADDR_2,B.ECA_ADDR_1,B.ECA_CITY,B.ECA_STATE,B.ECA_PIN,B.ECA_COUNTRY,B.ECA_TRANSORT_ZONE,B.ECA_JURISDICTION_CODE,B.ECA_LANG,B.ECA_EMAIL,B.ECA_WEB_ADDR,B.ECA_BLOCK_CODE,B.ECA_ACCOUNT_GROUP,B.ECA_EXT1 FROM EZC_CUSTOMER A , EZC_CUSTOMER_ADDR B where  A.EC_PARTNER_FUNCTION in ('"+partFunction+"') and B.ECA_LANG = 'EN' and A.EC_NO = B.ECA_NO ";
		
		if(!"".equals(custNO) && custNO!="" && "SOLDTO".equalsIgnoreCase(searchType))
			query = query + " AND A.EC_ERP_CUST_NO LIKE '%"+custNO+"%'";
		if("SHIPTO".equalsIgnoreCase(searchType) && !"".equals(selectedSoldTo))	
			query = query + " AND A.EC_PARTNER_NO LIKE '%"+custNO+"%'";
		if("SHIPTO".equalsIgnoreCase(searchType) && !"FD".equals(ordType))	
			query = query + " AND A.EC_ERP_CUST_NO='"+selectedSoldTo+"'";
		if("SHIPTO".equalsIgnoreCase(searchType) && "".equals(selectedSoldTo))
			query = query + " AND A.EC_PARTNER_NO LIKE '%"+custNO+"%'";
		if(!"".equals(name) && name!="")
			query = query + " AND B.ECA_NAME LIKE '%"+name+"%'";			
		if(!"".equals(addr) && addr!="")
			query = query + " AND B.ECA_ADDR_1 LIKE '%"+addr+"%'";
		if(!"".equals(city) && city!="")
			query = query + " AND B.ECA_CITY LIKE '%"+city+"%'";
		if(!"".equals(state) && state!="")
			query = query + " AND B.ECA_STATE LIKE '%"+state+"%'";
		if("CU".equals(userRole))
			query = query + " AND A.EC_BUSINESS_PARTNER = '"+busPartner+"'";
		if("FD".equals(ordType) && "SOLDTO".equalsIgnoreCase(searchType))	
			query = query + " AND A.EC_SYS_KEY IN ( '999704','999702','999701')";
			
		miscParams.setQuery(query);
		mainParamsMisc.setLocalStore("Y");
		mainParamsMisc.setObject(miscParams);
		Session.prepareParams(mainParamsMisc);	

		try
		{		
			ezc.ezcommon.EzLog4j.log("miscParams.getQuery()::::::::"+miscParams.getQuery() ,"I");
			retObjMisc = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsMisc);
		}
		catch(Exception e)
		{
			ezc.ezcommon.EzLog4j.log("Exception in Getting Data"+e,"E");
		}		
		return retObjMisc;
		
	}

	public String nullCheck(String str,String str1)
	{
		String ret = str;

		if(ret==null || "null".equalsIgnoreCase(ret) || "".equals(ret))
			ret = str1;

		return ret;
	}



%>
<%
	
	String busPartner = (String)session.getValue("BussPart");
	String userId = (String)Session.getUserId();
	String userRole	= (String)session.getValue("UserRole");
	String sysKey	= (String)session.getValue("SalesAreaCode");
	ezc.ezparam.ReturnObjFromRetrieve soldTos = null;
	if(searchChk)
		soldTos = (ezc.ezparam.ReturnObjFromRetrieve)getListOfSoldTos(soldTo,soldToName,addr,city,state,busPartner,userRole,Session,sysKey,searchType,selectedSoldTo,ordType);

	//ezc.ezcommon.EzLog4j.log("busPartner>>>"+soldTos.toEzcString()+"<<userId>>"+userId,"D");
	
%>

<html>
<head>
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
	var soldToId   = document.subUserFrom.soldToId.value
	var soldToName = document.subUserFrom.soldToName.value
	var city  = document.subUserFrom.city.value
	var addr  = document.subUserFrom.addr.value
	var state  = document.subUserFrom.state.value
	if(soldToId=="" && soldToName=="" && city=="" && addr=="" && state=="")
	{
		$("#dialog-search").dialog('open');
	}
	else if(soldToId!="" || soldToName!="" || city!="" || addr!="" || state!="" )
	{
		Popup.showModal('modal1');
		document.subUserFrom.action="ezSearchPOP.jsp";
		document.subUserFrom.submit();
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
var fromPage = '<%=fromPage%>'
var ordType = '<%=ordType%>'
function getValue(val)
{
	if(fromPage!="Y")
	{	
		//alert(val)
		//alert(eval("opener.document.generalForm.selSoldTo"))
		var sType = document.subUserFrom.searchType.value;
		if(sType=='SOLDTO')
		{
			opener.document.generalForm.selSoldTo.value=val
			window.opener.selectedSoldTos()
		}else{
			//alert(eval("opener.document.generalForm.selShipToInfo"))
			//alert(val)
			opener.document.generalForm.selShipToInfo.value=val
			//alert(eval("opener.document.generalForm.selShipToInfo").value)
			window.opener.selectedShipTos()
		}

	}else{

		var sType = document.subUserFrom.searchType.value;
		if(sType=='SOLDTO')
		{
			//alert(opener.document.myForm.selSoldTo)
			opener.document.myForm.selSoldTo.value=val
			if(ordType!='FD')
				window.opener.getShipTos()
			
		}else{
			//alert(eval("opener.document.myForm.shipTo"))
			//alert(val)
			opener.document.myForm.shipTo.value=val
			//alert(eval("opener.document.generalForm.selShipToInfo".value)
			
		}

	}
	
	window.close();
}
function showAlert()
{
	$("#dialog-showAlert").dialog('open');
}
function doClear()
{
	document.getElementById("userForm").reset()
}
function FunXeroCnt()
{
	//$("#dialog-zeroCnt").dialog('open');
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
/*$(function() {

	$("#dialog-zeroCnt" ).dialog({
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
		
});*/

</script>
</head>
<Style>
#change tr:hover {
    background-color: #ccc;
    cursor: pointer;
}    
</Style>
<body  scroll=auto onLoad="document.subUserFrom.soldToId.focus()">
<form name=subUserFrom id="userForm" method=post >
<input Type="hidden" name="searchType" value="<%=searchType%>">
<input Type="hidden" name="selSoldTo" value="<%=selectedSoldTo%>">
<input Type="hidden" name="chkBlock" value="<%=chkBlock%>">
<input Type="hidden" name="fromPage" value="<%=fromPage%>">
<input Type="hidden" name="ordType" value="<%=ordType%>">
<div id="dialog-search" title="Enter Search" style="display:none">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Please enter a search criteria.</p>
</div>
<div id="dialog-showAlert" title="Block Alert" style="display:none">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Selected account has been blocked.</p>
</div>
<div id="modal1" style="border:0px solid black; background-color:white; padding:1px; font-size:10;width:40%;height:20%; text-align:center; display:none;">
	<ul>
		<li>&nbsp;</li>
		<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
		<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
	</ul>
</div>
<div id="dialog-zeroCnt title="No Results" style="display:none">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>No data returned for the search criteria.</p>
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
			<Td><input type = "text"  name = "soldToId"  maxlength = "10" size="40" value="<%=soldTo%>" onKeyPress="return submitenterpostatus(this,event)"></Td>
		</Tr>	
		<Tr>
			<Td><Strong>Name </Strong></Td>
			<Td><input type = "text"  name = "soldToName"  maxlength = "15" size="40" value="<%=soldToName%>" onKeyPress="return submitenterpostatus(this,event)"></Td>	
		</Tr>	
		<Tr>
			<Td><Strong>Address</Strong></Td>
			<Td><input  type="text" name="addr"   maxlength="40" size="40" value="<%=addr%>" onKeyPress="return submitenterpostatus(this,event)"></Td>
		</Tr>		
		<Tr>
			<Td><Strong>City</Strong></Td>
			<Td><input  type="text" name="city"   maxlength="16" size="40" value="<%=city%>" onKeyPress="return submitenterpostatus(this,event)"></Td>
		</Tr>
		<Tr>
			<Td><Strong>State</Strong></Td>
			<style>
			select, select[size="0"], select[size="1"] {background-image:url(data:image/png;base64,R0lGODlhDQAEAIAAAAAAAP8A/yH5BAEHAAEALAAAAAANAAQAAAILhA+hG5jMDpxvhgIAOw==) !important; background-repeat: no-repeat !important; background-position: right center !important; padding-right: 20px !important;}
			</style>
			<Td><select name="state" width="400px">
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
			</select></Td>		
		</Tr>	
		</tbody>
	</table>
	<br>
	<div >
		<button type="button" class="button btn-black" title="Clear" onclick="doClear()"><span>Clear</span></button>
		<button type="button" class="button btn-black" title="Search" onclick="searchUser()"><span>Search</span></button>
	</div>	
	<br><br>
<%
	if(soldTos!=null && soldTos.getRowCount()==0)
	{
%>
		 <div class="block" style="padding-left:0px; width:100%;">
			<div class="block-title">
				<strong>
					<span>NO results for the search criteria</span>
				</strong>
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
		if(soldTos!=null && soldTos.getRowCount()>0)
		{
%>
			<tbody id="change">
<%
			for(int i=0;i<soldTos.getRowCount();i++)
			{
				String blockCode = soldTos.getFieldValueString(i,"ECA_EXT1");

				String soldToId = soldTos.getFieldValueString(i,"EC_ERP_CUST_NO");
				String partnerCode = soldTos.getFieldValueString(i,"EC_ERP_CUST_NO");
				String accountGroup = soldTos.getFieldValueString(i,"ECA_ACCOUNT_GROUP");

				if(searchType!=null && "SHIPTO".equalsIgnoreCase(searchType) && !"Y".equals(fromPage))
				{
					partnerCode = soldTos.getFieldValueString(i,"EC_PARTNER_NO");				

					if("CPDA".equalsIgnoreCase(accountGroup))//partnerCode.endsWith("9999"))
						soldToId = "еееееее"+partnerCode+"е"+accountGroup;
					else
						soldToId = nullCheck(soldTos.getFieldValueString(i,"ECA_NAME"),"")+"е"+nullCheck(soldTos.getFieldValueString(i,"ECA_ADDR_1"),"N/A")+"е"+nullCheck(soldTos.getFieldValueString(i,"ECA_CITY"),"N/A")+"е"+nullCheck(soldTos.getFieldValueString(i,"ECA_STATE"),"")+"е"+nullCheck(soldTos.getFieldValueString(i,"ECA_COUNTRY").trim(),"")+"е"+nullCheck(soldTos.getFieldValueString(i,"ECA_PIN"),"N/A")+"е"+nullCheck(soldTos.getFieldValueString(i,"ECA_PHONE"),"N/A")+"е"+nullCheck(soldTos.getFieldValueString(i,"EC_PARTNER_NO"),"")+"е"+nullCheck(soldTos.getFieldValueString(i,"ECA_ACCOUNT_GROUP"),"");
				}
				if("Y".equals(fromPage))
				{
					soldToId = soldTos.getFieldValueString(i,"EC_PARTNER_NO");
					partnerCode = soldTos.getFieldValueString(i,"EC_PARTNER_NO");
				}	

				String callFunc = "getValue('"+soldToId+"')";
				if("Y".equals(chkBlock) && (blockCode!=null && "BL".equalsIgnoreCase(blockCode)))
					callFunc = "showAlert()";

				if(chkSoldTo.contains(partnerCode))
					continue;
				else	
					chkSoldTo.add(partnerCode);
%>
				<tr >

					<td  onClick="<%=callFunc%>">
						<%=partnerCode%>
					</td>
					<td onClick="<%=callFunc%>"><%=soldTos.getFieldValueString(i,"ECA_NAME")%></td>
					<td onClick="<%=callFunc%>"><%=soldTos.getFieldValueString(i,"ECA_ADDR_1")%></td>
					<td onClick="<%=callFunc%>"><%=soldTos.getFieldValueString(i,"ECA_CITY")%></td>
					<td onClick="<%=callFunc%>"><%=soldTos.getFieldValueString(i,"ECA_STATE")%></td>
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
	var cnt = <%=soldTos.getRowCount()%>;
<%
	if(state!="" && !"".equals(state))
	{
%>

		document.subUserFrom.state.value = '<%=state%>'	
	
<%
	}
%>	
	if(cnt=='0' || cnt==0)
	{
		//alert(cnt)
		//FunXeroCnt()
	}

</script>
	
   
</body>
</form>	
</div>

</div>
</div>
</html>	


<%
String displayOrder = request.getParameter("displayOrder");
%>
<%@ include file="../../../Includes/JSPs/Search/iListSalesOrders.jsp"%>
<div class="main-container col2-left-layout middle account-pages">
<div class="hly-perftop"></div>
<div class="main ">
<div class="col-main roundedCorners">
<div class="my-account">
<div class="dashboard">
<%
	String loginUserId = (String)Session.getUserId();
	String fromDate = request.getParameter("fromDate");
	String toDate = request.getParameter("toDate");
	ReturnObjFromRetrieve retsoldto_A_SesGet = (ReturnObjFromRetrieve)session.getValue("retsoldto_A_Ses");
	String soldToQT = request.getParameter("soldToQT");
	if(soldToQT==null || "null".equals(soldToQT)) soldToQT ="";
	if(selSubUser==null || "null".equals(selSubUser)) selSubUser ="";
	EzCurrencyFormat myFormat = new EzCurrencyFormat();
	
	if(fromDate==null || "null".equalsIgnoreCase(fromDate)) fromDate = fMonth_S+"/"+fDate_S+"/"+fyear;
	if(toDate==null || "null".equalsIgnoreCase(toDate)) toDate = cMonth_S+"/"+cDate_S+"/"+cYear;
	int retobjCnt = 0;
	if(retobj!=null && retobj.getRowCount()>0)
		 retobjCnt = retobj.getRowCount();
	
	/*********************** Picking Sub-Users based on partner of login user Start **************/
	ReturnObjFromRetrieve partnersRetSU = null;
	int partnersRetSUCnt = 0;
	if("CU".equals(userRole))
	{
		
		ReturnObjFromRetrieve retcatarea = null;
		ezc.client.EzcUtilManager UtilManagerSA = new ezc.client.EzcUtilManager(Session);
		retcatarea = (ReturnObjFromRetrieve)UtilManagerSA.getUserCatalogAreas();
		String[] sortArr={"ESKD_SYS_KEY"};
		int syskeyCount = retcatarea.getRowCount();

		String mySyskeys = "";
		if(syskeyCount>0)
		{
			mySyskeys = retcatarea.getFieldValueString(0,"ESKD_SYS_KEY");
			for (int i=0;i<syskeyCount;i++)
			{
				if(i==0)
					mySyskeys = retcatarea.getFieldValueString(i,"ESKD_SYS_KEY");		
				else

					mySyskeys =mySyskeys+"','"+retcatarea.getFieldValueString(i,"ESKD_SYS_KEY");
			}	
		}

		EzcParams mainParamsSub 	= new EzcParams(false);
		EziMiscParams miscParamsSub	= new EziMiscParams();
		
		miscParamsSub.setIdenKey("MISC_SELECT");
		String query="SELECT DISTINCT  EU_ID,EU_FIRST_NAME,EU_MIDDLE_INITIAL,EU_LAST_NAME,EU_TYPE,EU_EMAIL  FROM EZC_USERS, EZC_USER_DEFAULTS WHERE EUD_USER_ID=EU_ID AND EUD_SYS_KEY IN ('"+mySyskeys+"')  AND EU_BUSINESS_PARTNER='"+session.getValue("BussPart")+"' ORDER BY EU_FIRST_NAME";
		miscParamsSub.setQuery(query);

		mainParamsSub.setLocalStore("Y");
		mainParamsSub.setObject(miscParamsSub);
		Session.prepareParams(mainParamsSub);	

		try
		{		
			ezc.ezcommon.EzLog4j.log("miscParams.getQuery()::::::::"+miscParams.getQuery() ,"I");
			partnersRetSU = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsSub);
			//out.println("partnersRetSU::::::::::::"+partnersRetSU.toEzcString());


		}
		catch(Exception e)
		{
			out.println("Exception in Getting Data"+e);
		}
		if(partnersRetSU!=null)
		{
			for(int i=partnersRetSU.getRowCount()-1;i>=0;i--)
			{
				String tempuserId=partnersRetSU.getFieldValueString(i,"EU_ID");
				if(loginUserId.equals(partnersRetSU.getFieldValueString(i,"EU_ID").trim()))
					partnersRetSU.deleteRow(i);

			}

			partnersRetSUCnt = partnersRetSU.getRowCount();
		}	
	}	

	/*********************** Picking Sub-Users based on partner of login user End ****************/		 
	
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
			"bSort" : true,
			//"aoColumnDefs": [ 
				//{ "bVisible": false, "aTargets": [ 7 ] }
			//],
 
			"sDom": '<"H"Tfr>t<"F"ip>',
			
			"oTableTools": {
				"sSwfPath": "/AST/EzComm/EzSales/Sales/Library/Script/TableTools-2.1.1/swf/copy_csv_xls_pdf.swf",
				"aButtons": [
				{
				    "sExtends":    "csv",
				    "sButtonText": "Download CSV"
				}
				]
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
<Script src="../../Library/Script/popup.js"></Script> 
<%
	String searchStat = request.getParameter("searchStat");
	
	String dispHeader = "<font color=\"#66cc33;\">"+retobjCnt+"</font> Saved Orders/Templates";

	if(retobjCnt>0)
		dispHeader = "<font color=\"#66cc33;\">"+retobjCnt+"</font> Saved Orders/Templates";
		
		
	String disp="display:none";

	if("Y".equals(searchStat) || "Y"==searchStat)
	disp = "";
%>
<div class="block" style="padding-left:0px; width:100%;">
<div class="block-title">
<strong>
<span>
<%=dispHeader%></span>
</strong>
</div>
 
</div>
<script type="text/javascript">
	function getOrders()
	{
		Popup.showModal('modal1');
		document.dateForm.action="ezSavedOrders.jsp";
		document.dateForm.submit();
	}
	function getDetails(SoNum,SoldTo,tempName)
	{
		Popup.showModal('modal1');
		document.dateForm.webOrNo.value=SoNum;
		document.dateForm.soldTo.value=SoldTo;
		document.dateForm.tempName.value=tempName;

		document.dateForm.action="ezEditSaveSalesOrderDetails.jsp";
		document.dateForm.submit();
	}
	
	function Initialize()
	{
		try
		{
			req = new ActiveXObject("Msxml2.XMLHTTP");
		}
		catch(e)
		{
			try
			{
				req = new ActiveXObject("Microsoft.XMLHTTP"); 
			}
			catch(oc)
			{
				req = null;
			}
		}
		if(! req&&typeof XMLHttpRequest != "undefined")
		{
			req = new XMLHttpRequest();
		}

	}

	function SendQuery()
	{


		try
		{
			req = new ActiveXObject("Msxml2.XMLHTTP");
		}
		catch(e)
		{
			try
			{
				req = new ActiveXObject("Microsoft.XMLHTTP");
			}
			catch(oc)
			{
				req = null;
			}
		}



		if(!req&&typeof XMLHttpRequest!="undefined")
		{
			req = new XMLHttpRequest();
		}

		var url="";
		url="../Sales/ezDelSavedTemp.jsp?webOrdNo="+webOrdNo+"&soldTo="+soldTo+"&mydate="+new Date();
		//alert(url)
		if(req!=null)
		{
			req.onreadystatechange = Process;
			req.open("POST", url, true);
			req.send(null);
		}


	} 
	function Process() 
	{
		if (req.readyState == 4)
		{

			var resText     = req.responseText;	
			resText = resText.replace(/[\n\r\t]/g,'')		

			if (req.status == 200)
			{
				//alert(resText)
				if(resText=='Y')
				{
					Popup.showModal('modal1');
					document.dateForm.searchStat.value="";
					document.dateForm.submit();
				}
				else
					alert("Error in deleting the Template")

			}
			else
			{
				if(req.status == 500)	 
				alert("Error");
			}
		}
	}
	function removeTemp(SoNum,SoldTo)
	{
		var status=confirm("Are you sure to delete the Template ?");
		if(status==true)
		{
			webOrdNo= SoNum;
			soldTo  = SoldTo;
			Popup.showModal('modal1');
			SendQuery();
		}
	}	
	
</script>
<form name="dateForm" method="post">
<input type="hidden" name="searchStat" value="Y">
<div id="modal1" style="border:0px solid black; background-color:white; padding:1px; font-size:10;width:40%;height:180px; text-align:center; display:none;">
	<ul>
		<li>&nbsp;</li>
		<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
		<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
	</ul>
</div>
<ul class="form-list">

	<li>
	<div id="it">
	<!--<input type="button" class="button" title="Show/Hide" value="Show/Hide"/>-->
	<button type="button" title="Search" class="button btn-update"><span>Show / Hide Search</span></button>
	</div>
	</li>

	<li>
	<div id="display" style="<%=disp%>" >
		<table class="data-table" >
		<thead>
		
		<tr>
		<th width=10%>Document Date</th>
		<th width=5% align=center>From</th>
		<td width=15%><input type="text" size="12" id="fromDate" name="fromDate" value="<%=fromDate%>" readonly /><%=getDateImage("fromDate")%></td>
		<th width=5% align=center>To</th>
		<td width=15%><input type="text" size="12" id="toDate" name="toDate" value="<%=toDate%>" readonly /><%=getDateImage("toDate")%></td>

		</tr>
		<tr>
		<th width=10%>Sold To Code</th>
		<td width=15% colspan="2">
		<ul>
		<li>
		<div class="input-box">
		<select name="soldToQT">
		<option value="">----Select----</option>
<%
		if(retsoldto_A_SesGet!=null)
		{
			retsoldto_A_SesGet.sort(new String[]{"ECA_NAME"},true);
			for(int i=0;i<retsoldto_A_SesGet.getRowCount();i++)
			{
				String soldToCode_A 	= retsoldto_A_SesGet.getFieldValueString(i,"EC_ERP_CUST_NO");
				String soldToName_A 	= retsoldto_A_SesGet.getFieldValueString(i,"ECA_NAME");

				String selected_A = "selected";

				if(soldToQT.equals(soldToCode_A))
				{
%>				
					<option value="<%=soldToCode_A%>" <%=selected_A%>><%=soldToName_A%> : <%=soldToCode_A%></option>
<%				}
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
		</ul>				
		</td>
<%
	if("CU".equals(userRole))		
	{
%>	
		<td colspan="2"></td>
		</tr><tr>
		<th width=10%>Created By</th>
		<td width=10% colspan="2">
		<div class="input-box">
		<select name="subUser" >
		<option value="">--Select--</option>
<%
		if(partnersRetSU!=null)
		{
			for(int i=0;i<partnersRetSUCnt;i++)
			{
				String subUser 	= partnersRetSU.getFieldValueString(i,"EU_ID");
				String fullName = partnersRetSU.getFieldValueString(i,"EU_FIRST_NAME")+partnersRetSU.getFieldValueString(i,"EU_LAST_NAME");
				

				String selected_A = "selected";

				if(selSubUser.equals(subUser))
				{
%>				
					<option value="<%=subUser%>" selected><%=fullName%></option>
<%				}
				else
				{
%>	
					<option value="<%=subUser%>" ><%=fullName%></option>
<%
				}
			}
		}
%>
		</select>
		</div>
		</td>
		<td colspan="2">
		<!--<input type="submit" class="button" title="Submit" onClick="getOrders()" />-->
		<button title="Submit" class="button btn-update" onClick="getOrders()" ><span>Submit</span></button>
		</td>
		</tr>
<%
	} else {
	
%>	
		<td colspan="2">
		<!--<input type="submit" class="button" title="Submit" onClick="getOrders()" />-->
		<button title="Submit" class="button btn-update" onClick="getOrders()" ><span>Search</span></button>
		</td>
<% } %>		
		</tr>

		</thead>
		</table>
	</div>
	</li>
</ul>



<%
	Hashtable poSalesOrdersHT = new Hashtable();
	Hashtable poValueHT = new Hashtable();
	Vector poVector = new Vector();
	

	/*if(retobjCnt>0)
	{
		for(int i=0;i<retobjCnt;i++)
		{
			String poNumber 	= retobj.getFieldValueString(i,"PO_NO");
			String soNumber 	= retobj.getFieldValueString(i,"WEB_ORNO");
			String soNetValue  	= retobj.getFieldValueString(i,"NET_VALUE");
			String docDate  	= retobj.getFieldValueString(i,"DOC_DATE");
			
		
			if(poVector.contains(soNumber))
			{
				try{
					poValueHT.put(poNumber,Double.parseDouble((String)poValueHT.get(poNumber))+Double.parseDouble(soNetValue)+"");
				}catch(Exception e){
				}	


				poSalesOrdersHT.put(poNumber,(String)poSalesOrdersHT.get(poNumber)+"#"+soNumber);

			}else{
				poVector.addElement(soNumber);
				poSalesOrdersHT.put(poNumber,soNumber);
				poValueHT.put(poNumber,soNetValue);
			}
		}
	}*/	
		
		//out.println("::::::::::::::::::poSalesOrdersHT:::::::::"+poSalesOrdersHT);
		//out.println("::::::::::::::::::poValueHT:::::::::"+poValueHT);
%>		
<div class="col1-set">
<div class="info-box"><br>

<input type="hidden" name="webOrNo">
<input type="hidden" name="soldTo">
<input type="hidden" name="tempName">
<input type="hidden" name="sysKey">
<input type="hidden" name="fromSave" value="Y">

	<!-- <table class="display" id="example"> -->
	<table class="data-table" id="example">
	<thead>
	<tr>
	<th width=5%>&nbsp;</th>
	<th width=15%>Template Name</th>
	<th width=10%>PO Id</th>
	<th width=15%>PO Date</th>
	<th width=15%>Posted Date</th>
	<th width=10%>Amount[USD]</th>
	<th width=10%>Customer</th>
	<!--<th width=10%>Created By</th>-->
	</tr>
	</thead>
	<tbody>
<%
		
	poVector = new Vector();
	
	for(int i=0;i<retobjCnt;i++)
	{
		String tempsoNumber = "";
		String soNumber	= retobj.getFieldValueString(i,"WEB_ORNO");
		String netValue	= retobj.getFieldValueString(i,"NET_VALUE");
		String soCust 	= retobj.getFieldValueString(i,"SOLD_TO_CODE");
		String DocDate 	= retobj.getFieldValueString(i,"RES1");
		String DocStatus = retobj.getFieldValueString(i,"STATUS");
		String pono = retobj.getFieldValueString(i,"PO_NO");
		String templName = retobj.getFieldValueString(i,"TEMPLATE_NAME");
		String createdBy = retobj.getFieldValueString(i,"CREATEDBY");
		//out.println("templName::::::::"+templName);
		if("NEW".equals(DocStatus))DocStatus="Saved";


		String soNetValue  	= retobj.getFieldValueString(i,"NET_VALUE");

		/*if(poVector.contains(pono))
			continue;
		else*/
			poVector.addElement(pono);	


		StringTokenizer st1 = new StringTokenizer(DocDate,"/");
		String[] docsplit = new String[3];
		int h=0;
		while(st1.hasMoreTokens())
		{
			docsplit[h]=st1.nextToken();
			h++;
		}			
		java.util.Date dDate = new java.util.Date(Integer.parseInt(docsplit[2])-1900,Integer.parseInt(docsplit[0])-1,Integer.parseInt(docsplit[1]));
		DocDate = formatDate.getStringFromDate(dDate,"/",formatDate.MMDDYYYY);
		try
		{
			tempsoNumber = (Long.parseLong(soNumber))+"";
		}
		catch(Exception e)
		{	
			tempsoNumber = soNumber;
		}

		if((DocDate==null)||(DocDate=="null")||(DocDate.trim().length() == 0)) DocDate ="N/A";
		if((netValue==null)||(netValue=="null")||(netValue.trim().length() == 0)) netValue ="N/A";

		String poValueBD="0";
		poValueBD = (String)soNetValue;

		try
		{
			poValueBD = new java.math.BigDecimal(poValueBD).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
		}
		catch(Exception e){
			poValueBD = (String)soNetValue;
		}
%>
		<tr>
		<td width=5%><a href="javascript:removeTemp('<%=soNumber%>','<%=soCust%>')"><img style="valign:bottom" src="../../Images/Common/delete_icon.gif" height="20" width="20" border=0  style='cursor:hand' title="Delete Template"></a></td>
		<td width=15%><a href="javascript:getDetails('<%=soNumber%>','<%=soCust%>','<%=templName%>')"><%=templName%></a></td>
<%		
		if("".equals(templName.trim()) || templName.length()<0)
		{
%>		
			<td width=10%><a href="javascript:getDetails('<%=soNumber%>','<%=soCust%>','<%=templName%>')"><%=pono%></a></td>
<%
		}else{
%>		
			<td width=10%><%=pono%></a></td>
<%
		}
%>		
		<td width=15%><%=DocDate%></td>
		<td width=15%><%=DocDate%></td>
		<td width=10%><%=myFormat.getCurrencyString(poValueBD)%></td>
		<td width=10%><%=soCust%></td>
		<!--<td width=10%><%//=createdBy%></td>-->
		</tr>
		
<%
	}
%>
	</tbody>
	</table>
</div>
</div>
<script>
$("#it").click(function () {
document.getElementById("");
$("#display").toggle( "slow" );
});
</script>
</form>

</div>
</div>
</div>
<%@ include file="ezMyOrdersMenuLink.jsp"%>

</div>
</div>
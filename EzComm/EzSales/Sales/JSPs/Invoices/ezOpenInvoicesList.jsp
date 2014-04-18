<div class="main-container col2-left-layout middle account-pages">
<div class="hly-perftop"></div>
<div class="main">
<div class="col-main roundedCorners">
<div class="my-account">
<div class="dashboard">
<%@ page import="java.util.*,java.text.ParseException,java.text.SimpleDateFormat,java.text.DateFormat" %>
<%!
	public Vector getPayerCodes(String soldToCode, ezc.session.EzSession Session)
	{
		java.util.Vector payerCodes = new java.util.Vector();

		ezc.ezparam.ReturnObjFromRetrieve retObjMisc = null;
		ezc.ezparam.EzcParams mainParamsMisc = new ezc.ezparam.EzcParams(false);

		ezc.ezmisc.params.EziMiscParams miscParams = new ezc.ezmisc.params.EziMiscParams();
		ezc.ezmisc.client.EzMiscManager ezMiscManager = new ezc.ezmisc.client.EzMiscManager();

		String query="SELECT DISTINCT(EC_PARTNER_NO) FROM EZC_CUSTOMER,EZC_CUSTOMER_ADDR WHERE EC_ERP_CUST_NO='"+soldToCode+"' AND EC_PARTNER_FUNCTION='RE' AND EC_NO=ECA_NO";

		miscParams.setIdenKey("MISC_SELECT");
		miscParams.setQuery(query);
		mainParamsMisc.setLocalStore("Y");
		mainParamsMisc.setObject(miscParams);
		Session.prepareParams(mainParamsMisc);	

		try
		{
			retObjMisc = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsMisc);

			if(retObjMisc!=null)
			{
				for(int i=0;i<retObjMisc.getRowCount();i++)
				{
					String payCode = retObjMisc.getFieldValueString(i,"EC_PARTNER_NO");

					if(!payerCodes.contains(payCode))
						payerCodes.addElement(payCode);
				}
			}
		}
		catch(Exception e)
		{
			ezc.ezcommon.EzLog4j.log("Exception in Getting Data"+e,"E");
		}
		return payerCodes;
	}
%>

<!-- jQuery for sorting & pagination STARTS here-->

<style type="text/css" media="screen">
	@import "../../Library/Styles/demo_table_jui.css";
	

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
			"sDom": '<"H"Tfr>t<"F"ip>',
			"oTableTools": {
				"sSwfPath": "/AST/EzComm/EzSales/Sales/Library/Script/TableTools-2.1.1/swf/copy_csv_xls_pdf.swf",
				"aButtons": [
				{
				    "sExtends":    "csv",
				    "sButtonText": " Download CSV "
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
		onResize:onSampleResized});

});
</script>
<script>
	function getDetails(invNumber,poNumber,custCode)
	{
		Popup.showModal('headermodal');
		document.generalForm.sapInvNo.value=invNumber;
		document.generalForm.poNumber.value=poNumber;
		document.generalForm.soldToCode.value=custCode;
		
		document.generalForm.action="ezSOInvoiceDetailsMain.jsp";
		document.generalForm.submit();
	} 
	function selectedSoldTos()
	{
		document.generalForm.action="ezOpenInvoices.jsp";
		document.generalForm.submit();
	}
	function openSearch(searchType)
	{
		var selSoldTo='';
		if(searchType=='SHIPTO')
			selSoldTo = document.generalForm.selSoldTo.value
		window.open("../Sales/ezSearchPOP.jsp?searchType="+searchType+"&selSoldTo="+selSoldTo+"&chkBlock=Y",'name','height=475,width=800,left=200,top=100,location=no,resizable=no,scrollbars=no,toolbar=no,status=yes,z-lock=yes');
	}	
</script>

<!-- jQuery for sorting & pagination ENDS here -->

<link rel="stylesheet" type="text/css" href="../../Library/Styles/formalize.css">
<script type="text/javascript" src="../../Library/Script/jquery.formalize.js"></script>
<%

	ReturnObjFromRetrieve lineItems = new ReturnObjFromRetrieve();
	ReturnObjFromRetrieve dlineItems = null;
	ReturnObjFromRetrieve tempItems = null;
	
	String searchStat = request.getParameter("searchStat");
	String disp="display:none";
		
	if("Y".equals(searchStat) || "Y"==searchStat)
	   disp = "";	
	ReturnObjFromRetrieve retsoldto_A_SesGet = (ReturnObjFromRetrieve)session.getValue("retsoldto_A_Ses");
	ezc.ezbasicutil.EzSearchReturn mySearch= new ezc.ezbasicutil.EzSearchReturn();
	//out.println(retsoldto_A_SesGet.toEzcString());

		String soldToQT   = request.getParameter("selSoldTo");
		//out.println("soldToQT:::::::::::::::"+soldToQT);
		if(soldToQT==null || "null".equals(soldToQT) || "".equals(soldToQT))
			soldToQT = (String)session.getValue("AgentCode");;

		String fromDate   = request.getParameter("fromDate");
		String toDate 	  = request.getParameter("toDate");
		String valFrom    = request.getParameter("valFrom");
		String valTo 	  = request.getParameter("valTo");
		String poNo 	  = request.getParameter("poNum");	
		if(poNo==null || "null".equals(poNo)) poNo ="";
		java.util.Calendar calObj = java.util.Calendar.getInstance();
		java.util.Calendar calTOObj = java.util.Calendar.getInstance();

		//calTOObj.add(Calendar.DATE, 1825);

		int cYearQ = calTOObj.get(Calendar.YEAR);
		int cMonthQ = calTOObj.get(Calendar.MONTH);
		int cDateQ = calTOObj.get(Calendar.DATE);

		calObj.add(Calendar.DATE, -365);

		int fyearQ = calObj.get(Calendar.YEAR);
		int fMonthQ = calObj.get(Calendar.MONTH); 
		int fDateQ = calObj.get(Calendar.DATE);


		cMonthQ = cMonthQ+1;
		fMonthQ = fMonthQ+1;

		String fDate_SQ = fDateQ+"";
		String fMonth_SQ = fMonthQ+"";
		String cDate_SQ = (cDateQ+1)+"";  
		String cMonth_SQ = cMonthQ+"";

		if(fDateQ<10) fDate_SQ = "0"+fDateQ;
		if(fMonthQ<10) fMonth_SQ = "0"+fMonthQ; 
		if(cDateQ<10) cDate_SQ = "0"+cDateQ;
		if(cMonthQ<10) cMonth_SQ = "0"+cMonthQ;



		// returning the first date
		Calendar calStartQ=Calendar.getInstance();
		calStartQ.set(Calendar.YEAR,cYear);
		calStartQ.set(Calendar.MONTH,10);
		calStartQ.set(Calendar.DAY_OF_MONTH,11);
		Date startDateQ=calStartQ.getTime();

		int vfYearQ  = calStart.get(Calendar.YEAR);
		int vfMonthQ = calStart.get(Calendar.MONTH); 
		int vfDateQ  = calStart.get(Calendar.DATE);

		// returning the last date
		Calendar calEndQ=Calendar.getInstance();
		calEndQ.set(Calendar.YEAR,cYear);
		calEndQ.set(Calendar.MONTH,11);
		calEndQ.set(Calendar.DAY_OF_MONTH,31);	
		Date endDateQ=calEndQ.getTime();

		//calEndQ.add(Calendar.DATE, 1825);

		int vtYearQ  = calEndQ.get(Calendar.YEAR);
		int vtMonthQ = calEndQ.get(Calendar.MONTH); 
		int vtDateQ  = calEndQ.get(Calendar.DATE);

		vfMonthQ = vfMonthQ+1;
		vtMonthQ = vtMonthQ+1;

		String vfDate_SQ = vfDateQ+"";
		String vfMonth_SQ = vfMonthQ+"";
		String vtDate_SQ = vtDateQ+"";  
		String vtMonth_SQ = vtMonthQ+"";

		if(vfDateQ<10) vfDate_SQ = "0"+vfDateQ;
		if(vfMonthQ<10) vfMonth_SQ = "0"+vfMonthQ; 
		if(vtDateQ<10) vtDate_SQ = "0"+vtDateQ;
		if(vtMonthQ<10) vtMonth_SQ = "0"+vtMonthQ;





		if(fromDate==null || "null".equalsIgnoreCase(fromDate)) fromDate = fMonth_SQ+"/"+fDate_SQ+"/"+fyearQ;
		if(toDate==null   || "null".equalsIgnoreCase(toDate)) toDate = cMonth_SQ+"/"+cDate_SQ+"/"+cYearQ;

		//if(valFrom==null  || "null".equalsIgnoreCase(valFrom)) valFrom = vfMonth_S+"/"+vfDate_S+"/"+vfYear;
		if(valFrom==null  || "null".equalsIgnoreCase(valFrom)) valFrom = fMonth_SQ+"/"+fDate_SQ+"/"+fyearQ;
		if(valTo==null    || "null".equalsIgnoreCase(valTo)) valTo = vtMonth_SQ+"/"+vtDate_SQ+"/"+vtYearQ;	   


		/*ezc.client.EzcUtilManager UtilManager = new ezc.client.EzcUtilManager(Session);
		FormatDate formatDate = new FormatDate();*/
		//String billto=(String)session.getValue("AgentCode");
		//if(soldToQT!="" && !"".equals(soldToQT))billto = soldToQT;
		//if(soldToQT=="" && "".equals(soldToQT))soldToQT = billto;
		int invcount = 0;
		
		java.util.Vector payerCodesVect = (Vector)getPayerCodes(soldToQT,Session);


		ReturnObjFromRetrieve SeqInv = null;
		EzCustomerParams ioparams = new EzCustomerParams();


		ezc.customer.invoice.params.EzcCustomerInvoiceParams newParams=new ezc.customer.invoice.params.EzcCustomerInvoiceParams();
		EziCustomerInvoiceParams ecip = new EziCustomerInvoiceParams();

		
		Date fromDateI = null;
		Date toDateI = null;
		String fd=fromDate;
		String td=toDate;
		if(fd!=null && td!=null && !"null".equals(fd) && !"null".equals(td))
		{
			int ffy=Integer.parseInt(fd.substring(6,10))-1900;
			int ffd=Integer.parseInt(fd.substring(3,5));
			int ffm=Integer.parseInt(fd.substring(0,2))-1;
			int tty=Integer.parseInt(td.substring(6,10))-1900;
			int ttd=Integer.parseInt(td.substring(3,5));
			int ttm=Integer.parseInt(td.substring(0,2))-1;
			fromDateI = new Date(ffy,ffm,ffd);
			toDateI = new Date(tty,ttm,ttd);

		}
		else
		{
			fromDateI = new Date(106,4,1);
			toDateI = new Date(106,8,10);
		}


//out.println("fromDateI::::::"+fromDateI+":::toDateI::::"+toDateI);


		if(payerCodesVect!=null && payerCodesVect.size()>0)
		{
			for(int v=0;v<payerCodesVect.size();v++)
			{
				String billto = (String)payerCodesVect.get(v);
				if(billto!=null)
					billto = billto.trim();

				ecip.setInvFlag("O");
				ecip.setSelection(billto);//payer
				ecip.setKeyDate(new Date());
				ecip.setFromDate(fromDateI);
				ecip.setToDate(toDateI);
				ecip.setCompCode("1000");

				newParams.createContainer();
				newParams.setObject(ioparams);
				newParams.setObject(ecip);
				Session.prepareParams(newParams);

				try{
					SeqInv = (ReturnObjFromRetrieve) SalesInvManager.getCustomerInvoices(newParams);
					tempItems = (ReturnObjFromRetrieve)SeqInv.getFieldValue("LINEITEMS");
				}
				catch(Exception e){
					ezc.ezcommon.EzLog4j.log("Exception in getCustomerInvoices>>>>>>>>>>>>"+e ,"E");
				}	

				if(v==0)
					lineItems = tempItems;
				else
				{
					if(lineItems!=null && tempItems!=null)
						lineItems.append(tempItems);
				}		
			}
		}
		try{
			lineItems.sort(new String[]{"postingDate"},true);
		}catch(Exception e){}


//out.println(lineItems.toEzcString());
			int rowno = 0;
			String custbillNum="",invNum="",delDocNo="",invAm="",pd="",bd="",custCode="";
			double total=0;
			ezc.ezbasicutil.EzCurrencyFormat myFormat = new ezc.ezbasicutil.EzCurrencyFormat();
			String  formatkey=(String)session.getValue("formatKey");	

			dlineItems=new ReturnObjFromRetrieve();
			String objColumns[]={"BILLINGDOCUMENTNO","SAPINVOICENO","DELIVERYDOCUMENTNO","INVOICEDATE","DUEDATE","INVOICEVALUE","CUSTOMERPONO","CUSTOMER"};
			dlineItems.addColumns(objColumns);

			if (lineItems!=null)
			{
				rowno = lineItems.getRowCount();
				for (int i= 0; i<rowno ; i++)
				{
					if("RV".equals(lineItems.getFieldValueString(i,"DocType")) )
					{
						Date postingDate= (Date)lineItems.getFieldValue(i,"PstngDate");
						Date blineDate	= (Date)lineItems.getFieldValue(i,"BlineDate");
						invNum 		= lineItems.getFieldValueString(i,"DocNo");
						custbillNum 	= lineItems.getFieldValueString(i,"RefDoc").trim();
						delDocNo 	= lineItems.getFieldValueString(i,"RefKey1").trim();
						invAm 		= lineItems.getFieldValueString(i,"Amount");
						custCode	= lineItems.getFieldValueString(i,"Customer");

						String custPoNo = lineItems.getFieldValueString(i,"AllocNmbr");

						pd = formatDate.getStringFromDate(postingDate,formatkey,FormatDate.MMDDYYYY);
						if(pd.length() != 10)
							pd = "&nbsp;";

						bd = formatDate.getStringFromDate(blineDate,formatkey,FormatDate.MMDDYYYY);
						if(bd.length() != 10)
							bd = "&nbsp;";

						dlineItems.setFieldValue("BILLINGDOCUMENTNO",custbillNum);
						dlineItems.setFieldValue("SAPINVOICENO",invNum);
						dlineItems.setFieldValue("DELIVERYDOCUMENTNO",delDocNo);
						dlineItems.setFieldValue("INVOICEDATE",FormatDate.getStringFromDate(postingDate,formatkey,FormatDate.MMDDYYYY));
						dlineItems.setFieldValue("DUEDATE",formatDate.getStringFromDate(blineDate,formatkey,FormatDate.MMDDYYYY));
						dlineItems.setFieldValue("INVOICEVALUE",invAm);
						dlineItems.setFieldValue("CUSTOMERPONO",custPoNo);
						dlineItems.setFieldValue("CUSTOMER",custCode);
						dlineItems.addRow();
						invcount++;
						total=total+Double.parseDouble(invAm);
					}	
				}
			}
			if(dlineItems!=null)
			{
				session.removeValue("InvoiceReturnObject");
				session.removeValue("InvoiceTotal");
			}
			if(dlineItems!=null && invcount>0)
			{
				session.putValue("InvoiceReturnObject",dlineItems);
				session.putValue("InvoiceTotal",myFormat.getCurrencyString(total));  
		}

	ReturnObjFromRetrieve InvoiceReturnObjectSes = null;
	InvoiceReturnObjectSes=(ReturnObjFromRetrieve)session.getValue("InvoiceReturnObject");
	Date validFrom = null;
	Date validTo = null;
	if(valFrom!=null && valTo!=null && !"null".equals(valFrom) && !"null".equals(valTo))
	{
		int ffy=Integer.parseInt(valFrom.substring(6,10))-1900;
		
		int ffd=Integer.parseInt(valFrom.substring(3,5));
		int ffm=Integer.parseInt(valFrom.substring(0,2))-1;
		int tty=Integer.parseInt(valTo.substring(6,10))-1900;
		int ttd=Integer.parseInt(valTo.substring(3,5));
		int ttm=Integer.parseInt(valTo.substring(0,2))-1;
		validFrom = new Date(ffy,ffm,ffd);
		validTo = new Date(tty,ttm,ttd);	
	
	}
	//out.println(validTo);
	if(poNo!=null && !"".equals(poNo))
	{

		String wsearch=request.getParameter("poNum");
		
		if(wsearch!=null)
		{
			mySearch.search(InvoiceReturnObjectSes,"CUSTOMERPONO",wsearch);
			//out.println(":::::::::::"+mySearch);
		}
	 }
	
	
	int cntINV =0;
	
	if(InvoiceReturnObjectSes!=null && InvoiceReturnObjectSes.getRowCount() > 0)
	
	cntINV =  InvoiceReturnObjectSes.getRowCount();
	
	String dispHeader = "Open Invoices";
%>
<div class="block" style="padding-left:0px; width:100%;">
<div class="block-title">
<strong>
<span><%=dispHeader%></span>
</strong>
</div>
 
</div>
<h3> Displayed List of Invoices is based on American Standard's Status and may not represent all balances due. If you do not see a specific invoice, please contact customer service.</h3>


<form name="generalForm" method="post">
<input type="hidden" name="searchStat" value="Y">
<input type="hidden" name="sapInvNo">
<input type="hidden" name="fromPage" value='Y'>
<input type="hidden" name="salesOrder">						
<input type="hidden" name="soldTo">
<input type="hidden" name="poNumber">
<input type="hidden" name="soldToCode">

	<ul class="form-list">

	<li>
	<div id="it">
	<!--<input type="button" class="button" title="Show/Hide" value="Show/Hide"/>-->
	<button type="button" title="Search" class="button btn-update"><span>Show / Hide Search</span></button>
	</div>
	</li>

	<li>
	<div id="display" style="<%=disp%>" >
		<table class="data-table">
		<thead>
		
		<tr>
		<th width=10%>Invoice Date</th>
		<th width=10% align=center>From</th>
		<td width=20%><input type="text" size="12" id="fromDate" name="fromDate" value="<%=fromDate%>" readonly /><%=getDateImage("fromDate")%></td>
		<th width=10% align=center>To</th>
		<td width=20%><input type="text" size="12" id="toDate" name="toDate" value="<%=toDate%>" readonly /><%=getDateImage("toDate")%></td>

		</tr>

		<!--<tr>
		<th width=10%>Due Date</th>
		<th width=10% align=center>From</th>
		<td width=20%><input type="text" size="12" id="valFrom" name="valFrom" value="<%=valFrom%>" readonly /><%=getDateImage("valFrom")%></td>
		<th width=10% align=center>To</th>
		<td width=20%><input type="text" size="12" id="valTo" name="valTo" value="<%=valTo%>" readonly /><%=getDateImage("valTo")%></td>
				
		</tr>-->				

		<tr>

		<th width=10%>Sold To Code</th>
		<td width=20% colspan=2>
		<ul>
		<li>
		<div class="input-box">
		<select name="selSoldTo" style="width:230px;">
<%
		if(retsoldto_A_SesGet!=null)
		{
			for(int i=0;i<retsoldto_A_SesGet.getRowCount();i++)
			{
				String soldToCode_A 	= retsoldto_A_SesGet.getFieldValueString(i,"EC_ERP_CUST_NO");
				String soldToName_A 	= retsoldto_A_SesGet.getFieldValueString(i,"ECA_NAME");

				String selected_A = "selected";

				if(soldToQT.equals(soldToCode_A))
				{
%>				
					<option value="<%=soldToCode_A%>" <%=selected_A%>><%=soldToName_A%></option>
<%				}
				else
				{
%>	
					<option value="<%=soldToCode_A%>" ><%=soldToName_A%></option>
<%
				}
			}
		}
%>
		</select>
		<a href="javascript:openSearch('SOLDTO')"><img height="20px" width="20px" src="../../Images/search2.png"></a>
		</div>
		</li>
		</ul>				
		</td>
		<th width=10%>Po Number</th>
		<td width=20%><input type="text" size="12" id="poNum" name="poNum" value="<%=poNo%>"  /></td>
		</tr>

		</thead>
		</table>
		<div style="margin-top:8px;float:right;margin-right: -10px;">
		<!--<input type="submit" class="button" title="Submit" onClick="selectedSoldTos()" />-->
		<button title="Submit" class="button btn-update" onClick="selectedSoldTos()" ><span>Search</span></button>
		</div>
	</div>
	</li>
</ul>
<%
	if(cntINV>0)
	{
%>
	
<div class="col1-set">
<div class="info-box"><br>							

										
	<table class="data-table" id="example" >				
	<thead>									
										
	
	<tr>
	<th width=15%>&nbsp;Invoice No</th>
	<th width=15%>&nbsp;Delivery No</th>
	<th width=15%>&nbsp;My PO</th>
	<th width=15%>&nbsp;Invoice Date</th>
	<th width=15%>&nbsp;Due Date</th>
	<th width=15%>&nbsp;Value[USD]</th>
	
	
	</tr>
	</thead>
	<tbody>
<%
		//ezc.record.util.EzOrderedDictionary userAuth_R = Session.getUserAuth();
		
                DateFormat formatter = null;
                if(userAuth_R.containsKey("VIEW_PRICES")) {
		for(int i=0;i<cntINV;i++)									      
		{												      
			String custCode_A = InvoiceReturnObjectSes.getFieldValueString(i,"CUSTOMER");
			String custCode_Sel = (String)session.getValue("AgentCode");

			if(custCode_Sel.equals(custCode_A))
			{

			String billDocNo = InvoiceReturnObjectSes.getFieldValueString(i,"BILLINGDOCUMENTNO");			      
			String sapInvNo  = InvoiceReturnObjectSes.getFieldValueString(i,"SAPINVOICENO");			      
			String delDoc  = InvoiceReturnObjectSes.getFieldValueString(i,"DELIVERYDOCUMENTNO");
			
			String InvDate 	 = InvoiceReturnObjectSes.getFieldValueString(i,"INVOICEDATE"); 			      
			String dueDate 	 = InvoiceReturnObjectSes.getFieldValueString(i,"DUEDATE");
  			formatter = new SimpleDateFormat("MM/dd/yyyy");
        		Date dDate = (Date) formatter.parse(dueDate);
        		Date invDate = (Date) formatter.parse(InvDate);
        		//out.println(searchStat+"convertedDate::::"+convertedDate+":::validFrom:::"+validFrom+":::validTo:::"+validTo);
        		//out.println("after::::::"+dDate.after(validFrom));
        		//out.println("before::::"+dDate.before(validTo));
       			if("Y".equals(searchStat))
       			{      				
       				if(!(invDate.compareTo(fromDateI) >= 0 &&  invDate.compareTo(toDateI) <= 0))
       					continue;
				//if(!(dDate.compareTo(validFrom) >= 0 &&  dDate.compareTo(validTo) <= 0))
       					//continue;
			}		
       				
			
			String invVal="0";
			
			invVal 	 = InvoiceReturnObjectSes.getFieldValueString(i,"INVOICEVALUE");
			
			try
			{
				invVal = new java.math.BigDecimal(invVal).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
			}
			catch(Exception e){}
			
			
			String custPoNo  = InvoiceReturnObjectSes.getFieldValueString(i,"CUSTOMERPONO");			

			try
			{
				billDocNo = (Long.parseLong(billDocNo))+"";
			}
			catch(Exception e)
			{	
				billDocNo = billDocNo;
			}
			
			try
			{
				sapInvNo = (Long.parseLong(sapInvNo))+"";
			}
			catch(Exception e)
			{	
				sapInvNo = sapInvNo;
			}
			try
			{
				delDoc = (Long.parseLong(delDoc))+"";
			}
			catch(Exception e)
			{	
				delDoc = delDoc;
			}
						
%>
			<tr>
			<td width=15%>&nbsp;<a href="javascript:getDetails('<%=billDocNo%>','<%=custPoNo%>','<%=custCode_A%>')"><%=billDocNo%></a></td>
			<td width=15%>&nbsp;<%=delDoc%></td>
			<td width=15%>&nbsp;<%=custPoNo%></td>
			<td width=15%>&nbsp;<%=InvDate%></td>
			<td width=15%>&nbsp;<%=dueDate%></td>
			<td width=15%>&nbsp;<%=NumberFormat.getCurrencyInstance(Locale.US).format(new java.math.BigDecimal(invVal).doubleValue())%></td>
			</tr>
<%
		}
		}
		} else {
		
%>
			
<% } %>
	</tbody>
	</table>
</div>
</div>
</form>


<%
	}
%>
<script>
$("#it").click(function () {
document.getElementById("");
$("#display").toggle( "slow" );
});
</script>
</div>
</div>
</div>
<div class="col-left sidebar roundedCorners">
	<div class="block">
		<div class="block-title">
			<strong><span>Invoices</span></strong>
		</div>
		<div class="block-content">
			<ul>
			<li class="current"><a href="../Invoices/ezOpenInvoices.jsp"><strong>Open Invoices</strong></a></li>
			<li><a href="../News/ezListNewsDash.jsp?newsFilter=PS">Account Statement</a></li>
			</ul>
		</div>
	</div>
</div>
</div>
</div>

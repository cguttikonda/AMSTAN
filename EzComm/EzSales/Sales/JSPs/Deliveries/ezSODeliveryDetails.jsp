 <div class="main-container col2-layout middle account-pages">
 <div class="main">
 <div class="col-main1 roundedCorners">
 <div class="page-title">
<%@ page import = "ezc.ezparam.*" %>
 <%@ page import ="ezc.ezparam.*,ezc.ezsap.*" %>
 <%@ page import="com.sap.mw.jco.*,java.util.*" %>
 <%@ page import ="ezc.sapconnection.*,com.sap.mw.jco.*,com.sap.mw.jco.JCO" %>
 <!-- Add fancyBox -->
 <link rel="stylesheet" href="../../Library/Script/jquery.fancybox.css?v=2.0.5" type="text/css" media="screen" />
 <script type="text/javascript" src="../../Library/Script/jquery.fancybox.pack.js?v=2.0.5"></script>

 <%
 	String soNumber 	= request.getParameter("salesOrder");
 	String dlvDocNumber 	= request.getParameter("dlvNumber");
 	String poNumber 	= request.getParameter("PurchaseOrder");
 	String billHeadersCnt	= request.getParameter("billHeadersCnt");
 	
 	String soldtoFromSO = request.getParameter("soldToCode");
 	
 	String soldto=(String) session.getValue("AgentCode");
 	
 	//out.println(":::::::::::::::::::soNumber::::::::::::::::::::"+soNumber);
 	//out.println(":::::::::::::::::::dlvDocNumber::::::::::::::::::::poNumber :::billHeadersCnt+:::: soldToFromSO"+dlvDocNumber+"::"+poNumber+"::"+billHeadersCnt+":::"+soldtoFromSO);
 
 	String dlvDtlCols[] = {"PROD_NO","DESC","UOM","QTY","DELIV_ITEM_CAT","DELIV_NUMB","DELIV_ITEM","ZORDITEMNO","ZKITITEMNO","ZKITMATNO","ZZKITQUANTITY","ZZITEMNBR"};
 	String dlvHdrCols[] = {"DELIV_NUMB","DELIV_DATE","DELIV_TYPE","PICKDATE","SOLD_TO_PARTY","SHIP_TO_PARTY","ACTUAL_GI_DATE","SHIPPOINT","INCOTERMS1","INCOTERMS2","ZZFLAG","ZZMSTRBOL","ZZSUBBOL","ZZBOL","ZZDRPOFF","ZZSUBDROP","ZZPCDRPOFF","ZZBRKCRY","ZZTDLNR","ZZPOOLCRY","ZZTRAILER","ZZSEAL","ZZSHPTYP","ZZPRONUM","ZZPOOLIND","ZZFRGHTCD","ZZINCO1","ZZMFRGR","ZZQNTY","ZZAMT","ZZCROSDOCK","ZZSTORNBR","ZZDEPTNBR","ZZVBELN","ZZAAT","AUART","CARRIER_NAME1","POOLCARRIER_NAME1","LIFEX","BOLNR"};
 	String dlvPartnersCols[] = {"DELIV_NUMB","POSNR","PARVW","KUNNR","LIFNR","XCPDK","ADRNR"};
 	String dlvAddressesCols[] = {"ADDRNUMBER","NAME1","NAME2","CITY1","POST_CODE1","STREET","STR_SUPPL1","REGION","COUNTRY","TEL_NUMBER","FAX_NUMBER"};
 
 	ReturnObjFromRetrieve dlvDetails = new ReturnObjFromRetrieve(dlvDtlCols);
 	ReturnObjFromRetrieve dlvHeader = new ReturnObjFromRetrieve(dlvHdrCols);
 	ReturnObjFromRetrieve dlvPartners = new ReturnObjFromRetrieve(dlvPartnersCols);
 	ReturnObjFromRetrieve dlvAddresses = new ReturnObjFromRetrieve(dlvAddressesCols);
 	
 	JCO.Client client2=null;
 	JCO.Function function1 = null;

	String site_S = (String)session.getValue("Site");
	String skey_S = "999";

 	try
 	{
 		function1= EzSAPHandler.getFunction("Z_EZ_GET_SALES_ORDER_DELIVERY",site_S+"~"+skey_S);
 		//out.println("function>>>>>>"+function);
 		JCO.ParameterList 	sapProc 	= function1.getImportParameterList();
 		
 		sapProc.setValue(dlvDocNumber,"SALESDOCUMENT");
 		//out.println(" going for Sold To:"+soldtoFromSO);
		if ((soldtoFromSO != null) && !soldtoFromSO.equals("")) {
			sapProc.setValue(soldtoFromSO,"CUSTOMER");
			//out.println(" going for Sold To:"+soldtoFromSO);
		} else {
			sapProc.setValue(soldto,"CUSTOMER");
		}

 		//sapProc.setValue(soldto,"CUSTOMER");
 		//sapProc.setValue("1001","SALESORG");
 		sapProc.setValue("I","SELECTION");
 		
 		//JCO.Table salesTable = function.getTableParameterList().getTable("DELIV_DETAILS");
 
 
 		try
 		{	// Execute RFC Call
 			client2 = EzSAPHandler.getSAPConnection(site_S+"~"+skey_S);
 			client2.execute(function1);
 			//out.println(":::::::::::::::::::ec::::::::::::::::::::"+client1);
 		}
 		catch(Exception ec)
 		{
 			out.println(":::::::::::::::::::ec::::::::::::::::::::"+ec);
 		}
 
 		JCO.Table headerTable 		= function1.getTableParameterList().getTable("DELIV_HEADER");
 		JCO.Table detailsTable 		= function1.getTableParameterList().getTable("DELIV_DETAILS");
 		JCO.Table partnersTable 		= function1.getTableParameterList().getTable("DELIVERY_PARTNERS");
 		JCO.Table addressesTable 		= function1.getTableParameterList().getTable("DELIVERY_ADDRESSES");
 		
 		//out.println(":::::::::::::::::::headerTable::::::::::::::::::::"+headerTable);
 		if(headerTable!=null)
		{
			if (headerTable.getNumRows() > 0)
			{
				do
				{
					dlvHeader.setFieldValue("DELIV_NUMB",headerTable.getValue("DELIV_NUMB"));
					dlvHeader.setFieldValue("DELIV_DATE",headerTable.getValue("DELIV_DATE"));
					dlvHeader.setFieldValue("DELIV_TYPE",headerTable.getValue("DELIV_TYPE"));
					dlvHeader.setFieldValue("PICKDATE",headerTable.getValue("PICKDATE"));
					dlvHeader.setFieldValue("SOLD_TO_PARTY",headerTable.getValue("SOLD_TO_PARTY"));
					dlvHeader.setFieldValue("SHIP_TO_PARTY",headerTable.getValue("SHIP_TO_PARTY"));					
					dlvHeader.setFieldValue("ACTUAL_GI_DATE",headerTable.getValue("ACTUALGIDATE"));	
					dlvHeader.setFieldValue("INCOTERMS1",headerTable.getValue("INCOTERMS1"));	
					dlvHeader.setFieldValue("INCOTERMS2",headerTable.getValue("INCOTERMS2"));	
					dlvHeader.setFieldValue("ZZFLAG",headerTable.getValue("ZZFLAG"));	
					dlvHeader.setFieldValue("ZZMSTRBOL",headerTable.getValue("ZZMSTRBOL"));	
					dlvHeader.setFieldValue("ZZSUBBOL",headerTable.getValue("ZZSUBBOL"));	
					dlvHeader.setFieldValue("ZZBOL",headerTable.getValue("ZZBOL"));	
					dlvHeader.setFieldValue("ZZDRPOFF",headerTable.getValue("ZZDRPOFF"));	
					dlvHeader.setFieldValue("ZZSUBDROP",headerTable.getValue("ZZSUBDROP"));	
					dlvHeader.setFieldValue("ZZPCDRPOFF",headerTable.getValue("ZZPCDRPOFF"));	
					dlvHeader.setFieldValue("ZZBRKCRY",headerTable.getValue("ZZBRKCRY"));	
					dlvHeader.setFieldValue("ZZTDLNR",headerTable.getValue("ZZTDLNR"));	
					dlvHeader.setFieldValue("ZZPOOLCRY",headerTable.getValue("ZZPOOLCRY"));	
					dlvHeader.setFieldValue("ZZTRAILER",headerTable.getValue("ZZTRAILER"));	
					dlvHeader.setFieldValue("ZZSEAL",headerTable.getValue("ZZSEAL"));	
					dlvHeader.setFieldValue("ZZSHPTYP",headerTable.getValue("ZZSHPTYP"));	
					dlvHeader.setFieldValue("ZZPRONUM",headerTable.getValue("ZZPRONUM"));	
					dlvHeader.setFieldValue("ZZPOOLIND",headerTable.getValue("ZZPOOLIND"));	
					dlvHeader.setFieldValue("ZZFRGHTCD",headerTable.getValue("ZZFRGHTCD"));	
					dlvHeader.setFieldValue("ZZINCO1",headerTable.getValue("ZZINCO1"));	
					dlvHeader.setFieldValue("ZZMFRGR",headerTable.getValue("ZZMFRGR"));	
					dlvHeader.setFieldValue("ZZQNTY",headerTable.getValue("ZZQNTY"));	
					dlvHeader.setFieldValue("ZZAMT",headerTable.getValue("ZZAMT"));	
					dlvHeader.setFieldValue("ZZCROSDOCK",headerTable.getValue("ZZCROSDOCK"));	
					dlvHeader.setFieldValue("ZZSTORNBR",headerTable.getValue("ZZSTORNBR"));	
					dlvHeader.setFieldValue("ZZDEPTNBR",headerTable.getValue("ZZDEPTNBR"));	
					dlvHeader.setFieldValue("ZZVBELN",headerTable.getValue("ZZVBELN"));	
					dlvHeader.setFieldValue("ZZAAT",headerTable.getValue("ZZAAT"));	
					dlvHeader.setFieldValue("AUART",headerTable.getValue("AUART"));	
					dlvHeader.setFieldValue("CARRIER_NAME1",headerTable.getValue("CARRIER_NAME1"));	
					dlvHeader.setFieldValue("POOLCARRIER_NAME1",headerTable.getValue("POOLCARRIER_NAME1"));	
					dlvHeader.setFieldValue("LIFEX",headerTable.getValue("LIFEX"));	
					dlvHeader.setFieldValue("BOLNR",headerTable.getValue("BOLNR"));	
					

					dlvHeader.addRow();
				} while(headerTable.nextRow());
			}
		}
 		
 		if(detailsTable!=null)
 		{
 			if (detailsTable.getNumRows() > 0)
 			{
 				do
 				{
 					dlvDetails.setFieldValue("PROD_NO",detailsTable.getValue("MATERIAL"));
 					dlvDetails.setFieldValue("DESC",detailsTable.getValue("SHORT_TEXT"));
 					dlvDetails.setFieldValue("UOM",detailsTable.getValue("SALES_UNIT"));
 					dlvDetails.setFieldValue("QTY",detailsTable.getValue("DLVQTY_SALES_UNT"));
 					dlvDetails.setFieldValue("DELIV_NUMB",detailsTable.getValue("DELIV_NUMB"));
 					dlvDetails.setFieldValue("DELIV_ITEM",detailsTable.getValue("DELIV_ITEM"));
 					dlvDetails.setFieldValue("DELIV_ITEM_CAT",detailsTable.getValue("DELIV_ITEM_CAT"));
 					dlvDetails.setFieldValue("ZORDITEMNO",detailsTable.getValue("ZORDITEMNO"));
 					dlvDetails.setFieldValue("ZKITITEMNO",detailsTable.getValue("ZKITITEMNO"));
 					dlvDetails.setFieldValue("ZKITMATNO",detailsTable.getValue("ZKITMATNO"));
 					dlvDetails.setFieldValue("ZZKITQUANTITY",detailsTable.getValue("ZZKITQUANTITY"));
 					dlvDetails.setFieldValue("ZZITEMNBR",detailsTable.getValue("ZZITEMNBR"));
 					
 					dlvDetails.addRow();
 				
 					// out.println(" DELIV_NUMB :::::::::::::::::::"+headerTable.getValue("DELIV_NUMB"));
 					// out.println(" DELIV_DATE :::::::::::::::::::"+headerTable.getValue("DELIV_DATE"));
   
 				}
 				while(detailsTable.nextRow());
 			}
 		}
 		
 		if(partnersTable!=null)
		 		{
		 			if (partnersTable.getNumRows() > 0)
		 			{
		 				do
		 				{
		 					dlvPartners.setFieldValue("DELIV_NUMB",partnersTable.getValue("VBELN"));
		 					dlvPartners.setFieldValue("POSNR",partnersTable.getValue("POSNR"));
		 					dlvPartners.setFieldValue("PARVW",partnersTable.getValue("PARVW"));
		 					dlvPartners.setFieldValue("KUNNR",partnersTable.getValue("KUNNR"));
		 					dlvPartners.setFieldValue("LIFNR",partnersTable.getValue("LIFNR"));
		 					dlvPartners.setFieldValue("XCPDK",partnersTable.getValue("XCPDK"));
		 					dlvPartners.setFieldValue("ADRNR",partnersTable.getValue("ADRNR"));
		 					
		 					dlvPartners.addRow();

		 				}
		 				while(partnersTable.nextRow());
		 			}
 		}
 		
 		
 		if(addressesTable!=null)
		 		{
		 			if (addressesTable.getNumRows() > 0)
		 			{
		 				do
		 				{
		 					dlvAddresses.setFieldValue("ADDRNUMBER",addressesTable.getValue("ADDRNUMBER"));
		 					dlvAddresses.setFieldValue("NAME1",addressesTable.getValue("NAME1"));
		 					dlvAddresses.setFieldValue("NAME2",addressesTable.getValue("NAME2"));
		 					dlvAddresses.setFieldValue("CITY1",addressesTable.getValue("CITY1"));
		 					dlvAddresses.setFieldValue("POST_CODE1",addressesTable.getValue("POST_CODE1"));
		 					dlvAddresses.setFieldValue("STREET",addressesTable.getValue("STREET"));
		 					dlvAddresses.setFieldValue("STR_SUPPL1",addressesTable.getValue("STR_SUPPL1"));
		 					dlvAddresses.setFieldValue("REGION",addressesTable.getValue("REGION"));
		 					dlvAddresses.setFieldValue("COUNTRY",addressesTable.getValue("COUNTRY"));
		 					dlvAddresses.setFieldValue("TEL_NUMBER",addressesTable.getValue("TEL_NUMBER"));
		 					dlvAddresses.setFieldValue("FAX_NUMBER",addressesTable.getValue("FAX_NUMBER"));
		 					
		 					dlvAddresses.addRow();
		 						 
		 				}
		 				while(addressesTable.nextRow());
		 			}
 		}
 		
 	}
 	catch(Exception e)
 	{
 		out.println("EXCEPTION>>>>>>"+e);
 	}
 	finally
 	{
 		if (client2!=null)
 		{
 			JCO.releaseClient(client2);
 			client2 = null;
 			function1=null;
 		}
 	}
 	
 	
 	 //out.println(dlvDetails.toEzcString());
 	
 	int delDetailsCnt = dlvDetails.getRowCount();
	Vector types = new Vector();
	Vector names = new Vector();
	types.addElement("date");
	types.addElement("date");
	types.addElement("date");
	names.addElement("DELIV_DATE");
	names.addElement("PICKDATE");
	names.addElement("ACTUAL_GI_DATE");
	EzGlobal.setColTypes(types);
	EzGlobal.setColNames(names);
	ezc.ezparam.ReturnObjFromRetrieve dlvHeader2 = EzGlobal.getGlobal(dlvHeader);

 	
%>
 
 <script type="text/javascript">
 
 function checkAll(field)
 {	
 	if(document.myForm.CheckBoxAll.checked)
 	{	
 		for (i = 0; i < field.length; i++)
 		{
 			document.myForm.CheckBox1[i].checked = true ;
 			alert(document.myForm.CheckBox1[i].checked)
 		}
 	}	
 	else
 	{	
 		for (i = 0; i < field.length; i++)
 		{
 			document.myForm.CheckBox1[i].checked = false ;
 			alert(document.myForm.CheckBox1[i].checked)
 		}
 	}				
 }
 function getPrintDtl(type)
{
		
	//Popup.showModal('modal');
	alert('A PDF will be generated and downloaded to your browsers download location');
	document.myForm.action="ezSODeliveryPrint.jsp?type="+type;
	document.myForm.submit();

}
 
 function funBack()
 {
 	var cnt ='<%=billHeadersCnt%>'
	if(cnt=='1')
		document.myForm.action="../Sales/ezSalesOrderDetails.jsp"
	else
 	document.myForm.action = "ezSODeliveriesList.jsp";
 	document.myForm.submit();
 }
 
 $(document).ready( function() {
 	        $('.fancyframe').fancybox({
 			     type:'iframe',
 			      closeBtn:true,
 			      autoSize:false,
 			      width:510,
 			      height:390,
 			      scrolling:'No'
			      });
	} );
 
 $('.fancyframe').on(click, function(){$('.fancybox-opened .fancybox-title').hide();})
 </script>
 
 <%!
 	public String eliminateDecimals(String myStr)
 	{
 		String remainder = "";
 		if(myStr.indexOf(".")!=-1)
 		{
 			remainder = myStr.substring(myStr.indexOf(".")+1,myStr.length());
 			myStr = myStr.substring(0,myStr.indexOf("."));
 		}
 		return myStr;
 	}
 %>
 
 <%
  	String dispHeader = "ADVANCED SHIP NOTICE" ;
  
  %>
 <div class="highlight" >
 <br>
 <font size="5" color="black">
 <b> <%=dispHeader%> </b>
 </font>
 <br>
 <strong> ASN NO:</strong>&nbsp;<%=dlvDocNumber%>&nbsp;&nbsp;<strong> PO NO:</strong>&nbsp;<%=poNumber%>
 </div>
<br>
 <h3> Print Document to view PDF Version similar to Paper Copy of ASN/Packing Slips and obtain additional Details like Ordered and Back Order Quantity</h3><br>
<div class="col3-set">
	<div class="col-1">
	<div class="info-box">
		<h2 class="sub-title">Sold To</h2>
<%
		String sysKey = (String)session.getValue("SalesAreaCode");
		

		String soldToInfo = "";
		String payerInfo = "";
		//payerInfo+=dlvHeader.getFieldValueString(0,"SHIP_TO_PARTY")+"<br>";
		//out.print("dlvHeader::::"+dlvHeader.toEzcString());
		String shipToAddrCode = "";
		String soldToAddrCode = "";
		if(dlvPartners!=null)
		{
			for(int i=0;i<dlvPartners.getRowCount();i++)
			{
				if (dlvPartners.getFieldValueString(i,"PARVW").equals("WE"))
					shipToAddrCode = dlvPartners.getFieldValueString(i,"ADRNR");
				if (dlvPartners.getFieldValueString(i,"PARVW").equals("AG"))
					soldToAddrCode = dlvPartners.getFieldValueString(i,"ADRNR");	
			}
		}	
			
		
		if(dlvAddresses!=null)
		{
			for(int i=0;i<dlvAddresses.getRowCount();i++)
			{
				String dlvAddrCode = dlvAddresses.getFieldValueString(i,"ADDRNUMBER");
				
				if(soldToAddrCode.equals(dlvAddrCode) && soldToInfo.equals(""))
				{
					soldToInfo+=soldtoFromSO+"<br>";
					
					soldToInfo+=dlvAddresses.getFieldValueString(i,"NAME1")+"<br>";
					
					soldToInfo+=dlvAddresses.getFieldValueString(i,"STREET")+"<br>";
					
					soldToInfo+=dlvAddresses.getFieldValueString(i,"CITY1")+",&nbsp;";
					soldToInfo+=dlvAddresses.getFieldValueString(i,"REGION")+"&nbsp;";
					if ((dlvAddresses.getFieldValueString(i,"POST_CODE1") != null) && (dlvAddresses.getFieldValueString(i,"POST_CODE1") != "null"))
					soldToInfo+=dlvAddresses.getFieldValueString(i,"POST_CODE1")+"&nbsp;";
					soldToInfo+=dlvAddresses.getFieldValueString(i,"COUNTRY")+"<br>";
					if ((dlvAddresses.getFieldValueString(i,"TEL_NUMBER") != null) && (dlvAddresses.getFieldValueString(i,"TEL_NUMBER") != "null"))
					soldToInfo+="<strong>Tel#:</strong>&nbsp;"+dlvAddresses.getFieldValueString(i,"TEL_NUMBER")+"<br>";
					if ((dlvAddresses.getFieldValueString(i,"FAX_NUMBER") != null) && (dlvAddresses.getFieldValueString(i,"FAX_NUMBER") != "null"))
					soldToInfo+="<strong>Fax#:</strong>&nbsp;"+dlvAddresses.getFieldValueString(i,"FAX_NUMBER")+"<br>";
				}
				
				if(shipToAddrCode.equals(dlvAddrCode) && payerInfo.equals(""))
				{
		
					
					payerInfo+=dlvHeader.getFieldValueString(0,"SHIP_TO_PARTY")+"<br>";
					payerInfo+=dlvAddresses.getFieldValueString(i,"NAME1")+"<br>";
					
					payerInfo+=dlvAddresses.getFieldValueString(i,"STREET")+"<br>";
					
					payerInfo+=dlvAddresses.getFieldValueString(i,"CITY1")+",&nbsp;";
					payerInfo+=dlvAddresses.getFieldValueString(i,"REGION")+"&nbsp;";
					if ((dlvAddresses.getFieldValueString(i,"POST_CODE1") != null) && (dlvAddresses.getFieldValueString(i,"POST_CODE1") != "null"))
					payerInfo+=dlvAddresses.getFieldValueString(i,"POST_CODE1")+"&nbsp;";
					payerInfo+=dlvAddresses.getFieldValueString(i,"COUNTRY")+"<br>";
					if ((dlvAddresses.getFieldValueString(i,"TEL_NUMBER") != null) && (dlvAddresses.getFieldValueString(i,"TEL_NUMBER") != "null"))
					payerInfo+="<strong>Tel#:</strong>&nbsp;"+dlvAddresses.getFieldValueString(i,"TEL_NUMBER")+"<br>";
					if ((dlvAddresses.getFieldValueString(i,"FAX_NUMBER") != null) && (dlvAddresses.getFieldValueString(i,"FAX_NUMBER") != "null"))
					payerInfo+="<strong>Fax#:</strong>&nbsp;"+dlvAddresses.getFieldValueString(i,"FAX_NUMBER")+"<br>";

				}

			}
		}	

%>
		<p><%=soldToInfo%></p>
	</div>

	</div>
	<div class="col-2">
		<div class="info-box">
			<h2 class="sub-title">Ship To Info</h2>
			<p><%=payerInfo%></p>
		
		</div>
	</div>
	<div class="col-3">
		<div class="info-box">
			<h2 class="sub-title">Dates</h2>
			<p><strong>Shipped On:</strong>&nbsp;<%=dlvHeader2.getFieldValueString(0,"PICKDATE")%><br></p>
			<br>
			<h2 class="sub-title">Carrier and Tracking</h2>
			
			<% 
			String prot = "http:";
			if (request.getProtocol().indexOf("HTTPS") != -1) 
				 prot = "https:";
			String myServer = request.getServerName();
			String myApp = "AST";
			if (request.getRequestURI().indexOf("ASP") != -1)
				myApp = "ASP";
			String dlvShippingPartner = "";
			String carrDesc = "";
			if (dlvHeader.getFieldValueString(0,"ZZPOOLCRY")!=null && !dlvHeader.getFieldValueString(0,"ZZPOOLCRY").equals("")) {
					dlvShippingPartner = dlvHeader.getFieldValueString(0,"ZZPOOLCRY");
					carrDesc = dlvHeader.getFieldValueString(0,"POOLCARRIER_NAME1");
			}		
			else {
				dlvShippingPartner = dlvHeader.getFieldValueString(0,"ZZTDLNR");
				carrDesc = dlvHeader.getFieldValueString(0,"CARRIER_NAME1");
			}	
	
			String trUrl = prot+"//"+myServer+"/"+myApp+"/EzComm/EzSales/Sales/JSPs/Sales/ezTrackPackage.jsp?trackingNumber="+nullCheckBlank(dlvHeader.getFieldValueString(0,"LIFEX"))+"&shippingPartner="+dlvShippingPartner+"&dlvBolNumber="+nullCheckBlank(dlvHeader.getFieldValueString(0,"BOLNR"))+"&salesDocNo="+nullCheckBlank(dlvHeader.getFieldValueString(0,"ZZVBELN"))+"&lineNo="+""+"&PurchaseOrder="+poNumber+"&CarrierDesc="+carrDesc.replaceAll("&"," ");
			%>
			
			<p><strong>Carrier:</strong>&nbsp;<a class="fancyframe" id="getMultiTrack"  href="<%=trUrl%>" title="Click to view Tracking options"><span><%=carrDesc%></span></a><br></p>
			<!-- <p><strong>Pool Carrier:</strong>&nbsp;<%=nullCheckBlank(dlvHeader.getFieldValueString(0,"POOLCARRIER_NAME1"))%><br></p> -->
			<p><strong>Tracking No:</strong>&nbsp;<%=nullCheckBlank(dlvHeader.getFieldValueString(0,"LIFEX"))%><br></p>
			<p><strong>BOL No:</strong>&nbsp;<%=nullCheckBlank(dlvHeader.getFieldValueString(0,"BOLNR"))%><br></p>
			<!-- <p><strong>PRO No:</strong>&nbsp;<%=nullCheckBlank(dlvHeader.getFieldValueString(0,"ZZPRONUM"))%><br></p> -->
			
		</div>
	</div>
	
</div>
<br>
	<div id="divAction" style="display:block;">
	<% if (!billHeadersCnt.equals("1")) { %>
	 <!-- <div>
	 	<a href="javascript:funBack()"><span id="backbutton">Back to List</span></a>
	 </div> -->
	 	<button type="button" title="Back" class="button btn-update" onclick="javascript:funBack()"><span>Back to List</span></button>
 	<% } %>

	<button type="button" title="Print" class="button btn-update" onclick="javascript:getPrintDtl('ASN')"><span>Print ASN/Packing Slip</span></button>
	<!-- <button type="button" title="Print" class="button btn-update" onclick="javascript:getPrintDtl('PACK')"><span>Print Packing Slip</span></button> -->
	</div>

<br>
 <div class="col1-set">
 <div class="info-box">
 
<form name="myForm" method="POST">	
<input type="hidden" name="salesOrder" value='<%=soNumber%>'>
<input type="hidden" name="PurchaseOrder" value='<%=poNumber%>'>
<input type="hidden" name="soldTo" value="<%=soldto%>">
<input type="hidden" name="soldToCode" value="<%=soldtoFromSO%>">
<input type="hidden" name="delivNo" value="<%=dlvDocNumber%>">
<input type="hidden" name="prodCode_D">
<br>

 <%
 
	String childComponents = "";
	String delimitedChildComponents = "";
	String childComponentsLineNos = "";
	String parentItemComp = "";
	String itemDescComp = "";
	String matnoComp = "";
	String salesDocNoComp = "";
	String lineNoComp = "";
	String itemQtyComp = "";
	for ( int ploop=0;ploop<delDetailsCnt;ploop++){
		String lineNo = dlvDetails.getFieldValueString(ploop,"DELIV_ITEM");
		String salesDocNo = dlvDetails.getFieldValueString(ploop,"DELIV_NUMB");
	for(int itemc=0;itemc<delDetailsCnt;itemc++){
		parentItemComp = "";
		itemDescComp = "";
		matnoComp = "";
		salesDocNoComp = "";
		lineNoComp = "";
		parentItemComp =         dlvDetails.getFieldValueString(itemc,"ZKITITEMNO");//slsOrdLineRetObj
		itemDescComp                 = dlvDetails.getFieldValueString(itemc,"DESC");
		matnoComp                       = dlvDetails.getFieldValueString(itemc,"PROD_NO");
		salesDocNoComp            = dlvDetails.getFieldValueString(itemc,"DELIV_NUMB");
		lineNoComp                       = dlvDetails.getFieldValueString(itemc,"DELIV_ITEM");
		itemQtyComp = dlvDetails.getFieldValueString(itemc,"QTY");
		//out.println("Current Line Number for ploop is "+lineNo +"<br>");
		//out.println("Current Line Number in itemc loop is "+lineNoComp +"<br>");
		//out.println("Parent ItemComp , matnoComp, SalesDocNoComp, lineNoComp "+parentItemComp+"\t"+itemDescComp+"\t"+matnoComp+"\t"+salesDocNoComp+"\t"+lineNoComp+"<br>");
		if (parentItemComp.equals(lineNo))
		{
			// Components Parent Item # matches the current Line #, and sales order nr is same
			// This component belongs to current line
			childComponents+="" +
			matnoComp 
			+ " " 
			+ itemDescComp
			+ "&nbsp;<br/>";
			delimitedChildComponents+= ""+ matnoComp + ":" + itemQtyComp + "#";
			childComponentsLineNos+=lineNoComp+":"+itemQtyComp+";";

			//matnoComp+" "+itemDescComp+;                     
			//out.println("My Line Number is "+lineNoComp +"<br>");
			//out.println("Child component "+ childComponents+" for Parent Item"+dlvDetails.getFieldValueString(ploop,"PROD_NO")+"<br>");
			//out.println("\nParent Item for this one is " +parentItem);
		}

	 } // end for itemc loop
	 if (!childComponents.trim().equals("")){
%>	 
	 <input type='hidden' name='childComponents<%=lineNo%>' id='childComponents<%=lineNo%>' value='<%=childComponents%>'>
<%	 
	}
	childComponents = "";
	} // end ploop

 
%>
 	<table class="data-table" id="example">
 	<thead>
 	<tr>
 	<!-- <th width="10%">&nbsp;</th>-->
 	<th width="5%">Line No</th>
 	<th width="15%"> Product No</th>
 	<th width="40%"> Description</th>
 	<th width="15%"> Shipped <br>Quantity</th>
 	<th width="15%"> UOM</th>
 	
 	</tr>
 	</thead>
 	<tbody>
<%
 	java.math.BigDecimal totTax = new java.math.BigDecimal("0");
 	String kitItemNo =  "",kitMatNo = "";
 	for(int i=0;i<delDetailsCnt;i++)
 	{
 		
 		String prodCode		= dlvDetails.getFieldValueString(i,"PROD_NO");
 		String prodDesc		= dlvDetails.getFieldValueString(i,"DESC");
 		String uom		= dlvDetails.getFieldValueString(i,"UOM");
 		String quantity         = dlvDetails.getFieldValueString(i,"QTY");
 		String itemCat         = dlvDetails.getFieldValueString(i,"DELIV_ITEM_CAT");
 		kitItemNo         = nullCheckBlank(dlvDetails.getFieldValueString(i,"ZKITITEMNO"));
 		kitMatNo        = nullCheckBlank(dlvDetails.getFieldValueString(i,"ZKITMATNO"));
 		
 		//out.println(dlvDetails.getFieldValueString(i,"DELIV_ITEM_CAT")+"---"+kitMatNo);
 		if ( kitMatNo.trim().equals("")) {
 %>
 	<tr>
 		<td width="1%"><div id="solineinfo"><%=dlvDetails.getFieldValueString(i,"DELIV_ITEM")%><%="\n"%></div></td>
 		<td width="15%" >
 				<a href="javascript:getProductDetails('<%=prodCode%>')" title="<%=prodDesc%>" target="_blank"><%=prodCode%></a>
 		</td>
 		<td width="40%"><%=prodDesc%>&nbsp;</td>
 		<td  width="15%"><%=eliminateDecimals(quantity)%></td>
 		<td  width="15%"><%=uom%></td>
 		
 	</tr>
 <%
 	} // end of if check on being parent item
 	}
 %>
 	</tbody>
 	
 	</table>
 	<br>
	<!-- <P><input type="button" onClick="javascript:getPrintDtl()" value="Print"/></P> -->
 	
 	</form>
 	</div>
 </div> <!-- Info box -->
 </div> <!-- col1-set -->
 </div> <!-- col-main -->
 </div> <!--main -->
</div> <!-- main-container col1-layout -->
<%!
	public String nullCheck(String str)
	{
		String ret = str;

		if(ret==null || "null".equalsIgnoreCase(ret) || "".equals(ret))
			ret = "N/A";
		return ret;
	}
	public String nullCheckBlank(String str)
		{
			String ret = str;
	
			if(ret==null || "null".equalsIgnoreCase(ret) || "".equals(ret))
				ret = "";
			return ret;
	}
%>

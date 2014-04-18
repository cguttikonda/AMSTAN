<%@page import="ezc.sapconnection.*"%>
<%@page import="com.sap.mw.jco.*"%>

<%@page  import="ezc.ezparam.ReturnObjFromRetrieve,ezc.ezparam.*,ezc.ezcommon.*"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="ShManager" class="ezc.ezshipment.client.EzShipmentManager" scope="session" />
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<jsp:useBean id="CustInvManager" class ="ezc.customer.invoice.client.EzCustomerInvoiceManager" scope="page" />
<link rel="stylesheet" type="text/css" href="../../Library/Styles/style0.css">
  <link rel="stylesheet" type="text/css" href="../../Library/Styles/style1.css" media="all">
  <link rel="stylesheet" type="text/css" href="../../Library/Styles/style2.css" media="print">
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
 <script type="text/javascript" src="../../Library/Script/complete.min.js"></script>
 <script type="text/javascript" src="../../Library/Script/jquery.dataTables.min.js"></script> 
 <script type="text/javascript" src="../../Library/Script/TableTools-2.1.1/js/TableTools.min.js"></script> 
 
 <script  src="../../Library/Script/colResizable-1.3.min.js"></script>
 <script type="text/javascript" src="../../Library/Script/jquery-ui-1.8.21.all.min.js"></script> 
  
 
<%

	String type = "PDF"; 	
	String sonum = request.getParameter("custInvNo");	//0090075491
	String soldTo= (String)session.getValue("AgentCode");	// "0010006806";//request.getParameter("soldTo");
	boolean showPDF=true;
	String siteNo = (String)session.getValue("Site");
	String fromPage = request.getParameter("fromPage");
	
	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(true);
	EziPrintParams params= new EziPrintParams();
	params.setObjectType("BD");	
	params.setObjectNo(sonum);
	params.setDocType(type);
	params.setCustomer(soldTo);
	//params.setMsgType(xmlMsgType);	
	mainParams.setObject(params);
	Session.prepareParams(mainParams);
	javax.servlet.ServletOutputStream sos=null;
	
		
	try{
		 if ("PDF".equals(type))
		 {
		 	
			 JCO.Client client1=null;
			 JCO.Function function = null;

			 try
			 {
				 client1 = EzSAPHandler.getSAPConnection(siteNo+"~999");
				 function = EzSAPHandler.getFunction("Z_EZ_PRINT_DOCUMENT",siteNo+"~999");
				 JCO.ParameterList  printDetail = function.getImportParameterList();
				 JCO.Table tabList = null;
				 printDetail.setValue("V3","OBJTYPE");
				 printDetail.setValue(soldTo,"CUSTOMER");
				 printDetail.setValue("P","DOCTYPE");
				 printDetail.setValue(sonum,"OBJNUMBER");
				 printDetail.setValue("ZRD2","MSGTYPE");
				 
				try{
					client1.execute(function);
					byte Z_STRING[]= (function.getExportParameterList()).getByteArray("Z_STRING");
					if (Z_STRING.length > 0 ) {
						response.setContentType("application/x-download");
					        response.setHeader ("Content-Disposition", "attachment;filename="+sonum+".pdf");
						sos=response.getOutputStream();           
						sos.write(Z_STRING);
					}	
					else {
						ezc.ezcommon.EzLog4j.log("============>1234--> SIZE OF RECEIVED BYTEARRAY "+Z_STRING.length,"I"); 
						showPDF = false;
					}	
				}catch(Exception err){
				ezc.ezcommon.EzLog4j.log("============>1234--> send o/p Stream for Invoice output for Invoice nr "+sonum,"I"); 
				showPDF = false;
				}

			}catch(Exception e){
			
			ezc.ezcommon.EzLog4j.log("============>1234-->Exception "+e.toString(),"I"); 
			showPDF = false;
			}
			finally
			{
				   if (client1!=null)
				   {
					JCO.releaseClient(client1);
					client1 = null;
					function=null;
					sos.close();
				    }
			}
		 	
		}
	}
	catch(Exception e)
	{
		
		showPDF=false;
	}
	
	if(!showPDF)
	{
	  	String display_header = "";
%>	        
		
  <body class=" customer-account-index">
  <div class="wrapper container" id="top-of-page">
  	<noscript>
          &lt;div class="noscript"&gt;
              &lt;div class="noscript-inner"&gt;
                  &lt;p&gt;&lt;strong&gt;JavaScript seem to be disabled in your browser.&lt;/strong&gt;&lt;/p&gt;
                  &lt;p&gt;You must have JavaScript enabled in your browser to utilize the functionality of this website.&lt;/p&gt;
              &lt;/div&gt;
          &lt;/div&gt;
  	</noscript>
  <form id="myForm" name="myForm" method="POST">
 	
	<input type='hidden' name='SalesOrder' value='<%=request.getParameter("SalesOrder")%>'>
	<input type='hidden' name='soNumber' value='<%=request.getParameter("SalesOrder")%>'>
	<input type='hidden' name='PurchaseOrder' value='<%=request.getParameter("PurchaseOrder")%>'>
	<input type='hidden' name='poNumber' value='<%=request.getParameter("PurchaseOrder")%>'>
	<input type="hidden" name="soldTo" value="<%=soldTo%>">
	<input type="hidden" name="soldToCode" value="<%=soldTo%>">
	<input type="hidden" name="sapInvNo" value="<%=sonum%>">
	<input type="hidden" name="fromPage" value=""> <!-- Invoice page needs it for knowing if it came from List or details. Pass blank here so that it considers it as 'N' -->
	<input type='hidden' name='Site' value='200'>
	
	
 </form>
 <div id="dialog-confirm" title="Print Error">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Could not Print at this time. Click to go back to Invoice Document</p>
</div>		
</body>
		
		
		
<%
	}
%>
<script type="text/javascript">

function funBack(from)
{
	if(from=='N')
		document.myForm.action = "ezSOInvoiceList.jsp";
	else if(from=='Y')
		document.myForm.action = "ezSOInvoiceDetailsMain.jsp";
	document.myForm.submit();
}

 
 $(function() {
  
  	$( "#dialog-confirm" ).dialog({
  		resizable: false,
  		height:200,
  		modal: true,
  		buttons: {
  			"Continue": function() {
  				$( this ).dialog( "close" );
  				funBack('Y');
  			}
  		}
  	});
	});
</script>


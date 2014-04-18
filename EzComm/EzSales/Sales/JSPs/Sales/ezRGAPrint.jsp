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
 	String rgaNumber = request.getParameter("rgaNumber");
 	//String poNumber = request.getParameter("PurchaseOrder");
 	
 	
 	//String rgaNumber = request.getParameter("delivNo"); //request.getParameter("custInvNo");	//0090075491
 	String soldTo= request.getParameter("soldTo");//(String)session.getValue("AgentCode");	// "0010006806";//request.getParameter("soldToCode");
 	boolean showPDF=true;
 	String siteNo = (String)session.getValue("Site");
 	String fromPage = request.getParameter("fromPage");
 	ezc.ezcommon.EzLog4j.log("rgaNumber>>>>>>>>>>>>>>>>>>>>>>"+rgaNumber,"D");
 	ezc.ezcommon.EzLog4j.log("soldTo>>>>>>>>>>>>>>>>>>>>>>"+soldTo,"D");
 	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(true);
 	EziPrintParams params= new EziPrintParams();
 	params.setObjectType("BD");	
 	params.setObjectNo(rgaNumber);
 	params.setDocType(type);
 	params.setCustomer(soldTo);
 	//params.setMsgType(xmlMsgType);	
 	mainParams.setObject(params);
 	Session.prepareParams(mainParams);
 	javax.servlet.ServletOutputStream sos=null;
 	//response.setContentType("application/x-download");
 	//response.setHeader ("Content-Disposition", "attachment;filename="+rgaNumber+".pdf");
 		
 	try{
 		 if ("PDF".equals(type))
 		 {
 		 	
			 JCO.Client client1=null;
			 JCO.Function function = null;
			 //javax.servlet.ServletOutputStream sos=null;
			 try
			 {
				 client1 = EzSAPHandler.getSAPConnection(siteNo+"~999");
				 function = EzSAPHandler.getFunction("Z_EZ_PRINT_DOCUMENT",siteNo+"~999");
				 JCO.ParameterList  printDetail = function.getImportParameterList();
				 JCO.Table tabList = null;
				 printDetail.setValue("V1","OBJTYPE");
				 printDetail.setValue("ZBA1","MSGTYPE");
				 //printDetail.setValue("ZASE","MSGTYPE");
				 printDetail.setValue(zeroPad(soldTo,10),"CUSTOMER");
				 printDetail.setValue("P","DOCTYPE");
				 
				 printDetail.setValue(zeroPad(rgaNumber,10),"OBJNUMBER");
				
 	
				try{
					client1.execute(function);
					byte Z_STRING[]= (function.getExportParameterList()).getByteArray("Z_STRING");
					if (Z_STRING.length == 0){
						showPDF = false;
					} else {
					 response.setContentType("application/x-download");
				 	response.setHeader ("Content-Disposition", "attachment;filename="+rgaNumber+".pdf");
					sos=response.getOutputStream();           
					sos.write(Z_STRING);
					ezc.ezcommon.EzLog4j.log("============>1234--> send o/p Stream for RGA output for RGA nr "+rgaNumber,"I"); 
					}
				}catch(Exception err){
				
				ezc.ezcommon.EzLog4j.log("============>1234-->Exception"+err.toString(),"I"); 
				showPDF = false;
				}

			}catch(Exception e){
				
				ezc.ezcommon.EzLog4j.log("============>1234-->Exception"+e.toString(),"I"); 
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
 	
  	
	<input type="hidden" name="soldTo" value="<%=soldTo%>">
	<input type="hidden" name="rgaNumber" value="<%=rgaNumber%>">
	<input type="hidden" name="billHeadersCnt" value="1">
 </form>
 <div id="dialog-confirm" title="Print Error">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Could not Print at this time. Click to go back to RGA Document</p>
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
 		document.myForm.action = "ezSORGADetailsMain.jsp";
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
 
<%!
public String zeroPad (String value, int size) {
  String s = "0000000000"+value;
  return s.substring(s.length() - size);
}
%>
<%@page import="ezc.sapconnection.*"%>
<%@page import="com.sap.mw.jco.*"%>

<%@page  import="ezc.ezparam.ReturnObjFromRetrieve,ezc.ezparam.*,ezc.ezcommon.*"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="ShManager" class="ezc.ezshipment.client.EzShipmentManager" scope="session" />
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<jsp:useBean id="CustInvManager" class ="ezc.customer.invoice.client.EzCustomerInvoiceManager" scope="page" />

<%

	String type = "PDF"; 	
	String sonum = request.getParameter("SalesOrder"); //request.getParameter("custInvNo");	//0090075491
	String soldTo= request.getParameter("soldToCode");//(String)session.getValue("AgentCode");	// "0010006806";//request.getParameter("soldToCode");
	boolean showPDF=true;
	String siteNo = (String)session.getValue("Site");
	String fromPage = request.getParameter("fromPage");
	ezc.ezcommon.EzLog4j.log("sonum>>>>>>>>>>>>>>>>>>>>>>"+sonum,"D");
	ezc.ezcommon.EzLog4j.log("soldTo>>>>>>>>>>>>>>>>>>>>>>"+soldTo,"D");
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
	
	response.setContentType("application/x-download");
	response.setHeader ("Content-Disposition", "attachment;filename="+sonum+".pdf");
		
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
					 		//printDetail.setValue("BA00","MSGTYPE");
					 		 printDetail.setValue(soldTo,"CUSTOMER");
					 		 printDetail.setValue("P","DOCTYPE");
					 		 printDetail.setValue(sonum,"OBJNUMBER");
					 		try{
					 			client1.execute(function);
					 			byte Z_STRING[]= (function.getExportParameterList()).getByteArray("Z_STRING");
					 			sos=response.getOutputStream();           
					 			sos.write(Z_STRING);
					 		}catch(Exception err){}
							
							ezc.ezcommon.EzLog4j.log("============>1234","I"); 
					 		ezc.ezcommon.EzLog4j.log("============>12345","I");
					 	}catch(Exception e){}
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
		 	/*
			//ezc.ezsap.V46B.generated.ZrawtabTable myTable=(ezc.ezsap.V46B.generated.ZrawtabTable)ShManager.ezGetPrintVersion(mainParams);
			ReturnObjFromRetrieve myTable=(ReturnObjFromRetrieve)ShManager.ezGetPrintVersion(mainParams);
			
			int rowCount=myTable.getRowCount();
			
			if (rowCount >= 55)
			{
				response.setContentType("application/x-download");
				response.setHeader ("Content-Disposition", "attachment;filename="+sonum+".pdf");
				//ezc.ezsap.V46B.generated.ZrawtabTableRow myTableRow=null;
				sos=response.getOutputStream();	
				for(int i=0;i<rowCount;i++)
				{
					//myTableRow=myTable.getRow(i);
					//sos.write(myTableRow.getZline());
					byte[] b=(byte[])myTable.getFieldValue(i,"OUTTAB");
					sos.write(b);
				}
			}
			else
			{
				showPDF=false;	
			}
			*/
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
	<div class="main-container col2-layout middle account-pages">
	<div class="main">
	<div class="col-main1">
	<div class="page-title">
		
		<%
		String dispHeader = "Invoice Print";
		%>
		<h2 class="sub-title"><%=dispHeader%></h2>
	</div> <!-- page-title -->
	<div class="col1-set">
	<div class="info-box">
	<form name="myForm" method="POST">	

		<input type='hidden' name='SalesOrder' value='<%=request.getParameter("soNumber")%>'>
		<input type='hidden' name='PurchaseOrder' value='<%=request.getParameter("poNumber")%>'>


	</form>
		
		<div>
		<br><br>
		<Table align=center><Tr><Td class=displayheader>Sorry ! Document Disabled for Printing.</Td></Tr></Table><br><br>
		<br><br><Table align='center'><Tr><Td>Contact System Administrator for further Details.</Td></Tr></Table>
		<br><br>
			<a href="javascript:funBack('<%=fromPage%>')"><span>Back to List</span></a>
			
			
		</div>
			
		</div> <!-- Info box -->
		</div> <!-- col1-set -->
		</div> <!-- col-main -->
		</div> <!--main -->
</div> <!-- main-container col1-layout -->
		
		
		
<%
	}
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

function funBack(from)
{
	if(from=='N')
		document.myForm.action = "ezSOInvoiceList.jsp";
	else if(from=='Y')
		document.myForm.action = "ezOpenInvoices.jsp";
	document.myForm.submit();
}

</script>


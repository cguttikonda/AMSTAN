<%@page import="ezc.sapconnection.*"%>
<%@page import="com.sap.mw.jco.*"%>

<%@page  import="ezc.ezparam.ReturnObjFromRetrieve,ezc.ezparam.*,ezc.ezcommon.*"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="ShManager" class="ezc.ezshipment.client.EzShipmentManager" scope="session" />
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%

	String type = "PDF"; 	
	String sonum = request.getParameter("custInvNo");	//0090075491
	String soldTo= (String)session.getValue("AgentCode");	// "0010006806";//request.getParameter("soldTo");
	boolean showPDF=true;
	String siteNo = (String)session.getValue("Site");
	
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
					 		 printDetail.setValue("V3","OBJTYPE");
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
			
			//if (rowCount >= 55)
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
			//else
			//{
			//	showPDF=false;	
			//}
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
	        <%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>

	        <%@ include file="../../../Sales2/JSPs/Misc/ezDisplayHeader.jsp"%>
		<br><br>
			<Table align=center><Tr><Td class=displayheader>Sorry ! Sales Order Disabled for Printing.</Td></Tr></Table><br><br>
			<br><br><Table align='center'><Tr><Td>Contact System Administrator for further Details.</Td></Tr></Table>
		<br><br>
<%
	}
%>

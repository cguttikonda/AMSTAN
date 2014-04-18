<%@page import="ezc.sapconnection.*"%>
<%@page import="com.sap.mw.jco.*"%>
<%@page  import="ezc.ezparam.ReturnObjFromRetrieve,ezc.ezparam.*,ezc.ezcommon.*"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="ShManager" class="ezc.ezshipment.client.EzShipmentManager" scope="session" />
<%@ include file="../Labels/iPrint_Labels.jsp"%>
<%	
	PrintWriter pwriter 		= null;
	StringReader stringReader 	= null;

	String type = "PDF"; 	
	String ponum = request.getParameter("PurchaseOrder");
	String vendor= request.getParameter("vendorNo");
	boolean showPDF=true;
	String SiteNo = "640";//(String)session.getValue("Site");
	
	if(vendor==null || "null".equals(vendor))
		vendor  = (String)session.getValue("SOLDTO");
		
	//out.println(vendor+"##"+ponum);
	//params.setObjectNo("4500009217");
	//params.setVendor("DAESUN");
	
	
	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(true);
	EziPrintParams params= new EziPrintParams();
	params.setObjectType("PO");
	params.setObjectNo(ponum);
	params.setDocType(type);
	params.setVendor(vendor);
	mainParams.setObject(params);
	Session.prepareParams(mainParams);
	
			
	try{
		 if ("PDF".equals(type))
		 {
			
			 JCO.Client client1=null;
			 JCO.Function function = null;
			 javax.servlet.ServletOutputStream sos=null;
			 try
			 {
				 client1 = EzSAPHandler.getSAPConnection(SiteNo+"~999");
				 function = EzSAPHandler.getFunction("Z_EZ_PRINT_DOCUMENT",SiteNo+"~999");
				 JCO.ParameterList  printDetail = function.getImportParameterList();
				 JCO.Table tabList = null;
				 printDetail.setValue("EF","OBJTYPE");
				 printDetail.setValue(vendor,"VENDOR");
				 printDetail.setValue("P","DOCTYPE");
				 printDetail.setValue(ponum,"OBJNUMBER");
				try{
					client1.execute(function);
					byte Z_STRING[]= (function.getExportParameterList()).getByteArray("Z_STRING");
					
					if(Z_STRING!=null && Z_STRING.length > 10){
						response.setContentType("application/x-download");
						response.setHeader ("Content-Disposition", "attachment;filename="+ponum+".pdf");
						sos=response.getOutputStream();           
						sos.write(Z_STRING);
					}else{
						showPDF = false;
					}	
				}catch(Exception err){}

				ezc.ezcommon.EzLog4j.log("============>1234"+vendor,"I"); 
				ezc.ezcommon.EzLog4j.log("============>12345"+ponum,"I");
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
			ReturnObjFromRetrieve myTable=(ReturnObjFromRetrieve)ShManager.ezGetPrintVersion(mainParams);
			int rowCount=myTable.getRowCount();
			response.setContentType("application/x-download");
			response.setHeader ("Content-Disposition", "attachment;filename="+ponum+".pdf");
			pwriter = new PrintWriter(response.getOutputStream());
			int charInt;
			for(int i=0;i<rowCount;i++)
			{
				//byte[] b=(byte[])myTable.getFieldValue(i,"OUTTAB");
				//pwriter.write(b);
				charInt=0;										
				stringReader = new StringReader(new String(myTable.getFieldValueString(i,"OUTTAB").getBytes("UTF-16LE")));
				while ((charInt = stringReader.read()) != -1)
				{
					pwriter.write((char)charInt);
					//log4j.log("Print Letter-->"+(char)charInt,"W");
				}
			}
			*/
		}
	}
	catch(Exception e)
	{
		showPDF=false;

	}
	finally
	{
		//if (sos!=null)
		//	sos.close();
	}
	if(!showPDF)
	{
	  	String display_header = "";
	  	String noDataStatement = sorryPrint_L+"<BR><BR>"+conSysAdm_L;
%>
		<html>
		<head>
	        	<%@include file="../../Lib/AddButtonDir.jsp" %>
	        </head>
	        <body scroll=no>
	        	<%@ include file="../../../Vendor2/JSPs/Misc/ezDisplayHeader.jsp"%>
	        	<%@ include file="../../../Vendor2/JSPs/Misc/ezDisplayNoData.jsp"%>
	        	<Div id="MenuSol"></Div>
	        </body>
	        </html>
<%
	}
%>

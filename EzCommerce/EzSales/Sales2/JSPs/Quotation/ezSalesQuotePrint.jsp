<%@ page import="java.io.*"%>
<%@page import="ezc.sapconnection.*"%>
<%@page import="com.sap.mw.jco.*"%>
<%@ page import="ezc.ezparam.*" %>
<%@page  import="ezc.ezparam.ReturnObjFromRetrieve,ezc.ezparam.*,ezc.ezcommon.*"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="ShManager" class="ezc.ezshipment.client.EzShipmentManager" scope="session" />
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<% 
	String type = "PDF"; 	
	String sonum = request.getParameter("salesQuote");
	String soldTo= (String)session.getValue("AgentCode");
	boolean showPDF=true;

	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(true);
	EziPrintParams params= new EziPrintParams();
	params.setObjectType("SO");	//BD
	params.setObjectNo(sonum);
	params.setDocType(type);
	params.setCustomer(soldTo);
	//params.setMsgType(xmlMsgType);	//ZRD0
	
	mainParams.setObject(params);
	Session.prepareParams(mainParams);
	javax.servlet.ServletOutputStream sos=null;
	
	PrintWriter pwriter 		= null;
	StringReader stringReader 	= null;

	String Site=(String)session.getValue("Site");
	try
	{
		 if ("PDF".equals(type))
		 {
		 
	   	    	 JCO.Client client1=null;
                         JCO.Function function = null;
		 	 try
		 	 {
		                 client1 = EzSAPHandler.getSAPConnection(Site+"~999");
		 		 function = EzSAPHandler.getFunction("Z_EZ_PRINT_DOCUMENT",Site+"~999");
		 		 JCO.ParameterList  printDetail = function.getImportParameterList();
		 		 JCO.Table tabList = null;
		 		 printDetail.setValue("V1","OBJTYPE");
		 		 printDetail.setValue(soldTo,"CUSTOMER");
		 		 printDetail.setValue("P","DOCTYPE");
		 		 printDetail.setValue(sonum,"OBJNUMBER");
		 		try{
		 			client1.execute(function);
		 			byte Z_STRING[]= (function.getExportParameterList()).getByteArray("Z_STRING");
					if(Z_STRING!=null && Z_STRING.length > 10){
						response.setContentType("application/x-download");
						response.setHeader ("Content-Disposition", "attachment;filename="+sonum+".pdf");
						sos=response.getOutputStream();           
						sos.write(Z_STRING);
					}else{
						showPDF = false;
						ezc.ezcommon.EzLog4j.log("============>1234else","I"); 
					}
		 		}catch(Exception err){}
				
				ezc.ezcommon.EzLog4j.log("============>1234","I"); 
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
		 }
	 }	 
	 catch(Exception err)
	 {
	 	showPDF=false;
	 }
	
	if(!showPDF)
	{
	  	String display_header = "";
	  	String noDataStatement =  "Sales Order/Quote is currently being reviewed by Continental Resources. Please revisit later to Print";
%>	        
	        <html>
				<head>
			        	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
					
					
			        </head>
			        <body scroll=no>
			        
			        	<%@ include file="../../../Sales2/JSPs/Misc/ezDisplayHeader.jsp"%>
	       				<%@ include file="../../../Sales2/JSPs/Misc/ezDisplayNoData.jsp"%>
			        				        				        
			        <Div id="ButtonDiv" style="position:absolute;top:90%;width:100%;visibility:visible">
				<center>
				<%
		
					buttonName = new java.util.ArrayList();
					buttonMethod = new java.util.ArrayList();
		
					buttonName.add("Back");
					buttonMethod.add("history.go(-1)");
					out.println(getButtonStr(buttonName,buttonMethod));
				%>
				</center>
				</DIV>
			        	
			        	<Div id="MenuSol"></Div>
			        </body>
	        </html>
<%
	}
%>

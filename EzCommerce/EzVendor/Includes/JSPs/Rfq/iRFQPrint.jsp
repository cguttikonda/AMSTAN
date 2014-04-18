<%@page  import="ezc.ezparam.ReturnObjFromRetrieve,ezc.ezparam.*,ezc.ezcommon.*"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="ShManager" class="ezc.ezshipment.client.EzShipmentManager" scope="session" />


<%	
	String type 		= 	"PDF"; 	
	String RFQNo 		= 	request.getParameter("PurchaseOrder");
	String rfqVendor	=	request.getParameter("rfqVendor");
	String display_header = "";
	boolean showPDF=true;
	
	
	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(true);
	EziPrintParams params= new EziPrintParams();
	params.setObjectType("RFQ");
	params.setObjectNo(RFQNo);
	params.setDocType(type);
	if(rfqVendor!=null && !"null".equals(rfqVendor))
	{
		params.setVendor(rfqVendor);
	}
	else
	{
		params.setVendor((String)session.getValue("SOLDTO"));
	}	
	mainParams.setObject(params);
	Session.prepareParams(mainParams);
	javax.servlet.ServletOutputStream sos=null;
%>
	
<%
	try{
		if ("TEXT".equals(type))
		{
			response.setContentType("application/x-download");
			response.setHeader ("Content-Disposition", "attachment;filename="+RFQNo+".txt");

			ezc.ezsap.V46B.generated.SoliTable myTable=(ezc.ezsap.V46B.generated.SoliTable)ShManager.ezGetPrintVersion(mainParams);
			int rowCount=myTable.getRowCount();
			ezc.ezsap.V46B.generated.SoliTableRow myTableRow=null;
			for(int i=0;i<rowCount;i++)
			{
				myTableRow=myTable.getRow(i);
			}
		}
		else if ("PDF".equals(type))
		{
			ezc.ezsap.V46B.generated.ZrawtabTable myTable=(ezc.ezsap.V46B.generated.ZrawtabTable)ShManager.ezGetPrintVersion(mainParams);
			int rowCount=myTable.getRowCount();

			if (rowCount > 55)
			{
				response.setContentType("application/x-download");
				response.setHeader ("Content-Disposition", "attachment;filename="+RFQNo+".pdf");

				ezc.ezsap.V46B.generated.ZrawtabTableRow myTableRow=null;
				sos=response.getOutputStream();	
				for(int i=0;i<rowCount;i++)
				{
					myTableRow=myTable.getRow(i);
					//out.println(String.valueOf(myTableRow.getZline()));
					sos.write(myTableRow.getZline());
				}
			}
			else
			{
				showPDF=false;

			}
		}
	}
	catch(Exception e)
	{
			showPDF=false;


	}
	
	if(!showPDF)
	{
%>	
				<%@include file="../../Lib/AddButtonDir.jsp" %>
				<%@ include file="../../../Vendor2/JSPs/Misc/ezDisplayHeader.jsp"%>
				<br><br>
				<Table align=center><Tr><Td class=displayheader>Sorry ! Purchase Order Disabled for Printing.</Td></Tr></Table><br><br>
				<br><br><Table align='center'><Tr><Td>Contact System Administrator for further Details.</Td></Tr></Table>
				<br><br>
<%		
				butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
				butActions.add("history.go(-1)");
	    			out.println(getButtons(butNames,butActions));
	}
	if (sos!=null)
		sos.close();

%>

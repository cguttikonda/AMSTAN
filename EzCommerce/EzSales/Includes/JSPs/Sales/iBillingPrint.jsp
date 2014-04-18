<%@page  import="ezc.ezparam.ReturnObjFromRetrieve,ezc.ezparam.*,ezc.ezcommon.*"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="EzSalesOrderManager" class="ezc.sales.client.EzSalesOrderManager" scope="session" />
<%


	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(true);
	ezc.ezcommon.EziPrintParams params= new ezc.ezcommon.EziPrintParams();
	javax.servlet.ServletOutputStream sos=null;
	String type = "PDF";
                   String ext = null;
	int rowcount = 0;

	String ponum = request.getParameter("custInvNo");

	String status = request.getParameter("status");
	String newFilter = request.getParameter("newFilter");

	newFilter=(newFilter == null)?"null":newFilter;

//type="sur";
	params.setObjectNo(ponum);
	params.setDocType(type);



	mainParams.setObject(params);
	Session.prepareParams(mainParams);
                 Object O =  EzSalesOrderManager.ezBillingPrint(mainParams);
	       // Object O =  EzSalesOrderManager.ezDispatchPrint(mainParams);

           if ("TEXT".equals(type))
	{
		rowcount = ((ezc.ezsap.V46B.generated.SoliTable)O).getRowCount();
                         	   ext = ".txt";
	}else if ("PDF".equals(type))
	{
		rowcount = ((ezc.ezsap.V46B.generated.ZrawtabTable)O).getRowCount();
                   	ext = ".pdf";
	}

	if (rowcount > 0)
	{

		                response.setContentType("application/x-download");
 		   	  response.setHeader ("Content-Disposition", "attachment;filename="+ponum+ext);
	                             try {
				sos=response.getOutputStream();
				if ("TEXT".equals(type))
				{
					ezc.ezsap.V46B.generated.SoliTable myTable=(ezc.ezsap.V46B.generated.SoliTable) O;
					ezc.ezsap.V46B.generated.SoliTableRow myTableRow=null;

					for(int i=0;i<rowcount;i++)
					{
						myTableRow=myTable.getRow(i);
						sos.write((myTableRow.getLine()).getBytes());
					}
				}else if ("PDF".equals(type))
				{
					ezc.ezsap.V46B.generated.ZrawtabTable myTable=(ezc.ezsap.V46B.generated.ZrawtabTable)O;
					ezc.ezsap.V46B.generated.ZrawtabTableRow myTableRow=null;
					for(int i=0;i<rowcount;i++)
					{
						myTableRow=myTable.getRow(i);
						sos.write(myTableRow.getZline());
					}
				}else
				{
					response.sendRedirect("ezPrintError.jsp?SONumber="+ponum+"&status ="+status +"&newFilter="+newFilter);
				}
			     } catch(Exception e)
	  		    {
				out.println(e.getMessage());
				sos.close();
			}
			sos.close();

	}else{
		response.sendRedirect("ezPrintError.jsp?SONumber="+ponum+"&status ="+status +"&newFilter ="+newFilter);
	}


%>

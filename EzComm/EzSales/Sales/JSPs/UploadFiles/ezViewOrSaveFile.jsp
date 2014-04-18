<%@page import="ezc.sapconnection.*"%>
<%@page import="com.sap.mw.jco.*"%>
<%
	String lineNo 	= request.getParameter("lineNo");
	String docName	= request.getParameter("fileKey_"+lineNo);
	String docId	= request.getParameter("fileVal_"+lineNo);
	//docName = "test.xls";

	javax.servlet.ServletOutputStream sos=null;

	response.setContentType("application/x-download");
	response.setHeader("Content-Disposition", "attachment;filename="+docName);

	try
	{
		 JCO.Client client1=null;
		 JCO.Function function = null;

		String site_S = (String)session.getValue("Site");
		String skey_S = "999";

		 try
		 {
			client1 = EzSAPHandler.getSAPConnection(site_S+"~"+skey_S);
			function = EzSAPHandler.getFunction("Z_EZ_DOCATT_DISPLAY",site_S+"~"+skey_S);

			JCO.ParameterList docDet = function.getImportParameterList();

			docDet.setValue(docId,"DOCUMENT_ID");
			docDet.setValue("H","ATTACHMENT_TYPE");

			try
			{
				client1.execute(function);
				byte Z_STRING[]= (function.getExportParameterList()).getByteArray("Z_STRING");
				sos=response.getOutputStream();
				sos.write(Z_STRING);
			}
			catch(Exception err){}
		}
		catch(Exception e){}
		finally
		{
			if(client1!=null)
			{
				JCO.releaseClient(client1);
				client1 = null;
				function=null;
				sos.close();
			}
		}
	}
	catch(Exception e){}
%>
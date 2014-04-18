<%@ page import="ezc.ezbasicutil.EzFileReader,java.util.*,java.io.*,ezc.ezsfa.params.*,ezc.ezparam.*,ezc.ezsynch.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />

<%

	Vector sectorsModified=new Vector();	
	String filePath="F:\\ora9ias\\EzRemoteSales\\SampleFiles\\Customer\\";
	String fileName=request.getParameter("fileName");
	if(fileName.indexOf("\\") >0 )
		fileName = fileName.substring(fileName.lastIndexOf("\\")+1);
	else if(fileName.indexOf("/") >0 )
		fileName = fileName.substring(fileName.lastIndexOf("/")+1);
		
	fileName = filePath+fileName;	


	ezc.ezbasicutil.Ez3PLCustMassSynch custSynch = new ezc.ezbasicutil.Ez3PLCustMassSynch();
	custSynch.setSession(Session);
	custSynch.addCustomerData(fileName);


	response.sendRedirect("ezConfirmCustSynch.jsp");
%>

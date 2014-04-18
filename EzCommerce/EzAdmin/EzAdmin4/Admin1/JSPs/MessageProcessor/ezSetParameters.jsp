
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>

<%
	String portOfUrl = null;
	try{
		long var_interval = new Long(request.getParameter("interval")).longValue();
		long var_starttime = new Long(request.getParameter("starttime")).longValue();
		long var_endtime = new Long(request.getParameter("endtime")).longValue();
		long var_testmode = 0;
		if (request.getParameter("testMode")!=null)
		{	
			var_testmode = 1;
		}

		ezc.eztransmessage.processor.EzScheduleParameters schparams = new ezc.eztransmessage.processor.EzScheduleParameters();
		schparams.setEndTimeofSchedule(var_endtime);
		schparams.setStartTimeofSchedule(var_starttime);
		schparams.setTimeInterval(var_interval);
		schparams.setTestMode((int)var_testmode);
//get RMI server
		ezc.ezutil.FileHandler fh = new ezc.ezutil.FileHandler("EzBuzRmiServers.properties", ezc.ezutil.FileHandler.READ);
		String line = fh.readLine();
		if (line!=null)
		{
			portOfUrl = "rmi://"+line.substring(line.indexOf("= ") + 2, line.length()) + "/";
		}	
		ezc.ezsem.ezsales.EzsSalesBusObjectIf ezRmi = (ezc.ezsem.ezsales.EzsSalesBusObjectIf)java.rmi.Naming.lookup(portOfUrl+"EzSalesBuz"+"100");
		if (ezRmi == null)
		{
			ezc.ezutil.EzSystem.out.println("Unable to get Rmi Server Reference for URL " + portOfUrl + "EzSalesBuz" + "100");
		}
		else
		{
			ezRmi.setScheduleParameters(null,schparams);
		}

		
	}catch(Exception e){
		ezc.ezutil.EzSystem.out.println("Unable to Get the RMI Server Reference :: " + e);
	}
	response.sendRedirect("ezMessageProcessor.jsp");
	

	
%>



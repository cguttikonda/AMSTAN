
<%
	long var_interval = 0 ;
	long var_starttime = 0;
	long var_endtime = 0;
	String portOfUrl = null;
	
	try{
		
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
			ezc.eztransmessage.processor.EzScheduleParameters schparams = new ezc.eztransmessage.processor.EzScheduleParameters();
			schparams = ezRmi.getScheduleParameters(null);
			if (schparams!=null)
			{
				var_interval = schparams.getTimeInterval();
				var_starttime = schparams.getStartTimeofSchedule();
				var_endtime = schparams.getEndTimeofSchedule();
			}

		}



	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	
%>
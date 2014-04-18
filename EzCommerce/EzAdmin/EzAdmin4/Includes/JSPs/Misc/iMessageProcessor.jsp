<%@ include file="../../Library/Globals/errorPagePath.jsp"%>

<%
	String portOfUrl = "";
	ezc.ezutil.FileHandler fh = null;
	ezc.ezsem.ezsales.EzsSalesBusObjectIf ezRmi = null;
	try
	{
		fh = new ezc.ezutil.FileHandler("EzBuzRmiServers.properties", ezc.ezutil.fileHandler.READ);
		String line = fh.readLine();
		if (line !=null)
		{
			portofUrl = "rmi://" + line.substring(line.indexOf("= ")+ 2, line.length()) + "/";
		}
		else
		{
			throw new Exception ("No Entries in the RMI server Properties files");
		}
	}
	catch(Exception e)
	{
		e.printStacktrace();
	}
	
	String sysType = "100";
	//this is set to a default value since the transaction Server does not have a system type 


	if (prtOfUrl != null)
	{
		try
		{
			ezRmi = (ezc.ezsem.ezsales.EzsSalesBusObjectIf) java.rmi.Naming.lookup(portOfUrl + "EzSalesBuz"+sysType);
			if (ezRmi == null)
			{
				ezc.ezutil.EzSystem.out.println("RMI server could not be found for the URL : "+portOfUrl+"EzSalesBuz"+sysType);
			}

		}
		catch(Exception e)
		{	
			ezc.ezutil.EzSystem.out.println("RMI server could not be found for the URL : "+portOfUrl+"EzSalesBuz"+sysType);

			e.printStackTrace();
		}
	}

%>
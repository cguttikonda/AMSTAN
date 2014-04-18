<%@ include file="../../Library/Globals/errorPagePath.jsp"%>

<%
	String portOfUrl = "";
	ezc.ezutil.FileHandler fh = null;
	ezc.ezsem.ezsales.EzsSalesBusObjectIf ezRmi = null;
	try
	{
		fh = new ezc.ezutil.FileHandler("EzBuzRmiServers.properties", ezc.ezutil.FileHandler.READ);
		String line = fh.readLine();
		if (line !=null)
		{
			portOfUrl = "rmi://" + line.substring(line.indexOf("= ")+ 2, line.length()) + "/";
		}
		else
		{
			throw new Exception ("No Entries in the RMI server Properties files");
		}
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	
	String sysType = "100";
	//this is set to a default value since the transaction Server does not have a system type 


	if (portOfUrl != null)
	{
		try
		{
			ezRmi = (ezc.ezsem.ezsales.EzsSalesBusObjectIf) java.rmi.Naming.lookup("rmi://192.168.3.25:1099/EzSalesBuz" + sysType);
			
			//ezRmi = (ezc.ezsem.ezsales.EzsSalesBusObjectIf) java.rmi.Naming.lookup(portOfUrl + sysType);
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
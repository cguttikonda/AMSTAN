<%@ include file="../../Library/Globals/errorPagePath.jsp"%>

<%
	String procserv = request.getParameter("processflag");
	try{
		String portOfUrl = "rmi://192.168.3.25:1099/";
		ezc.ezsem.ezsales.EzsSalesBusObjectIf ezRmi = (ezc.ezsem.ezsales.EzsSalesBusObjectIf) java.rmi.Naming.lookup(portOfUrl + "EzSalesBuz");
		if (procserv.equals("Y"))
		{
			ezRmi.stopScheduler(null);
		}
		else
		{
			ezRmi.processMessage(null,"200","");
		}

	}catch(Exception e){
		ezc.ezutil.EzSystem.out.println("Unable to stop the RMI Server Reference :: " + e);
	}
%>


<%
	int duration = 0;
	String lastAccessedTime = String.valueOf(session.getValue("MYLOGINMILLIS"));
	try
	{
		Long lt=new Long(lastAccessedTime);
		long myLoginTime = lt.longValue();
		long currMillis  = System.currentTimeMillis();
		Double d=new Double(String.valueOf((currMillis-myLoginTime)/60000));
		duration =  d.intValue();
	}
	catch(Exception e)
	{
		System.out.println(e);
	}
	
	out.println(duration);
%>	

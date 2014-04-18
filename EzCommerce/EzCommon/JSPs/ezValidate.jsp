<%

	String key=(String)session.getAttribute("key");
	String str=request.getParameter("queryString");
	ezc.ezcommon.EzLog4j.log("str::::::::::::::::::"+str,"I");
	if(str!=null)
	{
		if(key.compareTo(str)==0)
			out.println(true);
		else
			out.println(false);
	}

%>
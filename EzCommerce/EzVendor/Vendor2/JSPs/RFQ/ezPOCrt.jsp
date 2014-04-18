<%
	String[] str1 = request.getParameterValues("rfqDetails");
	String[] str2= request.getParameterValues("docType");
	String[] str3 = request.getParameterValues("ccKey");
	String[] str4 = request.getParameterValues("hbId");
	String[] str5 = request.getParameterValues("taxCode");
	String[] str6 = request.getParameterValues("headerText");
	for(int i=0;i<str1.length;i++)
	{
		out.println(str1[i]+"<Br>");
		//out.println(str2[i]+"<Br>");
		//out.println(str3[i]+"<Br>");
		//out.println(str4[i]+"<Br>");
	}
	
	for(int i=0;i<str2.length;i++)
	{
		out.println(str2[i]+"<Br>");
		//out.println(str3[i]+"<Br>");
		//out.println(str4[i]+"<Br>");
	}
	
%>
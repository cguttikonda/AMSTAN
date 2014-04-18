<%
	try
	{
		String fileName = "ezEmailTest.jsp";
		String filePath = request.getRealPath(fileName);
		filePath = filePath.substring(0,filePath.indexOf(fileName));
		filePath +="iEmailText.properties";

		Properties prop=new Properties();
		prop.load(new java.io.FileInputStream(filePath));

		String eMailSub_ToSAP = prop.getProperty("EMAILSUB_TOSAP");
		String eMailSub_ToREV = prop.getProperty("EMAILSUB_TOREV");
		String eMailBody_ToSAP = prop.getProperty("EMAILBODY_TOSAP");
		String eMailBody_ToREV = prop.getProperty("EMAILBODY_TOREV");

		eMailSub_ToSAP = eMailSub_ToSAP.replaceAll("%PONumber%","1234");
		eMailBody_ToSAP = eMailBody_ToSAP.replaceAll("%ConcernedUser%","ABC");
		eMailBody_ToSAP = eMailBody_ToSAP.replaceAll("%MainURL%","AAA");
		eMailBody_ToSAP = eMailBody_ToSAP.replaceAll("%OffLineURL%","BBB");

		out.println("eMailSub_ToSAP::"+eMailSub_ToSAP);
		out.println("eMailSub_ToREV::"+eMailSub_ToREV);
		out.println("eMailBody_ToSAP::"+eMailBody_ToSAP);
		out.println("eMailBody_ToREV::"+eMailBody_ToREV);
	}
	catch(Exception e){}
%>
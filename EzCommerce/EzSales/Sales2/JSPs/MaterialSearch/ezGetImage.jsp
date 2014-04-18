<%
	response.setContentType("image/jpeg");
	java.net.URL myurl = new java.net.URL((String)session.getValue("ImgURL"));
	try {
		myurl.openConnection();
	}catch(Exception e){     
		out.println(e.getMessage());
	}

	java.io.InputStream in= myurl.openStream();
	java.io.OutputStream jos=response.getOutputStream();
	byte[] buf = new byte[4096];
	int count = 0;
	while ((count = in.read(buf)) >= 0)
	{
		jos.write(buf, 0, count);
	} 
	in.close();
	jos.close();
	session.removeValue("ImgURL");
	
%>
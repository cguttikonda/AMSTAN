<%@ page import="java.net.*,java.io.*" %>
<%
	String myURL=request.getParameter("URL");
	String fname=request.getParameter("fname");
	
	java.util.StringTokenizer st =new java.util.StringTokenizer(myURL,"¥");
	String newUrl="";
	while(st.hasMoreTokens())
	{
		newUrl = newUrl.trim();
		newUrl+=(String)st.nextToken()+"&";


	}
	newUrl = newUrl.substring(0,newUrl.length()-1);
	newUrl=newUrl.replace('®','%');
	
	response.setContentType("application/pdf");
	response.setHeader ("Content-Disposition", "attachment;filename="+fname);
	
	URL myurl = new URL(newUrl);
	try {
		myurl.openConnection();
	}catch(Exception e){     
		System.out.println(e.getMessage());
	}
	try{
	InputStream in= myurl.openStream();
	OutputStream jos=response.getOutputStream();
	byte[] buf = new byte[4096];
	int count = 0;
	while ((count = in.read(buf)) >= 0)
	{
		jos.write(buf, 0, count);
	} 
	in.close();
	jos.close();
	}catch(Exception e){}
 
%>


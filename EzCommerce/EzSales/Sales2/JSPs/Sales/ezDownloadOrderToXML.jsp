<%@ page import="javax.xml.parsers.*,java.io.*,javax.xml.transform.*,javax.xml.transform.dom.*,javax.xml.transform.stream.*" %>
<%@ page import="org.w3c.dom.*,org.xml.sax.*" %>

<%
	String orderXML = request.getParameter("orderXML");
	String SalesOrder = request.getParameter("SO");
	if(SalesOrder==null) SalesOrder = "";
	
	String filePath=request.getRealPath("ezDownloadOrderToXML.jsp");
	filePath=filePath.substring(0,filePath.indexOf("ezDownloadOrderToXML.jsp"));
	filePath += "\\XML\\ezOrder_"+SalesOrder+".xml";
	
	
	orderXML=orderXML.replaceAll("&lt;","<");
	orderXML=orderXML.replaceAll("&gt;",">");
	orderXML=orderXML.replaceAll("&amp;","&");
	orderXML=orderXML.replaceAll("&apos;","'");
	orderXML=orderXML.replaceAll("&quo;","\"");
	
	DocumentBuilderFactory docFactory = javax.xml.parsers.DocumentBuilderFactory.newInstance();
	DocumentBuilder docBuilder = docFactory.newDocumentBuilder();
	
	Document document = docBuilder.parse(new InputSource(new StringReader(orderXML))); 
                    
	TransformerFactory factory = TransformerFactory.newInstance();
	Transformer transformer = factory.newTransformer();
	transformer.transform(new DOMSource(document),new StreamResult(new File(filePath)));
	
	
	File file = null;
	FileInputStream fileinputstream = null;
	
	try
	{
		file = new File(filePath);
		String fileName = file.getName();
		response.setContentType("application/xml");
		response.setHeader("Content-Disposition","attachment;filename="+fileName);
		fileinputstream = new FileInputStream(file);
		
		int i ;
		boolean flag = false;
		while((i = fileinputstream.read())!=-1)
			out.write(i);
	}
	catch(IOException ioexception)
	{
		out.println("Got exception  : " + ioexception);
	}
	finally
	{
		try{
			out.close();
			fileinputstream.close();
			//if(file.exists())
			 // file.delete();
		}catch(Exception clex){}
	}
%>


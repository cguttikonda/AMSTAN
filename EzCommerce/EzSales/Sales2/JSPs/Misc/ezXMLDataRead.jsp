<%@page import="org.xml.sax.*" %>
<%@page import="org.w3c.dom.*,javax.xml.parsers.*" %>
<%
	String xmlTagValue = "";
	try
	{
		DocumentBuilderFactory docFactory = javax.xml.parsers.DocumentBuilderFactory.newInstance();
		DocumentBuilder docBuilder = docFactory.newDocumentBuilder();
	
		String fileName = "ezBanner.jsp";
		String filePath=request.getRealPath(fileName);
		filePath=filePath.substring(0,filePath.indexOf(fileName));
		String filePath1 = filePath+"\\..\\..\\..\\..\\EzCommon\\XMLs\\ezData.xml";
		java.io.File fileObj = new java.io.File(filePath1);
		if(!fileObj.exists())
		{
			filePath1 = filePath+"\\EzCommerce\\EzCommon\\XMLs\\ezData.xml";
		}
		Element element=null;
		Node node=null;
		Document doc = docBuilder.parse("file:"+filePath1);
		Element root = doc.getDocumentElement();
		NodeList list = root.getElementsByTagName("EzSales");
		node=list.item(0);
		xmlTagValue = ((Element)node).getElementsByTagName(xmlTagName).item(0).getFirstChild().getNodeValue();
		if(xmlTagValue == null || "null".equals(xmlTagValue))
			xmlTagValue = "";
	}
	catch(Exception e){}
%>
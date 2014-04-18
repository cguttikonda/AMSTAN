<%@ page import="javax.xml.parsers.*,org.w3c.dom.*,ezc.ezparam.ReturnObjFromRetrieve" %>
<%@page import="java.util.*,java.io.*"%>
<%@page import="javax.xml.parsers.*" %>
<%@page import="org.w3c.dom.*" %>
<%@page import="org.xml.sax.*" %>
<%
	
	String xmlValue 	= "";
	ezc.ezparam.ReturnObjFromRetrieve ret = new ezc.ezparam.ReturnObjFromRetrieve(new String[]{"DOMAIN_NAME","VENDOR_SUPPORT","SALES_SUPPORT"});
	try
	{
		DocumentBuilderFactory docFactory = javax.xml.parsers.DocumentBuilderFactory.newInstance();
		DocumentBuilder docBuilder = docFactory.newDocumentBuilder();

		String fileName = "ezGetData.jsp";
		String filePath=request.getRealPath(fileName);
		filePath=filePath.substring(0,filePath.indexOf(fileName));
		String filePath1 = filePath+"\\..\\..\\..\\..\\..\\EzCommon\\XMLs\\ezData.xml";
		java.io.File fileObj = new java.io.File(filePath1);
		if(!fileObj.exists())
		{
			filePath1 = filePath+"\\EzCommerce\\EzCommon\\XMLs\\ezData.xml";
		}

		Node node=null;
		Document doc = docBuilder.parse("file:"+filePath1);
		Element root = doc.getDocumentElement();
		NodeList list;

		list = root.getElementsByTagName("EzVendor");
		node=list.item(0);
		xmlValue = ((Element)node).getElementsByTagName("support").item(0).getFirstChild().getNodeValue();
		if(xmlValue == null || "null".equals(xmlValue))
			xmlValue = "";
		ret.setFieldValue("VENDOR_SUPPORT",xmlValue);

		list = root.getElementsByTagName("EzSales");
		node=list.item(0);
		xmlValue = ((Element)node).getElementsByTagName("Support").item(0).getFirstChild().getNodeValue();
		if(xmlValue == null || "null".equals(xmlValue))
			xmlValue = "";
		ret.setFieldValue("SALES_SUPPORT",xmlValue);
		
		list = root.getElementsByTagName("Portal");
		node=list.item(0);
		xmlValue = ((Element)node).getElementsByTagName("domain").item(0).getFirstChild().getNodeValue();
		if(xmlValue == null || "null".equals(xmlValue))
			xmlValue = "";
		ret.setFieldValue("DOMAIN_NAME",xmlValue);
	
		ret.addRow();
	}
	catch(Exception e){}
%>
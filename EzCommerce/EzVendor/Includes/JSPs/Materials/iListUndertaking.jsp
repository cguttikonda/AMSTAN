<%@ include file="../../../Includes/JSPs/Misc/iJaxpPath.jsp" %>
<%@ page import="javax.xml.parsers.*,org.w3c.dom.*,javax.xml.transform.*,javax.xml.transform.dom.DOMSource,java.io.FileOutputStream,javax.xml.transform.stream.StreamResult" %>

<%

	ezc.ezparam.ReturnObjFromRetrieve ret=new ezc.ezparam.ReturnObjFromRetrieve(new String[]{"HEADER1","HEADER2","HEADER3"});

	try
	{
		DocumentBuilderFactory docFactory = javax.xml.parsers.DocumentBuilderFactory.newInstance();
		DocumentBuilder docBuilder = docFactory.newDocumentBuilder();

		String filePath="file:"+request.getRealPath("ezEditUndertaking.jsp");
		filePath=filePath.substring(0,filePath.indexOf("ezEditUndertaking.jsp"));
		//filePath += "\\EzCommerce\\EzVendor\\EzVendorDemo\\Vendor2\\JSPs\\Materials\\ezUndertaking.xml";

		filePath=filePath+relativePath+letterOfUndertaking;
		Document doc = docBuilder.parse(filePath);

		Element root = doc.getDocumentElement();
		NodeList list = root.getElementsByTagName("Letter");
		int n = list.getLength();


		Node node=null;
		Element element=null;
		NodeList resultList=null;
		String sbu="";
		String code="";

			element=(Element)list.item(0);

			node=(Node)element;
			resultList=node.getChildNodes();

			resultList=((Element)node).getElementsByTagName("header1");
			ret.setFieldValue("HEADER1",resultList.item(0).getFirstChild().getNodeValue());

			resultList=((Element)node).getElementsByTagName("header2");
			ret.setFieldValue("HEADER2",resultList.item(0).getFirstChild().getNodeValue());
			resultList=((Element)node).getElementsByTagName("header3");
			ret.setFieldValue("HEADER3",resultList.item(0).getFirstChild().getNodeValue());
			ret.addRow();



	}
	catch(Exception e)
	{
		out.println(e);

	}
%>

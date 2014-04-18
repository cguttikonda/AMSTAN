<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Misc/iJaxpPath.jsp" %>

<%@ page import="javax.xml.parsers.*,org.w3c.dom.*,javax.xml.transform.*,javax.xml.transform.dom.DOMSource,java.io.FileOutputStream,javax.xml.transform.stream.StreamResult" %>
<%

	String header1=(request.getParameter("header1").equals("")?"  ":request.getParameter("header1"));
	String header2=(request.getParameter("header2").equals("")?"  ":request.getParameter("header2"));
	String header3=(request.getParameter("header3").equals("")?"   ":request.getParameter("header3"));
	try
	{
		DocumentBuilderFactory docFactory = javax.xml.parsers.DocumentBuilderFactory.newInstance();
		DocumentBuilder docBuilder = docFactory.newDocumentBuilder();

		String filePath=request.getRealPath("ezEditUndertaking.jsp");
		filePath=filePath.substring(0,filePath.indexOf("ezEditUndertaking.jsp"));
		//filePath += "\\EzCommerce\\EzVendor\\EzVendorDemo\\Vendor2\\JSPs\\Materials\\ezUndertaking.xml";
		filePath=filePath+relativePath+letterOfUndertaking;
		Document doc = docBuilder.parse("file:"+filePath);
		Element root = doc.getDocumentElement();
		NodeList list = root.getElementsByTagName("Letter");
		int n = list.getLength();
		Element element=null;
		String xmlcode="";
		Node node=null;
		NodeList resultList=null;

			element=(Element)list.item(0);
			node=list.item(0);
				((Element)node).getElementsByTagName("header1").item(0).getFirstChild().setNodeValue(header1);
				((Element)node).getElementsByTagName("header2").item(0).getFirstChild().setNodeValue(header2);
				((Element)node).getElementsByTagName("header3").item(0).getFirstChild().setNodeValue(header3);
		TransformerFactory factory = TransformerFactory.newInstance();
		Transformer transformer = factory.newTransformer();

		transformer.transform(new DOMSource(root),new StreamResult(new FileOutputStream(filePath)));

	}
	catch(Exception e)
	{
		out.println(e);
	}


	response.sendRedirect("ezEditUndertaking.jsp");
%>
<Div id="MenuSol"></Div>

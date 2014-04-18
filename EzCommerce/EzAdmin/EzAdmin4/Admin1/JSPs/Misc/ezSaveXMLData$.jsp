<%@ page import="javax.xml.parsers.*,org.w3c.dom.*,javax.xml.transform.*,javax.xml.transform.dom.DOMSource,java.io.FileOutputStream,javax.xml.transform.stream.StreamResult" %>
<%
		
		String suppID="";
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

			Element element=null;
			Node node=null;		
			Document doc = docBuilder.parse("file:"+filePath1);
			Element root = doc.getDocumentElement();

			suppID = request.getParameter("domainName");
			if(suppID == null || "null".equals(suppID))
				suppID = "";
			NodeList list = root.getElementsByTagName("Portal");
			node=list.item(0);
			((Element)node).getElementsByTagName("domain").item(0).getFirstChild().setNodeValue(suppID);
			
			suppID = request.getParameter("supportSales");
			if(suppID == null || "null".equals(suppID))
				suppID = "";
			list = root.getElementsByTagName("EzSales");
			node=list.item(0);
			((Element)node).getElementsByTagName("Support").item(0).getFirstChild().setNodeValue(suppID);
			
			suppID = request.getParameter("supportVendor");
			if(suppID == null || "null".equals(suppID))
				suppID = "";
			list = root.getElementsByTagName("EzVendor");
			node=list.item(0);
			((Element)node).getElementsByTagName("support").item(0).getFirstChild().setNodeValue(suppID);
			TransformerFactory factory = TransformerFactory.newInstance();
			Transformer transformer = factory.newTransformer();
			transformer.transform(new DOMSource(root),new StreamResult(new FileOutputStream(filePath1)));
		}
		catch(Exception e){out.println(e);}
		response.sendRedirect("ezGetData.jsp");
%>

				
				
				
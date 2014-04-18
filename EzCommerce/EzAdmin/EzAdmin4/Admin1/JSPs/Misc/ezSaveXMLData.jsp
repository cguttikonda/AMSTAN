<%@ page import="javax.xml.parsers.*,org.w3c.dom.*,javax.xml.transform.*,javax.xml.transform.dom.DOMSource,java.io.FileOutputStream,javax.xml.transform.stream.StreamResult" %>
<%
		String suppID="";
		try
		{
			DocumentBuilderFactory docFactory = javax.xml.parsers.DocumentBuilderFactory.newInstance();
			DocumentBuilder docBuilder = docFactory.newDocumentBuilder();
		
			String fileName = "ezGetData.jsp";
			String filePath=request.getRealPath(fileName);
			filePath=filePath.substring(0,filePath.indexOf("EzAdmin\\EzAdmin4\\Admin1\\JSPs\\Misc\\ezSaveXMLData.jsp"));
			String filePath1 = filePath+"EzCommon\\XMLs\\ezData.xml";
			java.io.File fileObj = new java.io.File(filePath1);
			if(!fileObj.exists())
			{
				filePath1 = filePath+"\\EzCommerce\\EzCommon\\XMLs\\ezData.xml";
			}

			Element element=null;
			Node node=null;		
			Document doc = docBuilder.parse("file:"+filePath1);
			Element root = doc.getDocumentElement();

			String CompValue = request.getParameter("CompValue");
			//out.println("CompValue>>>>"+CompValue);
			if(suppID == null || "null".equals(suppID))
				suppID = "";
			String Components = request.getParameter("Components");
			//out.println("Components>>>>"+Components);
			if(Components == null || "null".equals(Components))
				Components = "";
			String subComponents = request.getParameter("subComponents");
			//out.println("subComponents>>>>"+subComponents);
			if(subComponents == null || "null".equals(subComponents))
				subComponents = "";
			NodeList list = root.getElementsByTagName(Components.trim());
			node=list.item(0);
			((Element)node).getElementsByTagName(subComponents.trim()).item(0).getFirstChild().setNodeValue(CompValue.trim());
			
			
			TransformerFactory factory = TransformerFactory.newInstance();
			Transformer transformer = factory.newTransformer();
			transformer.transform(new DOMSource(root),new StreamResult(new FileOutputStream(filePath1)));
			
		}
		catch(Exception e){System.out.println("Components>>>>"+e);}
		response.sendRedirect("ezGetData.jsp");
		
%>

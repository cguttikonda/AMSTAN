<%@ page import="javax.xml.parsers.*,org.w3c.dom.*,javax.xml.transform.*,javax.xml.transform.dom.DOMSource,java.io.FileOutputStream,javax.xml.transform.stream.StreamResult" %>
<%

	String name		=(request.getParameter("name").equals("")?"  ":request.getParameter("name"));
	String address1		=(request.getParameter("address1").equals("")?"  ":request.getParameter("address1"));
	String address2		=(request.getParameter("address2").equals("")?"   ":request.getParameter("address2"));
	String city		=(request.getParameter("city").equals("")?"  ":request.getParameter("city"));
	String state		=(request.getParameter("state").equals("")?"  ":request.getParameter("state"));
	String country		=(request.getParameter("country").equals("")?"  ":request.getParameter("country"));
	String cst		=(request.getParameter("cst").equals("")?"  ":request.getParameter("cst"));
	String phone		=(request.getParameter("phone").equals("")?"  ":request.getParameter("phone"));
	String code 		=request.getParameter("code");
	String sbu 		=(request.getParameter("sbu").equals("")?"  ":request.getParameter("sbu"));

	try
	{
		DocumentBuilderFactory docFactory = javax.xml.parsers.DocumentBuilderFactory.newInstance();
		DocumentBuilder docBuilder = docFactory.newDocumentBuilder();

		String fileName = "ezEditSaveSbuPlantAddress.jsp";
		
		String filePath=request.getRealPath(fileName);
		filePath=filePath.substring(0,filePath.indexOf(fileName));
		filePath += "\\ezSbuPlantAddress.xml";
		
		Document doc = docBuilder.parse("file:"+filePath);

		Element root = doc.getDocumentElement();
		NodeList list = root.getElementsByTagName("EzPlant");
		int n = list.getLength();
		Element element=null;
		String xmlcode="";
		Node node=null;
		NodeList resultList=null;

		for(int i=0;i<n;i++)
		{
			element=(Element)list.item(i);
			xmlcode= element.getAttribute("code");

			node=list.item(i);

			if(xmlcode.equals(code))
			{
				out.println("********"+sbu);
				 element.setAttribute("sbu",sbu);
				((Element)node).getElementsByTagName("Name").item(0).getFirstChild().setNodeValue(name);
				((Element)node).getElementsByTagName("Address1").item(0).getFirstChild().setNodeValue(address1);
				((Element)node).getElementsByTagName("Address2").item(0).getFirstChild().setNodeValue(address2);

				((Element)node).getElementsByTagName("City").item(0).getFirstChild().setNodeValue(city);
				((Element)node).getElementsByTagName("State").item(0).getFirstChild().setNodeValue(state);
				((Element)node).getElementsByTagName("Country").item(0).getFirstChild().setNodeValue(country);

				//((Element)node).getElementsByTagName("Centralexice-code").item(0).getFirstChild().setNodeValue(centralexice);
				((Element)node).getElementsByTagName("CST").item(0).getFirstChild().setNodeValue(cst);
				((Element)node).getElementsByTagName("Phone").item(0).getFirstChild().setNodeValue(phone);



				break;
			}
		}
		TransformerFactory factory = TransformerFactory.newInstance();
		Transformer transformer = factory.newTransformer();

		transformer.transform(new DOMSource(root),new StreamResult(new FileOutputStream(filePath)));

	}
	catch(Exception e)
	{
		out.println(e);
	}

	String index=request.getParameter("index");
	response.sendRedirect("ezListSbuPlantAddresses.jsp?code="+code+"&index="+index);
%>
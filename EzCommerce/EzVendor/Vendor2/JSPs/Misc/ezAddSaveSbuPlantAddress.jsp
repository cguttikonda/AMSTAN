<%@ page import="javax.xml.parsers.*,org.w3c.dom.*,javax.xml.transform.*,javax.xml.transform.dom.DOMSource,java.io.FileOutputStream,javax.xml.transform.stream.StreamResult" %>
<%

	//String index=request.getParameter("count");
	String name		=(request.getParameter("name").equals("")?"  ":request.getParameter("name"));
	String address1		=(request.getParameter("address1").equals("")?"  ":request.getParameter("address1"));
	String address2		=(request.getParameter("address2").equals("")?"  ":request.getParameter("address2"));
	String city		=(request.getParameter("city").equals("")?"  ":request.getParameter("city"));
	String state		=(request.getParameter("state").equals("")?"  ":request.getParameter("state"));
	String country		=(request.getParameter("country").equals("")?"  ":request.getParameter("country"));
	//String centralexice	=(request.getParameter("centralexice").equals("")?" ":request.getParameter("centralexice"));
	String cst		=(request.getParameter("cst").equals("")?" ":request.getParameter("cst"));
	String phone		=(request.getParameter("phone").equals("")?" ":request.getParameter("phone"));
	String  sbu 		=(request.getParameter("sbu").equals("")?"  ":request.getParameter("sbu"));
	String code		= request.getParameter("plantCode");


	//out.println(name+":"+address1+":"+address2+":"+city+":"+state+":"+country+":"+centralexice+":"+cst+":"+phone+":"+sbu+":"+code);
	//out.println(name+":"+address1+":"+address2+":"+city+":"+state+":"+country+":"+cst+":"+phone+":"+sbu+":"+code);

	try
	{
		DocumentBuilderFactory docFactory = javax.xml.parsers.DocumentBuilderFactory.newInstance();
		DocumentBuilder docBuilder = docFactory.newDocumentBuilder();

		String fileName = "ezAddSaveSbuPlantAddress.jsp";
		String filePath=request.getRealPath(fileName);
		filePath=filePath.substring(0,filePath.indexOf(fileName));
		filePath += "\\ezSbuPlantAddress.xml";

		Document doc = docBuilder.parse("file:"+filePath);

		Element root = doc.getDocumentElement();
		Element element=null;
		element=doc.createElement("EzPlant");
		element.setAttribute("code",code);
		element.setAttribute("sbu",sbu);

		Node nodeelement=(Node)element;

		Node nodename=null;
		Node nodevalue=null;

		nodename=(Node)doc.createElement("Name");
		nodevalue=doc.createTextNode(name);
		nodename.appendChild(nodevalue);
		nodeelement.appendChild(nodename);

		nodename=(Node)doc.createElement("Address1");
		nodevalue=doc.createTextNode(address1);
		nodename.appendChild(nodevalue);
		nodeelement.appendChild(nodename);

		nodename=(Node)doc.createElement("Address2");
		nodevalue=doc.createTextNode(address2);
		nodename.appendChild(nodevalue);
		nodeelement.appendChild(nodename);

		nodename=(Node)doc.createElement("City");
		nodevalue=doc.createTextNode(city);
		nodename.appendChild(nodevalue);
		nodeelement.appendChild(nodename);

		nodename=(Node)doc.createElement("State");
		nodevalue=doc.createTextNode(state);
		nodename.appendChild(nodevalue);
		nodeelement.appendChild(nodename);

		nodename=(Node)doc.createElement("Country");
		nodevalue=doc.createTextNode(country);
		nodename.appendChild(nodevalue);
		nodeelement.appendChild(nodename);


		nodename=(Node)doc.createElement("CST");
		nodevalue=doc.createTextNode(cst);
		nodename.appendChild(nodevalue);
		nodeelement.appendChild(nodename);

		nodename=(Node)doc.createElement("Phone");
		nodevalue=doc.createTextNode(phone);
		nodename.appendChild(nodevalue);
		nodeelement.appendChild(nodename);

		Node rootelement=(Node)root;
		root.appendChild(nodeelement);

		TransformerFactory factory = TransformerFactory.newInstance();
		Transformer transformer = factory.newTransformer();

		transformer.transform(new DOMSource(root),new StreamResult(new FileOutputStream(filePath)));

	}
	catch(Exception e)
	{
		out.println(e);
	}

	response.sendRedirect("ezListSbuPlantAddresses.jsp");
%>
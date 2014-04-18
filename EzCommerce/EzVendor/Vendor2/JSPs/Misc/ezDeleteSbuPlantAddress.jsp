<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Misc/iJaxpPath.jsp" %>

<%@ page import="javax.xml.parsers.*,org.w3c.dom.*,javax.xml.transform.*,javax.xml.transform.dom.DOMSource,java.io.FileOutputStream,javax.xml.transform.stream.StreamResult" %>
<%
	String index=request.getParameter("index");
	String  code = request.getParameter("code"+index);


	try
	{
		DocumentBuilderFactory docFactory = javax.xml.parsers.DocumentBuilderFactory.newInstance();
		DocumentBuilder docBuilder = docFactory.newDocumentBuilder();

		String fileName = "ezDeleteSbuPlantAddress.jsp";
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
				Node nodeelement=(Node)root;
				nodeelement.removeChild(node);
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

	response.sendRedirect("ezListSbuPlantAddresses.jsp");
%>
<Div id="MenuSol"></Div>

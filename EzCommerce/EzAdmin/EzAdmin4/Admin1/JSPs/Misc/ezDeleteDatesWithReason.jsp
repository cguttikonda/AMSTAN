<%@ page import="javax.xml.parsers.*,org.w3c.dom.*,javax.xml.transform.*,javax.xml.transform.dom.DOMSource,java.io.FileOutputStream,javax.xml.transform.stream.StreamResult"%>
<%
	
	String fileName = "EzHolidayXML.xml";
		
	java.io.File file=new java.io.File(fileName); 
	String day   = request.getParameter("day");
	String month = request.getParameter("month");
	String year  = request.getParameter("year");
	String id    = day+month+year;

	String[] code=request.getParameterValues("chk1");
	
	for(int j=0;j<code.length;j++)
	{
		try
		{
			DocumentBuilderFactory docFactory = javax.xml.parsers.DocumentBuilderFactory.newInstance();
			DocumentBuilder docBuilder = docFactory.newDocumentBuilder();
			Document doc = docBuilder.parse(file);
			Element root = doc.getDocumentElement();
			NodeList list = root.getElementsByTagName("DayOff");
			int n = list.getLength();
			Element element=null;
			String xmlcode="";
			Node node=null;
			NodeList resultList=null;
			for(int i=0;i<n;i++)
			{
				element=(Element)list.item(i);
				xmlcode= element.getAttribute("id");
				node=list.item(i);
				if(xmlcode.equals(code[j]))
				{
					Node nodeelement=(Node)root;
					nodeelement.removeChild(node);
					break;
				}
			}
			TransformerFactory factory = TransformerFactory.newInstance();
			Transformer transformer = factory.newTransformer();
			transformer.transform(new DOMSource(root),new StreamResult(new FileOutputStream(fileName)));

		}
		catch(Exception e)
		{
			System.out.println(e);
		}
	}
	response.sendRedirect("ezHolidayCalListWithReason.jsp");
%>

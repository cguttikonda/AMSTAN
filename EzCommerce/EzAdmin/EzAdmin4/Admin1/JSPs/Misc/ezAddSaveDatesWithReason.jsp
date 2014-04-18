<%@ page import="javax.xml.parsers.*,org.w3c.dom.*,javax.xml.transform.*,javax.xml.transform.dom.DOMSource,java.io.FileOutputStream,javax.xml.transform.stream.StreamResult"%>
<%
	String fileName = "EzHolidayXML.xml";
	
	java.io.File file=new java.io.File(fileName); 
	
	String date  = request.getParameter("hldDate");
	String reason  = request.getParameter("reason");
	
	
	
	String dat   = date.substring(3,5);
	int date1 = Integer.parseInt(dat);
	
	
	String mon = date.substring(0,2);
	int month = Integer.parseInt(mon);
	
	String year  = date.substring(6,date.length());
	String id    = (new java.util.Date()).getTime()+"";
	
	try
	{
		DocumentBuilderFactory docBuildFactory = javax.xml.parsers.DocumentBuilderFactory.newInstance();
		DocumentBuilder docBuilder = docBuildFactory.newDocumentBuilder();
		Document doc=docBuilder.parse(file);
		Element mainElement=doc.getDocumentElement();
					
		Element element=null;
		Node node=null;
		element=doc.createElement("DayOff");	
				
		element.setAttribute("id",id);
		element.setAttribute("date",date1+"");
		element.setAttribute("month",month+"");
		element.setAttribute("year",year);
		element.setAttribute("reason",reason);
		
		
		Node nodeelement=(Node)element;
		mainElement.appendChild(nodeelement);
	
		TransformerFactory factory = TransformerFactory.newInstance();
		Transformer transformer = factory.newTransformer();
		transformer.transform(new DOMSource(doc),new StreamResult(new FileOutputStream(fileName)));
		
		

	}
	catch(Exception e)
	{
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>"+e);
	}
	response.sendRedirect("ezHolidayCalListWithReason.jsp");
%>
<%@ page import="javax.xml.parsers.*,org.w3c.dom.*,javax.xml.transform.*,javax.xml.transform.dom.DOMSource,java.io.FileOutputStream,javax.xml.transform.stream.StreamResult"%>
<%
	String fileName = "EzHolidayXML.xml";
	
		
	java.io.File file=new java.io.File(fileName); 
	ezc.ezparam.ReturnObjFromRetrieve listRet = new ezc.ezparam.ReturnObjFromRetrieve(new String[]{"DAY","MONTH","YEAR","ID","REASON"});
	try
	{
		DocumentBuilderFactory docBuildFactory = javax.xml.parsers.DocumentBuilderFactory.newInstance();
		DocumentBuilder docBuilder = docBuildFactory.newDocumentBuilder();
		Document doc=docBuilder.parse(file);
		Element rootElement=doc.getDocumentElement();		
		NodeList nodeList=rootElement.getElementsByTagName("DayOff");		
		int nodeLength=nodeList.getLength();		
		Element element=null;
		String day="";
		String month="";
		String year="";
		String id="";
		String reason="";
		
		for(int i=0;i<nodeLength;i++)
		{
			element=(Element)nodeList.item(i);
			day	= 	element.getAttribute("date");
			month	=	element.getAttribute("month");
			year	= 	element.getAttribute("year");
			reason	= 	element.getAttribute("reason");
			id	=	element.getAttribute("id");
			listRet.setFieldValue("DAY",day);
			listRet.setFieldValue("MONTH",month);
			listRet.setFieldValue("YEAR",year);
			listRet.setFieldValue("ID",id);
			listRet.setFieldValue("REASON",reason);
			listRet.addRow();
		}
	}
	catch(Exception e)
	{
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>"+e);
	}

%>


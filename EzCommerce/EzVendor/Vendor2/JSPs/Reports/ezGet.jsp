<%@ page import="javax.xml.bind.*,java.io.*,ezc.ezadmin.reports.*,ezc.ezadmin.reports.impl.*,ezc.ezadmin.reports.impl.runtime.*" %>
<%@ page import="com.sun.msv.datatype.xsd.*,primer.po.*" %>
<%
	/*java.util.Properties props= System.getProperties();
	out.println(props.get("java.ext.dirs"));*/
%>
<%
//JAXBContext jc = JAXBContext.newInstance("ezc.ezadmin.reports");
JAXBContext jc = JAXBContext.newInstance("primer.po");

Unmarshaller u =jc.createUnmarshaller();

//ReportType rep = (ReportType)
try{
//u.unmarshal(new FileInputStream("Reports.xml"));

Items itms =(Items)u.unmarshal(new FileInputStream("itemList.xml"));
 InfoType infoType =itms.getItemInfo();
java.util.List item = infoType.getItem();
%>

<Table align="center">
<Tr>
	<Th>Name</Th>
	<Th>Price</Th>
</Tr>
<%

for( Iterator iter = item.iterator(); iter.hasNext(); ) 
{
           InfoType.ItemType item1 = (InfoType.ItemType)iter.next(); 
%>

		<Tr>
			<Td><%=item1.getName()%></Td>	
			<Td><%=item1.getPrice()%></Td>	
		</Tr>

<%
}


}catch(Exception e)
{
out.println(e);
}



/*
Marshaller m = jc.createMarshaller();
m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT,Boolean.TRUE);
m.marshal(rep,out);
*/

%>








<%--

<%@ page import="javax.xml.parsers.*,org.w3c.dom.*" %>

		DocumentBuilderFactory docFactory = javax.xml.parsers.DocumentBuilderFactory.newInstance();
		DocumentBuilder docBuilder = docFactory.newDocumentBuilder();

		String filePath="file:"+request.getRealPath("ezGet.jsp");
		filePath=filePath.substring(0,filePath.indexOf("ezGet.jsp"));
		filePath += "\\EzCommerce\\EzAdmin\\EzAdmin4\\Admin1\\JSPs\\Reports\\ReportsXML.xml";
		Document doc = docBuilder.parse(filePath);

		Element root = doc.getDocumentElement();
		NodeList list = root.getElementsByTagName("Report");
	out.println("--"+list.getLength());
		for(int i=0;i<list.getLength();i++)
		{
			Element element=(Element)list.item(i);
			String code=element.getAttribute("orderid");

			Node node=(Node)element;
			NodeList resultList=node.getChildNodes();


			if(code.equals("10"))
			{

				resultList=((Element)node).getElementsByTagName("Name");
				out.println( resultList.item(0).getFirstChild().getNodeValue());
			}
		}

-----------------------------------------------------------------------------------------------


		SAXParserFactory saxFactory = javax.xml.parsers.SAXParserFactory.newInstance();
		saxFactory.setValidating(true);
		SaxParser Sparser = saxFactory.newSAXParser()

				String filePath="file:"+request.getRealPath("ezListSbuPlantAddresses.jsp");
				filePath=filePath.substring(0,filePath.indexOf("ezListSbuPlantAddresses.jsp"));
				filePath += "\\EzCommerce\\EzAdmin\\EzAdmin4\\Admin1\\JSPs\\Reports\\ReportsXML.xml";
		Parser parser =Sparser.getParser();
		parser.parse(filePath);
		XMLReader reader = Sparser.getXMLReader();
		reader.setContentHandler(this);

--%>



























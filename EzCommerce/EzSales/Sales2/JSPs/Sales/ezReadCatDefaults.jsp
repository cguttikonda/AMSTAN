<%@ page import="javax.xml.parsers.*,org.w3c.dom.*,javax.xml.transform.*,javax.xml.transform.dom.DOMSource,java.io.FileOutputStream,javax.xml.transform.stream.StreamResult" %>

<%
/*************************** Read Catalog Defaults start *************************************/


	java.util.Hashtable catDefaultsHt=new java.util.Hashtable();
	catDefaultsHt.put("ECONOMY","OR-517¤");
	catDefaultsHt.put("LUXURY","TA-517¤");
	/*try
	{

		DocumentBuilderFactory docFactory = javax.xml.parsers.DocumentBuilderFactory.newInstance();
		DocumentBuilder docBuilder = docFactory.newDocumentBuilder();

		String filePath=request.getRealPath("ezAddOrderPlant.jsp");
		filePath=filePath.substring(0,filePath.indexOf("EzCommerce"));
		filePath += "\\EzCommerce\\EzCommon\\XMLs\\ezOrderPlantDefaults.xml";

		Document doc = docBuilder.parse("file:"+filePath);

		Element root = doc.getDocumentElement();
		NodeList list = root.getElementsByTagName("Category");
		NodeList nodeList1= doc.getElementsByTagName("Default0");
		NodeList nodeList2= doc.getElementsByTagName("Default1");
		NodeList nodeList3= doc.getElementsByTagName("Default2");
		NodeList nodeList4= doc.getElementsByTagName("Default3");
		NodeList nodeList5= doc.getElementsByTagName("Default4");

		int n = list.getLength();
		Element element=null;

		String xmlcatid="";
		String xmlDefault0="";
		String xmlDefault1="";
		String xmlDefault2="";
		String xmlDefault3="";
		String xmlDefault4="";

		Node node=null;
		Node node1= null;
		Node node2= null;
		Node node3= null;
		Node node4= null;
		Node node5= null;


		for(int i=0;i<n;i++)
		{


			element=(Element)list.item(i);
			xmlcatid= element.getAttribute("id");
			
			node1=nodeList1.item(i).getFirstChild();
			node2=nodeList2.item(i).getFirstChild();
			node3=nodeList3.item(i).getFirstChild();
			node4=nodeList4.item(i).getFirstChild();
			node5=nodeList5.item(i).getFirstChild();

			xmlDefault0=(String)node1.getNodeValue();
			xmlDefault1=(String)node2.getNodeValue();
			xmlDefault2=(String)node3.getNodeValue();
			xmlDefault3=(String)node4.getNodeValue();
			xmlDefault4=(String)node5.getNodeValue();


			if(xmlDefault0==null || "null".equalsIgnoreCase(xmlDefault0) || "N/A-N/A".equalsIgnoreCase(xmlDefault0.trim())) xmlDefault0 = "";
			if(xmlDefault1==null || "null".equalsIgnoreCase(xmlDefault1) || "N/A-N/A".equalsIgnoreCase(xmlDefault1.trim())) xmlDefault1 = "";	
			if(xmlDefault2==null || "null".equalsIgnoreCase(xmlDefault2) || "N/A-N/A".equalsIgnoreCase(xmlDefault2.trim())) xmlDefault2 = "";	
			if(xmlDefault3==null || "null".equalsIgnoreCase(xmlDefault3) || "N/A-N/A".equalsIgnoreCase(xmlDefault3.trim())) xmlDefault3 = "";
			if(xmlDefault4==null || "null".equalsIgnoreCase(xmlDefault4) || "N/A-N/A".equalsIgnoreCase(xmlDefault4.trim())) xmlDefault4 = "";	
			
			String defaultsStr = xmlDefault0+"¤"+xmlDefault1+"¤"+xmlDefault2+"¤"+xmlDefault3+"¤"+xmlDefault4;


			catDefaultsHt.put(xmlcatid,defaultsStr);			

		}


			TransformerFactory factory = TransformerFactory.newInstance();
			Transformer transformer = factory.newTransformer();
			transformer.transform(new DOMSource(root),new StreamResult(new FileOutputStream(filePath)));
	}		
	catch(Exception e)
	{
		System.out.println(e);
	}*/


	/*************************** Read Catalog Defaults End *************************************/
%>
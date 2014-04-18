<%@ page import="javax.xml.parsers.*,org.w3c.dom.*,javax.xml.transform.*,javax.xml.transform.dom.DOMSource,java.io.FileOutputStream,javax.xml.transform.stream.StreamResult,java.util.*;" %>
<%

		//Vector v=new Vector();
		String Catnum=request.getParameter("Cat");

		String []order =request.getParameterValues("Order");
		String []plant =request.getParameterValues("Plant");
		
		
		int length=order.length;
		
		for(int i=0;i<length;i++)
		{

		 if("".equals(order[i])&&"".equals(plant[i]))
		  {
		   order[i]="N/A";
		   plant[i]="N/A";
		  }
		}
		
		String OrdPlant1=order[0]+"-"+plant[0];
		String OrdPlant2=order[1]+"-"+plant[1];
		String OrdPlant3=order[2]+"-"+plant[2];
		String OrdPlant4=order[3]+"-"+plant[3];
		String OrdPlant5=order[4]+"-"+plant[4];
		
		
		
		
		
		out.println(Catnum+":::");
	if(Catnum!=null&&Catnum!="sel")
		{
	
	try
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
		
		
		boolean userexists = false;

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
			xmlDefault4=(String)node4.getNodeValue();
		
  			
			
			
			if(xmlcatid.equals(Catnum))
			{		
				userexists = true;
				
				
				if(!"".equals(xmlDefault0) || !"N/A-N/A".equals(xmlDefault0))
				node1.setNodeValue(OrdPlant1);
				if(!"".equals(xmlDefault1) || !"N/A-N/A".equals(xmlDefault1))
				node2.setNodeValue(OrdPlant2);	
				if(!"".equals(xmlDefault2) || !"N/A-N/A".equals(xmlDefault2))
				node3.setNodeValue(OrdPlant3);
				if(!"".equals(xmlDefault3) || !"N/A-N/A".equals(xmlDefault3))
				node4.setNodeValue(OrdPlant4);
				if(!"".equals(xmlDefault4) || !"N/A-N/A".equals(xmlDefault4))
				node5.setNodeValue(OrdPlant5);
				break;	

			}
		}	
		
	
		if(!userexists)
		{
			element=doc.createElement("Category");
			element.setAttribute("id",Catnum);
			node=(Node)element;
			
			Element wbsele1=doc.createElement("Default0");
			Node wbsnode1=(Node)wbsele1;
			Element wbsele2=doc.createElement("Default1");
			Node wbsnode2=(Node)wbsele2;
			Element wbsele3=doc.createElement("Default2");
			Node wbsnode3=(Node)wbsele3;
			Element wbsele4=doc.createElement("Default3");
			Node wbsnode4=(Node)wbsele4;
			Element wbsele5=doc.createElement("Default4");
			Node wbsnode5=(Node)wbsele5;

			
			Node eletext1=doc.createTextNode(OrdPlant1);
			Node eletext2=doc.createTextNode(OrdPlant2);
			Node eletext3=doc.createTextNode(OrdPlant3);
			Node eletext4=doc.createTextNode(OrdPlant4);
			Node eletext5=doc.createTextNode(OrdPlant5);
						
			wbsnode1.appendChild(eletext1);
			wbsnode2.appendChild(eletext2);
			wbsnode3.appendChild(eletext3);
			wbsnode4.appendChild(eletext4);
			wbsnode5.appendChild(eletext5);
			
			node.appendChild(wbsnode1);
			node.appendChild(wbsnode2);
			node.appendChild(wbsnode3);
			node.appendChild(wbsnode4);
			node.appendChild(wbsnode5);
			
												
			root.appendChild(node);
												
			
			
			
		}
		
		
				

		
		TransformerFactory factory = TransformerFactory.newInstance();
		Transformer transformer = factory.newTransformer();
		transformer.transform(new DOMSource(root),new StreamResult(new FileOutputStream(filePath)));
	}	
	catch(Exception e)
	{
		System.out.println(e);
	}
	response.sendRedirect("ezCategoryList.jsp?Cat="+Catnum+"&myIndex="+Catnum);
	}	
%>

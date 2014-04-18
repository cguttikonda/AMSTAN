<%@ page import="javax.xml.parsers.*,
		 org.w3c.dom.*,
		 javax.xml.transform.*,
		 javax.xml.transform.dom.DOMSource,
		 java.io.FileOutputStream,
		 javax.xml.transform.stream.StreamResult"
%>
<html>
<body>
<form name="myForm" method="post">
<%
	
	String fileName  = "default-web-app/EzCommerce/EzVendor/EzSubros/Vendor2/JSPs/Misc/ezVendorMenu.xml";
	java.io.File file= new java.io.File(fileName); 
	Element root 	 = null;
	int noOfChilds 	 = 0;
	Element element1 = null;
	try
	{
		DocumentBuilderFactory docFactory = javax.xml.parsers.DocumentBuilderFactory.newInstance();
		DocumentBuilder docBuilder 	  = docFactory.newDocumentBuilder();
		Document doc = docBuilder.parse(file);
		root = doc.getDocumentElement();
	
		String ele	 = null;
		String str1	 = request.getParameter("updtvls");
		
		java.util.StringTokenizer st = null;
		NodeList list1	 = null;
		String eleAttr	 = null;
		String child1    = null;
		String parent1   = null;
		String mainChild = null;
		st	= new java.util.StringTokenizer(str1,"*");
		while(st.hasMoreElements())
		{		
			ele	= st.nextToken();
			java.util.StringTokenizer st1 = new java.util.StringTokenizer(ele,"#");
			child1   = st1.nextToken();
			parent1  = st1.nextToken();

			java.util.StringTokenizer st2 = new java.util.StringTokenizer(parent1,"$");
			if(st2!=null)
				parent1 = st2.nextToken();

			child1	= child1.trim();
			parent1	= parent1.trim();

			list1		= root.getElementsByTagName(parent1);
			noOfChilds 	= list1.getLength();

			for(int i=0;i<noOfChilds;i++)
			{
				element1 = (Element)list1.item(i);
				eleAttr	 = element1.getAttribute("id");	
				eleAttr	 = eleAttr.trim();

				if(eleAttr==child1 || eleAttr.equals(child1)) 
				{
					element1.setAttribute("status","N");
					break;
				}
			}
		}
		TransformerFactory factory	= TransformerFactory.newInstance();
		Transformer transformer		= factory.newTransformer();
		transformer.transform(new DOMSource(root),new StreamResult(new FileOutputStream(fileName)));
	}	
	catch(Exception e)
	{
		out.println(e);
	}

	Element root1 	 = null;
	int noOfChilds1  = 0;
	Element element2 = null;
	NodeList list2	 = null;
	String eleAttr1  = null;
	
	try
	{
		DocumentBuilderFactory docFactory1 = javax.xml.parsers.DocumentBuilderFactory.newInstance();
		DocumentBuilder docBuilder1 	   = docFactory1.newDocumentBuilder();
		Document doc1 = docBuilder1.parse(file);
		root1 = doc1.getDocumentElement();
	
		String ele1	 = null;
		String[] rdoArr	 = request.getParameterValues("rdo");
		String parent2   = null;
		String child2    = null;
		
		for(int r=0;r<rdoArr.length;r++)
		{
		
			ele1	= rdoArr[r];
			java.util.StringTokenizer st3 = new java.util.StringTokenizer(ele1,"#");
			child2   = st3.nextToken();
			parent2  = st3.nextToken();

			java.util.StringTokenizer st4 = new java.util.StringTokenizer(parent2,"$");
			if(st4!=null)
				parent2 = st4.nextToken();

			child2	= child2.trim();
			parent2	= parent2.trim();

			list2		= root.getElementsByTagName(parent2);
			noOfChilds1 	= list2.getLength();

			for(int i=0;i<noOfChilds1;i++)
			{
				element2 = (Element)list2.item(i);
				eleAttr1 = element2.getAttribute("id");	
				eleAttr1 = eleAttr1.trim();

				if(eleAttr1==child2 || eleAttr1.equals(child2)) 
				{
					element2.setAttribute("status","Y");
					break;
				}
			}
		}	
		TransformerFactory factory1	= TransformerFactory.newInstance();
		Transformer transformer1	= factory1.newTransformer();
		transformer1.transform(new DOMSource(root),new StreamResult(new FileOutputStream(fileName)));
		
	}	
	catch(Exception e)
	{
		out.println(e);
	}	
	String flagVal = "true";
	response.sendRedirect("ezChangeOptionsMain.jsp?flag="+flagVal);
%>
</form>
</body>
</html>
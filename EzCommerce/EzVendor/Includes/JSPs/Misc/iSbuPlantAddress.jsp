<%@ page import="javax.xml.parsers.*,org.w3c.dom.*,ezc.ezparam.ReturnObjFromRetrieve" %>
<%@page import="java.util.*,java.io.*"%>
<%@page import="javax.xml.parsers.*" %>
<%@page import="org.w3c.dom.*" %>
<% //@page import="org.apache.xml.serialize.*" %>
<%@page import="org.xml.sax.*" %>
<% //@page import="org.apache.xerces.parsers.*" %>


<%
	String redirectcode	=request.getParameter("code");
	String redirectindex	=request.getParameter("index");
	int count =0;
	
	ezc.ezparam.ReturnObjFromRetrieve ret=new ezc.ezparam.ReturnObjFromRetrieve(new String[]{"CODE","SBU","NAME","ADDRESS1","ADDRESS2","CITY","STATE","COUNTRY","CST","PHONE"});
	
	try
	{
	
		DocumentBuilderFactory docFactory 	= javax.xml.parsers.DocumentBuilderFactory.newInstance();
		DocumentBuilder docBuilder 		= docFactory.newDocumentBuilder();
		
		String filePath=request.getRealPath(fileName);
		filePath=filePath.substring(0,filePath.indexOf(fileName));
		filePath += "\\ezSbuPlantAddress.xml";
		
		File fileObj = new File(filePath);
		Document doc = docBuilder.parse(fileObj);
		Element root = doc.getDocumentElement();
		NodeList list = root.getElementsByTagName("EzPlant");
		int n = list.getLength();
		

		Node node=null;
		Element element=null;
		NodeList resultList=null;
		String sbu="";
		String code="";

		for(int i=0;i<n;i++)
		{
			element=(Element)list.item(i);
			sbu= element.getAttribute("sbu");
			code=element.getAttribute("code");

			node=(Node)element;
			resultList=node.getChildNodes();

			ret.setFieldValue("CODE",code);
			ret.setFieldValue("SBU",sbu);
			resultList=((Element)node).getElementsByTagName("Name");
			ret.setFieldValue("NAME",resultList.item(0).getFirstChild().getNodeValue());

			resultList=((Element)node).getElementsByTagName("Address1");
			ret.setFieldValue("ADDRESS1",resultList.item(0).getFirstChild().getNodeValue());

			resultList=((Element)node).getElementsByTagName("Address2");
			ret.setFieldValue("ADDRESS2",resultList.item(0).getFirstChild().getNodeValue());


			resultList=((Element)node).getElementsByTagName("City");
			ret.setFieldValue("CITY",resultList.item(0).getFirstChild().getNodeValue());


			resultList=((Element)node).getElementsByTagName("State");
			ret.setFieldValue("STATE",resultList.item(0).getFirstChild().getNodeValue());
			resultList=((Element)node).getElementsByTagName("Country");
			ret.setFieldValue("COUNTRY",resultList.item(0).getFirstChild().getNodeValue());

			resultList=((Element)node).getElementsByTagName("CST");
			ret.setFieldValue("CST",resultList.item(0).getFirstChild().getNodeValue());
			
			
			

			resultList=((Element)node).getElementsByTagName("Phone");
			ret.setFieldValue("PHONE",resultList.item(0).getFirstChild().getNodeValue());
			ret.addRow();
		}
	}
	catch(Exception e)
	{
		out.println(e);
		try{
		e.printStackTrace(new PrintStream(new FileOutputStream("CLICK.log")));
		}catch(Exception ex){}
	}
	
	String columns[]=new String[]{"CODE"};
	ret.sort(columns,true);
	if(ret!=null)
		count= ret.getRowCount();
%>


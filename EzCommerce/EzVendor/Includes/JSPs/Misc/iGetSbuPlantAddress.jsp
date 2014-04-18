<%@ include file="iJaxpPath.jsp" %>
<%
	String token=request.getParameter("plant");
	ezc.ezparam.ReturnObjFromRetrieve ret=new ezc.ezparam.ReturnObjFromRetrieve(new String[]{"CODE","SBU","NAME","ADDRESS1","ADDRESS2","CITY","STATE","COUNTRY","CST","CENTRALEXICE-CODE","PHONE"});
	try
	{
		String filePath=request.getRealPath(fileName);
		filePath=filePath.substring(0,filePath.indexOf(fileName));
		if(filePath.endsWith("Purorder\\"))
			filePath = replaceStr(filePath,"Purorder","Misc");
		filePath += "ezSbuPlantAddress.xml";
		//out.println("filePath"+filePath);
		java.io.File fileObj = new java.io.File(filePath);

		DocumentBuilderFactory docFactory = javax.xml.parsers.DocumentBuilderFactory.newInstance();
		DocumentBuilder docBuilder = docFactory.newDocumentBuilder();
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
			if(code.equals(token))
			{
				ret.setFieldValue("CODE",code);
				ret.setFieldValue("SBU",sbu);

				resultList=((Element)node).getElementsByTagName("Name");
				if(resultList.item(0).getFirstChild().getNodeValue()!=null)
				ret.setFieldValue("NAME",resultList.item(0).getFirstChild().getNodeValue());
				else
				ret.setFieldValue("NAME","");	

				resultList=((Element)node).getElementsByTagName("Address1");
				if(resultList.item(0).getFirstChild().getNodeValue()!=null)
				ret.setFieldValue("ADDRESS1",resultList.item(0).getFirstChild().getNodeValue());
				else
				ret.setFieldValue("ADDRESS1","");		

				
				resultList=((Element)node).getElementsByTagName("Address2");
				if(resultList.item(0).getFirstChild().getNodeValue()!=null)
					ret.setFieldValue("ADDRESS2",resultList.item(0).getFirstChild().getNodeValue());
				else
				ret.setFieldValue("ADDRESS2","");		

				resultList=((Element)node).getElementsByTagName("City");
				if(resultList.item(0).getFirstChild().getNodeValue()!=null)
				ret.setFieldValue("CITY",resultList.item(0).getFirstChild().getNodeValue());
				else
				ret.setFieldValue("CITY","");		

				resultList=((Element)node).getElementsByTagName("State");
				if(resultList.item(0).getFirstChild().getNodeValue()!=null)
				ret.setFieldValue("STATE",resultList.item(0).getFirstChild().getNodeValue());
				else
				ret.setFieldValue("STATE","");		

				resultList=((Element)node).getElementsByTagName("Country");
				if(resultList.item(0).getFirstChild().getNodeValue()!=null)
				ret.setFieldValue("COUNTRY",resultList.item(0).getFirstChild().getNodeValue());
				else
				ret.setFieldValue("COUNTRY","");		

				resultList=((Element)node).getElementsByTagName("CST");
				if(resultList.item(0).getFirstChild().getNodeValue()!=null)
				ret.setFieldValue("CST",resultList.item(0).getFirstChild().getNodeValue());
				else
				ret.setFieldValue("CST","");		

				/*resultList=((Element)node).getElementsByTagName("Centralexice-code");
				if(resultList.item(0).getFirstChild().getNodeValue()!=null)
				ret.setFieldValue("CENTRALEXICE-CODE",resultList.item(0).getFirstChild().getNodeValue());
				else
				*/
				ret.setFieldValue("CENTRALEXICE-CODE","");	
				

				resultList=((Element)node).getElementsByTagName("Phone");
				if(resultList.item(0).getFirstChild().getNodeValue()!=null)
				ret.setFieldValue("PHONE",resultList.item(0).getFirstChild().getNodeValue());
				else
				ret.setFieldValue("PHONE","");		
				

				ret.addRow();
			}
		}

	}
	catch(Exception e)
	{
		out.println(e);

	}
%>

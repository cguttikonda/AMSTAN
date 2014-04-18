<%@page import="ezc.ezcommon.*"%>
<%@ include file="../../../Includes/JSPs/Misc/iJaxpPath.jsp" %>
<jsp:useBean id="ShManager" class="ezc.ezshipment.client.EzShipmentManager" scope="session" />
<jsp:useBean id="EzWorkFlowManager" class="ezc.ezworkflow.client.EzWorkFlowManager" scope="session" />
<%
	
	String data="";
	String userRole = (String)session.getValue("USERROLE");
	int rowCount=0;
	String isNew="Y";
	String flag="N";
	String newStat = "";

	String qcfNum = request.getParameter("qcfNumber");
	String status = request.getParameter("status");
	String statMessage = "";
	String createdBy = request.getParameter("createdBy");
	if(createdBy==null)
	{
	   createdBy="";
	}

	if(status==null)
	{
	   status="N";	
	}


	if(!status.equals("QCFSUBMITTEDBYVP"))
	{
		statMessage = "To Be Approved";
	}
	else
	{
		statMessage = "Approved";
	}

	ezc.ezsap.V46B.generated.SoliTable myTable=null;

	ezc.ezparam.ReturnObjFromRetrieve ret=new ezc.ezparam.ReturnObjFromRetrieve(new String[]{"USER","DATE","COMMENTS"});
	ezc.ezsap.V46B.generated.SoliTableRow myTableRow=null;
	
	try
	{
	   if(userRole.equals("PP"))
	   {

		ezc.ezparam.EzcParams wfMainParams = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziWFDocHistoryParams wfParams= new ezc.ezworkflow.params.EziWFDocHistoryParams();	

		String sysKey="";
		
		/*ezc.client.EzcPurchaseUtilManager PurManager = new ezc.client.EzcPurchaseUtilManager(Session);
		ReturnObjFromRetrieve retcatarea = (ReturnObjFromRetrieve)PurManager.getUserPurAreas();
		for(int i=0;i<retcatarea.getRowCount();i++)
		{
		   sysKey = sysKey+retcatarea.getFieldValue(i,"ESKD_SYS_KEY")+"','";
		}
		sysKey = sysKey.substring(0,sysKey.length()-3); */

		sysKey = (String)session.getValue("SYSKEY");
	
		wfParams.setAuthKey("'PO_LIST'");
		wfParams.setSysKey("'"+sysKey+"'");
		wfParams.setDocId("'"+qcfNum+"'");
		wfParams.setTemplateCode((String)session.getValue("TEMPLATE"));
		wfParams.setCreatedBy("'"+Session.getUserId()+"'"); 
	
		wfMainParams.setObject(wfParams);
		Session.prepareParams(wfMainParams);
		
		ezc.ezparam.ReturnObjFromRetrieve retobj=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWFDocList(wfMainParams);


		int retobjCount=retobj.getRowCount();
		if(retobjCount>0)
		{
		     for(int i=0;i<retobjCount;i++)
		     {
			if(retobj.getFieldValueString(i,"DOCID").equals(qcfNum))
			{
				flag="Y";
				newStat = retobj.getFieldValueString(i,"STATUS");
				createdBy = retobj.getFieldValueString(i,"CREATEDBY");
			}	
		     }		
		}	
		
		if(!flag.equals("Y"))
		{
			ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(true);
			EziPrintParams params= new EziPrintParams();
			params.setObjectType("QCF");
			params.setObjectNo(qcfNum);
			params.setDocType("TEXT");
			//params.setCustomer("3000");
			mainParams.setObject(params);
			Session.prepareParams(mainParams);
				   
			myTable=(ezc.ezsap.V46B.generated.SoliTable)ShManager.ezGetPrintVersion(mainParams);
			rowCount=myTable.getRowCount(); 
		 }
		 else	
		 {
			rowCount = 2;
		 }
	 
		 if(status.equals("N") && flag.equals("Y"))
		 {
		 	isNew="N";
		 }

	    }	
		rowCount=2;
		String userId = Session.getUserId();
		
		String filePath=request.getRealPath("ezQcfComments.jsp");
		filePath=filePath.substring(0,filePath.indexOf("ezQcfComments.jsp"));
		//filePath += "\\EzCommerce\\EzVendor\\EzVendorDemo\\Vendor2\\JSPs\\Purorder\\QCF\\"+qcfNum+".xml";
		filePath=filePath+relativePath+qcfNum+".xml";
		
		

	  	if(rowCount>1)
	  	{

			File f = new File(filePath);
	
			if(!f.exists())
			{
				
				FileWriter fw = new FileWriter(f);
				String fileString = "<?xml version = '1.0'?>\n<Print-Comments>\n</Print-Comments>";
				fw.write(fileString);
				fw.close();
			}
		}	

		String fPath = filePath;
		filePath = "file:"+filePath;

		DocumentBuilderFactory docFactory = javax.xml.parsers.DocumentBuilderFactory.newInstance();
		DocumentBuilder docBuilder = docFactory.newDocumentBuilder();

		Document doc = docBuilder.parse(filePath);
	
		Element root = doc.getDocumentElement();
	
		NodeList textList = root.getElementsByTagName("Ret-Data");
		int m = textList.getLength();
		
		if(m==0)
		{			
		  	if(rowCount>1)
		  	{
	   			for(int i=0;i<rowCount;i++)
	   			{
	   				myTableRow=myTable.getRow(i);
	   				data = data+myTableRow.getLine()+"<br>";
	   			}
		   

		  		 Node n1 = (Node)doc.createElement("Ret-Data");
		  		 Node n2 = (Node)doc.createElement("Data");
		   
		  		 Node n3 = (Node)doc.createTextNode(data);
		   
		  		 n2.appendChild(n3);
		  		 n1.appendChild(n2);
		   
		  		 Node tmp = (Node)root;
		  		 tmp.appendChild(n1);
  
		  		 TransformerFactory factory = TransformerFactory.newInstance();
		  		 Transformer transformer = factory.newTransformer();
		  		 transformer.transform(new DOMSource(root),new StreamResult(new FileOutputStream(fPath)));
		  	}	 

		
		}
		else
		{



			//if(!userRole.equals("PP"))				
			//{
				rowCount=2;
			//}		
		
		  	//if(rowCount>1)
		  	//{

				Node dataNode=null;
				NodeList dataList=null;
		
				for(int i=0;i<m;i++)
				{
					dataNode=textList.item(i);
					dataList=dataNode.getChildNodes();
	
					dataList=((Element)dataNode).getElementsByTagName("Data");
					data = dataList.item(0).getFirstChild().getNodeValue();
				
		     		}
		     	//}	
			
		} 
	
		NodeList list = root.getElementsByTagName("User-Comments");
		int n = list.getLength();
	
		Node node=null;
		NodeList resultList=null;
		
		for(int i=0;i<n;i++)
		{
			node=list.item(i);
			resultList=node.getChildNodes();

			resultList=((Element)node).getElementsByTagName("User");
			ret.setFieldValue("USER",resultList.item(0).getFirstChild().getNodeValue());
			resultList=((Element)node).getElementsByTagName("Date");
			ret.setFieldValue("DATE",resultList.item(0).getFirstChild().getNodeValue());
			resultList=((Element)node).getElementsByTagName("Comments");
			ret.setFieldValue("COMMENTS",resultList.item(0).getFirstChild().getNodeValue());
			ret.addRow();
		
		}
		

	}
	catch(Exception e)
	{
		//out.println("Exception is "+e.getMessage());
	}
%>


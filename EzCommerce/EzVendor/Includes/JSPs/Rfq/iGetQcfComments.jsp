<%@page import="ezc.ezcommon.*"%>
<jsp:useBean id="ShManager" class="ezc.ezshipment.client.EzShipmentManager" scope="session" />

<jsp:useBean id="EzWorkFlowManager" class="ezc.ezworkflow.client.EzWorkFlowManager" scope="session" />
<%

	String data	= "";
	String userRole = (String)session.getValue("USERROLE");
	int rowCount	= 0;
	String isNew	= "Y";
	String flag	= "N";
	String newStat 	= "";

	String qcfNum 	= request.getParameter("qcfNumber");
	String quantity = request.getParameter("quantity");
	String action 	= request.getParameter("action");
	String status 	= request.getParameter("status");
	String isDelegate = request.getParameter("isdelegate");
	String fl 	= "";
	String prevStatus = "";
	String nextPart = "";
	
	
	if(action==null)
	{
		// action = "A";
		action = "N";
	}	 
	String type 	= request.getParameter("type");
	if(type==null)
	  type="";

	ezc.ezsap.V46B.generated.SoliTable myTable=null;

	ezc.ezparam.ReturnObjFromRetrieve ret=new ezc.ezparam.ReturnObjFromRetrieve(new String[]{"USER","DATE","COMMENTS"});
	ezc.ezsap.V46B.generated.SoliTableRow myTableRow=null;
	
	try
	{
		ezc.ezparam.EzcParams wfMainParams = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziWFDocHistoryParams wfParams= new ezc.ezworkflow.params.EziWFDocHistoryParams();	
		ezc.ezparam.ReturnObjFromRetrieve retobj = null;
		
		String sysKey="";
		sysKey = (String)session.getValue("SYSKEY");

		wfParams.setAuthKey("QCF_RELEASE");
		wfParams.setSysKey(sysKey);
		wfParams.setSoldTo("0");
		wfParams.setDocId(qcfNum);


		wfMainParams.setObject(wfParams);
		Session.prepareParams(wfMainParams);
		try
		{
			retobj=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWFDocDetails(wfMainParams);
		}
		catch(Exception e)
		{
			System.out.println("Exception Occured while getting getWFDocDetails in ezQcfComments.jsp:"+e);
		}
		
		int retobjCount = 0;
		if(retobj!=null)
		{
			retobjCount = retobj.getRowCount();
		}	
		if(retobjCount>0)
		{
			prevStatus	= retobj.getFieldValueString(0,"STATUS");	
			nextPart	= retobj.getFieldValueString(0,"NEXTPARTICIPANT");	
		}	
		
		System.out.println("userRoleuserRole:"+userRole);	
		
	   if(userRole.equals("SP"))
	   {
	
		if(retobjCount==0)
		{
			flag="Y";
		}	
		if(!flag.equals("Y"))
		{
			System.out.println("Here flag is not y:");
			
			ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(true);
			EziPrintParams params= new EziPrintParams();
			params.setObjectType("QCF");
			params.setObjectNo(qcfNum);
			params.setDocType("TEXT");
			mainParams.setObject(params);
			Session.prepareParams(mainParams);
				   
			myTable	= (ezc.ezsap.V46B.generated.SoliTable)ShManager.ezGetPrintVersion(mainParams);
			rowCount= myTable.getRowCount(); 
		 }
		 else	
		 {
			rowCount = 2;
		 }
 

	    }	
	
		
		
		
		String userId	= Session.getUserId();
		String filePath	= request.getRealPath("ezQcfComments.jsp");
		filePath	= filePath.substring(0,filePath.indexOf("ezQcfComments.jsp"));
		filePath += "\\EzCommerce\\EzVendor\\EzRanbaxyVendor\\Vendor2\\JSPs\\Rfq\\QCF\\"+qcfNum+".xml";

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

		String fPath	= filePath;
		filePath 	= "file:"+filePath;

		DocumentBuilderFactory docFactory = javax.xml.parsers.DocumentBuilderFactory.newInstance();
		DocumentBuilder docBuilder = docFactory.newDocumentBuilder();
		Document doc	= docBuilder.parse(filePath);
		Element root	= doc.getDocumentElement();
		NodeList textList = root.getElementsByTagName("Ret-Data");
		int m	= textList.getLength();

		if(m==0)
		{	
		  	if(rowCount>1)
		  	{
		  		if(myTable!=null)
		  		{
					for(int i=0;i<rowCount;i++)
					{
						myTableRow	= myTable.getRow(i);
						data 		= data+myTableRow.getLine()+"<br>";
					}
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

			if(!userRole.equals("SP"))
			{
				rowCount=2;
			}
		
		  	if(rowCount>1)
		  	{

				Node dataNode	 = null;
				NodeList dataList= null;
				System.out.println("MMMMMMMMMMMMMMMMMMMMMMMMM:"+m);	
				for(int i=0;i<m;i++)
				{
					dataNode	= textList.item(i);
					dataList	= dataNode.getChildNodes();
					dataList	= ((Element)dataNode).getElementsByTagName("Data");
					data 		= dataList.item(0).getFirstChild().getNodeValue();
				
		     		}
		     	}
			
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
		
		
		ezc.ezpreprocurement.client.EzPreProcurementManager qcfManager = new ezc.ezpreprocurement.client.EzPreProcurementManager();
		ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
		mainParams.setLocalStore("Y");
		ezc.ezpreprocurement.params.EziQcfCommentParams qcfParams= new ezc.ezpreprocurement.params.EziQcfCommentParams();
		qcfParams.setQcfCode(qcfNum);
		mainParams.setObject(qcfParams);
		Session.prepareParams(mainParams);
						   
		ret = (ezc.ezparam.ReturnObjFromRetrieve)qcfManager.getQcfCommentList(mainParams);
		

	}
	catch(Exception e)
	{
		System.out.println("Exception is in ezQcfComents.jsp:"+e);
	}
%>

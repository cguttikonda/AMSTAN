<%@ page import = "ezc.sapconnection.*,com.sap.mw.jco.*,com.sap.mw.jco.JCO,ezc.ezparam.*" %>
<%@ page import = "ezc.ezutil.FormatDate"%>
<%@ page import ="java.util.*,ezc.ezbasicutil.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<%
	String Status = "R";//request.getParameter("Status");
	String matNo = request.getParameter("matNo");
	String plant = request.getParameter("selplant");
	plant = "BP01";
	String fromDate = request.getParameter("fromDate");
	String toDate = request.getParameter("toDate");
	
	java.util.Date fromDate1 = null;
	java.util.Date toDate1 = null;
		//fromDate = fromDate.substring(3,5)+"/"+fromDate.substring(0,2)+"/"+fromDate.substring(6,10);
	if(!(fromDate==null || fromDate=="" || "".equals(fromDate)) || "null".equals(fromDate))
		fromDate1 = new java.util.Date(fromDate);
	if(!(toDate==null || toDate=="" || "".equals(toDate)) || "null".equals(toDate))
		toDate1 = new java.util.Date(toDate);
	
	ezc.ezcommon.EzLog4j.log("==fromDate=="+fromDate+"=fromDate1 "+fromDate1,"I");
	ezc.ezcommon.EzLog4j.log("==toDate=="+toDate+"=toDate1 "+toDate1,"I");
	
	//SimpleDateFormat dateDisplayFormat = new SimpleDateFormat("dd/MM/yyyy"); 
	//Date date = dateDisplayFormat.parse("2010-58-14 03:58:02"); 

	ezc.ezparam.EzcParams mainParams=new ezc.ezparam.EzcParams(true);
	ezc.ezpreprocurement.client.EzPreProcurementManager cm=new ezc.ezpreprocurement.client.EzPreProcurementManager(); 
	
	com.sap.mw.jco.JCO.Client client = null;
	
	String systemKey = (String)session.getValue("SYSKEY");
	String site = (String)session.getValue("Site");
	String connStr 		= "642~999";
	if(systemKey!=null)
		connStr = site+"~"+systemKey.substring(0,3);

	java.util.Hashtable purgrphash	=  (java.util.Hashtable)session.getValue("PURGROUPS");


	String purGrp = "";

	if(purgrphash!=null)
	purGrp = (String)purgrphash.get(systemKey);
	
	com.sap.mw.jco.JCO.Function function = EzSAPHandler.getFunction("Z_EZ_GET_PRS",connStr);
	com.sap.mw.jco.JCO.ParameterList sapPreProc = function.getImportParameterList();

	client = EzSAPHandler.getSAPConnection(connStr);
	
	if(Status.equals("R"))
	{		
		sapPreProc.setValue("Y", "RELEASE_FLAG");
	}
	else
	{	
		sapPreProc.setValue("N", "RELEASE_FLAG");
	}

	sapPreProc.setValue(purGrp, "PUR_GROUP");
        
        if(!("".equals(plant) || plant==null || "null".equals(plant)))
        	sapPreProc.setValue(plant, "PLANT");
        
        if(!("".equals(matNo) || matNo==null || "null".equals(matNo)))
        	sapPreProc.setValue(matNo, "MATERIAL");
       
       if(!("".equals(fromDate) || fromDate==null || "null".equals(fromDate)))
       		sapPreProc.setValue(fromDate1, "FROM_DATE");
       		
       if(!("".equals(toDate1) || toDate1==null || "null".equals(toDate1)))
       		sapPreProc.setValue(toDate1, "TO_DATE");

	try{
		client.execute(function);
	}catch(Exception e){}


	ReturnObjFromRetrieve myRet=new ReturnObjFromRetrieve(new String[]{"REQNO","ITEM","REQDATE","REL_DATE","DESCRIPTION","MATERIAL","PLANT","QUANTITY","UNIT","DELIV_DATE","CREATED_BY","TRACKING_NO","INT_ORDER","VAL_TYPE"});
	try 
	{
		JCO.Table sapPurchReqList = function.getTableParameterList().getTable("REQUISITION_ITEMS");

		//out.println(sapPurchReqList);

		int poCount = sapPurchReqList.getNumRows();
		if(poCount>0)
		{
			do
			{

				myRet.setFieldValue("REQNO", sapPurchReqList.getValue("PREQ_NO"));			//"BANFN"
				myRet.setFieldValue("ITEM",sapPurchReqList.getValue("PREQ_ITEM"));			//"BNFPO"
				myRet.setFieldValue("REQDATE",sapPurchReqList.getValue("PREQ_DATE"));		//"BADAT"
				myRet.setFieldValue("DELIV_DATE",sapPurchReqList.getValue("DELIV_DATE"));	//"LFDAT"
				myRet.setFieldValue("REL_DATE",sapPurchReqList.getValue("REL_DATE"));		//"FRGDT"
				myRet.setFieldValue("DESCRIPTION",sapPurchReqList.getValue("SHORT_TEXT"));	//"TXZ01"
				myRet.setFieldValue("MATERIAL",sapPurchReqList.getValue("MATERIAL"));		//"MATNR"
				myRet.setFieldValue("PLANT",sapPurchReqList.getValue("PLANT"));			//"WERKS"
				myRet.setFieldValue("QUANTITY",sapPurchReqList.getValue("QUANTITY"));		//"MENGE"
				myRet.setFieldValue("UNIT",sapPurchReqList.getValue("UNIT"));				//"MEINS"
				myRet.setFieldValue("CREATED_BY",sapPurchReqList.getValue("CREATED_BY"));	//"ERNAM"
				myRet.setFieldValue("TRACKING_NO",sapPurchReqList.getValue("TRACKINGNO"));
				myRet.setFieldValue("INT_ORDER",sapPurchReqList.getValue("PROMOTION"));
				myRet.setFieldValue("VAL_TYPE",sapPurchReqList.getValue("VAL_TYPE"));
				myRet.addRow();

			}
			while(sapPurchReqList.nextRow());
		}
	} catch (Exception e) {}

	finally{
		if (client!=null){
			//log("R E L E A S I N G   C L I E N T .... ");
			JCO.releaseClient(client);
			client = null;
			function=null;
		}
	}
		
	int myRetCount = myRet.getRowCount();
	
	if(myRetCount>0)
	{
		//myRet.sort(new String[]{"REQDATE","MATERIAL","PLANT"},false);
		//myRet.sort(new String[]{"REQDATE"},false);
	}
	
/************* The following is for knowing RFQ created against PR(s) or not  ******************/	
	java.util.TreeSet prTreeSet=new java.util.TreeSet();
	java.util.Hashtable colRfqsHt=new java.util.Hashtable();
	ezc.ezparam.ReturnObjFromRetrieve retObj = null;

	ezc.ezpreprocurement.params.EziRFQHeaderParams ezirfqheaderparams 	= new ezc.ezpreprocurement.params.EziRFQHeaderParams();
	ezirfqheaderparams.setExt1("RFQ_PR");	
	mainParams.setObject(ezirfqheaderparams);
	mainParams.setLocalStore("Y");
	Session.prepareParams(mainParams);
	try
	{
		retObj=(ezc.ezparam.ReturnObjFromRetrieve)cm.ezGetRFQList(mainParams);
	}
	catch(Exception e)
	{
		System.out.println("Exception Occured in iListPR.jsp while getting PR details"+e.getMessage());
	}	

	int retObjCount=0;
	if(retObj!=null)
		retObjCount=retObj.getRowCount();

	for(int i=0;i<retObjCount;i++)
	{
		String prText=retObj.getFieldValueString(i,"PR_TEXT");
		String colRfqNo=retObj.getFieldValueString(i,"COLLECTIVE_RFQ_NO");
		if(prText!=null && !"null".equals(prText) && !"".equals(prText.trim()))
		{

			EzStringTokenizer notesAllSt=null;
			notesAllSt = new EzStringTokenizer(prText,"$");
			int notesAllCt =notesAllSt.getTokens().size();
			if(notesAllCt>0)
			{
				for(int j=0;j<notesAllCt;j++)
				{
					EzStringTokenizer notesAllSt1 = new EzStringTokenizer((String)notesAllSt.getTokens().elementAt(j),"¥");
					int notesAllCt1 = notesAllSt1.getTokens().size();
					if(notesAllCt1>1)
					{

						String keyStr=(String)notesAllSt1.getTokens().elementAt(0)+"¥"+(String)notesAllSt1.getTokens().elementAt(1);

						prTreeSet.add(keyStr);
						colRfqsHt.put(keyStr,colRfqNo);
					}
				}	
			}
		}	
	}
	
	
	
%>

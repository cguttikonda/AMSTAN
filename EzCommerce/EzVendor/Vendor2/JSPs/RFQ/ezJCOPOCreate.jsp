<%//@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ page import ="ezc.sapconnection.*,com.sap.mw.jco.*,com.sap.mw.jco.JCO" %>
<%@page import="ezc.ezutil.*,ezc.ezparam.*,ezc.ezpreprocurement.params.*"%>
<%@include file="../../../Includes/JSPs/Rfq/iViewRFQDetails.jsp"%>
<jsp:useBean id="Manager" class="ezc.ezpreprocurement.client.EzPreProcurementManager" />	
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>

<%

	//Delivery Schedules
	ezc.ezcommon.EzLog4j.log("**ezPurchaseOrderDeliverySchedule** START","I");
	String poNum1 = request.getParameter("PurchaseOrder");
	ezc.ezcommon.EzLog4j.log("**poNum1** START"+poNum1,"I");
	String OrderDate = request.getParameter("OrderDate");
	String EndDate = request.getParameter("EndDate");
	ezc.ezcommon.EzLog4j.log("**OrderDate** START"+OrderDate,"I");
	ezc.ezcommon.EzLog4j.log("**EndDate** START"+EndDate,"I");

	EzcParams ezcparams= new EzcParams(false);

	iparams = new EzPSIInputParameters();
	iparams.setOrderNumber(poNum1);
	newParams = new ezc.ezparam.EzcPurchaseParams();
	testparams = new ezc.ezpurchase.params.EziPurOrderDetailsParams();
	newParams.createContainer();
	newParams.setObject(iparams);
	newParams.setObject(testparams);
	Session.prepareParams(newParams);
	ezc.ezcommon.EzLog4j.log("**ezPurchaseOrderDeliverySchedule** START","I");
	ReturnObjFromRetrieve retObj =  (ReturnObjFromRetrieve)PoManager.ezPurchaseOrderDeliverySchedule(newParams);
	ezc.ezcommon.EzLog4j.log("**ezPurchaseOrderDeliverySchedule** END"+retObj.toEzcString(),"I");

        int retCount = retObj.getRowCount();
        	//out.println("==retObj=="+retObj.toEzcString()	);
        
	//Create PO
	
	JCO.Client client = null;
	JCO.Function function = null;
	String createdPONum = "";
	boolean poCreated = false;
	
	java.util.Hashtable compht = (java.util.Hashtable)session.getValue("COMP_CODE");
	String compCode = (String)compht.get(session.getValue("SYSKEY"));
	
	String purchOrg = (String)Session.getUserPreference("PURORG");
	
	String systemKey = (String)session.getValue("SYSKEY");
	java.util.Hashtable purgrphash	=  (java.util.Hashtable)session.getValue("PURGROUPS");
	String purGrp = "";	
	if(purgrphash!=null)
		purGrp = (String)purgrphash.get(systemKey);
	String docType = "NB";
	String siteNo = (String)session.getValue("Site");
	
	ReturnObjFromRetrieve outRet = new ReturnObjFromRetrieve(new String[] {
		            "PO_NUM", "TYPE", "ID", "NUMBER", "MESSAGE", "LOG_NO", "LOG_MSG_NO", "MESSAGE_V1", "MESSAGE_V2", "MESSAGE_V3", 
		            "MESSAGE_V4", "PARAMETER", "ROW", "FIELD", "SYSTEM"
	        });
	         String retMessage ="";
				boolean closing=false;
	boolean prclose=true;
try
{
	
	client   = EzSAPHandler.getSAPConnection(siteNo+"~999");
	function = EzSAPHandler.getFunction("BAPI_PO_CREATE1");
        JCO.ParameterList sapImpParam = function.getImportParameterList();
        JCO.ParameterList sapTabParam = function.getTableParameterList();
        JCO.Structure PoHeader = sapImpParam.getStructure("POHEADER");
        JCO.Structure PoHeaderx = sapImpParam.getStructure("POHEADERX");
        JCO.Table PoItem = sapTabParam.getTable("POITEM");
        JCO.Table PoItemx = sapTabParam.getTable("POITEMX");
        JCO.Table PoSchedule = sapTabParam.getTable("POSCHEDULE");
        JCO.Table PoSchedulex = sapTabParam.getTable("POSCHEDULEX");
        JCO.Table PoCond = sapTabParam.getTable("POCOND");
        JCO.Table PoCondx = sapTabParam.getTable("POCONDX");
        JCO.Table PoTextHeader = sapTabParam.getTable("POTEXTHEADER");
        JCO.Table PoTextItem = sapTabParam.getTable("POTEXTITEM");
        
       
        
        String incoTerms1="",incoTerms2="",pmntTerms="";
        
           
        
                
        PoHeader.setValue(compCode, "COMP_CODE");
        PoHeaderx.setValue("X", "COMP_CODE");
       
        PoHeader.setValue(purchOrg, "PURCH_ORG");
        PoHeaderx.setValue("X", "PURCH_ORG");
        
        PoHeader.setValue(purGrp, "PUR_GROUP");
        PoHeaderx.setValue("X", "PUR_GROUP");
       
        PoHeader.setValue(docType, "DOC_TYPE");
        PoHeaderx.setValue("X", "DOC_TYPE");
        
        ezc.ezcommon.EzLog4j.log("***compCode***"+compCode,"I");
        ezc.ezcommon.EzLog4j.log("***purchOrg***"+purchOrg,"I");
        ezc.ezcommon.EzLog4j.log("***purGrp***"+purGrp,"I");
        ezc.ezcommon.EzLog4j.log("***docType***"+docType,"I");
        
      
        if(retHead.getRowCount() > 0)
	{
		incoTerms1 = retHead.getFieldValueString(0,"INCOTERM1");
		incoTerms2 = retHead.getFieldValueString(0,"INCOTERM2");
	        pmntTerms   = retHead.getFieldValueString(0,"PMNTTERM");
	        String quoteDateStr = retHead.getFieldValueString(0,"QUOTDATE");
	        
	        java.util.Date quoteDate = new Date(quoteDateStr);
	        
	        
	       /* PoHeader.setValue(pmntTerms, "PMNTTRMS");
		PoHeaderx.setValue("X", "PMNTTRMS");

		PoHeader.setValue(incoTerms2, "INCOTERMS1");
		PoHeaderx.setValue("X", "INCOTERMS1");

		PoHeader.setValue(incoTerms1, "INCOTERMS2");
		PoHeaderx.setValue("X", "INCOTERMS2");*/
		
		PoHeader.setValue(quoteDate, "QUOT_DATE");
		PoHeaderx.setValue("X", "QUOT_DATE");
		
		PoHeader.setValue(ordDate, "DOC_DATE");
		PoHeaderx.setValue("X", "DOC_DATE");
		
		PoHeader.setValue(ordDate, "CREAT_DATE");
		PoHeaderx.setValue("X", "CREAT_DATE");
		
		ezc.ezcommon.EzLog4j.log("***PMNTTRMS***"+pmntTerms,"I");
		ezc.ezcommon.EzLog4j.log("***INCOTERMS2***"+incoTerms2,"I");
		ezc.ezcommon.EzLog4j.log("***INCOTERMS1***"+incoTerms1,"I");
		ezc.ezcommon.EzLog4j.log("***QUOT_DATE***"+quoteDate,"I");
		

        }
        
        String vendor = ((String)session.getValue("SOLDTO")).trim();//"S-1006";
        
	PoHeader.setValue(vendor, "VENDOR");
	PoHeaderx.setValue("X", "VENDOR");

	PoHeader.setValue(poNum1, "QUOTATION");
	PoHeaderx.setValue("X", "QUOTATION");
	
        ezc.ezcommon.EzLog4j.log("***VENDOR***"+vendor,"I");
        ezc.ezcommon.EzLog4j.log("***AGREEMENT***"+poNum1,"I");
        ezc.ezcommon.EzLog4j.log("***QUOTATION***"+poNum1,"I");
        ezc.ezcommon.EzLog4j.log("***JYOTHI dtlXML***"+dtlXML.toEzcString(),"I");
       
      
        if(Count > 0)
        {
            for(int i = 0; i < Count; i++)
            {
               
                PoItem.appendRow();
                PoItemx.appendRow();
                
                String itmMaterial = dtlXML.getFieldValueString(i,"ITEM");
                String itemDesc = dtlXML.getFieldValueString(i,"ITEMDESCRIPTION");
                String itmPlant = dtlXML.getFieldValueString(i,"PLANT");
                String itmQty = dtlXML.getFieldValueString(i,"ORDEREDQUANTITY");
                String itmUOM = dtlXML.getFieldValueString(i,"UOMPURCHASE");
                //SLoc = itmRow.getSLoc();
                //FOC = itmRow.getFOC();
                String itmPrice = dtlXML.getFieldValueString(i,"AMOUNT");
                Double itmPriceDouble = new Double(Double.parseDouble(itmPrice));
                //Double d = itmPriceDouble.doubleValue()*100.0;
                
                String itemPrice = (itmPriceDouble.doubleValue()*100.0)+"";
                String taxCode = dtlXML.getFieldValueString(i,"TAX_CODE");
                //confCtrl = itmRow.getConfCtrl();
                //valType = itmRow.getValType();
                //shipInstr = itmRow.getShipInstr();
                String rfqItem = dtlXML.getFieldValueString(i,"POSITION");
                //reqNo = itmRow.getPRNo();
                //String reqItem = 
                //itmagreement = itmRow.getAgreement();
                //agmtItem = itmRow.getAgmtItem();
                String statusChar = "N";
                 // itmPlant="BP01";        
               
                PoItem.setValue((i + 1) * 10, "PO_ITEM");
                PoItemx.setValue((i + 1) * 10, "PO_ITEM");
                
                PoItemx.setValue("X", "PO_ITEMX");
                
              /*  if(taxCode != null)
                {
                    PoItem.setValue(taxCode, "TAX_CODE");
                    PoItemx.setValue("X", "TAX_CODE");
                }*/

		PoItem.setValue(itmPlant, "PLANT");
		PoItemx.setValue("X", "PLANT");
              
		PoItem.setValue(poNum1, "RFQ_NO");
		PoItem.setValue(rfqItem, "RFQ_ITEM");
		PoItemx.setValue("X", "RFQ_NO");
		PoItemx.setValue("X", "RFQ_ITEM");
		statusChar = "Y";
                         
		PoItem.setValue(itmMaterial, "MATERIAL");
		PoItemx.setValue("X", "MATERIAL");
		
		PoItem.setValue(itemDesc, "SHORT_TEXT");
		PoItemx.setValue("X", "SHORT_TEXT");
	
		PoItem.setValue(itmQty, "QUANTITY");
		PoItemx.setValue("X", "QUANTITY");
                   
                 
		ezc.ezcommon.EzLog4j.log("***PO_ITEM***"+((i + 1) * 10),"I");
		ezc.ezcommon.EzLog4j.log("***TAX_CODE***"+taxCode,"I");
		ezc.ezcommon.EzLog4j.log("***PLANT***"+itmPlant,"I");
		ezc.ezcommon.EzLog4j.log("***RFQ_NO***"+poNum1,"I");
		ezc.ezcommon.EzLog4j.log("***RFQ_ITEM***"+rfqItem,"I");
                ezc.ezcommon.EzLog4j.log("***QUOTATION***"+poNum1,"I");
                
                ezc.ezcommon.EzLog4j.log("***MATERIAL***"+itmMaterial,"I");
                ezc.ezcommon.EzLog4j.log("***PO_UNIT***"+itmUOM,"I");
                ezc.ezcommon.EzLog4j.log("***FREE_ITEM***X","I");
                ezc.ezcommon.EzLog4j.log("***QUANTITY***"+itmQty,"I");
                ezc.ezcommon.EzLog4j.log("***NET_PRICE***"+itemPrice,"I");
            }

        }
       
        if(retCount > 0)
        {
            int k = 1;
            for(int j = 0; j < retCount; j++)
            {
                ezc.ezcommon.EzLog4j.log("**ezPurchaseOrderDeliverySchedule** ezJCOPOCreate.jsp START"+j,"I");
                
                              
                String qty = (String)retObj.getFieldValue(j,"QUANTITY");
                //String dlvDareStr = retObj.getFieldValueString(j,"DLVDATE");
                String lineNum = retObj.getFieldValueString(j,"LINENUM");
                
                ezc.ezcommon.EzLog4j.log("**ezPurchaseOrderDeliverySchedule ezJCOPOCreate.jsp** qty"+qty,"I");                
                
                
                PoSchedule.appendRow();
                PoSchedulex.appendRow();
                
                String delvDate = FormatDate.getStringFromDate((java.util.Date)retObj.getFieldValue(j,"DLVDATE"),"/",Integer.parseInt((String)session.getValue("DATEFORMAT")));
                ezc.ezcommon.EzLog4j.log("**ezPurchaseOrderDeliverySchedule** ezJCOPOCreate.jsp delvDate"+delvDate,"I");
               
                PoSchedule.setValue((j + 1) * 10, "PO_ITEM");
                PoSchedule.setValue(k, "SCHED_LINE");
                PoSchedule.setValue(qty, "QUANTITY");
                PoSchedule.setValue(delvDate, "DELIVERY_DATE");
                PoSchedulex.setValue((j + 1) * 10, "PO_ITEM");
                PoSchedulex.setValue(k, "SCHED_LINE");
                PoSchedulex.setValue("X", "PO_ITEMX");
                PoSchedulex.setValue("X", "SCHED_LINEX");
                PoSchedulex.setValue("X", "QUANTITY");
                PoSchedulex.setValue("X", "DELIVERY_DATE");
                //k++;
            }

        }
        
        try
        {
		client.execute(function);
		EzSAPHandler.commit(client);		
	}
	catch(Exception e)
	{
		ezc.ezcommon.EzLog4j.log("ERROR OCCURED IN EXECUTING BAPI_PO_CREATE1 FUNCTION"+e,"W");
	}

        
        ezc.ezcommon.EzLog4j.log("***Output***","I");
        
	ezc.ezcommon.EzLog4j.log("***retOut***","I");
	try
	{
	    com.sap.mw.jco.JCO.Table retOut = function.getTableParameterList().getTable("RETURN");
	    ezc.ezcommon.EzLog4j.log("***retOut***"+retOut,"I");
	    String createdPO = "";
	    com.sap.mw.jco.JCO.ParameterList expParam = function.getExportParameterList();
	    createdPO = (String)expParam.getValue("EXPPURCHASEORDER");
	    ezc.ezcommon.EzLog4j.log("createdPO==***"+createdPO,"I");
	    ezc.ezcommon.EzLog4j.log("***retOut***"+retOut,"I");
	    
	    int poCount = retOut.getNumRows();
	    if(poCount > 0)
		do
		{
		    outRet.setFieldValue("PO_NUM", createdPO);
		    outRet.setFieldValue("TYPE", retOut.getValue("TYPE"));
		    outRet.setFieldValue("ID", retOut.getValue("ID"));
		    outRet.setFieldValue("NUMBER", retOut.getValue("NUMBER"));
		    outRet.setFieldValue("MESSAGE", retOut.getValue("MESSAGE"));
		    outRet.setFieldValue("LOG_NO", retOut.getValue("LOG_NO"));
		    outRet.setFieldValue("LOG_MSG_NO", retOut.getValue("LOG_MSG_NO"));
		    outRet.setFieldValue("MESSAGE_V1", retOut.getValue("MESSAGE_V1"));
		    outRet.setFieldValue("MESSAGE_V2", retOut.getValue("MESSAGE_V2"));
		    outRet.setFieldValue("MESSAGE_V3", retOut.getValue("MESSAGE_V3"));
		    outRet.setFieldValue("MESSAGE_V4", retOut.getValue("MESSAGE_V4"));
		    outRet.setFieldValue("PARAMETER", retOut.getValue("PARAMETER"));
		    outRet.setFieldValue("ROW", retOut.getValue("ROW"));
		    outRet.setFieldValue("FIELD", retOut.getValue("FIELD"));
		    outRet.setFieldValue("SYSTEM", retOut.getValue("SYSTEM"));
		    outRet.addRow();
		} while(retOut.nextRow());
	ezc.ezcommon.EzLog4j.log("PO created==ezJCOPOCreate.jsp*"+outRet.toEzcString(),"I");
	}
	catch(Exception e)
	{
	    ezc.ezcommon.EzLog4j.log("Exception in:convertCreatePO"+e,"I");
        }
%>
<html>
<body>
<br><br><br>
<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:90%;height:60%;left:2%">
<Table id="InnerBox1Tab" width=60% align=center  borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
<%
        boolean flag =false;
        
        if(outRet.getRowCount()>0)
        {
        	int cnt=1;
        	for(int abc=0;abc<outRet.getRowCount();abc++)
        	{
        		String errorType = outRet.getFieldValueString(abc,"TYPE");
        		
        		retMessage = retMessage+cnt+". " + outRet.getFieldValueString(abc,"MESSAGE")+"<br>";
        		cnt++;
			flag = true;
			closing=true;     		
        		if("S".equalsIgnoreCase(errorType))
        		{
        			poCreated = true;
        			createdPONum = outRet.getFieldValueString(abc,"PO_NUM");
        		}
        		
        		
        		/*if("E".equalsIgnoreCase(errorType))
        		{
%>
				retMessage = retMessage+cnt+"."+outRet.getFieldValueString(abc,"MESSAGE")+"<br>";
				cnt++;
				flag = false;
				prclose = false;
<%
        		}
        		else if("S".equalsIgnoreCase(errorType))
        		{
				retMessage = retMessage + outRet.getFieldValueString(abc,"MESSAGE");
				retMessage = retMessage + " Successfully"+"<br>";
				flag = true;
				closing=true;
				poCreated = true;
				createdPONum = outRet.getFieldValueString(abc,"PO_NUM");
			}*/
        	}
        }
%>
<Div id="MenuSol"></Div>
</table>
</DIV>
</body>
</html>
<%
        
}
catch(Exception e)
{
	ezc.ezcommon.EzLog4j.log("ERROR OCCURS IN EXECUTING FUNCTION"+e,"W");
}
finally
{
	if (client!=null)
	{
		ezc.ezcommon.EzLog4j.log("R E L E A S I N G   C L I E N T .... ","W");
		JCO.releaseClient(client);
		client = null;
		function = null;
	}
}

ezc.ezcommon.EzLog4j.log("PO Created True/False "+poCreated,"I");

//Release PO in SAP

JCO.ParameterList sapImpParam = null;
if(poCreated)
{
	
	
	
	
	
	
	/****Close PRs********/
	
	ezc.ezparam.EzcParams prezcparams  = new ezc.ezparam.EzcParams(false);
	ezc.ezpreprocurement.params.EziRFQHeaderParams ezirfqheaderparams = new ezc.ezpreprocurement.params.EziRFQHeaderParams();
	ezirfqheaderparams.setRFQNo(poNum1);
	ezirfqheaderparams.setSysKey((String)session.getValue("SYSKEY"));
	prezcparams.setObject(ezirfqheaderparams);
	prezcparams.setLocalStore("Y");
	Session.prepareParams(prezcparams);

	
	ezc.ezpreprocurement.params.EzoRFQHeaderParams ezorfqheaderparams = (ezc.ezpreprocurement.params.EzoRFQHeaderParams)Manager.ezGetRFQDetails(prezcparams);
	
	ezc.ezcommon.EzLog4j.log("****==before==Closing PRS==rfqHeader===**","I");
	ezc.ezparam.ReturnObjFromRetrieve rfqHeader  = (ezc.ezparam.ReturnObjFromRetrieve)ezorfqheaderparams.getRFQHeader();
	ezc.ezcommon.EzLog4j.log("****==before==Closing PRS= after rfqHeader====**"+rfqHeader.toEzcString(),"I");

	ezc.ezpreprocurement.params.EziPRTable  	prTable		= new ezc.ezpreprocurement.params.EziPRTable();
	ezc.ezpreprocurement.params.EziPRTableRow 	prTableRow	= null;
	int count = rfqHeader.getRowCount();  

	for(int i=0;i<count;i++)
	{
		String pr = rfqHeader.getFieldValueString(i,"PR_NO");
		if(pr!=null && !"null".equals(pr))
		{
			prTableRow     =  new ezc.ezpreprocurement.params.EziPRTableRow();
			prTableRow.setReqNo(rfqHeader.getFieldValueString(i,"PR_NO"));
			prTableRow.setItemNo(rfqHeader.getFieldValueString(i,"PR_ITEM_NO"));
			prTableRow.setStatus("X");
			prTable.appendRow(prTableRow);
		}	
	}

	ezc.ezparam.EzcParams prcloseParams=new ezc.ezparam.EzcParams(true);
	prcloseParams.setObject(prTable);
	Session.prepareParams(prcloseParams);
	try
	{
		ezc.ezcommon.EzLog4j.log("****==before==Closing PRS=====**","I");
		ezc.ezparam.ReturnObjFromRetrieve myRet = (ezc.ezparam.ReturnObjFromRetrieve)Manager.ezClosePR(prcloseParams);
		ezc.ezcommon.EzLog4j.log("****==After==Closing PRS=====**"+myRet.toEzcString(),"I");
	}
	catch(Exception e)
	{
		System.out.println("Exception Occured in ezJCOPOCreate.jsp  in closing PR"+e.getMessage());
	}
	
	/***********/
	
	/**** For Close All RFQs ******/	
	ezc.ezparam.EzcParams closeezcparams				     	= new ezc.ezparam.EzcParams(false);
	ezc.ezpreprocurement.params.EziRFQHeaderTable closeezirfqheadertable	= new ezc.ezpreprocurement.params.EziRFQHeaderTable();
	ezc.ezpreprocurement.params.EziRFQHeaderTableRow closeezirfqheadertablerow   = new ezc.ezpreprocurement.params.EziRFQHeaderTableRow();

	
	//If All POs created successfully closed by passing collective rfq number
			

	closeezirfqheadertablerow.setRFQNo(poNum1); 
	closeezirfqheadertablerow.setStatus("C"); 
	closeezirfqheadertablerow.setModifiedBy(Session.getUserId()); 
	closeezirfqheadertable.appendRow(closeezirfqheadertablerow);

	closeezcparams.setObject(closeezirfqheadertable);
	closeezcparams.setLocalStore("Y");
	Session.prepareParams(closeezcparams);
	Manager.ezUpdateRFQ(closeezcparams);
	ezc.ezcommon.EzLog4j.log("****==After==Closing RFQ=====**","I");
	
	/**********************************************************/
	ReturnObjFromRetrieve reth = null;
	EziPOHeaderParams hheaderParams		= new EziPOHeaderParams();
	
	for(int i=0;i<2;i++)
	{
	
		hheaderParams		= new EziPOHeaderParams();	
		hheaderParams.setPONo(createdPONum.trim());
		hheaderParams.setHouseBankId("");
		hheaderParams.setRelFlag("Y");			
		EzcParams hpatchParams = new EzcParams(true);
		hpatchParams.setObject(hheaderParams);
		Session.prepareParams(hpatchParams);

		ezc.ezcommon.EzLog4j.log("Before releasing PO ezPOPostPatch() in ezJCOPOCreate.jsp","I");
		reth = (ReturnObjFromRetrieve)Manager.ezPOPostPatch(hpatchParams);
		
		if(reth.getRowCount()>0) continue;
		else
		break;
	}
	ezc.ezcommon.EzLog4j.log("After releasing PO ezPOPostPatch() in ezJCOPOCreate.jsp"+reth.toEzcString(),"I");
	if(reth!=null && reth.getRowCount()>0)
	{
		for(int i=0;i<reth.getRowCount();i++)
		retMessage = retMessage + "<br><br>"+reth.getFieldValueString(i,"MSGV1");
	}
	
	

	
}
%>
<html>
<head>
<title>
Message
</title>
<%@ include file="../../../Includes/JSPs/Misc/iblockcontrol.jsp" %>
</script>
</head>
<body bgcolor="#FFFFF7">
<Form>

<br>
<br>
<br>
<table width="70%" align="center" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1>
  <tr align="center">
    <th align="left"><%=retMessage%></th>
  </tr>
</table>
<br><br>
<Div id="MenuSol"></Div>
</Form>
</body>
</html>
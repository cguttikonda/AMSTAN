<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<%@ page import ="ezc.ezparam.*,ezc.ezsap.*,ezc.ezcommon.*,ezc.ezutil.*,ezc.record.util.*,ezc.ezshipment.params.*,ezc.ezpurchase.params.*,ezc.ezsap.V46B.generated.*,ezc.ezerp.EzErpConversion" %>
<%@ page import ="java.io.*" %>
<%@ page import="com.sap.mw.jco.*,java.util.*,javax.swing.*,java.awt.*" %>
<%@ page import ="ezc.sapconnection.*,com.sap.mw.jco.*,com.sap.mw.jco.JCO" %>
<%
	JCO.Client client 	= null;
	JCO.Function function	= null;
	String r3SysSID = "243~999";
	try
	{
		client 		= EzSAPHandler.getSAPConnection(r3SysSID);
		function	= EzSAPHandler.getFunction("Z_EZ_PO_CHANGE",r3SysSID);
		
		JCO.ParameterList impParamList 	= function.getImportParameterList();
		JCO.Structure sapHead 	  	= impParamList.getStructure("PO_HEADER");	
		JCO.Structure sapHeadAdd 	= impParamList.getStructure("PO_HEADER_ADD_DATA");	
		
		JCO.Table    sapItemTable = function.getTableParameterList().getTable("PO_ITEMS");
		JCO.Table    sapCondRow   = function.getTableParameterList().getTable("POCOND");
		JCO.Table    sapSlltx     = function.getTableParameterList().getTable("POCOND");
		//JCO.Table    sapTable 	  = function.getTableParameterList().getTable("PO_ITEM_SCHEDULES");

		/*EzBapiekkocStructure header 	= (EzBapiekkocStructure) iParams.getObject("ezc.ezpurchase.params.EzBapiekkocStructure");
		EzBapiekkoaStructure headerAdd  = (EzBapiekkoaStructure) iParams.getObject("ezc.ezpurchase.params.EzBapiekkoaStructure");
		
		EzBapicondTable condTable =  (EzBapicondTable) iParams.getObject("ezc.ezpurchase.params.EzBapicondTable");
		EzBapicondTableRow condRow = null;
		
		EzBapieslltxTable slltxTable =  (EzBapieslltxTable) iParams.getObject("ezc.ezpurchase.params.EzBapieslltxTable");
		EzBapieslltxTableRow slltxRow = null;
		*/
		
		impParamList.setValue("6000000280","PURCHASEORDER");
		
		//log(">>>>>>FOR QUOTE POST Header Structure Values","D");
		sapHead.setValue("6000000280","PO_NUMBER");
		sapHead.setValue("123280","AGREEMENT");
		sapHead.setValue(new java.util.Date("03/27/2007"),"DOC_DATE");
		sapHead.setValue("A","DOC_TYPE");
		
		//log("Po Number >>>>>"+ header.getPoNumber(),"D");
		//log("Doc Type >>>>>"+ header.getDocType(),"D"); //A
		//log("Quotation >>>>>"+ header.getAgreement(),"D");
		//log("Quotation Date>>>>>"+ header.getDocDate(),"D");
		
		//log(">>>>>>FOR QUOTE POST Header Additional Structure Values","D");
		sapHeadAdd.setValue("CFR","INCOTERMS1");
		sapHeadAdd.setValue("COSTS AND FREIGHT","INCOTERMS2");
		sapHeadAdd.setValue("0001","PMNTTRMS");
						
		/*log("IncoTerms 1>>>>>"+headerAdd.getIncoterms1(),"D");
		//log("IncoTerms 2>>>>>"+headerAdd.getIncoterms2(),"D");
		///log("Pmnt terms>>>>> "+headerAdd.getPmnttrms(),"D");*/
		
		/*
		if(iParams.getObject("ezc.ezpurchase.params.EzBapiekpocTable")!=null)
		{			
			EzBapiekpocTable itemTable=null;
			EzBapiekpocTableRow itemTableRow=null;
			itemTable=(EzBapiekpocTable)iParams.getObject("ezc.ezpurchase.params.EzBapiekpocTable");
			
			int itmCount = itemTable.getRowCount();
			for(int i=0;i<itmCount;i++)
			{
				itemTableRow=(EzBapiekpocTableRow) itemTable.getRow(i);
				
				sapItemTableRow.setPoItem(itemTableRow.getPoItem());
				log(">>>>>>>>><<<<<<<<<<<<<<<<"+itemTableRow.getPoItem(),"D");
				sapItemTable.appendRow(sapItemTableRow);
			}
		}
		*/
		int count = 1;//condTable.getRowCount();
		//log(">>>>>>>>>>>>>>>>Conditions","D");
		for ( int i=0; i< count ; i++){
			
			//condRow = (EzBapicondTableRow) condTable.getRow(i);
			//sapCondRow.appendRow();
			/*if (condRow.getCondType() != null){
				sapCondRow.setValue(condRow.getCondType(),"COND_TYPE");
				log("CondType>>>"+condRow.getCondType(),"D");
			}	
			if (condRow.getItmNumberString() != null){
				sapCondRow.setValue(condRow.getItmNumberString(),"ITM_NUMBER");
				log("ItemNo>>>>>"+condRow.getItmNumberString(),"D");
			}	
			if (condRow.getCondvalueString() != null){
				sapCondRow.setValue(condRow.getCondvalueString(),"COND_VALUE");
				log("Condvalue>>"+condRow.getCondvalueString(),"D");
			}	
			if (condRow.getCurrency() != null){
				sapCondRow.setValue(condRow.getCurrency(),"CURRENCY");
				log("Currency>>>"+condRow.getCurrency(),"D");
			}	
			if (condRow.getCondclass() != null ){
				sapCondRow.setValue(condRow.getCondclass(),"CONDCLASS");
				log("CondClass>>"+condRow.getCondclass(),"D");
			}	
			if (condRow.getCondNo() != null){
				sapCondRow.setValue(condRow.getCondNo(),"COND_NO");
				log("CondNo>>>>>"+condRow.getCondNo(),"D");
			}*/
			/*sapCondRow.setValue("PBXX","COND_TYPE");
			sapCondRow.setValue("001","ITM_NUMBER");
			sapCondRow.setValue("100","COND_VALUE");
			sapCondRow.setValue("USD","CURRENCY");*/
			
			sapItemTable.appendRow();	
			sapItemTable.setValue("001","PO_ITEM");
			sapItemTable.setValue("2","NET_PRICE");
			sapItemTable.setValue("1","DISP_QUAN");
			
				

			
		}
	    	
		/*
		count = slltxTable.getRowCount();
		//log(">>>>>>>>>>>>>>>>Services Text","D");
		for ( int i=0; i< count ; i++){
			
			slltxRow = (EzBapieslltxTableRow) slltxTable.getRow(i);
			sapSlltx.appendRow();
			
			sapSlltxRow.setValue(slltxRow.getTextLine(),"TEXT_LINE");
			log("Text Line>>>>>>"+slltxRow.getTextLine(),"D");
			
			if (slltxRow.getLineNo() != null){
				sapSlltxRow.setValue(slltxRow.getLineNo(),"LINE_NO");
				log("Line No>>>>>>>>"+slltxRow.getLineNo(),"D");
			}	
			if(slltxRow.getTextId()!=null){
				sapSlltxRow.setValue(slltxRow.getTextId(),"TEXT_ID");
				log("Line No>>>>>>>>"+slltxRow.getTextId(),"D");
			}	
	      }*/
	      
	      try{
			client.execute(function);
	      }catch(Exception e){
			//return log(7002,"EzOpenGR :: postPODeliveryDates() ",e,"BE");
			out.println("Exception occurred while executing function>"+e);
	      }
	      //log("Befor Calling OP conversion class  ======== ","D");
	      //EzOpenGROutputConversion opConv=new EzOpenGROutputConversion();
	      // ReturnObjFromRetrieve retObj=(ReturnObjFromRetrieve)opConv.postQuotation(function);
	      ///log("ezOpenGR Output conversion Over  ======== ","D");
	      // log("Result OP>>>>>"+retObj.toEzcString(),"D");
	}
	catch (Exception e) 
	{
		out.println("Exception occurred while exe Params "+e);
		//log(" ***** EzOpenGR :: The Exception has Occured ---->" + e.getMessage(),"E");
		return ;//log(3001," EzOpenGR :: getOpenGRList() ",e,"E");

	}
	finally
	{
		out.println("After executing Function "+function);
		JCO.Table    ret = function.getTableParameterList().getTable("RETURN");
		int retCount = ret.getNumRows();
		if(retCount>0)
		{
			do
			{
				out.println("MSG>>"+ret.getValue("MESSAGE"));
				out.println("TYPE>>"+ret.getValue("TYPE"));
				out.println("CODE>>"+ret.getValue("MESSAGE_V2"));
				out.println("MSGNO>>"+ret.getValue("MESSAGE_V1"));
				

			}
			while(ret.nextRow());
		}
		
		if (client!=null){
			//log("R E L E A S I N G   C L I E N T .... ","D");
			JCO.releaseClient(client);
			client = null;
			function=null;
		}
	}
	
%>	
				
		

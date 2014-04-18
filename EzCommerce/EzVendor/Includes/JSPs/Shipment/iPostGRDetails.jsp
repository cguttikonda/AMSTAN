<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ page import ="ezc.ezparam.*,ezc.ezvendor.params.*,ezc.ezpreprocurement.params.*" %>
<%@ page import = "ezc.ezutil.FormatDate"%>
<%@ page import = "java.util.*"%>
<jsp:useBean id="VendorManager" class="ezc.ezvendor.client.EzVendorManager" scope="page" />
<%
	int    msgCount  	= 0;
	int    lastIndex 	= 0;
	
	String mainText 	= "";
	String tempText1	= "";
	String tempText2 	= "";
	String tempText3 	= "";
	if(text!=null || !"null".equals(text))
		mainText = text;
	
	ReturnObjFromRetrieve retObj = null;
	EziVendorParams eziVendorParams 	= new EziVendorParams();
	EzVendorTable ezVendorTable 		= new EzVendorTable();
	EzVendorTableRow ezVendorTableRow 	= null;
	EziPOHeaderTextTable 	textTable 	= new EziPOHeaderTextTable();
	EziPOHeaderTextTableRow textTableRow	= null;
		
	//out.println("dcnodcnodcnodcno>>>>>"+dcno+"**");
	eziVendorParams.setVendor((String)session.getValue("SOLDTO"));
	eziVendorParams.setPONumber(ponum);
	eziVendorParams.setModeOfTrans(dcno);
	eziVendorParams.setBLNumber(lrno) ;
	eziVendorParams.setDelivDate(ibd_exdate);
	eziVendorParams.setShipDate(ibd_shipdate) ;

	for(int i=0;i<line.length;i++)
	{
		//out.println("qty[i]::iPostGR:"+qty[i]);
		if(!("".equals(confKey[i]) || "null".equals(confKey[i]) || confKey[i]==null)){
			ezVendorTableRow = new EzVendorTableRow();
			if("".equals(qty[i]) || "null".equals(qty[i]) || qty[i]==null)
				ezVendorTableRow.setEntryQty("0");
			else
				ezVendorTableRow.setEntryQty(qty[i]);
			ezVendorTableRow.setPOItem(line[i]);
			ezVendorTable.appendRow(ezVendorTableRow);
		}	
	}
	
	while(mainText.length() > 130){
		
		tempText1 	= mainText.substring(0,130);
		tempText2 	= mainText.substring(130);
		lastIndex 	= tempText1.lastIndexOf(" ");
		if(lastIndex == -1){
			lastIndex = 130;
		}
		tempText3	= tempText1.substring(0,lastIndex);
		mainText	= tempText1.substring(lastIndex)+""+tempText2;
		
		textTableRow = new EziPOHeaderTextTableRow();
		textTableRow.setTextLine(tempText3);
		textTable.appendRow(textTableRow);
		//out.println("<BR>"+tempText3);
	}
	if(mainText.length()>0){
		
		textTableRow = new EziPOHeaderTextTableRow();
		textTableRow.setTextLine(mainText);
		textTable.appendRow(textTableRow);
	}
	/*
	for(int i=0;i<3;i++)
	{
		
		textTableRow = new EziPOHeaderTextTableRow();
		textTableRow.setTextLine("THIS IS TEXT LINE::>"+i);
			
		textTable.appendRow(textTableRow);
			
	}
	*/
	
	
	Date mfgDateToSAP = null;
	Date expDateToSAP = null;
	StringTokenizer batchesSAPST = null;
	EzShipmentSchedulesTable ezBatchesToSAPTable 	= new EzShipmentSchedulesTable();
	EzShipmentSchedulesTableRow ezLinesToSAPTableRow  = null;
	
	
	
	for(int s=0;s<count;s++)			//For lines
		{
			int j=0;
		
			if(batches[s]!=null && !"null".equals(batches[s]) && !"".equals(batches[s]))
			{
				j=0;
				batchesSAPST=new StringTokenizer(batches[s],"µ");
				String sbatches[]=new String[batchesSAPST.countTokens()];
				while(batchesSAPST.hasMoreTokens())
				{
					sbatches[j]=batchesSAPST.nextToken();
					ezc.ezcommon.EzLog4j.log("<<< sbatches[j] >>> "+sbatches[j],"I");	
					j++;
				}
				
				for(int k=0;k<sbatches.length;k++) //for no of batches in each line
				{
					ezLinesToSAPTableRow = new EzShipmentSchedulesTableRow();
					batchesSAPST=new StringTokenizer(sbatches[k],"§");
					String bat=batchesSAPST.nextToken();
					bat=(bat.equals("NA"))?"":(bat);
					String mfg= batchesSAPST.nextToken();
					mfg=(mfg.equals("NA"))?"":(dateConvertion(mfg,fdate));
					String exp=batchesSAPST.nextToken();
					exp=(exp.equals("NA"))?"":(dateConvertion(exp,fdate));
					String qtys=batchesSAPST.nextToken();
					
					
					ezc.ezcommon.EzLog4j.log("<<< Before Item No>>> "+line[s]+"<<ScheduleLine>>>"+(k+1)+"<<<BatchNo>>>"+bat+"<<<qtys>>>"+qtys+"<<<Manufacture Date>>>"+mfg+"<<<Expiration Date>>>"+exp,"I");	
					
					if(mfg!=null && !"".equals(mfg) && !"NA".equals(mfg)) 
					{
						ezc.ezcommon.EzLog4j.log("<<<Mfg Date In If >>>"+mfg,"I");	
						
						mfgDateToSAP =new Date(Integer.parseInt(mfg.substring(6,10))-1900,Integer.parseInt(mfg.substring(3,5))-1,Integer.parseInt(mfg.substring(0,2)));
						ezLinesToSAPTableRow.setMfgDateObj(mfgDateToSAP);
					}
					
					if(exp!=null && !"".equals(exp) && !"NA".equals(exp))
					{
						ezc.ezcommon.EzLog4j.log("<<<Expiration Date In If >>>"+exp,"I");
					
						expDateToSAP =new Date(Integer.parseInt(exp.substring(6,10))-1900,Integer.parseInt(exp.substring(3,5))-1,Integer.parseInt(exp.substring(0,2)));
						ezLinesToSAPTableRow.setExpDateObj(expDateToSAP);
					}						
					
					ezc.ezcommon.EzLog4j.log("<<<Item No>>> "+line[s]+"<<ScheduleLine>>>"+(k+1)+"<<<BatchNo>>>"+bat+"<<<qtys>>>"+qtys+"<<<Manufacture Date>>>"+mfgDateToSAP+"<<<Expiration Date>>>"+expDateToSAP,"I");	
					
					
					ezLinesToSAPTableRow.setLineNumber(line[s]);
					ezLinesToSAPTableRow.setScheduleLine(String.valueOf(k+1));
					ezLinesToSAPTableRow.setBatch(bat);
					ezLinesToSAPTableRow.setBatchQty(qtys);
					ezBatchesToSAPTable.appendRow(ezLinesToSAPTableRow);
				}
			}
	}
	
	
	
	EzcParams params = new EzcParams(false);
	params.setObject(eziVendorParams);
	params.setObject(ezVendorTable);
	params.setObject(textTable);
	params.setObject(ezBatchesToSAPTable);
	Session.prepareParams(params);
	retObj = (ReturnObjFromRetrieve)VendorManager.postIBD(params);
	
	if(retObj!=null){
		msgCount 	= retObj.getRowCount();  
		for(int i=0;i<msgCount;i++){
			
			msgNumber 	= retObj.getFieldValueString(i,"NUMBER");
			ibdStatus 	= retObj.getFieldValueString(i,"TYPE");
			
			if("311".equals(msgNumber) && "S".equalsIgnoreCase(ibdStatus)){
				ibdNo 	= retObj.getFieldValueString(i,"MESSAGE_V2");
				break;
			}else if("E".equalsIgnoreCase(ibdStatus)){
				ibdNo 	= retObj.getFieldValueString(i,"MESSAGE");
				break;
			}
		}
		if(msgCount==0){
			ibdStatus = "E";
			ibdNo = "Problem occured while creating Inbound Delivery.";
		}
	}
		
	
	
	ezc.ezcommon.EzLog4j.log("MY IBD KEYS>>>"+ibdStatus+"---->"+ibdNo,"I");
	///ezc.ezcommon.EzLog4j.log("--------------------------------------------","I");
	ezc.ezcommon.EzLog4j.log("MY CHK NUMBER>>>"+retObj.toEzcString(),"I");
%>

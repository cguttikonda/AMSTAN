<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="PreProMgr" class="ezc.ezpreprocurement.client.EzPreProcurementManager" />
<%@ page import="ezc.ezpreprocurement.params.*,ezc.ezutil.*,java.util.*,ezc.ezbasicutil.*,ezc.ezparam.*;" %>
<%!
	public String eliminateNewLineChar(String str)
	{
		char[] chars=str.toCharArray();
		for(int i=0;i<chars.length;i++)
		{
			char c=chars[i];
			int a=(int)c;
			
			if(a == 13) 
			{
				if(i<chars.length-1)
				{
					char c1=chars[i+1];
					int b=(int)c1;
					if(b == 10)
					{
						chars[i]=' ';
						chars[i+1]='¥';
					}
				}	
			}
			
		}
		
		String finalStr = new String(chars);
		return finalStr;
	}
	
	public EziPOHeaderTextTable getHeaderTextTab(EziPOHeaderTextTable headerTextTable,String headerText,String textId)
	{
		String[] notesAll = new String[]{headerText};
		EzStringTokenizer notesAllSt=null;
		int notesAllCt=0;
		String chkLin="";
		int strLength=0;
		int len=0;
		int rem=0;
		String cutLen="";
		String myLine="";
		EziPOHeaderTextTableRow hTextRow=null;
		
		for(int k=0;k<notesAll.length;k++)
		{
			
			myLine = eliminateNewLineChar(notesAll[k]);
			notesAllSt = new EzStringTokenizer(myLine,"¥");
			
			notesAllCt =notesAllSt.getTokens().size();
			if(notesAllCt == 0)
			{
				chkLin = notesAll[k];
				strLength = chkLin.length();
	
				if(strLength >130)
				{
					len = strLength / 130 ;
					rem = strLength % 130;
	
					for(int l=0;l<len;l++)
					{
						try
						{
							cutLen = chkLin.substring(130*l,130*(l+1));
						}
						catch(Exception e)
						{
							cutLen=chkLin.substring(130*l,chkLin.length());
						}
						
						hTextRow = new EziPOHeaderTextTableRow();
						hTextRow.setTextId(textId);					
						hTextRow.setTextForm("EN");
						hTextRow.setTextLine(cutLen);
						try{
							headerTextTable.appendRow(hTextRow);
						}catch(Exception err){}
					}
					if(rem > 0)
					{
						cutLen =chkLin.substring(130*len,strLength);
						hTextRow = new EziPOHeaderTextTableRow();
						hTextRow.setTextId(textId);					
						hTextRow.setTextForm("EN");
						hTextRow.setTextLine(cutLen);					
						try{
							headerTextTable.appendRow(hTextRow);
						}catch(Exception err){}
	
					}
				}
				else
				{
	
						hTextRow = new EziPOHeaderTextTableRow();
						hTextRow.setTextId(textId);					
						hTextRow.setTextForm("EN");
						hTextRow.setTextLine(cutLen);					
						try{
							headerTextTable.appendRow(hTextRow);
						}catch(Exception err){}
				}
	
			}
			else
			{
				for(int linall=0;linall<notesAllCt;linall++)
				{
					chkLin = (String)notesAllSt.getTokens().elementAt(linall);
					strLength = chkLin.length();
	
					if(strLength >130)
					{
						len = strLength / 130 ;
						rem = strLength % 130;
						for(int l=0;l<len;l++)
						{
							try{
								cutLen = chkLin.substring(130*l,130*(l+1));
							}catch(Exception e){cutLen=chkLin.substring(130*l,chkLin.length());}
							hTextRow = new EziPOHeaderTextTableRow();
							hTextRow.setTextId(textId);					
							hTextRow.setTextForm("EN");
							hTextRow.setTextLine(cutLen);					
							try{
								headerTextTable.appendRow(hTextRow);
							}catch(Exception err){}
						}
						if(rem > 0)
						{
							cutLen =chkLin.substring(130*len,strLength);
							hTextRow = new EziPOHeaderTextTableRow();
							hTextRow.setTextId(textId);					
							hTextRow.setTextForm("EN");
							hTextRow.setTextLine(cutLen);					
							try{
								headerTextTable.appendRow(hTextRow);
							}catch(Exception err){}
						}
					}
					else
					{
					
						hTextRow = new EziPOHeaderTextTableRow();
						hTextRow.setTextId(textId);					
						hTextRow.setTextForm("EN");
						hTextRow.setTextLine(chkLin);					
						try{
							headerTextTable.appendRow(hTextRow);
						}catch(Exception err){}			
					}
	
				}
			}
		}
		
		return headerTextTable;
	}
	
	public EziPOItemTextTable getItemTextTable(EziPOItemTextTable  itemTextTable,String itemText,String itemNo,String textId)
	{
		String[] notesAll = new String[]{itemText};
		EzStringTokenizer notesAllSt=null;
		int notesAllCt=0;
		String chkLin="";
		int strLength=0;
		int len=0;
		int rem=0;
		String cutLen = "";
		String myLine="";
		EziPOItemTextTableRow iTextRow = null;
		try{
		for(int k=0;k<notesAll.length;k++)
		{
			
			myLine = eliminateNewLineChar(notesAll[k]);
			notesAllSt = new EzStringTokenizer(myLine,"¥");
			
			notesAllCt =notesAllSt.getTokens().size();
			if(notesAllCt == 0)
			{
				chkLin = notesAll[k];
				strLength = chkLin.length();
	
				if(strLength >130)
				{
					len = strLength / 130 ;
					rem = strLength % 130;
	
					for(int l=0;l<len;l++)
					{
						try
						{
							cutLen = chkLin.substring(130*l,130*(l+1));
						}
						catch(Exception e)
						{
							cutLen=chkLin.substring(130*l,chkLin.length());
						}
						
						iTextRow = new EziPOItemTextTableRow();
						iTextRow.setPoItem(itemNo);
						iTextRow.setTextId(textId);					
						iTextRow.setTextForm("EN");
						iTextRow.setTextLine(cutLen);					
						itemTextTable.appendRow(iTextRow);
					}
					if(rem > 0)
					{
						cutLen =chkLin.substring(130*len,strLength);
						iTextRow = new EziPOItemTextTableRow();
						iTextRow.setPoItem(itemNo);
						iTextRow.setTextId(textId);					
						iTextRow.setTextForm("EN");
						iTextRow.setTextLine(cutLen);					
						itemTextTable.appendRow(iTextRow);
	
					}
				}
				else
				{
	
						iTextRow = new EziPOItemTextTableRow();
						iTextRow.setPoItem(itemNo);
						iTextRow.setTextId(textId);					
						iTextRow.setTextForm("EN");
						iTextRow.setTextLine(cutLen);					
						itemTextTable.appendRow(iTextRow);
				}
	
			}
			else
			{
				for(int linall=0;linall<notesAllCt;linall++)
				{
					chkLin = (String)notesAllSt.getTokens().elementAt(linall);
					strLength = chkLin.length();
	
					if(strLength >130)
					{
						len = strLength / 130 ;
						rem = strLength % 130;
						for(int l=0;l<len;l++)
						{
							try{
								cutLen = chkLin.substring(130*l,130*(l+1));
							}catch(Exception e){cutLen=chkLin.substring(130*l,chkLin.length());}
							iTextRow = new EziPOItemTextTableRow();
							iTextRow.setPoItem(itemNo);
							iTextRow.setTextId(textId);					
							iTextRow.setTextForm("EN");
							iTextRow.setTextLine(cutLen);					
							itemTextTable.appendRow(iTextRow);
						}
						if(rem > 0)
						{
							cutLen =chkLin.substring(130*len,strLength);
							iTextRow = new EziPOItemTextTableRow();
							iTextRow.setPoItem(itemNo);
							iTextRow.setTextId(textId);					
							iTextRow.setTextForm("EN");
							iTextRow.setTextLine(cutLen);					
							itemTextTable.appendRow(iTextRow);
						}
					}
					else
					{
					
						iTextRow = new EziPOItemTextTableRow();
						iTextRow.setPoItem(itemNo);
						iTextRow.setTextId(textId);					
						iTextRow.setTextForm("EN");
						iTextRow.setTextLine(chkLin);					
						itemTextTable.appendRow(iTextRow);				
					}
	
				}
			}
		}
		}catch(Exception err){}
		return itemTextTable;
	}
	
	
%>


<%
	String collRfqs[]=request.getParameterValues("collRFQNo");
	String collRfqStat[]=request.getParameterValues("collRFQStat");
	java.util.Hashtable openQCFHT=new java.util.Hashtable();
	java.util.Vector openRFQVect=new java.util.Vector();
	if(collRfqs!=null) {
		for(int i=0;i<collRfqs.length;i++){
			openQCFHT.put(collRfqs[i],collRfqStat[i]);
		}	
	}
	
	String purchOrg    = (String)Session.getUserPreference("PURORG");
	String purGrp      = (String)Session.getUserPreference("PURGROUP");
	
	String vendor[]=request.getParameterValues("vendor");
	String docType[]=request.getParameterValues("docType");
	String hbid[]=request.getParameterValues("hbId");
	String headerText[]=request.getParameterValues("headerText");
	String shipmentText[]=request.getParameterValues("shipmentText");
	String[]  rfqNumbers =null;
	
	
	EzcParams ezContainer =null;
	EziPOHeaderParams 	headerParams		= new EziPOHeaderParams();
	EziPOItemTable		itemTable		= new EziPOItemTable();	
	EziPOItemTableRow 	itemRow			= null;
	EziPOSchedTable 	schTable		= new EziPOSchedTable();
	EziPOSchedTableRow 	schRow			= null;
	EziPOCondTable 		condTable		= new EziPOCondTable();
	EziPOCondTableRow 	condRow			= null;
	EziPOHeaderTextTable 	headerTextTable 	= new EziPOHeaderTextTable();
	EziPOHeaderTextTableRow	hTextRow		= null;
	EziPOItemTextTable   	itemTextTable   	= new EziPOItemTextTable();
	EziPOItemTextTableRow	iTextRow		= null; 
	
	EziAuditTrailTable eziaudittable = new EziAuditTrailTable();
	EziAuditTrailTableRow eziaudittablerow = null; 
  
  	EziPartialPODetailsTable   	partialPODtlTab   	= new EziPartialPODetailsTable();
	EziPartialPODetailsTableRow	partialPODtlTabRow		= null; 
  
  	EziPartialPODetailsTable   	partialPODtlTabFinal   	= new EziPartialPODetailsTable();
	EziPartialPODetailsTableRow	partialPODtlTabRowFinal		= null; 
	
	java.util.Vector posVect=new java.util.Vector();
  	java.util.Vector posCollRFQVect=new java.util.Vector();
	java.util.Vector hbkIds=new java.util.Vector();
	java.util.Vector tobeclosedrfqs	= new java.util.Vector(); 
	java.util.Hashtable rfqpos	= new java.util.Hashtable(); 
	java.util.Hashtable poshash	= new java.util.Hashtable(); 
	java.util.Hashtable poDocTypeHT = new java.util.Hashtable(); 
  
 	 ezc.ezutil.FormatDate formatDate = new ezc.ezutil.FormatDate();
	
	ReturnObjFromRetrieve finalRet = new ReturnObjFromRetrieve(new String[]{"OBJ","VENDOR","RFQNO","COLLRFQ","PPTAB"});
	
	if(vendor!=null && vendor.length>0)
	{
	
		String rfqNo[]=null;
		String collNo[]=null;
		
		String rfqItem[]=null;
		String plant[]=null;
		String rfqQty[]=null;
		String penQty[]=null;
		String poQty[]=null;
		String delDate=null;
		String valType[]=null;
		String taxCode[]=null;
		String ccKey[]=null;
		String itemText[]=null;

		String rcMat[]=null;
		String rcMatDesc[]=null;
		String rcDelDt=null;
		String rcPOQty[]=null;
		String rcUOM[]=null;
		String rcPlant[]=null;
		String rcSLoc[]=null;
		String rcFOC[]=null;
		String rcValType[]=null;
		String rcTaxCode[]=null;
		String rcCCKey[]=null;
		String rcText[]=null;
    
    
    
		rfqNumbers=new String[vendor.length];
		
		
		
		for(int i=0;i<vendor.length;i++)
		{
		
			
			headerParams		= new EziPOHeaderParams();
			itemTable		= new EziPOItemTable();	
			schTable		= new EziPOSchedTable();
			condTable		= new EziPOCondTable();
			headerTextTable 	= new EziPOHeaderTextTable();
			itemTextTable   	= new EziPOItemTextTable();
			partialPODtlTab   	= new EziPartialPODetailsTable();
			
			
			
			
			
			
			headerParams.setCreatedOn(new Date());
			headerParams.setVendor(vendor[i]);
			headerParams.setDocType(docType[i]);
			
			try{
				headerTextTable=getHeaderTextTab(headerTextTable,headerText[i],"F01");
			}catch(Exception err){}	
			try{
				headerTextTable=getHeaderTextTab(headerTextTable,shipmentText[i],"F06");
			}catch(Exception err){}	
		
      
      
     			partialPODtlTab   	= new EziPartialPODetailsTable();
    
		
			rfqNo=request.getParameterValues("rfqNo"+i);
			collNo=request.getParameterValues("collRFQNo"+i);
			rfqItem=request.getParameterValues("rfqLine"+i);
			plant=request.getParameterValues("plant"+i);
			rfqQty=request.getParameterValues("rfqQty"+i);
			penQty=request.getParameterValues("pendQty"+i);
			poQty=request.getParameterValues("poQty"+i);
			
			valType=request.getParameterValues("valuationType"+i);
			taxCode=request.getParameterValues("taxCode"+i);
			ccKey=request.getParameterValues("ccKey"+i);
			itemText=request.getParameterValues("itemText"+i);

			rcMat=request.getParameterValues("rcMat"+i);
			rcMatDesc=request.getParameterValues("rcMatDesc"+i);

			rcPOQty=request.getParameterValues("rcPOQty"+i);
			rcUOM=request.getParameterValues("rcUOM"+i);
			rcPlant=request.getParameterValues("rcPlant"+i);
			rcSLoc=request.getParameterValues("rcSLoc"+i);
			rcFOC=request.getParameterValues("rcFOC"+i);
			rcValType=request.getParameterValues("rcValType"+i);
			rcTaxCode=request.getParameterValues("rcTaxCode"+i);
			rcCCKey=request.getParameterValues("rcCCKey"+i);
			rcText=request.getParameterValues("rcText"+i);

      
					
			String rfqNoTemp="";
			String collRFQTemp="";
			int myLineNo=0;
			if(rfqNo!=null&&rfqNo.length>0)
			{
				for(int j=0;j<rfqNo.length;j++){
					double qtyDoub=0;
					double penqtyDoub=0;
					double remQty=0;
					try{
						qtyDoub=Double.parseDouble(poQty[j]);
					}catch(Exception err){qtyDoub=0;}
					
					try{
						penqtyDoub=Double.parseDouble(penQty[j]);
					}catch(Exception err){penqtyDoub=0;}
					
					if(qtyDoub<penqtyDoub){
						openQCFHT.put(collNo[j],"N");
						if(!openRFQVect.contains(rfqNo[j])){
							openRFQVect.add(rfqNo[j]);
						}
					}

					if(qtyDoub==0){
						continue;
					}
          				remQty=penqtyDoub-qtyDoub;
					
					
          
					
					
					itemRow = new EziPOItemTableRow();	
					itemRow.setRFQNo(rfqNo[j]);
					itemRow.setQuantity(poQty[j]);
					itemRow.setPlant(plant[j]);
					if(ccKey!=null)
					itemRow.setConfCtrl(ccKey[j]);				
					itemRow.setTaxCode(taxCode[j]);				
					itemRow.setValType(valType[j]);				
					itemTable.appendRow(itemRow);
          
					schRow	= new EziPOSchedTableRow();
					
					delDate=request.getParameter("delDate"+i+""+j);
					if(delDate!=null){
						if((delDate).length()>9){

							int dd=Integer.parseInt(delDate.substring(0,2));
							int mm=Integer.parseInt(delDate.substring(3,5));
							int yy=Integer.parseInt(delDate.substring(6,10));
							GregorianCalendar g=new GregorianCalendar(yy,mm-1,dd);
							Date delDateObj= g.getTime();
							String dDate 	= formatDate.getStringFromDate(delDateObj,".",FormatDate.DDMMYYYY);
							schRow.setDelivDate(dDate);
						}
					}
         
					schRow.setQuantity(poQty[j]);
					schTable.appendRow(schRow);

					partialPODtlTabRow		=new EziPartialPODetailsTableRow(); 
					partialPODtlTabRow.setDocType("P");
					partialPODtlTabRow.setRFQNo(rfqNo[j]);
					partialPODtlTabRow.setItemNo(rfqItem[j]);
					partialPODtlTabRow.setPlant(plant[j]);
					partialPODtlTabRow.setOrdQty(poQty[j]);
					partialPODtlTabRow.setPendingQty(String.valueOf(remQty));
					partialPODtlTabRow.setCreatedBy(Session.getUserId());
					partialPODtlTab.appendRow(partialPODtlTabRow);
          
          
					if("".equals(rfqNoTemp)) rfqNoTemp=rfqNo[j];
					else rfqNoTemp +=","+rfqNo[j];
					
					if("".equals(collRFQTemp)) collRFQTemp=collNo[j];
					else collRFQTemp +="#"+collNo[j];
					
					
					rfqNumbers[i]=rfqNoTemp;
					myLineNo++;
					try{
						itemTextTable=getItemTextTable(itemTextTable,itemText[j],String.valueOf(((j+1)*10)),"F01");
						
					}catch(Exception err){}	
					
									
				}	
			}
			
      if(rcMat!=null)
      {
        try{
            for(int z=0;z<rcMat.length;z++)
            {
            
              if(rcMat[z]!=null && !"null".equals(rcMat[z])&& !"".equals((rcMat[z]).trim()))
              {
                itemRow = new EziPOItemTableRow();	
                String matnoTemp="000000000000000000"+rcMat[z];
                itemRow.setMaterial(matnoTemp.substring(matnoTemp.length()-18,matnoTemp.length()));
                itemRow.setUOM(rcUOM[z]);
                itemRow.setQuantity(rcPOQty[z]);
                itemRow.setPlant(rcPlant[z]);
                
                if(rcSLoc[z]!=null && !"null".equals(rcSLoc[z]) && !"".equals((rcSLoc[z]).trim()))
                itemRow.setSLoc(rcSLoc[z]);
                
                //if(rcFOC[z]!=null && !"null".equals(rcFOC[z]) && !"".equals((rcFOC[z]).trim()))
                //itemRow.setFOC(rcFOC[z]);
                
                itemRow.setPrice("0");
                if(rcCCKey!=null)
                itemRow.setConfCtrl(rcCCKey[z]);				
                itemRow.setTaxCode(rcTaxCode[z]);				
                itemRow.setValType(rcValType[z]);				
                itemTable.appendRow(itemRow);
                
                rcDelDt=request.getParameter("rcDelDt"+i+z);
                
                schRow	= new EziPOSchedTableRow();
                if((rcDelDt).length()>9){
      
                  int dd=Integer.parseInt(rcDelDt.substring(0,2));
                  int mm=Integer.parseInt(rcDelDt.substring(3,5));
                  int yy=Integer.parseInt(rcDelDt.substring(6,10));
                  GregorianCalendar g=new GregorianCalendar(yy,mm-1,dd);
                  Date delDateObj= g.getTime();
                  String dDate 	= formatDate.getStringFromDate(delDateObj,".",FormatDate.DDMMYYYY);
                  schRow.setDelivDate(dDate);
                }	
             
                schRow.setQuantity(rcPOQty[z]);
                schTable.appendRow(schRow);
            
              
                myLineNo++;
                itemTextTable=getItemTextTable(itemTextTable,rcText[z],String.valueOf(((myLineNo)*10)),"F01");
              } 
            }	
					}catch(Exception err){}
      }
			ezContainer = new EzcParams(true);
			ezContainer.setObject(headerParams);
			ezContainer.setObject(itemTable);
			ezContainer.setObject(schTable);
			ezContainer.setObject(condTable);
			ezContainer.setObject(headerTextTable);
			ezContainer.setObject(itemTextTable);
			Session.prepareParams(ezContainer);
			ReturnObjFromRetrieve createPORet = (ReturnObjFromRetrieve)PreProMgr.ezCreatePO(ezContainer);
			String myPoNum ="";

			if(createPORet!=null&&createPORet.getRowCount()>0){
				myPoNum =createPORet.getFieldValueString("PO_NUM");

				if(myPoNum!=null && !"null".equals(myPoNum) && !"".equals(myPoNum))
				{
					posVect.add(myPoNum);
					posCollRFQVect.add(collRFQTemp);
					
					if(hbid!=null)
						hbkIds.add(hbid[i]);
					else
						hbkIds.add("¥");
				}

				rfqpos.put(rfqNumbers[i],myPoNum);
				poshash.put(myPoNum,rfqNumbers[i]);
				poDocTypeHT.put(myPoNum,docType[i]);
			}




			finalRet.setFieldValue("OBJ",createPORet);
			finalRet.setFieldValue("VENDOR",vendor[i]);
			finalRet.setFieldValue("RFQNO",rfqNumbers[i]);
			finalRet.setFieldValue("COLLRFQ",collRFQTemp);
			finalRet.setFieldValue("PPTAB",partialPODtlTab);
			finalRet.addRow();
			
		}	
			
	
		
		
	
	
	}
	
	String retMessage ="";
	boolean closing=false;
	boolean prclose=true;
	int finalRetcnt = finalRet.getRowCount();
	String blnArr[] = new String[finalRetcnt];
	for(int x=0;x<finalRetcnt;x++)
	{	
		blnArr[x] = "F";
		String vend = finalRet.getFieldValueString(x,"VENDOR");		
		String tobecloserfq = finalRet.getFieldValueString(x,"RFQNO");
		String tobecollrfq = finalRet.getFieldValueString(x,"COLLRFQ");
		boolean flag =false;
		int cnt =1;

		ReturnObjFromRetrieve ret = (ReturnObjFromRetrieve )finalRet.getFieldValue(x,"OBJ");	

		retMessage += "Vendor: " +vend +"<br>";	
		for(int pc=0;pc<ret.getRowCount();pc++)
		{
			String errorType = ret.getFieldValueString(pc,"TYPE");
			if("E".equalsIgnoreCase(errorType))
			{
				retMessage = retMessage+cnt+"."+ret.getFieldValueString(pc,"MESSAGE")+"<br>";
				cnt++;
				flag = false;
				prclose = false;
				
				java.util.StringTokenizer myStk = new java.util.StringTokenizer(tobecollrfq,"#");
				while(myStk.hasMoreElements())
				{
					String myCollRFQNo = myStk.nextToken();
					
					if("Y".equals((String)openQCFHT.get(myCollRFQNo)))
					openQCFHT.put(myCollRFQNo,"N");
									
				}
				
				
			}
			else if("S".equalsIgnoreCase(errorType))
			{
				retMessage = retMessage + ret.getFieldValueString(pc,"MESSAGE");
				retMessage = retMessage + " Successfully"+"<br>";
				flag = true;
				closing=true;
        
				partialPODtlTab=(EziPartialPODetailsTable)finalRet.getFieldValue(x,"PPTAB");
				if(partialPODtlTab!=null){
					for(int p=0;p<partialPODtlTab.getRowCount();p++){
					partialPODtlTabRowFinal=(EziPartialPODetailsTableRow)partialPODtlTab.getRow(p);
					partialPODtlTabRowFinal.setDocNumber(ret.getFieldValueString("PO_NUM"));
					partialPODtlTabFinal.appendRow(partialPODtlTabRowFinal);

					}
				}
        
				
				
				java.util.StringTokenizer myStk = new java.util.StringTokenizer(tobecloserfq,",");
				while(myStk.hasMoreElements())
				{
					String myRFQNo = myStk.nextToken();
					if(!openRFQVect.contains(myRFQNo))
					{
						if(!tobeclosedrfqs.contains(myRFQNo)){
							tobeclosedrfqs.add(myRFQNo);
						}	
					}	
					
				}
				
			}
		}
		if(flag)
		{
			blnArr[x] = "T";

			ezc.ezupload.client.EzUploadManager ezUploadManager = new ezc.ezupload.client.EzUploadManager();
			EzcParams docMainParams = new EzcParams(true);
			ezc.ezupload.params.EziDocumentTextsTable ezidocumenttextstable = new ezc.ezupload.params.EziDocumentTextsTable();
			ezc.ezupload.params.EziDocumentTextsTableRow ezidocumenttextstablerow = new ezc.ezupload.params.EziDocumentTextsTableRow();
			ezidocumenttextstablerow.setDocType("QCFPO"+((new java.util.Date()).getTime()));
			ezidocumenttextstablerow.setDocNo(vend);
			ezidocumenttextstablerow.setSysKey("QCF_PO");
			ezidocumenttextstablerow.setKey("QCF_PO");
			ezidocumenttextstablerow.setValue(ret.getFieldValueString(0,"PO_NUM"));
			ezidocumenttextstable.appendRow(ezidocumenttextstablerow);
			docMainParams.setObject(ezidocumenttextstable);
			Session.prepareParams(docMainParams);
			ezUploadManager.addDocumentText(docMainParams);

		}
	}
	
	/*********This is for relasing POs in SAP********/
	for(int k=0;k<posVect.size();k++)
	{
		String myPo=(String)posVect.elementAt(k);
		if(myPo!=null && !"null".equals(myPo) && !"".equals(myPo))
		{
			EziPOHeaderParams 	hheaderParams		= new EziPOHeaderParams();
			String hbkId = "";
			if(!"¥".equals((String)hbkIds.elementAt(k)))
				hbkId = (String)hbkIds.elementAt(k);
			hheaderParams.setPONo(myPo);
			hheaderParams.setHouseBankId(hbkId);			//"ABNDB"
			hheaderParams.setRelFlag("Y");			
			EzcParams hpatchParams = new EzcParams(true);
			hpatchParams.setObject(hheaderParams);
			Session.prepareParams(hpatchParams);
		
			ReturnObjFromRetrieve reth = (ReturnObjFromRetrieve)PreProMgr.ezPOPostPatch(hpatchParams);
		
			java.util.StringTokenizer st1 = new java.util.StringTokenizer((String)posCollRFQVect.elementAt(k),"#");

			while(st1.hasMoreElements())
			{
				String colNoStr = st1.nextToken();
				ezc.ezparam.EzcParams historyMainParams = new ezc.ezparam.EzcParams(false);
				historyMainParams.setLocalStore("Y");
				ezc.ezpreprocurement.params.EziWFAuditTrailParams eziWFHistoryParams= new ezc.ezpreprocurement.params.EziWFAuditTrailParams();
				eziWFHistoryParams.setEwhDocId(colNoStr);
				historyMainParams.setObject(eziWFHistoryParams);
				Session.prepareParams(historyMainParams);
				ezc.ezparam.ReturnObjFromRetrieve wfMyRet = (ezc.ezparam.ReturnObjFromRetrieve)PreProMgr.ezGetWFAuditTrailNo(historyMainParams);
				String historyNo = "";
				if(wfMyRet != null)
				{
					historyNo = wfMyRet.getFieldValueString(0,"AUDIT_NO");
					if(historyNo == "null")
						historyNo = "1";
				}
				else
					historyNo = "1";
				eziWFHistoryParams.setEwhAuditTrailNo(historyNo);
				eziWFHistoryParams.setEwhDocId(colNoStr);
				eziWFHistoryParams.setEwhType("");
				eziWFHistoryParams.setEwhSourceParticipant((String)Session.getUserId());
				eziWFHistoryParams.setEwhSourceParticipantType("");
				eziWFHistoryParams.setEwhDestParticipant("");
				eziWFHistoryParams.setEwhDestParticipantType("");
				ezc.ezutil.FormatDate fd = new ezc.ezutil.FormatDate();	
				String strDate = fd.getStringFromDate(new Date(),".",ezc.ezutil.FormatDate.DDMMYYYY);				
				String POComments = "PO :"+myPo+ " Created on "+strDate+" wrt RFQ :"+(String)poshash.get(myPo); 
				eziWFHistoryParams.setEwhComments(POComments);
				historyMainParams.setObject(eziWFHistoryParams);
				Session.prepareParams(historyMainParams);
				PreProMgr.ezAddWFAuditTrail(historyMainParams);
			}
			
			
			ezContainer = new ezc.ezparam.EzcParams(true);
			eziaudittable = new EziAuditTrailTable();
			eziaudittablerow = new EziAuditTrailTableRow(); 
			eziaudittablerow.setDocId(myPo);
			eziaudittablerow.setDocType((String)poDocTypeHT.get(myPo));
			eziaudittablerow.setDocCategory("F");
			eziaudittablerow.setUserName(Session.getUserId());
			eziaudittablerow.setFMName("BAPI_PO_CREATE1");
			eziaudittablerow.setIPAddress(request.getRemoteAddr());
			eziaudittablerow.setPurOrg(purchOrg);
			eziaudittablerow.setPurGrp(purGrp);
			eziaudittablerow.setComments("PO has been created and released");
			eziaudittablerow.setChangeInd("I");
			eziaudittable.appendRow(eziaudittablerow);
			
			/*
			eziaudittablerow = new EziAuditTrailTableRow(); 
			eziaudittablerow.setDocId(myPo);
			eziaudittablerow.setDocType((String)poDocTypeHT.get(myPo));
			eziaudittablerow.setDocCategory("F");
			eziaudittablerow.setUserName(Session.getUserId());
			eziaudittablerow.setFMName("BAPI_PO_RELEASE");
			eziaudittablerow.setIPAddress(request.getRemoteAddr());
			eziaudittablerow.setPurOrg(purchOrg);
			eziaudittablerow.setPurGrp(purGrp);
			eziaudittablerow.setComments("PO has been released");
			eziaudittablerow.setChangeInd("U");
			eziaudittable.appendRow(eziaudittablerow);
			*/
		
			ezContainer.setObject(eziaudittable);
			Session.prepareParams(ezContainer);
			PreProMgr.ezAddAuditTrail(ezContainer);

			
		}	
	}	
	/*********End  for relasing POs in SAP********/
	
	if(closing)
	{

		/*****For Put  Rank Status and PO Nos RFQ wise *****/
		ezc.ezparam.EzcParams rfqezcparams				     	= new ezc.ezparam.EzcParams(false);
		ezc.ezpreprocurement.params.EziRFQHeaderTable ezirfqheadertable 	= new ezc.ezpreprocurement.params.EziRFQHeaderTable();
		String reasons="",RFQString="",rfqNmbrs = "" ;
		
		for(int i=0;i<rfqNumbers.length;i++)
		{
			if("T".equals(blnArr[i]))
			{
				java.util.StringTokenizer stk = new java.util.StringTokenizer(rfqNumbers[i],",");
				while(stk.hasMoreElements())
				{
					rfqNmbrs = stk.nextToken();
					ezc.ezpreprocurement.params.EziRFQHeaderTableRow ezirfqheadertablerow   = new ezc.ezpreprocurement.params.EziRFQHeaderTableRow();
					ezirfqheadertablerow.setRFQNo(rfqNmbrs); 		
					ezirfqheadertablerow.setRankStatus("L1");
					ezirfqheadertablerow.setPOorCon("P");
					ezirfqheadertablerow.setPONo((String)rfqpos.get(rfqNumbers[i])); 
					ezirfqheadertablerow.setModifiedBy(Session.getUserId()); 
					ezirfqheadertable.appendRow(ezirfqheadertablerow);
					RFQString = RFQString+"','"+rfqNmbrs;

				}		
			}	
		}	

		rfqezcparams.setObject(ezirfqheadertable);
		rfqezcparams.setObject(partialPODtlTabFinal);
		rfqezcparams.setLocalStore("Y");
		Session.prepareParams(rfqezcparams);
		PreProMgr.ezUpdateRFQ(rfqezcparams);

		/**********/		
		/**** For Close Related PRs ******/
		if(prclose)
		{
			ezc.ezparam.EzcParams 			       prezcparams	  = new ezc.ezparam.EzcParams(false);
			ezc.ezpreprocurement.params.EziRFQHeaderParams ezirfqheaderparams = new ezc.ezpreprocurement.params.EziRFQHeaderParams();
			ezirfqheaderparams.setRFQNo(RFQString);
			ezirfqheaderparams.setSysKey((String)session.getValue("SYSKEY"));
			prezcparams.setObject(ezirfqheaderparams);
			prezcparams.setLocalStore("Y");
			Session.prepareParams(prezcparams);

			ezc.ezpreprocurement.params.EzoRFQHeaderParams ezorfqheaderparams = (ezc.ezpreprocurement.params.EzoRFQHeaderParams)PreProMgr.ezGetRFQDetails(prezcparams);
			ezc.ezparam.ReturnObjFromRetrieve rfqHeader  = (ezc.ezparam.ReturnObjFromRetrieve)ezorfqheaderparams.getRFQHeader();

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
				ezc.ezparam.ReturnObjFromRetrieve myRet = (ezc.ezparam.ReturnObjFromRetrieve)PreProMgr.ezClosePR(prcloseParams);
			}
			catch(Exception e)
			{
				System.out.println("Exception Occured in ClosePR.jsp"+e.getMessage());
			}
		}	
		/***********/

		/**** For Close All RFQs ******/	
		ezc.ezparam.EzcParams closeezcparams				     	= new ezc.ezparam.EzcParams(false);
		ezc.ezpreprocurement.params.EziRFQHeaderTable closeezirfqheadertable	= new ezc.ezpreprocurement.params.EziRFQHeaderTable();
		ezc.ezpreprocurement.params.EziRFQHeaderTableRow closeezirfqheadertablerow   = new ezc.ezpreprocurement.params.EziRFQHeaderTableRow();

		int tobeclosedvectcnt = tobeclosedrfqs.size();
		String tobeclosedrfqStr ="";
		for(int i=0;i<tobeclosedvectcnt;i++)
		{
			tobeclosedrfqStr+=",'"+tobeclosedrfqs.elementAt(i)+"'";
		}
		if(tobeclosedrfqStr.length() >0)
			tobeclosedrfqStr=tobeclosedrfqStr.substring(2,tobeclosedrfqStr.length()-1);

		if(collRfqs!=null && collRfqs.length>0)
		{//If All POs created successfully closed by passing collective rfq number
			for(int z=0;z<collRfqs.length;z++)
			{

				if("Y".equals((String)openQCFHT.get(collRfqs[z])))
				{
			
					closeezirfqheadertablerow.setCollectiveRFQNo(collRfqs[z]);
					closeezirfqheadertablerow.setStatus("C"); 
					closeezirfqheadertablerow.setModifiedBy(Session.getUserId()); 
					closeezirfqheadertable.appendRow(closeezirfqheadertablerow);

					closeezcparams.setObject(closeezirfqheadertable);
					closeezcparams.setLocalStore("Y");
					Session.prepareParams(closeezcparams);
					PreProMgr.ezUpdateRFQ(closeezcparams);
					
					
					// for deleting the job once all the POs were created Successfully against QCF
					try
					{			
						ezc.ezworkflow.client.EzWorkFlowManager ezWorkFlowManager = new ezc.ezworkflow.client.EzWorkFlowManager();
						ezc.ezparam.EzcParams wfMainParams = new ezc.ezparam.EzcParams(false);
						ezc.ezworkflow.params.EziWFDocHistoryParams wfParams= new ezc.ezworkflow.params.EziWFDocHistoryParams();
						wfParams.setAuthKey("QCF_RELEASE");
						wfParams.setSysKey((String)session.getValue("SYSKEY"));
						wfParams.setDocId(collRfqs[z]);
						wfParams.setSoldTo("0");
						wfMainParams.setObject(wfParams);
						Session.prepareParams(wfMainParams);
						ezc.ezparam.ReturnObjFromRetrieve wfDetailsRet=(ezc.ezparam.ReturnObjFromRetrieve)ezWorkFlowManager.getWFDocDetails(wfMainParams);	
						int wfDetailCount = 0;
						String initiator = "";
						if(wfDetailsRet!= null)
						{
							wfDetailCount = wfDetailsRet.getRowCount();
							String nextParticipant	= wfDetailsRet.getFieldValueString(wfDetailsRet.getRowCount()-1,"NEXTPARTICIPANT");

							ReturnObjFromRetrieve escltdRet = new ReturnObjFromRetrieve(new String[]{"PARTICIPANT","PARTICIPANT_TYPE","ROLE","STATUS","SYSKEY","DOCID","TEMPLATE","AUTHKEY","MODIFIEDBY","ACTIONCODE","DELPARTICIPANT","DELPARTICIPANTTYPE","ADDORUPDATE","PREVPARTICIPANT","PREVPARTICIPANT_TYPE","INITIATOR","WFTYPE","MAIL_EXTS","COMMENTS"});
							escltdRet.setFieldValue("PARTICIPANT"		,	nextParticipant);
							escltdRet.setFieldValue("PARTICIPANT_TYPE"	,	"");
							escltdRet.setFieldValue("ROLE"			,	"");
							escltdRet.setFieldValue("STATUS"			,	"");
							escltdRet.setFieldValue("SYSKEY"			,	"");
							escltdRet.setFieldValue("DOCID"			,	collRfqs[z]);
							escltdRet.setFieldValue("TEMPLATE"		,	"");
							escltdRet.setFieldValue("AUTHKEY"		,	"");
							escltdRet.setFieldValue("MODIFIEDBY"		,	"");
							escltdRet.setFieldValue("ACTIONCODE"		,	"");
							escltdRet.setFieldValue("DELPARTICIPANT"		,	"");
							escltdRet.setFieldValue("DELPARTICIPANTTYPE"	,	"");
							escltdRet.setFieldValue("ADDORUPDATE"		,	"UPDATE");
							escltdRet.setFieldValue("PREVPARTICIPANT"	,	nextParticipant);
							escltdRet.setFieldValue("PREVPARTICIPANT_TYPE"	,	"");
							escltdRet.setFieldValue("INITIATOR"		,	"");
							escltdRet.setFieldValue("WFTYPE"			,	"");
							escltdRet.setFieldValue("MAIL_EXTS"		,	"");
							escltdRet.setFieldValue("COMMENTS"		,	"");
							escltdRet.addRow();
							ezWorkFlowManager.doEscalate(escltdRet,wfMainParams);
						}
					}catch(Exception ex)
					{
						System.out.println("While Deleting the Scheduled Job");
						ex.printStackTrace();
					}
				}
			}
			

			
			
		}
		if(!"".equals(tobeclosedrfqStr))
		{

			closeezirfqheadertablerow.setRFQNo(tobeclosedrfqStr); 
			closeezirfqheadertablerow.setStatus("C"); 
			closeezirfqheadertablerow.setModifiedBy(Session.getUserId()); 
			closeezirfqheadertable.appendRow(closeezirfqheadertablerow);

			closeezcparams.setObject(closeezirfqheadertable);
			closeezcparams.setLocalStore("Y");
			Session.prepareParams(closeezcparams);
			PreProMgr.ezUpdateRFQ(closeezcparams);

		}
		/**********/	
		if(collRfqs!=null && collRfqs.length>0)
		{
		
			ezc.ezparam.EzcParams historyMainParams = new ezc.ezparam.EzcParams(false);

			for(int z=0;z<collRfqs.length;z++)
			{
			
				if("Y".equals((String)openQCFHT.get(collRfqs[z])))
				{
					
						
					historyMainParams.setLocalStore("Y");
					ezc.ezpreprocurement.params.EziWFAuditTrailParams eziWFHistoryParams= new ezc.ezpreprocurement.params.EziWFAuditTrailParams();
					eziWFHistoryParams.setEwhDocId(collRfqs[z]);
					historyMainParams.setObject(eziWFHistoryParams);
					Session.prepareParams(historyMainParams);
					ezc.ezparam.ReturnObjFromRetrieve wfMyRet = (ezc.ezparam.ReturnObjFromRetrieve)PreProMgr.ezGetWFAuditTrailNo(historyMainParams);
					String historyNo = "";
					if(wfMyRet != null)
					{
						historyNo = wfMyRet.getFieldValueString(0,"AUDIT_NO");
						if(historyNo == "null")
							historyNo = "1";
					}
					else
						historyNo = "1";
					eziWFHistoryParams.setEwhAuditTrailNo(historyNo);
					eziWFHistoryParams.setEwhDocId(collRfqs[z]);
					eziWFHistoryParams.setEwhType("QCF_CLOSED");
					eziWFHistoryParams.setEwhSourceParticipant((String)Session.getUserId());
					eziWFHistoryParams.setEwhSourceParticipantType("");
					eziWFHistoryParams.setEwhDestParticipant("");
					eziWFHistoryParams.setEwhDestParticipantType("");
					eziWFHistoryParams.setEwhComments(reasons);
					historyMainParams.setObject(eziWFHistoryParams);
					Session.prepareParams(historyMainParams);
					PreProMgr.ezAddWFAuditTrail(historyMainParams);
					
				}
			}	
		}	
	}


%>


<html>
<head>
<title>
Message
</title>
<%@ include file="../../../Includes/Jsps/Misc/iblockcontrol.jsp" %>
<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
</script>
<script>
function poOk()
{
  
	document.location.href="ezWFListApprovedQcfs.jsp?Type=APPROVED&EDIT=T"
	

}
</script>
<script language="Javascript1.2">
	am = "This function is disabled!";
	bV  = parseInt(navigator.appVersion)
	bNS = navigator.appName=="Netscape"
	bIE = navigator.appName=="Microsoft Internet Explorer"
	function nrc(e) 
	{
	   if (bNS && e.which > 1)
	   {
	      alert(am)
	      return false
	   } 
	   else if (bIE && (event.button >1)) 
	   {
	     alert(am)
	     return false;
	   }
	}
	document.onmousedown = nrc;
	if (document.layers) window.captureEvents(Event.MOUSEDOWN);
	if (bNS  && bV<5) window.onmousedown = nrc;
	
</script>
</head>
<body bgcolor="#FFFFF7">
<Form name=myForm>
<%
	String display_header = "";
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<br>
<br>
<br>
<table width="70%" align="center" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1>
  <tr align="center">
    <th align="left"><%=retMessage%></th>
  </tr>
</table>
<br><br>
<center>
<%          
		butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ok&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");  
    butActions.add("poOk()");
    out.println(getButtons(butNames,butActions)); 
%>    
</center>
<Div id="MenuSol"></Div>
</Form>
</body>
</html>
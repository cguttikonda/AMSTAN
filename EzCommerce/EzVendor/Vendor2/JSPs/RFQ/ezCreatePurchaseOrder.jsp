<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="Manager" class="ezc.ezpreprocurement.client.EzPreProcurementManager" />
<%@ page import="ezc.ezpreprocurement.params.*,java.util.*,ezc.ezbasicutil.*,ezc.ezparam.*;" %>
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
%>

<%

	java.util.Vector rfqNos		=new java.util.Vector(); 
	java.util.Vector tobeclosedrfqs	=new java.util.Vector(); 
	java.util.Hashtable rfqpos	=new java.util.Hashtable(); 
	java.util.Hashtable poshash	=new java.util.Hashtable(); 

	String POorCon	 = "P";

	String        collNo 	 = request.getParameter("collectiveRFQNo");
	String[]      rfqNumbers = request.getParameterValues("rfqNumbers");
	
	String vendor[]          = request.getParameterValues("vendor"); 
	String docType[]	 = request.getParameterValues("docType");
	String confCtrl[]	 = request.getParameterValues("ccKey");	
	String houseBnkId[]	 = request.getParameterValues("hbId");	
	String valType[]	 = request.getParameterValues("valuationType");
	
	String shipInstr[]	 = request.getParameterValues("shipInstr");
	
	String taxCode[]	 = request.getParameterValues("taxCode");
	String headerText[]	 = request.getParameterValues("headerText");
	String itemText[]	 = request.getParameterValues("itemText");
	
	ReturnObjFromRetrieve finalRet = new ReturnObjFromRetrieve(new String[]{"OBJ","VENDOR","RFQNO"});

	int myRetCount  = 0;
	if(vendor!=null)
		myRetCount  = vendor.length;
		
	
	java.util.Vector posVect=new java.util.Vector();
	java.util.Vector hbkIds=new java.util.Vector();
	for(int i=0;i<myRetCount;i++)
	{

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

		headerParams.setCreatedOn(new Date());			//"04/25/2005"	
		//headerParams.setCreatedBy(Session.getUserId());		//"SWAMINATHN"
		headerParams.setVendor(vendor[i]);			//"1100000887"
		headerParams.setDocType(docType[i]);			//"ZRMI"

		String cckey = "";
		if(confCtrl!=null)
			cckey = confCtrl[i];

		String tax = "";
		if(taxCode!=null)
			tax = taxCode[i];

		String val = "";
		if(valType!=null)
			val = valType[i];
		
		String rfqsStr =  rfqNumbers[i];
		java.util.StringTokenizer str = new java.util.StringTokenizer(rfqsStr,",");
		
		while(str.hasMoreElements())
		{
			String rfqNum = str.nextToken();
			rfqNos.add(rfqNum);			
			itemRow = new EziPOItemTableRow();	
			itemRow.setRFQNo(rfqNum);
			itemRow.setConfCtrl(cckey);				//"0001"
			itemRow.setTaxCode(tax);				//"AA"
			itemRow.setValType(val);				//"OGL FOR RM"
			itemTable.appendRow(itemRow);
		}	
		
/*		StringTokenizer strk = new StringTokenizer(headerText[i],"\n");
		while(strk.hasMoreElements())
		{
			hTextRow = new EziPOHeaderTextTableRow();
			hTextRow.setTextId("F01");					//"F01" for Header Text. 
			hTextRow.setTextForm("EN");
			//hTextRow.setTextLine(headerText[i]);				//"Header Text Testing"
			hTextRow.setTextLine(strk.nextToken());
			headerTextTable.appendRow(hTextRow);
		}	
		
		strk = new StringTokenizer(shipInstr[i],"\n");
		while(strk.hasMoreElements())
		{
			hTextRow = new EziPOHeaderTextTableRow();
			hTextRow.setTextId("F06");					//"F06" for Shipping
			hTextRow.setTextForm("EN");
			//hTextRow.setTextLine(shipInstr[i]);				//"Header Text Testing"
			hTextRow.setTextLine(strk.nextToken());
			headerTextTable.appendRow(hTextRow);
		}	

		strk = new StringTokenizer(itemText[i],"\n");
		while(strk.hasMoreElements())
		{
			iTextRow = new EziPOItemTextTableRow();
			iTextRow.setPoItem("10");
			iTextRow.setTextId("F01");	
			iTextRow.setTextForm("EN");
			//iTextRow.setTextLine(itemText[i]);				//"Item Text Testing"
			iTextRow.setTextLine(strk.nextToken());
			itemTextTable.appendRow(iTextRow);
		}	

*/

	String myLine="";

/***********Header Text Start*********/
{
	String[] notesAll = new String[]{headerText[i]};
	EzStringTokenizer notesAllSt=null;
	int notesAllCt=0;
	String chkLin="";
	int strLength=0;
	int len=0;
	int rem=0;
	String cutLen = "";
	
	for(int k=0;k<notesAll.length;k++)
	{
		//notesAllSt = new EzStringTokenizer(notesAll[k],"\n");
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
					hTextRow.setTextId("F01");					
					hTextRow.setTextForm("EN");
					hTextRow.setTextLine(cutLen);					
					headerTextTable.appendRow(hTextRow);
				}
				if(rem > 0)
				{
					cutLen =chkLin.substring(130*len,strLength);
					hTextRow = new EziPOHeaderTextTableRow();
					hTextRow.setTextId("F01");					
					hTextRow.setTextForm("EN");
					hTextRow.setTextLine(cutLen);					
					headerTextTable.appendRow(hTextRow);

				}
			}
			else
			{

					hTextRow = new EziPOHeaderTextTableRow();
					hTextRow.setTextId("F01");					
					hTextRow.setTextForm("EN");
					hTextRow.setTextLine(cutLen);					
					headerTextTable.appendRow(hTextRow);
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
						hTextRow.setTextId("F01");					
						hTextRow.setTextForm("EN");
						hTextRow.setTextLine(cutLen);					
						headerTextTable.appendRow(hTextRow);
					}
					if(rem > 0)
					{
						cutLen =chkLin.substring(130*len,strLength);
						hTextRow = new EziPOHeaderTextTableRow();
						hTextRow.setTextId("F01");					
						hTextRow.setTextForm("EN");
						hTextRow.setTextLine(cutLen);					
						headerTextTable.appendRow(hTextRow);
					}
				}
				else
				{
				
					hTextRow = new EziPOHeaderTextTableRow();
					hTextRow.setTextId("F01");					
					hTextRow.setTextForm("EN");
					hTextRow.setTextLine(chkLin);					
					headerTextTable.appendRow(hTextRow);				
				}

			}
		}
	}
}
/*******Header Text End*********/
/*******ShipText Start*************/
{
	String[] notesAll = new String[]{shipInstr[i]};
	EzStringTokenizer notesAllSt=null;
	int notesAllCt=0;
	String chkLin="";
	int strLength=0;
	int len=0;
	int rem=0;
	String cutLen = "";
	for(int k=0;k<notesAll.length;k++)
	{
		//notesAllSt = new EzStringTokenizer(notesAll[k],"\n");
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
					hTextRow.setTextId("F06");					
					hTextRow.setTextForm("EN");
					hTextRow.setTextLine(cutLen);					
					headerTextTable.appendRow(hTextRow);
				}
				if(rem > 0)
				{
					cutLen =chkLin.substring(130*len,strLength);
					hTextRow = new EziPOHeaderTextTableRow();
					hTextRow.setTextId("F06");					
					hTextRow.setTextForm("EN");
					hTextRow.setTextLine(cutLen);					
					headerTextTable.appendRow(hTextRow);

				}
			}
			else
			{

					hTextRow = new EziPOHeaderTextTableRow();
					hTextRow.setTextId("F06");					
					hTextRow.setTextForm("EN");
					hTextRow.setTextLine(cutLen);					
					headerTextTable.appendRow(hTextRow);
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
						hTextRow.setTextId("F06");					
						hTextRow.setTextForm("EN");
						hTextRow.setTextLine(cutLen);					
						headerTextTable.appendRow(hTextRow);
					}
					if(rem > 0)
					{
						cutLen =chkLin.substring(130*len,strLength);
						hTextRow = new EziPOHeaderTextTableRow();
						hTextRow.setTextId("F06");					
						hTextRow.setTextForm("EN");
						hTextRow.setTextLine(cutLen);					
						headerTextTable.appendRow(hTextRow);
					}
				}
				else
				{
				
					hTextRow = new EziPOHeaderTextTableRow();
					hTextRow.setTextId("F06");					
					hTextRow.setTextForm("EN");
					hTextRow.setTextLine(chkLin);					
					headerTextTable.appendRow(hTextRow);				
				}

			}
		}
	}
}
/*********ShipText End***********/
/*********Item Text Start***********/
{
	String[] notesAll = new String[]{itemText[i]};
	EzStringTokenizer notesAllSt=null;
	int notesAllCt=0;
	String chkLin="";
	int strLength=0;
	int len=0;
	int rem=0;
	String cutLen = "";
	for(int k=0;k<notesAll.length;k++)
	{
		//notesAllSt = new EzStringTokenizer(notesAll[k],"\n");
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
					iTextRow.setPoItem("10");
					iTextRow.setTextId("F01");					
					iTextRow.setTextForm("EN");
					iTextRow.setTextLine(cutLen);					
					itemTextTable.appendRow(iTextRow);
				}
				if(rem > 0)
				{
					cutLen =chkLin.substring(130*len,strLength);
					iTextRow = new EziPOItemTextTableRow();
					iTextRow.setPoItem("10");
					iTextRow.setTextId("F01");					
					hTextRow.setTextForm("EN");
					iTextRow.setTextLine(cutLen);					
					itemTextTable.appendRow(iTextRow);

				}
			}
			else
			{

					iTextRow = new EziPOItemTextTableRow();
					iTextRow.setPoItem("10");
					iTextRow.setTextId("F01");					
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
						iTextRow.setPoItem("10");
						iTextRow.setTextId("F01");					
						iTextRow.setTextForm("EN");
						iTextRow.setTextLine(cutLen);					
						itemTextTable.appendRow(iTextRow);
					}
					if(rem > 0)
					{
						cutLen =chkLin.substring(130*len,strLength);
						iTextRow = new EziPOItemTextTableRow();
						iTextRow.setPoItem("10");
						iTextRow.setTextId("F01");					
						iTextRow.setTextForm("EN");
						iTextRow.setTextLine(cutLen);					
						itemTextTable.appendRow(iTextRow);
					}
				}
				else
				{
				
					iTextRow = new EziPOItemTextTableRow();
					iTextRow.setPoItem("10");
					iTextRow.setTextId("F01");					
					iTextRow.setTextForm("EN");
					iTextRow.setTextLine(chkLin);					
					itemTextTable.appendRow(iTextRow);				
				}

			}
		}
	}
}
/**********Item Text End**********/

		EzcParams mainParams = new EzcParams(true);
		mainParams.setObject(headerParams);
		mainParams.setObject(itemTable);
		mainParams.setObject(schTable);
		mainParams.setObject(condTable);
		mainParams.setObject(headerTextTable);
		mainParams.setObject(itemTextTable);

		Session.prepareParams(mainParams);
		ReturnObjFromRetrieve ret = (ReturnObjFromRetrieve)Manager.ezCreatePO(mainParams);
/***************/
		String po = ret.getFieldValueString("PO_NUM");

		if(po!=null && !"null".equals(po) && !"".equals(po))
		{
			posVect.add(po);
			if(houseBnkId!=null)
				hbkIds.add(houseBnkId[i]);
			else
				hbkIds.add("¥");
		}		
/***************/
		
		rfqpos.put(rfqNumbers[i],ret.getFieldValueString("PO_NUM"));
		poshash.put(ret.getFieldValueString("PO_NUM"),rfqNumbers[i]);
		finalRet.setFieldValue("OBJ",ret);
		finalRet.setFieldValue("VENDOR",vendor[i]);
		finalRet.setFieldValue("RFQNO",rfqNumbers[i]);
		finalRet.addRow();
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
			}
			else if("S".equalsIgnoreCase(errorType))
			{
				retMessage = retMessage + ret.getFieldValueString(pc,"MESSAGE");
				retMessage = retMessage + " Successfully"+"<br>";
				flag = true;
				closing=true;
				
				if(!tobeclosedrfqs.contains(tobecloserfq))
					tobeclosedrfqs.add(tobecloserfq);
					
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
			
			ReturnObjFromRetrieve reth = (ReturnObjFromRetrieve)Manager.ezPOPostPatch(hpatchParams);
		//reth = (ReturnObjFromRetrieve)Manager.ezPOPostPatch(hpatchParams);	
				
		
			java.util.StringTokenizer st1 = new java.util.StringTokenizer(collNo,"#");

			while(st1.hasMoreElements())
			{
				String colNoStr = st1.nextToken();
				ezc.ezparam.EzcParams historyMainParams = new ezc.ezparam.EzcParams(false);
				historyMainParams.setLocalStore("Y");
				ezc.ezpreprocurement.params.EziWFAuditTrailParams eziWFHistoryParams= new ezc.ezpreprocurement.params.EziWFAuditTrailParams();
				eziWFHistoryParams.setEwhDocId(colNoStr);
				historyMainParams.setObject(eziWFHistoryParams);
				Session.prepareParams(historyMainParams);
				ezc.ezparam.ReturnObjFromRetrieve wfMyRet = (ezc.ezparam.ReturnObjFromRetrieve)Manager.ezGetWFAuditTrailNo(historyMainParams);
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
				Manager.ezAddWFAuditTrail(historyMainParams);
			}
		}	
	}	
	
	/*********End  for relasing POs in SAP********/
	
	
	
	
	
	
	if(closing)
	{

/*****For Put  Rank Status and PO Nos RFQ wise *****/
		ezc.ezparam.EzcParams rfqezcparams				     	= new ezc.ezparam.EzcParams(false);
		ezc.ezpreprocurement.params.EziRFQHeaderTable ezirfqheadertable 	= new ezc.ezpreprocurement.params.EziRFQHeaderTable();
		String reasons="",RFQString="",rfqNmbrs = "" ;
		int retCount = rfqNos.size();
		for(int i=0;i<myRetCount;i++)
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
					ezirfqheadertablerow.setPOorCon(POorCon);
					ezirfqheadertablerow.setPONo((String)rfqpos.get(rfqNumbers[i])); 
					ezirfqheadertablerow.setModifiedBy(Session.getUserId()); 
					ezirfqheadertable.appendRow(ezirfqheadertablerow);
					/*if(i!=0)
						RFQString = RFQString+"','"+(String)rfqNos.get(i);
					else
						RFQString = (String)rfqNos.get(i);
					*/	
					RFQString = RFQString+"','"+rfqNmbrs;
					
				}		
			}	
		}	

		rfqezcparams.setObject(ezirfqheadertable);
		rfqezcparams.setLocalStore("Y");
		Session.prepareParams(rfqezcparams);
		Manager.ezUpdateRFQ(rfqezcparams);
		
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

		ezc.ezpreprocurement.params.EzoRFQHeaderParams ezorfqheaderparams = (ezc.ezpreprocurement.params.EzoRFQHeaderParams)Manager.ezGetRFQDetails(prezcparams);
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
			ezc.ezparam.ReturnObjFromRetrieve myRet = (ezc.ezparam.ReturnObjFromRetrieve)Manager.ezClosePR(prcloseParams);
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
		
		if(prclose)
		{	//If All POs created successfully closed by passing collective rfq number
			java.util.StringTokenizer st = new java.util.StringTokenizer(collNo,"#");
			while(st.hasMoreElements())
			{
				closeezirfqheadertablerow.setCollectiveRFQNo(st.nextToken());
				closeezirfqheadertablerow.setStatus("C"); 
				closeezirfqheadertablerow.setModifiedBy(Session.getUserId()); 
				closeezirfqheadertable.appendRow(closeezirfqheadertablerow);

				closeezcparams.setObject(closeezirfqheadertable);
				closeezcparams.setLocalStore("Y");
				Session.prepareParams(closeezcparams);
				Manager.ezUpdateRFQ(closeezcparams);
			}
		}else{
		
			closeezirfqheadertablerow.setRFQNo(tobeclosedrfqStr); 
			closeezirfqheadertablerow.setStatus("C"); 
			closeezirfqheadertablerow.setModifiedBy(Session.getUserId()); 
			closeezirfqheadertable.appendRow(closeezirfqheadertablerow);

			closeezcparams.setObject(closeezirfqheadertable);
			closeezcparams.setLocalStore("Y");
			Session.prepareParams(closeezcparams);
			Manager.ezUpdateRFQ(closeezcparams);
		
		}
/**********/				
		ezc.ezparam.EzcParams historyMainParams = new ezc.ezparam.EzcParams(false);
		
		java.util.StringTokenizer st1 = new java.util.StringTokenizer(collNo,"#");
		if(prclose)
		{
			while(st1.hasMoreElements())
			{
				String colNoStr = st1.nextToken();
				historyMainParams.setLocalStore("Y");
				ezc.ezpreprocurement.params.EziWFAuditTrailParams eziWFHistoryParams= new ezc.ezpreprocurement.params.EziWFAuditTrailParams();
				eziWFHistoryParams.setEwhDocId(colNoStr);
				historyMainParams.setObject(eziWFHistoryParams);
				Session.prepareParams(historyMainParams);
				ezc.ezparam.ReturnObjFromRetrieve wfMyRet = (ezc.ezparam.ReturnObjFromRetrieve)Manager.ezGetWFAuditTrailNo(historyMainParams);
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
				eziWFHistoryParams.setEwhType("QCF_CLOSED");
				eziWFHistoryParams.setEwhSourceParticipant((String)Session.getUserId());
				eziWFHistoryParams.setEwhSourceParticipantType("");
				eziWFHistoryParams.setEwhDestParticipant("");
				eziWFHistoryParams.setEwhDestParticipantType("");
				eziWFHistoryParams.setEwhComments(reasons);
				historyMainParams.setObject(eziWFHistoryParams);
				Session.prepareParams(historyMainParams);
				Manager.ezAddWFAuditTrail(historyMainParams);
			}
		}	
	}
	
	
	
	//response.sendRedirect("../Shipment/ezMessage.jsp?Msg="+retMessage+"¥MsgType=POCON");
%>
<html>
<head>
<title>
Message
</title>
<%@ include file="../../../Includes/Jsps/Misc/iblockcontrol.jsp" %>
<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
</script>
</head>
<body bgcolor="#FFFFF7">
<Form>
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
<center><a href="../Rfq/ezWFListApprovedQcfs.jsp?Type=APPROVED&EDIT=T"><img src="../../Images/Buttons/<%=ButtonDir%>/ok.gif" style="cursor:hand" border=none></center>
<Div id="MenuSol"></Div>
</Form>
</body>
</html>

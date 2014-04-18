<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="Manager" class="ezc.ezpreprocurement.client.EzPreProcurementManager" />
<%@ page import="ezc.ezpreprocurement.params.*,java.util.*,ezc.ezparam.*,ezc.ezbasicutil.*" %>
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
	java.util.Vector rfqNos=new java.util.Vector(); 
	java.util.Hashtable rfqpos=new java.util.Hashtable(); 

	String POorCon	 = "P";
	String fromContract = request.getParameter("SOS");
	String Agreement="",AgmtItem="",quantity="",plant="",reqDate="",yyyymmddStr="";
	FormatDate formatDate = new FormatDate();

ezc.ezcommon.EzLog4j.log("****=fromContract==**"+fromContract,"I");
ezc.ezcommon.EzLog4j.log("****=searchcriteria==**"+request.getParameter("searchcriteria"),"I");
	if(fromContract!=null)	
	{
		String selectedVendors = request.getParameter("selChk");		
		quantity	       = request.getParameter("quantity");
		plant		       = request.getParameter("plant");
		reqDate	 	       = request.getParameter("reqDate");
		
		java.util.StringTokenizer vendSt =new java.util.StringTokenizer(selectedVendors,"#");
		ezc.ezcommon.EzLog4j.log("****=selectedVendors=ezCreatePOByPopUp.jsp=**"+selectedVendors,"I");
		try
		{
			
			ezc.ezcommon.EzLog4j.log("****=Agreement=**"+vendSt.nextToken(),"I");
			ezc.ezcommon.EzLog4j.log("****=Agreement=**"+vendSt.nextToken(),"I");
			
			
			//vendSt.nextToken();
			//vendSt.nextToken();
			Agreement = vendSt.nextToken();
			vendSt.nextToken();
			AgmtItem = vendSt.nextToken();
			ezc.ezcommon.EzLog4j.log("****=Agreement=**"+Agreement,"I");
			ezc.ezcommon.EzLog4j.log("****=AgmtItem==**"+AgmtItem,"I");
			
			
		}		
		catch(Exception e)
		{
		}
	}

	String vendor[]	 	 = request.getParameterValues("vendor");
	String docType[]	 = request.getParameterValues("docType");
	String valType[]	 = request.getParameterValues("valuationType");
	String confCtrl[]	 = request.getParameterValues("ccKey");	
	String houseBnkId[]	 = request.getParameterValues("hbId");	
	String rfqno[] 		 = request.getParameterValues("rfqno");
	String taxCode[]	 = request.getParameterValues("taxCode");
	String headerText[]	 = request.getParameterValues("headerText");
	String shipInstr[]	 = request.getParameterValues("shipInstr");
	String itemText[]	 = request.getParameterValues("itemText");
	
	String prNo		 = request.getParameter("reqNo");
	String itemNo		 = request.getParameter("prItmNo");
	String documentType 	 = "";
	String po =	"";
	
	ReturnObjFromRetrieve finalRet = new ReturnObjFromRetrieve(new String[]{"OBJ","VENDOR"});

	int myRetCount  = 0;
	if(vendor!=null)
		myRetCount  = vendor.length;
			
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
		
		
		documentType = docType[i];

		headerParams.setCreatedOn(new Date());			//"04/25/2005"	
		headerParams.setCreatedBy(Session.getUserId());		//"SWAMINATHN"
		headerParams.setVendor(vendor[i]);			//"1100000887"
		headerParams.setDocType(docType[i]);			//"ZRMI"

		//String hbkId = "";
		//if(houseBnkId!=null)
		//	hbkId = houseBnkId[i];
		//headerParams.setHouseBankId(hbkId);		//"ABNDB"
	
		itemRow = new EziPOItemTableRow();	
		itemRow.setAgreement(Agreement);		//"4600000017"
		itemRow.setAgmtItem(AgmtItem);			//"10"
		itemRow.setPlant(plant);			//"1000"
		itemRow.setQuantity(quantity);			//"10"
		itemRow.setPRNo(prNo);			//"1001186298"
		itemRow.setPRItem(itemNo);			//"00010"
		
		
		
		
		schRow	= new EziPOSchedTableRow();
		if(reqDate!=null)
		{
			if((reqDate).length()>9)
			{

				String tempDD="",tempMM="";
				int dd=Integer.parseInt(reqDate.substring(0,2));
				int mm=Integer.parseInt(reqDate.substring(3,5));
				int yy=Integer.parseInt(reqDate.substring(6,10));
				tempDD=dd+"";
				tempMM=mm+"";
				if(dd<10)
				{
					tempDD="0"+dd;		
				}

				if(mm<10)
				{
					tempMM="0"+mm;
				}

				yyyymmddStr=yy+""+tempMM+""+tempDD;				
				//yyyymmddStr=tempDD+""+tempMM+""+yy;
				System.out.println("Delivery Date India Format::"+yyyymmddStr);

				GregorianCalendar g=new GregorianCalendar(yy,mm-1,dd);
				Date delDateObj= g.getTime();
				String dDate 	= formatDate.getStringFromDate(delDateObj,".",FormatDate.DDMMYYYY);
				schRow.setDelivDate(yyyymmddStr);

			}
		}

		schRow.setQuantity(quantity);
		schTable.appendRow(schRow);
		
						
		String tax = "";
		
		if(taxCode!=null)
			tax = taxCode[i];
		itemRow.setTaxCode(tax);				//"AA"
		
		String val = "";
		if(valType!=null)
			val = valType[i];
		itemRow.setValType(val);				//"OGL FOR RM"

		String cckey = "";
		if(confCtrl!=null)
			cckey = confCtrl[i];
		itemRow.setConfCtrl(cckey);				//"0001"
		itemTable.appendRow(itemRow);

		/*hTextRow = new EziPOHeaderTextTableRow();
		hTextRow.setTextId("F01");					//"F01" for Header Text. 
		hTextRow.setTextForm("EN");
		hTextRow.setTextLine(headerText[i]);				//"Header Text Testing"
		headerTextTable.appendRow(hTextRow);

		hTextRow = new EziPOHeaderTextTableRow();
		hTextRow.setTextId("F06");					//"F06" for Shipping
		hTextRow.setTextForm("EN");		
		hTextRow.setTextLine(shipInstr[i]);				//"Header Text Testing"
		headerTextTable.appendRow(hTextRow);

		iTextRow = new EziPOItemTextTableRow();
		iTextRow.setTextId("F01");	
		iTextRow.setTextForm("EN");
		iTextRow.setTextLine(itemText[i]);			//"Item Text Testing"
		itemTextTable.appendRow(iTextRow);
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
		
		
		po = ret.getFieldValueString("PO_NUM");
		if(po!=null && !"null".equals(po) && !"".equals(po))
		{
			EziPOHeaderParams 	hheaderParams		= new EziPOHeaderParams();
			String hbkId = "";
			if(houseBnkId!=null)
				hbkId = houseBnkId[i];
			hheaderParams.setPONo(ret.getFieldValueString("PO_NUM"));
			hheaderParams.setHouseBankId(hbkId);			//"ABNDB"
			hheaderParams.setRelFlag("Y");			
			EzcParams hpatchParams = new EzcParams(true);
			hpatchParams.setObject(hheaderParams);
			Session.prepareParams(hpatchParams);
			ReturnObjFromRetrieve reth = (ReturnObjFromRetrieve)Manager.ezPOPostPatch(hpatchParams);
			
		}	
		
		finalRet.setFieldValue("OBJ",ret);
		finalRet.setFieldValue("VENDOR",vendor[i]);
		finalRet.addRow();
	}
	
	String retMessage ="";
	boolean closing=false;
	for(int x=0;x<finalRet.getRowCount();x++)
	{		
		String vend = finalRet.getFieldValueString(x,"VENDOR");		
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
			}
			else if("S".equalsIgnoreCase(errorType))
			{
				retMessage = retMessage + ret.getFieldValueString(pc,"MESSAGE");
				retMessage = retMessage + " Successfully"+"<br>";
				flag = true;
				closing=true;
			}
		}
	}	
	if(closing)
	{
		ezc.ezpreprocurement.params.EziPRTable  	prTable		= new ezc.ezpreprocurement.params.EziPRTable();
		ezc.ezpreprocurement.params.EziPRTableRow 	prTableRow	= null;
		
		EzcParams mainParams = new EzcParams(true);
		EziAuditTrailTable eziaudittable = new EziAuditTrailTable();
		EziAuditTrailTableRow 	eziaudittablerow 	= null;	
		  	
		String purchOrg    = (String)Session.getUserPreference("PURORG");
		String purGrp  	   = (String)Session.getUserPreference("PURGROUP");
		
		eziaudittablerow 	= new EziAuditTrailTableRow();	
		eziaudittablerow.setDocId(po);
		eziaudittablerow.setDocType(documentType);
		eziaudittablerow.setDocCategory("F");
		eziaudittablerow.setUserName(Session.getUserId());
		eziaudittablerow.setFMName("BAPI_PO_CREATE1");
		eziaudittablerow.setIPAddress(request.getRemoteAddr());
		eziaudittablerow.setPurOrg(purchOrg);
		eziaudittablerow.setPurGrp(purGrp);
		eziaudittablerow.setComments("PO has been created");
		eziaudittablerow.setChangeInd("I");
      		eziaudittable.appendRow(eziaudittablerow);
		
		
		prTableRow     =  new ezc.ezpreprocurement.params.EziPRTableRow();
		prTableRow.setReqNo(prNo);
		prTableRow.setItemNo(itemNo);
		prTableRow.setStatus("X");
		prTable.appendRow(prTableRow);

		ezc.ezparam.EzcParams prcloseParams=new ezc.ezparam.EzcParams(true);
		ezc.ezparam.EzcParams auditParams=new ezc.ezparam.EzcParams(true);
		prcloseParams.setObject(prTable);
		Session.prepareParams(prcloseParams);
		try
		{
			auditParams.setObject(eziaudittable);
			Session.prepareParams(auditParams);
			Manager.ezAddAuditTrail(auditParams);
			
			ezc.ezparam.ReturnObjFromRetrieve myRet = (ezc.ezparam.ReturnObjFromRetrieve)Manager.ezClosePR(prcloseParams);
		}
		catch(Exception e)
		{
			System.out.println("Exception Occured in ClosePR.jsp"+e.getMessage());
		}		
	}
	//response.sendRedirect("../Shipment/ezMessage.jsp?Msg="+retMessage+"¥MsgType=POCON");
%>
<html>
<head>
<title>
Message
</title>
<%@ include file="../../../Includes/JSPs/Misc/iblockcontrol.jsp" %>
<%@include file="../../../Includes/Lib/AddButtonDir.jsp" %>
</script>
<script>
function ezOk()
{	
  document.myForm.action = '../Misc/ezSBUWelcome.jsp'
  document.myForm.submit();	
}
</script>
</head>
<body bgcolor="#FFFFF7">
<%
	String display_header = "";
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<br>
<br>
<br>
<table width="70%" align="center" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1>
  <tr align="center">
    <th align = left><%=retMessage%></th>
  </tr>
</table>
<br><br>
<center>
  
<%        
        buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	    
    	//buttonName.add("&nbsp;&nbsp;Back&nbsp;&nbsp");
    	//buttonMethod.add("history.go(-1)");
    	
    	buttonName.add("&nbsp;&nbsp;OK&nbsp;&nbsp");
    	buttonMethod.add("ezOk()");
    	
    		
   	out.println(getButtonStr(buttonName,buttonMethod));
   	
%>   
</center>
<Div id="MenuSol"></Div>
</body>
</html>

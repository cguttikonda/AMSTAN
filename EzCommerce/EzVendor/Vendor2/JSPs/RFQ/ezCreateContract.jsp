<%@include file="../../Library/Globals/errorPagePath.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@ page import="ezc.ezpreprocurement.params.*,java.util.*,ezc.ezparam.*,ezc.ezutil.*,ezc.ezbasicutil.*;" %>
<jsp:useBean id="Manager" class="ezc.ezpreprocurement.client.EzPreProcurementManager" />
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
	EzcParams mainParams = new EzcParams(true);
	EziAuditTrailTable eziaudittable = new EziAuditTrailTable();
  	EziAuditTrailTableRow 	eziaudittablerow 	= null;	
  	
  	String purchOrg    = (String)Session.getUserPreference("PURORG");
	String purGrp  	   = (String)Session.getUserPreference("PURGROUP");
  	
	java.util.Vector rfqNos=new java.util.Vector(); 
	java.util.Vector tobeclosedrfqs	=new java.util.Vector(); 
	java.util.Vector consVect=new java.util.Vector();
	java.util.Hashtable rfqpos=new java.util.Hashtable();
	java.util.Hashtable selDocTypes = new java.util.Hashtable();
	java.util.Hashtable poshash	=new java.util.Hashtable(); 
	boolean closeAllRFQs = true;
	String POorCon	 	 = "C";
	String rfqno[] 		 = request.getParameterValues("rfqno");
	String collNo 	 	 = request.getParameter("collectiveRFQNo");

    	String vendor[]    = request.getParameterValues("vendor");
    	String quantity[]  = request.getParameterValues("poQuantity");
    	String docType[]   = request.getParameterValues("docType");
    	String conValue[]  = request.getParameterValues("targetValue");
    	
	String valType[]   = request.getParameterValues("valuationType");
    	String headerText[]= request.getParameterValues("headerText");
    	String shipInstr[] = request.getParameterValues("shipInstr");
	String itemText[]  = request.getParameterValues("itemText");
	
	String materialArr[]	 = request.getParameterValues("material");	
	String priceArr[]	 = request.getParameterValues("price");

	ezc.ezparam.ReturnObjFromRetrieve finalRet= new ezc.ezparam.ReturnObjFromRetrieve(new String[]{"OBJ","VENDOR","RFQNO"});
	String material="",price="";
	
	int myRetCount  = 0;
	if(vendor!=null)
		myRetCount  = vendor.length;
		

	for(int i=0;i<myRetCount;i++)	
	{
		rfqNos.add(rfqno[i]);
		selDocTypes.put(vendor[i],docType[i]);
			
		material = materialArr[i];
		price	 = priceArr[i];

					
		EziSAHeaderParams headerParams = new EziSAHeaderParams();	
		
		EziPOItemTable    itemTable    = new EziPOItemTable();
		EziPOItemTableRow itmRow       = null;
		
		EziPOHeaderTextTable 	headerTextTable 	= new EziPOHeaderTextTable();
		EziPOHeaderTextTableRow	hTextRow		= null;
		EziPOItemTextTable   	itemTextTable   	= new EziPOItemTextTable();
		EziPOItemTextTableRow	iTextRow		= null; 

		String strtDate = request.getParameter("contractStartDate"+i);
		String endDate = request.getParameter("contractEndDate"+i);
		
		int smm=Integer.parseInt(strtDate.substring(3,5));
		int sdd=Integer.parseInt(strtDate.substring(0,2));
       		int syy=Integer.parseInt(strtDate.substring(6,10));
       		
       		int emm=Integer.parseInt(endDate.substring(3,5));
		int edd=Integer.parseInt(endDate.substring(0,2));
       		int eyy=Integer.parseInt(endDate.substring(6,10));
	
		headerParams.setFlag(docType[i]);			//"MK"
		headerParams.setAgmtDate(new Date(syy-1900,smm-1,sdd));
		headerParams.setValidityDate(new Date(eyy-1900,emm-1,edd));
		headerParams.setTargetVal(conValue[i]);
		headerParams.setVendor(vendor[i]);
		headerParams.setRFQNo(rfqno[i]);
		
	/*	
		headerParams.setText(headerText[i]);
		headerParams.setShipInstr(shipInstr[i]);
	*/	
		itmRow = new EziPOItemTableRow();        
		itemTable.appendRow(itmRow);
	
	
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
					hTextRow.setTextId("K01");					
					hTextRow.setTextLine(cutLen);					
					headerTextTable.appendRow(hTextRow);
				}
				if(rem > 0)
				{
					cutLen =chkLin.substring(130*len,strLength);
					hTextRow = new EziPOHeaderTextTableRow();
					hTextRow.setTextId("K01");					
					hTextRow.setTextLine(cutLen);					
					headerTextTable.appendRow(hTextRow);

				}
			}
			else
			{

					hTextRow = new EziPOHeaderTextTableRow();
					hTextRow.setTextId("K01");					
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
						hTextRow.setTextId("K01");					
						hTextRow.setTextLine(cutLen);					
						headerTextTable.appendRow(hTextRow);
					}
					if(rem > 0)
					{
						cutLen =chkLin.substring(130*len,strLength);
						hTextRow = new EziPOHeaderTextTableRow();
						hTextRow.setTextId("K01");					
						hTextRow.setTextLine(cutLen);					
						headerTextTable.appendRow(hTextRow);
					}
				}
				else
				{
				
					hTextRow = new EziPOHeaderTextTableRow();
					hTextRow.setTextId("K01");					
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
					hTextRow.setTextId("K06");					
					hTextRow.setTextLine(cutLen);					
					headerTextTable.appendRow(hTextRow);
				}
				if(rem > 0)
				{
					cutLen =chkLin.substring(130*len,strLength);
					hTextRow = new EziPOHeaderTextTableRow();
					hTextRow.setTextId("K06");					
					hTextRow.setTextLine(cutLen);					
					headerTextTable.appendRow(hTextRow);

				}
			}
			else
			{

					hTextRow = new EziPOHeaderTextTableRow();
					hTextRow.setTextId("K06");					
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
						hTextRow.setTextId("K06");					
						hTextRow.setTextLine(cutLen);					
						headerTextTable.appendRow(hTextRow);
					}
					if(rem > 0)
					{
						cutLen =chkLin.substring(130*len,strLength);
						hTextRow = new EziPOHeaderTextTableRow();
						hTextRow.setTextId("K06");					
						hTextRow.setTextLine(cutLen);					
						headerTextTable.appendRow(hTextRow);
					}
				}
				else
				{
				
					hTextRow = new EziPOHeaderTextTableRow();
					hTextRow.setTextId("K06");					
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
					iTextRow.setPoItem("00010");
					iTextRow.setTextId("K01");					
					iTextRow.setTextLine(cutLen);					
					itemTextTable.appendRow(iTextRow);
				}
				if(rem > 0)
				{
					cutLen =chkLin.substring(130*len,strLength);
					iTextRow = new EziPOItemTextTableRow();
					iTextRow.setPoItem("00010");
					iTextRow.setTextId("K01");					
					iTextRow.setTextLine(cutLen);					
					itemTextTable.appendRow(iTextRow);

				}
			}
			else
			{

					iTextRow = new EziPOItemTextTableRow();
					iTextRow.setPoItem("00010");
					iTextRow.setTextId("K01");					
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
						iTextRow.setPoItem("00010");
						iTextRow.setTextId("K01");					
						iTextRow.setTextLine(cutLen);					
						itemTextTable.appendRow(iTextRow);
					}
					if(rem > 0)
					{
						cutLen =chkLin.substring(130*len,strLength);
						iTextRow = new EziPOItemTextTableRow();
						iTextRow.setPoItem("00010");
						iTextRow.setTextId("K01");					
						iTextRow.setTextLine(cutLen);					
						itemTextTable.appendRow(iTextRow);
					}
				}
				else
				{
				
					iTextRow = new EziPOItemTextTableRow();
					iTextRow.setPoItem("00010");
					iTextRow.setTextId("K01");					
					iTextRow.setTextLine(chkLin);					
					itemTextTable.appendRow(iTextRow);				
				}

			}
		}
	}
}
/**********Item Text End**********/

		mainParams.setObject(headerParams);
		mainParams.setObject(itemTable);
		mainParams.setObject(headerTextTable);
		mainParams.setObject(itemTextTable);
		Session.prepareParams(mainParams);
		ReturnObjFromRetrieve ret = (ReturnObjFromRetrieve)Manager.ezCreateContract(mainParams);
		
		

		for(int k=0;k<ret.getRowCount();k++)
		{
			String msgv2 = ret.getFieldValueString(k,"MSGV2");
			if("S".equals(ret.getFieldValueString(k,"MSGTYP")) && "017".equals(ret.getFieldValueString(k,"MSGNR")))
			{
				rfqpos.put(rfqno[i],msgv2);
				poshash.put(msgv2,rfqno[i]);
				consVect.add(msgv2);
			}	
		}
		finalRet.setFieldValue("OBJ",ret);
		finalRet.setFieldValue("VENDOR",vendor[i]);
		finalRet.setFieldValue("RFQNO",rfqno[i]);
		finalRet.addRow();
	}

	String retMessage ="";
	boolean closing=false;
	for(int x=0;x<finalRet.getRowCount();x++)
	{
		String vend = finalRet.getFieldValueString(x,"VENDOR");	
		String tobecloserfq = finalRet.getFieldValueString(x,"RFQNO");
		boolean flag =false;
		int cnt =1;

		ezc.ezparam.ReturnObjFromRetrieve ret = (ezc.ezparam.ReturnObjFromRetrieve )finalRet.getFieldValue(x,"OBJ");	
		retMessage += "Vendor: " +vend +"<br>";	
		for(int pc=0;pc<ret.getRowCount();pc++)
		{
			String errorType = ret.getFieldValueString(pc,"MSGTYP");
			if("E".equalsIgnoreCase(errorType))
			{
				retMessage = retMessage+"Error in Creating Contract<br>";
				if(!"".equals((ret.getFieldValueString(pc,"MSGV1")).trim()))
				retMessage = retMessage+cnt+"."+ret.getFieldValueString(pc,"MSGV1")+"<br>";
				cnt++;
				flag = false;
				closeAllRFQs = false;
			}
			else if("S".equalsIgnoreCase(errorType) && "017".equals(ret.getFieldValueString(pc,"MSGNR")))
			{
				retMessage = retMessage +ret.getFieldValueString(pc,"MSGV1") +" has been created successfully under the number "+ret.getFieldValueString(pc,"MSGV2")+"<br>";				
				
				String documentType = (String)selDocTypes.get(vend);
				String docId = ret.getFieldValueString(pc,"MSGV2");
				
				eziaudittablerow 	= new EziAuditTrailTableRow();	
			        eziaudittablerow.setDocId(docId);
			        eziaudittablerow.setDocType(documentType);
			        eziaudittablerow.setDocCategory("K");
			        eziaudittablerow.setUserName(Session.getUserId());
			        eziaudittablerow.setFMName("Z_EZ_PURCHASE_CONTRACT_CREATE");
			        eziaudittablerow.setIPAddress(request.getRemoteAddr());
			        eziaudittablerow.setPurOrg(purchOrg);
			        eziaudittablerow.setPurGrp(purGrp);
			        eziaudittablerow.setComments("Contract has been created");
			        eziaudittablerow.setChangeInd("I");
      				eziaudittable.appendRow(eziaudittablerow);
      				
      				eziaudittablerow 	= new EziAuditTrailTableRow();	
				eziaudittablerow.setDocId(docId);
				eziaudittablerow.setDocType(documentType);
				eziaudittablerow.setDocCategory("K");
				eziaudittablerow.setUserName(Session.getUserId());
				eziaudittablerow.setFMName("Z_EZ_PURCHASE_CONTRACT_CREATE");
				eziaudittablerow.setIPAddress(request.getRemoteAddr());
				eziaudittablerow.setPurOrg(purchOrg);
				eziaudittablerow.setPurGrp(purGrp);
				eziaudittablerow.setComments("Contract has been released");
				eziaudittablerow.setChangeInd("I");
      				eziaudittable.appendRow(eziaudittablerow);
				
				flag = true;
				closing=true;
				
				if(!tobeclosedrfqs.contains(tobecloserfq))
					tobeclosedrfqs.add(tobecloserfq);
			}
		}
	}	
	if(closing)
	{		 
	         mainParams.setObject(eziaudittable);
	         Session.prepareParams(mainParams);
	     	 Manager.ezAddAuditTrail(mainParams);      		 
	
	
%>		<%@include file="../../../Includes/JSPs/Rfq/iCloseQCF.jsp"%>			
<%	}
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
	if (bNS && bV<5) window.onmousedown = nrc;
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
    <th><%=retMessage%></th>
  </tr>
</table>
<br><br>
<center><a href="../Rfq/ezWFListApprovedQcfs.jsp?Type=APPROVED&EDIT=T"><img src="../../Images/Buttons/<%=ButtonDir%>/ok.gif" style="cursor:hand" border=none></center>
<Div id="MenuSol"></Div>
</body>
</html>

<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ page import = "java.util.*"%>
<%@ page import = "ezc.ezutil.FormatDate"%>
<%@ include file="../../../Includes/Lib/PurchaseBean.jsp"%>
<%@ include file="../../../Includes/Lib/DateFunctions.jsp"%>
<%
	ezc.ezparam.EzInvoice SeqInv = new ezc.ezparam.EzInvoice();
	
	String searchField = request.getParameter("searchField");
	String base = request.getParameter("base");
	String invoiceFlag = request.getParameter("InvStat");
	String vendor=(String) session.getValue("SOLDTO");
	String purnum = "";

	
	if ( invoiceFlag.equals("P") )
	{
	
		ezc.ezshipment.client.EzShipmentManager manager = new ezc.ezshipment.client.EzShipmentManager();
		
		EzcParams ezcParams=new EzcParams(true);
		ezc.ezshipment.params.EziSearchInputStructure inStruct=new ezc.ezshipment.params.EziSearchInputStructure();
		
		inStruct.setBase("POIN");
		inStruct.setVendor(vendor);
		inStruct.setDocnum(searchField);

		ezcParams.setObject(inStruct);
		Session.prepareParams(ezcParams);

		SeqInv = (EzInvoice) manager.ezGetInvoicesForGR(ezcParams);
	}
	else{
%>
		<%@ include file="../../../Includes/JSPs/Purorder/iListInv.jsp"%>
<%
	}
		ezc.ezcommon.EzLog4j.log("invoiceFlag>>>>>>>>>>>>>"+invoiceFlag ,"I");

	ezc.ezbasicutil.EzCurrencyFormat myFormat= new ezc.ezbasicutil.EzCurrencyFormat();
	myFormat.setLocale((java.util.Locale)session.getValue("LOCALE"));
	myFormat.setNeedSybmol(((Boolean)session.getValue("SREQUIRED")).booleanValue());
	myFormat.isPre(((Boolean)session.getValue("CPOSITION")).booleanValue());
	myFormat.setSymbol((String)session.getValue("CURRENCY"));

	ezc.ezbasicutil.EzSearchReturn mySearch= new ezc.ezbasicutil.EzSearchReturn();
	if(base!=null)
	{
		if(base.equals("Invoice")){
			mySearch.searchLong(SeqInv,"INVOICENUMBER",searchField);
		}else if(base.equals("VendorInvoiceNumber")){
			mySearch.search(SeqInv,"REFDOC",searchField);
		}
	}
                      
	int count=0;
	int seqRowCount = 0;
	if(SeqInv!=null)
		seqRowCount = SeqInv.getRowCount();
	
	
	out.println("<?xml version=\"1.0\"?>");
	out.println("<rows>");

	
	if(seqRowCount>0){
		FormatDate formatDate = new FormatDate();
		
		String sortItems[] = {"INVOICEDATE"};
		SeqInv.sort(sortItems,false);

		String invNumber = new String();
		double invConAmt = 0;

		/// INV LIST CONSOLIDATION STARTS HERE
		Hashtable invAmtHT = new Hashtable();
		for(int i=0;i<seqRowCount;i++)	{
			if(SeqInv.getFieldValue(i,"DOCTYPE").equals("AB") && SeqInv.getFieldValueString(i,"DBCRINDICATOR").equals("H"))
					continue;
			if(SeqInv.getFieldValue(i,"DOCTYPE").equals("OV") && SeqInv.getFieldValueString(i,"DBCRINDICATOR").equals("S"))
					continue;
			if(!invAmtHT.containsKey(SeqInv.getFieldValueString(i,"INVOICENUMBER"))){
				invAmtHT.put(SeqInv.getFieldValueString(i,"INVOICENUMBER"),SeqInv.getFieldValueString(i,"AMOUNT"));
			}
			else
			{
				invNumber = SeqInv.getFieldValueString(i,"INVOICENUMBER");
				try{
					invConAmt = Double.parseDouble(SeqInv.getFieldValueString(i,"AMOUNT"))+Double.parseDouble(invAmtHT.get(invNumber).toString());
				}catch(Exception numFmtEx)
				{
					System.out.println(" <<<<<<<<<< Exception Occured at :: "+i+" while consolidating InvList with Invoice Number :: "+invNumber+" >>>>>>>>>> "+numFmtEx.getMessage());
					invConAmt = Double.parseDouble((String)invAmtHT.get(invNumber));
				}
				invAmtHT.put(invNumber,new Double(invConAmt).toString());
			}	
		
		}
		/// INV LIST CONSOLIDATION ENDS HERE
%>
		
<%
		
		String amt = null;

		String vndInvNumber = "";
		String sapInvNumber = "";
		String invDate	    = "";
		String payDueDate   = "";
		String poNumber	    = "";
		String invCurrency  = "";
		String invAmount    = "";
		String compCode	    = "";
		
		for (int i= 0;i<seqRowCount;i++){
			if (invAmtHT.containsKey(SeqInv.getFieldValueString(i,"INVOICENUMBER"))){
				try{
					amt = (String)invAmtHT.get(SeqInv.getFieldValueString(i,"INVOICENUMBER"));
					invAmtHT.remove(SeqInv.getFieldValueString(i,"INVOICENUMBER"));
				}
				catch(Exception ae){
					amt = "0";
				}

				if(!"0.00".equals(myFormat.getCurrencyString(amt))){
					count = count+1;

					vndInvNumber = SeqInv.getFieldValueString(i,"REFDOC");
					if(vndInvNumber == null || vndInvNumber.trim().length() == 0  || "null".equals(vndInvNumber))
						vndInvNumber = "";
					sapInvNumber	= SeqInv.getFieldValueString(i,"INVOICENUMBER");	
					invDate 	= formatDate.getStringFromDate((Date) SeqInv.getFieldValue(i,"INVOICEDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
					payDueDate 	= formatDate.getStringFromDate((Date) SeqInv.getFieldValue(i,"CLEAR_DATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
					compCode	= SeqInv.getFieldValueString(i,"COMPCODE");
					invCurrency	= SeqInv.getFieldValueString(i,"INVOICECURRENCY");
					invAmount	= myFormat.getCurrencyString(amt);

					poNumber  = null ;
					try{
						poNumber = Long.parseLong(SeqInv.getFieldValueString(i,"PURCHASEORDER"))+"";
					}catch(Exception numFmtEx)
					{
						poNumber = SeqInv.getFieldValueString(i,"PURCHASEORDER");
					}
					if(poNumber == null ||"".equals(poNumber))
						poNumber = "";
					if(payDueDate == null ||"".equals(payDueDate))
						payDueDate = "";	

					out.println("<row id='"+sapInvNumber+"'><cell>"+vndInvNumber+"</cell><cell><![CDATA[<nobr><a href=\"JavaScript:funLinkInvoice('ezInvoiceDetails.jsp','"+sapInvNumber+"','"+poNumber+"','"+compCode+"','"+SeqInv.getFieldValue(i,"DOCTYPE")+"','"+invDate+"','"+invCurrency+"','"+invAmount+"','"+formatDate.getStringFromDate((Date)SeqInv.getFieldValue(i,"POSTINGDATE"),".",ezc.ezutil.FormatDate.DDMMYYYY)+"')\" onMouseover=\"window.status='Click To View Details '; return true\" onMouseout=\"window.status=' '; return true\">"+sapInvNumber+"</a></nobr>]]></cell><cell>"+invDate+"</cell><cell>"+payDueDate+"</cell><cell>"+poNumber+"</cell><cell>"+invCurrency+"</cell><cell>"+invAmount+"</cell></row>");

				}
			
			}		
		}
		if(count == 0){
			out.println("<row id='"+count+"'></row>");
			ezc.ezcommon.EzLog4j.log("<row id='"+count+"'></row>","I");
		}
	}	
	else{
		out.println("<row id='"+count+"'></row>");
		ezc.ezcommon.EzLog4j.log("<row id='"+count+"'></row>","I");
	}
out.println("</rows>");
	
				
%>

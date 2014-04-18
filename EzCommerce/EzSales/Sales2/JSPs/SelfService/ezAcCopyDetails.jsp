<%
	response.setContentType("text/xml");
	out.println("<?xml version=\"1.0\" encoding=\"ISO-8859-1\" ?>");	
	out.println("<rows>");
%>

<%@ include file="../../Library/Globals/ezErrorPagePath.jsp" %>
<%@ include file="../../../Includes/JSPs/SelfService/iAcCopy.jsp"%>
<%
	String TRANSDATE ="";
	String PARTICULARS ="";
	String DOCNO="";
	String DEBIT="";
	String CREDIT="";
	String BALANCE="";
		
	//out.println("<?xml version=\"1.0\"?>");		
	//out.println("<rows>");
	
	if((lineItems!=null) && (lineItemsCount>0))
	{

		Date invDt = null;
		String invAmount = null;
		String docNo = null;
		String dbcrInd = null;
		String docType = null;
		String acType = "";
		for(int i=0;i<lineItemsCount;i++)
		{
			invDt 		= (Date)lineItems.getFieldValue(i,"PstngDate");
			docNo 		= lineItems.getFieldValueString(i,"DocNo");
			docType 	= lineItems.getFieldValueString(i,"DocType");
			invAmount 	= lineItems.getFieldValueString(i,"Amount");

			if("H".equals(lineItems.getFieldValueString(i,"DbCrInd")))
			{
				balance 	=  invoiceBal - Double.parseDouble(invAmount);
				dbcrInd 	= "";
			}
			else
			{
				balance 	=  invoiceBal + Double.parseDouble(invAmount);
				dbcrInd 	= "-";
			}

			if("DZ".equals(docType))
				acType = "Receipt";
			else if("DA".equals(docType))
				acType = "Bill Of Exchange";
			else if("RV".equals(docType))
				acType = "Invoice";
			else if("AB".equals(docType))
				acType = "Adjustment";
			else if("OC".equals(docType))
				acType = "Opening Balance";

			if((fromDate.compareTo(invDt) <= 0) && (toDate.compareTo(invDt) >=0))
			{	

				
				try{
					docNo = ""+Long.parseLong(docNo);
				}catch(Exception e){}


				TRANSDATE 	= formatDate.getStringFromDate(invDt,forkey,formatDate.MMDDYYYY);
				PARTICULARS 	= acType;
				DOCNO 		= docNo;
				if (dbcrInd.equals("-"))
				{
					DEBIT 	= myFormat.getCurrencyString(lineItems.getFieldValueString(i,"Amount")) ;
					CREDIT	= "";
				}else{

					DEBIT	= "";
					CREDIT	= myFormat.getCurrencyString(lineItems.getFieldValueString(i,"Amount")) ;
				}
				if(balance<0)
				{
					BALANCE	= myFormat.getCurrencyString(balance);
				}else{
					BALANCE	= myFormat.getCurrencyString(balance);
				}				
				invoiceBal = balance;
				out.println("<row id='"+i+1+"'><cell>"+TRANSDATE+"</cell><cell>"+PARTICULARS+"</cell><cell>"+DOCNO+"</cell><cell>"+DEBIT+"</cell><cell>"+CREDIT+"</cell><cell>"+BALANCE+"</cell></row>");				
			}				
		}

	}
	
	if(lineItemsCount==0)
	{
		out.println("<row id='"+lineItemsCount+"'><cell></cell></row>");
	}	
	out.println("</rows>");	
%>	

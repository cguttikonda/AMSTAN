<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iInvoiceDetails_Labels.jsp"%>
<%@ include file="../../../Includes/JSPs/Purorder/iInvoiceDetails.jsp"%>
<%@ page import = "ezc.ezutil.FormatDate"%>
<%@ page import = "java.util.*"%>

<%
	int Count = SeqInv.getRowCount();
	ezc.ezbasicutil.EzCurrencyFormat myFormat= new ezc.ezbasicutil.EzCurrencyFormat();
	myFormat.setLocale((java.util.Locale)session.getValue("LOCALE"));
	myFormat.setNeedSybmol(((Boolean)session.getValue("SREQUIRED")).booleanValue());
	myFormat.isPre(((Boolean)session.getValue("CPOSITION")).booleanValue());
	myFormat.setSymbol((String)session.getValue("CURRENCY"));

	double grandTotal = 0;
	Vector ponos = new Vector();
	Vector indexes = new Vector();
	boolean flag=true;
	for(int i=0;i<Count;i++)
	{
		pono = (String)SeqInv.getFieldValue(i,"POSITIONNUMBER");
		if(!ponos.contains(pono))
		{
			ponos.addElement(pono);
			indexes.addElement(new Integer(i));

		}
	}

	double qty1=0;
	double price= 0;
	double netAmt = 0;

	double tqty=0;
	double tprice= 0;
	double tnetAmt = 0;

	
	String curElement = new String();

	int index = 0;


	Vector vInvDocTypes = new Vector();
	vInvDocTypes.addElement("RC");
	vInvDocTypes.addElement("RE");
	vInvDocTypes.addElement("RI");
	vInvDocTypes.addElement("RJ");
	vInvDocTypes.addElement("RS");
	
	
	boolean dispnoDataDiv =true;
	
	out.println("<?xml version=\"1.0\"?>");
	out.println("<rows>");
	if(docType.equals("KR"))
	{
		dispnoDataDiv =false;
		out.println("<row id='1'><cell>"+invoiceAmtExp_L+"</cell><cell></cell><cell></cell><cell></cell><cell></cell><cell></cell><cell>"+myFormat.getCurrencyString(invAmount)+"</cell></row>");
	}
	else if(docType.equals("OV"))
	{
		dispnoDataDiv =false;
		out.println("<row id='1'><cell>"+invoiceAmtFisc_L+"</cell><cell></cell><cell></cell><cell></cell><cell></cell><cell></cell><cell>"+myFormat.getCurrencyString(invAmount)+"</cell></row>");
	}
	else if(docType.equals("AB"))
	{
		dispnoDataDiv =false;
		out.println("<row id='1'><cell>"+invoiceAmtClr_L+"</cell><cell></cell><cell></cell><cell></cell><cell></cell><cell></cell><cell>"+myFormat.getCurrencyString(invAmount)+"</cell></row>");
	}
	else if(vInvDocTypes.contains(docType))
	{
		dispnoDataDiv =false;
		for(int i=0;i<ponos.size();i++)
		{
			tqty 	= 0;
			tprice 	= 0;
			tnetAmt = 0;
			flag 	= false;
			curElement = ponos.elementAt(i).toString();
			if(curElement.equals("0"))
				flag = true;
			for(int j=0;j<Count;j++)
			{
				try
				{
					qty1 	= Double.parseDouble(SeqInv.getFieldValueString(j,"INVOICEDQUANTITY"));
					netAmt 	= Double.parseDouble(SeqInv.getFieldValueString(j,"INVOICEDAMOUNT"));
					if(qty1 != 0)
						price = netAmt/qty1;
				}catch(Exception e){}

				if(curElement.equals((String)SeqInv.getFieldValue(j,"POSITIONNUMBER")))
				{
					if(!flag)
					{
						if(tqty == 0)
							tqty = tqty + qty1;
						tprice = tprice+price;
						tnetAmt = tnetAmt+netAmt;
					}
				}
			}

			if(!flag)
			{
				index = ((Integer)indexes.elementAt(i)).intValue();
				grandTotal += tnetAmt;
				String lineNo = curElement;
				String matrNo = "";
				try
				{
					matrNo = Long.parseLong(SeqInv.getFieldValueString(index,"ITEM"))+"";
				}
				catch(Exception e)
				{
					matrNo = SeqInv.getFieldValueString(index,"ITEM");
				}
				String matDesc = SeqInv.getFieldValueString(index,"DESCRIPTION");
				String uomData = SeqInv.getFieldValueString(index,"PURCHASEUNIT");
				String qtyData = myFormat.getCurrencyString(tqty);
				String tbprice = "";	
				double qty2 = 0;
				try
				{
					qty2 = Double.parseDouble((String)SeqInv.getFieldValue(index,"INVOICEDQUANTITY"));
				}
				catch(Exception e){}
				if(tqty != 0)
					tbprice = myFormat.getCurrencyString(tnetAmt/tqty)+"";
				else
					tbprice = "0.00";
				String netValue = myFormat.getCurrencyString(tnetAmt);	
				
				out.println("<row id='"+lineNo+"'><cell>"+lineNo+"</cell><cell>"+matrNo+"</cell><cell>"+matDesc+"</cell><cell>"+uomData+"</cell><cell>"+qtyData+"</cell><cell>"+tbprice+"</cell><cell>"+netValue+"</cell></row>");
			}
		}

		double totZeroLnAmount =0;
		for(int i=1;i<Count;i++)
		{
			if(SeqInv.getFieldValueString(i,"POSITIONNUMBER").equals("0"))
			{
				try
				{
					totZeroLnAmount += Double.parseDouble(SeqInv.getFieldValueString(i,"INVOICEDAMOUNT"));
				}catch(Exception numFmtEx)
				{
					totZeroLnAmount += 0;
				}
			}
		}
		grandTotal += totZeroLnAmount;
		out.println("<row id='"+Count+"' style='background-color:pink;color:darkblue;font-weight:600;'><cell>Taxes,Duties,Levies</cell><cell></cell><cell></cell><cell></cell><cell></cell><cell></cell><cell>"+myFormat.getCurrencyString(totZeroLnAmount)+"</cell></row>");
		out.println("<row id='"+(Count+1)+"' style='background-color:pink;color:darkblue;font-weight:600;'><cell>Total</cell><cell></cell><cell></cell><cell></cell><cell></cell><cell></cell><cell>"+myFormat.getCurrencyString(grandTotal)+"</cell></row>");
	}
	if(dispnoDataDiv)
	{
		out.println("<row id='0'></row>");
		
	}
	out.println("</rows>");	
%>
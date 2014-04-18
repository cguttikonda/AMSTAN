<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ page import="java.util.*,java.text.*" %>
<%@ include file="../../../Includes/JSPs/Misc/iEzDateConvertion.jsp" %>
<%@ include file="../../../Includes/JSPs/Purorder/iListToBeDelivered.jsp"%>
<%
	boolean isAvailable=false;	
	out.println("<?xml version=\"1.0\"?>");
	out.println("<rows>");
	if (Count > 0)
	{
		String poNumber = "";
		String lineNo 	= "";
		String matCode	= "";
		String matDesc	= "";
		String pouom	= "";
		String quantity	= "";
		String delDate	= "";
		String cmtDate	= "";
		String outputString = "";		
		for (int i=0 ; i < Count ; i++)
		{
			Date DelDate = (Date)hdrXML.getFieldValue(i, "DELIVERYDATE");
			if (DelDate.before(ToDate))
			{
				isAvailable = true;
				poNumber = hdrXML.getFieldValueString(i, "ORDER");
				try
				{
					poNumber = Long.parseLong(poNumber)+"";
				}
				catch(Exception ex){}

				lineNo   = hdrXML.getFieldValueString(i, "LINEOFBUSINESS");
				try
				{
					lineNo = Long.parseLong(lineNo)+"";
				}
				catch(Exception ex){}
				
				matCode  = hdrXML.getFieldValueString(i, "SUPPLIERTEXT");
				try
				{
					matCode = Long.parseLong(matCode)+"";
				}
				catch(Exception ex){} 	
				
				matDesc  = hdrXML.getFieldValueString(i,"VENDOR_NAME");
				matDesc = matDesc.replaceAll("&","&amp;");
				pouom	 = hdrXML.getFieldValueString(i, "PAYMENTTERMSID");
				quantity = getNumberFormat(hdrXML.getFieldValueString(i, "NETAMOUNT"),0);
				delDate  = FormatDate.getStringFromDate((Date)hdrXML.getFieldValue(i, "DELIVERYDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
				cmtDate  = FormatDate.getStringFromDate((Date)hdrXML.getFieldValue(i, "CONFIRMDELIVERYDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
				
				outputString  = "<row id='"+poNumber+"_"+i+"'>";
				outputString += "<cell><![CDATA[<nobr><a href='javascript:funLinkOpen(\"ezPoLineitems.jsp\",\""+poNumber+"\",\""+quantity+"\",\""+hdrXML.getFieldValueString(i,"CURRENCY")+"\",\"Y\")'>"+poNumber+"</a></nobr>]]></cell>";
				outputString += "<cell>"+lineNo+"</cell><cell>"+matCode+"</cell><cell>"+matDesc+"</cell><cell>"+pouom+"</cell><cell>"+quantity+"</cell><cell>"+delDate+"</cell><cell>"+cmtDate+"</cell>";
				outputString += "</row>";
				
				out.println(outputString);
			}
		}	
	}
	else
	{
		isAvailable = false;
	}
	
	ezc.ezcommon.EzLog4j.log(">>>>>>>>>>>>>>>>>>>>>>>>>>"+isAvailable,"I");
	
	if(!isAvailable)
	{
		out.println("<row id='0'></row>");
	}
	out.println("</rows>");
%>



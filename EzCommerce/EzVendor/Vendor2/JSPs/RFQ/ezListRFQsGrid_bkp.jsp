<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@include file="../../../Includes/JSPs/Rfq/iListRFQs.jsp"%>
<%
	ezc.ezutil.FormatDate formatDate = new ezc.ezutil.FormatDate();
	String rfqNum 	= "";
	String rfqDate	= "";
	String rfqcloseDate = "";
	
	out.println("<?xml version=\"1.0\"?>");
	out.println("<rows>");
	if(Count > 0)
	{
		for(int i=0;i<Count;i++)
		{
			rfqNum 	 = hdrXML.getFieldValueString(i,"ORDER");
			rfqDate = formatDate.getStringFromDate((java.util.Date)hdrXML.getFieldValue(i,"ORDERDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
			rfqcloseDate = formatDate.getStringFromDate((java.util.Date)hdrXML.getFieldValue(i,"CONFIRMDELIVERYDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));

			
			if ("List".equalsIgnoreCase(type)){
				
				out.println("<row id='"+rfqNum+"'><cell><![CDATA[<nobr><a href='ezViewQuoteDetails.jsp?PurchaseOrder="+rfqNum+"&amp;type="+type+"&amp;EndDate="+rfqcloseDate+"&amp;OrderDate="+rfqcloseDate+"'>"+rfqNum+"</a></nobr>]]></cell><cell>"+rfqDate+"</cell><cell>"+rfqcloseDate+"</cell></row>");
				
			}else{
				
				 out.println("<row id='"+rfqNum+"'><cell><![CDATA[<nobr><a href='ezViewRFQDetails.jsp?PurchaseOrder="+rfqNum+"&amp;type="+type+"&amp;EndDate="+rfqcloseDate+"&amp;OrderDate="+rfqcloseDate+"'>"+rfqNum+"</a></nobr>]]></cell><cell>"+rfqDate+"</cell><cell>"+rfqcloseDate+"</cell></row>");
			}
		}
	}
	else
	{
		out.println("<row id='"+Count+"'></row>");
	}
	out.println("</rows>");
%>	
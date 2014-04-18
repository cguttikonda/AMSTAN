<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Purorder/iListAcknowledgedPO.jsp"%>
<%
	ezc.ezutil.FormatDate formatDate = new ezc.ezutil.FormatDate();
	String poNum 	= "";
	String ordDate	= "";
	String ackDate	= "";
	String vendor 	= "";
	String status   = "";
	String createdBy= "";
	String headerTxt= "";
	String shipDate = "";
	String poSysKey	= "";
	
	String purGrp	= "";
	String cCode	= "";	
	java.util.Hashtable  purGroupsHash = (java.util.Hashtable) session.getValue("PURGRPSHASH");//REFFROM: iloginbanner.jsp
	java.util.Hashtable  ccHash	   = (java.util.Hashtable) session.getValue("CCODEHASH");  //REFFROM: iloginbanner.jsp
	
	
	out.println("<?xml version=\"1.0\"?>");
	out.println("<rows>");
	if(Count > 0)
	{
		if(orderType.equals("Acknowledged"))
		{
			for(int i=0;i<Count;i++)
			{
				poNum 	 = ret.getFieldValueString(i,"DOCNO");
				status   = ret.getFieldValueString(i,"DOCSTATUS");
				ordDate  = formatDate.getStringFromDate((java.util.Date)ret.getFieldValue(i,"DOCDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
				ackDate  = formatDate.getStringFromDate((java.util.Date)ret.getFieldValue(i,"MODIFIEDON"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
				if(poHash.get(poNum.trim()) != null)
				{
					formatDate.getStringFromDate((java.util.Date)poHash.get(poNum.trim()),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
				}
				else
					shipDate = "";
				out.println("<row id='"+poNum+"'><cell><![CDATA[<nobr><a href='ezOpenPoLineitems.jsp?orderType=Open&PurchaseOrder="+poNum+"&amp;status="+status+"'>"+poNum+"</a></nobr>]]></cell><cell>"+ordDate+"</cell><cell>"+shipDate+"</cell><cell>"+ackDate+"</cell></row>");
			}
		}
		else if(orderType.equals("NotAcknowledged"))
		{
			for(int i=0;i<Count;i++)
			{
				poNum 	  	= ret.getFieldValueString(i,"DOCNO");
				status  	= ret.getFieldValueString(i,"DOCSTATUS");
				createdBy 	= ret.getFieldValueString(i,"CREATEDBY");
				ordDate 	= formatDate.getStringFromDate((java.util.Date)ret.getFieldValue(i,"DOCDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
				vendor 		= ret.getFieldValueString(i,"EXT1");
				poSysKey = ret.getFieldValueString(i,"DOCSYSKEY");
				
				if(poHash.get(poNum.trim()) != null)
				{
					if(poHash.get(poNum.trim()) != null && !"null".equals(poHash.get(poNum.trim())) && !"".equals(poHash.get(poNum.trim())))
						shipDate = formatDate.getStringFromDate((java.util.Date)poHash.get(poNum.trim()),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
					else	
						shipDate = "";
				}
				else
					shipDate = "";				
					
				if("PH".equals(userRole) && "ALL".equals(show) )
				{
					try
					{
						purGrp 	 = (String)purGroupsHash.get(poSysKey);
						cCode    = (String)ccHash.get(poSysKey) ;
					}
					catch(Exception e)
					{
						purGrp="";
						cCode=""; 
					}
					
					out.println("<row id='"+poNum+"¥"+vendor+"'><cell><![CDATA[<nobr><input type=checkbox name=chk1 value='"+poNum+"¥"+vendor+"¥"+"A¥"+poSysKey+"'></nobr>]]></cell> <cell><![CDATA[<nobr><a href='ezNewPoLineitems.jsp?PurchaseOrder="+poNum+"&amp;status="+status+"&amp;vendor="+vendor+"&amp;poSysKey="+poSysKey+"&amp;show="+show+"'>"+poNum+"</a></nobr>]]></cell><cell>"+purGrp+"</cell><cell>"+cCode+"</cell><cell>"+ordDate+"</cell><cell>"+shipDate+"</cell> <cell>"+vendor+"</cell></row>");
				}
				else
				{	
					out.println("<row id='"+poNum+"¥"+vendor+"'><cell><![CDATA[<nobr><input type=checkbox name=chk1 value='"+poNum+"¥"+vendor+"¥"+"A¥"+poSysKey+"'></nobr>]]></cell><cell><![CDATA[<nobr><a href='ezNewPoLineitems.jsp?PurchaseOrder="+poNum+"&amp;status="+status+"&amp;vendor="+vendor+"'>"+poNum+"</a></nobr>]]></cell><cell>"+ordDate+"</cell><cell>"+shipDate+"</cell><cell>"+vendor+"</cell></row>");
				}	
			}
		}
		else if(orderType.equals("Rejected"))
		{
			for(int i=0;i<Count;i++)
			{
				poNum 	  	= ret.getFieldValueString(i,"DOCNO");
				status  	= ret.getFieldValueString(i,"DOCSTATUS");
				ordDate 	= formatDate.getStringFromDate((java.util.Date)ret.getFieldValue(i,"DOCDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
				headerTxt	= ret.getFieldValueString(i,"HEADERTEXT");
				vendor 		= ret.getFieldValueString(i,"EXT1");
				poSysKey  	= ret.getFieldValueString(i,"DOCSYSKEY");
				if(poHash.get(poNum.trim()) != null)
				{
					formatDate.getStringFromDate((java.util.Date)poHash.get(poNum.trim()),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
				}
				else
					shipDate = "";				
				out.println("<row id='"+poNum+"¥"+vendor+"'><cell><![CDATA[<nobr><input type=checkbox name=chk1 value='"+poNum+"¥"+vendor+"¥"+"R¥"+poSysKey+"'></nobr>]]></cell><cell><![CDATA[<nobr><a href='ezBlockedPoLineitems.jsp?PurchaseOrder="+poNum+"&amp;poSysKey="+poSysKey+"&amp;Vendor="+vendor+"&amp;type=R'>"+poNum+"</a></nobr>]]></cell><cell>"+ordDate+"</cell><cell>"+shipDate+"</cell><cell><![CDATA[<nobr><a href=\"javascript:funShowReason('"+headerTxt+"')\">Reason</a></nobr>]]></cell></row>");
			}
		}
	}
	else
	{
		out.println("<row id='"+Count+"'></row>");
	}
	out.println("</rows>");
	
%>
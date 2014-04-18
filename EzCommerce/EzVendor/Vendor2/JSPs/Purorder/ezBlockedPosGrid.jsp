<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Purorder/iListBlockedPO.jsp"%>
<%

	ezc.ezutil.FormatDate formatDate = new ezc.ezutil.FormatDate();
	String poNum 	= "";
	String poDate	= "";
	String mdDate	= "";
	String vendor 	= "";
	String poSysKey	= "";
	String purGrp	= "";
	String cCode	= "";
	
	java.util.Hashtable  purGroupsHash = (java.util.Hashtable) session.getValue("PURGRPSHASH");//REFFROM: iloginbanner.jsp
	java.util.Hashtable  ccHash	   = (java.util.Hashtable) session.getValue("CCODEHASH");  //REFFROM: iloginbanner.jsp
	
	out.println("<?xml version=\"1.0\"?>");
	out.println("<rows>");
	if(Count > 0)
	{
		for(int i=0;i<Count;i++)
		{
			if(ret.getFieldValueString(i,"DOCSTATUS").equals("B"))	
			{
				poNum 	 = ret.getFieldValueString(i,"DOCNO");
				vendor   = ret.getFieldValueString(i,"EXT1");
				poSysKey = ret.getFieldValueString(i,"DOCSYSKEY");
				
				poDate = formatDate.getStringFromDate((java.util.Date)ret.getFieldValue(i,"DOCDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
				mdDate = formatDate.getStringFromDate((java.util.Date)ret.getFieldValue(i,"MODIFIEDON"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
				if("PH".equals(userRole) && "ALL".equals(show) ){
					try{
						purGrp 	 = (String)purGroupsHash.get(poSysKey);
						cCode    = (String)ccHash.get(poSysKey) ;
					}catch(Exception e){purGrp="";cCode=""; }	
					out.println("<row id='"+poNum+"¥"+vendor+"'><cell><![CDATA[<nobr><input type=checkbox name=chk1 value='"+poNum+"¥"+vendor+"¥"+"B¥"+poSysKey+"'></nobr>]]></cell><cell><![CDATA[<nobr><a href='ezBlockedPoLineitems.jsp?PurchaseOrder="+poNum+"&amp;Vendor="+vendor+"&amp;type=B&amp;poSysKey="+poSysKey+"'>"+poNum+"</a></nobr>]]></cell><cell>"+poDate+"</cell><cell>"+purGrp+"</cell><cell>"+cCode+"</cell><cell>"+mdDate+"</cell><cell>"+vendor+"</cell></row>");
				}else{
					out.println("<row id='"+poNum+"¥"+vendor+"'><cell><![CDATA[<nobr><input type=checkbox name=chk1 value='"+poNum+"¥"+vendor+"¥"+"B¥"+poSysKey+"'></nobr>]]></cell><cell><![CDATA[<nobr><a href='ezBlockedPoLineitems.jsp?PurchaseOrder="+poNum+"&amp;Vendor="+vendor+"&amp;type=B&amp;poSysKey="+poSysKey+"'>"+poNum+"</a></nobr>]]></cell><cell>"+poDate+"</cell><cell>"+mdDate+"</cell><cell>"+vendor+"</cell></row>");
				}
			}
		}
	}
	else
	{
		out.println("<row id='"+Count+"'></row>");
	}
	out.println("</rows>");
%>	
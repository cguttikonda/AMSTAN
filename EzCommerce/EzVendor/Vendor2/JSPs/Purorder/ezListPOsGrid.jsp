<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ page import="java.util.*,java.text.*" %>
<%@ page import = "ezc.ezutil.FormatDate"%>
<%@ include file="../../../Includes/JSPs/Purorder/iListPO.jsp"%>
<%
	NumberFormat nf=null;
	int rowCount=0;
	boolean isDisplay = false;
	
	FormatDate fD=new FormatDate();
	ezc.ezbasicutil.EzCurrencyFormat myFormat= new ezc.ezbasicutil.EzCurrencyFormat();
	myFormat.setLocale((java.util.Locale)session.getValue("LOCALE"));
	myFormat.setNeedSybmol(((Boolean)session.getValue("SREQUIRED")).booleanValue());
	myFormat.isPre(((Boolean)session.getValue("CPOSITION")).booleanValue());
	myFormat.setSymbol((String)session.getValue("CURRENCY"));
	ezc.ezbasicutil.EzSearchReturn mySearch= new ezc.ezbasicutil.EzSearchReturn();
	
	
	if((!"null".equals(POSearch))){
		String poToSearch=request.getParameter("PurchaseOrder");
		mySearch.searchLong(hdrXML,"ORDER",poToSearch);
	}
	if(orderType == null || "null".equals(orderType)) 
		orderType="";
	
	
	
%>


<%
	
	out.println("<?xml version=\"1.0\"?>");
	out.println("<rows>");
	
	String chkLink 	= "";
	String hypLink 	= "";
	String poNumber = "";
	String ordDate	= "";
	String earlyDate= "";
	String shipdate = "";
	String latDate	= "";
	String curr 	= "";
	String val   	= "";
	String status   ="";
	
	if(hdrxmlCnt>0){
		
		String[] sortKey = {ORDER};
		hdrXML.sort( sortKey, false );//false for descending	
		java.math.BigDecimal totValue=new java.math.BigDecimal("0");
		int hdrCount=hdrXML.getRowCount();
		
	
		for(int i=0; i< hdrCount; i++)
		{
			poNumber = hdrXML.getFieldValueString(i, ORDER);
			isDisplay = false;
			chkLink = "";
			if(orderType.equals("CDate") && v.contains(poNumber)){
				rowCount = rowCount+1;
				isDisplay=true;
				
				hypLink = "<a href=JavaScript:funLinkNew('ezAddComittedDate.jsp','"+poNumber+"','"+hdrXML.getFieldValueString(i,"NETAMOUNT")+"','"+hdrXML.getFieldValueString(i,"CURRENCY")+"','"+orderType+"','"+sysKey+"','"+soldTo+"')>"+Long.parseLong(poNumber)+"</a>";
				
			}
			else if(orderType.equals("Open") && !v.contains(poNumber)){
				rowCount = rowCount+1;
				isDisplay=true;
				if(orderType.equals("Open") && !userType.equals("3"))
				{
					if(blockedPOs.containsKey(poNumber))
					{
						status =(String)blockedPOs.get(poNumber);
						if(!status.equals("B"))
						{   	
							chkLink = poNumber+"#"+status;
						}
					}
					else
					{
						chkLink = poNumber+"#-";
					}
				}

			        hypLink = "<a href=JavaScript:funLinkNew('ezOpenPoLineitems.jsp','"+poNumber+"','"+hdrXML.getFieldValueString(i,"NETAMOUNT")+"','"+hdrXML.getFieldValueString(i,"CURRENCY")+"','"+orderType+"')>"+Long.parseLong(poNumber)+"</a>";
			}
			else if(orderType.equals("Closed")){
				rowCount = rowCount+1;
				isDisplay=true;
				
				hypLink = "<a href=JavaScript:funLinkNew('ezPoLineitems.jsp','"+poNumber+"','"+hdrXML.getFieldValueString(i,"NETAMOUNT")+"','"+hdrXML.getFieldValueString(i,"CURRENCY")+"','"+orderType+"')>"+Long.parseLong(poNumber)+"</a>";
			}
			else if(orderType.equals("All") && !v.contains(poNumber)){
				rowCount = rowCount+1;
				isDisplay=true;
				
				hypLink = "<a href=JavaScript:funLinkNew('ezPoLineitems.jsp','"+poNumber+"','"+hdrXML.getFieldValueString(i,"NETAMOUNT")+"','"+hdrXML.getFieldValueString(i,"CURRENCY")+"','"+orderType+"')>"+Long.parseLong(poNumber)+"</a>";

			}
			else if ((orderType==null)||(orderType.trim().length()==0)){
				rowCount = rowCount+1;
				isDisplay=true;
				
				hypLink = "<a href=JavaScript:funLinkNew('ezPoLineitems.jsp','"+poNumber+"','"+hdrXML.getFieldValueString(i,"NETAMOUNT")+"','"+hdrXML.getFieldValueString(i,"CURRENCY")+"','"+orderType+"')>"+Long.parseLong(poNumber)+"</a>";
			}
			if(isDisplay){
					ordDate	 = fD.getStringFromDate((java.util.Date)hdrXML.getFieldValue(i, ORDERDATE),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
					earlyDate = fD.getStringFromDate((java.util.Date)hdrXML.getFieldValue(i,DELIVERYDATE),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
					latDate	 = fD.getStringFromDate((java.util.Date)hdrXML.getFieldValue(i,"CONFIRMDELIVERYDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));		
					shipdate = fD.getStringFromDate((java.util.Date)hdrXML.getFieldValue(i,"SHIPDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
					curr 	 = hdrXML.getFieldValueString(i,"CURRENCY");
					if(shipdate==null || "null".equals(shipdate))
						shipdate = "";
					val   	 = myFormat.getCurrencyString(hdrXML.getFieldValueString(i,"NETAMOUNT"));
					try{
						totValue=totValue.add(new java.math.BigDecimal(hdrXML.getFieldValueString(i,"NETAMOUNT")));
					}
					catch(Exception e){
						//out.println(">>>"+e);
					}
					
				if("".equals(chkLink))
				{
					chkLink = poNumber+"";
					out.println("<row id='"+chkLink+"'><cell><![CDATA[<nobr>"+hypLink+"</nobr>]]></cell><cell>"+ordDate+"</cell><cell>"+earlyDate+"</cell><cell>"+latDate+"</cell><cell>"+shipdate+"</cell><cell>"+curr+"</cell><cell>"+val+"</cell></row>");
				}
				else
				{
					String disabled = "";
					if(chkLink.endsWith("#-"))
						disabled = "disabled";
					out.println("<row id='"+chkLink+"'><cell><![CDATA[<nobr><input type=checkbox name=chk1 value="+chkLink+" "+disabled+"></nobr>]]></cell><cell><![CDATA[<nobr>"+hypLink+"</nobr>]]></cell><cell>"+ordDate+"</cell><cell>"+earlyDate+"</cell><cell>"+latDate+"</cell><cell>"+shipdate+"</cell><cell>"+curr+"</cell><cell>"+val+"</cell></row>");		
				}
				
				
			}
			
			
			////out.println("dugfug");
			
			
			
			
			
			
			
			
		}
		if(rowCount==0){
			out.println("<row id='"+rowCount+"'></row>");
			ezc.ezcommon.EzLog4j.log("<row id='"+rowCount+"'></row>"+"NO LOCAL PO---LIST","I");
		
		}
	}
	else if( (rowCount == 0 || hdrxmlCnt == 0) ){
	
		out.println("<row id='"+hdrxmlCnt+"'></row>");
		ezc.ezcommon.EzLog4j.log("<row id='"+hdrxmlCnt+"'></row>"+"NO PO---LIST FROM R/3","I");
		
	}
	
	out.println("</rows>");
%>

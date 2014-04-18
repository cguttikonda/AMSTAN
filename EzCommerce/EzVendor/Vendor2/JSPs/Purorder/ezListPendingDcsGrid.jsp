<%@ include file ="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file ="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file ="../../../Includes/JSPs/Labels/iListPendingDcs_Labels.jsp"%>
<%@ page import  ="java.util.*"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="ShipmentManager" class="ezc.ezshipment.client.EzShipmentManager" scope="session" />
<%
	int Count = 0;
	String site = (String)session.getValue("Site");
	if(site==null || "null".equals(site))
	site="641~999";
	else
	site=site.trim();
	
	String ErpVendor = (String)session.getValue("SOLDTO");
	String clientNo = (String)session.getValue("Site");
	
	if(session.getValue("Site")!=null && "640".equals(clientNo))
		clientNo = "400";
	else
		clientNo = "410";
	
	java.text.NumberFormat numberFormat = java.text.NumberFormat.getInstance();
	numberFormat.setMaximumFractionDigits(0);
	numberFormat.setMinimumFractionDigits(0);
	
	ezc.ezparam.EzcParams params =  new ezc.ezparam.EzcParams(true);
	ezc.ezshipment.params.ezGetOpenGRsParams inParams = new ezc.ezshipment.params.ezGetOpenGRsParams();
	inParams.setVendorNo(ErpVendor);
	inParams.setShortText(clientNo);//SAP CLIENT NO
	params.setObject(inParams);
	Session.prepareParams(params);
	ezc.ezparam.ReturnObjFromRetrieve retGrs = (ezc.ezparam.ReturnObjFromRetrieve)ShipmentManager.ezGetOpenGRList(params);
	if(retGrs != null)
		Count = retGrs.getRowCount();
	
	out.println("<?xml version=\"1.0\"?>");
	out.println("<rows>");
	if(Count > 0)
	{
		String sortField[] = {"GRDATE"};
		retGrs.sort(sortField,false);
		
		String quantity = "",dcNo = "",matDesc = "",dcDate = "",grDate = "",poNo = "",grNo = "";		
		ezc.ezutil.FormatDate formatDate = new ezc.ezutil.FormatDate();	
		for(int i=0;i<Count;i++)
		{
			quantity	= retGrs.getFieldValueString(i,"QUANTITY");
			matDesc		= retGrs.getFieldValueString(i,"MATDESC");	
			dcNo 		= retGrs.getFieldValueString(i,"REFDOCNO");
			grNo		= retGrs.getFieldValueString(i,"GRNO");
			poNo		= Long.parseLong(retGrs.getFieldValueString(i,"PONO"))+"";
			dcDate 		= formatDate.getStringFromDate((java.util.Date)retGrs.getFieldValue(i,"DOCDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
			grDate 		= formatDate.getStringFromDate((java.util.Date)retGrs.getFieldValue(i,"GRDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
			matDesc		= ((matDesc.trim()).length()==0)?"":matDesc;
			if(quantity != null && !"null".equals(quantity) && !"".equals(quantity.trim()))
				quantity = numberFormat.format(Double.valueOf(quantity))+"";
			else	
				quantity = "0";
			quantity = quantity.replaceAll(",","");
			matDesc = matDesc.replaceAll("&","&amp;");
			out.println("<row id='"+poNo+"'><cell>"+dcNo+"</cell><cell>"+dcDate+"</cell><cell>"+poNo+"</cell><cell>"+grNo+"</cell><cell>"+grDate+"</cell><cell>"+matDesc+"</cell><cell>"+quantity+"</cell></row>");
		}	
	}
	else
	{
		out.println("<row id='0'></row>");
	}
	out.println("</rows>");	
%>
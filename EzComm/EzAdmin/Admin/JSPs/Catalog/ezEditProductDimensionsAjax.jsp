<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<%@ page import="ezc.ezparam.*,ezc.ezmisc.params.*"%>
<%
	String prodCode	= request.getParameter("proCode");
	String style 	= request.getParameter("style");
	String size 	= request.getParameter("size");
	String finish	= request.getParameter("finish");
	String width 	= request.getParameter("width");
	String length	= request.getParameter("length");
	String weight 	= request.getParameter("weight");
	String volume 	= request.getParameter("volume");
	
	String lengthUOM	= request.getParameter("lengthUOM");
	String weightUOM	= request.getParameter("weightUOM");
	String volumeUOM	= request.getParameter("volumeUOM");
			
	EzcParams catalogParamsMisc	= new EzcParams(false);
	EziMiscParams catalogParams	= new EziMiscParams();

	catalogParams.setIdenKey("MISC_UPDATE");
	String query ="UPDATE EZC_PRODUCTS SET EZP_STYLE = '"+style+"',EZP_SIZE = '"+size+"',EZP_FINISH = '"+finish+"',EZP_LENGTH = '"+length+"',EZP_LENGTH_UOM = '"+lengthUOM+"',EZP_WIDTH = '"+width+"', EZP_WEIGHT = '"+weight+"',EZP_WEIGHT_UOM = '"+weightUOM+"',EZP_VOLUME = '"+volume+"',EZP_VOLUME_UOM = '"+volumeUOM+"' WHERE EZP_PRODUCT_CODE = '"+prodCode+"'";

	catalogParams.setQuery(query);

	catalogParamsMisc.setLocalStore("Y");
	catalogParamsMisc.setObject(catalogParams);
	Session.prepareParams(catalogParamsMisc);	

	try
	{		
		ezMiscManager.ezUpdate(catalogParamsMisc);
	}
	catch(Exception e)
	{
		out.println("Exception in Getting Data"+e);
	}
	out.print(style+"##"+size+"##"+prodCode+"##"+finish+"##"+width+"##"+length+"##"+lengthUOM+"##"+weight+"##"+weightUOM+"##"+volume+"##"+volumeUOM);
%>
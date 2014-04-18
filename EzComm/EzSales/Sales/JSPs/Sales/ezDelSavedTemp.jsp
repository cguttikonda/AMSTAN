<%@ page import="ezc.ezmisc.params.*" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<%

	ezc.ezparam.EzcParams mainParams= null;
	EziMiscParams miscParams = null;
	
	String webNo  = request.getParameter("webOrdNo");
	String soldTo = request.getParameter("soldTo");
	String schQry = "";
	String success ="";
	
	if(webNo!=null && !"".equals(webNo) && !"null".equals(webNo))
	{
		webNo = webNo.trim(); 
		schQry = "UPDATE EZC_SALES_DOC_HEADER SET ESDH_STATUS='DELETED' WHERE ESDH_DOC_NUMBER = '"+webNo+"'";
		mainParams = new ezc.ezparam.EzcParams(false);
		miscParams = new EziMiscParams();
		miscParams.setIdenKey("MISC_UPDATE");
		miscParams.setQuery(schQry);

		mainParams.setLocalStore("Y");
		mainParams.setObject(miscParams);
		Session.prepareParams(mainParams);	

		try
		{		
			ezc.ezcommon.EzLog4j.log("mainParams.getQuery()::::::::"+schQry ,"I");
			ezMiscManager.ezUpdate(mainParams);
			success = "Y";
			
		}
		catch(Exception e)
		{
			out.println("Exception in Getting Data"+e);
		}		
		
		ezc.ezparam.EzcParams mainParams_W = new ezc.ezparam.EzcParams(false);
		EziMiscParams miscParams_W = new EziMiscParams();
		miscParams_W.setIdenKey("MISC_UPDATE");
		miscParams_W.setQuery("UPDATE EZC_WF_DOC_HISTORY_HEADER SET EWDHH_WF_STATUS='DELETED' WHERE EWDHH_DOC_ID = '"+webNo+"'");

		mainParams_W.setLocalStore("Y");
		mainParams_W.setObject(miscParams_W);
		Session.prepareParams(mainParams_W);	

		try
		{		
			ezc.ezcommon.EzLog4j.log("mainParams.getQuery()::::::::"+schQry ,"I");
			ezMiscManager.ezUpdate(mainParams_W);
			success = "Y";
			out.println(success);
		}
		catch(Exception e)
		{
			out.println("Exception in Getting Data"+e);
		}				
		
		
		
	}
	//out.println("webNo:::::"+webNo+":::soldTo::::"+soldTo);
	if("Y".equals(request.getParameter("fromDetails")))
		response.sendRedirect("../Sales/ezSavedOrders.jsp");
%>
	
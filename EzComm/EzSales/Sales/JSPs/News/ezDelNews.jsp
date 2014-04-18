<%@ page import="ezc.ezmisc.params.*" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<%
	ezc.ezparam.EzcParams mainParams= null;
	EziMiscParams miscParams = null;
	
	String newsId  = request.getParameter("newsId");
	String schQry = "";
	String success ="";
	
	if(newsId!=null && !"".equals(newsId) && !"null".equals(newsId))
	{
		newsId = newsId.trim(); 
		schQry = "UPDATE EZC_NEWS SET EZN_AUTH='D' WHERE EZN_ID='"+newsId+"'";
		mainParams = new ezc.ezparam.EzcParams(false);
		miscParams = new EziMiscParams();
		miscParams.setIdenKey("MISC_UPDATE");
		miscParams.setQuery(schQry);

		mainParams.setLocalStore("Y");
		mainParams.setObject(miscParams);
		Session.prepareParams(mainParams);	

		try
		{		
			ezc.ezcommon.EzLog4j.log("mainParams.getQuery():::::ezDelNews.jsp:::"+schQry ,"I");
			ezMiscManager.ezUpdate(mainParams);
			success = "Y";
			out.println(success);
		}
		catch(Exception e)
		{
			out.println("Exception in Updating News"+e);
		}		
	}
	if("Y".equals(request.getParameter("fromDetails")))
		response.sendRedirect("../Sales/ezListNewsDash.jsp");
%>
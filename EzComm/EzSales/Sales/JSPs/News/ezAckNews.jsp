<%@page import="java.util.*"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%
	String news_id= request.getParameter("newsId");
	Date today = new Date();
	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("MM/dd/yyyy");
	ezc.eznews.client.EzNewsManager newsManager = null;
	ezc.eznews.params.EziNewsParams newsParam = null;
	ezc.ezparam.EzcParams mainParams_N=null;
	if(news_id!=null)
	{
		mainParams_N=new ezc.ezparam.EzcParams(true);
		newsManager = new ezc.eznews.client.EzNewsManager();
		newsParam = new ezc.eznews.params.EziNewsParams();	
	
		newsParam.setQType("ACK");
		newsParam.setTrackAckFlag("Y");
		newsParam.setTrackAckDate(formatter.format(today));
		newsParam.setNewsId(news_id);
		mainParams_N.setLocalStore("Y");
		mainParams_N.setObject(newsParam);
		Session.prepareParams(mainParams_N);
	
		newsManager.ezGetNews(mainParams_N);
	
	}
	response.sendRedirect("../News/ezListNewsDash.jsp");
%>
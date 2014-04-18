<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>

<%
	String news = request.getParameter("news");
	String newsStrtDate = request.getParameter("newsStrtDate");
	String newsEndDate = request.getParameter("newsEndDate");
	String role = request.getParameter("role");
	String group = request.getParameter("group");
	String syskey = request.getParameter("syskey");
	String newsType = request.getParameter("newsType"); 
	
	news = news.replaceAll("'","`");

	ezc.ezparam.ReturnObjFromRetrieve myRet = null;
	ezc.ezparam.EzcParams mainParams=new ezc.ezparam.EzcParams(false);
	ezc.eznews.client.EzNewsManager newsManager = new ezc.eznews.client.EzNewsManager();
	ezc.eznews.params.EziNewsParams newsParam = new ezc.eznews.params.EziNewsParams();
	
	newsParam.setNewsSyskey(syskey);
	newsParam.setNewsCreatedBy("EZCADMIN");
	newsParam.setNewsModifiedBy("EZCADMIN");
	newsParam.setNewsEndDate(newsEndDate);
	newsParam.setNewsStartDate(newsStrtDate);
	newsParam.setNewsGroup(group);
	newsParam.setNewsRole(role);
	newsParam.setNewsType(newsType);
	newsParam.setNewsText(news);
	
	mainParams.setLocalStore("Y");
	mainParams.setObject(newsParam);
	Session.prepareParams(mainParams);
	try{
		newsManager.ezAddNews(mainParams);
	}catch(Exception e){}	
	
	response.sendRedirect("ezListNews.jsp?syskey="+syskey);
%>


	 
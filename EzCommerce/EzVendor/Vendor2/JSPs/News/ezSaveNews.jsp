<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>

<%
	ezc.eznews.client.EzNewsManager newsManager = new ezc.eznews.client.EzNewsManager();
	ezc.ezparam.EzcParams mainParams=new ezc.ezparam.EzcParams(false);
	ezc.ezparam.ReturnObjFromRetrieve myRet = null;
	
	ezc.eznews.params.EziNewsParams newsParam = new ezc.eznews.params.EziNewsParams();
	
	newsParam.setNewsSyskey("999301");
	newsParam.setNewsCreatedBy("PURPERSON");
	newsParam.setNewsModifiedBy("PURPERSON");
	newsParam.setNewsEndDate("10.12.2005");//newsEndDate
	newsParam.setNewsStartDate("10.12.2005");//newsStrtDate
	newsParam.setNewsGroup("PP");
	newsParam.setNewsRole("Purchase Person");
	newsParam.setNewsType("PBD");
	newsParam.setNewsText("News From Matrix");
	
	mainParams.setLocalStore("Y");
	mainParams.setObject(newsParam);
	Session.prepareParams(mainParams);
		
	System.out.println("Before calling newsManager.ezAddNews..............");	
	myRet=(ezc.ezparam.ReturnObjFromRetrieve)newsManager.ezAddNews(mainParams);
	System.out.println("After calling newsManager.ezAddNews..............");	
	
%>


	 
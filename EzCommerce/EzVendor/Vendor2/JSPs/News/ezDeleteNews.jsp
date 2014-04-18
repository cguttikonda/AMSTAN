<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>

<%
	String syskey = request.getParameter("syskey");
	String deleteStr[] = request.getParameterValues("chk1");
	String deletedNewsStr = "";
	
	for(int i=0;i<deleteStr.length;i++)
	{
		ezc.ezbasicutil.EzStringTokenizer Tokens = new ezc.ezbasicutil.EzStringTokenizer(deleteStr[i],"$$");
		java.util.Vector Vect = Tokens.getTokens();
		deletedNewsStr += (String)Vect.elementAt(0)+"','";
		
	}	
	
	if(deletedNewsStr.length()>3) deletedNewsStr =deletedNewsStr.substring(0,deletedNewsStr.length()-3);
	
	ezc.ezparam.ReturnObjFromRetrieve myRet = null;
	ezc.ezparam.EzcParams mainParams=new ezc.ezparam.EzcParams(false);
	ezc.eznews.client.EzNewsManager newsManager = new ezc.eznews.client.EzNewsManager();
	ezc.eznews.params.EziNewsParams newsParam = new ezc.eznews.params.EziNewsParams();

	mainParams.setLocalStore("Y");
	newsParam.setNewsId(deletedNewsStr);
	mainParams.setObject(newsParam);
	Session.prepareParams(mainParams);
	try{
		newsManager.ezDeleteNews(mainParams);
	}catch(Exception e){}	
	
	response.sendRedirect("ezListNews.jsp?syskey="+syskey);
%>
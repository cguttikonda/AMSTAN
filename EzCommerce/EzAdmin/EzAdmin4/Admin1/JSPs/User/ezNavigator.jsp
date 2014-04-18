<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<input type="hidden" name="myUserType" value = "<%=myUserType%>" >
<input type="hidden" name="mySearchcriteria" value="<%=mySearchcriteria%>" >
<input type=hidden name="myArea" value="<%=myArea%>" >
<input type="hidden" name="myWebSysKey" value="<%=myWebSysKey%>" >


<%
	String myUserType = request.getParameter("myUserType");
	String mySearchcriteria = request.getParameter("mySearchcriteria");
	String myArea = request.getParameter("myArea");
	String myWebSysKey = request.getParameter("myWebSysKey");	
%>	

	
 --------------------------------------------------------------------------------------




	String myUserType = (String)session.getValue("myUserType");
	String myWebSyskey = (String)session.getValue("myWebSyskey");
	String myAreaFlag = (String)session.getValue("myAreaFlag");
	String mySearchCriteria = (String)session.getValue("mySearchCriteria");


?WebSysKey="+myWebSyskey+"&Area="+myAreaFlag+"&myUserType="+myUserType+"&searchcriteria="+mySearchCriteria




	session.putValue("myUserType",myUserType);
	session.putValue("myWebSyskey",websyskey);
	session.putValue("myAreaFlag",areaFlag);
	session.putValue("mySearchCriteria",searchCriteria);
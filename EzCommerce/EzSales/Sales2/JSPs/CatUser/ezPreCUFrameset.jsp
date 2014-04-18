<%
	ezc.ezcommon.EzLog4j.log("ezPreCUFrameset.jsp>> ValidSalesUser >>>>>>>>>>"+session.getValue("ValidSalesUser"),"I");
	ezc.ezcommon.EzLog4j.log("ezPreCUFrameset.jsp>>>>>>session>>>>"+session.isNew(),"I");
%>
<%@ page import="java.util.*" %>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp" %>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iAddWebStats.jsp"%>
<%
	//session.putValue("welcome","1");
	//response.sendRedirect("ezCatUserFrameset.jsp"); 
%>
<jsp:forward page="ezCatUserFrameset.jsp"/>
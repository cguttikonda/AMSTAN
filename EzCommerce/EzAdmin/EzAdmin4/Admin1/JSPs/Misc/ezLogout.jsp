<%@ page language="java" errorPage="ezErrorDisplay.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" /> 
<%@ include file="../../../Includes/JSPs/Misc/iUpdateWebStats.jsp"%>
<%

  Session.logOut();

  session.removeAttribute("Session");
  session.invalidate();
  %>

<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
<head>
 	<meta http-equiv="refresh" content="1;url=/">
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
   	<meta name="Author" content="Nitin Shiralkar">
   	<meta name="GENERATOR" content="Mozilla/4.5 [en] (WinNT; I) [Netscape]">
   	<Title>Logout</Title>
</head>
<body onUnload="history.forward()">
&nbsp;
<br>&nbsp;
<br>&nbsp;
<br>&nbsp;
<br>&nbsp;
<br>&nbsp;
<br>&nbsp;
<br>&nbsp;
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size=+2>&nbsp;
You have been Successfully logged out ..........................</font>
<br><font size=+2></font>&nbsp;
</body>
</html>

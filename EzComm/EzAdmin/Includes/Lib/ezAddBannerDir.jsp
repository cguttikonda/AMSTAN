
<%
	session.putValue("MYLOGINMILLIS",String.valueOf(System.currentTimeMillis()));
	response.setHeader("Pragma", "No-cache");
	response.setDateHeader("Expires", -1);
	response.setHeader("Cache-Control", "no-cache");
	
         String menuDir 	= (String)session.getValue("userStyle");
         String userLang_meta 	= (String)session.getValue("userLang");
	if(menuDir==null || "".equals(menuDir) || " ".equals(menuDir))
         	menuDir = "BROWN";
         else
         	menuDir = menuDir.toUpperCase();
         	
%>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="../../Library/Styles/Menu/<%=menuDir%>.css">



<%
	response.setHeader("Pragma", "No-cache");
	response.setDateHeader("Expires", -1);
	response.setHeader("Cache-Control", "no-cache");
	
         String menuDir 	= (String)session.getValue("userStyle");
         String userLang_meta 	= (String)session.getValue("userLang");
	if(menuDir==null || "".equals(menuDir) || " ".equals(menuDir))
         	menuDir = "BROWN";
         else
         	menuDir = "BROWN";
         	
%>
	<meta http-equiv="Content-Type" content="text/html;charset=<%= "RUSSIAN".equals(userLang_meta)?"iso-8859-5":"iso-8859-1"%>"> 
	<link rel="stylesheet" href="../../Library/Styles/Menu/<%=menuDir%>.css">


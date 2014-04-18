<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>


<%
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
	<meta http-equiv="Content-Type" content="text/html;charset=<%= "RUSSIAN".equals(userLang_meta)?"iso-8859-5":"iso-8859-1"%>"> 
	<link rel="stylesheet" href="../../Library/Styles/Menu/<%=menuDir%>.css">
<%
	if("BROWN".equals(menuDir))
	{
		session.putValue("fontColor","#00326B");
		session.putValue("fontColorOver","#00326B");
		session.putValue("menuBGColor","#C9D4DA");					
		session.putValue("menuBGColorOver","#EDF1F4");
		session.putValue("menuSeperatorColor","#000000");
		session.putValue("menuSeperatorColor1","#000000");
	}else if("BLUE".equals(menuDir)){
		session.putValue("fontColor","#FFFFFF");
		session.putValue("fontColorOver","#FFFFFF");
		session.putValue("menuBGColor","#0088bb");					
		session.putValue("menuBGColorOver","#225555");
		session.putValue("menuSeperatorColor","#225555");
		session.putValue("menuSeperatorColor1","#000000");
	}else if("GREEN".equals(menuDir)){
		session.putValue("fontColor","#FFFFFF");
		session.putValue("fontColorOver","#224400");
		session.putValue("menuBGColor","#224400");					
		session.putValue("menuBGColorOver","#bbffdd");
		session.putValue("menuSeperatorColor","#000000");
		session.putValue("menuSeperatorColor1","#000000");
	
	}else if("BROWN".equals(menuDir)){
		session.putValue("fontColor","#FFFFFF");
		session.putValue("fontColorOver","#660000");
		session.putValue("menuBGColor","#660000");					
		session.putValue("menuBGColorOver","#d4eaf8");
		session.putValue("menuSeperatorColor","#000000");
		session.putValue("menuSeperatorColor1","#000000");
	
	}else if("PINK".equals(menuDir)){
		session.putValue("fontColor","#FFFFFF");
		session.putValue("fontColorOver","#000000");
		session.putValue("menuBGColor","#990099");					
		session.putValue("menuBGColorOver","#ffddbb");
		session.putValue("menuSeperatorColor","#ffddbb");
		session.putValue("menuSeperatorColor1","#ffddbb");
	
	}else if("YELLOW".equals(menuDir)){
		session.putValue("fontColor","#FFFFFF");
		session.putValue("fontColorOver","#000000");
		session.putValue("menuBGColor","#cc9900");					
		session.putValue("menuBGColorOver","#55ddff");
		session.putValue("menuSeperatorColor","#000000");
		session.putValue("menuSeperatorColor1","#000000");
	
	}else if("DARKBLUE".equals(menuDir)){
		session.putValue("fontColor","#FFFFFF");
		session.putValue("fontColorOver","#003355");
		session.putValue("menuBGColor","#003355");					
		session.putValue("menuBGColorOver","#bbddff");
		session.putValue("menuSeperatorColor","#000000");
		session.putValue("menuSeperatorColor1","#000000");
	
	}else{
		session.putValue("fontColor","#FFFFFF");
		session.putValue("fontColorOver","#660000");
		session.putValue("menuBGColor","#660000");					
		session.putValue("menuBGColorOver","#d4eaf8");
		session.putValue("menuSeperatorColor","#000000");
		session.putValue("menuSeperatorColor1","#000000");	
	}
%>

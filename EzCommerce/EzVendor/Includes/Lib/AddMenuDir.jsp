<%
	response.setHeader("Pragma", "No-cache");
	response.setDateHeader("Expires", 0);
	response.setHeader("Cache-Control", "no-cache");
	String ButtonDir = (String)session.getValue("userStyle");
	String userLang_meta = (String)session.getValue("userLang");
        ButtonDir = "PINK";
	if(("PINK").equals(ButtonDir))
	{
%>
		<link rel="stylesheet" href="../../Library/Styles/Menu/BROWN.css">
<%
		session.putValue("fontColor","#00326B");
		session.putValue("fontColorOver","#00326B");
		session.putValue("menuBGColor","#C9D4DA");					
		session.putValue("menuBGColorOver","#EDF1F4");
		session.putValue("menuSeperatorColor","#000000");
		session.putValue("menuSeperatorColor1","#000000");
	}
%>
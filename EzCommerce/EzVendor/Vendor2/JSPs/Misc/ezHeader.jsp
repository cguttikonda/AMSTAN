<HTML>
<HEAD>
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

<link rel="stylesheet" href="../../Library/Styles/Menu/<%=menuDir%>.css">
</HEAD>
<Body leftMargin=0 topMargin=0 MARGINWIDTH="0" MARGINHEIGHT="0" >

<TABLE cellSpacing=0 cellPadding=0 width="100%" align=center border=0 >
<TR>
	<TD>
		<IMG src="../../../../EzCommon/Images/Banner/ezc_logof.jpg" border=0 style='width:100%'>
	</TD>
	<TD>
		<IMG src="../../../../EzCommon/Images/Banner/banner_ext1.jpg" border=0 style='width:100%'>
	</TD>
</TR>
</TABLE>
<Div id="MenuSol"></Div>
</BODY>
</HTML>
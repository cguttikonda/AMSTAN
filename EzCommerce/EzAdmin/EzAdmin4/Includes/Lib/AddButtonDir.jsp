<%@ include file="../../Admin1/Library/Globals/CacheControl.jsp"%>
<%
        String ButtonDir = (String)session.getValue("userStyle");
        if(ButtonDir==null || "".equals(ButtonDir) || " ".equals(ButtonDir))
        	ButtonDir = "LAVENDER";
        

        if(("BROWN").equals(ButtonDir)) 
	{         
%>


                <link rel="stylesheet" href="../../Library/Styles/Theme0.css">
<%		session.putValue("fontColor","white");
		session.putValue("fontColorOver","black");
		session.putValue("menuBGColor","#818181");
		session.putValue("menuBGColorOver","#F3EDD8");
		session.putValue("menuSeperatorColor","#F3EDD8");
		session.putValue("menuSeperatorColor1","black");
		session.putValue("Table_BgColor","#818181");
		session.putValue("Td_TodayOverColor","#F3EDD8");
		session.putValue("Txt_TodayOverColor","#000000");
		session.putValue("Txt_TodayOutColor","#ffffff");
		session.putValue("Td_TodayCellOverColor","yellow");
	}			
        else if(("LAVENDER").equals(ButtonDir))
        {
%>
		<link rel="stylesheet" href="../../Library/Styles/kiss.css">
<%		session.putValue("fontColor","#000066");
		session.putValue("fontColorOver","#000000");
		session.putValue("menuBGColor","#9BB3EA");
		session.putValue("menuBGColorOver","#D7E1F7");
		session.putValue("menuSeperatorColor","#9BB3EA");
		session.putValue("menuSeperatorColor1","#000000");
		session.putValue("Table_BgColor","#9BB3EA");
		session.putValue("Td_TodayOverColor","#9BB3EA");
		session.putValue("Txt_TodayOverColor","#000000");
		session.putValue("Txt_TodayOutColor","#ffffff");
		session.putValue("Td_TodayCellOverColor","#9BB3EA");  
	}
	else if(("YELLOW").equals(ButtonDir))
	{
%>
		<link rel="stylesheet" href="../../Library/Styles/Theme7.css"> 
<%
		session.putValue("fontColor","#000066");
		session.putValue("fontColorOver","#ffcc66");
		session.putValue("menuBGColor","#ffcc66");
		session.putValue("menuBGColorOver","#000066");
		session.putValue("menuSeperatorColor","#ffcc66");
		session.putValue("menuSeperatorColor1","#000000");
		session.putValue("Table_BgColor","#ffcc66");
		session.putValue("Td_TodayOverColor","#ffcc66");
		session.putValue("Txt_TodayOverColor","#000000");
		session.putValue("Txt_TodayOutColor","#ffffff");
		session.putValue("Td_TodayCellOverColor","yellow");  
	}
        else
        {
%>
		<link rel="stylesheet" href="../../Library/Styles/kiss.css"> 
<%		session.putValue("fontColor","#000000");
		session.putValue("fontColorOver","#ffffff");
		session.putValue("menuBGColor","#ffcc66");
		session.putValue("menuBGColorOver","e7e7e7");
		session.putValue("menuSeperatorColor","e7e7e7");
		session.putValue("menuSeperatorColor1","black");
		session.putValue("Table_BgColor","#4061A4");
		session.putValue("Td_TodayOverColor","e7e7e7");
		session.putValue("Txt_TodayOverColor","#000000");
		session.putValue("Txt_TodayOutColor","#ffffff");
		session.putValue("Td_TodayCellOverColor","yellow");		
	}
%>
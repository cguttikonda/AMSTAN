<style>
<!--
a:active {color: #blue}
a:hover {color: #coral}
a:link {color: #blue}

.subclass
	{
	font-family: Verdana;
	font-size: 10pt;
	font-style: normal;
	font-weight: normal;
	color: white;
	}
a.subclass
	{
	color: white;
	text-decoration:underline;
	}
a.subclass:active {color: yellow}
a.subclass:hover {color: yellow}
a.subclass:link {color: yellow}
a.subclass:visited{color: WHITE}

.submenuclass{}
a.submenuclass
	{
	color: white;
	text-decoration:underline;
	}
a.submenuclass:active {color: white}
a.submenuclass:hover {color: whitew}
a.submenuclass:link {color: white}
a.submenuclass:visited{color: WHITE}


td 
	{
	font-family: "Arial, Helvetica"; 
	font-size: 10pt; 
	font-style: bold; 
	color: <%= session.getValue("Header")%>;
	background-color: <%= session.getValue("Body")%>;
	}
.tabclass{}
td.tabclass{background-color: #CCCCCC}

.mainmenuclass{}
td.mainmenuclass{background-color: <%= session.getValue("Header")%>}

.bgcolorclass{}
body.bgcolorclass{background-color: <%= session.getValue("Header")%>}

.bodyclass{}
body.bodyclass{background-color: <%= session.getValue("Header")%>}

.bodymenuclass{}
body.bodymenuclass{background-color: <%= session.getValue("Header")%>}

.menucell{}
td.menucell{background-color: <%= session.getValue("Header")%>}

.bannercell{}
td.bannercell{background-color: <%= session.getValue("Header")%>}

.tdmenuclass{}
td.tdmenuclass{color: #ffffff;
               background-color: <%= session.getValue("Header")%>} 


.bannerbody{}
body.bannerbody{background-color: <%= session.getValue("Header")%>}
td.bannerbody{background-color: <%= session.getValue("Header")%>}

.displayheader{}
td.displayheader{
	font-family: "Arial"; 
	font-size: 14pt; 
	font-style: bold; 
	color: <%= session.getValue("Body")%>;
	background-color: <%= session.getValue("Header")%>
}

.labelcell{}
td.labelcell{
	font-family: "Trebuchet MS"; 
	font-size: 10pt; 
	font-style: normal; 
	color: <%= session.getValue("Body")%>;
	background-color: <%= session.getValue("Header")%>
}

.blankcell{}
td.blankcell{
	background-color: #FFFFFF
}
TD.btnup 
	{
    	cursor: hand;
    	color: <%=session.getValue("Body")%>;
    	background-color: <%=session.getValue("Header")%>;
    	padding: 1 8px;
    	border: outset <%=session.getValue("Body")%> 3px;
    	
	font-family: arial,sans-serif;
	font-size: 10pt;
	font-weight: bold;
	}
TD.btnoff 
	{
    	color: <%=session.getValue("Header")%>;
    	background-color: <%=session.getValue("Body")%>;
    	padding: 1 8px;    	
    	border: solid <%=session.getValue("Header")%> 3px;
    	
	font-family: arial,sans-serif;
	font-size: 10pt;
	font-weight: bold;
	}
table {  
	font-family: "Courier New", Courier, mono; 
	font-size: 14pt; 
	font-style: normal; 
	color: <%= session.getValue("Header")%>
}
th {  
	font-family: Verdana; 
	font-size: 10pt; 
	font-style: normal; 
	font-weight: bold; 
	color: <%= session.getValue("Body")%>; 
	background-color: <%= session.getValue("Header")%>
}
body {  
	color: <%= session.getValue("Header")%>; 
	background-color: #FFFFFF
}
tr {  
	font-family: "Trebuchet MS"; 
	font-size: 10pt; 
	font-style: normal; 
	line-height: normal; 
	font-weight: normal; 
	color: #000066
}

p {  
	font-family: "Arial, Helvetica"; 
	font-size: 11pt; 
	font-style: normal; 
	color: #4682B4
}

.InputBox
    {
	  BORDER-RIGHT:black 1px inset;
	  BORDER-TOP: white 1px inset;
	  BORDER-LEFT: white 1px inset;
	  BORDER-BOTTOM: black 1px inset;
	  FONT-FAMILY: Verdana;
    }
-->
</style>
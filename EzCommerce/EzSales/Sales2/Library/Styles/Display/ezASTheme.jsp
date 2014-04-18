<style >
<!--
active {color: blue}
hover {color: coral}
link {color: indigo}

.subclass{
	font-family: arial,sans-serif;
	font-size: 10px;
	font-style: normal;
	font-weight: normal;
	color: white;
}
a.subclass{
	color: white;
	text-decoration:underline;
}
a.subclass:active {color: yellow}
a.subclass:hover {color: yellow}
a.subclass:link {color: yellow}
a.subclass:visited{color: white}

table {  
	font-family: arial,sans-serif;
	font-size: 10px; 
	font-style: normal; 
	color: #00385D
}
th {  
	color: #FFFFFF;
	font-family: arial,sans-serif;
	font-size: 11px;
    	text-decoration: none;
    	background-color: #227A7A
}
tr {  
	font-family: arial,sans-serif;
	font-size: 11px; 
	font-style: normal; 
	line-height: normal; 
	font-weight: normal; 
	color: #227A7A
}
td {
	color: #000000;
	font-family: arial,sans-serif;
    	font-size: 11px;
    	background-color: #ABCDCE
}
.iframebody{
	background-color: #ABCDCE
	

}

TD.InvalidMaterial 
{
	background-color:#FF6633
}

p {
	font-family: arial,sans-serif;
	font-size: 11px;
	font-style: normal;
	color: #00385d;
}

.bodyclass{}
body.bodyclass{background-color: #00385D}

.welcomebody{}
body.welcomebody{background-color: #ffffff}

.displayheader{}
td.displayheader{
   color: #00385D;
   font-family: arial,sans-serif;
   font-size: 12px;
   font-weight: 600;
   text-decoration: none;

}
.displayheaderback{
	filter:progid:DXImageTransform.Microsoft.Gradient(GradientType=0,StartColorStr='#F1F4F5',EndColorStr='#F1F4F5');
	font-size: 12px; 
	font-style: bold; 
	font-weight: 600; 
	color: #00385D	   
}

.displayalert{}
td.displayalert{
   color: #00326B;
   font-family: arial,sans-serif;
   font-size: 12px;
   font-weight: 600;
   background-color: #ffffff;
   text-decoration: none;

}
.labelcell{}
td.labelcell{
	font-family: arial,sans-serif;
	font-size: 10px;
	font-style: normal;
	color: #FFFFFF;
	background-color: #00385D
}

.blankcell{}
td.blankcell{
	background-color: #ffffff
}
.welcomecell{}
td.welcomecell
{
	background-color: #ABCDCE
	font-size: 10px;
	color:#00385D
}
.credit{}
td.credit{color:black}

.debit{}
td.debit{color:red}

body {
	color: #00385d;
	background-color: #FFFFFF;
	overflow-y : scroll;
	scrollbar-3dlight-color:#000000;
	scrollbar-arrow-color:#02335E;
	scrollbar-base-color:#000000;
	scrollbar-darkshadow-color:#000000;
	scrollbar-highlight-color:#FFFFFF;
	scrollbar-shadow-color:#000000;
	Scrollbar-Track-Color :#FFFFFF
}

.txcredit {
	font-family: arial,sans-serif;
	border:none;
	font-size: 9px;
	background-color:#ffffff;
	color: #000000
}

.txdebit {
	font-family: arial,sans-serif;
	border:none;
	font-size: 9px;
	background-color:#ffffff;
	color:red;

}

.tx {
	font-family: arial,sans-serif;
	border:0;
	font-size: 10px;
	background-color:#ABCDCE;
	text-align:left;
	color: #00385D
}
.inputbox
{
		  font-size: 10px;
 		  border-right:#00385D 1px inset;
 		  border-top: white 1px inset;
 		  border-left: white 1px inset;
 		  border-bottom: #00385D 1px inset;
 		  font-family: arial,sans-serif
}

select{
	font-family: arial,sans-serif;
	border:none;
	font-size: 10px;
	background-color:#FFFFFF;
	color:#00385D

}
.alertcell{
	color: #00385D;
	font-family: arial,sans-serif;
	font-size: 11px;
	font-weight: 600;
   	text-decoration: none
}
.txarea{
  overflow:auto;
  border-right:#00385D 1px inset;
  border-top: white 1px inset;
  border-left: white 1px inset;
  border-bottom: #00385D 1px inset;
  font-family: arial,sans-serif;
  cursor:pointer;
  
  	   scrollbar-3dlight-color:#ccbbbb;
           scrollbar-arrow-color:#ccbbbb;
           scrollbar-base-color:#00385D;
           scrollbar-darkshadow-color:#ccbbbb;
           scrollbar-highlight-color:#ccbbbb;
           scrollbar-shadow-color:#ccbbbb;
	   Scrollbar-Track-Color :white;

}
.tablehelp{}
table.tablehelp{
  border-right:#00385D 1px inset;
  border-top: #00385D 1px inset;
  border-left: #00385D 1px inset;
  border-bottom: #00385D 1px inset;
  font-family: arial,sans-serif;
}
table.tablesubhelp{
   border-right#FFCCCC 1px outset;
   border-top: #00385D 1px outset;
   border-left: #00385D 1px outset;
   border-bottom: #FFCCCC 1px outset;
   font-family: arial,sans-serif;
}
.thhelp{}
th.thhelp{
	font-family: arial,sans-serif;
	font-size: 10px;
	font-style: normal;
	color: #000000;
	background-color: #FFCCCC

}

.tdhelp{}
td.tdhelp{
	font-family: arial,sans-serif;
	font-size: 10px;
	font-style: normal;
	color: #00385D;
	background-color: #E1E8EE

}

TABLE.buttonTable {

}
TD.TDCmdBtnOff 
{
	color: #003168;
	Filter: Chroma(Color = #ABCDCE);
	filter:progid:DXImageTransform.Microsoft.Gradient(GradientType=0,StartColorStr='#FFFFFF',EndColorStr='#ABCDCE');
	padding: 2px 2px 2px 2px;
	tab-index: 0;
	background-color: #ABCDCE;
	border: outset #ABCDCE 1px;
	font-family: tahoma;
	font-size: 10px;
	line-height: 14px;
	font-weight: bold;
	vertical-align: top;
}
TD.TDCmdBtnDown 
{
	color: #003168;
	Filter: Chroma(Color = #ABCDCE);
	filter:progid:DXImageTransform.Microsoft.Gradient(GradientType=0,StartColorStr='#ABCDCE',EndColorStr='#FFFFFF');
	padding: 2px 2px 2px 2px;
	tab-index: 0;
	background-color: #ABCDCE;
	border: outset #ABCDCE 1px;
	font-family: tahoma;
	font-size: 10px;
	line-height: 14px;
	font-weight: bold;
	vertical-align: top;
	cursor:pointer;
	
}
TD.TDCmdBtnUp 
{
	color: #000000;
	Filter: Chroma(Color = #ffCC00);
	filter:progid:DXImageTransform.Microsoft.Gradient(GradientType=0,StartColorStr='#ABCDCE',EndColorStr='#FFFFFF');
	padding: 2px 2px 2px 2px;
	tab-index: 0;
	background-color: #6C6A6B;
	border: outset #6C6A6B 1px;
	font-family: tahoma;
	font-size: 10px;
	line-height: 14px;
	font-weight: bold;
	vertical-align: top;
	cursor:pointer;
}
TD.TDCommandBarBorder 
{
	background-color: #ffffff;
}


div#search input.input-search {
	padding: 3px 2px 3px 23px;
	font-size: 11px;
	font-family: Verdana, Helvetica, Arial, Helvetica, sans-serif;
	color: #666;
	background: #FFF url(../../../Images/Common/search-icon.gif) no-repeat 4px 2px;
	border: 1px solid #89B5EB;
	width: 139px;
	_height: 21px;
	position: relative;
	top: 2px;	
	_width: 165px; 
}

div#search div.in {
	font-size: 10px;
	font-family: Verdana, Helvetica, Arial, Helvetica, sans-serif;
	font-weight: bold;
	color: #37517E;
	width: 100%;
	display: block;
	margin-bottom: 2px;
}


.urbangreymenu{
width: 130px; /*width of menu*/
}

.urbangreymenu .headerbar{
font: bold 11px Arial;
color: white;
background: #000000 url(media/arrowstop.gif) no-repeat 8px 6px; /*last 2 values are the x and y coordinates of bullet image*/
margin-bottom: 0; /*bottom spacing between header and rest of content*/
padding: 7px 0 7px 8px; /*8px is left indentation of header text*/
line-height: 10px;
}

.urbangreymenu ul{
list-style-type: none;
margin: 0;
padding: 0;
margin-bottom: 0; /*bottom spacing between each UL and rest of content*/
}

.urbangreymenu ul li{
padding-bottom: 2px; /*bottom spacing between menu items*/
}

.urbangreymenu ul li a{
font: bold 10px Arial;
color: black;
background: url(arrowbullet.png) no-repeat center left; /*custom bullet list image*/
display: block;
padding: 2px 0;
padding-left: 19px; /*link text is indented 19px*/
text-decoration: none;
border-bottom: 1px solid #DADADA;
}

.urbangreymenu ul li a:visited{
color: black;
}

.urbangreymenu ul li a:hover{ /*hover state CSS*/
color: white;
background: #0B305F;
}



}



-->
</style>

 
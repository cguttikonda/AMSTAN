<style >
<!--
active {color: blue}
hover {color: coral}
link {color: indigo}

.subclass{
	font-family: verdana, arial;
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
	font-family: verdana, arial;
	font-size: 9px; 
	font-style: normal; 
	color: #00385D
}
th {  
	color: #000000;
	font-family: verdana, arial;
	font-size: 11px;
    	text-decoration: none;
    	background-color: #B3B3B3
}
tr {  
	font-family: verdana, arial;
	font-size: 9px; 
	font-style: normal; 
	line-height: normal; 
	font-weight: normal; 
	color: #00385D
}
td {
	color: #000000;
	font-family: tahoma;
    	font-size: 11px;
    	background-color: #D9E5F2
}

p {
	font-family: verdana, arial;
	font-size: 11px;
	font-style: normal;
	color: #FFAFAF;
}

.bodyclass{}
body.bodyclass{background-color: #00385D}

.welcomebody{}
body.welcomebody{background-color: #ffffff}

.displayheader{}
td.displayheader{
   color: #00385D;
   font-family: verdana, arial;
   font-size: 12px;
   font-weight: 600;
   text-decoration: none;

}
.displayheaderback{
	filter:progid:DXImageTransform.Microsoft.Gradient(GradientType=0,StartColorStr='#CBDBEA',EndColorStr='#CBDBEA');
	font-size: 12px; 
	font-style: bold; 
	font-weight: 600; 
	color: #225A8D	   
}

.displayalert{}
td.displayalert{
   color: #00326B;
   font-family: verdana, arial;
   font-size: 12px;
   font-weight: 600;
   background-color: #ffffff;
   text-decoration: none;

}
.labelcell{}
td.labelcell{
	font-family: verdana, arial;
	font-size: 9px;
	font-style: normal;
	color: #ffffff;
	background-color: #00385D
}

.blankcell{}
td.blankcell{
	background-color: #ffffff
}
.welcomecell{}
td.welcomecell
{
	background-color: #FFFFFF
	font-size: 9px;
	color:#00385D
}
.credit{}
td.credit{color:black}

.debit{}
td.debit{color:red}

body {
	color: #00385d;
	background-color: #FFFFFF;
	scrollbar-3dlight-color:#CACACA;
	scrollbar-arrow-color:#02335E;
	scrollbar-base-color:#CACACA;
	scrollbar-darkshadow-color:#CACACA;
	scrollbar-highlight-color:#FFFFFF;
	scrollbar-shadow-color:#000000;
	Scrollbar-Track-Color :#FFFFFF
}

.txcredit {
	font-family: verdana, arial;
	border:none;
	font-size: 9px;
	background-color:#ffffff;
	color: #000000
}

.txdebit {
	font-family: verdana, arial;
	border:none;
	font-size: 9px;
	background-color:#ffffff;
	color:red;

}

.tx {
	font-family: verdana, arial;
	border:0;
	font-size: 9px;
	background-color:#D9E5F2;
	text-align:left;
	color: #00385D
}
.inputbox
{
		  font-size: 9px;
 		  border-right:#00385D 1px inset;
 		  border-top: white 1px inset;
 		  border-left: white 1px inset;
 		  border-bottom: #00385D 1px inset;
 		  font-family: verdana, arial
}
select{
	font-family: verdana, arial;
	border:none;
	font-size: 9px;
	background-color:#ffffff;
	color:#00385D

}
.alertcell{
	color: #00385D;
	font-family: verdana, arial;
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
  font-family: verdana, arial;
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
  font-family: verdana, arial;
}
table.tablesubhelp{
   border-right#FFCCCC 1px outset;
   border-top: #00385D 1px outset;
   border-left: #00385D 1px outset;
   border-bottom: #FFCCCC 1px outset;
   font-family: verdana, arial;
}
.thhelp{}
th.thhelp{
	font-family: verdana, arial;
	font-size: 9px;
	font-style: normal;
	color: #000000;
	background-color: #FFCCCC

}

.tdhelp{}
td.tdhelp{
	font-family: verdana, arial;
	font-size: 9px;
	font-style: normal;
	color: #00385D;
	background-color: #E1E8EE

}

TABLE.buttonTable {

}
TD.TDCmdBtnOff 
{
	color: #000000;
	Filter: Chroma(Color = #ffCC00);
	filter:progid:DXImageTransform.Microsoft.Gradient(GradientType=0,StartColorStr='#FAEEB1',EndColorStr='#FAEEB1');
	padding: 2px 2px 2px 2px;
	tab-index: 0;
	background-color: #6C6A6B;
	border: outset #6C6A6B 1px;
	font-family: tahoma;
	font-size: 10px;
	line-height: 14px;
	font-weight: bold;
	vertical-align: top;
}
TD.TDCmdBtnDown 
{
	color: #000000;
	Filter: Chroma(Color = #ffCC00);
	filter:progid:DXImageTransform.Microsoft.Gradient(GradientType=0,StartColorStr='#FFC54E',EndColorStr='#FFC54E');
	padding: 2px 2px 2px 2px;
	tab-index: 0;
	background-color: #6C6A6B;
	border: outset #6C6A6B 1px;
	font-family: tahoma;
	font-size: 10px;
	line-height: 14px;
	font-weight: bold;
	vertical-align: top;
	cursor: hand;
}
TD.TDCmdBtnUp 
{
	color: #000000;
	Filter: Chroma(Color = #ffCC00);
	filter:progid:DXImageTransform.Microsoft.Gradient(GradientType=0,StartColorStr='#FFC54E',EndColorStr='#FFC54E');
	padding: 2px 2px 2px 2px;
	tab-index: 0;
	background-color: #6C6A6B;
	border: outset #6C6A6B 1px;
	font-family: tahoma;
	font-size: 10px;
	line-height: 14px;
	font-weight: bold;
	vertical-align: top;
	cursor: hand;
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

-->
</style>


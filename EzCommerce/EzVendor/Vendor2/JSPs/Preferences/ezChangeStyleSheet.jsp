<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@ include file="../../../Includes/JSPs/Preferences/iChangeStyleSheet.jsp"%>

<html>
<head>
<title>Change Style Sheet</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%
String dirName=(String)session.getValue("userStyle");
String sLang = (String)session.getValue("userLang");
%>
<script>
var colors=new Array();
colors[0]="BROWN";
colors[1]="BLUE";
colors[2]="GREEN";
colors[3]="MAROON";
colors[4]="YELLOW";
colors[5]="DARKBLUE";
var lan=new Array();
lan[0]="ENGLISH";
//lan[1]="GERMAN";
//lan[2]="RUSSIAN";
//lan[3]="FRENCH";
//lan[4]="SPANISH";
/*
function selStyle()
{
	for(var i=0;i<document.changeStyle.DefValue.length;i++)
	{
		if (document.changeStyle.DefValue[i].value=="<%= dirName%>")
		{
	                   document.changeStyle.DefValue.selectedIndex=i;
	        }
	}
}	*/
function changeImg()
{
var dname="";
	for(i=0;i<=5;i++)
	{
		dname="div"+i;
		document.getElementById(dname).style.visibility="hidden";
	}
var x = document.changeStyle.DefValue.value;
	for(i=0;i<=5;i++)
	{
	if(x==colors[i])
		p=i;
	}
dname="div"+p;
document.getElementById(dname).style.visibility="visible";
}
</script>
</head>
<body onLoad = "document.changeStyle.DefValue.focus();changeImg()">
<br>
<form method="post" action="ezSaveChangeStyleSheet.jsp" name="changeStyle" target = "_top">
  <TABLE border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="40%">
<%
	int defRows = retStyle.getRowCount();
	if ( defRows > 0 )
		{
		for ( int i = 0 ; i < defRows; i++ )
			{
			String defKey = (String)retStyle.getFieldValue(i,"EUD_KEY");
			String defValue = (String)(retStyle.getFieldValue(i,"EUD_VALUE"));
			defKey = defKey.trim();
			if (defKey.equals("STYLE"))
				{
%>
				<tr>
				<th >
					Select Colour
					<input type = hidden  name = DefKey value = <%= defKey%>>
				</th>
				<td>
				<div id = "listBoxDiv">
				<select name="DefValue" onChange=changeImg()>
					<script>
						for(i=0;i<=colors.length-1;i++)
						{
							if(colors[i]=="<%=dirName%>")
							{
								document.writeln("<option value="+colors[i]+" selected>"+colors[i]+" </option>")
							}
							else
							{
								document.writeln("<option value="+colors[i]+">"+colors[i]+" </option>")
							}
						}
						</script>
					</select>
			    	</div>
				</td>
				<!--
				<Th >Language</Th>
				<TD >
					<div id = "listBoxDiv1"><select name="Deflanguage">
					<script>
						for(i=0;i<=lan.length-1;i++)
						{
							if(lan[i]=="<%//sLang%>")
							{
								document.writeln("<option value="+lan[i]+" selected>"+lan[i]+" </option>")
							}
							else
							{
								document.writeln("<option value="+lan[i]+">"+lan[i]+" </option>")
							}
						}
						</script>
					</select></div>
				 </TD>
				 -->
				 <td class=blankcell><input type="image" src = "../../Images/Buttons/<%=ButtonDir%>/save.gif" name="Submit" value="Save"></td>
				</tr>
<%				}//End if
			}
		}
%>
</table>
<div id="div0" STYLE='Position:Absolute;visibility:hidden;width:100%;top:30%;' align="center"'>
 <img src="../../Images/Common/br_e.gif">
 </div>
 <div id="div1" STYLE='Position:Absolute;visibility:hidden;width:100%;top:30%;' align="center"'>
    <img src="../../Images/Common/b_e.gif">
 </div>
<div id="div2" STYLE='Position:Absolute;visibility:hidden;width:100%;top:30%;' align="center"'>
 <img src="../../Images/Common/g_e.gif">
 </div>
<div id="div3" STYLE='Position:Absolute;visibility:hidden;width:100%;top:30%;' align="center"'>
 <img src="../../Images/Common/p_e.gif">
 </div>
<div id="div4" STYLE='Position:Absolute;visibility:hidden;width:100%;top:30%;' align="center"'>
 <img src="../../Images/Common/y_e.gif">
  </div>
<div id="div5" STYLE='Position:Absolute;visibility:hidden;width:100%;top:30%;' align="center"'>
 <img src="../../Images/Common/db_e.gif">
  </div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>

<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@ page import="java.util.*,java.text.*" %>
<%@ include file="../../../Includes/JSPs/Materials/iListVendorQuestionnaire.jsp" %>
<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<Script>
var tabHeadWidth=60
var tabHeight="60%"
</Script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<script>

function formEvents(evnt)
{
	document.myForm.action=evnt
	document.myForm.submit();
}

function newFun()
{
	document.location.href="ezAddVendorQuestionnaire.jsp"
}
</script>
</head>

<%
if(Count==0)
{
%>
	<body scroll=no>
	<form name="myForm" method="post">
	<br><br><br><br><br>
	<TABLE width=50% align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<tr>
	<Th>No New Material Profiles Added by the Vendor.</th>
	</tr>
	</table>
	<br><br>
	<center><img src="../../Images/Buttons/<%=ButtonDir%>/addbutton.gif" style="cursor:hand" border=none onClick="newFun()">	</center>
	<%
}else
{
%>
	<body onLoad="scrollInit()" onResize="scrollInit()" scroll=no>
	<form name="myForm" method="post">
	
	<TABLE width="40%" align=center  border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
	<tr align="center">
    	<td class="displayheader">List Vendor Questionaires</td>
  	</tr>
	</table>
	<br>
	<DIV id="theads">
	<TABLE id="tabHead" width="60%" align=center  border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
      <tr>
	<th align="center" width="10%">&nbsp;</th>
        <th align="center" width="90%">Material Description</th>
      </tr>
	</table>
	</div>


	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:60%;height:60%;left:2%">
	<TABLE id="InnerBox1Tab" width="100%" align=center  border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
	<%	

	String materialId="";

	for(int i=0;i<Count;i++)
	{
		materialId = ret.getFieldValueString(i,"MATERIALID");
	%>
		<tr>
		<%
		   if(i==0)
		   {
		%>
			<td align="center" width="10%"><input type="radio" name="chk1" value="<%=materialId%>" checked></td>
		<% }else{ %>
		
		 	<td align="center" width="10%"><input type="radio" name="chk1" value="<%=materialId%>"></td>  
		<% } %> 	
		<td align="left" width="90%"><a href="ezViewVendorQuestionnaire.jsp?chk1=<%=materialId%>"><%=ret.getFieldValueString(i,"MATERIALDESC")%></td>
		</tr>
<%
	}
%>
</table>
</div>
<div id="buttons" align=center style="position:absolute;top:88%;width:100%;visibility:visible">
<img src="../../Images/Buttons/<%=ButtonDir%>/addbutton.gif" style="cursor:hand" border=none onClick="formEvents('../Materials/ezAddVendorQuestionnaire.jsp')">
<img src="../../Images/Buttons/<%=ButtonDir%>/edit.gif" style="cursor:hand" border=none onClick="formEvents('../Materials/ezEditVendorQuestionnaire.jsp')">
</div>
<%
	}
%>

</form>
<Div id="MenuSol"></Div>
</body>
</html>

<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@include file="../../../Includes/JSPs/Materials/iViewMaterialSpec.jsp"%>

<html>
<head>
<title>Material Specifications</title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<head>

</head>
<body bgcolor="#FFFFFF">
<form>
<table width="40%" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 align="center">
    <tr>
      <td class="displayheader" align="center">Material Specifications
      </td>
    </tr>
  </table>
<br>
<table width="60%" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 align="center">

  <tr>
    <th width="40%" align="left">&nbsp;Material Description</th>
    <td width="60%"><%=request.getParameter("materialDesc")%></td>
  </tr>
</table><br>

<table width="60%" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 align="center">
  <tr>
  <th width="100%">Material Specifications </th> </tr>
  <tr>
  <% ezc.drl.util.Replace rep = new ezc.drl.util.Replace();  %>

  <td width="100%"><%=rep.setNewLine(retOther.getFieldValueString(0,"VALUE1"))%></td>
  <!--<textarea cols="60" rows=5 style="overflow:auto;width:100%" readonly><%//retOther.getFieldValueString(0,"VALUE1")%></textarea>-->
   </tr>
</table>


<br><br><br><br>
<center>

<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" onClick="javascript:history.go(-1)" style="cursor:hand">

</center>
</form>
<Div id="MenuSol"></Div>
</body>
</html>

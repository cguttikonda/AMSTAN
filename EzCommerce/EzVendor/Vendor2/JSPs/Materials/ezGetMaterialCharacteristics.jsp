<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@ page import="java.util.*,java.text.*" %>
<%@ page import="ezc.ezutil.*"%>
<%@ include file="../../../Includes/JSPs/Materials/iGetMaterialCharacteristics.jsp" %>
<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<script>
		

function funSubmit()
{

  document.myForm.action="../Rfq/ezViewRFQDetails.jsp"
  document.myForm.submit()		

}
</script>

<Script>
var tabHeadWidth=95
var tabHeight="65%"
</Script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>



</head>

<body onLoad="scrollInit()" onResize="scrollInit()" scroll=no>
<form name="myForm" method="post">
<%
	
	int Count=MatCharcs.getRowCount();
	
	if(Count==0)
	{
%>
	<br><br><br><br><br>
	<TABLE width="50%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<tr>
	<Th width="100%">No Material Specifications to Display.</th>
	</tr>
	</table>
	<br><br>
	<center>
	<%
		if(request.getParameter("EndDate")==null)
		{
	%>
			<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" style="cursor:hand" border=none onClick="JavaScript:history.go(-1)">
	<%   }else{   %>
	  <img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" style="cursor:hand" border=none onClick="funSubmit()">
	  <input type="hidden" name="PurchaseOrder" value='<%=request.getParameter("PurchaseOrder")%>'>
	  <input type="hidden" name="EndDate" value='<%=request.getParameter("EndDate")%>'>
	<%   } %>

		</center>

<%
	return;
	}
%>
<TABLE width="40%" align=center  border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
  <tr align="center">
    <td class="displayheader">List Of Material Characteristics</td>
  </tr>
</table>
<br>
<DIV id="theads">
<TABLE id="tabHead" width="95%" align=center  border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
      	<tr>
        	<th align="center" width="16%"  rowspan=2>Inspection Lot No</th>
       	<th align="center" width="24%%" rowspan=2>Inspection Char.</th>
        	<th align="center" width="34%" colspan=2>Tolerance Limit</th>
	<th align="center" width="26%" rowspan=2>Inspection Method</th>
      	</tr>
	<Tr>
	<Th width="17%">Lower</Th><Th width="17%">Upper</Th>
	</Tr>
</table>
</div>

<DIV id="InnerBox1Div"  style="overflow:auto;position:absolute;width:95%;height:60%;left:2%">
<TABLE id="InnerBox1Tab" width="100%" align=center  border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
<%

	FormatDate fd = new FormatDate();

	for(int i=0;i<Count;i++)
	{
%>
		<tr>
			<td  width="16%"><%=MatCharcs.getFieldValueString(i,"INSPLOT")%>&nbsp;</td>
			<td width="24%"><%=MatCharcs.getFieldValueString(i,"CHAR_DESCR")%>&nbsp;</td>
			<td align="right" width="17%"><%=MatCharcs.getFieldValueString(i,"LW_TOL_LMT")%>&nbsp;</td>
			<td align="right" width="17%"><%=MatCharcs.getFieldValueString(i,"UP_TOL_LMT")%>&nbsp;</td>
			<td  width="26%"><%=MatCharcs.getFieldValueString(i,"METHOD_TXT")%></td>	
		</tr>
<%
	}
%>
</table>
</div>


  <div id="buttons" align=center style="position:absolute;top:90%;width:100%;visibility:visible">
  <%
	if(request.getParameter("EndDate")==null)
	{
  %>	  <img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" style="cursor:hand" border=none onClick="JavaScript:history.go(-1)">
   <%   }else{   %>
	  <img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" style="cursor:hand" border=none onClick="funSubmit()">
	  <input type="hidden" name="PurchaseOrder" value='<%=request.getParameter("PurchaseOrder")%>'>
	  <input type="hidden" name="EndDate" value='<%=request.getParameter("EndDate")%>'>
   <%   } %>
  </div>

</form>
<Div id="MenuSol"></Div>
</body>
</html>

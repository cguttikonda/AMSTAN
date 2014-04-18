<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<html>
<head>
<base TARGET="_self">
<Title>Update QCF Comments -- Powered by Answerthink India Pvt Ltd.</Title>
<script>
var qcf_code = '<%=request.getParameter("qcf_code")%>'
function save()
{
	if(document.myForm.qcfComments.value=="")
	{
		alert("Please Enter Comments For QCF Number :"+qcf_code);
		document.myForm.qcfComments.focus();
		return;
	}
	else
	if(document.myForm.qcfComments.value.length>999)
	{
		alert("Comments Should Not Be More Than 999 Characters");
		document.myForm.qcfComments.focus();
		return;
	}
	else
	if(document.myForm.qcfComments.value!="")
	{
		var notValidChars="'";
		var nLoop=0;
		var nLength=(document.myForm.qcfComments.value).length;
		for(nLoop=0;nLoop<nLength;nLoop++)
		{
			cChar=(document.myForm.qcfComments.value).charAt(nLoop);
			if (notValidChars.indexOf(cChar)!=-1)
			{
				alert("Single(') quotes are not allowed in Comments");
				document.myForm.qcfComments.focus();
				return ;
			}
		}

	}

	document.getElementById("ButtonsDiv").style.visibility="hidden"
	document.getElementById("msgDiv").style.visibility="visible"

	document.myForm.action="ezUpdateQcfCommentsWindow.jsp";
	document.myForm.submit();
}
</script>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
</head>
<body scroll=no onLoad="document.myForm.qcfComments.focus()">
<form name="myForm">
<input type=hidden name="qcf_code" value='<%=request.getParameter("qcf_code")%>'>
<input type=hidden name="qcf_comment_no" value='<%=request.getParameter("qcf_comment_no")%>'>

<DIV id="addCmntTab" style="position:absolute;width:100%;top:15%">
	<Table align="center" style="width:90%" border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
		<Tr>
			<Th colspan="2">Enter Comments for Col RFQ No <%=request.getParameter("qcf_code")%></Th>
		</Tr>
		<Tr>
			<Td align="center" valign="bottom"><textarea rows=3 name="qcfComments" style="width:100%"><%=request.getParameter("qcf_comments")%></textarea></Td>
		</Tr>
	</Table>
</Div>	
<DIV id="ButtonsDiv" style="position:absolute;width:100%;top:80%">	
	<Table align="center" style="width:100%">	
		<Tr>
			<Td class='TDCommandBarBorder' align='center'>
      <table border="0" cellspacing="3" cellpadding="5">
	    <tr>
          <td nowrap class="TDCmdBtnOff" onMouseDown="changeClass(this,'TDCmdBtnDown')" onMouseUp="changeClass(this,'TDCmdBtnUp')" onMouseOver="changeClass(this,'TDCmdBtnUp')" onMouseOut="changeClass(this,'TDCmdBtnOff')" onClick="javascript:save()">
                <b>&nbsp;&nbsp;&nbsp;&nbsp;Submit&nbsp;&nbsp;&nbsp;&nbsp;</b>
          </td>
          <td nowrap class="TDCmdBtnOff" onMouseDown="changeClass(this,'TDCmdBtnDown')" onMouseUp="changeClass(this,'TDCmdBtnUp')" onMouseOver="changeClass(this,'TDCmdBtnUp')" onMouseOut="changeClass(this,'TDCmdBtnOff')" onClick="javascript:window.close()">
                <b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Close&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>
          </td>
	    </tr>
	    </table>
				<!--<img src="../../Images/Buttons/<%=ButtonDir%>/submit.gif" border=none style="cursor:hand" border=none onClick="JavaScript:save()">
				<img src="../../Images/Buttons/<%=ButtonDir%>/close.gif" border=none style="cursor:hand" border=none onClick="JavaScript:window.close()">-->
			</Td>
		</Tr>
	</Table>
</Div>
<Div id="msgDiv" style="position:absolute;top:90%;width:100%;visibility:hidden" align="center">
	<Table align="center" width="60%" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
		<Tr>
			<Th  align="center">Your request is being processed. Please wait ...............</Th>
		</Tr>
	</Table>
</Div>
<Div id="MenuSol">
</Div>
</form>
</body>
</html>

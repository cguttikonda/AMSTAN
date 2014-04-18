<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>

<%
// Key Variables
ReturnObjFromRetrieve ret = null;

// System Configuration Class
EzSystemConfig ezc = new EzSystemConfig();

//Get Error Description
ret = ezc.getCurrencyDesc();
%>

<html>
<head>

<script language = "javascript">
function setCheck(i) {
	document.forms[0].elements['CheckBox_' + i].checked = true;
	document.returnValue = true;
}
</script>

<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<BODY >
<form name=myForm method=post action="ezSaveModifyErrorCode.jsp">
  <Table  width="55%" border="0" align="center">
    <Tr align="center"> 
      <Td class="displayheader">Update Error Code Description</Td>
    </Tr>
  </Table>
  <br>
  <Table  width="85%" align="center">
    <Tr> 
      <Th width="9%">Update </Th>
      <Th width="25%">Error Code</Th>
      <Th width="66%"> Error Description </Th>
    </Tr>
    <%
int curRows = ret.getRowCount();
if ( curRows > 0 ) {
	for ( int i = 0 ; i < curRows; i++ ){		
%>

    <Tr align="center"> 
      <Td><%
		// CheckBox for Update
        	out.println("<input type=\"checkbox\" name=\"CheckBox_"+i+"\" value=\"Selected\" unchecked>");
%></Td>

      <Td><%
	      out.println(ret.getFieldValue(i,CURRENCY_KEY)); 
		out.println("<input type=\"hidden\" name=\"CurKey_"+i+"\" value=\""+ret.getFieldValue(i,CURRENCY_KEY)+"\" onChange=\"setCheck("+i+");return document.returnValue\">");
%></Td>

      <Td><%
		out.println("<input type=\"text\" size=\"30\" name=\"CurDesc_"+i+"\" value=\""+ret.getFieldValue(i,CURRENCY_LONG_DESC)+"\" onChange=\"setCheck("+i+");return document.returnValue\">");
		out.println("<input type=\"hidden\" name=\"CurShortDesc_"+i+"\" value=\""+ret.getFieldValue(i,CURRENCY_SHORT_DESC)+"\" onChange=\"setCheck("+i+");return document.returnValue\">");
		out.println("<input type=\"hidden\" name=\"CurLang_"+i+"\" value=\""+ret.getFieldValue(i,CURRENCY_LANG)+"\" >");
		out.println("<input type=\"hidden\" name=\"TotalCount\" value=\""+curRows+"\" >");
%></Td>
    </Tr>

<%
	}//End for
}//End If
%> 
  </Table>
  <div align="center"><br>
    <input type="submit" name="Submit" value="Update Description">
  </div>
</form>
</body>
</html>
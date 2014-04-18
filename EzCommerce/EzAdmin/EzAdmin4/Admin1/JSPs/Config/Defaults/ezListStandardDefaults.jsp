<%@ include file="../../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../../Includes/JSPs/Config/Defaults/iListStandardDefaults.jsp"%>

<html>
<head>
<%@ include file="../../../../Includes/Lib/AddButtonDir1.jsp"%>
<script src="../../../Library/JavaScript/Config/Defaults/ezListStandardDefaults.js">
</script>
</head>
<BODY>
<form name=myForm method=post action="ezUpdateStandardDefaults.jsp">
<br>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
  <Tr align="center">
    <Td class="displayheader">List of Standard Defaults</Td>
  </Tr>
</Table>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
    <Tr>
      <Th width="12%">Select</Th>
      <Th width="34%"> Default</Th>
      <Th width="54%"> Description </Th>
    </Tr>
    <%
int defRows = ret.getRowCount();
if ( defRows > 0 ) {
	for ( int i = 0 ; i < defRows ; i++ ){
%>

    <Tr align="center">
      <Td>
        	<input type= "checkbox" name="CheckBox" value="Selected" unchecked>
</Td>

      <Td>
      		<%=ret.getFieldValue(i,STD_DEFAULTS_KEY)%>
      </Td>

      <Td>
		<%=ret.getFieldValue(i,STD_DEFAULTS_DESC)%>
		<input type="hidden" name="DefLang" value= "<%=ret.getFieldValue(i,STD_DEFAULTS_LANG)%>" >
		<input type="hidden" name="DefKey" value="<%=ret.getFieldValue(i,STD_DEFAULTS_KEY)%>" >
		<input type="hidden" name="DefDesc" value="<%=ret.getFieldValue(i,STD_DEFAULTS_DESC)%>" >
		<input type="hidden" name="DefType" value="<%=ret.getFieldValue(i,STD_DEFAULTS_TYPE)%> ">
</Td>
    </Tr>

<%
	}//End for
}//End If
%>
  </Table>
  <br>
  <div align="center">
    <!--<input type="submit" name="Submit" value="Update" onClick="checkAll(<%=defRows%>);return document.returnValue">-->
    	<input type="image" src="../../../Images/Buttons/<%= ButtonDir%>/update.gif" onClick="checkAll(<%=defRows%>);return document.returnValue">
   <!-- <input type="Reset" name="Reset" value="Reset"> -->
    	<a href="javascript:void(0)"><img src="../../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
    	<a href="JavaScript:history.go(-1)"><img src="../../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

  </div>
</form>
</body>
</html>
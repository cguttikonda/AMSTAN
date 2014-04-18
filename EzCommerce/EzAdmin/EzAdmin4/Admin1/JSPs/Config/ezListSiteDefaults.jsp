<%@ include file="../../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../../Includes/JSPs/Config/Defaults/iListSiteDefaults.jsp"%>

<html>
<head>
<script src="../../../Library/JavaScript/Config/Defaults/ezListSiteDefaults.js"></script>
<script src="../../Library/JavaScript/ezTabScroll.js"></script>	
<%@ include file="../../../../Includes/Lib/AddButtonDir1.jsp"%></head>
<BODY onLoad="scrollInit()" onResize = "scrollInit()" scroll="no">
<br>
<form name=myForm method=post >
    <%
int defRows = 0;
defRows = retfixed.getRowCount();
if ( defRows > 0 ) {
	
%>

<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="96%">
  <Tr align="center">
    <Td class="displayheader">List of Site Defaults</Td>
  </Tr>
</Table>

<div id="theads">
<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width=96%>
    <Tr>
      <Th width="96%" colspan="2">These are the Site Defaults independent of
        Business Area</Th>
    </Tr>
    <Tr align="left">
      <Th width="45%"> Default</Th>
      <Th width="55%"> Description </Th>
    </Tr>
</Table>
</div>

<div id="InnerBox1Div" style="overflow:auto;position:absolute">
<Table  id="InnerBox1Tab"  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="100%" left="2%">

<%     

     for ( int i = 0 ; i < defRows; i++ ){
%>     
    <Tr align="left">
      <Td  width="45%"><%

	String defDescription = (String)retfixed.getFieldValue(i,DEFAULTS_DESC);
	out.println(retfixed.getFieldValue(i,DEFAULTS_KEY));
%></Td>

      <Td  width="55%"><%
		if ( defDescription != null){
		      out.println(defDescription);
		}
%></Td>
    </Tr>
<%
	}//End for
}//End If
%>
  </Table>
  </div>
  
    <div id="ButtonDiv" align = "center" style="position:absolute;top:90%;width:100%">
  <a href="JavaScript:history.go(-1)"><img src="../../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

  </div>
</form>
</body>
</html>

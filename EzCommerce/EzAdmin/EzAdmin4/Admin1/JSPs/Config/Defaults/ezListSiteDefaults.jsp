<%@ include file="../../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../../Includes/JSPs/Config/Defaults/iListSiteDefaults.jsp"%>
<html>
<head>
<Script src="../../../Library/JavaScript/Config/Defaults/ezListSiteDefaults.js"></Script>
<script src="../../../Library/JavaScript/ezTabScroll.js"></script>
<%@ include file="../../../../Includes/Lib/AddButtonDir1.jsp"%></head>
<body onLoad="scrollInit()" onResize = "scrollInit()" scroll="no">
<br>
<form name=myForm method=post >
<%
int defRows = 0;
defRows = retfixed.getRowCount();
if ( defRows > 0 ) 
{
	retfixed.sort(new String[]{DEFAULTS_KEY},true);
%>
	<Table border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
  	<Tr>
    		<Td align="center" class="displayheader">List of Site Defaults</Td>
  	</Tr>
	</Table>
	<div id="theads">
	<Table  id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
    	<Tr>
      		<Th colspan="2">These are the Site Defaults independent of Business Area</Th>
    	</Tr>
    	<Tr >
      		<Th width="45%"> Default</Th>
      		<Th width="45%"> Description </Th>
    	</Tr>
	</Table>
	</div>
	<div id="InnerBox1Div">
	<Table align="center" id="InnerBox1Tab" border=1 borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
<%
     	for ( int i = 0 ; i < defRows; i++ )
     	{
%>     
    	<Tr>
	      	<Td  width="50%">
<%
			String defDescription = (String)retfixed.getFieldValue(i,DEFAULTS_DESC);
			out.println(retfixed.getFieldValue(i,DEFAULTS_KEY));
%>
		</Td>
      		<Td  width="50%">
<%
		if ( defDescription != null)
		{
		      out.println(defDescription);
		}
%>
		</Td>
    	</Tr>
<%
	}//End for
%>
	</Table>
	</div>
    	<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
		<a href="javascript:funAdd()"> <img src="../../../Images/Buttons/<%= ButtonDir%>/add.gif"   border=none></a>
		<a href="javascript:funEdit()"> <img src="../../../Images/Buttons/<%= ButtonDir%>/edit.gif"   border=none></a>
		<a href="JavaScript:history.go(-1)"><img src="../../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
	</div>	
<%
}//End If
else
{
%>
	<br><br><br><br>
	<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
	<Tr>
		<Th width="100%" align=center>
			No Defaults To List.
		</Th>
	</Tr>
	</Table>
	<br>
	<center>
		<a href="javascript:funAdd()"> <img src="../../../Images/Buttons/<%= ButtonDir%>/add.gif"   border=none></a>
		<a href="JavaScript:history.go(-1)"><img src="../../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
	<center>
<%
}
%>
</form>
</body>
</html>

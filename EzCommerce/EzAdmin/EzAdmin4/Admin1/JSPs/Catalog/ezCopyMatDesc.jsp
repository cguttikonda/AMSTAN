<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Catalog/iCopyMatDesc.jsp"%>

<html>
<head>
<script src="../../Library/JavaScript/Catalog/ezCopyMatDesc.js" >
</script>
<Title>ezCopyMatDesc</Title>
<meta http-equiv="Content-Type" content=" text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<%
	if(ret!=null && ret.getRowCount()==0)
	{
%>
		<body>
<%
	}
	else
	{
%>
		<body onLoad="document.myForm.SourceLang.focus()">
<%
	}
%>
<form name=myForm method=post action="ezSaveCopyMatDesc.jsp" onSubmit="return chkLang()">
<br>
<%
     int langRows = ret.getRowCount();
	if ( langRows > 0 )
	{

%>
   <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
  <Tr align="center">
    <Td class="displayheader">Copy Catalog To Different Language </Td>
  </Tr>
</Table>

  <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
    <Tr bordercolor="#999999">
      <Th width="40%" class="labelcell" align="right">Source Language*</Th>
      <Td width="60%" bgcolor="#FFFFF7">
     
      <select name="SourceLang" id=ListBoxDiv>
       <option value="sel">--Select--</option>
<%
		for ( int i = 0 ; i < langRows ; i++ ){
%>
	        <option value=<%=(ret.getFieldValue(i,LANG_ISO))%> >
	        <%=ret.getFieldValue(i,LANG_DESC)%>
	        </option>
<%
		}
%>
		</select>
      </Td>
    </Tr>
    <Tr bordercolor="#999999">
      <Th width="40%" height="3" class="labelcell" align="right">Destination Language*</Th>
        
      <Td width="60%" height="3" bgcolor="#FFFFF7">
<%
		int alllangRows = retlangall.getRowCount();
		if ( alllangRows > 0 )
		{
%>
			<select name="DestLang" id=ListBoxDiv>
			<option value="sel">--Select--</option>
<%
		for ( int i = 0 ; i < alllangRows ; i++ ){
%>
	        <option value=<%=((String)retlangall.getFieldValue(i,LANG_ISO)).toUpperCase()%> >
	        <%=retlangall.getFieldValue(i,LANG_DESC)%>
	        </option>
<%
		}
%>
        </select>
 <%
	}
%>
      </Td>
    </Tr>
  </Table>
  <div align="center"><br>
    <input type="image" src = "../../Images/Buttons/<%= ButtonDir%>/copy.gif" name="Submit" value="Copy">
    <a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

<%
   }
    //Changed by anil(06/05/01) //To appear only if there is a source language

%>
  </div>
</form>


<%
  if(langRows<1)
  {
%>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
  <Tr align="center">
    <Td class="displayheader">There is  No Source Language</Td>
  </Tr>
</Table>
<center>
<br><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

</center>

<%
  }
%>
</body>
</html>
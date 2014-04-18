<%@ include file="../../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../../Includes/JSPs/Config/Defaults/iAddSiteDefaults.jsp"%>
<html>
<head>
<script src="../../../Library/JavaScript/Config/Defaults/ezAddSiteDefaults.js">
</script>
<Title>Add Site Defaults</Title>
<%@ include file="../../../../Includes/Lib/AddButtonDir1.jsp"%></head>
<body OnLoad="document.myForm.DefType.focus()">
<br>
<form name=myForm method=post action="ezSaveSiteDefaultsDesc.jsp">
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
	<Tr align="center">
    	<Td class="displayheader">Add New Site Defaults</Td>
  	</Tr>	
</Table>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
    	<Tr>
      	<Th colspan="2" height="17"><nobr>
        <div align="center">For adding a new site default enter the following
          information.<font color="#FFFFFF"> </font>To add pre-defined defaults
          <font color="#FFFFFF"><font color="#FFFF00"><a class="subclass" href="ezListStandardDefaults.jsp"><b>Click
          Here</b></a></font></font></div></nobr>
      	</Th>
    	</Tr>
	<Tr>
      	<Td width="42%" class="labelcell">
        <div align="right">Default Level*:</div>
      	</Td>
      	<Td width="58%">
<%
	retdeftype.sort(new String[]{DEFAULT_TYPE_DESC},true);
	int typeRows = retdeftype.getRowCount();
	if ( typeRows > 0 )
		{
%>
        	<select name="DefType" id=ListBoxDiv>
        	<option value="sel">--Select Default Level--</option>
<%
		for ( int i = 0 ; i < typeRows ; i++ )
			{
%>
	       		<option  value=<%=retdeftype.getFieldValue(i,DEFAULT_TYPE)%> ><%=retdeftype.getFieldValue(i,DEFAULT_TYPE_DESC)%>
	       	</option>

<%
			}//End for
%>
        	</select>
        	
<%
		}
%>
     	</Td>
    	</Tr>
    	<Tr>
      	<Td width="42%" class="labelcell">
        <div align="right">Language:</div>
      	</Td>
      	<Td width="58%">
        <%//@ include file="../../../../Includes/Lib/ListBox/LBLanguage.jsp"%>
		<select name=Lang id="ListBoxDiv">
			<option value="EN">English</option>
		</select>
      	</Td>
    	</Tr>
	<Tr>
      	<Td width="42%" class="labelcell">
        <div align="right">Default Key*:</div>
      	</Td>
      	<Td width="58%"> 
      	<input type=text class = "InputBox" name=key style="width:100%" maxlength="18" onChange="this.value=this.value.toUpperCase()">
        </Td>
    	</Tr>
    	<Tr>
      	<Td width="42%" class="labelcell">
        <div align="right">Description:*</div>
      	</Td>
      	<Td width="58%">
        <input type=text class = "InputBox" name=Desc style="width:100%" maxlength="100" >
        </Td>
    	</Tr>
</Table>
<br>
<center>
	<input type="image" src="../../../Images/Buttons/<%= ButtonDir%>/save.gif" onClick="CheckValue();return document.returnValue">
	<a href="javascript:void(0)"><img src="../../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
	<a href="JavaScript:history.go(-1)"><img src="../../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

  </center>
  <div align="center"><br>
  </div>
</form>
</body>
</html>

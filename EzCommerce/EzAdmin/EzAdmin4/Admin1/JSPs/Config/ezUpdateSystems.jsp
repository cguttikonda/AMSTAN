<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iUpdateSystems.jsp"%>
<html>
<head>
<script src="../../Library/JavaScript/CheckFormFields.js"></script>
<script src="../../Library/JavaScript/Config/ezUpdateSystems.js"></script>
<script src="../../Library/JavaScript/ezTabScroll.js"></script>

<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
</head>
<BODY onLoad="setFocus();scrollInit()" onResize="scrollInit()" scroll="no">
<br>
<form name=myForm method=post action="ezUpdateSaveSystems.jsp" onSubmit="return funCheckBoxModify()">

<%
int sysRows = ret.getRowCount();
if ( sysRows > 0 )
	{
%>
<div id="theads">
<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="89%">
  	<Tr align="center">
    	<Td class="displayheader">Update System Description</Td>
  	</Tr>
</Table>
</div>
<div id="InnerBox1Div">
<Table id="InnerBox1Tab" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="89%">
    	<Tr>
      	<Th width="5%" title="Select/Deselect All"><input type='checkbox' name='chk1Main' onClick="selectAll()"></Th>
      	<Th width="10%" align="center">System</Th>
      	<Th width="55%" align="center">Description</Th>
      	<Th width="30%" align="center">System Type</Th>
    	</Tr>
<%
	for ( int i = 0 ; i < sysRows; i++ )
		{
%>
    		<Tr align="center">
		<label for="cb_<%=i%>">
    		<Td width="5%">
		<input type="checkbox" name="chk"  id="cb_<%=i%>" value="<%=ret.getFieldValue(i,SYSTEM_NO)%>#<%=ret.getFieldValue(i,SYSTEM_NO_DESC_LANGUAGE)%>" unchecked>
      		</Td>
      		<Td align="left" width="10%">
			<%=ret.getFieldValue(i,SYSTEM_NO)%>
      		</Td>
      		<Td align="left" width="55%">
			<input type=text style = "width:100%" class = "InputBox" size="35" maxlength="100" name="SystemDesc"  value="<%=ret.getFieldValue(i,SYSTEM_NO_DESCRIPTION)%>"  >
      		</Td>
      		<Td align="left" width="30%">
			<%=ret.getFieldValue(i,SYSTEM_TYPE_DESC)%>
      		</Td>
    		</label>
    		</Tr>
<%
		}//End for

%>
</Table>
</div>
<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
	<input type="image" src="../../Images/Buttons/<%= ButtonDir%>/save.gif" >
    	<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
    	<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

</div>
<%
	}//End If
//Changed By anil(06/05/01) To not Display Buttons when there is no Data
else
	{

%>
<br><br><br><br>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
  	<Tr align="center">
    	<Th>There are No Systems Created Currently</Th>
  	</Tr>
</Table>
<br>
<center>
	<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

</center>
<%
	}
%>
</form>
<%
	String saved = request.getParameter("saved");
	if ( saved != null && saved.equals("Y") )
		{
%>
		<script language="JavaScript">
			alert('System Description(s) updated successfully');
		</script>
<%
		} //end if
%>
</body>
</html>

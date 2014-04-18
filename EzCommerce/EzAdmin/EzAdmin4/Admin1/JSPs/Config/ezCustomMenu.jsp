<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>

<script>
function funSubmit()
{
	if(document.myForm.MenuKey.selectedIndex != 0)
	{
		document.myForm.action="ezSampleJSP.jsp"
		document.myForm.submit()
	}	
}

</script>
<form name=myForm method=post>
<%
String[] Menus = {"CU","CM","LF","RM","VP"};
%>
    <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
    <Tr>
      <Th width="30%" class="labelcell" bordercolor="#CCCCCC">Menu Area</Th>
      <Td width="70%" bordercolor="#CCCCCC">
      <select name="MenuKey" id = "FullListBox" style="width:100%" onChange="funSubmit()">
	<option value="sel" >--Select Menu--</option>

<%
     for (int i = 0 ;i<Menus.length;i++ )
     {
	     
%>
	  	  <option value="<%=Menus[i]%>"><%=Menus[i]%></option>
<%  	    
     }//for close
%>
      </select>
      </Td>
    </Tr>
    </Table>
</body>
</html>

<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script>
function submitFun()
{
  	if(document.form2.attach.value=="")
   	{
     		alert("Please Select File");
      		return false
   	}
   	else
    		return true
}
</script>    
</head>
 <body> 
<form name="form2" enctype="multipart/form-data" method="post" onSubmit="return submitFun()" action="ezUpload.jsp"  target="_parent">
   	<TABLE align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width=80%>
   		<tr><th>Select Attachment File</th></tr>
   	</table>
       	<table width="25%" align="center" valign="middle">
       	<tr align="center" valign="middle">
          	<td bordercolor="#FFFFF7" class="blankcell">
          		<input type="File" name="attach">
          	</td>
         </tr>
         <tr>
          	<td  class="blankcell" align="center">
             		<input type="submit" value="Upload">
          	</td>
       	</tr>
       </table>
</form>
</body>
</html>
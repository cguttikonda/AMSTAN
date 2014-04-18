<%@ page import="java.io.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%
	String name= Session.getUserId();
	File f = new File("C:\\MailApp\\"+name);

     	String[] str=null;	
     	File[] files =null;
     	if(f.exists())
     	{
         	str = f.list();
         	if(str.length==0)
          		f.delete();
        	else
         	{
           		files=new File[str.length];
           		for(int i=0;i<str.length;i++)
            		{
              			files[i]=new File(str[i]);    
            		}
         	}
   	}
%>
<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script>
function go()
{
 	count=0;  
  	chkLength=document.myForm.chk1.length
   	if(!(isNaN(chkLength)))
    	{
        	for(i=0;i<chkLength;i++)
		{
	  		if(document.myForm.chk1[i].checked)
	  		count=count+1
		}
    	}
  	else
    	{
       		if(document.myForm.chk1.checked)
        		count=1
        	else
        		count=0
    	}
       	if(count !=1)
	{
           	alert("EzMail couldn't find a record  to Delete \n Solution : Please check Only one checkbox which you want to Delete")
	   	return false;
	}
        else
        {
         	document.myForm.action = "ezRemoveAttachment.jsp"
         	document.myForm.submit();
        } 
}
</script>
</head>
<body>
<form name=myForm>
<%
     	if(!f.exists())
     	{
%>      
	<center>
	<font size=4 color=red>
     		You did not Uploaded any File
     	</font>
		<br><br><input type='button' value="Close" onClick="parent.window.close()">
	</center>
 
<%   
	}
     	else
     	{
%>
		<TABLE align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 valign=top width=80%>
		<tr><th>List Of Uploaded Files</th></tr>
   		</table>
		<TABLE align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width=80%>
		<tr>
    		<th align=center>&nbsp;</th><th>File Name</th>
    		</tr>
<% 
		for(int i=0;i<files.length;i++)
   		{
%>
    			<tr>
    			<td align=center><input type=checkbox value="<%=files[i].getName()%>" name="chk1"></td> 
    			 	<td><%=files[i].getName()%></td>
    			</tr>
<% 
   		} 
%>
		</table>   
		<center><br>
			<input type='button' value="Remove" onClick="go()">
			<input type='button' value="Done" onClick="parent.window.close()">
		</center>
<%  
 	}
%>
</form>
</body>
</html>
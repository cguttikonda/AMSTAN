<%//@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%
	String[] attachedFiles=request.getParameterValues("attachedFiles");
%>
<html>
<head>
	<title>Mail Attachments</title>
	<%@ include file="uploads/AddButtonDir.jsp"%>
	<script src="uploads/ezComposePersMsgs.js"></script>
     	<script language="JavaScript">
	function setDefaults()
	{
<%
		if(attachedFiles != null)
		{
			for(int i=0;i<attachedFiles.length;i++)
			{
%>
				document.myForm.attachList.options[<%=i%>]=new Option("<%=attachedFiles[i]%>","<%=attachedFiles[i]%>")
<%
			}
		}
%>
	}
   	</script>
</head>
<body onLoad="setDefaults()">
<form name="myForm" ENCTYPE="multipart/form-data" method="POST" >
	<Table  border="0" cellpadding="0" cellspacing="0">
	<Tr>
    		<Td width="160" valign="top" rowspan=2>
    			<Table  border=0 cellpadding=2 cellspacing=0 width=100% align=center>
    			<Tr>
    			</Tr>
    			</Table ><p>
    		</Td>
    	</Tr>
    	<Tr valign=top><Td width="100%" valign=top >
    	<br>
   	<Table  border=0 cellspacing=0 cellpadding=0 width=100%>
	<Tr>
	<Td width=15 rowspan=7></Td>
	<Td colspan=5>
		<font >Attach a file to your message in two steps, repeating the steps as needed to attach multiple files. Click <b>done</b> to return to your message when you are done.</font>
		<br><br>
	   	</Td>
		</Tr>
		<Tr>
	   		<Td style="padding:2px;" valign="top"><font >1.</font></Td>
	   		<Td style="padding:2px; padding-right:15px;" width="48%" valign="top"><font >Click <b>Browse</b> to select the file, or type the path to the file in the box below.</font></Td>
	   		<Td style="padding:2px;" valign="top"><font >2.</font></Td>
           		<Td style="padding:2px;" width="48%" colspan=2><font >Move the file to the <b>Attachments</b> box by clicking <b>Attach</b>.</font> <font class="s">File Transfer times vary (30 seconds up to 10 minutes).</font><br><br></Td>
		</Tr>
   		<Tr>
	   	<Td></Td>
	   	<Td style="padding-right:15px;" rowspan=2 valign="top">
	   	   	<font  style="font-size:13px"><label for="attFbutton">Attach File</label>:</font><br>
	   	   	<input type="file"  name="attachFile" id="attFbutton" tabindex="1">
	      		<br>
	   	</Td>
	  	<Td></Td>
	  	<Td></Td>
	  	<Td><font  style="font-size:13px"><label for="attachList">Attachments</label>:</font></Td>
		</Tr>
		<Tr>
	  	<Td></Td>
	  	<Td></Td>
	  	<Td align="center" valign="top">
	 		<a href="javascript:doAttachFile()"><img src = "../../Images/Buttons/<%=ButtonDir%>/attach.gif" border=none></a>
		<p>
		<a href="javascript:doRemove()"><img src = "../../Images/Buttons/<%=ButtonDir%>/remove.gif" border=none></a>
	  	</Td>
	  	<Td valign="top">
		<select class = "control" name="attachList" tabindex="4" size=5 multiple>
   	        </select>
	       <br>
	  </Td>
	  </Tr>
  	<Tr>
	<Td colspan=5 align=right>
		<hr size="1" color="#8CA5B5" width="100%">
			<img src = "../../Images/Buttons/<%=ButtonDir%>/done.gif" style="cursor:hand" border=none onClick="doAttach()">
		&nbsp;
		<a href="javascript:window.close()"><img src="../../Images/Buttons/<%=ButtonDir%>/cancel.gif" border=none ></a>
  	</Td>
	</Tr>
</Table>
	</Td>
	</Tr></Table >
	</Td>
	</Tr>
	</Table >

</form>
   </body>
</html>

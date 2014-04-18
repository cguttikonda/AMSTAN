<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/InboxBean.jsp"%>
<%@ include file="../../../Includes/Lib/Inbox.jsp"%>
<jsp:useBean id="FileNames"  class="ezc.discussion.groups.EzFileNamesStore" scope="session">
</jsp:useBean>
<html>
<head>
<Title>Untitled Document</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>    

<body bgcolor="#FFFFFF">
<div align="center"> 
  <form method="post" action="">
    <p><b><font size="4" face="Verdana, Arial, Helvetica, sans-serif">Attached 
      File List</font></b></p>
    <% 
String Flag = (String) IBObject.uploadFile(AdminObject, servlet, request);
FileNames.setUploadedFileName(Flag);
String[] filenames=FileNames.getUploadedFileName();
int counter = filenames.length;
%> 
    <Table  width="25%" border="0">
      <% if(counter>0)  for(int i=0;i<counter;i++) {   %> 
      <Tr> 
        <Td> 
          <input type="checkbox" name="checkbox2" value="checkbox" checked >
        </Td>
        <Td><% 
String UP_File = filenames[i];
   int space = UP_File.lastIndexOf("\\"); 
   UP_File = UP_File.substring(space+1,UP_File.length());

out.println(UP_File); %></Td>
      </Tr>
      <% } %> 
    </Table>
    <p>Unselect to Delete the Attachments 
      <input type="submit" name="Submit2" value="Delete">
    </p>
  </form>
  <p>&nbsp;</p>
  <p>&nbsp; </p>
</div>
</body>
</html>

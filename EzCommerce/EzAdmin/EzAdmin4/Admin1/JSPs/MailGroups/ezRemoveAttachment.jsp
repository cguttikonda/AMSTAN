
<%@ include file="../../../Includes/Lib/MailGroupBean.jsp" %>

<% 
     String[] fileNames=request.getParameterValues("chk1"); 
     String name= Session.getUserId();
     java.io.File uploadedFile=null;
     for(int i=0;i<fileNames.length;i++)
     {
      uploadedFile = new java.io.File("C:\\MailApp\\"+name+"\\"+fileNames[i]);
      uploadedFile.delete();
     }
     response.sendRedirect("ezListUploadedFiles.jsp");

%>


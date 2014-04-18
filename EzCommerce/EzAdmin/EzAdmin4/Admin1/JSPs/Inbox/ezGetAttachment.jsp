<%@ include file="../../../Includes/Lib/MailGroupBean.jsp" %>
<html>
<body>
<%
	String groupId="Ezc";
	String msgId = request.getParameter("msgId");
	//String msgFlag = request.getParameter("msgFlag");

	ezc.ezmail.EzcMailParams params=new ezc.ezmail.EzcMailParams();
	params.setGroupId("Ezc");
	params.setFolderName("Inbox");
	params.setMessageId(msgId);


	ezc.ezmail.EzMail ezmail=new ezc.ezmail.EzMail();
	ReturnObjFromRetrieve retDet = ezmail.getMailDetails(params,Session);

	params.setFileName(retDet.getFieldValueString(0,"ATTACHMENTS"));

	java.io.InputStream inStream = ezmail.getAttachmentFile(params,Session);

	String fileName=retDet.getFieldValueString(0,"ATTACHMENTS");
	fileName = fileName.substring(1,fileName.length()-1);
try
{
	response.setContentType("application/x-download");
	response.setHeader("Content-Disposition", "attachment;filename="+fileName);

	//byte[] b=new byte[inStream.available()];
	byte[] b=new byte[15000];

	int a = inStream.read(b);

//java.io.BufferedInputStream bi=new java.io.BufferedInputStream(inStream);

//bi.close();
inStream.close();

	response.setContentLength(b.length);
	response.getOutputStream().write(b);
	response.getOutputStream().flush();
}
catch(Exception e)
{
	out.println(e);
}

%>
</body>
</html>

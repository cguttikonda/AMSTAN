<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/InboxBean.jsp"%>
<%
	String msgFlag = request.getParameter("msgFlag");
	String folderName = request.getParameter("FolderName");

	String language = "EN";
	String client = "200";

	EzFolderStructure foldStruc = null;
	foldStruc = new EzFolderStructure();
	foldStruc.setFolderName(folderName);
	foldStruc.setLanguage(language);
	foldStruc.setClient(client);

	EzcMessageParams  ezcMessageParams = new EzcMessageParams();
	EzMessageParams ezMessageParams = new EzMessageParams();
	ezMessageParams.setEzFolderStructure(foldStruc);
	ezcMessageParams.setObject(ezMessageParams);
	Session.prepareParams(ezcMessageParams);
	Manager.createMsgFolder(ezcMessageParams);
	response.sendRedirect("ezListFolders.jsp?msgFlag="+msgFlag);
%>

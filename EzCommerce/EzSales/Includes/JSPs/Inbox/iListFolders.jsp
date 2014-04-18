<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezInboxBean.jsp"%>

<%!
	final String FOLDER_ID = "EFI_FOLDER_ID";
	final String FOLDER_NAME = "EFI_FOLDER_NAME";
%>

<%
	int foldRows = 0;
	ReturnObjFromRetrieve retFoldList = null;

	String language = "EN";
	String client = "200";
	EzcMessageParams  ezcMessageParams = new EzcMessageParams();
	EzMessageParams ezMessageParams = new EzMessageParams();

	ezMessageParams.setClient(client);
	ezMessageParams.setLanguage(language);

	ezcMessageParams.setObject(ezMessageParams);
	Session.prepareParams(ezcMessageParams); 

	retFoldList = (ReturnObjFromRetrieve)Manager.getFolderList(ezcMessageParams);
	retFoldList.check();
	
	if(retFoldList!=null)
		foldRows = retFoldList.getRowCount();
		
%>
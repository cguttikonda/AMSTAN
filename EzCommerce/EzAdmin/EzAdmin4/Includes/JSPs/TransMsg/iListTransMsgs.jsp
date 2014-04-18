
<%
  // Key Variables
  ReturnObjFromRetrieve retProcessedMsgList = null;
  String language = "EN";
  String client = "200";
 //SET PARAMETERS TO CONTAINER
  EzcTransParams  ezcTransParams = new EzcTransParams();
  EzTransParams ezTransParams = new EzTransParams();
  ezTransParams.setClientId("200");
  ezcTransParams.setObject(ezTransParams);
  Session.prepareParams(ezcTransParams);

//Get List of Folders
  retProcessedMsgList = (ReturnObjFromRetrieve)TransManager.getAllProcessedMsgList(ezcTransParams);

%>
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 

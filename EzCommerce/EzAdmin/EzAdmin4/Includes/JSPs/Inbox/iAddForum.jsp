<%
// Key Variables
ReturnObjFromRetrieve retUser = null;

String language = "EN";
String client = "200";

EzcUserParams uparams= new EzcUserParams();
Session.prepareParams(uparams);

EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
ezcUserNKParams.setLanguage("EN");

uparams.createContainer();
boolean result_flag = uparams.setObject(ezcUserNKParams);
// Get List of Business Users
retUser = (ReturnObjFromRetrieve)UserManager.getAllBussUsers(uparams);

%>

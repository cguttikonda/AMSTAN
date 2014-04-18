<%@ page import ="ezc.ezparam.*"%>
<%@ page import = "ezc.ezparam.EzCustomerAddrStructure"%>
<%@ page import="java.util.ResourceBundle,java.util.Enumeration"%>
<%@ page import="ezc.forums.params.*,ezc.messaging.params.*,ezc.trans.messaging.params.*" %>
<%@ page import="ezc.client.*,ezc.ezparam.*,ezc.ezadmin.ezadminutils.params.*" %>
<%@ page import="ezc.ezvendor.csb.*" %>
<%@ page import ="ezc.client.EzcUtilManager"%>
<jsp:useBean id="Manager" class="ezc.client.EzMessagingManager" scope="session"/>
<jsp:useBean id="CustomerManager" class="ezc.ezcustomer.client.EzCustomerManager" scope = "page"/>
<jsp:useBean id="MsgManager" class="ezc.client.EzMessagingManager" scope="session"/>
<%
	String template		=(String)session.getValue("Templet");
	String catalog_area	=(String)session.getValue("SalesAreaCode");

	ArrayList desiredStep=new ArrayList();
	desiredStep.add("-1");	
		
	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziWFParams params= new ezc.ezworkflow.params.EziWFParams();
	params.setTemplate(template);
	params.setSyskey(catalog_area);
	params.setParticipant((String)session.getValue("Participant"));
	params.setDesiredSteps(desiredStep);
	mainParams.setObject(params);
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve retsoldto=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlow.getWorkFlowUsers(mainParams);

	String client = "200";		
	String subject="New Web Sales Order "+weborno+" ("+sDocNumber+") has been created.";
	
	String mailMessageDetails="New Web Sales Order "+weborno+" ("+sDocNumber+") has been created.\n";
	mailMessageDetails =mailMessageDetails + "PO NO : " + ezHeader.getPoNr()+"\n";
	mailMessageDetails =mailMessageDetails + "Customer : " + ezSoldTo.getName()+"(" + ezSoldTo.getSoldTo() + ")\n";

	EzPersonalMsgStructure[] msgDetails = null;
	EzMsgStructure msgStruc = null;
	msgStruc = new EzMsgStructure();
	msgStruc.setClient(client);
	msgStruc.setPriorityFlag("U");
	msgStruc.setMsgHeader(subject);
	msgStruc.setMsgContent1(mailMessageDetails);
	msgStruc.setMsgContent2("");
	msgStruc.setLnkExtInfo("Lnk");

	EzcMessageParams ezcMessageParams = new EzcMessageParams();
	EzMessageParams ezMessageParams = new EzMessageParams();
	ezMessageParams.setEzMsgStructure(msgStruc);
	ezcMessageParams.setObject(ezMessageParams);
	Session.prepareParams(ezcMessageParams);
	if(retsoldto!=null)
	{
		for(int j=0;j<retsoldto.getRowCount();j++)
		{
			msgDetails = new EzPersonalMsgStructure[1];
			msgDetails[0] = new EzPersonalMsgStructure();
			msgDetails[0].setClient(client);
			msgDetails[0].setRecUserId(retsoldto.getFieldValueString(j,"EU_ID").toUpperCase());			
			msgDetails[0].setExpiryDate("99999999");
			msgDetails[0].setExpiryDays(10);
			msgDetails[0].setReminderDate("0");
			msgDetails[0].setFolderId("1000");
			ezMessageParams.setEzPersonalMsgStructure(msgDetails);
			MsgManager.createPersonalMsg(ezcMessageParams);
		}
	}
%>
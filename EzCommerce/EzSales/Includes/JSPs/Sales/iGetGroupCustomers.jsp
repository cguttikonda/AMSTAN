<%@ include file="../../../Includes/Lib/ezWorkFlow.jsp"%>

<%
//ReturnObjFromRetrieve retIntUsers=null;
	String catalog_area = (String)session.getValue("SalesAreaCode");
	String userGroup=(String)session.getValue("UserGroup");
	String salesOffice=(String)session.getValue("SalesOffice");


//starts

	String template1=(String)session.getValue("Templet");
	String UserRole1 = (String)session.getValue("UserRole");
	ArrayList desiredSteps=new ArrayList();

	if("CM".equals(UserRole))
		desiredSteps.add("1");
	else if("LF".equals(UserRole))
		desiredSteps.add("2");
	else if("BP".equals(UserRole))
		desiredSteps.add("3");		


	String participant1=(String)session.getValue("UserGroup");
	String syskey1=(String)session.getValue("SalesAreaCode");

	if("BP".equals(UserRole) || "BP"==UserRole)
		participant1= "SALES_FINANCE";

//Ends
	boolean USER_GROUP_EXISTS=(userGroup!=null  && !"null".equals(userGroup) && !"".equals(userGroup));

ezc.client.EzcUtilManager UtilManager=null;
ArrayList allCust = new ArrayList();

if(session.getValue("retCustList") != null)
{
	retCustList = (ezc.ezparam.ReturnObjFromRetrieve)session.getValue("retCustList");
}else
{

	if("CM".equals(UserRole))
	{
		if(USER_GROUP_EXISTS)
		{
/*			ezc.ezparam.EzcParams mainParamsu = new ezc.ezparam.EzcParams(false);
			ezc.ezworkflow.params.EziWorkGroupUsersParams paramsu= new ezc.ezworkflow.params.EziWorkGroupUsersParams();
			paramsu.setGroupId(userGroup);
			paramsu.setSyskey(catalog_area);
			mainParamsu.setObject(paramsu);
			Session.prepareParams(mainParamsu);
			retCustList=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlow.getWorkGroupUsers(mainParamsu);
*/
			ezc.ezparam.EzcParams mainParamsu = new ezc.ezparam.EzcParams(false);
			ezc.ezworkflow.params.EziWFParams paramsu= new ezc.ezworkflow.params.EziWFParams();
			paramsu.setTemplate(template1);
			paramsu.setSyskey(catalog_area); //999602
			paramsu.setPartnerFunction("AG");
			paramsu.setParticipant(participant1);
			paramsu.setDesiredSteps(desiredSteps);
			mainParamsu.setObject(paramsu);
			Session.prepareParams(mainParamsu);
			//ezc.ezparam.ReturnObjFromRetrieve retUser=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlow.getWorkFlowUsers(mainParamsu);
			retCustList=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlow.getWorkFlowUsers(mainParamsu);

		}
		else
		{
			UtilManager = new ezc.client.EzcUtilManager(Session);
			retCustList = (ReturnObjFromRetrieve)UtilManager.getUserCustomers(catalog_area);
		}
	}
	else if("PP".equals(UserRole)) // Added  by Srinivas to accomodiate Ramadurai
	{
			
			UtilManager = new ezc.client.EzcUtilManager(Session);
	     		retCustList = (ReturnObjFromRetrieve)UtilManager.getUserCustomers(catalog_area);
	}
	else if("LF".equals(UserRole)   || "BP".equals(UserRole))
	{



			
			ezc.ezparam.EzcParams mainParamsu = new ezc.ezparam.EzcParams(false);
			ezc.ezworkflow.params.EziWFParams paramsu= new ezc.ezworkflow.params.EziWFParams();
			paramsu.setTemplate(template1);
			paramsu.setSyskey(catalog_area); //999602
			paramsu.setPartnerFunction("AG");
			paramsu.setParticipant(participant1);
			paramsu.setDesiredSteps(desiredSteps);
			mainParamsu.setObject(paramsu);
			Session.prepareParams(mainParamsu);
			//ezc.ezparam.ReturnObjFromRetrieve retUser=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlow.getWorkFlowUsers(mainParamsu);
			retCustList=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlow.getWorkFlowUsers(mainParamsu);

		//	out.println("****"+retCustList.toEzcString());



	}else
	{
			// This call was commented as ordered by Mr.venkat by Suresh.V at ranbaxy on 29-april-2003 to increase performance by removing call
			//UtilManager = new ezc.client.EzcUtilManager(Session);
			//retCustList = (ReturnObjFromRetrieve) UtilManager.getUserCustomers(catalog_area);
			retCustList=new ReturnObjFromRetrieve();
	}
	session.putValue("retCustList",retCustList);
}
int co=retCustList.getRowCount();

log4j.log(""+retCustList.toEzcString(),"W");

for(int i=0;i<co;i++)
{
	allCust.add(retCustList.getFieldValueString(i,"EC_ERP_CUST_NO"));
}
%>

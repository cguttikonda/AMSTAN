<%@ page import="java.util.*" %>
<%//@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezInboxBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezGlobalBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezWorkFlow.jsp"%>
<jsp:useBean id="UManager" class="ezc.client.EzUserAdminManager" scope="session" />
<html>
<head>
<%
	//This code for Language indipendent
	
	String lang = (String)session.getValue("userLang"); 
	if(lang==null || "null".equals(lang)){
		lang ="ENGLISH";
	}
        if(lang.equals("GERMANY"))
 	{	
       		java.util.Locale l = new java.util.Locale("de","DE");
       		session.putValue("LOCALE",l);
 	}
 	else if(lang.equals("ENGLISH"))
 	{
		java.util.Locale l = new java.util.Locale("en","US");
		session.putValue("LOCALE",l);
 	}
 	else
 	{
		java.util.Locale l = new java.util.Locale("de","DE");
		session.putValue("LOCALE",l);
  	}

	//This code for Globel date,currency format's
	EzGlobal.setDateFormat("MM/dd/yyyy");
	EzGlobal.setLocale((java.util.Locale)session.getValue("LOCALE"));
	EzGlobal.setCurrencySymbol("$");
	EzGlobal.setIsPreSymbol(true);
	EzGlobal.setIsSymbolRequired(false);
	//End of Global

	//To put UserRole(from UserDefualts)  into session
	
	ezc.ezparam.EzcUserParams uparams= new ezc.ezparam.EzcUserParams();
	EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
	ezcUserNKParams.setLanguage("EN");
	ezcUserNKParams.setSys_Key("0");
	uparams.createContainer();
	uparams.setUserId(Session.getUserId());
	uparams.setObject(ezcUserNKParams);
	Session.prepareParams(uparams);
	ReturnObjFromRetrieve retobj = (ReturnObjFromRetrieve)(UManager.getAddUserDefaults(uparams));

	//retobj.toEzcString();

	String userStyle=null;
	String userRole=null;
	String userGroup=null;
	String salesOffice=null;
	String isSubUser = null;
	String userStatus = null;
	String suAuth = null;
	String viewAllCust = null;

	for(int i=0;i<retobj.getRowCount();i++)
	{
		if("STYLE".equals(retobj.getFieldValueString(i,"EUD_KEY")))
		{
			userStyle=retobj.getFieldValueString(i,"EUD_VALUE");
		}
		if("USERROLE".equals(retobj.getFieldValueString(i,"EUD_KEY")))
		{
			userRole=retobj.getFieldValueString(i,"EUD_VALUE");
		}
		if("USERGROUP".equals(retobj.getFieldValueString(i,"EUD_KEY")))
		{
			//userGroup=retobj.getFieldValueString(i,"EUD_VALUE");
		}
		if("SALESOFFICE".equals(retobj.getFieldValueString(i,"EUD_KEY")))
		{
			salesOffice=retobj.getFieldValueString(i,"EUD_VALUE");
		}
		if("ISSUBUSER".equals(retobj.getFieldValueString(i,"EUD_KEY")))
		{
			isSubUser=retobj.getFieldValueString(i,"EUD_VALUE");
		}
		if("STATUS".equals(retobj.getFieldValueString(i,"EUD_KEY")))
		{
			userStatus=retobj.getFieldValueString(i,"EUD_VALUE");
		}
		if("SUAUTH".equals(retobj.getFieldValueString(i,"EUD_KEY")))
		{
			suAuth=retobj.getFieldValueString(i,"EUD_VALUE");
		}
		if("VIEWALLCUST".equals(retobj.getFieldValueString(i,"EUD_KEY")))
		{
			viewAllCust=retobj.getFieldValueString(i,"EUD_VALUE");
		}
	}
	ezc.ezcommon.EzLog4j.log("<<<isSubUser>>>>>>>>>>>>>."+isSubUser ,"I");

	if(isSubUser==null || "null".equals(isSubUser) || "".equals(isSubUser))
		isSubUser="N";
	if(userStatus!=null)userStatus=userStatus.trim();
	ezc.ezcommon.EzLog4j.log("<<<userStatus>>>>>>>>>>>>>."+userStatus ,"I");

	if(suAuth==null || "null".equals(suAuth) || "".equals(suAuth)) suAuth = "";
	if(viewAllCust==null || "null".equals(viewAllCust) || "".equals(viewAllCust)) viewAllCust = "N";

	session.putValue("IsSubUser",isSubUser);		
	session.putValue("userStyle",userStyle);
	session.putValue("UserRole1",userRole);
	session.putValue("UserRole",userRole);
	session.putValue("SuAuth",suAuth);
	session.putValue("VIEWALLCUST",viewAllCust);

	//this Method is used to get the userGroup for ALL

	if("CM".equals(userRole) || "LF".equals(userRole))
	{
		ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziWorkGroupsParams params= new ezc.ezworkflow.params.EziWorkGroupsParams();
		params.setUserId(Session.getUserId());
		mainParams.setObject(params);
		Session.prepareParams(mainParams);
	
		ezc.ezparam.ReturnObjFromRetrieve ret=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlow.getWorkGroupsList(mainParams);
		
	
		java.util.ArrayList aGroups=new java.util.ArrayList();
		if(ret!=null && ret.getRowCount()>0)
		{
			int retCount = ret.getRowCount();
			userGroup = ret.getFieldValueString(0,"GROUP_ID");
		
			if(retCount>1)
			{
				for(int p=1;p<retCount;p++)
					aGroups.add(ret.getFieldValueString(p,"GROUP_ID"));
			}
			session.putValue("AGROUPS",aGroups);
		}
	}

	//method ends here

	session.putValue("UserGroup",userGroup);
	session.putValue("SalesOffice",salesOffice);
	session.putValue("DATEFORMAT",String.valueOf(ezc.ezutil.FormatDate.MMDDYYYY));
	session.putValue("DATESEPERATOR","/");

	String WFRole="";
	String Participant="";

	if("CU".equalsIgnoreCase(userRole))
	{
		Participant 	="SALES_CUSTOMER";
		WFRole 		="SALES_CUSTOMER";
	}
	else if("CM".equalsIgnoreCase(userRole))
	{
		Participant	="SALES_CM";
		WFRole		="SALES_CM";
	}
	else if("LF".equalsIgnoreCase(userRole))
	{
		Participant 	="SALES_LF";
		WFRole		="SALES_LF";
	}
	else if("DM".equalsIgnoreCase(userRole))
	{
		Participant 	="SALES_DM";
		WFRole		="SALES_DM";
	}
	else if("SM".equalsIgnoreCase(userRole))
	{
		Participant 	="SALES_SM";
		WFRole		="SALES_SM";
	}
	else if("BP".equalsIgnoreCase(userRole))
	{
		Participant 	="SALES_FINANCE";
		WFRole		="SALES_FINANCE";
	}
	
	Participant = (userGroup == null||"null".equals(userGroup))?Participant:userGroup;
	
	session.putValue("Participant",Participant);
	session.putValue("WFRole",WFRole);

	String redirectfile = null;

	ReturnObjFromRetrieve retUserData=null;

	EzcUserParams uparamsN= new EzcUserParams();
	EzcUserNKParams ezcUserNKParamsN = new EzcUserNKParams();
	ezcUserNKParamsN.setLanguage("EN");
	uparamsN.setUserId(Session.getUserId());
	uparamsN.createContainer();
	uparamsN.setObject(ezcUserNKParamsN);
	Session.prepareParams(uparamsN);	
	retUserData = (ReturnObjFromRetrieve)UManager.getUserData(uparamsN);

	String UserType	=retUserData.getFieldValueString(0,"EU_TYPE");
	String bussPrt	=retUserData.getFieldValueString(0,"EU_BUSINESS_PARTNER");
	
	session.putValue("BussPart",bussPrt);
	session.putValue("UserType",UserType);
	
	System.out.println("Success in Confirm >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
	
	if("3".equals(UserType))
	{
		/*
		ezc.ezshipment.client.EzShipmentManager dsclmrManager = new ezc.ezshipment.client.EzShipmentManager();
		ezc.ezparam.EzcParams dsclmrparams = new ezc.ezparam.EzcParams(true);
		ezc.ezparam.EzcUserParams dsclmrusrparams= new ezc.ezparam.EzcUserParams();
		dsclmrusrparams.setUserId(Session.getUserId()+"¥Y");//This is for knowing whether customer clicked on 'I Agree' button when first time logged in the portal .
		dsclmrparams.setObject(dsclmrusrparams);
		Session.prepareParams(dsclmrparams);
		ezc.ezparam.ReturnObjFromRetrieve dsclmrRetObj = (ezc.ezparam.ReturnObjFromRetrieve)dsclmrManager.ezGetDisclaimerStamp(dsclmrparams);
		*/
		
		if("I".equals(userStatus))
			redirectfile = "ezUserBlock.jsp";
		/*else if (dsclmrRetObj!=null && dsclmrRetObj.getRowCount()>0)
		{
			redirectfile="ezPutDisclaimerStamp.jsp"; 
		}*/
		else{
			redirectfile="ezDisclamerframeset.jsp"; // this to for disclamier
		}	
	}
	else if (UserType.equals("2"))
	{
		redirectfile = "ezUserCheck.jsp";	//  Intranet User
	}
	else
       		redirectfile = "invalidArea.jsp";

	response.sendRedirect(redirectfile);
%>
</head>
<body>
<Div id="MenuSol"></Div>
</body>
</html>
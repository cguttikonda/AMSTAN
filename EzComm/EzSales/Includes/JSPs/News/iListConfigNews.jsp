<%@ page import = "ezc.ezparam.*" %>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session" />
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session" />
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<%
	ReturnObjFromRetrieve ret = null;

	EzcSysConfigParams sparams = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
	snkparams.setLanguage("EN");
	sparams.setObject(snkparams);
	Session.prepareParams(sparams);
	ret = (ReturnObjFromRetrieve) sysManager.getCatalogAreas(sparams);
	//out.println("ret:::::::::::::::::::"+ret.toEzcString());
	String[] sortArr={"ESKD_SYS_KEY"};

	/*********VALUE_MAP********

	ReturnObjFromRetrieve newsValMapRetObj = null;

	ezc.ezparam.EzcParams mainParams_NVM = new ezc.ezparam.EzcParams(false);
	EziMiscParams miscParams_NVM = new EziMiscParams();

	miscParams_NVM.setIdenKey("VALUE_MAP"); // Mandatory 
	miscParams_NVM.setExt3("NEWSVALMAP"); // NEWSVALMAP is the map_type in the table and it is optional should pass the blank parameter
	mainParams_NVM.setLocalStore("Y");
	mainParams_NVM.setObject(miscParams_NVM);
	Session.prepareParams(mainParams_NVM);

	try
	{
		newsValMapRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParams_NVM);
	}
	catch(Exception e){out.println("Exception in Getting Data"+e);}

	*********VALUE_MAP********/

	ReturnObjFromRetrieve retUsers  = null;
	String websyskey=request.getParameter("WebSysKey");
	String myUserType = request.getParameter("myUserType");
	//out.println("myUserType::::::"+myUserType);
	
	String websys="";
	if("All".equals(websyskey))
		websys=websyskey;
	
	
	if((websyskey!=null))
	{
		if(!websyskey.equals("sel") && !websyskey.equals("All"))
		{
			EzcUserParams uparams= new EzcUserParams();
			Session.prepareParams(uparams);

			EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
			ezcUserNKParams.setLanguage("EN");
			ezcUserNKParams.setSys_Key(websyskey);
			uparams.createContainer();
			boolean result_flag = uparams.setObject(ezcUserNKParams);
			retUsers =	(ReturnObjFromRetrieve)UserManager.getUsersForSalesArea(uparams);
			ezc.ezcommon.EzLog4j.log("DE1:End Get BizPartners1111111"+retUsers,"I");
		}
		else
		{
			if(websyskey.equals("All"))
			{
				int myRetCount=ret.getRowCount();
				String allWebSysKeys="";
				if(myRetCount==0)
					allWebSysKeys="NONE";	
				else
					allWebSysKeys=ret.getFieldValueString(0,"ESKD_SYS_KEY");
				for(int k=1;k<myRetCount;k++)
				{
					allWebSysKeys += "','"+ret.getFieldValueString(k,"ESKD_SYS_KEY");
				}
				EzcUserParams uparams= new EzcUserParams();
				Session.prepareParams(uparams);	
				EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
				ezcUserNKParams.setLanguage("EN");
				ezcUserNKParams.setSys_Key(allWebSysKeys);
				uparams.createContainer();
				boolean result_flag = uparams.setObject(ezcUserNKParams);
				ezc.ezcommon.EzLog4j.log("DE1:Start Get BizUsers","I");
				retUsers =	(ReturnObjFromRetrieve)UserManager.getUsersForSalesArea(uparams);
				ezc.ezcommon.EzLog4j.log("DE1:End Get BizPartners"+retUsers,"I");
				
			}
		}
	}
	java.util.TreeSet alphaTree = new java.util.TreeSet();
	String alphaName = null;
	String initAlpha = "";
	int deleteCount = 0;
	
	if(myUserType!=null && !"null".equals(myUserType) && websyskey!=null && !"null".equals(websyskey))
	{
		deleteCount = retUsers.getRowCount();
		for(int i=deleteCount-1;i>=0;i--)
		{
			if(!(myUserType.equals(retUsers.getFieldValueString(i,"EU_TYPE"))))
			{
				retUsers.deleteRow(i);
			}
		}
	}
	
	if(websyskey!=null && !"null".equals(websyskey))
	{
		deleteCount = retUsers.getRowCount();
		for(int i=0;i<deleteCount;i++)
		{
			alphaName = retUsers.getFieldValueString(i,"EU_FIRST_NAME");
			alphaTree.add((alphaName.substring(0,1)).toUpperCase());
		}
		//if(alphaTree.size()>0)
		//initAlpha = (String)alphaTree.first()+"*";
	}
	
	String searchPartner=request.getParameter("searchcriteria");
	if(alphaTree.size()>0 && "$".equals(searchPartner))
		searchPartner=(String)alphaTree.first()+"*";	
		
	if(retUsers!=null)
	//out.println("retUsers>>>"+retUsers.getRowCount());
%>
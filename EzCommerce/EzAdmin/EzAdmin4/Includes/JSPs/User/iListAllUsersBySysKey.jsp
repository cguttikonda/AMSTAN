<%@ page import = "ezc.ezparam.*" %>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session" />
<%
	ReturnObjFromRetrieve retUsers  = null;
	String websyskey=request.getParameter("WebSysKey");
	String myUserType = request.getParameter("myUserType");
	
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
					allWebSysKeys=ret.getFieldValueString(0,SYSTEM_KEY);
				for(int k=1;k<myRetCount;k++)
				{
					allWebSysKeys += "','"+ret.getFieldValueString(k,SYSTEM_KEY);
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

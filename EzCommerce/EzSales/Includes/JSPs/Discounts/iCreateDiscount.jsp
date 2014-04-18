<%@ page import="ezc.ezcnetconnector.params.*,ezc.ezparam.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="EzWorkFlowManager" class="ezc.ezworkflow.client.EzWorkFlowManager" scope="session" />
<jsp:useBean id="CnetManager" class="ezc.ezcnetconnector.client.EzCnetConnectorManager" />
<jsp:useBean id="UManager" class="ezc.client.EzUserAdminManager" scope="session" />

<%
	String template		= (String)session.getValue("Templet");
	String UserRole 	= (String)session.getValue("UserRole");
	String participant	= (String)session.getValue("UserGroup");
	String syskey		= (String)session.getValue("SalesAreaCode");
	String logInUserId	= Session.getUserId();

	String showDisp = request.getParameter("showDisp");
	String dispData = request.getParameter("dispData");
	String manfId   = request.getParameter("manfId");
	String manfDesc = request.getParameter("mfr");
	String itemCat  = request.getParameter("itemCat");
	String soldTo   = request.getParameter("soldTo");
	String discount = request.getParameter("discount");
	
	if(dispData==null || "null".equalsIgnoreCase(dispData) || "BLANK".equals(dispData))
	{
		dispData = "";
	}
	else
	{
		dispData = dispData.replaceAll("¤¤","%");
	}
	
	if(manfId==null || "null".equalsIgnoreCase(manfId)) manfId = "";
	if(manfDesc==null || "null".equalsIgnoreCase(manfDesc)) manfDesc = "";
	if(itemCat==null || "null".equalsIgnoreCase(itemCat) || "BLANK".equals(itemCat)) itemCat = "";
	if(soldTo==null || "null".equalsIgnoreCase(soldTo)) soldTo = "";
	if(discount==null || "null".equalsIgnoreCase(discount)) discount = "";

	ArrayList desiredSteps=new ArrayList();
	if("CM".equals(UserRole))
		desiredSteps.add("1");
	else if("DM".equals(UserRole))
		desiredSteps.add("2");	
	else if("LF".equals(UserRole))
		desiredSteps.add("3");
	else if("SM".equals(UserRole))
		desiredSteps.add("4");	
	else if("SBU".equals(UserRole))
		desiredSteps.add("5");
	else if("INDREG".equals(UserRole))
		desiredSteps.add("6");	
	
	ReturnObjFromRetrieve retsoldto = null;
	int retsoldtoCount = 0;
	
	ezc.ezparam.EzcParams mainParamsu = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziWFParams paramsu = new ezc.ezworkflow.params.EziWFParams();
	paramsu.setTemplate(template);
	paramsu.setSyskey(syskey);
	paramsu.setPartnerFunction("AG");
	paramsu.setParticipant(participant);
	paramsu.setDesiredSteps(desiredSteps);
	mainParamsu.setObject(paramsu);
	Session.prepareParams(mainParamsu);
	
	retsoldto = (ReturnObjFromRetrieve)EzWorkFlowManager.getWorkFlowUsers(mainParamsu);
	
	if(retsoldto!=null)
		retsoldtoCount = retsoldto.getRowCount();
		
	//out.println("retsoldto:::::::::"+retsoldto.toEzcString());

	ReturnObjFromRetrieve retCat=null;
	int retCatCnt = 0;
	//out.print(manfId);
	if(!"".equals(manfId))
	{
		EzcParams ezcpparams = new EzcParams(false);
		EzCnetConnectorParams cnetParams=new EzCnetConnectorParams();
		cnetParams.setStatus("GET_CATEGORY_MFR");
		cnetParams.setExt1("order by cds_Cctez.Description");
		cnetParams.setQuery(manfId);
		ezcpparams.setObject(cnetParams);
		ezcpparams.setLocalStore("Y");
		Session.prepareParams(ezcpparams);

		retCat = (ReturnObjFromRetrieve)CnetManager.ezGetCnetProductsByStatus(ezcpparams);
		if(retCat!=null)
			retCatCnt = retCat.getRowCount();

		//out.println("retCat>>>>"+retCat.toEzcString());
	}	
	
	String userId="",bPart="";
	java.util.ArrayList bpAuth = new java.util.ArrayList();
	mainParamsu = new ezc.ezparam.EzcParams(false);
	paramsu = new ezc.ezworkflow.params.EziWFParams();
	paramsu.setTemplate(template);
	paramsu.setSyskey(syskey);
	paramsu.setParticipant(participant);
	paramsu.setDesiredSteps(desiredSteps);
	mainParamsu.setObject(paramsu);
	Session.prepareParams(mainParamsu);
	
	ReturnObjFromRetrieve retsoldtoUid = (ReturnObjFromRetrieve)EzWorkFlowManager.getWorkFlowUsers(mainParamsu);
	if(retsoldtoUid!=null)
	{
		for(int k=0;k<retsoldtoUid.getRowCount();k++)
		{
			userId = retsoldtoUid.getFieldValueString(k,"EU_ID");
			bPart = retsoldtoUid.getFieldValueString(k,"EU_BUSINESS_PARTNER");
			
			ezc.ezparam.EzcUserParams uparams= new ezc.ezparam.EzcUserParams();
			EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
			ezcUserNKParams.setLanguage("EN");
			ezcUserNKParams.setSys_Key("0");
			uparams.createContainer();
			uparams.setUserId(userId);
			uparams.setObject(ezcUserNKParams);
			Session.prepareParams(uparams);
			ReturnObjFromRetrieve retobj = (ReturnObjFromRetrieve)(UManager.getAddUserDefaults(uparams));
			if(retobj!=null)
			{
				String isSubUser = "";
				String ecadVal = "";
				
				for(int j=0;j<retobj.getRowCount();j++)
				{
					if("ISSUBUSER".equals(retobj.getFieldValueString(j,"EUD_KEY")))
					{
						isSubUser = retobj.getFieldValueString(j,"EUD_VALUE");
					}
					if("SALESREPRES".equals(retobj.getFieldValueString(j,"EUD_KEY")))
					{
						ecadVal = retobj.getFieldValueString(j,"EUD_VALUE");
					}
					if(!"Y".equals(isSubUser))
					{
						try
						{
							StringTokenizer stEcadVal = new StringTokenizer(ecadVal,"¥");

							while(stEcadVal.hasMoreTokens())
							{
								String salesRep_A = (String)stEcadVal.nextElement();
								String salesRep_AId = salesRep_A.split("¤")[0];

								if(logInUserId.equalsIgnoreCase(salesRep_AId.trim()))
								{
									bpAuth.add(bPart);
								}
							}
						}
						catch(Exception e){}
					}
				}
			}			
		}
	}
	for(int i=retsoldtoCount-1;i>=0;i--)
	{
		String bPartner=retsoldto.getFieldValueString(i,"EC_BUSINESS_PARTNER");
		if(!bpAuth.contains(bPartner))
			retsoldto.deleteRow(i);
	}
	if(retsoldto!=null)
		retsoldtoCount = retsoldto.getRowCount();
%>
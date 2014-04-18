<%@ include file="../../Lib/EzWorkFlowBean.jsp"%>
<%
	String template		= (String)session.getValue("TEMPLATE");	
	String sessionRole	= (String)session.getValue("ROLE");
	String userGroup	= (String)session.getValue("USERGROUP");
	String userName		= (String)Session.getUserId();
	String price 		= request.getParameter("PRICE");	
	int retCount = 0;      
	java.util.Hashtable hashCheck = new  java.util.Hashtable();
	hashCheck.put("G","Group");
	hashCheck.put("R","Role");
	hashCheck.put("U","User");
	
	
	String currentPurchaseArea			=	(String)session.getValue("SYSKEY");
	java.util.Hashtable  purchaseGroupTempStore	= 	(java.util.Hashtable)session.getValue("PURGROUPS");
	String currentPurchaseGroup 			=  	(String)purchaseGroupTempStore.get(currentPurchaseArea);
	
	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziTemplateStepsParams params= new ezc.ezworkflow.params.EziTemplateStepsParams();
	params.setCode(template);
	mainParams.setObject(params);
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve listRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getTemplateStepsList(mainParams);

	
	ezc.ezparam.EzcParams bypassMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziByPassInfoParams byPassInfoParams=new ezc.ezworkflow.params.EziByPassInfoParams();
	byPassInfoParams.setTemplate(template+"¥"+price);
	byPassInfoParams.setSourceType("G','R','U");
	byPassInfoParams.setSourceLevel(userGroup+"','"+userName+"','"+sessionRole);
	bypassMainParams.setObject(byPassInfoParams);
	Session.prepareParams(bypassMainParams);
	ezc.ezparam.ReturnObjFromRetrieve bypassRet = (ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getByPassList(bypassMainParams);
	String srcLevel = "0";
	String dstLevel = "0";
	if(bypassRet!=null)
	{
		int byPassCount = bypassRet.getRowCount();
		for(int i=0;i<byPassCount;i++)
		{
			if("Y".equals(bypassRet.getFieldValueString(i,"ALLOWED")))
			{
				srcLevel = bypassRet.getFieldValueString(i,"SOURCE_LEVEL");
				dstLevel = bypassRet.getFieldValueString(i,"DEST_LEVEL");
				break;
			}
		}
	}
	
	int srcLvl = Integer.parseInt(srcLevel);
	int dstLvl = Integer.parseInt(dstLevel);
	int listCnt = listRet.getRowCount();
	String lastStep = "";
	int tmpLevel = 0;
	for(int i=listCnt-1;i>=0;i--)
	{
		if(i == listCnt-1)
			lastStep = listRet.getFieldValueString(i,"STEP");
		try{
			tmpLevel = Integer.parseInt(listRet.getFieldValueString(i,"STEP"));
		}catch(Exception ex){	tmpLevel = 0;}
		
		if(tmpLevel<=srcLvl || tmpLevel>dstLvl)
			listRet.deleteRow(i);
	}
	
	listRet.addColumn("CANAPPROVE");
	retCount = listRet.getRowCount();
	String role = "";
	String userId = "";
	for(int i=0;i<retCount;i++)
	{
		role 	= listRet.getFieldValueString(i,"ROLE");
		userId 	= getUserName(Session,listRet.getFieldValueString(i,"OWNERPARTICIPANT"),listRet.getFieldValueString(i,"OPTYPE")+"¥ID",(String)session.getValue("SYSKEY"));
		ezc.ezworkflow.client.EzWorkFlowManager ezWorkFlowManager = new ezc.ezworkflow.client.EzWorkFlowManager();
		ezc.ezworkflow.params.EziActionsParams  wfp = new ezc.ezworkflow.params.EziActionsParams();
		ezc.ezparam.EzcParams wfMainP = new ezc.ezparam.EzcParams(false);
		wfp.setFlag("Y");
		wfp.setRole(role);
		wfp.setAuthKey("QCF_RELEASE");
		wfp.setValue(price);
		wfp.setUserId(userId);
		wfp.setPurchaseGroup(currentPurchaseGroup);
		wfMainP.setObject(wfp);
		Session.prepareParams(wfMainP);
		ezc.ezparam.ReturnObjFromRetrieve wfr=(ezc.ezparam.ReturnObjFromRetrieve)ezWorkFlowManager.getActionsList(wfMainP);
		String actionsList = "";
		if(wfr!=null)
		{	
			actionsList = wfr.getFieldValueString(0,"ACTIONS");	
			if(actionsList.indexOf("APPROVED") > 0)
				listRet.setFieldValueAt("CANAPPROVE","Y",i);	
			else	
				listRet.setFieldValueAt("CANAPPROVE","N",i);	
		}	
	}	
%>

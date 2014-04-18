<%@ page import="ezc.ezsynch.*,ezc.ezparam.*" %>


<%
	try
	{
		ezc.ezadmin.ezadminutils.client.EzAdminUtilsManager utilManager=new ezc.ezadmin.ezadminutils.client.EzAdminUtilsManager();
		ezc.ezadmin.ezadminutils.params.EziAdminUtilsParams utilParams=new ezc.ezadmin.ezadminutils.params.EziAdminUtilsParams();
		utilParams.setDefaultKey("SECTOR");
		EzcParams utilMainParams = new EzcParams(false);
		utilMainParams.setObject(utilParams);
		Session.prepareParams(utilMainParams);
		ReturnObjFromRetrieve usersRet =(ReturnObjFromRetrieve)utilManager.getUsersByDefault(utilMainParams);
		
		java.util.Vector userIds=new java.util.Vector();	
		int rowCount = usersRet.getRowCount();
		for(int x=0;x<rowCount;x++)
		{
			if(! userIds.contains(usersRet.getFieldValueString(x,"USER_ID")))	
				userIds.add(usersRet.getFieldValueString(x,"USER_ID"));
		}
		
		ezc.ezupload.client.EzUploadManager upManager=new ezc.ezupload.client.EzUploadManager();
		ezc.ezupload.params.EziUploadDocsParams upParams=new ezc.ezupload.params.EziUploadDocsParams();
		ezc.ezparam.EzcParams upMainParams = new ezc.ezparam.EzcParams(false);
		String objNo="555555"+"VERSION"+code;
		upParams.setObjectNo("'"+objNo+"'");
		upMainParams.setObject(upParams);
		Session.prepareParams(upMainParams);
		ReturnObjFromRetrieve upRet=(ReturnObjFromRetrieve)upManager.getUploadedDocs(upMainParams);
		
		for(int k=upRet.getRowCount()-1;k>=0;k--)
		{
			if(!((upRet.getFieldValueString(k,"UPLOADNO").trim()).equals(patchNo.trim())))
				upRet.deleteRow(k);
		}
		
		
		//ADDED BY SATYA 13/04/2004
		
		upRet.addColumn("HISTORY");
		upRet.addColumn("COMPONENT");
		upRet.addColumn("VERSION");
		upRet.addColumn("MODIFIEDDATE");
		upRet.addColumn("PATCH");
		
		
		upRet.setFieldValueAt("HISTORY",historyNo,0);
		upRet.setFieldValueAt("COMPONENT",code,0);
		upRet.setFieldValueAt("VERSION",version,0);
		upRet.setFieldValueAt("MODIFIEDDATE",releasedOn,0);
		upRet.setFieldValueAt("PATCH",patchNo,0);
		

		EzcSynchBlockParams syb=new EzcSynchBlockParams();
		syb.setMessageId(String.valueOf(System.currentTimeMillis()));
		syb.setMessageStatus("B");
		syb.setMessageType("VERSION-ADD");
		syb.setContainer(upRet);
		
		EzsSynchExecuteEngine see = null;
		
		int usersCount=userIds.size();
		
		syb.setUserId(userName);
		see=new EzsSynchExecuteEngine();
		see.start(syb);
	}
	catch(Exception e)
	{
		System.out.println(">>>>>>>>>>>>>---"+e.getMessage());
		e.printStackTrace();
	}


%>










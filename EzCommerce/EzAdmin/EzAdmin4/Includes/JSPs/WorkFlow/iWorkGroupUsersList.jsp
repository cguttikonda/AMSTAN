<%
	String groupid=request.getParameter("groups");
	ezc.ezparam.ReturnObjFromRetrieve listRet1=null;
	String groupType="";
	//myFlag for disbaling WorkGroups Select when coming from ezNextOrganogramLevelsByParticipant.jsp -- Suresh Parimi. 3 rd July 2003.
	String myFlag = request.getParameter("myFlag");
	if(myFlag==null)
		myFlag="Y";

	if(groupid!=null)
	{
		ezc.ezparam.EzcParams mainParamsu = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziWorkGroupUsersParams paramsu= new ezc.ezworkflow.params.EziWorkGroupUsersParams();
		paramsu.setGroupId("'"+groupid+"'");
		mainParamsu.setObject(paramsu);
		Session.prepareParams(mainParamsu);
		listRet1=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWorkGroupUsers(mainParamsu);
		
		if(listRet1.getRowCount() >0)
			groupType=listRet1.getFieldValueString(0,"WGTYPE");
		int myRowCount = listRet.getRowCount();
		if(myRowCount>0)
		{
			for(int i=0;i<myRowCount;i++)
			{
				if(groupid.equals(listRet.getFieldValueString(i,"GROUP_ID")))
					wgType = listRet.getFieldValueString(i,"WGTYPE");
			}
		}
		if("VN".equals(wgType) || "IV".equals(wgType))
			myAreaFlag = "V";
		else if("AG".equals(wgType) || "IC".equals(wgType))
			myAreaFlag = "C";
		session.putValue("myAreaFlag",myAreaFlag);
	}
	String areaFlag = myAreaFlag;
%>

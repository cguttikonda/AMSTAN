<%@ include file="../../Lib/AdminUtilsBean.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%
	ReturnObjFromRetrieve ret = null;
	String areaFlag = request.getParameter("Area");
	if(areaFlag!=null)
	{
		EziAdminUtilsParams adminUtilsParams = new EziAdminUtilsParams();
		adminUtilsParams.setAreaType(areaFlag);
		EzcParams mainParams = new EzcParams(false);
		mainParams.setObject(adminUtilsParams);
		Session.prepareParams(mainParams);

		ret = (ReturnObjFromRetrieve)AUM.getUsersAreasWithDefaults(mainParams);
	}
	int rowCount = ret.getRowCount();
	java.util.Vector myColVector = new java.util.Vector();
	java.util.Hashtable myHashTable = new java.util.Hashtable();
	java.util.Hashtable mySyskeyTable = new java.util.Hashtable();
	if(rowCount>0)
	{
		myColVector.add("SYSKEY");
		myColVector.add("SYSKEYDESC");
	}
	for (int i=0;i<rowCount;i++)
	{
		String sysKey = ret.getFieldValueString(i,"ESKD_SYS_KEY");
		String defKey = ret.getFieldValueString(i,"ECAD_KEY");
		if(!"SYSNO".equals(defKey))
		{
			if(!myColVector.contains(defKey))
			{
				myColVector.add(defKey);
				myColVector.add(defKey+"_DESC");
			}
		}
		java.util.Hashtable myHT = (java.util.Hashtable)myHashTable.get(sysKey);
		if(myHT==null)
		{
			myHT = new java.util.Hashtable();
			myHashTable.put(sysKey,myHT);
			mySyskeyTable.put(sysKey,ret.getFieldValueString(i,"ESKD_SYS_KEY_DESC"));
		}
		java.util.Vector tempVect = new java.util.Vector();
		if(!"SYSNO".equals(defKey))
		{
			tempVect.add(ret.getFieldValueString(i,"ECAD_VALUE"));
			tempVect.add(ret.getFieldValueString(i,"EUDD_DEFAULTS_DESC"));
			myHT.put(defKey,tempVect);
		}
	}
	ReturnObjFromRetrieve defRet=new ReturnObjFromRetrieve();
	int myColVectSize = myColVector.size();
	for(int i=0;i<myColVectSize;i++)
	{
		defRet.addColumn((String)myColVector.elementAt(i));
	}
	java.util.Enumeration mySysEnum = myHashTable.keys();
	while(mySysEnum.hasMoreElements())
	{
		String mySysKey = (String)mySysEnum.nextElement();
		String mySysKeyDesc = (String)mySyskeyTable.get(mySysKey);
		java.util.Hashtable myHashValue = (java.util.Hashtable)myHashTable.get(mySysKey);
		java.util.Enumeration myHashValueEnum = myHashValue.keys();
		defRet.setFieldValue("SYSKEY",mySysKey);
		defRet.setFieldValue("SYSKEYDESC",mySysKeyDesc);
		while(myHashValueEnum.hasMoreElements())
		{
			String myDefKey = (String)myHashValueEnum.nextElement();
			java.util.Vector myDefVec = (java.util.Vector)myHashValue.get(myDefKey);
			String myDefValue = (String)myDefVec.elementAt(0);
			String myDefDesc = (String)myDefVec.elementAt(1);
			defRet.setFieldValue(myDefKey,myDefValue);
			defRet.setFieldValue(myDefKey+"_DESC",myDefDesc);
		}
		defRet.addRow();
	}
%>
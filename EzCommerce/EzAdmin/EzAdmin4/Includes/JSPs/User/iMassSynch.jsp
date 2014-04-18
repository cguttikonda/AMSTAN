<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@ include file="../../Lib/AdminUtilsBean.jsp"%>
<%
	String areaFlag = request.getParameter("Area");
	String bussArea = "Sales Area";
	if(areaFlag.equals("V"))
		bussArea = "Purchase Area";

	String sysKey=request.getParameter("syskey");
	String massKey=request.getParameter("masskey");
	ReturnObjFromRetrieve massSynchAreas = null;
	ReturnObjFromRetrieve massSynchKeys = null;
	ReturnObjFromRetrieve massSynchDetails = null;

	EziAdminUtilsParams adminUtilsParams = new EziAdminUtilsParams();
	adminUtilsParams.setAreaType(areaFlag);
	if(sysKey!=null && massKey!=null)
	{
		adminUtilsParams.setSyskeys(sysKey);
		adminUtilsParams.setDefaultKey(massKey);
	}

	EzcParams mainParams = new EzcParams(false);
	mainParams.setObject(adminUtilsParams);
	Session.prepareParams(mainParams);

	EzoAdminUtilsParams myOutParams = (EzoAdminUtilsParams)AUM.viewMassSynch(mainParams);

	massSynchAreas = myOutParams.getMassSynchAreas();
	massSynchKeys = myOutParams.getMassSynchKeys();
	massSynchDetails = myOutParams.getMassSynchDetails();
%>


<%
		/*if(sysKey.equals("All"))
		{
			int myRetCount=v1.size();
			allWebSysKeys="";
			if(myRetCount==0)
				allWebSysKeys="NONE";
			else
				allWebSysKeys=(String)v1.elementAt(0);
			for(int k=1;k<myRetCount;k++)
			{
				allWebSysKeys += "','"+(String)v1.elementAt(k);
			}
		}
		else
		{
			allWebSysKeys = sysKey;
		}

		if(massKey.equals("All"))
		{
			int count=v2.size();
			if(count==0)
				allMassKeys="NONE";
			else
				allMassKeys=(String)v2.elementAt(0);
			for(int k=1;k<count;k++)
			{
				allMassKeys+= "','"+(String)v2.elementAt(k);
			}
		}
		else
		{
			allMassKeys = massKey;
		}*/
%>

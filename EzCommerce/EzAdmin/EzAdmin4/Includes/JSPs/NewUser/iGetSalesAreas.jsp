<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="AdminUtilsManager" class="ezc.ezadmin.ezadminutils.client.EzAdminUtilsManager" scope="session" />
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session" />
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"></jsp:useBean>
<%@ page import = "ezc.ezparam.*,ezc.ezadmin.ezadminutils.params.*" %>
<%
	String soldTo   	= request.getParameter("soldTo");
	String Division 	= request.getParameter("division");
	String disChannel 	= request.getParameter("dchannel");
	String salesOrg 	= request.getParameter("salesorg");


	if(soldTo!=null && !"null".equals(soldTo))
		soldTo = soldTo.toUpperCase();

	/*if(Division!=null && !"null".equals(Division))
		Division = Division.toUpperCase();

	if(disChannel!=null && !"null".equals(disChannel))
		disChannel = disChannel.toUpperCase();

	if(salesOrg!=null && !"null".equals(salesOrg))
		salesOrg = salesOrg.toUpperCase();*/

	boolean syncSucess 	= false;
	int retUserCustCount 	= 0;
	ReturnObjFromRetrieve retUserCust = null;
	EziAdminUtilsParams adminUtilsParams = new EziAdminUtilsParams();
	adminUtilsParams.setAreaType("AC");
	EzcParams mainParams = new EzcParams(false);
	mainParams.setObject(adminUtilsParams);
	Session.prepareParams(mainParams);
	ReturnObjFromRetrieve ret = (ReturnObjFromRetrieve)AdminUtilsManager.getUsersAreasWithDefaults(mainParams);
	int rowCount = ret.getRowCount();

	String [] myRetCols = {"SYSKEY","DISTRIBUTION","DIVISION","SALESORG","SYSKEY_DESC"};
	ReturnObjFromRetrieve retSalArea = new ReturnObjFromRetrieve(myRetCols);
	java.util.Vector sysVector =new java.util.Vector();
	int rowId = 0;
	String syskey="",value = "";

	for (int i=0;i<rowCount;i++)
	{
		syskey = ret.getFieldValueString(i,"ESKD_SYS_KEY");
		value  = ret.getFieldValueString(i,"ECAD_VALUE");

		try{
			if(sysVector.contains(syskey))
			{
				rowId= retSalArea.getRowId("SYSKEY",syskey);
				if("DISTRIBUTION".equals(ret.getFieldValueString(i,"ECAD_KEY")))
					retSalArea.setFieldValueAt("DISTRIBUTION",value,rowId);
				else if("DIVISION".equals(ret.getFieldValueString(i,"ECAD_KEY")))
					retSalArea.setFieldValueAt("DIVISION",value,rowId);
				else if("SALESORG".equals(ret.getFieldValueString(i,"ECAD_KEY")))
					retSalArea.setFieldValueAt("SALESORG",value,rowId);


			}
			else
			{
				sysVector.addElement(syskey);
				retSalArea.setFieldValue("SYSKEY",syskey);
				retSalArea.setFieldValue("SYSKEY_DESC",ret.getFieldValueString(i,"ESKD_SYS_KEY_DESC"));
				if("DISTRIBUTION".equals(ret.getFieldValueString(i,"ECAD_KEY")))
					retSalArea.setFieldValue("DISTRIBUTION",value);
				else if("DIVISION".equals(ret.getFieldValueString(i,"ECAD_KEY")))
					retSalArea.setFieldValue("DIVISION",value);
				else if("SALESORG".equals(ret.getFieldValueString(i,"ECAD_KEY")))
					retSalArea.setFieldValue("SALESORG",value);
				retSalArea.addRow();
			}
		}catch(Exception e){}
	}

	int retRowCount = retSalArea.getRowCount();
	String salesArea ="",mySyskeys = "";
	for (int i=0;i<retRowCount;i++)
	{
		if(Division.equals(retSalArea.getFieldValueString(i,"DIVISION")) && disChannel.equals(retSalArea.getFieldValueString(i,"DISTRIBUTION")) && salesOrg.equals(retSalArea.getFieldValueString(i,"SALESORG")))
			salesArea = retSalArea.getFieldValueString(i,"SYSKEY");
		if(i==0)
			mySyskeys = retSalArea.getFieldValueString(0,"SYSKEY");
		else if(i>0)
			mySyskeys += ","+retSalArea.getFieldValueString(i,"SYSKEY");
	}
	//System.out.println("salesAreasalesAreasalesAreasalesAreasalesArea"+salesArea);
	//retSalArea.toEzcString();
/******* To Get User Existence *******/

	if(!(salesArea==null || "null".equals(salesArea) || "".equals(salesArea)))
	{
		ReturnObjFromRetrieve partnersRet = null;
		if(soldTo!=null)
		{
			soldTo = soldTo.trim();
			String mySoldTo = "";
			try{
				mySoldTo = "0000000000"+soldTo;
				mySoldTo = mySoldTo.substring((mySoldTo.length()-10),mySoldTo.length());
			}
			catch(Exception e)
			{
				mySoldTo = soldTo;
			}



			adminUtilsParams = new EziAdminUtilsParams();
			adminUtilsParams.setSyskeys(mySyskeys);
			adminUtilsParams.setPartnerValueBy(mySoldTo);
			mainParams = new EzcParams(false);
			mainParams.setObject(adminUtilsParams);
			Session.prepareParams(mainParams);
			partnersRet = (ReturnObjFromRetrieve)AdminUtilsManager.getUsersByPartnerValueAndArea(mainParams);




			EzcUserParams ezcuserparams= new EzcUserParams();
			EzcUserNKParams ezcusernkparams = new EzcUserNKParams();
			String[] partFunctions = {"AG","VN"};
			ezcusernkparams.setPartnerFunctions(partFunctions);
			ezcusernkparams.setLanguage("EN");
			ezcuserparams.setUserId(partnersRet.getFieldValueString(0,"EU_ID"));
			ezcuserparams.createContainer();
			ezcuserparams.setObject(ezcusernkparams);
			Session.prepareParams(ezcuserparams);
			retUserCust = (ReturnObjFromRetrieve)UserManager.getUserCustomers(ezcuserparams);
			//retUserCust.toEzcString();
		}




		retUserCustCount = retUserCust.getRowCount();
		for(int k=0;k<retUserCustCount;k++)
		{

			if(salesArea.equals(retUserCust.getFieldValueString(k,"EUD_SYS_KEY")))
			{
				syncSucess = true;
				break;
			}
		}
	}
%>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"></jsp:useBean>
<%
	ezc.ezparam.EzcUserParams uparams= new ezc.ezparam.EzcUserParams();
	EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
	ezcUserNKParams.setLanguage("EN");
	ezcUserNKParams.setSys_Key("0");
	uparams.createContainer();
	uparams.setUserId(Session.getUserId());
	uparams.setObject(ezcUserNKParams);
	Session.prepareParams(uparams);
	ReturnObjFromRetrieve retobj = (ReturnObjFromRetrieve)(UserManager.getAddUserDefaults(uparams));
	String UserCurrency=null;
	for(int z=0;z<retobj.getRowCount();z++)
	{
		if("CURRENCY".equals(retobj.getFieldValueString(z,"EUD_KEY").trim()))
		{
			UserCurrency=retobj.getFieldValueString(z,"EUD_VALUE");
			break;
		}
	}
%>
<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/AdminUser.jsp"%>
<jsp:useBean id="BPManager" class="ezc.client.EzBussPartnerManager" scope="session"></jsp:useBean>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"></jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>

<%!
private boolean checkDuplicate(String ID, ezc.session.EzSession ezsess) throws Exception
{
	String UserId = ID;
	if(UserId != null)
	{     
		UserId = UserId.toUpperCase();
		UserId = UserId.trim();
	}
	/***** Added by Venkat on 4/4/2001 *******/
	ReturnObjFromRetrieve retU = null;

      	ezc.client.EzUserAdminManager UserManager = new ezc.client.EzUserAdminManager();
	EzcUserParams uparams= new EzcUserParams();
	EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
	ezcUserNKParams.setLanguage("EN");
      	uparams.setUserId(UserId);
	uparams.setObject(ezcUserNKParams);
     	ezsess.prepareParams(uparams);

	//Get All Users
	retU =	(ReturnObjFromRetrieve)UserManager.getUserData(uparams);
	retU.check();
	int retURows = retU.getRowCount();
       	if (   retURows > 0 )
        {
             	return false;
        }
        else
        {
            	return true;
        }
} //End function
/***** Venkats Changes end here **********/
%>

<%
	String areaFlag=request.getParameter("Area");

	String userid = request.getParameter("UserID");
	boolean Uflag = true;
	if ( userid != null )
	{
	      Uflag = checkDuplicate(userid, Session);
	}

	EzcUserParams auparams= new EzcUserParams();
	Session.prepareParams(auparams);
	EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
	ezcUserNKParams.setLanguage("EN");
	auparams.createContainer();
	auparams.setObject(ezcUserNKParams);

	ReturnObjFromRetrieve allUsersRet =	(ReturnObjFromRetrieve)UserManager.getAllBussUsers(auparams);


	ReturnObjFromRetrieve ret = null;
	EzcBussPartnerParams bparams = new EzcBussPartnerParams();
	EzcBussPartnerNKParams bNKParams = new EzcBussPartnerNKParams();
	bNKParams.setLanguage("EN");
	bparams.createContainer();
	bparams.setObject(bNKParams);
	Session.prepareParams(bparams);

	ret =(ReturnObjFromRetrieve) BPManager.getBussPartners(bparams);

	int bpRows = ret.getRowCount();
	if("V".equals(areaFlag))
	{
		for(int i=bpRows-1;i>=0;i--)
		{
			if(!("0".equals(ret.getFieldValueString(i,"EBPC_CATALOG_NO"))))
				ret.deleteRow(i);
		}
	}
	else
	{
		for(int i=bpRows-1;i>=0;i--)
		{
			if("0".equals(ret.getFieldValueString(i,"EBPC_CATALOG_NO")))
				ret.deleteRow(i);
		}
	}
	bpRows=ret.getRowCount();


%>

<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<jsp:useBean id="AUM" class="ezc.ezadmin.ezadminutils.client.EzAdminUtilsManager" scope="session" />
<%@ page import = "ezc.ezparam.*,ezc.ezadmin.ezadminutils.params.*" %>
<%@ include file="../../../Includes/Lib/ezCatalogBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalog.jsp"%>


<%

	String soldTo = request.getParameter("soldTo");
	if(soldTo!=null)soldTo=soldTo.trim();
	String type = request.getParameter("type");
	String favGrp = request.getParameter("favGrp");
	String sysKey = (String)session.getValue("SalesAreaCode");
	String retStr="$$NODATA$$";
	
	EziAdminUtilsParams adminUtilsParams = new EziAdminUtilsParams();
	adminUtilsParams.setSyskeys(sysKey);
	adminUtilsParams.setPartnerValueBy(soldTo);

	EzcParams mainParams = new EzcParams(false);
	mainParams.setObject(adminUtilsParams);
	Session.prepareParams(mainParams);

	ReturnObjFromRetrieve partnersRet = (ReturnObjFromRetrieve)AUM.getUsersByPartnerValueAndArea(mainParams);
	
	if(partnersRet!=null && partnersRet.getRowCount()>0)
	{
		String userId = partnersRet.getFieldValueString(0,"EU_ID");
		if(userId!=null)userId=userId.trim();

		ReturnObjFromRetrieve retprodfav = null;

		EzcPersonalizationParams ezget = new EzcPersonalizationParams();
		EziPersonalizationParams izget = new EziPersonalizationParams();
		izget.setLanguage("EN");
		izget.setUserId(userId);
		ezget.setObject(izget);
		Session.prepareParams(ezget);
		retprodfav = (ReturnObjFromRetrieve) EzcPersonalizationManager.getProdFavDesc(ezget);
		int retprodfavCount=retprodfav.getRowCount();
		//ezc.ezcommon.EzLog4j.log("retprodfav>>>>>>>>>>>"+retprodfav.toEzcString(),"I");
		
		if("LIST".equals(type))
		{
			if(retprodfavCount>0)
			{
				/*
				 --------------- Row 0 --------------------- 
				 0 ::  Field Name : EPG_NO ----> Field Value : ~11001290 
				 0 ::  Field Name : EPGD_LANG ----> Field Value : EN 
				 0 ::  Field Name : EPGD_DESC ----> Field Value : Test 
				 0 ::  Field Name : EPGD_WEB_DESC ----> Field Value : Test Catalog
				--------------- End Of Row 0 -------------- 
				*/
				for(int i=0;i<retprodfavCount;i++)
				{
					if(i==0)
						retStr = retprodfav.getFieldValueString(i,"EPG_NO")+"§"+retprodfav.getFieldValueString(i,"EPGD_DESC")+"§"+retprodfav.getFieldValueString(i,"EPGD_WEB_DESC");
					else
						retStr += "¥" + retprodfav.getFieldValueString(i,"EPG_NO")+"§"+retprodfav.getFieldValueString(i,"EPGD_DESC")+"§"+retprodfav.getFieldValueString(i,"EPGD_WEB_DESC");

				}
			}
		}
		else if("CHECK".equals(type))
		{
			if(retprodfavCount>0)
			{
				if(retprodfav.find("EPGD_DESC",favGrp))
					retStr = "$$FOUND$$";
			}
		}
	}
	out.print(retStr);
	

%>
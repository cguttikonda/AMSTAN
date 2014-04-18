<%@ include file="../../Lib/AdminUtilsBean.jsp"%>
<%
	ReturnObjFromRetrieve partnersRet = null;
	String sysKey = request.getParameter("sysKey");
	String partnerFunction = request.getParameter("partnerFunction");
	String partnerValue = request.getParameter("partnerValue");
	String subPartnerValue = "";
	if(sysKey!=null && partnerFunction!=null && partnerValue!=null)
	{
		partnerValue = partnerValue.trim();
		try{
			partnerValue = Long.parseLong(partnerValue)+"";
			subPartnerValue="0000000000"+partnerValue;
			subPartnerValue=subPartnerValue.substring((subPartnerValue.length()-10),subPartnerValue.length());
		}
		catch(Exception e)
		{
			subPartnerValue = partnerValue;
		}

		
	
		EziAdminUtilsParams adminUtilsParams = new EziAdminUtilsParams();
		adminUtilsParams.setSyskeys(sysKey);
		adminUtilsParams.setPartnerFunction(partnerFunction);
		adminUtilsParams.setPartnerValue(subPartnerValue);

		EzcParams mainParams = new EzcParams(false);
		mainParams.setObject(adminUtilsParams);
		Session.prepareParams(mainParams);

		partnersRet = (ReturnObjFromRetrieve)AUM.getPartnerPartners(mainParams);
	}
%>

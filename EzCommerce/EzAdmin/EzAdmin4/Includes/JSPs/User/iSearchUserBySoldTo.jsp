<%@ include file="../../Lib/AdminUtilsBean.jsp"%>
<%
	ReturnObjFromRetrieve partnersRet = null;
	String sysKey = request.getParameter("sysKey");
	String soldTo = request.getParameter("soldTo");
	if(sysKey!=null && soldTo!=null)
	{
		soldTo = soldTo.trim();
	
		String mySoldTo = "";
		try{
			soldTo = Long.parseLong(soldTo)+"";
		mySoldTo = "0000000000"+soldTo;
		mySoldTo = mySoldTo.substring((mySoldTo.length()-10),mySoldTo.length());
		}catch(Exception ex){mySoldTo = soldTo;}
	
		EziAdminUtilsParams adminUtilsParams = new EziAdminUtilsParams();
		adminUtilsParams.setSyskeys(sysKey);
		adminUtilsParams.setPartnerValueBy(mySoldTo);

		EzcParams mainParams = new EzcParams(false);
		mainParams.setObject(adminUtilsParams);
		Session.prepareParams(mainParams);

		partnersRet = (ReturnObjFromRetrieve)AUM.getUsersByPartnerValueAndArea(mainParams);
	}
%>

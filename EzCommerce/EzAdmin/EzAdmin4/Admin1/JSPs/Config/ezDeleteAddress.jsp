<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="EzUploadManager" class="ezc.ezupload.client.EzUploadManager" scope="session" />

<%
	String [] addressNo = null;
	addressNo = request.getParameterValues("chk1");
	String addNum="";
	for(int i=0;i<addressNo.length;i++)
	{
		addNum=addressNo[i]+","+addNum;	
	}
	addNum=addNum.substring(0,addNum.length()-1);
	//out.println(addNum);
	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezupload.params.EziAddressParams params = new ezc.ezupload.params.EziAddressParams();
      	params.setNo(addNum);
        mainParams.setObject(params);
	Session.prepareParams(mainParams);
	EzUploadManager.deleteAddress(mainParams); 
	response.sendRedirect("ezListAddress.jsp");
%>

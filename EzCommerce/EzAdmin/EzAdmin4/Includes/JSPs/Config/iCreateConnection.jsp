<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<%@ page import = "ezc.ezparam.ReturnObjFromRetrieve" %>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>


<%
	String params = request.getParameter("params");
	params=params.trim();	
	String connexist = params.substring(0,1);	
	String grpId = params.substring(1,params.length());
	connexist=connexist.trim();
	grpId=grpId.trim();
	String myConnGroup=(String)session.getValue("ConnGroup");
	myConnGroup=myConnGroup+"~"+grpId;
	

	EzcSysConfigParams sparams = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
	snkparams.setLanguage("EN");
	snkparams.setGroupId(grpId);
	sparams.setObject(snkparams);
	Session.prepareParams(sparams);
	ReturnObjFromRetrieve ret = null;
	if(connexist.equals("2")) {
		// Create Connection Pool
		if("555".equals(grpId)){
			ret = (ReturnObjFromRetrieve)sysManager.addToConnectionPool(sparams);
			if ( ret.isError() ) {

				String[] errMsgs = ret.getErrorMessages();
			}
	    	}
	}else{
		// Remove Connection Pool
		if("555".equals(grpId)){
			ret = (ReturnObjFromRetrieve)sysManager.delFromConnectionPool(sparams);
			if ( ret.isError() ){

				String[] errMsgs = ret.getErrorMessages();
			}
	    	}
	    	
	    	
		
		try{
			ezc.sapconnection.EzSAPHandler.removeSAPConnectionPool(myConnGroup);
			//ezc.sapconnection.EzSAPHandler.removeSAPConnectionPool();
		}catch(Exception err){System.out.println("======>"+err);}	
	    	
	    	//ezc.sapconnection.EzSAPHandler.removeConnectionPool();
	}
	

response.sendRedirect("ezListConnections.jsp");
%>
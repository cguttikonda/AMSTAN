<%@ include file="iBlockControl.jsp"%>  
<%@ page import = "ezcom.ezcsm.EzUser" %>
<%@ page import = "ezcom.ezcommon.EzUserDBLight" %>
<%@ include file="../../../Includes/Lib/SalesBean.jsp"%>

<%



String mypwd = request.getParameter("oldpasswd");
if ((!(mypwd == null))) {
	boolean ret = SBObject.validateUserPassword(servlet, mypwd);
	if (ret) {
		String newpwd = request.getParameter("password1");
		SBObject.changeUserPassword(servlet, newpwd);
  	}//End if	
}//End if






%>


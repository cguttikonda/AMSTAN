<%@ include file="../../../Includes/Lib/SalesBean.jsp"%>

<%
String error = "";
String mypwd = null;

mypwd = request.getParameter("oldpasswd");

	if ((!(mypwd == null)) || (error.equals("O"))) {
		boolean ret = SBObject.validateUserPassword(servlet, mypwd);
		if (ret) {
			error = "";
		}else{
			error = "E";
			mypwd = "";
		}	
	}else{
		mypwd="";
		error = "W";
	}//end if
%>
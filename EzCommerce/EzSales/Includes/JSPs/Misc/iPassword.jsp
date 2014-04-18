<%@ include file="iBlockControl.jsp"%>   
<%@ include file="../../../Includes/Lib/SalesBean.jsp"%>

<%
String error = "W";
String mypwd = null;

mypwd = request.getParameter("oldpasswd");

/*
boolean ret = SBObject.validateUserPassword(servlet, mypwd);
if(error != "W"){
	if (ret) {
		error = "S";
	}else{
		error = "E";
		mypwd = "";
	}	
}//end if
*/

	if ((!(mypwd == null)) || (error.equals("O"))) {
		boolean ret = SBObject.validateUserPassword(servlet, mypwd);
		if (ret) {
			error = "S";
		}else{
			error = "E";
			mypwd = "";
		}	
	}else{
		mypwd="";
		error = "W";
	}//end if
%>
<%@ include file="iReleaseControl.jsp"%>
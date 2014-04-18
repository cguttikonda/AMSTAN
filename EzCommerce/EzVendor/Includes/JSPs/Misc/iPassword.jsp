<jsp:useBean id="PasswordManager" class="ezc.ezadmin.ezadminutils.client.EzAdminUtilsManager" scope="session"></jsp:useBean>
<%@ page import ="ezc.ezparam.*"%>
<%@ include file="../../../Includes/Lib/ezPurchaseBean.jsp"%>
<%@ page import="ezc.ezadmin.user.csb.*" %>

<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope = "page">
</jsp:useBean>
<%@ include file="../Misc/iblockcontrol.jsp" %>


<%
String error = "W";
String mypwd = null;

mypwd = request.getParameter("oldpasswd");



EzcUserNKParams usernkparams = new EzcUserNKParams();
EzcUserParams newParams = new EzcUserParams();
newParams.createContainer();
newParams.setObject(usernkparams);
Session.prepareParams(newParams);
usernkparams.setPassword(mypwd);

ezc.ezparam.EzcParams pwdMgmtParams = new ezc.ezparam.EzcParams(false);
ezc.ezadmin.ezadminutils.params.EziAdminUtilsParams admPwdMgmtUtilParams = new  ezc.ezadmin.ezadminutils.params.EziAdminUtilsParams();
admPwdMgmtUtilParams.setUserId("'"+Session.getUserId()+"'");
pwdMgmtParams.setObject(admPwdMgmtUtilParams);
Session.prepareParams(pwdMgmtParams);
ReturnObjFromRetrieve pwdMgmtRet=(ReturnObjFromRetrieve)PasswordManager.getPasswordPolicy(pwdMgmtParams);
String oldPwd=null;
if(pwdMgmtRet!=null){
	
	
	ezc.ezcommon.EzCipher myCipher = new ezc.ezcommon.EzCipher();
	
	if(pwdMgmtRet!=null && pwdMgmtRet.getRowCount()>0){
		  
		  oldPwd=pwdMgmtRet.getFieldValueString(0,"EPM_PWD_OLD");
		  java.util.StringTokenizer st=new java.util.StringTokenizer(oldPwd,"¥");
		  int tokenCount=0;
		  if(st!=null)
		  	tokenCount=st.countTokens();
		  int count=0;	
		  String tempPswd=null;
		  while(st.hasMoreTokens()){
		  	count++;
		  	String ss=((String)st.nextToken()).trim();
		  	if(tokenCount>5){
		  		if(count<=(tokenCount-5))
		  			continue;
		  	}
		  	
		  	
		  	if(tempPswd==null){
		  		tempPswd=ss; //myCipher.ezDecrypt(ss);
		  		
		  	}else{
		  		
		  		tempPswd +="¥"+ss;//myCipher.ezDecrypt(ss);
		  		
		  	}
		  	
		  }
		  oldPwd = tempPswd;
		  	
	}
	
	
}






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
		//boolean ret = SIMObject.validateUserPassword(servlet, mypwd);
		  boolean ret = UserManager.validateUserPassword(newParams);

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
<%@ include file="../Misc/ireleasecontrol.jsp" %>
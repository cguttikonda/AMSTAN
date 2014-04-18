<%@ include file="../../../Includes/Lib/EzWorkFlowBean.jsp"%>
<%
	ezc.ezparam.EzcParams deleteMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziActionStatParams deleteParams= new ezc.ezworkflow.params.EziActionStatParams();

	String[] chkValue=request.getParameterValues("chk1");
	
	java.util.StringTokenizer st=null;
	
	String act="";
	String auth="";
	for(int i=0;i<chkValue.length;i++)
	{
	    st=new java.util.StringTokenizer(chkValue[i],",");
  	    act+="'"+st.nextToken()+"',";	
  	    auth+="'"+st.nextToken()+"',";		
  	
  	}
  	act=act.substring(0,act.length()-1);
  	auth=auth.substring(0,auth.length()-1);
  	deleteParams.setAction(act);
	deleteParams.setAuthKey(auth);
	
	deleteMainParams.setObject(deleteParams);
	Session.prepareParams(deleteMainParams);
	EzWorkFlowManager.deleteActionStats(deleteMainParams);
 
	response.sendRedirect("ezActionStatList.jsp");
%>

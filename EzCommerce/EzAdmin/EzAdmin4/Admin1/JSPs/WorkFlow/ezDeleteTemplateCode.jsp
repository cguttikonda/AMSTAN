<%@ include file="../../../Includes/Lib/EzWorkFlowBean.jsp"%>
<%
	ezc.ezparam.EzcParams deleteMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziTemplateCodeTable tabParams= new ezc.ezworkflow.params.EziTemplateCodeTable();
	String[] chkValue=request.getParameterValues("chk1");
	 
 	ezc.ezworkflow.params.EziTemplateCodeTableRow tabRow=null; 
 	for(int i=0;i<chkValue.length;i++)
 	{
 		java.util.StringTokenizer setVal=new java.util.StringTokenizer(chkValue[i],",");
 		
 		tabRow=new ezc.ezworkflow.params.EziTemplateCodeTableRow();
 		tabRow.setCode(setVal.nextToken());
		setVal.nextToken();
		tabRow.setLang("'"+setVal.nextToken()+"'");
		tabParams.appendRow(tabRow);
	}	
		deleteMainParams.setObject(tabParams);
		Session.prepareParams(deleteMainParams);
		EzWorkFlowManager.deleteTemplates(deleteMainParams);
 
	response.sendRedirect("ezTemplateCodeList.jsp");
%>

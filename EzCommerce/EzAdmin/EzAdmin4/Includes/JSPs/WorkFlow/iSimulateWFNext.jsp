<%@ include file="../../../Includes/Lib/EzWorkFlowBean.jsp"%>
<%
	java.util.Hashtable myTable= new java.util.Hashtable();
	int attCount=Integer.parseInt(request.getParameter("attCount"));
	String template=request.getParameter("template");
	String attObj=null,attribute=null,type=null,attVal=null;
	java.util.StringTokenizer stk=null;
	for(int i=0;i<attCount;i++)
	{
		attObj=request.getParameter("attribute"+i);
		if(! attObj.equals("SELECT"))
		{
			stk=new java.util.StringTokenizer(attObj,",");
			attribute=stk.nextToken();
			type=stk.nextToken();
			attVal=request.getParameter("attributeVal"+i);
		
			if(type.equals("Date"))
			{
				attVal = "Between " +attVal+" and "+(request.getParameter("attributeVal"+i+""+i));
			}
			myTable.put(attribute,attVal);
		}
	}


	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziWFDocHistoryParams params= new ezc.ezworkflow.params.EziWFDocHistoryParams();
	ezc.ezworkflow.params.EziWFParams wfParams= new ezc.ezworkflow.params.EziWFParams();
	
	wfParams.setConditionAttributes(myTable);
	params.setTemplateCode(template);
	mainParams.setObject(params);
	mainParams.setObject(wfParams);
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve ret = (ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.ezSimulateWF(mainParams);
	

	
%>	

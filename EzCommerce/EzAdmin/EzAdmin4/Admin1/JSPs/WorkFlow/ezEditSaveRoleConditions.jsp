<%@ include file="../../../Includes/Lib/EzWorkFlowBean.jsp"%>
<%
	String roleId=request.getParameter("role");
	String ruleId=request.getParameter("rule");
	String delegateIndex = "";
	
	java.util.Hashtable hTable=new java.util.Hashtable();
	hTable.put("GT","is greater than");
	hTable.put("LT","is less than");
	hTable.put("EQ","is equals to");
	hTable.put("GE","is greater than or equals to");
	hTable.put("LE","is less than or equals to");
	hTable.put("CN","contains");
	hTable.put("SW","starts with");
	hTable.put("EW","ends with");
	hTable.put("BN","between");
	hTable.put("ON","on");
	hTable.put("BF","before");
	hTable.put("AF","after");
	hTable.put("OB","on or before");
	hTable.put("OA","on or after");

	String desc=request.getParameter("desc");
	String authKey=request.getParameter("authKey");
	String result=request.getParameter("result");
	
	String busDomain 	= request.getParameter("busDomain");
	String docType	 	= request.getParameter("doctype");
	String conditionList 	= request.getParameter("list");
	
	if("B".equals(docType))
		conditionList		= "100001";
	if("D".equals(docType))
		conditionList		= "100002";		
	
	

	String conditionStr="";

	int attribLength=Integer.parseInt(request.getParameter("len"));

	ezc.ezworkflow.params.EziConditionsTable table=new ezc.ezworkflow.params.EziConditionsTable();
	java.util.StringTokenizer stk=null;	
	for(int i=0;i<attribLength;i++)
	{
		String attribBox=request.getParameter("attribute"+i);
		if(!("sel".equals(attribBox)))
		{
			ezc.ezworkflow.params.EziConditionsTableRow tabRow=new ezc.ezworkflow.params.EziConditionsTableRow();
			stk=new java.util.StringTokenizer(attribBox,",");
			String attributeId=stk.nextToken();
			String attribDesc=stk.nextToken();
			String type=stk.nextToken();
			String operator=request.getParameter("fType"+i);
			String txt1=request.getParameter("txt"+i+"0");
			String txt2=request.getParameter("txt"+i+"1");
			String nextOp=request.getParameter("chk"+i);

			tabRow.setAttribute(attributeId);
			tabRow.setConditionOperator(operator);
			tabRow.setCondValue1(txt1);
			tabRow.setCondValue2(txt2);
			tabRow.setConditionType("F");
			tabRow.setTemp1(nextOp);
			tabRow.setRuleId(ruleId);

			table.appendRow(tabRow);

			conditionStr += attribDesc;
			if("String".equals(type))
			{
				if(hTable.get(operator) != null)
				{
					conditionStr += " "+hTable.get(operator)+" ";
					conditionStr += txt1;
				}
				else
				{
					conditionStr += " "+operator+" ";
					conditionStr += txt1;
				}
			}	
			else if("Number".equals(type))
			{
				if(hTable.get(operator) != null)
				{
					conditionStr += " "+hTable.get(operator)+" ";
					if(operator.equals("BN"))
						conditionStr += txt1 + " And "+ txt2;
					else	
						conditionStr += txt1;
				}	
			}
			else if("Date".equals(type))
			{
				if(hTable.get(operator) != null)
				{
					conditionStr += " "+hTable.get(operator)+" ";
					if(operator.equals("BN"))
						conditionStr += txt1 + " And "+ txt2;
					else	
						conditionStr += txt1;
				}
			}
			conditionStr += "  " + nextOp+" ";
		}
	}
	conditionStr=conditionStr.substring(0,conditionStr.length()-4);

	ezc.ezworkflow.params.EziRoleConditionsParams params=new ezc.ezworkflow.params.EziRoleConditionsParams();
	params.setRoleNo(roleId);
	params.setAuthKey(authKey);
	params.setConditionId(ruleId);
	params.setDescription(desc);
	params.setConditionText(conditionStr);
	params.setResult(result);
	
	params.setBusDomain(busDomain);
	params.setDocType(docType);
	params.setDocNo(conditionList);

	ezc.ezparam.EzcParams addMainParams = new ezc.ezparam.EzcParams(false);
	addMainParams.setObject(table);
	addMainParams.setObject(params);
	if("D".equals(docType))
	{
		delegateIndex	= request.getParameter("delIndex");
		ezc.ezworkflow.params.EziDelegateApproverParams delInfoParams=new ezc.ezworkflow.params.EziDelegateApproverParams();
		delInfoParams.setSourceType(request.getParameter("delegatLevel")+delegateIndex);
		delInfoParams.setSourceUser(request.getParameter("srcHiddenDel")+delegateIndex);
		delInfoParams.setDestType(request.getParameter("delegatLevel")+delegateIndex);
		delInfoParams.setDestUser(request.getParameter("dstHiddenDel")+delegateIndex);
		delInfoParams.setConditionId(ruleId+"¥Y");
		addMainParams.setObject(delInfoParams);
		//ezc.ezparam.EzcParams updateDelParams = new ezc.ezparam.EzcParams(false);
		//updateDelParams.setObject(delInfoParams);
		//Session.prepareParams(updateDelParams);
		//EzWorkFlowManager.addDelegateApprovers(delInfoParams);
		
	}		
	
	
	
	Session.prepareParams(addMainParams);
	EzWorkFlowManager.updateCondition(addMainParams);

	EzWorkFlowManager.loadRules(addMainParams);

	
	if("B".equals(docType))
	{
		ezc.ezworkflow.params.EziByPassInfoParams byPassInfoParams=new ezc.ezworkflow.params.EziByPassInfoParams();
		byPassInfoParams.setSourceLevel(request.getParameter("srcLevel"));
		byPassInfoParams.setDestinationLevel(request.getParameter("dstLevel"));
		byPassInfoParams.setDirection(request.getParameter("direction"));
		byPassInfoParams.setByPassId(request.getParameter("byPassCode"));

		ezc.ezparam.EzcParams updateByPassParams = new ezc.ezparam.EzcParams(false);
		updateByPassParams.setObject(byPassInfoParams);
		Session.prepareParams(updateByPassParams);
		EzWorkFlowManager.addByPass(updateByPassParams);
		
	}	
	
	
	

	response.sendRedirect("ezRoleConditionsList.jsp?Role="+roleId);

%>

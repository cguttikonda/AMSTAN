<%@ include file="../../../Includes/Lib/EzWorkFlowBean.jsp"%>
<%
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
	
	String roleId		=request.getParameter("role");
	String desc		=request.getParameter("desc");
	String authKey		=request.getParameter("authKey");
	String result		=request.getParameter("result");
	
	String busDomain	= request.getParameter("busDomain");
	String doctype		= request.getParameter("doctype");
	String list		= request.getParameter("list");
	if("B".equals(doctype))
		list		= "100001";
	if("D".equals(doctype))
		list		= "100002";		
	
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
	params.setDescription(desc);
	params.setConditionText(conditionStr);
	params.setResult(result);
	
	params.setBusDomain(busDomain);
	params.setDocType(doctype);
	params.setDocNo(list);
	
	
	
	ezc.ezworkflow.params.EziDelegateApproverParams delAppParams=new ezc.ezworkflow.params.EziDelegateApproverParams();
	if(!"D".equals(doctype))
		delAppParams.setSourceType("-");
	else
	{
		String delegateLevel 	= request.getParameter("delegatLevel");
		String delegateSource	= request.getParameter("srcHiddenDel");
		String delegateDest 	= request.getParameter("dstHiddenDel");
		
		delAppParams.setSourceType(delegateLevel);
		delAppParams.setSourceUser(delegateSource);
		delAppParams.setDestType(delegateLevel);
		delAppParams.setDestUser(delegateDest);
	}	
	
	ezc.ezworkflow.params.EziByPassInfoParams byPassInfoParams=new ezc.ezworkflow.params.EziByPassInfoParams();
	if(!"B".equals(doctype))
		byPassInfoParams.setTemplate("-");
	else
	{
		byPassInfoParams.setTemplate(request.getParameter("template"));
		byPassInfoParams.setSourceLevel(request.getParameter("srcLevel"));
		byPassInfoParams.setDestinationLevel(request.getParameter("dstLevel"));
		byPassInfoParams.setDirection(request.getParameter("direction"));
	}	
	
	
	
	ezc.ezparam.EzcParams addMainParams = new ezc.ezparam.EzcParams(false);
	addMainParams.setObject(table);
	addMainParams.setObject(params);
	addMainParams.setObject(delAppParams);
	addMainParams.setObject(byPassInfoParams);
	Session.prepareParams(addMainParams);
	EzWorkFlowManager.addCondition(addMainParams);
 
	EzWorkFlowManager.loadRules(addMainParams);
	
	
	
	response.sendRedirect("ezRoleConditionsList.jsp?Role="+roleId);


%>

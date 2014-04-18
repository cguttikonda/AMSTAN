<%@ page import="ezc.ezparam.*,ezc.ezmisc.params.*" %>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%
	String purposeOrder = request.getParameter("purposeOrder");

	EzcParams focParamsMisc = new EzcParams(false);
	EziMiscParams focParams = new EziMiscParams();

	ReturnObjFromRetrieve approverRetObj = null;
	ReturnObjFromRetrieve reasonRetObj = null;

	if(purposeOrder!=null && !"null".equalsIgnoreCase(purposeOrder) && !"".equals(purposeOrder))
	{
		focParams.setIdenKey("MISC_SELECT");

		String query = "SELECT VALUE2,EU_FIRST_NAME,EU_LAST_NAME FROM EZC_VALUE_MAPPING,EZC_USERS WHERE EU_ID=VALUE2 AND MAP_TYPE='PURPTOAPPR' AND VALUE1='"+purposeOrder+"' ORDER BY EU_FIRST_NAME";

		focParams.setQuery(query);

		focParamsMisc.setLocalStore("Y");
		focParamsMisc.setObject(focParams);
		Session.prepareParams(focParamsMisc);

		try
		{
		ezc.ezcommon.EzLog4j.log("ezGetFOCApprover.jsp::::::::::::"+focParams.getQuery(),"I");
			approverRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(focParamsMisc);
		}
		catch(Exception e){ezc.ezcommon.EzLog4j.log("Error in ezGetFOCApprover.jsp::::::::::::","I");}

		query = "SELECT A.VALUE1 VALUE1,A.VALUE2 VALUE2,(SELECT VALUE2 FROM EZC_VALUE_MAPPING B WHERE MAP_TYPE='FDREASON' AND B.VALUE1=A.VALUE2) REASON_NAME FROM EZC_VALUE_MAPPING A WHERE MAP_TYPE='PURPREASON' AND VALUE1='"+purposeOrder+"' ORDER BY VALUE2";
		focParams.setQuery(query);

		try
		{
		ezc.ezcommon.EzLog4j.log("ezGetFOCApprover.jsp1::::::::::::"+focParams.getQuery(),"I");
			reasonRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(focParamsMisc);
		}
		catch(Exception e){ezc.ezcommon.EzLog4j.log("Error in ezGetFOCApprover.jsp1::::::::::::","I");}
	}

	String buffer = "<select id='approver' name='approver' title='Approver' onChange='selApprover()'><option value=''>------Select------</option>";
	if(approverRetObj!=null)
	{
		for(int i=0;i<approverRetObj.getRowCount();i++)
		{
			String apprVal = approverRetObj.getFieldValueString(i,"VALUE2");
			String apprFName = approverRetObj.getFieldValueString(i,"EU_FIRST_NAME");
			String apprLName = approverRetObj.getFieldValueString(i,"EU_LAST_NAME");
			apprVal = apprVal.trim();
			apprVal = apprVal.toUpperCase();

			buffer = buffer+"<option value='"+apprVal+"'>"+apprFName+" "+apprLName+" ("+apprVal+")</option>";
		}
	}
	//buffer = buffer+"</select>";

	buffer = buffer+"</select>ееее<select id='reasonCode' name='reasonCode' title='Reason Code' onChange='selDefCat()'><option value=''>------Select------</option>";
	if(reasonRetObj!=null)
	{
		for(int i=0;i<reasonRetObj.getRowCount();i++)
		{
			String reasonCodeKey = reasonRetObj.getFieldValueString(i,"VALUE2");
			String reasonDescVal = reasonRetObj.getFieldValueString(i,"REASON_NAME");

			buffer = buffer+"<option value='"+reasonCodeKey+"'>"+reasonCodeKey+" - "+reasonDescVal+"</option>";
		}
	}
	buffer = buffer+"</select>";

	response.getWriter().println(buffer);
%>
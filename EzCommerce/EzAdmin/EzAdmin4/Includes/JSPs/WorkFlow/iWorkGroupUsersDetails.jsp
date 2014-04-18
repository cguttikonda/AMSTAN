
<%@ page import="java.util.*,java.text.*" %>
<%@ include file="../../Lib/EzWorkFlowBean.jsp"%>
<%@ page import="java.util.*" %>
<%
	ezc.ezparam.EzcParams detailsMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziWorkGroupUsersParams detailsParams= new ezc.ezworkflow.params.EziWorkGroupUsersParams();
	
	/*
	String[] chkValue=request.getParameterValues("chk1");
	String Str="";
	for(int i=0;i<chkValue.length;i++)
	{
		StringTokenizer setVal=new StringTokenizer(chkValue[i],",");
		Str=Str+"('"+setVal.nextToken()+"','"+setVal.nextToken()+"'),";

	}
	*/
	String chkValue=request.getParameter("chk1");
	StringTokenizer setVal=new StringTokenizer(chkValue,",");
String a=setVal.nextToken();
String b=setVal.nextToken();
	detailsParams.setGroupId(a);
	detailsParams.setUserId(b);
	detailsMainParams.setObject(detailsParams);
	Session.prepareParams(detailsMainParams);
	ezc.ezparam.ReturnObjFromRetrieve detailsRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWorkGroupUserDetails(detailsMainParams);

	String flag="false";
	String effectivefrom="";
	String effectiveto="";
	if(detailsRet.getRowCount()>1)
	{
		String fs=detailsRet.getFieldValueString(0,"EFFECTIVE_FROM");
		String ts=detailsRet.getFieldValueString(0,"EFFECTIVE_TO");
		for(int i=1;i<detailsRet.getRowCount();i++)
		{
			String s1=detailsRet.getFieldValueString(i,"EFFECTIVE_FROM");
			String s2=detailsRet.getFieldValueString(i,"EFFECTIVE_TO");
			if(!fs.equals(s1))
			{
				flag="true";
				break;
			}
			if(!ts.equals(s2))
			{
				flag="true";
				break;
			}
		}
	}
	if(flag.equals("true"))
	{
		Date d=new Date();
		SimpleDateFormat sdf= new SimpleDateFormat("MM/dd/yyyy");
		effectivefrom =sdf.format(d);
		effectiveto=sdf.format(d);
	}
	else
	{
		Date ef=(Date)detailsRet.getFieldValue("EFFECTIVE_FROM");
		SimpleDateFormat sdf1= new SimpleDateFormat("MM/dd/yyyy");
		effectivefrom =sdf1.format(ef);

		Date et=(Date)detailsRet.getFieldValue("EFFECTIVE_TO");
		SimpleDateFormat sdf2= new SimpleDateFormat("MM/dd/yyyy");
		effectiveto =sdf2.format(et);
	}

%>

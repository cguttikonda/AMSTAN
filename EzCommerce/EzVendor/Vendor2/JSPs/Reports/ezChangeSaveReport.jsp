<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ page import="ezc.ezparam.*,java.util.*" %>
<jsp:useBean id="Manager" class="ezc.client.EzReportManager" />
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />

<%

String system = request.getParameter("system");
String reportDomain =request.getParameter("reportDomain");
String reportNo =request.getParameter("reportNo");
String reportName= request.getParameter("reportName");
String reportDesc= request.getParameter("reportDesc");
String reportType= request.getParameter("reportType");
String exeType= request.getParameter("exeType");
String visibility= request.getParameter("visibility");
String status= request.getParameter("status");


String paramName[]= request.getParameterValues("paramName");
String paramDesc[]= request.getParameterValues("paramDesc");
String paramNo[]= request.getParameterValues("paramNo");
String paramIsSel[]= request.getParameterValues("paramIsSel");
String paramIshide[]= request.getParameterValues("paramIshide");
String paramLen[]= request.getParameterValues("paramLen");
String paramType[]= request.getParameterValues("paramType");
String paramDataType[]= request.getParameterValues("paramDataType");
String paramIsmand[]= request.getParameterValues("paramIsmand");
String paramIsDef[]= request.getParameterValues("paramIsDef");
String paramMethod[]= request.getParameterValues("paramMethod");
String paramMulti[]= request.getParameterValues("paramMulti");
String lowValue[]= request.getParameterValues("lowValue");
String highValue[]= request.getParameterValues("highValue");
String paramMod[]= request.getParameterValues("paramMod");
String paramOpt[]= request.getParameterValues("paramOpt");

StringTokenizer st = null;
StringTokenizer st1 = null;
StringTokenizer st2 = null;
StringTokenizer st3 = null;
StringTokenizer st4 = null;

EzReportInfoStructure in = new EzReportInfoStructure();
EzReportSelectTable rptTable = new EzReportSelectTable();
EzReportSelectRow rptSelectRow = null;
EzReportValuesTable rptValTable = new EzReportValuesTable();
EzReportValuesRow rptValRow = null;

in.setReportNo(reportNo);
in.setBusinessDomain(reportDomain);
in.setSystemNo(system);
in.setReportName(reportName);
in.setReportDesc(reportDesc);
in.setLanguage("EN");
in.setReportType(reportType);
in.setExecType(exeType);
in.setVisibilityLevel(visibility);
in.setReportStatus(status);
in.setExt1(" ");
in.setExt2(" ");

String low,high,mode,operator="";

for(int i=0;i<paramName.length;i++)
{
	///paramDesc[i]=paramDesc[i].replace(''','`');
	rptSelectRow = new EzReportSelectRow();

	rptSelectRow.setParamNo(paramNo[i]);
	rptSelectRow.setReportNo(reportNo);
	rptSelectRow.setParameterName(paramName[i]);
	rptSelectRow.setParameterDesc(paramDesc[i]);
	rptSelectRow.setParameterType(paramType[i]);
        rptSelectRow.setDataType(paramDataType[i]);
        rptSelectRow.setLength(paramLen[i]);
	rptSelectRow.setIsMandatory(paramIsmand[i]);
	rptSelectRow.setIsCustomer(paramIsSel[i]);
	rptSelectRow.setIsHidden(paramIshide[i]);
        rptSelectRow.setChkDefaults(paramIsDef[i]);
        rptSelectRow.setMethodName(paramMethod[i]);
	rptSelectRow.setExt1(" ");
        rptSelectRow.setExt2(" ");
        rptTable.appendRow(rptSelectRow);


	int j=0;
	st=new StringTokenizer(paramMulti[i],"¤");
	String valColumns[]=new String[st.countTokens()];
		while(st.hasMoreTokens())
	{

		valColumns[j]=st.nextToken();
		j++;
	}
	try{
		//for(int k=0;k<valColumns.length;k++) //for no of columns in each line
		{
			st1=new StringTokenizer(valColumns[0],"µ");
			st2=new StringTokenizer(valColumns[1],"µ");
			st3=new StringTokenizer(valColumns[2],"µ");
			st4=new StringTokenizer(valColumns[3],"µ");
		}

		int v=1; // this is for value no
		while(st1.hasMoreTokens())
		{
			low=st1.nextToken();
			try{
			high=st2.nextToken();
			}catch(Exception e){high="";}
			try
			{
			mode=st3.nextToken();
			}catch(Exception e){mode="I";}
			try{
			operator=st4.nextToken();
			}catch(Exception e){operator="EQ";}

			high=("N".equals(high))?"":high;

			if(!"N".equals(low))
			{
				rptValRow = new EzReportValuesRow();
				rptValRow.setReportNo(reportNo);
				rptValRow.setParamNo(paramNo[i]);
				rptValRow.setParameterValueLow(low);
				rptValRow.setParameterValueHigh(high);
        			rptValRow.setRetreivalMode(mode);
        			rptValRow.setOperator(operator);
				rptValRow.setExt1(" ");
        			rptValRow.setExt2(" ");
        			rptValTable.appendRow(rptValRow);
			}
		}
	}catch(Exception e){}

	if(lowValue[i].trim().length()!=0 && !"µ".equals(lowValue[i]))
	{
		highValue[i]=("µ".equals(highValue[i]))?"":highValue[i];
		/*if("Y".equals(paramIsDef[i]))
		{
			st1=new StringTokenizer(lowValue[i],",");
			String wast="";
			while(st1.hasMoreTokens())
			{
				wast=st1.nextToken();
				if(wast.trim().length()!=0)
				{
					rptValRow = new EzReportValuesRow();

					rptValRow.setReportNo(reportNo);
					rptValRow.setParamNo(paramNo[i]);
					rptValRow.setParameterValueLow(lowValue[i]);
					rptValRow.setParameterValueHigh(highValue[i]);
					rptValRow.setRetreivalMode("I");
					rptValRow.setOperator("EQ");
					rptValRow.setExt1(" ");
					rptValRow.setExt2(" ");
					rptValTable.appendRow(rptValRow);
				}
			}
		}else
		{*/


			rptValRow = new EzReportValuesRow();

			rptValRow.setReportNo(reportNo);
			rptValRow.setParamNo(paramNo[i]);
			rptValRow.setParameterValueLow(lowValue[i]);
			rptValRow.setParameterValueHigh(highValue[i]);
			paramMod[i]=(paramMod[i]==null || "µ".equals(paramMod[i]))?"I":paramMod[i];
			paramOpt[i]=(paramOpt[i]==null || "µ".equals(paramOpt[i]))?"EQ":paramOpt[i];

			rptValRow.setRetreivalMode(paramMod[i]);
			rptValRow.setOperator(paramOpt[i]);
			rptValRow.setExt1(" ");
			rptValRow.setExt2(" ");
			rptValTable.appendRow(rptValRow);
		//}


	}

}


	EzExecReportParams params=new EzExecReportParams();
        EzReportParams rptParams=new EzReportParams();
        params.setSysNum(system);

        rptParams.setReportInfo(in);
        rptParams.setReportSelectTable(rptTable);
        rptParams.setReportValuesTable(rptValTable);
        params.setReportParams(rptParams);
        Session.prepareParams(params);
	try{
	       	Manager.changeReport(params);
		//out.println("Sucess");
	}catch(Exception e)
	{
		//out.println("failure");
	}

	//response.sendRedirect("ezListReport.jsp?system="+system+"&reportDomain="+reportDomain);
	response.sendRedirect("ezListReports.jsp?system="+system+"&reportDomain="+reportDomain);

%>



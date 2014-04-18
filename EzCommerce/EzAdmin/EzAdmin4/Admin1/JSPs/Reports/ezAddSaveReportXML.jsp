<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ page import="ezc.ezparam.*,java.util.*" %>
<%@ page import="javax.xml.bind.*,java.io.*,ezc.ezadmin.reports.*" %>
<jsp:useBean id="Manager" class="ezc.client.EzReportManager" />
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%
String system = request.getParameter("system");
String reportDomain =request.getParameter("reportDomain");
String reportName= request.getParameter("reportName");
String reportDesc= request.getParameter("reportDesc");
String reportType= request.getParameter("reportType");
String exeType= request.getParameter("exeType");
String visibility= request.getParameter("visibility");
String status= request.getParameter("status");


String paramName[]= request.getParameterValues("paramName");
String paramDesc[]= request.getParameterValues("paramDesc");
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


in.setSystemNo(system);
in.setBusinessDomain(reportDomain);
in.setReportName(reportName);
in.setReportDesc(reportDesc);
in.setLanguage("EN");
in.setReportType(reportType);
in.setExecType(exeType);
in.setVisibilityLevel(visibility);
in.setReportStatus(status);
in.setExt1(" ");
in.setExt2(" ");


EzExecReportParams params=new EzExecReportParams();
EzReportParams rptParams=new EzReportParams();
params.setSysNum(system);

rptParams.setReportInfo(in);
rptParams.setReportSelectTable(rptTable);
rptParams.setReportValuesTable(rptValTable);
params.setReportParams(rptParams);
Session.prepareParams(params);
try{
	///Manager.addReport(params);

}catch(Exception e){}


JAXBContext jc = JAXBContext.newInstance("ezc.ezadmin.reports");
ObjectFactory objFactory = new ObjectFactory();
ReportType rep = objFactory.createReportType();

try{

rep.setRSys(system);
rep.setRDomain(reportDomain);
rep.setRName(reportName);
rep.setRDesc(reportDesc);
rep.setRLang("EN");
rep.setRType(reportType);
rep.setRExetype(exeType);
rep.setRVisible(visibility);
rep.setRStatus(status);
rep.setRExt1(" ");
rep.setRExt2(" ");

String low,high,mode,operator="";
java.util.List RParams = rep.getRParam();
ezc.ezadmin.reports.ReportType.RParamType Rparams =null;
java.util.List RValues = null;
ezc.ezadmin.reports.ReportType.RParamType.RValueType values = null;

Iterator iter = RParams.iterator();
Iterator iter1 = null;
for(int i=0;i<paramName.length;i++)
{

	Rparams =objFactory.createReportTypeRParamType();
	RValues =Rparams.getRValue();

	Rparams.setPNo(String.valueOf((i+1)));
	Rparams.setRPN(paramName[i]);
	Rparams.setRPD(paramDesc[i]);
	Rparams.setRPT(paramType[i]);
        Rparams.setRPDT(paramDataType[i]);
        Rparams.setRPL(paramLen[i]);
	Rparams.setRPM(paramIsmand[i]);
	Rparams.setRPS(paramIsSel[i]);
	Rparams.setRPH(paramIshide[i]);
        Rparams.setRPCD(paramIsDef[i]);
        Rparams.setRPMet(paramMethod[i]);
	Rparams.setRPExt1(" ");
        Rparams.setRPExt2(" ");

	int j=0;
	st=new StringTokenizer(paramMulti[i],"¤");
	String valColumns[]=new String[st.countTokens()];
	while(st.hasMoreTokens())
	{

		valColumns[j]=st.nextToken();
		j++;
	}

	//for(int k=0;k<valColumns.length;k++) //for no of columns in each line
	{

		st1=new StringTokenizer(valColumns[0],"µ");
		st2=new StringTokenizer(valColumns[1],"µ");
		st3=new StringTokenizer(valColumns[2],"µ");
		st4=new StringTokenizer(valColumns[3],"µ");
	}
	if(lowValue[i].trim().length()!=0 && !"µ".equals(lowValue[i]))
	{
		highValue[i]=("µ".equals(highValue[i]))?"":highValue[i];
		paramMod[i]=(paramMod[i]==null || "µ".equals(paramMod[i]))?"I":paramMod[i];
		paramOpt[i]=(paramOpt[i]==null || "µ".equals(paramOpt[i]))?"EQ":paramOpt[i];


		values=  objFactory.createReportTypeRParamTypeRValueType();

		values.setVNo(String.valueOf((i+1)));
       		values.setRVL(lowValue[i]);
		values.setRVH(highValue[i]);
		values.setRVMOD(paramMod[i]);
		values.setRVOPT(paramOpt[i]);
		values.setRVExt1(" ");
      	 	values.setRVExt2(" ");

		RValues.add(values);
	}
	while(st1.hasMoreTokens())
	{
		low=st1.nextToken();
		high=st2.nextToken();
		mode=st3.nextToken();
		operator=st4.nextToken();
		high=("N".equals(high))?"":high;

		if(!"N".equals(low))
		{
			values=  objFactory.createReportTypeRParamTypeRValueType();

			values.setVNo(String.valueOf((i+1)));
        		values.setRVL(low);
			values.setRVH(high);
        		values.setRVMOD(mode);
        		values.setRVOPT(operator);
			values.setRVExt1(" ");
        		values.setRVExt2(" ");

			RValues.add(values);
		}
	}
	RParams.add(Rparams);
}

}catch(Exception e){out.println(e);}
//rep.setRParam(RValues);
Marshaller m = jc.createMarshaller();
FileOutputStream fos= new  FileOutputStream(new File("Xmls/suresh.xml"));
m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT,Boolean.TRUE);
m.marshal(rep,fos);
fos.close();
//response.sendRedirect("ezListReport.jsp?system="+system+"&reportDomain="+reportDomain);
%>

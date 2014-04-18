<%@include file="../../Library/Globals/errorPagePath.jsp"%>
<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>

<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@page import="ezc.ezadmin.ezadminutils.client.*,ezc.ezadmin.ezadminutils.params.*,ezc.ezparam.*,ezc.ezpreprocurement.client.*,ezc.ezpreprocurement.params.*"%>

<%@ page import = "ezc.ezchart.EzChartGenerator" %>
<%@ page import = "ezc.ezchart.params.*" %>

<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.text.ParseException" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.Date" %>
<%@ page import = "java.util.Iterator" %>
<%@ page import = "java.util.Locale" %>
<%
  	
	
	String graphType = request.getParameter("GraphType");
	if("".equals(graphType)||"null".equals(graphType)|| graphType==null )
		graphType="3DBar";
	
	int retObjCount = 0;
	String  StdXResolution = "980";
	String  StdYResolution = "600";
	
	String xAxisTitle = null;
	String yAxisTitle = null;
	String title = null;
	String  url= null;
	
	String s1[] = {"XKEY","YKEY"};
	ezc.ezparam.ReturnObjFromRetrieve retbuild = new ezc.ezparam.ReturnObjFromRetrieve(s1);
	
	String dataseries[] = {"SERIES","LEGEND_LABELS"};
	ezc.ezparam.ReturnObjFromRetrieve dataSetsRet = new ezc.ezparam.ReturnObjFromRetrieve(dataseries);
	
	EzGraphParams graphParams = new EzGraphParams();
	
	/*
	graphParams.setChartTitle("CHART TITLE");
	graphParams.setDomainAxisLabel("XAXIS-LABEL");
	graphParams.setRangeAxisLabel("YAXIS-LABEL");
	graphParams.setURL("../Purorder/ezListPOs.jsp?OrderType=All");
	
	*/
	
	graphParams.setIsUrls(false);
	graphParams.setIsLegend(true);
	graphParams.setIsToolTips(true);
	graphParams.setPlotOrientation("VERTICAL");
	graphParams.setLabelRotation("2.3");
	graphParams.setBarWidth("0.03");
	graphParams.setBackgroundPaint("White");
	
	
	/*
	graphParams.setIsIntervalMarker(true);
	graphParams.setIsValueMarker(false);
	graphParams.setMarkerLabel("Target Range");
	graphParams.setMarkerRange1("200");
	graphParams.setMarkerRange2("900"); 
	
	*/
			
	EzcParams 		ezcParams 	= null;
	ReturnObjFromRetrieve 	retObj 		= null;		
	EzPreProcurementManager procurementManager = new EzPreProcurementManager();
	EziReportParams 	reportParams = new EziReportParams();
	
	String reportType = request.getParameter("Report");
	String timePeriod = request.getParameter("TimePeriod");	
	reportParams.setCallPattern("REPORT");
	reportParams.setTimePeriod(timePeriod);	
	reportParams.setReportType(reportType);
	
	
	//out.println("---->"+reportType+"<BR>");
	//out.println("---->"+timePeriod+"<BR>");
	String purGrp ="";
	String purOrg ="";
	
	if("PGEH".equals(reportType) || "PGQH".equals(reportType) || "PGFH".equals(reportType))
	{
		purGrp = request.getParameter("PurchaseGrp");							      
		purOrg = request.getParameter("PurchaseOrg");	
		//out.println(purGrp+"<br>");
		//out.println(purOrg+"<br>");	
		
				
		reportParams.setPurchaseGrp(purGrp);	
		reportParams.setPurchaseOrg(purOrg);	
	}		
	if("MPFH".equals(reportType) ||  "VQH".equals(reportType) || "VQWH".equals(reportType) )
	{
		ReturnObjFromRetrieve purAreaDefaults = null;
		EzAdminUtilsManager adminUtilManager = new EzAdminUtilsManager();
		EziAdminUtilsParams adminUtilsParams = new EziAdminUtilsParams();
		adminUtilsParams.setAreaType("AV");		
		ezcParams = new EzcParams(false);
		ezcParams.setLocalStore("Y");
		ezcParams.setObject(adminUtilsParams);
		Session.prepareParams(ezcParams);				
		purAreaDefaults = (ReturnObjFromRetrieve)adminUtilManager.getUsersAreasWithDefaults(ezcParams);		
		int purAreaCount = purAreaDefaults.getRowCount();
		String sysKey = (String)session.getAttribute("SYSKEY");
		

		if(purAreaCount>0)
		{
			String purGroup = null;
			purOrg = null;
			for(int i=0;i<purAreaCount;++i)
			{
				String parea = purAreaDefaults.getFieldValueString(i,"ESKD_SYS_KEY"); 
				if(sysKey.equals(parea))
				{
					String temp = purAreaDefaults.getFieldValueString(i,"ECAD_KEY");
					if(purGroup==null && "PURGROUP".equals(temp))
					{
						purGroup = purAreaDefaults.getFieldValueString(i,"ECAD_VALUE");
						
					}
					else if(purOrg==null && "PURORG".equals(temp))
					{
						purOrg = purAreaDefaults.getFieldValueString(i,"ECAD_VALUE");
					}
				}
				if(purGroup!=null && purOrg!=null)
				break;
			}
			
			reportParams.setPurchaseGrp(purGroup);	
			reportParams.setPurchaseOrg(purOrg);	
		}
	}
	

	ezcParams = new EzcParams(false);
	ezcParams.setLocalStore("Y");
	ezcParams.setObject(reportParams);
	Session.prepareParams(ezcParams);				
	retObj = (ReturnObjFromRetrieve)procurementManager.getReportData(ezcParams);	

	
	if(retObj!=null)
	{
		int offset =0;
		retObjCount = retObj.getRowCount();
		
		
		if(retObjCount>20)
		{
			offset = (retObjCount-20);
			StdXResolution = (Integer.parseInt(StdXResolution)+(offset*40))+"";
			//out.println("StdXResolution :::"+StdXResolution);
			
		}
		
	}
	//out.println("retObjCount"+retObjCount)	;

	if(retObjCount>0)
	{
		for(int i=0;i<retObjCount;i++)
		{
			if("VQH".equals(reportType) || "VQWH".equals(reportType))
			{
				
				retbuild.addRow();
				retbuild.setFieldValueAt("XKEY",Long.parseLong(retObj.getFieldValueString(i,"ERH_SOLD_TO"))+"",i);
				retbuild.setFieldValueAt("YKEY",retObj.getFieldValueString(i,"QUOTES"),i);
						
			}
			else if("APGEH".equals(reportType) || "PGEH".equals(reportType))
			{
				//data[0][i] = Double.parseDouble(retObj.getFieldValueString(i,"TOTAL_PRICE"));	
				retbuild.addRow();
				retbuild.setFieldValueAt("YKEY",retObj.getFieldValueString(i,"TOTAL_PRICE"),i);
			}
			else if("APGQH".equals(reportType) || "PGQH".equals(reportType))
			{
				///data[0][i] = Double.parseDouble(retObj.getFieldValueString(i,"TOTAL_QTY"));	
				retbuild.addRow();
				retbuild.setFieldValueAt("YKEY",retObj.getFieldValueString(i,"TOTAL_QTY"),i);
			}
			else if("APGFH".equals(reportType) || "PGFH".equals(reportType) || "MPFH".equals(reportType))
			{
				///data[0][i] = Double.parseDouble(retObj.getFieldValueString(i,"FREQUENCY"));
				retbuild.addRow();
				retbuild.setFieldValueAt("YKEY",retObj.getFieldValueString(i,"FREQUENCY"),i);
							
			}
			if("APGEH".equals(reportType) || "PGEH".equals(reportType) || "APGQH".equals(reportType) || "PGQH".equals(reportType) || "APGFH".equals(reportType) || "PGFH".equals(reportType) || "MPFH".equals(reportType))
			{
				//xAxisLabels[j] = Long.parseLong(retObj.getFieldValueString(j,"ERD_MATERIAL"))+"";
				retbuild.setFieldValueAt("XKEY",Long.parseLong(retObj.getFieldValueString(i,"ERD_MATERIAL"))+"",i);
			}
		}
		
		if("VQH".equals(reportType))
		{
			xAxisTitle = "VENDORS";
			yAxisTitle = "NUMBER OF QUOTATIONS";
			title = "Quotations Made By Vendors in Last "+timePeriod+" Months";
			
			dataSetsRet.addRow();
			dataSetsRet.setFieldValueAt("SERIES",retbuild,0);
			dataSetsRet.setFieldValueAt("LEGEND_LABELS","Quoted",0);
			
		}
		else if("VQWH".equals(reportType))
		{
			xAxisTitle = "VENDORS";
			yAxisTitle = "QUOTATION WINS";
			title = "Quotation Won By Vendors in Last "+timePeriod+" Months";
			
			dataSetsRet.addRow();
			dataSetsRet.setFieldValueAt("SERIES",retbuild,0);
			dataSetsRet.setFieldValueAt("LEGEND_LABELS"," Wins ",0);
			
		}
		else if("APGEH".equals(reportType))
		{
			xAxisTitle = "MATERIALS";
			yAxisTitle = "EXPENDITURE";
			title = "All Purchase Groups Expenditure On Materials in Last "+timePeriod+" Months";
			
			dataSetsRet.addRow();
			dataSetsRet.setFieldValueAt("SERIES",retbuild,0);
			dataSetsRet.setFieldValueAt("LEGEND_LABELS"," Expenditure ",0);
			
		}
		else if("PGEH".equals(reportType))
		{
			xAxisTitle = "MATERIALS";
			yAxisTitle = "EXPENDITURE";
			title = " Purchase Group Expenditure On Materials in Last "+timePeriod+" Months";
			
			dataSetsRet.addRow();
			dataSetsRet.setFieldValueAt("SERIES",retbuild,0);
			dataSetsRet.setFieldValueAt("LEGEND_LABELS"," Expenditure ",0);
			
		}
		else if("APGQH".equals(reportType))
		{
			xAxisTitle = "MATERIALS";
			yAxisTitle = "QUANTITY";
			title = "All Purchase Groups Purchased Materials Quantity in Last "+timePeriod+" Months";
			
			dataSetsRet.addRow();
			dataSetsRet.setFieldValueAt("SERIES",retbuild,0);
			dataSetsRet.setFieldValueAt("LEGEND_LABELS"," Quantity ",0);
			
		}
		else if("PGQH".equals(reportType))
		{
			xAxisTitle = "MATERIALS";
			yAxisTitle = "QUANTITY";
			title = " Purchase Groups Purchased Materials Quantity in Last "+timePeriod+" Months";
			
			dataSetsRet.addRow();
			dataSetsRet.setFieldValueAt("SERIES",retbuild,0);
			dataSetsRet.setFieldValueAt("LEGEND_LABELS"," Quantity ",0);
			
			
		}
		else if("APGFH".equals(reportType))
		{
			xAxisTitle = "MATERIALS";
			yAxisTitle = "FREQUENCY";
			title = "All Purchase Groups Purchased Materials Frequency in Last "+timePeriod+" Months";
			
			dataSetsRet.addRow();
			dataSetsRet.setFieldValueAt("SERIES",retbuild,0);
			dataSetsRet.setFieldValueAt("LEGEND_LABELS"," FREQUENCY ",0);
			
		}
		else if("PGFH".equals(reportType) || "MPFH".equals(reportType))
		{
			xAxisTitle = "MATERIALS";
			yAxisTitle = "FREQUENCY";
			title = " Purchase Groups Purchased Materials Frequency in Last "+timePeriod+" Months";
			
			dataSetsRet.addRow();
			dataSetsRet.setFieldValueAt("SERIES",retbuild,0);
			dataSetsRet.setFieldValueAt("LEGEND_LABELS"," Frequency ",0);
			
		}
		//out.println("StdXResolution : "+StdXResolution);
		graphParams.setXResolution(StdXResolution);
		graphParams.setYResolution(StdYResolution);
		graphParams.setChartTitle(title);
		graphParams.setDomainAxisLabel(xAxisTitle);
		graphParams.setRangeAxisLabel(yAxisTitle);
		
		ezc.ezparam.EzcParams graphmainParams = new ezc.ezparam.EzcParams(false);
		graphmainParams.setObject(graphParams);
		
		String filename = EzChartGenerator.generateChart(graphType,dataSetsRet,graphmainParams,session, new PrintWriter(out));
		String graphURL1 = request.getContextPath() + "/servlet/DisplayChart?filename=" + filename;
		//out.println("graphURL1"+graphURL1);
%>
		<!--<img src="<%= graphURL1 %>" width=<%= StdXResolution %> height=600 border=0 align="center" usemap="#<%= filename %>"> -->
		<html>
		<head>
		<link rel="stylesheet" href="../../../../..Library/Styles/ezThemeGreen.css">
		<title> Graphs </title>
		<Script>
		function funSelect()
		{
			var graphtype="";
			graphtype = document.myForm.GraphType.value;
			//document.myForm.action ="ezChart.jsp"
			document.myForm.submit();
		}
		function funLoad()
		{
			var graphtype="<%=graphType%>";
			document.myForm.GraphType.value=graphtype;
			
		}
		</Script>
		</head>
		<body onLoad="funLoad()">
		<form name="myForm" >
		
			<table width="50%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
				
					  <Th width="40%" align="left">Select Graph Type :</Th>	
					  <td width="60%">
					  	<select name="GraphType" style="width:100%" id="" onChange="javaScript:funSelect()">
							<option value="">-Select Graph Type-</option>
							<option value="3DBar">3DBar</option>
							<option value="Bar">Bar</option>
							<option value="StackedBar">StackedBar</option>
							<option value="Pie">Pie</option>
							<option value="3DPie">3DPie</option>
							<option value="MultiplePie">MultiplePie</option>
							<option value="Area">Area</option>
							<option value="StackedArea">StackedArea</option>
							<option value="Line">Line</option>
							<option value="Line3D">Line3D</option>
							
							
						</select>
					  </td>
					
			</table>
			<br>
			<table  id="tabHead1" width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
			<td  width="100%" align="center" class="displayheader">
			<img src="<%= graphURL1 %>" width=<%=StdXResolution%> height=600 border=0 align="center" usemap="#<%= filename %>">
			</td>
			</table>
			
			<input type="hidden" name="selGraph" value="" >
			<input type="hidden" name="Report" value='<%=reportType%>' >
			<input type="hidden" name="TimePeriod" value='<%=timePeriod%>' >
			<input type="hidden" name="PurchaseGrp" value='<%=purGrp%>' >
			<input type="hidden" name="PurchaseOrg" value='<%=purOrg%>' >
			
			
		</form>	
		</body>
		</html>
		
<%	
	
	}
	else if("VQH".equals(reportType))
	{
%>
	<BR><BR><BR><BR><BR>
	<center>
	<Th>There Are No Quotations Made By Any Vendor in last <%=" "+timePeriod+" " %> Months</Th>
	</center>
<%
	}
	else if("VQWH".equals(reportType))
	{
%>
	<BR><BR><BR><BR><BR>
	<center>
	<Th>There Are No Quotations Won By Any Vendor in last <%=" "+timePeriod+" " %> Months</Th>
	</center>
<%
	}
	else if("APGEH".equals(reportType))
	{
%>	
		<BR><BR><BR><BR><BR>
		<center>
			
			<Th>There Are No Purchase Groups Expenditure On Materials in Last <%=" "+timePeriod+" " %> Months</Th>
		</center>
<%
	}
	else if("PGEH".equals(reportType))
	{
%>	
		<BR><BR><BR><BR><BR>
		<center>
			<Th>There is No Purchase Group Expenditure On Materials in Last <%=" "+timePeriod+" " %> Months</Th>
		</center>
<%
	}
	else if("APGQH".equals(reportType))
	{
%>	
		<BR><BR><BR><BR><BR>
			<center>
				<Th>There Are No Purchase Groups Purchased Materials Quantity in Last <%=" "+timePeriod+" " %> Months</Th>
			</center>
<%
	}
	else if("PGQH".equals(reportType))
	{
%>	
		<BR><BR><BR><BR><BR>
			<center>
				<Th>There is No Purchase Group Purchased Materials Quantity in Last <%=" "+timePeriod+" " %> Months</Th>
			</center>
<%
	}
	else if("APGFH".equals(reportType))
	{
%>		
		<BR><BR><BR><BR><BR>
			<center>
				<Th>There Are No Purchase Groups Purchased Materials Frequency in Last <%=" "+timePeriod+" " %> Months</Th>
			</center>
<%
	}
	else if("PGFH".equals(reportType))
	{
%>
		<BR><BR><BR><BR><BR>
			<center>
				<Th>There is No Purchase Group Purchased Materials Frequency in Last <%=" "+timePeriod+" " %> Months</Th>
			</center>
<%
	}
%>



<Div id="MenuSol"></Div>
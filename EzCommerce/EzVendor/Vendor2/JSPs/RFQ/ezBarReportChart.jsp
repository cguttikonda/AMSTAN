<%@include file="../../Library/Globals/errorPagePath.jsp"%>
<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>

<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@page import="ezc.ezadmin.ezadminutils.client.*,ezc.ezadmin.ezadminutils.params.*,ezc.ezparam.*,ezc.ezpreprocurement.client.*,ezc.ezpreprocurement.params.*"%>
<%@page import="org.jCharts.axisChart.AxisChart,org.jCharts.axisChart.customRenderers.axisValue.renderers.ValueLabelPosition,org.jCharts.axisChart.customRenderers.axisValue.renderers.ValueLabelRenderer,org.jCharts.chartData.AxisChartDataSet,org.jCharts.chartData.DataSeries,org.jCharts.chartData.interfaces.IAxisDataSeries,org.jCharts.encoders.ServletEncoderHelper,org.jCharts.properties.*,org.jCharts.properties.util.ChartFont,org.jCharts.types.ChartType,java.awt.*"%>
<%
	int chartWidth  = 850;
	int chartHeight = 565;
	int retObjCount = 0;	
	double[][] data = null;
	String[]   xAxisLabels  = null;
	String xAxisTitle = null;
	String yAxisTitle = null;
	String title = null;
	String[] legendLabels = new String[1];	
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
	
	if("PGEH".equals(reportType) || "PGQH".equals(reportType) || "PGFH".equals(reportType))
	{
		String purGrp = request.getParameter("PurchaseGrp");							      
		String purOrg = request.getParameter("PurchaseOrg");	
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
			String purGroup = null,purOrg = null;
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
		retObjCount = retObj.getRowCount();
		

	if(retObjCount>0)
	{
	
	BarChartProperties barChartProperties	= new BarChartProperties();
	LegendProperties   legendProperties 	= new LegendProperties();
	ChartProperties    chartProperties 	= new ChartProperties();
	AxisProperties 	   axisProperties 	= new AxisProperties(false);	
	
	ChartFont axisScaleFont = new ChartFont( new Font( "Georgia Negreta cursiva", Font.PLAIN, 13 ), Color.black );
	axisProperties.getXAxisProperties().setScaleChartFont( axisScaleFont );
	axisProperties.getYAxisProperties().setScaleChartFont( axisScaleFont );

	ChartFont axisTitleFont = new ChartFont( new Font( "Arial Narrow", Font.PLAIN, 14 ), Color.black );
	axisProperties.getXAxisProperties().setTitleChartFont( axisTitleFont );
	axisProperties.getYAxisProperties().setTitleChartFont( axisTitleFont );

	/****************************************
	To Define Our Own Scale On Y-Axis
	DataAxisProperties dataAxisProperties = (DataAxisProperties) axisProperties.getYAxisProperties();
	dataAxisProperties.setUserDefinedScale( 0,1);
	dataAxisProperties.setRoundToNearest(1);
	*****************************************/
	
	ChartFont titleFont = new ChartFont(new Font("Georgia Negreta cursiva",Font.PLAIN,14),Color.black);
	chartProperties.setTitleFont(titleFont);
	
	ValueLabelRenderer valueLabelRenderer = new ValueLabelRenderer(false,false,true,-1);
	valueLabelRenderer.setValueLabelPosition(ValueLabelPosition.ON_TOP);
	valueLabelRenderer.useVerticalLabels(false);
	barChartProperties.addPostRenderEventListener(valueLabelRenderer);
	barChartProperties.setWidthPercentage(0.25f);
	
	data 	= new double[1][retObjCount];
	xAxisLabels = new String[retObjCount];
	
	for(int i=0;i<retObjCount;i++)
	{
		if("VQH".equals(reportType) || "VQWH".equals(reportType))
		{
			data[0][i] = Double.parseDouble(retObj.getFieldValueString(i,"QUOTES"));		
		}
		else if("APGEH".equals(reportType) || "PGEH".equals(reportType))
		{
			data[0][i] = Double.parseDouble(retObj.getFieldValueString(i,"TOTAL_PRICE"));		
		}
		else if("APGQH".equals(reportType) || "PGQH".equals(reportType))
		{
			data[0][i] = Double.parseDouble(retObj.getFieldValueString(i,"TOTAL_QTY"));		
		}
		else if("APGFH".equals(reportType) || "PGFH".equals(reportType) || "MPFH".equals(reportType))
		{
			data[0][i] = Double.parseDouble(retObj.getFieldValueString(i,"FREQUENCY"));
		}	
	}
	
	for(int j=0;j<retObjCount;j++)
	{
		if("VQH".equals(reportType) || "VQWH".equals(reportType))
		{
			xAxisLabels[j] = Long.parseLong(retObj.getFieldValueString(j,"ERH_SOLD_TO"))+"";
		}
		else if("APGEH".equals(reportType) || "PGEH".equals(reportType) || "APGQH".equals(reportType) || "PGQH".equals(reportType) || "APGFH".equals(reportType) || "PGFH".equals(reportType) || "MPFH".equals(reportType))
		{
			xAxisLabels[j] = Long.parseLong(retObj.getFieldValueString(j,"ERD_MATERIAL"))+"";
		}
	}
		
	if("VQH".equals(reportType))
	{
		xAxisTitle = "VENDORS";
		yAxisTitle = "NUMBER OF QUOTATIONS";
		title = "Quotations Made By Vendors in Last "+timePeriod+" Months";
		legendLabels[0] = "Quoted";
	}
	else if("VQWH".equals(reportType))
	{
		xAxisTitle = "VENDORS";
		yAxisTitle = "QUOTATION WINS";
		title = "Quotation Won By Vendors in Last "+timePeriod+" Months";
		legendLabels[0] = "Wins";
	}
	else if("APGEH".equals(reportType))
	{
		xAxisTitle = "MATERIALS";
		yAxisTitle = "EXPENDITURE";
		title = "All Purchase Groups Expenditure On Materials in Last "+timePeriod+" Months";
		legendLabels[0] = "Expenditure";
	}
	else if("PGEH".equals(reportType))
	{
		xAxisTitle = "MATERIALS";
		yAxisTitle = "EXPENDITURE";
		title = " Purchase Group Expenditure On Materials in Last "+timePeriod+" Months";
		legendLabels[0] = "Expenditure";
	}
	else if("APGQH".equals(reportType))
	{
		xAxisTitle = "MATERIALS";
		yAxisTitle = "QUANTITY";
		title = "All Purchase Groups Purchased Materials Quantity in Last "+timePeriod+" Months";
		legendLabels[0] = "Quantity";
	}
	else if("PGQH".equals(reportType))
	{
		xAxisTitle = "MATERIALS";
		yAxisTitle = "QUANTITY";
		title = " Purchase Groups Purchased Materials Quantity in Last "+timePeriod+" Months";
		legendLabels[0] = "Quantity";
	}
	else if("APGFH".equals(reportType))
	{
		xAxisTitle = "MATERIALS";
		yAxisTitle = "FREQUENCY";
		title = "All Purchase Groups Purchased Materials Frequency in Last "+timePeriod+" Months";
		legendLabels[0] = "Frequency";
	}
	else if("PGFH".equals(reportType) || "MPFH".equals(reportType))
	{
		xAxisTitle = "MATERIALS";
		yAxisTitle = "FREQUENCY";
		title = " Purchase Groups Purchased Materials Frequency in Last "+timePeriod+" Months";
		legendLabels[0] = "Frequency";
	}
	
	IAxisDataSeries dataSeries = new DataSeries(xAxisLabels,xAxisTitle,yAxisTitle,title);
	Paint[] paints = new Paint[]{Color.yellow};
	dataSeries.addIAxisPlotDataSet( new AxisChartDataSet(data,legendLabels,paints,ChartType.BAR,barChartProperties));
	AxisChart axisChart = new AxisChart(dataSeries,chartProperties,axisProperties,legendProperties,chartWidth,chartHeight);
	ServletEncoderHelper.encodeJPEG13(axisChart,1.0f,response);
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
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@page import="ezc.ezparam.*,ezc.ezpreprocurement.client.*,ezc.ezpreprocurement.params.*"%>
<%@page import="org.jCharts.axisChart.AxisChart,org.jCharts.axisChart.customRenderers.axisValue.renderers.ValueLabelPosition,org.jCharts.axisChart.customRenderers.axisValue.renderers.ValueLabelRenderer,org.jCharts.chartData.AxisChartDataSet,org.jCharts.chartData.DataSeries,org.jCharts.chartData.interfaces.IAxisDataSeries,org.jCharts.encoders.ServletEncoderHelper,org.jCharts.properties.*,org.jCharts.properties.util.ChartFont,org.jCharts.types.ChartType,java.awt.*"%>
<%
	EzcParams 		ezcParams 	= null;
	ReturnObjFromRetrieve 	retObj 		= null;		
	EzPreProcurementManager procurementManager = new EzPreProcurementManager();
	EziReportParams 	reportParams = new EziReportParams();
	
	String timePeriod = request.getParameter("timePeriod");
	String reportType = request.getParameter("reportType");
	
	reportParams.setCallPattern("REPORT");
	reportParams.setReportType(reportType);
	reportParams.setTimePeriod(timePeriod);	

	ezcParams = new EzcParams(false);
	ezcParams.setLocalStore("Y");
	ezcParams.setObject(reportParams);
	Session.prepareParams(ezcParams);				
	retObj = (ReturnObjFromRetrieve)procurementManager.getReportData(ezcParams);	
	int retObjCount = 0;	
	if(retObj!=null) 
		retObjCount = retObj.getRowCount();

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

	DataAxisProperties dataAxisProperties = (DataAxisProperties) axisProperties.getYAxisProperties();
	dataAxisProperties.setUserDefinedScale( 0,1);
	dataAxisProperties.setRoundToNearest(1);
	
	ChartFont titleFont = new ChartFont(new Font("Georgia Negreta cursiva",Font.PLAIN,14),Color.black);
	chartProperties.setTitleFont(titleFont);
	ValueLabelRenderer valueLabelRenderer = new ValueLabelRenderer(false,false,true,-1);
	valueLabelRenderer.setValueLabelPosition(ValueLabelPosition.ON_TOP);
	valueLabelRenderer.useVerticalLabels(false);
	barChartProperties.addPostRenderEventListener(valueLabelRenderer);
	
	double[][] data 	= new double[1][retObjCount];
	String[]   xAxisLabels  = null;
	xAxisLabels = new String[retObjCount];
	int width  = 850;
	int height = 565;
	
	for(int i=0;i<retObjCount;i++)
	{
		data[0][i] = Double.parseDouble(retObj.getFieldValueString(i,"QUOTES"));		
	}
	for(int j=0;j<retObjCount;j++)
	{
		xAxisLabels[j] = retObj.getFieldValueString(j,"ERH_SOLD_TO");
	}

	String xAxisTitle = "Vendors";
	String yAxisTitle = "";
	String title = "";
	String[] legendLabels = new String[1];
	
	if("VENREQ".equals(reportType))
	{
		yAxisTitle = "Quotation Requests";
		title = "Vendor Quotation Request";
		legendLabels[0] = "Requests";
	}
	else if("VENRES".equals(reportType))
	{
		yAxisTitle = "Quotation Responses";
		title = "Vendor Quotation Response";
		legendLabels[0] = "Responses";
	}
	else if("VENWIN".equals(reportType))
	{
		yAxisTitle = "L1 Win";
		title = "Vendor L1 Wins";
		legendLabels[0] = "L1 Wins";
	}
	
	IAxisDataSeries dataSeries = new DataSeries(xAxisLabels,xAxisTitle,yAxisTitle,title);

	Paint[] paints = new Paint[]{Color.yellow};
	dataSeries.addIAxisPlotDataSet( new AxisChartDataSet(data,legendLabels,paints,ChartType.BAR,barChartProperties));

	AxisChart axisChart = new AxisChart(dataSeries,chartProperties,axisProperties,legendProperties,width,height);
	ServletEncoderHelper.encodeJPEG13(axisChart,1.0f,response);
%>	
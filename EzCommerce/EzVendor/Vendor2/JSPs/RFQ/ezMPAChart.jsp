<%@include file="../../Library/Globals/errorPagePath.jsp"%>
<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<%@include file="../../../Includes/Jsps/Rfq/iMPAChart.jsp" %>

<%
	
   try
   {
	//LineChart Delcarations
	LegendProperties legendProperties = new LegendProperties();
	ChartProperties chartProperties = new ChartProperties();
	AxisProperties axisProperties = new AxisProperties(false);
	
	ChartFont axisScaleFont = new ChartFont( new Font( "Georgia Negreta cursiva", Font.PLAIN, 13 ), Color.red );
	ChartFont naxisScaleFont = new ChartFont( new Font( "Times New Roman", Font.PLAIN, 18 ), Color.red );
	axisProperties.getXAxisProperties().setScaleChartFont( axisScaleFont );
	axisProperties.getYAxisProperties().setScaleChartFont( axisScaleFont );
			
	ChartFont axisTitleFont = new ChartFont( new Font( "Arial Narrow", Font.PLAIN, 11 ), Color.black );
	axisProperties.getXAxisProperties().setTitleChartFont( axisTitleFont );
	axisProperties.getYAxisProperties().setTitleChartFont( axisTitleFont );
	
	String xAxisTitle= "Vendors";
	String yAxisTitle= "Prices";
	String title= "Vendor Material-Price Analysis";
	DataSeries dataSeries = new DataSeries( labels, xAxisTitle, yAxisTitle, title );

	String[] legendLabels= { "Max Price", "Min Price" };
	Paint[] paints= TestDataGenerator.getRandomPaints( 2 );
	ClusteredBarChartProperties clusteredBarChartProperties= new ClusteredBarChartProperties();

	ChartFont titleFont = new ChartFont(new Font("Georgia Negreta cursiva",Font.PLAIN,14),Color.black);
	chartProperties.setTitleFont(titleFont);
	ValueLabelRenderer valueLabelRenderer = new ValueLabelRenderer(false,false,true,-1);
	valueLabelRenderer.setValueLabelPosition(ValueLabelPosition.ON_TOP);
	valueLabelRenderer.useVerticalLabels(false);
	clusteredBarChartProperties.addPostRenderEventListener(valueLabelRenderer);

	AxisChartDataSet axisChartDataSet= new AxisChartDataSet(data, legendLabels, paints, ChartType.BAR_CLUSTERED, clusteredBarChartProperties );
	dataSeries.addIAxisPlotDataSet( axisChartDataSet );
	
	AxisChart axisChart= new AxisChart( dataSeries, chartProperties, axisProperties, legendProperties,550, 360);
		
	ServletEncoderHelper.encodeJPEG13(axisChart, 1.0f, response);
					
    }catch(Exception e)
    {
	System.out.println(e);
    }
			
%>
			


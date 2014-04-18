<%@ page import="ezc.ezparam.*,org.jCharts.chartData.*,org.jCharts.encoders.*,org.jCharts.nonAxisChart.*,org.jCharts.properties.*,java.awt.*" %>
<%@include file="../../../Includes/Jsps/Rfq/iLineChartReport.jsp" %>

<%--
	//LineChart Delcarations
	LegendProperties legendProperties = new LegendProperties();
	ChartProperties chartProperties = new ChartProperties();
	AxisProperties axisProperties = new AxisProperties(false);	

	ChartFont axisScaleFont = new ChartFont( new Font( "Georgia Negreta cursiva", Font.PLAIN, 13 ), Color.red );
	ChartFont naxisScaleFont = new ChartFont( new Font( "Times New Roman", Font.PLAIN, 18 ), Color.red );
	axisProperties.getXAxisProperties().setScaleChartFont( axisScaleFont );
	axisProperties.getYAxisProperties().setScaleChartFont( axisScaleFont );
	//axisProperties.setXAxisLabelsAreVertical(true);

	ChartFont axisTitleFont = new ChartFont( new Font( "Arial Narrow", Font.PLAIN, 11 ), Color.black );
	axisProperties.getXAxisProperties().setTitleChartFont( axisTitleFont );
	axisProperties.getYAxisProperties().setTitleChartFont( axisTitleFont );

	String[] legendLabels = null;
	String title= "Materials Average Quotation Price History";
	String xAxisTitle= "Quotations";
	String yAxisTitle= "Price";
	String[] xAxisLabels = new String[MaxQuotations+1];
	xAxisLabels[0] = "Initial";
	for(int i=1;i<MaxQuotations+1;++i)
	{
		
		xAxisLabels[i] = "QT"+i;
	}
	
	int materialsVectorSize = materials.size();	
	legendLabels = new String[materialsVectorSize];
	for(int i=0;i<materialsVectorSize;++i)
	{
		legendLabels[i]=(String)materials.get(i); 
	}	
	DataSeries dataSeries = new DataSeries( xAxisLabels, xAxisTitle, yAxisTitle,title );
	
	double dataarr[][] = null;	
	dataarr = new double[materialsVectorSize][MaxQuotations+1];
	
	for(int i=0;i<materialsVectorSize;++i)
	{
						
		Hashtable values = new Hashtable();
		String material = (String)materials.get(i);
		
		for(int k=0;k<retObjCount;++k)
		{
			String mat=retObj.getFieldValueString(k,"ERD_MATERIAL");
			String count=retObj.getFieldValueString(k,"ERD_COUNTER");
			if(material.equals(v))
			{				
				String p=retObj.getFieldValueString(k,"ERD_PRICE");
				String c=retObj.getFieldValueString(k,"ERD_COUNTER");				
				values.put(c,p);
			}			
		}
		out.println(values+"<BR><BR><BR><BR>");
		
		
		
		
		for(int j=0;j<MaxQuotations+1;++j)
		{
			String index = new Integer(j).toString();
			Object obj = values.get(index);
			if(obj != null)
			{
				double d=Double.parseDouble((String)obj);
				dataarr[i][j] = d;
			}
			else
			{
				dataarr[i][j] = 0;
			}						
		}
	}
	
	Paint[] paints= new Paint[materialsVectorSize];
	Random r = new Random();
	for(int i=0;i<paints.length;++i)
	{
		paints[i] = new Color(r.nextInt(255),r.nextInt(255),r.nextInt(255));
	}
	

	Stroke[] strokes = new Stroke[materialsVectorSize];
	for(int l=0;l<materialsVectorSize;++l)
	{
		strokes[l] = LineChartProperties.DEFAULT_LINE_STROKE;
	}
	
	Shape[] shapes = new Shape[materialsVectorSize]; 
	for(int m=0;m<materialsVectorSize;++m)
	{
		shapes[m] = PointChartProperties.SHAPE_CIRCLE;
	}
	
	LineChartProperties lineChartProperties = new LineChartProperties(strokes,shapes);


	/***********************************************
	for(int i=0;i<dataarr.length;++i)
	{
		out.println("ROW NUMBER - "+i+"----->");
		for(int j=0;j<dataarr[i].length;++j)
		out.println(dataarr[i][j]+"--");
		out.println("<BR><BR><BR>");
	}
	************************************************/
	
	AxisChartDataSet acds = new AxisChartDataSet(dataarr, legendLabels, paints,ChartType.LINE, lineChartProperties );
	dataSeries.addIAxisPlotDataSet(acds);	
	AxisChart axisChart = new AxisChart(dataSeries, chartProperties, axisProperties,legendProperties, 550, 360);
	ServletEncoderHelper.encodeJPEG13(axisChart, 1.0f, response);

--%>


</html>
<Div id="MenuSol"></Div>
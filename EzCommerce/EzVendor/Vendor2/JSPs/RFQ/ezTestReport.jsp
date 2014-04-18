<%@ page import="ezc.ezparam.*,org.jCharts.chartData.*,org.jCharts.encoders.*,org.jCharts.nonAxisChart.*,org.jCharts.properties.*,java.awt.*" %>

<%

PieChart2DProperties pieChart2DProperties = new PieChart2DProperties();
LegendProperties legendProperties = new LegendProperties();
ChartProperties chartProperties = new ChartProperties();
PieChartDataSet dataset = null;
PieChart2D pieChart2D = null;
Random randomColorGenerator=new Random();


legendProperties.setNumColumns(2);
legendProperties.setPlacement(LegendProperties.RIGHT);

double[] data = new double[]{4, 2, 1, 1, 1};
Paint[] paints = new Paint[]{Color.blue, Color.red, Color.green, Color.yellow, Color.magenta};

for(int i=0;i<data.length;++i)
{
	paints[i] = new Color(randomColorGenerator.random(255),randomColorGenerator.random(255),randomColorGenerator.random(255));
}



String[] labels = {"VEN1", "VEN2", "VEN3", "VEN4", "VEN5"};

dataset = new PieChartDataSet("VENDOR QUOTATION ANALYSIS", data, labels, paints, pieChart2DProperties);

try
{
    pieChart2D = new PieChart2D(dataset,legendProperties,chartProperties,300,300);
    ServletEncoderHelper.encodeJPEG13( pieChart2D, 1.0f, response );
    
}
catch( Throwable throwable )
{
  //HACK do your error handling here...
  throwable.printStackTrace();
}

%>

<html>
<head>
	
</head>
<body  bgcolor="#ffffff" text="#000000">
<form name=myForm>

<div id="buttons" style="position:absolute;top:65%;width:100%;visibility:visible" align="center">
	<img src="../../Images/Buttons/ENGLISH/GREEN/close.gif" style="cursor:hand" border=none onClick="JavaScript:window.close()">
	
	
</div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
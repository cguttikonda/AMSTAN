
<%@ page import="ezc.ezparam.*,org.jCharts.chartData.*,org.jCharts.encoders.*,org.jCharts.nonAxisChart.*,org.jCharts.properties.*,java.awt.*" %>
<%@include file="../../../Includes/Jsps/Rfq/iPieReportGenerator.jsp" %>

<%

//Pie Chart Declarations
PieChart2DProperties pieChart2DProperties = new PieChart2DProperties();
PieChartDataSet dataset = null;
PieChart2D pieChart2D = null;

//Generic Declarations
Paint[] paints = null;
LegendProperties legendProperties = new LegendProperties();
ChartProperties chartProperties = new ChartProperties();

legendProperties.setNumColumns(2);
legendProperties.setPlacement(LegendProperties.RIGHT);

%>

<%
if(data!=null && labels!=null)
{
	int size = data.length;
	paints = new Paint[size];
	Random r=new Random();
	for(int i=0;i<size;++i)
	{
		paints[i] = new Color(r.nextInt(255),r.nextInt(255),r.nextInt(255));
	}
	if("QBV".equals(status))
	{	
		dataset = new PieChartDataSet("VENDOR QUOTATION ANALYSIS", data, labels, paints, pieChart2DProperties);
	}
	else if("VQH".equals(status))
	{
		dataset = new PieChartDataSet("VENDOR QUOTATION HISTORY( "+selectedTime+" )months", data, labels, paints, pieChart2DProperties);
	}	

	try
	{
	    pieChart2D = new PieChart2D(dataset,legendProperties,chartProperties,450,450);
	    ServletEncoderHelper.encodeJPEG13( pieChart2D, 1.0f, response );
	    
	}
	catch( Throwable throwable )
	{	  
	  throwable.printStackTrace();
	}

}
else
{
%>
	<body  bgcolor="#ffffff" text="#000000">
	<form name=myForm>
	
	<Div id="ezClosedDates" style="position:absolute;width:100%">
	<Table  align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
   	<Tr>		
		Sorry,No Vendors Quoted For This Purchase Requistion	
	</Tr>
	</Table>
	</Div>
	
	<Div id="buttons" style="position:absolute;top:85%;width:100%;visibility:visible" align="center">
<%				 
	    butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;close&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");  
	    butActions.add("window.close()");
	    out.println(getButtons(butNames,butActions));
%>	</Div>
	
	</form>
	</body>
<%
}
%>
<Div id="MenuSol"></Div>
</html>
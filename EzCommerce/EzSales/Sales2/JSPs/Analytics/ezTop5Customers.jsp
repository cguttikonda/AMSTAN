<%@ page import="java.lang.*,java.sql.*" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>

<jsp:useBean id="webCatalogObj" class="ezc.client.EzWebCatalogManager" scope="page"></jsp:useBean>
<%
	ezc.ezparam.ReturnObjFromRetrieve custSalesObj = new ezc.ezparam.ReturnObjFromRetrieve(new String[]{"SOLDTO","TOTPRICE"});

	Connection con = null;	
	java.sql.Statement stmt=null;

	try
	{
		String click="SELECT TOP 5 ESDH_SOLD_TO,SUM(ESDI_COMMITED_PRICE) TOTAL_PRICE FROM EZC_SALES_DOC_HEADER,EZC_SALES_DOC_ITEMS WHERE ESDI_SALES_DOC=ESDH_DOC_NUMBER GROUP BY ESDH_SOLD_TO";

		Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");
		con = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=ezastdev;SelectMethod=cursor","ezastdev","ezastdev");

		stmt = con.createStatement();
		ResultSet rs = stmt.executeQuery(click);

		String soldTo = "";
		String totPrice = "";

		while(rs.next()) 
		{
			soldTo 	 = rs.getString(1);
			totPrice = rs.getString(2);

			custSalesObj.setFieldValue("SOLDTO",soldTo);
			custSalesObj.setFieldValue("TOTPRICE",totPrice);
			custSalesObj.addRow();
		}
	}
	catch(Exception e) 
	{
		//out.println(e.toString());
		e.printStackTrace();
	}
	finally
	{
		stmt.close();
		con.close();
	}
	int totCount = 0;
	
	if(custSalesObj!=null)
	{
		totCount = custSalesObj.getRowCount();
		custSalesObj.sort(new String[]{"TOTPRICE"},true);
	}

	//out.println(custSalesObj.toEzcString());
%>
<html>
<head>
<script type="text/javascript" src="http://www.google.com/jsapi"></script>
<script type="text/javascript">

	//google.load('visualization', '1');
	google.setOnLoadCallback(drawVisualization);
	
	google.load('visualization', '1.0', {packages: ['charteditor']});

	var graphChng=''
	var chartEditor = null;
	function drawVisualization()
	{

		graphChng=document.myForm.graph.value

		if(graphChng=='pie')
			graphChng='PieChart'
		else if(graphChng=='bar')
			graphChng='BarChart'
		else if(graphChng=='line')
			graphChng='AreaChart'
		else if(graphChng=='col')
			graphChng='ColumnChart'
		else if(graphChng=='com')
		{
			drawComarision()
			return
		}
		else
			return

		nCust=<%=totCount%>
		var selCustCodeObj=document.myForm.selCustCode;
		var selTotValObj=document.myForm.selTotVal;

		var sCust0 = eval("selCustCodeObj[0]").value;
		var sTot0 = parseInt(eval("selTotValObj[0]").value);

		var sCust1 = eval("selCustCodeObj[1]").value;
		var sTot1 = parseInt(eval("selTotValObj[1]").value);
		
		var sCust2 = eval("selCustCodeObj[2]").value;
		var sTot2 = parseInt(eval("selTotValObj[2]").value);

		var sCust3 = eval("selCustCodeObj[3]").value;
		var sTot3 = parseInt(eval("selTotValObj[3]").value);

		//var sCust4 = eval("selCustCodeObj[4]").value;
		//var sTot4 = parseInt(eval("selTotValObj[4]").value);

		var wrapper = new google.visualization.ChartWrapper({
			chartType: graphChng,
			dataTable: [['C6100',0],[sCust0,sTot0],[sCust1,sTot1],[sCust2,sTot2],[sCust3,sTot3]],
			options: {width: 385, height: 175,'title': 'Top 5 Customers (SoldTo / Price($))' ,is3D:false},
			containerId: 'vis_div'
			});
 		wrapper.draw();
	}
	function drawComarision()
	{
		var data = new google.visualization.DataTable();
		var raw_data = [['Desktops', 1500, 1800, 2500, 7900,6770,5520],
				['Servers', 1800, 2500, 1500, 1900,8770,1520],
				['Routers', 4500, 1780, 3500, 2900,7770,3520],
				['HardDisks', 3500, 1800, 4500, 900,8770,4520],
				['Rams', 5500, 2800, 2500, 5900,9770,5520],
				['Switches', 1500, 3800, 6500, 9900,770,6520]
			       ];

		var years = [2003, 2004, 2005, 2006, 2007, 2008];

		data.addColumn('string', 'Year');
		for (var i = 0; i  < raw_data.length; ++i) 
		{
			data.addColumn('number', raw_data[i][0]);
		}

	        data.addRows(years.length);

		for (var j = 0; j < years.length; ++j)
		{
			data.setValue(j, 0, years[j].toString());
		}
		for (var i = 0; i  < raw_data.length; ++i)
		{
			for (var j = 1; j  < raw_data[i].length; ++j)
			{
				data.setValue(j-1, i+1, raw_data[i][j]);
			}
		}

		new google.visualization.BarChart(document.getElementById('vis_div')).
		draw(data,
			{title:"Yearly Sales",width:500,height:300,vAxis: {title: "Year"},hAxis: {title: "Quantity"}}
           	);
	}
	google.setOnLoadCallback(drawVisualization);
</script>
</head>
<body scroll=yes>
	<form name='myForm'>
        <div id="vis_div" align='center'></div>
        <div  align='center'>
	<Tr>
        	<Th>Select Graph Type</Th>
        	<Td>
        		<select name ="graph" onChange="drawVisualization()">
        		<option value=''>--Select----</option>
        		<option value='bar' selected>BAR </option>
        		<option value='pie'>Pie </option>
        		<option value='line'>Line </option>
        		<option value='col'>Column </option>
        		<!--<option value='com'>Comparision </option>-->
        		</select>
		</Td>
<%
	for(int i=0;i<custSalesObj.getRowCount();i++)
	{
		String soldTo_A = custSalesObj.getFieldValueString(i,"SOLDTO");
		String totVal_A = custSalesObj.getFieldValueString(i,"TOTPRICE");

		java.math.BigDecimal bd_totVal = new java.math.BigDecimal(totVal_A);
		bd_totVal = bd_totVal.setScale(2,java.math.BigDecimal.ROUND_HALF_UP);
%>
		<input type=hidden name="selCustCode" value="<%=soldTo_A.trim()%>">
		<input type=hidden name="selTotVal" value="<%=bd_totVal.toString()%>">
<%
	}
%>
        </Tr>
        <Tr>
        	<Th>&nbsp;</Th>
        	<Td>&nbsp;</Td>
        </Tr>
        <Tr>
        	<Th>&nbsp;</Th>
        	<Td>&nbsp;</Td>
        </Tr>
        </div>
</form>
</body>
</html>
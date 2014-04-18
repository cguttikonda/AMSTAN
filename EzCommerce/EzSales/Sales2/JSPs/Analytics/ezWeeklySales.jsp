<%@ page import="java.lang.*,java.sql.*"%>
<%@ page import = "ezc.ezutil.FormatDate"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>

<jsp:useBean id="webCatalogObj" class="ezc.client.EzWebCatalogManager" scope="page"></jsp:useBean>
<%
	ezc.ezparam.ReturnObjFromRetrieve custSalesObj = new ezc.ezparam.ReturnObjFromRetrieve(new String[]{"WEEKEND","TOTPRICE"});
	//out.println("retCat"+retCat.toEzcString());

	Connection con = null;	
	java.sql.Statement stmt=null;
	
	FormatDate formatDate = new FormatDate();
	
	
	try
	{
		//String click="SELECT  DATENAME(YEAR,ESDH_CREATE_ON) YEAR,DATENAME(WEEK,ESDH_CREATE_ON) WEEK,SUM(ESDI_COMMITED_PRICE) TOTAL_PRICE FROM EZC_SALES_DOC_HEADER,EZC_SALES_DOC_ITEMS WHERE ESDI_SALES_DOC=ESDH_DOC_NUMBER GROUP BY DATENAME(YEAR,ESDH_CREATE_ON),DATENAME(WEEK,ESDH_CREATE_ON)ORDER BY DATENAME(YEAR,ESDH_CREATE_ON),DATENAME(WEEK,ESDH_CREATE_ON)";
		  String click="SELECT  DATEADD(WK, DATEDIFF(WK, 5,ESDH_CREATE_ON), 5) WEEKEND,SUM(ESDI_COMMITED_PRICE) TOTAL_PRICE FROM EZC_SALES_DOC_HEADER,EZC_SALES_DOC_ITEMS WHERE ESDI_SALES_DOC=ESDH_DOC_NUMBER GROUP BY DATEADD(WK, DATEDIFF(WK, 5,ESDH_CREATE_ON), 5) ORDER BY DATEADD(WK, DATEDIFF(WK, 5,ESDH_CREATE_ON), 5)";
		Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");
		con = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=ezastdev;SelectMethod=cursor","ezastdev","ezastdev");

		stmt = con.createStatement();
		ResultSet rs = stmt.executeQuery(click);

		String weekEnd = "";
		String totPrice = "";

		while(rs.next()) 
		{
			weekEnd 	 = rs.getString(1);
			totPrice = rs.getString(2);

			custSalesObj.setFieldValue("WEEKEND",weekEnd);
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
		//custSalesObj.sort(new String[]{"TOTPRICE"},true);
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

		/*var sCust3 = eval("selCustCodeObj[3]").value;
		var sTot3 = parseInt(eval("selTotValObj[3]").value);

		var sCust4 = eval("selCustCodeObj[4]").value;
		var sTot4 = parseInt(eval("selTotValObj[4]").value);*/

		var wrapper = new google.visualization.ChartWrapper({
			chartType: graphChng,
			dataTable: [['C6100',0],[sCust0,sTot0],[sCust1,sTot1],[sCust2,sTot2]],
			options: {width: 385, height: 175,'title': 'Weekly Sales',is3D:false},
			containerId: 'vis_div'
			});
 		wrapper.draw();
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
        		<option value='bar' >BAR </option>
        		<option value='pie'>Pie </option>
        		<option value='line'selected>Line </option>
        		<option value='col'>Column </option>
        		</select>
		</Td>
<%
	int monthReq=0,dateReq=0,yearReq=0;
	java.util.Date wDate = null;

	for(int i=totCount;totCount-3<i;i--)
	{
		String weekEnd_A = custSalesObj.getFieldValueString(i-1,"WEEKEND");

		monthReq = Integer.parseInt(weekEnd_A.substring(5,7));
		dateReq  = Integer.parseInt(weekEnd_A.substring(8,10));
		yearReq  = Integer.parseInt(weekEnd_A.substring(0,4));

		wDate = new java.util.Date(yearReq-1900,monthReq-1,dateReq);
		//out.println("wDate::"+wDate);

		String totVal_A = custSalesObj.getFieldValueString(i-1,"TOTPRICE");

		java.math.BigDecimal bd_totVal = new java.math.BigDecimal(totVal_A);
		bd_totVal = bd_totVal.setScale(2,java.math.BigDecimal.ROUND_HALF_UP);
%>
		<input type=hidden name="selCustCode" value="<%=formatDate.getStringFromDate(wDate,"/",FormatDate.MMDDYYYY)%>">
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
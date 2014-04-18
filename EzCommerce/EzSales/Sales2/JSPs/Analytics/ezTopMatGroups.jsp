<%@ page import="java.lang.*,java.sql.*" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/JSPs/NonCnet/iListNonCnetCategories.jsp"%>

<%
	ezc.ezparam.ReturnObjFromRetrieve custSalesObj = new ezc.ezparam.ReturnObjFromRetrieve(new String[]{"MATGROUP","TOTQTY"});
	//out.println("retCat"+retCat.toEzcString());
	Connection con = null;	
	java.sql.Statement stmt=null;

	try
	{
		String click="SELECT TOP 5 ESDI_MATERIAL_GROUP,SUM(ESDI_REQ_QTY) TOTAL_QTY FROM EZC_SALES_DOC_HEADER,EZC_SALES_DOC_ITEMS WHERE ESDI_SALES_DOC=ESDH_DOC_NUMBER GROUP BY ESDI_MATERIAL_GROUP ORDER BY TOTAL_QTY DESC";

		Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");
		con = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=ezastdev;SelectMethod=cursor","ezastdev","ezastdev");

		stmt = con.createStatement();
		ResultSet rs = stmt.executeQuery(click);

		String matGroup = "";
		String totQty = "";

		while(rs.next()) 
		{
			matGroup = rs.getString(1);
			totQty 	 = rs.getString(2);

			custSalesObj.setFieldValue("MATGROUP",matGroup);
			custSalesObj.setFieldValue("TOTQTY",totQty);
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

		
		var selMatGrpObj=document.myForm.selMatGrp;
		var selTotQtyObj=document.myForm.selTotQty;

		var sCust0 = eval("selMatGrpObj[0]").value;
		var sTot0 = parseInt(eval("selTotQtyObj[0]").value);

		var sCust1 = eval("selMatGrpObj[1]").value;
		var sTot1 = parseInt(eval("selTotQtyObj[1]").value);
		
		var sCust2 = eval("selMatGrpObj[2]").value;
		var sTot2 = parseInt(eval("selTotQtyObj[2]").value);

		/*var sCust3 = eval("selMatGrpObj[3]").value;
		var sTot3 = parseInt(eval("selTotQtyObj[3]").value);

		var sCust4 = eval("selMatGrpObj[4]").value;
		var sTot4 = parseInt(eval("selTotQtyObj[4]").value);*/

		var wrapper = new google.visualization.ChartWrapper({
			chartType: graphChng,
			dataTable: [['C6100',0],[sCust0,sTot0],[sCust1,sTot1],[sCust2,sTot2]],
			options: {width: 385, height: 175,'title': 'Product Groups Analytics',is3D:false},
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
        		<option value='line'>Line </option>
        		<option value='col' selected>Column </option>
        		<!--<option value='com'>Comparision </option>-->
        		</select>
		</Td>
<%
	for(int i=0;i<custSalesObj.getRowCount();i++)
	{
		String matGroup_A = custSalesObj.getFieldValueString(i,"MATGROUP");
		String totQty_A = custSalesObj.getFieldValueString(i,"TOTQTY");

		java.math.BigDecimal bd_totQty = new java.math.BigDecimal(totQty_A);
		bd_totQty = bd_totQty.setScale(2,java.math.BigDecimal.ROUND_HALF_UP);

		for(int j=0;j<retCat.getRowCount();j++)
		{
			String matGroupCnet=retCat.getFieldValueString(j,"EMM_FAMILY");

			if(matGroupCnet.equals(matGroup_A.trim()))
			{
%>		
				<input type=hidden name="selMatGrp" value="<%=retCat.getFieldValueString(j,"EMM_TYPE")%>">
<%
			}
		}	
%>	
				<input type=hidden name="selTotQty" value="<%=bd_totQty.toString()%>">
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

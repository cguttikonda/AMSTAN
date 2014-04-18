<%@ page import="java.lang.*,java.sql.*" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/JSPs/NonCnet/iListNonCnetCategories.jsp"%>


<%
	String uRole =(String)session.getValue("UserRole");
	//if("CU".equals(uRole))
	{
		java.util.ArrayList selCustCat = new java.util.ArrayList();
		EzCatalogParams catalogParams = new ezc.ezparam.EzCatalogParams();
		EzCustomerItemCatParams ecic = new EzCustomerItemCatParams();

		catalogParams.setType("GET_CUST");
		ecic.setSoldTo((String)session.getValue("AgentCode"));
		ecic.setExt1((String)session.getValue("SalesAreaCode"));
		catalogParams.setLocalStore("Y");
		catalogParams.setObject(ecic);
		Session.prepareParams(catalogParams);

		ReturnObjFromRetrieve retCustCat =(ReturnObjFromRetrieve)webCatalogObj.getCustomerCategories(catalogParams);

		if(retCustCat!=null && retCustCat.getRowCount()>0)
		{
			for(int k=0;k<retCustCat.getRowCount();k++)
			{
				selCustCat.add(retCustCat.getFieldValueString(k,"ECI_ITEMCAT"));
			}
		}
		if(retCatCnt>0)
		{
			for(int i=retCatCnt-1;i>=0;i--)
			{
				if(!selCustCat.contains(retCat.getFieldValueString(i,"EMM_FAMILY")))
					retCat.deleteRow(i);
			}
			retCatCnt = retCat.getRowCount();
		}
		//out.println(retCatCnt);
	}
	String prdGrp_C = request.getParameter("prdGrp");
	if(prdGrp_C=="" || "".equals(prdGrp_C) || "null".equals(prdGrp_C) || prdGrp_C==null)prdGrp_C="LUXURY";
	//out.println("prdGrp_C::::::"+prdGrp_C);

	ezc.ezparam.ReturnObjFromRetrieve custSalesObj = new ezc.ezparam.ReturnObjFromRetrieve(new String[]{"SOLDTO","MATGROUP","TOTQTY"});
	java.math.BigDecimal bd_Qty = new java.math.BigDecimal("0.00");

	Connection con = null;	
	java.sql.Statement stmt=null;

	if(prdGrp_C!=null && !"null".equalsIgnoreCase(prdGrp_C) && !"".equals(prdGrp_C))
	{
		try
		{
			String click="SELECT ESDH_SOLD_TO,ESDI_MATERIAL_GROUP,SUM(ESDI_REQ_QTY) TOTAL_QTY FROM EZC_SALES_DOC_HEADER,EZC_SALES_DOC_ITEMS WHERE ESDI_SALES_DOC=ESDH_DOC_NUMBER AND ESDH_SOLDTO_STATE='TX' AND ESDI_MATERIAL_GROUP='"+prdGrp_C+"' GROUP BY ESDH_SOLD_TO,ESDI_MATERIAL_GROUP";

			Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");
			con = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=ezastdev;SelectMethod=cursor","ezastdev","ezastdev");

			stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(click);

			String soldTo = "";
			String matGrp = "";
			String totQty = "";

			while(rs.next()) 
			{
				soldTo = rs.getString(1);
				matGrp = rs.getString(2);
				totQty = rs.getString(3);

				custSalesObj.setFieldValue("SOLDTO",soldTo);
				custSalesObj.setFieldValue("MATGROUP",matGrp);
				custSalesObj.setFieldValue("TOTQTY",totQty);
				custSalesObj.addRow();
				bd_Qty = bd_Qty.add(new java.math.BigDecimal(totQty));
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

	var selTotQty=''
	var selCustCode=''
	var selCustQty=''

	var graphChng=''
	var chartEditor = null;
	function drawVisualization()
	{

		graphChng=document.myForm.graph.value

		selTotQty=parseInt(document.myForm.selTotQty.value)
		if(selTotQty=='' || isNaN(selTotQty)) selTotQty=0

		selCustCode=document.myForm.selCustCode.value

		selCustQty=parseInt(document.myForm.selCustQty.value)
		if(selCustQty=='' || isNaN(selCustQty)) selCustQty=0

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

		var wrapper = new google.visualization.ChartWrapper({
			chartType: graphChng,
			dataTable: [['C6100',0],[selCustCode,selCustQty],['Total Sales',selTotQty]],
			options: {width: 385, height: 175,'title': 'Sales',is3D:false},
			containerId: 'vis_div'
			});
 		wrapper.draw();
	}
	google.setOnLoadCallback(drawVisualization);

	function getData()
	{
		var pGrp = document.myForm.prdGrp.value;
		document.myForm.action="ezSalesAnalysis.jsp?prdGrp="+pGrp;
		document.myForm.submit();
	}
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
        		<!--<option value='pie'>Pie </option>-->
        		<option value='line'>Line </option>
        		<option value='col'>Column </option>
        		<!--<option value='com'>Comparision </option>-->
        		</select>
        	</Td>
        </Tr>
        <Tr>
        	<Th>Select Product Group</Th>
        	<Td>
        		<select name ="prdGrp" onChange="getData()">
<%
			String catID = "",catDesc="";
			retCat.sort(new String[]{"EMM_TYPE"},true);
			for(int i=0;i<retCatCnt;i++)
			{
				catID = retCat.getFieldValueString(i,"EMM_FAMILY"); 
				catDesc = retCat.getFieldValueString(i,"EMM_TYPE");
				if(prdGrp_C!=null && prdGrp_C.equals(catID))
				{
%>
				<option value="<%=catID%>" selected><%=catDesc%></option>
<%
				}
				else
				{
%>
				<option value="<%=catID%>" ><%=catDesc%></option>
<%
				}
			}
%>
        		</select>
<%
			String custQty_A = "";
			String agentCode = (String)session.getValue("AgentCode");
			for(int i=0;i<custSalesObj.getRowCount();i++)
			{
				String soldTo_A = custSalesObj.getFieldValueString(i,"SOLDTO");
				if((agentCode.trim()).equalsIgnoreCase(soldTo_A.trim()))
				{
					custQty_A = custSalesObj.getFieldValueString(i,"TOTQTY");
					break;
				}
			}
%>
        		<input type=hidden name=selTotQty value="<%=bd_Qty.toString()%>">
			<input type=hidden name=selCustCode value="<%=agentCode.trim()%>">
			<input type=hidden name=selCustQty value="<%=custQty_A%>">

		</Td>
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
<%@page import="ezc.sapconnection.*"%>
<%@page import="com.sap.mw.jco.*"%>
<%@ page import="ezc.ezparam.*" %>
<%@ page import="ezc.sales.material.params.*" %>

<%@ page import= "ezc.ezbasicutil.*" %>
<%@ page import="ezc.ezparam.*,java.util.*"%>
<%//@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@ include file="../../../Includes/Lib/MaterialBean.jsp"%>

<%@ page import ="ezc.ezparam.*,ezc.ezsap.*" %>
<%@ page import="com.sap.mw.jco.*,java.util.*" %>
<%@ page import ="ezc.sapconnection.*,com.sap.mw.jco.*,com.sap.mw.jco.JCO" %>

<%
	String matNo = request.getParameter("matNo");
	String matDesc =request.getParameter("matDesc");
	String uom = request.getParameter("uom");
	String mfrId = request.getParameter("mfrId");
	String mfrPrNo = request.getParameter("mfrPrNo");
	String requiredQty = request.getParameter("requiredQty");
	String requiredDate =request.getParameter("requiredDate");
	String mfrName = request.getParameter("mfrName");

	String [] myRetCols = {"PROD_CODE","PROD_DESC","REQ_QTY","REQ_DATE","COMMIT_QTY","COMMIT_DATE","PLANT","QTY_AVAIL_PLANT"};
	ReturnObjFromRetrieve myRetObj = new ReturnObjFromRetrieve(myRetCols);

	ReturnObjFromRetrieve resultObj = new ReturnObjFromRetrieve(new String[]{"MATID","MATERIAL","BASE_UOM","PLANT","STATUS","AVAIL_QTY","ENDLEADTME","UPCNO","MFR_PART","MFR_NO","SAP_MATNR"});

	JCO.Client client1=null;
	JCO.Function function = null;
	JCO.ParameterList sapProc =null;

	try
	{
		client1 = EzSAPHandler.getSAPConnection("200~999");
		//function = EzSAPHandler.getFunction("BAPI_SALESORDER_CREATEFROMDAT2","200~999");
		//out.println("function>>>>>>"+function);

		function = EzSAPHandler.getFunction("Z_EZ_GET_MATERIAL_AVAILABILITY","200~999");
		sapProc = function.getImportParameterList();

		//sapProc.setValue(matNo,"MATERIAL");
		sapProc.setValue("BP01","PLANT");
		//sapProc.setValue(uom,"UNIT");

		sapProc.setValue("BP01","SALES_ORGANIZATION");
		sapProc.setValue("01","DISTRI_CHANNEL");
		sapProc.setValue("01","DIVISON");

		JCO.Table zmaterial = function.getTableParameterList().getTable("ZMATERIAL");

		zmaterial.appendRow();
		zmaterial.setValue("","MATID");
		zmaterial.setValue("","MATERIAL");
		zmaterial.setValue("","EAN11");
		//zmaterial.setValue(mfrPrNo,"MFRPN");
		//zmaterial.setValue(mfrId,"MFRNR");
		zmaterial.setValue(matNo,"MFRPN");
		zmaterial.setValue(mfrName.toUpperCase(),"MFRNR");
		
		//out.println("matNo>>>>>>"+matNo+"<<");
		//out.println("mfrName>>>>>>"+mfrName+"<<");

		client1.execute(function);

		JCO.Table result = function.getTableParameterList().getTable("RESULT");

		String mfr_part = null;
		if(result!=null)
		{
			if(result.getNumRows()>0)
			{
				do
				{
					//out.println(result.getValue("AVAIL_QTY"));

					resultObj.setFieldValue("MATID",result.getValue("MATID"));
					resultObj.setFieldValue("MATERIAL",result.getValue("MATERIAL"));
					resultObj.setFieldValue("BASE_UOM",result.getValue("BASE_UOM"));
					resultObj.setFieldValue("PLANT",result.getValue("PLANT"));
					resultObj.setFieldValue("STATUS",result.getValue("STATUS"));
					resultObj.setFieldValue("AVAIL_QTY",result.getValue("AVAIL_QTY"));
					resultObj.setFieldValue("ENDLEADTME",result.getValue("ENDLEADTME"));
					resultObj.setFieldValue("UPCNO",result.getValue("EAN11"));
					resultObj.setFieldValue("MFR_PART",result.getValue("MFRPN"));
					resultObj.setFieldValue("MFR_NO",result.getValue("MFRNR"));
					resultObj.setFieldValue("SAP_MATNR",result.getValue("MATERIAL"));
					mfr_part = (String)result.getValue("MFRPN");

					if(mfr_part == null || "null".equals(mfr_part) || "".equals(mfr_part.trim())){
						resultObj.setFieldValue("MATERIAL",result.getValue("MATERIAL"));
					}else{
						resultObj.setFieldValue("MATERIAL",result.getValue("MFRPN")); 
					}


					resultObj.addRow();
				}
				while(result.nextRow());	
			}
		} 
	}
	catch(Exception e)
	{
		System.out.println("EXCEPTION>>>>>>"+e);
	}
	finally
	{
		if(client1!=null)
		{
			JCO.releaseClient(client1);
			client1 = null;
			function=null;
		}
	}

	if(resultObj!=null)
	{
		for(int j=0;j<resultObj.getRowCount();j++)
		{
			if(!("0.000").equals(resultObj.getFieldValueString(j,"AVAIL_QTY")))
			{
				myRetObj.setFieldValue("PROD_CODE",matNo);
				myRetObj.setFieldValue("PROD_DESC",matDesc);
				myRetObj.setFieldValue("REQ_QTY","");
				myRetObj.setFieldValue("REQ_DATE","");
				myRetObj.setFieldValue("COMMIT_QTY",resultObj.getFieldValueString(j,"AVAIL_QTY"));
				myRetObj.setFieldValue("COMMIT_DATE","");
				myRetObj.setFieldValue("PLANT","BP01");
				myRetObj.setFieldValue("QTY_AVAIL_PLANT","");
				myRetObj.addRow();
				break;
			}
		}
	}

	int myRetObjCount=0;
	if(myRetObj!=null)
	myRetObjCount=myRetObj.getRowCount();

%>				
	
	<%
		/*
		String matNo =request.getParameter("matNo");
		String matDesc =request.getParameter("matDesc");
		String uom =  request.getParameter("uom");
		String requiredQty = request.getParameter("requiredQty");
		String requiredDate =request.getParameter("requiredDate");
		
		
	        
	       
	
		java.util.GregorianCalendar reqDateG =null;
		EzcMaterialParams ezMatParams = new EzcMaterialParams();
		EziMaterialParams eiMatParams = new EziMaterialParams();
		EzBapiwmdvsTable InputTable = new EzBapiwmdvsTable();
		EzBapiwmdvsTableRow InputTableRow = new EzBapiwmdvsTableRow();
	
		int mn = Integer.parseInt(requiredDate.substring(0,2));
		int dt = Integer.parseInt(requiredDate.substring(3,5));
		int yr = Integer.parseInt(requiredDate.substring(6,10));
		reqDateG = new java.util.GregorianCalendar(yr,mn-1,dt);
		
		//out.println("reqDateG:::"+reqDateG.getTime());
		
		InputTableRow.setReqDate(reqDateG.getTime());
		InputTableRow.setReqQty(new java.math.BigDecimal(requiredQty)); 
		InputTable.appendRow(InputTableRow);
	
		
		eiMatParams.setMaterial(matNo);
		eiMatParams.setUnit(uom);
		eiMatParams.setCheckRule("");
		eiMatParams.setWmdvsx(InputTable);
	
		String [] myRetCols = {"PROD_CODE","PROD_DESC","REQ_QTY","REQ_DATE","COMMIT_QTY","COMMIT_DATE","PLANT","QTY_AVAIL_PLANT"};
		ReturnObjFromRetrieve myRetObj = new ReturnObjFromRetrieve(myRetCols);
	
		Vector types = new Vector();
		Vector names = new Vector();
		ezc.ezparam.ReturnObjFromRetrieve ret = null;
		
		java.util.Locale l = new java.util.Locale("en","US");
		ezc.ezbasicutil.EzGlobal EzGlobalNew = new ezc.ezbasicutil.EzGlobal();
		EzGlobalNew.setDateFormat("MM.dd.yyyy");
		EzGlobalNew.setLocale(l);
		EzGlobalNew.setCurrencySymbol("$");
		EzGlobalNew.setIsPreSymbol(true);
		EzGlobalNew.setIsSymbolRequired(false);
		
			String plant="BP01";
			eiMatParams.setPlant(plant);
			ezMatParams.setObject(eiMatParams);	
			Session.prepareParams(ezMatParams);
			EzoMaterialParams eoMatParams = (EzoMaterialParams) EzcMaterialManager.getMaterialAvailability(ezMatParams);
			ReturnObjFromRetrieve Return = (ReturnObjFromRetrieve) eoMatParams.getReturn();
			ReturnObjFromRetrieve OutputTable = (ReturnObjFromRetrieve) eoMatParams.getMdve();
			//out.println("eoMatParams:::"+eoMatParams.toEzcString());
			//out.println("OutputTable:::"+OutputTable.toEzcString());
			int OutputTableCount=0;

			//this code is for globalization for open upto field
			types = new Vector();
			types.addElement("date");
			types.addElement("date");
			EzGlobalNew.setColTypes(types);
			names = new Vector();
			names.addElement("ReqDate");
			names.addElement("ComDate");
			EzGlobalNew.setColNames(names);
			ret = EzGlobalNew.getGlobal(OutputTable);
			String availQtyAtPlant=String.valueOf(eoMatParams.getAvQtyPlt());
			
			if(availQtyAtPlant==null||"null".equals(availQtyAtPlant))availQtyAtPlant="";
			
			if(OutputTable!=null)
			{
				OutputTableCount = OutputTable.getRowCount();
				for(int j=0;j<OutputTableCount;j++)
				{
					if(!("0.000").equals(OutputTable.getFieldValueString(j,"ComQty"))&&!("null".equals(OutputTable.getFieldValueString(j,"ReqQty"))))
					{
						
						myRetObj.setFieldValue("PROD_CODE",matNo);
						myRetObj.setFieldValue("PROD_DESC",matDesc);
						myRetObj.setFieldValue("REQ_QTY",OutputTable.getFieldValueString(j,"ReqQty"));
						myRetObj.setFieldValue("REQ_DATE",ret.getFieldValueString(j,"ReqDate"));
						//if(requiredDate.equals(ret.getFieldValueString(j,"ComDate")))
						myRetObj.setFieldValue("COMMIT_QTY",OutputTable.getFieldValueString(j,"ComQty"));
						//else myRetObj.setFieldValue("COMMIT_QTY","0");
						myRetObj.setFieldValue("COMMIT_DATE",ret.getFieldValueString(j,"ComDate"));
						myRetObj.setFieldValue("PLANT",plant);
						myRetObj.setFieldValue("QTY_AVAIL_PLANT",availQtyAtPlant);
						
						myRetObj.addRow();
						//availQtyAtPlant="0.000";
						break;
						
						
					}	
				}
			}
		
	
		
		
		int myRetObjCount=0;
		if(myRetObj!=null)
		myRetObjCount=myRetObj.getRowCount();
		
		*/
		
		
	
	%>
	
	
		
	
	<html>
	<head>
		<title>Check for ATP -- Answerthink</title>
		<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
	<script>
	function setBack()
	{
		window.close();
	}
	function setOk()
	{
		window.close();
	}
	</Script>
	</head>
	<body  scroll=auto> 
	<form method="post"  name="generalForm">
	<table align=center border="0" cellpadding="0" class="displayheaderback" cellspacing="0" width="100%">
		<tr>
			<td height="35" class="displayheader"  width="100%" align="center">Product Availability</td>
	
		</Tr>
		</Table>
	<br>
	<Table width="70%"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<tr> 
			<th colspan=2><%= matDesc %> (<%= uom %>) Availability </th>
		</tr>
		<tr> 
			<th width="40%" >Plant</th>
			
			<!--
				<th width="20%">Required Date</th>
				<th width="15%">Required Qty</th>
			
			<th width="25%">Tentative Commitment Date</th>
			<th width="25%">Tentative Commitment</th>
			-->
			<th width="60%">Avail Qty At Plant</th>
			
	
		</tr>
	<%
		
		boolean flag = true;
		//myRetObj.toEzcString();
		for ( int i = 0 ; i < myRetObjCount ; i++ )
		{
			String comQty = myRetObj.getFieldValueString(i,"COMMIT_QTY");
			
			
			//if(!("0.000").equals(comQty))
			if(Double.parseDouble(comQty) > 0 )
			{
				flag=false;
	%>
				 <tr>
					
					<Td width="40%" align="center"> <%= myRetObj.getFieldValue(i,"PLANT") %> </Td>
					<!--
					<Td width="20%" align="center"> <%//= myRetObj.getFieldValue(i,"REQ_DATE") %> </Td>
					<Td width="15%" align="right"> <%//= myRetObj.getFieldValue(i,"REQ_QTY") %></Td>
					<Td width="25%" align="center"> <%= myRetObj.getFieldValue(i,"COMMIT_DATE") %></Td>
					<Td width="25%" align="right"> <%= comQty %></Td>
					-->
					<Td width="60%" align="right"> <%= myRetObj.getFieldValue(i,"COMMIT_QTY") %></Td>
				</tr>
	<%		}
		}
		if(flag)
		{
	%>
			 <tr>
				<Td colspan="2" align="center">Not in Stock. Please call Sales Rep </Td>
			 </tr>
	<%	
		}
	%>
	</Table>	
	
	<br>
		<Table align="center">
		<Tr><Td align=center class=blankcell>
<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		buttonName.add("Close");
		buttonMethod.add("setBack()");
		out.println(getButtonStr(buttonName,buttonMethod));
%>	

		
		</Td></Tr></Table>
	</form>
	</body>
	</html>
	
	

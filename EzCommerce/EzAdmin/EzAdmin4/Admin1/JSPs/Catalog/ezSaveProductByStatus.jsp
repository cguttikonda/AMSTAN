<%//@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ page import = "ezc.ezcommon.*" %>
<%@ page import = "ezc.ezparam.*,ezc.sales.client.*" %>
<%@page import="javax.jms.*,java.util.*,javax.naming.*,java.io.*" %>
<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<%@ include file="../../../Includes/Lib/AdminUtilsBean.jsp"%>

<jsp:useBean id="catalogObj" class="ezc.client.EzCatalogManager" scope="page"></jsp:useBean>

<%
	String retMessage =""; 
	
   try{
	
	String strTemp[] 	= request.getParameterValues("chk1");
	String catalog		= request.getParameter("catalog");
	       
	ezc.ezparam.ReturnObjFromRetrieve myRetTemp = new ezc.ezparam.ReturnObjFromRetrieve(new String[]{"MATCODE","MATDESC","MANUFACT","PRICE","IMGPATH","STATUS","FAMILY","UPC","TYPE","COLOR","SIZE","LENGTH","WIDTH","UOM","FINISH","SPEC1","SPEC2","SPEC3","SPEC4","FUTUREPRICE","EFFECTIVEDATE","WEIGHT","WEIGHTUOM","LEADTIME","OPERATION"});
	String prdStr = "";
	

	for(int i=0;i<strTemp.length;i++)
	{
		
		//out.println("=======>"+strTemp[i]);
		ezc.ezbasicutil.EzStringTokenizer EzToken = new ezc.ezbasicutil.EzStringTokenizer(strTemp[i],"¥");
		java.util.Vector Tokens = EzToken.getTokens();	

		try{
			myRetTemp.setFieldValue("MATCODE",(String)Tokens.elementAt(0));
		}catch(Exception e){
			myRetTemp.setFieldValue("MATCODE","");
		}
		try{
			myRetTemp.setFieldValue("MATDESC",(String)Tokens.elementAt(1));
		}catch(Exception e){
			myRetTemp.setFieldValue("MATDESC","");
		}
		try{
			myRetTemp.setFieldValue("MANUFACT",(String)Tokens.elementAt(2));
		}catch(Exception e){
			myRetTemp.setFieldValue("MANUFACT","");
		}
		try{
			myRetTemp.setFieldValue("PRICE",(String)Tokens.elementAt(3));
		}catch(Exception e){
			myRetTemp.setFieldValue("PRICE","");
		}
		try{
			myRetTemp.setFieldValue("IMGPATH",(String)Tokens.elementAt(4));
		}catch(Exception e){
			myRetTemp.setFieldValue("IMGPATH","");
		}
		try{
			myRetTemp.setFieldValue("STATUS",(String)Tokens.elementAt(5));
		}catch(Exception e){
			myRetTemp.setFieldValue("STATUS","");
		}
		try{
			myRetTemp.setFieldValue("FAMILY",(String)Tokens.elementAt(6));
		}catch(Exception e){
			myRetTemp.setFieldValue("FAMILY","");
		}
		try{
			myRetTemp.setFieldValue("UPC",(String)Tokens.elementAt(7));
		}catch(Exception e){
			myRetTemp.setFieldValue("UPC","");
		}
		try{
			myRetTemp.setFieldValue("TYPE",(String)Tokens.elementAt(8));
		}catch(Exception e){
			myRetTemp.setFieldValue("TYPE","");
		}
		try{
			myRetTemp.setFieldValue("COLOR",(String)Tokens.elementAt(9));
		}catch(Exception e){
			myRetTemp.setFieldValue("COLOR","");
		}
		try{
			myRetTemp.setFieldValue("SIZE",(String)Tokens.elementAt(10));
		}catch(Exception e){
			myRetTemp.setFieldValue("SIZE","");
		}
		try{
			myRetTemp.setFieldValue("LENGTH",(String)Tokens.elementAt(11));
		}catch(Exception e){
			myRetTemp.setFieldValue("LENGTH","");
		}
		try{
			myRetTemp.setFieldValue("WIDTH",(String)Tokens.elementAt(12));
		}catch(Exception e){
			myRetTemp.setFieldValue("WIDTH","");
		}
		try{
			myRetTemp.setFieldValue("UOM",(String)Tokens.elementAt(13));
		}catch(Exception e){
			myRetTemp.setFieldValue("UOM","");
		}
		try{
			myRetTemp.setFieldValue("FINISH",(String)Tokens.elementAt(14));
		}catch(Exception e){
			myRetTemp.setFieldValue("FINISH","");
		}
		try{
			myRetTemp.setFieldValue("SPEC1",(String)Tokens.elementAt(15));
		}catch(Exception e){
			myRetTemp.setFieldValue("SPEC1","");
		}
		try{
			myRetTemp.setFieldValue("SPEC2",(String)Tokens.elementAt(16));
		}catch(Exception e){
			myRetTemp.setFieldValue("SPEC2","");
		}
		try{
			myRetTemp.setFieldValue("SPEC3",(String)Tokens.elementAt(17));
		}catch(Exception e){
			myRetTemp.setFieldValue("SPEC3","");
		}
		try{
			myRetTemp.setFieldValue("SPEC4",(String)Tokens.elementAt(18));
		}catch(Exception e){
			myRetTemp.setFieldValue("SPEC4","");
			
		}
		try{
			myRetTemp.setFieldValue("FUTUREPRICE",(String)Tokens.elementAt(19));
		}catch(Exception e){
			myRetTemp.setFieldValue("FUTUREPRICE","");
					
		}
		try{
			String effDate = (String)Tokens.elementAt(20);
			effDate = effDate.split("/")[1]+"/"+effDate.split("/")[0]+"/"+effDate.split("/")[2];
		
			myRetTemp.setFieldValue("EFFECTIVEDATE",effDate);
			
		}catch(Exception e){
			myRetTemp.setFieldValue("EFFECTIVEDATE","");

		}
		try{
			myRetTemp.setFieldValue("WEIGHT",(String)Tokens.elementAt(21));
		}catch(Exception e){
			myRetTemp.setFieldValue("WEIGHT","");
		
		}
		try{
			myRetTemp.setFieldValue("WEIGHTUOM",(String)Tokens.elementAt(22));
		}catch(Exception e){
			myRetTemp.setFieldValue("WEIGHTUOM","KG");

		}
		try{
			myRetTemp.setFieldValue("LEADTIME",(String)Tokens.elementAt(23));
		}catch(Exception e){
			myRetTemp.setFieldValue("LEADTIME","");

		}		
		try{
			myRetTemp.setFieldValue("OPERATION",(String)Tokens.elementAt(24));
		}catch(Exception e){
			myRetTemp.setFieldValue("OPERATION","N");

		}

		myRetTemp.addRow();

	}
	
	//out.println("=============>"+myRetTemp.toEzcString());
	
	int myRetTempCount = myRetTemp.getRowCount();
	
		

	EzbapimatTable ebmtAdd = new EzbapimatTable();
	EzbapimtdTable edmtAdd = new EzbapimtdTable();

	EzbapimatTableRow bapimatTableRowAdd = null;
	EzbapimtdTableRow bapimtdTableRowAdd = null;

	EzbapimatTable ebmtUpd = new EzbapimatTable();
	EzbapimtdTable edmtUpd = new EzbapimtdTable();

	EzbapimatTableRow bapimatTableRowUpd = null;
	EzbapimtdTableRow bapimtdTableRowUpd = null;



        java.math.BigDecimal setStdprice = null;
        java.math.BigDecimal setFutureprice = null; 
        java.math.BigDecimal setWeight = null; 
        java.math.BigDecimal setLeadTime = null; 
	
        for(int j=0;j<myRetTempCount;j++)
        {
	  
	  try
	  {
	     setStdprice = new java.math.BigDecimal(myRetTemp.getFieldValueString(j,"PRICE"));
	  
	  }
	  catch(Exception e)
	  {
	     setStdprice = new java.math.BigDecimal("0");
	   
	  }
	  try
	  {
	     setFutureprice = new java.math.BigDecimal(myRetTemp.getFieldValueString(j,"FUTUREPRICE"));

	  }
	  catch(Exception e)
	  {
	     setFutureprice = new java.math.BigDecimal("0");
	  	   
	  }
	  try
	  {
	     setWeight = new java.math.BigDecimal(myRetTemp.getFieldValueString(j,"WEIGHT"));

	  }
	  catch(Exception e)
	  {
	     setWeight = new java.math.BigDecimal("0");
	  	   
	  }
	  try
	  {
	     setLeadTime = new java.math.BigDecimal(myRetTemp.getFieldValueString(j,"LEADTIME"));

	  }
	  catch(Exception e)
	  {
	     setLeadTime = new java.math.BigDecimal("0");
	  	   
	  }	  
	  
	  
	  String oper = myRetTemp.getFieldValueString(j,"OPERATION");
	  if(oper!=null)oper=oper.trim();
	  if("A".equals(oper))
	  {
		  bapimatTableRowAdd = new EzbapimatTableRow();
		  bapimtdTableRowAdd = new EzbapimtdTableRow();

		  bapimatTableRowAdd.setCatalogNumber(catalog);
		  bapimatTableRowAdd.setMaterial(myRetTemp.getFieldValueString(j,"MATCODE"));
		  bapimatTableRowAdd.setManufacturer(myRetTemp.getFieldValueString(j,"MANUFACT"));
		  bapimatTableRowAdd.setStdprice(setStdprice);
		  bapimatTableRowAdd.setUofmeasure(myRetTemp.getFieldValueString(j,"UOM"));
		  bapimatTableRowAdd.setUpcno(myRetTemp.getFieldValueString(j,"UPC"));
		  bapimatTableRowAdd.setDelflag("N");
		  bapimatTableRowAdd.setHierarchy("");
		  bapimatTableRowAdd.setQuantity( new java.math.BigDecimal("0"));
		  bapimatTableRowAdd.setImagePath(myRetTemp.getFieldValueString(j,"IMGPATH"));
		  bapimatTableRowAdd.setStatus(myRetTemp.getFieldValueString(j,"STATUS"));
		  bapimatTableRowAdd.setFamily(myRetTemp.getFieldValueString(j,"TYPE"));
		  bapimatTableRowAdd.setType(myRetTemp.getFieldValueString(j,"TYPE"));
		  bapimatTableRowAdd.setColor(myRetTemp.getFieldValueString(j,"COLOR"));
		  bapimatTableRowAdd.setSize(myRetTemp.getFieldValueString(j,"SIZE"));
		  bapimatTableRowAdd.setLength(myRetTemp.getFieldValueString(j,"LENGTH"));
		  bapimatTableRowAdd.setWidth(myRetTemp.getFieldValueString(j,"WIDTH"));
		  bapimatTableRowAdd.setFinish(myRetTemp.getFieldValueString(j,"FINISH"));
		  bapimatTableRowAdd.setFutrePrice(setFutureprice); 
		  bapimatTableRowAdd.setEffectiveDate(myRetTemp.getFieldValueString(j,"EFFECTIVEDATE")); 
		  //bapimatTableRowAdd.setWeightNum(setWeight); 
		  //bapimatTableRowAdd.setWeightUOM(myRetTemp.getFieldValueString(j,"WEIGHTUOM")); 
		  bapimatTableRowAdd.setWeightNum(setWeight); 
		  bapimatTableRowAdd.setWeightUOM(myRetTemp.getFieldValueString(j,"WEIGHTUOM")); 		  
		  bapimatTableRowAdd.setLeadTime(setLeadTime); 

		  ebmtAdd.appendRow(bapimatTableRowAdd);

		  bapimtdTableRowAdd.setMaterial(myRetTemp.getFieldValueString(j,"MATCODE"));
		  bapimtdTableRowAdd.setLang("EN");
		  bapimtdTableRowAdd.setMatdesc(myRetTemp.getFieldValueString(j,"MATDESC"));  
		  bapimtdTableRowAdd.setSpec1(myRetTemp.getFieldValueString(j,"SPEC1")); 
		  bapimtdTableRowAdd.setSpec2(myRetTemp.getFieldValueString(j,"SPEC2")); 
		  bapimtdTableRowAdd.setSpec3(myRetTemp.getFieldValueString(j,"SPEC3")); 
		  bapimtdTableRowAdd.setSpec4(myRetTemp.getFieldValueString(j,"SPEC4"));


		  edmtAdd.appendRow(bapimtdTableRowAdd);
	  }	  
	  else if("U".equals(oper))
	  {

		  bapimatTableRowUpd = new EzbapimatTableRow();
		  bapimtdTableRowUpd = new EzbapimtdTableRow();

		  bapimatTableRowUpd.setCatalogNumber(catalog);
		  bapimatTableRowUpd.setMaterial(myRetTemp.getFieldValueString(j,"MATCODE"));
		  bapimatTableRowUpd.setStdprice(setStdprice);
		  bapimatTableRowUpd.setImagePath(myRetTemp.getFieldValueString(j,"IMGPATH"));
		  bapimatTableRowUpd.setType("P");

		  ebmtUpd.appendRow(bapimatTableRowUpd);

		  bapimtdTableRowUpd.setMaterial(myRetTemp.getFieldValueString(j,"MATCODE"));
		  bapimtdTableRowUpd.setSpec1(myRetTemp.getFieldValueString(j,"SPEC1")); 
		  bapimtdTableRowUpd.setSpec2(myRetTemp.getFieldValueString(j,"SPEC2")); 
		  bapimtdTableRowUpd.setSpec3(myRetTemp.getFieldValueString(j,"SPEC3")); 
		  bapimtdTableRowUpd.setSpec4(myRetTemp.getFieldValueString(j,"SPEC4"));


		  edmtUpd.appendRow(bapimtdTableRowUpd);


	  
	  }
	  else if("D".equals(oper))
	  {
	  	prdStr += myRetTemp.getFieldValueString(j,"MATCODE") + "','"; 
	  }
	  else
	  {
	  
	  }
        }

	EzProdSyncParams prodSyncParams = null;
	EzCatalogParams catalogParams = null;
	
	
	if(ebmtAdd!=null && ebmtAdd.getRowCount()>0)
	{
		prodSyncParams = new EzProdSyncParams();
		catalogParams = new EzCatalogParams();

		prodSyncParams.setSysKey("999001");
		prodSyncParams.setMaterialTable(ebmtAdd);
		prodSyncParams.setMaterialDescTable(edmtAdd);
		catalogParams.setSysKey("999001");
		catalogParams.setLanguage("EN");
		catalogParams.setObject(prodSyncParams);
		catalogParams.setLocalStore("Y");
		Session.prepareParams(catalogParams);
		catalogObj.synchronize(catalogParams);
	}	
	
	if(ebmtUpd!=null && ebmtUpd.getRowCount()>0)
	{
		prodSyncParams = new EzProdSyncParams();
		catalogParams = new EzCatalogParams();

		prodSyncParams.setSysKey("999101");
		prodSyncParams.setMaterialTable(ebmtUpd);
		prodSyncParams.setMaterialDescTable(edmtUpd);
		catalogParams.setSysKey("999101");
		catalogParams.setLanguage("EN");
		catalogParams.setIndicator("UPLOAD");
		catalogParams.setObject(prodSyncParams);
		catalogParams.setLocalStore("Y");
		Session.prepareParams(catalogParams);
		catalogObj.updateMaterialMaster(catalogParams);
	}	
	
	if(!"".equals(prdStr) && prdStr.indexOf(",")>0)
	{
		prdStr = prdStr.substring(0,prdStr.length()-3);
		
		//out.println("prdStr=============>"+prdStr);
		EziMaterialSearchParams searchParams = new EziMaterialSearchParams();
		searchParams.setCatalog(catalog);
		searchParams.setMaterialCode(prdStr);
		searchParams.setSearchType("GET_BY_CAT_MAT");
		EzcParams mainParams = new EzcParams(false);
		mainParams.setObject(searchParams);
		Session.prepareParams(mainParams);
		ReturnObjFromRetrieve retCatMats = (ReturnObjFromRetrieve)AUM.searchMaterials(mainParams);
		if(retCatMats!=null && retCatMats.getRowCount()>0)
		{
			String matIds = "'";
			for(int i=0;i<retCatMats.getRowCount();i++)
			{
				    matIds+=retCatMats.getFieldValueString(i,"EMM_ID")+"','" ;
			}
			if(matIds.indexOf(",")>0)
				matIds = matIds.substring(0,matIds.length()-2);
			
			//out.println("matIds=============>"+matIds);
			
			EzSalesOrderManager ezManager=new EzSalesOrderManager();
			EzcParams ezcParams=new EzcParams(false);
			EzCatalogParams catParams = new EzCatalogParams();

			catParams.setType("S");
			catParams.setMatId(matIds);
			catParams.setCatalogNumber("'"+catalog+"'");
			ezcParams.setObject(catParams);
			Session.prepareParams(ezcParams);
			Object o = ezManager.ezDeleteMatSynch(ezcParams);
		}		
	}	
	

	
       
   }catch(Exception e){
     System.out.println("Exception occured while uploading data");
   }
%>
<html>
<head>
<title>Message</title>
<%@include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Script>
		
	function DisableRightButton()
	{	
	}
	
	function funOK()
	{
		document.myForm.action="../Config/ezListSystems.jsp";
		document.myForm.submit();
	}
	
</Script>	
</head>
<body onContextMenu="DisableRightButton(); return false" bgcolor="#FFFFF7">
<form name="myForm" method="post">
<br><br><br><br>
<table width="50%" align="center" border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0>
	<tr align="center">
		<th>Products uploaded Successfully</th>
	</tr>
</table>
<br><br><br><br>
<center>
	<img src="../../Images/Buttons/<%=ButtonDir%>/ok.gif" style="cursor:hand" border=none onClick="funOK()"> 
</center>
<Div id="MenuSol"></Div>
</form>
</body>
</html>
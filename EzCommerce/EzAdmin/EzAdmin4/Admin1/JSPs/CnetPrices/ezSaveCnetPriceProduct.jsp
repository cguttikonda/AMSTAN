<%//@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ page import = "ezc.ezcommon.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@page import="javax.jms.*,java.util.*,javax.naming.*,java.io.*" %>
<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<jsp:useBean id="MaterialMgr" class="ezc.sales.material.client.EzcMaterialManager" scope="page"></jsp:useBean>

<%
	String retMessage =""; 
	
   try{
	
	String strTemp[] 	= request.getParameterValues("chk1");
	       
	ezc.ezparam.ReturnObjFromRetrieve myRetTemp = new ezc.ezparam.ReturnObjFromRetrieve(new String[]{"ECP_MATERIAL","ECP_MFR_NAME","ECP_MFR_NO","ECP_PRICE","ECP_FUTURE_PRICE","ECP_EFFECTIVE_DATE"});
	

	

	for(int i=0;i<strTemp.length;i++)
	{
		ezc.ezbasicutil.EzStringTokenizer EzToken = new ezc.ezbasicutil.EzStringTokenizer(strTemp[i],"¥");
		java.util.Vector Tokens = EzToken.getTokens();	

		try{
			myRetTemp.setFieldValue("ECP_MATERIAL",(String)Tokens.elementAt(0));
		}catch(Exception e){
			myRetTemp.setFieldValue("ECP_MATERIAL","");
		}
		try{
			myRetTemp.setFieldValue("ECP_MFR_NAME",(String)Tokens.elementAt(1));
		}catch(Exception e){
			myRetTemp.setFieldValue("ECP_MFR_NAME","");
		}
		try{
			myRetTemp.setFieldValue("ECP_MFR_NO",(String)Tokens.elementAt(2));
		}catch(Exception e){
			myRetTemp.setFieldValue("ECP_MFR_NO","");
		}
		try{
			myRetTemp.setFieldValue("ECP_PRICE",(String)Tokens.elementAt(3));
		}catch(Exception e){
			myRetTemp.setFieldValue("ECP_PRICE","");
		}
		myRetTemp.setFieldValue("ECP_FUTURE_PRICE","0");
		myRetTemp.setFieldValue("ECP_EFFECTIVE_DATE","01/01/2999");
		myRetTemp.addRow();

	}
	
	
	
	int myRetTempCount = myRetTemp.getRowCount();
	
		
	EzProdSyncParams prodSyncParams = new EzProdSyncParams();
	ezc.sales.material.params.EzcMaterialParams matParams = new ezc.sales.material.params.EzcMaterialParams();

	EzbapimatTable ebmt = new EzbapimatTable();
	EzbapimatTableRow bapimatTableRow = null;

        java.math.BigDecimal setStdprice = null;
	
        for(int j=0;j<myRetTempCount;j++)
        {
	  
	  try
	  {
	     setStdprice = new java.math.BigDecimal(myRetTemp.getFieldValueString(j,"ECP_PRICE"));
	  
	  }
	  catch(Exception e)
	  {
	     setStdprice = new java.math.BigDecimal("0");
	   
	  }
	  
	  bapimatTableRow = new EzbapimatTableRow();
	
	  bapimatTableRow.setMaterial(myRetTemp.getFieldValueString(j,"ECP_MATERIAL"));
	  bapimatTableRow.setManufacturer(myRetTemp.getFieldValueString(j,"ECP_MFR_NAME"));
	  bapimatTableRow.setMatId(myRetTemp.getFieldValueString(j,"ECP_MFR_NO"));
	  bapimatTableRow.setStdprice(setStdprice);
	  bapimatTableRow.setFutrePrice(new java.math.BigDecimal("0"));
	  bapimatTableRow.setEffectiveDate("01/01/2999");
	  	  
	  ebmt.appendRow(bapimatTableRow);
	
	  
        }
        
        prodSyncParams.setSysKey("999101");
	prodSyncParams.setMaterialTable(ebmt);
	matParams.setObject(prodSyncParams);
	matParams.setSysKey("999101");
	matParams.setLocalStore("Y");
	Session.prepareParams(matParams);
	
	java.util.Date data2 = new java.util.Date();
	//out.println("====>"+data2.getHours()+":"+data2.getMinutes()+":"+data2.getSeconds());

	
	MaterialMgr.ezMaintainCNETPrices(matParams);
   }catch(Exception e){
     System.out.println("Exception occured while uploading data");
   }
   
   java.util.Date data1 = new java.util.Date();
   	//out.println("====>"+data1.getHours()+":"+data1.getMinutes()+":"+data1.getSeconds());

	
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
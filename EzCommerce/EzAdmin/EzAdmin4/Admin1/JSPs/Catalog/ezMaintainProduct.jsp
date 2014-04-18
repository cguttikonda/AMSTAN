<%//@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ page import = "ezc.ezcommon.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<jsp:useBean id="catalogObj" class="ezc.client.EzCatalogManager" scope="page"></jsp:useBean>

<%
	String retMessage ="";
	
	
	
	
   try{
	
	String strTemp[] 	= request.getParameterValues("chk1");
	String catalog		= request.getParameter("catalog");
	String priceFlg         = request.getParameter("price");
	String imageFlg         = request.getParameter("image");
	
	String updateFlg ="";
	
	if("P".equals(priceFlg)&&"I".equals(imageFlg)){
		updateFlg="B";
	}else if("P".equals(priceFlg)){
		updateFlg="P";
	}else if("I".equals(priceFlg)){ 
		updateFlg="I";
	}
	
	updateFlg = "P";
	       
	ezc.ezparam.ReturnObjFromRetrieve myRetTemp = new ezc.ezparam.ReturnObjFromRetrieve(new String[]{"MATCODE","PRICE","IMAGE_PATH","SPEC1","SPEC2","SPEC3","SPEC4"});
	
	

	for(int i=0;i<strTemp.length;i++)
	{
		ezc.ezbasicutil.EzStringTokenizer EzToken = new ezc.ezbasicutil.EzStringTokenizer(strTemp[i],"$$");
		java.util.Vector Tokens = EzToken.getTokens();	

		myRetTemp.setFieldValue("MATCODE",(String)Tokens.elementAt(0));
		myRetTemp.setFieldValue("PRICE",(String)Tokens.elementAt(1));
		myRetTemp.setFieldValue("IMAGE_PATH",(String)Tokens.elementAt(2));
		myRetTemp.setFieldValue("SPEC1",(String)Tokens.elementAt(3));
		myRetTemp.setFieldValue("SPEC2",(String)Tokens.elementAt(4));
		myRetTemp.setFieldValue("SPEC3",(String)Tokens.elementAt(5));
		myRetTemp.setFieldValue("SPEC4",(String)Tokens.elementAt(6));
		myRetTemp.addRow();

	}
	
	int myRetTempCount = myRetTemp.getRowCount();
	
		
	EzProdSyncParams prodSyncParams = new EzProdSyncParams();
	EzCatalogParams catalogParams = new EzCatalogParams();

	EzbapimatTable ebmt = new EzbapimatTable();
	EzbapimatTableRow bapimatTableRow = null;
	
	EzbapimtdTable ebmd = new EzbapimtdTable();
	EzbapimtdTableRow bapimtdTableRow = null;
	

        java.math.BigDecimal setStdprice = null;
        String imagePath =null;
        String priceStr = null;
        String spec1 =null;
        String spec2 =null;
        String spec3 =null;
        String spec4 =null;
	
        for(int j=0;j<myRetTempCount;j++)
        {
        
          setStdprice = null;
          imagePath =myRetTemp.getFieldValueString(j,"IMAGE_PATH");
          priceStr = myRetTemp.getFieldValueString(j,"PRICE");
          spec1 =myRetTemp.getFieldValueString(j,"SPEC1");
          spec2 =myRetTemp.getFieldValueString(j,"SPEC2");
          spec3 =myRetTemp.getFieldValueString(j,"SPEC3");
          spec4 =myRetTemp.getFieldValueString(j,"SPEC4");
          
          if(imagePath==null || "null".equals(imagePath)) imagePath ="";
          else imagePath = imagePath.trim();
          
          if(priceStr==null || "null".equals(priceStr)) priceStr ="";
          else priceStr = priceStr.trim();
          
          if(spec1==null || "null".equals(spec1)) spec1 ="";
          else spec1 = spec1.trim();
          
          if(spec2==null || "null".equals(spec2)) spec2 ="";
          else spec2 = spec2.trim();
          
          if(spec3==null || "null".equals(spec3)) spec3 ="";
          else spec3 = spec3.trim();
          
          if(spec4==null || "null".equals(spec4)) spec4 ="";
          else spec4 = spec4.trim();
          
                  
          bapimatTableRow = new EzbapimatTableRow();
          bapimtdTableRow = new EzbapimtdTableRow();
          
         
          bapimatTableRow.setCatalogNumber(catalog);
	  bapimatTableRow.setMaterial(myRetTemp.getFieldValueString(j,"MATCODE"));
	  
	  bapimtdTableRow.setMaterial(myRetTemp.getFieldValueString(j,"MATCODE"));
	  
	  
	  if(!"".equals(priceStr)){
		  try  {
		     setStdprice = new java.math.BigDecimal(myRetTemp.getFieldValueString(j,"PRICE"));

		  } catch(Exception e)  {
		     setStdprice = new java.math.BigDecimal("0");

		  }
		  bapimatTableRow.setStdprice(setStdprice);
	  } 
	  
	  if(!"".equals(imagePath)){
	  	bapimatTableRow.setImagePath(imagePath);
	  }
	  
	  if(!"".equals(spec1)){
	  	bapimtdTableRow.setSpec1(spec1);
	  }
	  if(!"".equals(spec2)){
	  	bapimtdTableRow.setSpec2(spec2);
	  }
	  if(!"".equals(spec3)){
	  	bapimtdTableRow.setSpec3(spec3);
	  }
	  if(!"".equals(spec4)){
	  	bapimtdTableRow.setSpec4(spec4);
	  }
	
	
	  
	  bapimatTableRow.setType(updateFlg);
	  ebmt.appendRow(bapimatTableRow);
	  ebmd.appendRow(bapimtdTableRow);
	
		  
        }
        
        prodSyncParams.setSysKey("999001");
	prodSyncParams.setMaterialTable(ebmt);
	prodSyncParams.setMaterialDescTable(ebmd);
	catalogParams.setSysKey("999101");
	catalogParams.setLanguage("EN");
	catalogParams.setObject(prodSyncParams);
	catalogParams.setIndicator("UPLOAD");
	catalogParams.setLocalStore("Y");
	Session.prepareParams(catalogParams);
	
	catalogObj.updateMaterialMaster(catalogParams);
       
   }catch(Exception e){ }
	
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
		<th>Products updated Successfully</th>
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
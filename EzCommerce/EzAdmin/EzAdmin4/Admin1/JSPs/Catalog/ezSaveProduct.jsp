<%//@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ page import = "ezc.ezcommon.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@page import="javax.jms.*,java.util.*,javax.naming.*,java.io.*" %>
<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<jsp:useBean id="catalogObj" class="ezc.client.EzCatalogManager" scope="page"></jsp:useBean>

<%
	String retMessage =""; 
	
   try{
	
	String strTemp[] 	= request.getParameterValues("chk1");
	String catalog		= request.getParameter("catalog");
	       
	ezc.ezparam.ReturnObjFromRetrieve myRetTemp = new ezc.ezparam.ReturnObjFromRetrieve(new String[]{"MATCODE","MATDESC","MANUFACT","PRICE","IMGPATH","STATUS","FAMILY","UPC","TYPE","COLOR","SIZE","LENGTH","WIDTH","UOM","FINISH","SPEC1","SPEC2","SPEC3","SPEC4"});
	
	

	for(int i=0;i<strTemp.length;i++)
	{
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
		myRetTemp.addRow();

	}
	
	
	
	int myRetTempCount = myRetTemp.getRowCount();
	
		
	EzProdSyncParams prodSyncParams = new EzProdSyncParams();
	EzCatalogParams catalogParams = new EzCatalogParams();

	EzbapimatTable ebmt = new EzbapimatTable();
	EzbapimtdTable edmt = new EzbapimtdTable();

	EzbapimatTableRow bapimatTableRow = null;
	EzbapimtdTableRow bapimtdTableRow = null;

        java.math.BigDecimal setStdprice = null;
	
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
	  
	  bapimatTableRow = new EzbapimatTableRow();
	  bapimtdTableRow = new EzbapimtdTableRow();
	
	  bapimatTableRow.setCatalogNumber(catalog);
	  bapimatTableRow.setMaterial(myRetTemp.getFieldValueString(j,"MATCODE"));
	  bapimatTableRow.setManufacturer(myRetTemp.getFieldValueString(j,"MANUFACT"));
	  bapimatTableRow.setStdprice(setStdprice);
	  bapimatTableRow.setUofmeasure(myRetTemp.getFieldValueString(j,"UOM"));
	  bapimatTableRow.setUpcno(myRetTemp.getFieldValueString(j,"UPC"));
	  bapimatTableRow.setDelflag("N");
	  bapimatTableRow.setHierarchy("");
	  bapimatTableRow.setQuantity( new java.math.BigDecimal("0"));
	  bapimatTableRow.setImagePath(myRetTemp.getFieldValueString(j,"IMGPATH"));
	  bapimatTableRow.setStatus(myRetTemp.getFieldValueString(j,"STATUS"));
	  bapimatTableRow.setFamily(myRetTemp.getFieldValueString(j,"FAMILY"));
	  bapimatTableRow.setType(myRetTemp.getFieldValueString(j,"TYPE"));
	  bapimatTableRow.setColor(myRetTemp.getFieldValueString(j,"COLOR"));
	  bapimatTableRow.setSize(myRetTemp.getFieldValueString(j,"SIZE"));
	  bapimatTableRow.setLength(myRetTemp.getFieldValueString(j,"LENGTH"));
	  bapimatTableRow.setWidth(myRetTemp.getFieldValueString(j,"WIDTH"));
	  bapimatTableRow.setFinish(myRetTemp.getFieldValueString(j,"FINISH"));
	  
	  bapimatTableRow.setFutrePrice(new java.math.BigDecimal("0"));
	  bapimatTableRow.setEffectiveDate("01/01/2999");
	  	  
	  ebmt.appendRow(bapimatTableRow);
	
	  bapimtdTableRow.setMaterial(myRetTemp.getFieldValueString(j,"MATCODE"));
	  bapimtdTableRow.setLang("EN");
	  bapimtdTableRow.setMatdesc(myRetTemp.getFieldValueString(j,"MATDESC"));  
	  bapimtdTableRow.setSpec1(myRetTemp.getFieldValueString(j,"SPEC1")); 
	  bapimtdTableRow.setSpec2(myRetTemp.getFieldValueString(j,"SPEC2")); 
	  bapimtdTableRow.setSpec3(myRetTemp.getFieldValueString(j,"SPEC3")); 
	  bapimtdTableRow.setSpec4(myRetTemp.getFieldValueString(j,"SPEC4")); 
	  
	  edmt.appendRow(bapimtdTableRow);
	  
        }
        
        prodSyncParams.setSysKey("999001");
	prodSyncParams.setMaterialTable(ebmt);
	prodSyncParams.setMaterialDescTable(edmt);
	catalogParams.setSysKey("999001");
	catalogParams.setLanguage("EN");
	catalogParams.setObject(prodSyncParams);
	catalogParams.setLocalStore("Y");
	Session.prepareParams(catalogParams);
	
	java.util.Date data2 = new java.util.Date();
	//out.println("====>"+data2.getHours()+":"+data2.getMinutes()+":"+data2.getSeconds());

	
	catalogObj.synchronize(catalogParams);
	
	
	
	/*try{
		    String CTXFACT = "com.sap.engine.services.jndi.InitialContextFactoryImpl";
		    String PROVIDERURL = "localhost";
		    String DESTFACT =  "java:comp/env/InstToolTopicFactoryFinishImage";
		    String TOPICNAME = "java:comp/env/InstToolTopicFinishImage";
	
		    Properties properties = new Properties();
		    properties.put("java.naming.factory.initial", CTXFACT);
		    properties.put("java.naming.provider.url", PROVIDERURL);
		    InitialContext initialcontext = new InitialContext(properties);
	
		    TopicConnectionFactory topicconnectionfactory = (TopicConnectionFactory)initialcontext.lookup(DESTFACT);
		    
		    out.println("topicconnectionfactory========>"+topicconnectionfactory);
		    TopicConnection topicconnection = topicconnectionfactory.createTopicConnection();
		    out.println("topicconnection========>"+topicconnection);
		    TopicSession topicsession = topicconnection.createTopicSession(false, 1);
		    out.println("topicsession========>"+topicsession);
		    Topic topic = (Topic)initialcontext.lookup(TOPICNAME);
		    out.println("topic========>"+topic);
		    TopicPublisher topicpublisher = topicsession.createPublisher(topic);
		    out.println("topicpublisher========>"+topicpublisher);
		    ObjectMessage objectmessage = topicsession.createObjectMessage();
		    objectmessage.setObject(catalogParams);
		    topicpublisher.publish(objectmessage);
		    
	}catch(Exception err){
			out.println("==========>"+err);
	}*/
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
       
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
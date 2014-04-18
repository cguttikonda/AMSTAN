<%@ page import = "ezc.ezcommon.*" %>
<%@ page import = "ezc.ezparam.*,ezc.sales.client.*" %>
<%@ page import="javax.jms.*,java.util.*,javax.naming.*,java.io.*" %>
<%@ page import="ezc.ezparam.*" %>
<%@ page import="ezc.ezparam.ReturnObjFromRetrieve" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>

<jsp:useBean id="catalogObj" class="ezc.client.EzCatalogManager" scope="page"></jsp:useBean>



<head>
	<Script>
	function uploadAgain()
	{								      
	   document.myForm.action="ezPreUploadCart.jsp"; 
	   document.myForm.target="_self";
	   document.myForm.submit();       
	}
	
	function downloadErr()
	{								      
	   document.myForm.action="ezDownLoadERR.jsp"; 
	   document.myForm.target="_self";
	   document.myForm.submit();       
	}
	</Script>
	
</head>

<Body> 
<div class="main-container col2-layout middle account-pages">
<div class="main">
<div class="col-main1" style='width:750px;height:250px;'>

<div class="page-title">
<Form name="myForm" method="post">
<h2>Items to Cart</h2> 	
</div>

<%
	String retMessage =""; 
	int strTempLen = 0;
	ezc.ezparam.ReturnObjFromRetrieve myRetTemp = null;
	ezc.ezparam.ReturnObjFromRetrieve myRetERR = null;
	
   try{
	
	String strTemp[] 	= request.getParameterValues("chk1");
	       
	myRetTemp = new ezc.ezparam.ReturnObjFromRetrieve(new String[]{"MATCODE","QTY","MYPO","MYSKU","QUOTENO","QUOTELINE"});
	myRetERR  = new ezc.ezparam.ReturnObjFromRetrieve(new String[]{"MATCODE_ERR","QTY_ERR","MYPO_ERR","MYSKU_ERR","QUOTE_NO","QUOTE_LINE","REASON"});
	String prdStr = "";
	strTempLen= strTemp.length;

	for(int i=0;i<strTemp.length;i++)
	{
		
		out.println("=======>"+strTemp[i]);
		ezc.ezbasicutil.EzStringTokenizer EzToken = new ezc.ezbasicutil.EzStringTokenizer(strTemp[i],"¥");
		java.util.Vector Tokens = EzToken.getTokens();	

		try{
			myRetTemp.setFieldValue("MATCODE",(String)Tokens.elementAt(0));
		}catch(Exception e){
			myRetTemp.setFieldValue("MATCODE","");
		}		
		try{
			myRetTemp.setFieldValue("QTY",(String)Tokens.elementAt(1));
		}catch(Exception e){
			myRetTemp.setFieldValue("QTY","");		
		}		
		/*try{
			String desDate = (String)Tokens.elementAt(2);
			desDate = desDate.split("/")[1]+"/"+desDate.split("/")[0]+"/"+desDate.split("/")[2];
		
			myRetTemp.setFieldValue("DESIREDDATE",desDate);
			
		}catch(Exception e){
			myRetTemp.setFieldValue("DESIREDDATE","");

		}
		try{
			myRetTemp.setFieldValue("PROGRAMTYPE",(String)Tokens.elementAt(3));
		}catch(Exception e){
			myRetTemp.setFieldValue("PROGRAMTYPE","");
		
		}*/
		try{
			myRetTemp.setFieldValue("MYPO",(String)Tokens.elementAt(2));
		}catch(Exception e){
			myRetTemp.setFieldValue("MYPO","");

		}
		try{
			myRetTemp.setFieldValue("MYSKU",(String)Tokens.elementAt(3));
		}catch(Exception e){
			myRetTemp.setFieldValue("MYSKU","");

		}	
		try{
			myRetTemp.setFieldValue("QUOTENO",(String)Tokens.elementAt(4));
		}catch(Exception e){
			myRetTemp.setFieldValue("QUOTENO","");
		
		}	
		try{
			myRetTemp.setFieldValue("QUOTELINE",(String)Tokens.elementAt(5));
		}catch(Exception e){
			myRetTemp.setFieldValue("QUOTELINE","");

		}	
		
		myRetTemp.addRow();
	}
	
	//out.println("=============>"+myRetTemp.toEzcString());
	
	       
   }catch(Exception e){
     System.out.println("Exception occured while uploading data");
   }
      	
   	for(int u=0;u<myRetTemp.getRowCount();u++)
	{
	
		String matCodeUP   = myRetTemp.getFieldValueString(u,"MATCODE");
		String quantity    = myRetTemp.getFieldValueString(u,"QTY");		
		//String desireDate  = myRetTemp.getFieldValueString(u,"DESIREDDATE");
		//String progType    = myRetTemp.getFieldValueString(u,"PROGRAMTYPE");		
		String prodSku	   = myRetTemp.getFieldValueString(u,"MYSKU");
		String poLine	   = myRetTemp.getFieldValueString(u,"MYPO");
		String quoteNo	   = myRetTemp.getFieldValueString(u,"QUOTENO");
		String quoteLine   = myRetTemp.getFieldValueString(u,"QUOTELINE");
%>
<%@ include file="ezAddCartUpload.jsp"%>

<%	
		if(!"Y".equals(notAddedUP))
		{
			--strTempLen;
			myRetERR.setFieldValue("MATCODE_ERR",matCodeUP);
			myRetERR.setFieldValue("QTY_ERR",quantity);
			//myRetERR.setFieldValue("DESIREDDATE_ERR",desireDate);
			//myRetERR.setFieldValue("PROGRAMTYPE_ERR",progType);
			myRetERR.setFieldValue("MYPO_ERR",poLine);
			myRetERR.setFieldValue("MYSKU_ERR",prodSku);
			myRetERR.setFieldValue("QUOTE_NO",quoteNo);
			myRetERR.setFieldValue("QUOTE_LINE",quoteLine);
			
			if("NS".equals(notAddedUP))
				myRetERR.setFieldValue("REASON","No Stock Available");
			else if("RE".equals(notAddedUP)) 
				myRetERR.setFieldValue("REASON","Retail Exclusive");
			else 
				myRetERR.setFieldValue("REASON","Product Not Available");
			
			myRetERR.addRow();		
		}							
	}		
%>

<br>

<%	if(myRetERR!=null && myRetERR.getRowCount()>0)
	{
	
		session.putValue("myRetERRSes",myRetERR);
%>	
		<h2> <font color=green> <%=strTempLen%></font>&nbsp; Items Successfully Added to Cart.</h2>
		<br>
	
		<a href="JavaScript:downloadErr()"><h2><span>Click Here</span></a> to check the items which are not saved to Cart.</h2>
		<br>
		<!--<h3>Rest of the Items Successfully Added to Cart.</h3> -->

<%	}
	else
	{
%>
	<h2>Items Successfully Added to Cart.</h2>
	
<%	}
	
%>

<br><br>
<div>
	<ul>
	<li>
		<!--<a href="JavaScript:uploadAgain()"><span>Click Here</span></a> to upload some more...-->
		
		<input type="button" onClick="uploadAgain()" value="Upload Again">
		<input type="button" onClick="self.close()" value="Close">
		

	</li>
	</ul>
</div>


</Form>
</div> <!-- col-main -->
</div> <!--main -->
</div> <!-- main-container col1-layout -->

</Body>


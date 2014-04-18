<%@ page import="ezc.sales.material.params.*" %>
<%@ page import= "ezc.ezparam.*,ezc.ezbasicutil.*" %>
<%@ page import = "ezc.ezutil.FormatDate" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<jsp:useBean id="EzcMaterialManager" class="ezc.sales.material.client.EzcMaterialManager" scope="session"></jsp:useBean>

<%
	String productNo = request.getParameter("ProductCode");
	
	if(productNo!=null)
    	productNo = productNo.replaceAll("@@@","#");  
    	
	String upc = request.getParameter("upc");
	String matId = request.getParameter("matId");
	String vendCode = request.getParameter("vendCode");
	String prodDesc = request.getParameter("prdDesc");
	int retCount=0;
	String plant="",availableQty="",availableDate="";
	
	String[] prodNo =new String[1];
	String[] upcNos =new String[1];
	String[] matIds =new String[1];
	String[] vendCodes =new String[1];
	
	prodNo[0]   = productNo;
	upcNos[0]   = upc;
	matIds[0]   = matId;
	vendCodes[0]= vendCode;
	
		
	
	ReturnObjFromRetrieve myObj =null;
        String  formatkey=(String)session.getValue("formatKey");
        FormatDate formatDate = new FormatDate();

    	try{
    		EzcMaterialParams ezMatParams = new EzcMaterialParams();
    		EziMaterialParams eiMatParams = new EziMaterialParams();  
    
    		eiMatParams.setMaterialCodes(prodNo);
    		eiMatParams.setMatIds(matIds);
		eiMatParams.setUPCNumbers(upcNos);
		eiMatParams.setVendorCodes(vendCodes); 
    		eiMatParams.setMaterial("");
    		eiMatParams.setUnit("");
     		
    		ezMatParams.setObject(eiMatParams);
    		Session.prepareParams(ezMatParams);  
    
    
    		EzoMaterialParams eoMatParams = (EzoMaterialParams) EzcMaterialManager.getMaterialAvailability(ezMatParams);
    		myObj = (ReturnObjFromRetrieve) eoMatParams.getReturn();
    
    	}catch(Exception e){		  
	}
	
	if(myObj!=null)
		retCount = myObj.getRowCount();	
		
        
        String sapCode ="";
        
        if(retCount>0){
         sapCode = myObj.getFieldValueString(0,"MATERIAL");
         if(sapCode==null||"null".equals(sapCode))
         sapCode ="";
        } 
%>  

<html>
<head>
	<title>Check for ATP -- Answerthink Inc</title>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
</head>

<body  scroll=no> 
<form method="post"  name="generalForm">
<br>
<Table width="85%"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
   <tr> 
     <th colspan=8><%= prodDesc %>  Availability </th>
  </tr>
  <tr> 
       <th colspan=8>SAP Product Code : <%= sapCode %></th>
  </tr>
   <tr> 
    <th colspan="2">Plant </th>
    <th colspan="2">Available Quantity</th>
    <th colspan="2">Available On </th>
    
  </tr>
  
<%
   double qty = 0;
   for ( int i = 0 ; i < retCount ; i++ )
   {
      plant          = myObj.getFieldValueString(i,"PLANT");
      availableQty   = myObj.getFieldValueString(i,"AVAIL_QTY");
      Date tempDate  = (Date)myObj.getFieldValue(i,"ENDLEADTME");
      try{
      	qty = Double.parseDouble(availableQty);
      }catch(Exception err){
      	qty = 0;
      }
      if(plant!=null)
      plant = plant.trim();
      
      
      if("QU".equals(plant) || "BK".equals(plant) || "XX".equals(plant) ){
      if(tempDate!=null)
      	  availableDate = formatDate.getStringFromDate(tempDate,formatkey,FormatDate.MMDDYYYY); 
      if(qty == 0)	  
      	availableDate ="Call for Availability Date";

%>
	<tr>
		<Td colspan="2"> <%=plant%> </Td>
		<Td colspan="2"> <%=availableQty%></Td>
		<Td colspan="2"> <%=availableDate%></Td> 
	</tr>


<%
      }
   }
%>
</table>
<br>
<center>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	buttonName.add("Close");
	buttonMethod.add("window.close()");	
	out.println(getButtonStr(buttonName,buttonMethod));
%>
</center>
</form>
</body>
</html> 



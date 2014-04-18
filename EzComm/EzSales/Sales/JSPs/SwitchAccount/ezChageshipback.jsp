 <%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
 <%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
 <%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
 <%@ page import = "ezc.ezparam.*" %>
 <%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
 
 
 
 <%@ page import="ezc.ezparam.*,ezc.ezbasicutil.*,java.util.*" %>
 <%@ page import="ezc.customer.invoice.params.*,ezc.ezmisc.params.*,ezc.ezadmin.ezadminutils.params.*" %>
 <%@ page import="java.text.*,ezc.ezsap.*,ezc.client.*,ezc.ezutil.FormatDate" %>
 <style>
 
 #input {
 box-shadow: inset 0px 0px 0px ; 
 border: none;    
 }
 
</style>
 <script type="text/javascript">
 
 function selectedShipTos()
 {
 	
 	var selShipTo=document.shipForm.selShipToInfo.value
 	//alert(selShipTo)
 	shipAddr	= selShipTo.split('#')[0]
	shipStreet	= selShipTo.split('#')[1]
	shipCity	= selShipTo.split('#')[2]
	shipState	= selShipTo.split('#')[3]
	shipCountry	= selShipTo.split('#')[4]
	shipZip		= selShipTo.split('#')[5]
	shipPhNum	= selShipTo.split('#')[6]
	shipCodes	= selShipTo.split('#')[7]


	document.shipForm.selShipTo_S.value 	= shipCodes	
	document.shipForm.shipToName.value 	= shipAddr
	document.shipForm.shipToStreet.value	= shipStreet
	document.shipForm.shipToCity.value 	= shipCity
	document.shipForm.shipToState.value 	= shipState
	document.shipForm.shipToCountry.value 	= shipCountry
	document.shipForm.shipToZip.value 	= shipZip
	document.shipForm.shipToPhone.value 	= shipPhNum
	
}
 </script>
 
<body onLoad="selectedShipTos()">
<form name="shipForm" method="post" action="ezSaveDefaultShipTo.jsp">
<input type='hidden' name='selShipTo_S' value="">
 <div class="main-container col2-layout middle account-pages">
 <div class="main">
 <div class="col-main1">
 <div class="page-title">
 
 <h2>Switch ShipTo</h2> 	
 
 <%//@ include file="../../../Includes/JSPs/SwitchAccount/iChangeShipTo.jsp"%>
 
 <ul class="form-list">
 
 	
 <%
 	String soldTOses = (String)session.getValue("AgentCode");
 	ReturnObjFromRetrieve  listShipTos_entSesGet = (ReturnObjFromRetrieve)UtilManager.getListOfShipTos(soldTOses);
 	
 	
	String selShipToInfoSes = (String)session.getValue("ShipCode");
	
	
	//out.println("selShipToInfoSes::"+selShipToInfoSes);
 
 	String shipToName = "";
 	String shipAddr1 = "";
	String shipAddr2 = "";
	String shipState = "";
	String shipCountry = "";
	String shipZip = "";
	String shipPhNum = "";
	int sl=0;
	
 %>
 	<li>
		<label for="shiptoname" >Ship To ID </label>
		<div class="input-box">
		<div>
		<select name="selShipToInfo" onChange="selectedShipTos()">
<%
		for(int l=0;l<listShipTos_entSesGet.getRowCount();l++)
		{
			String shipToCode = listShipTos_entSesGet.getFieldValueString(l,"EC_PARTNER_NO");
			shipToName 	= listShipTos_entSesGet.getFieldValueString(l,"ECA_NAME");
			shipAddr1  	= listShipTos_entSesGet.getFieldValueString(l,"ECA_ADDR_1"); //Street
			shipAddr2  	= listShipTos_entSesGet.getFieldValueString(l,"ECA_CITY");
			shipState  	= listShipTos_entSesGet.getFieldValueString(l,"ECA_STATE");
			shipCountry  	= listShipTos_entSesGet.getFieldValueString(l,"ECA_COUNTRY");
			shipZip    	= listShipTos_entSesGet.getFieldValueString(l,"ECA_PIN");
			shipPhNum    	= listShipTos_entSesGet.getFieldValueString(l,"ECA_PHONE");

			shipAddr1 	= (shipAddr1==null || "null".equals(shipAddr1)|| "".equals(shipAddr1))?"":shipAddr1;
			shipAddr2 	= (shipAddr2==null || "null".equals(shipAddr2)|| "".equals(shipAddr2))?"":shipAddr2;// for city
			shipState 	= (shipState==null || "null".equals(shipState) || "".equals(shipState))?"":shipState;
			shipCountry 	= (shipCountry==null || "null".equals(shipCountry)|| "".equals(shipCountry))?"":shipCountry.trim();
			shipZip 	= (shipZip==null || "null".equals(shipZip)|| "".equals(shipZip))?"":shipZip;
			shipPhNum 	= (shipPhNum==null || "null".equals(shipPhNum)|| "".equals(shipPhNum))?"":shipPhNum;
													
			String shipParams = shipToName+"#"+shipAddr1+"#"+shipAddr2+"#"+shipState+"#"+shipCountry+"#"+shipZip+"#"+shipPhNum+"#"+shipToCode;
%>
				
<%			String selected_A = "selected";

			if(selShipToInfoSes.equals(shipToCode))
			{			
				
				sl=l;
%>				
				<option value="<%=shipParams%>" <%=selected_A%>><%=shipToCode%>(<%=shipToName%>)</option>
				
<%			}
			else
			{
%>	
				<option value="<%=shipParams%>"><%=shipToCode%>(<%=shipToName%>)</option>
<%
			}
			
			shipToName 	= listShipTos_entSesGet.getFieldValueString(sl,"ECA_NAME");
			shipAddr1  	= listShipTos_entSesGet.getFieldValueString(sl,"ECA_ADDR_1"); //Street
			shipAddr2  	= listShipTos_entSesGet.getFieldValueString(sl,"ECA_CITY");
			shipState  	= listShipTos_entSesGet.getFieldValueString(sl,"ECA_STATE");
			shipCountry  	= listShipTos_entSesGet.getFieldValueString(sl,"ECA_COUNTRY");
			shipZip    	= listShipTos_entSesGet.getFieldValueString(sl,"ECA_PIN");
			shipPhNum    	= listShipTos_entSesGet.getFieldValueString(sl,"ECA_PHONE");

			shipAddr1 	= (shipAddr1==null || "null".equals(shipAddr1)|| "".equals(shipAddr1))?"":shipAddr1;
			shipAddr2 	= (shipAddr2==null || "null".equals(shipAddr2)|| "".equals(shipAddr2))?"":shipAddr2;// for city
			shipState 	= (shipState==null || "null".equals(shipState) || "".equals(shipState))?"":shipState;
			shipCountry 	= (shipCountry==null || "null".equals(shipCountry)|| "".equals(shipCountry))?"":shipCountry.trim();
			shipZip 	= (shipZip==null || "null".equals(shipZip)|| "".equals(shipZip))?"":shipZip;
			shipPhNum 	= (shipPhNum==null || "null".equals(shipPhNum)|| "".equals(shipPhNum))?"":shipPhNum;
%>
			
<%
		}
%>
		</select>
 		</div>
 		
 		
 	</li>
 	<br>
 	<li>
		<h2>Ship To Addrress:</h2>
			
	</li>
 	<li>
		<label for="shipToName" class="required">Ship To Name: </label>
		<div class="input-box">
			<input type="text" id="input" name="shipToName" value="<%=shipToName%>" size=50 readonly>
		</div>
	</li>
	<li>
		<label for="shipToStreet" class="required">Street:</label>
		<div class="input-box">
			<input type="text" id="input" name="shipToStreet" value="<%=shipAddr1%>" readonly>
		</div>
	</li>
	<li>
		<label for="city-state-zip" >City/ State/ Zip:</label>
		<div class="input-box">
			<input type="text" id="input" name="shipToCity" value="<%=shipAddr2%>" readonly>
			<input type="text" id="input" name="shipToState" value="<%=shipState%>" readonly>
			<input type="text" id="input" name="shipToZip" value="<%=shipZip%>" readonly>
		</div>
	</li>
	<li>
		<label for="shipToPhone" class="required">Phone: </label>
		<div class="input-box">
			<input type="text" id="input" name="shipToPhone" value="<%=shipPhNum%>" readonly>
			
		</div>
	</li>
 	
 	</ul>
 
 </div>
 
 
   <div class="buttons-set form-buttons">
         <p class="back-link"><a href="../Misc/ezDashBoard.jsp"><small>&laquo; </small>Go Home</a></p>
         <button type="submit" class="button btn-blue" ><span><span>Save</span></span></button>
 
     </div>
 	 
 <div class="col1-set">
 <div class="info-box">
  	
</div> <!-- Info box -->
</div> <!-- col1-set -->
</div> <!-- col-main -->
</div> <!--main -->
</div> <!-- main-container col1-layout -->
</form>
</body>
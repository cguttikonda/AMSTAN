<%@ page import ="java.util.*,ezc.ezutil.*,ezc.ezparam.*" %>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/DrillDownCatalog/iMyAccount.jsp" %>
<%
	String display_header = "My Account"; 
	String billTo="";
	String shipTo="",shitoAddr1="",shipCity="",shipState="",shipPin="",shipCountry="";
%>
<Html>
<Head>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
	
<script>
        function funEditBillTo(obj)
        {
           //retVal=showModalDialog('ezEditBillTo.jsp'," ",'center:yes;dialogWidth:45;dialogHeight:40;status:no;minimize:no');
           
        }
        function funEditShipTo()
	{
		var shipToObj = document.myForm.shipTo;
		var len       = shipToObj.length;
		var shipTo    ="";
		if(isNaN(len)){
			if(shipToObj.checked)
			shipTo=shipToObj.value;
		}else{
		      for(i=0;i<len;i++){
			  if(shipToObj[i].checked)
			  shipTo=shipToObj[i].value;
		      }
		}
		
		if("" != shipTo){
		        document.myForm.editShip.value=shipTo;
			document.myForm.action="ezEditShipTo.jsp";
			document.myForm.submit();
		}else{
		        alert("Please select ShipTo to edit")  
		        return;
		}
		
        }
        function funAddShipTo()
        {
             document.myForm.action="ezAddShipTo.jsp"; 
             document.myForm.submit();
        }
</script>
</Head>
<Body scroll=no>
<Form  name="myForm" method="post">
<input type='hidden' name='editShip'>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>  
<Br>

	        <Table align="center" width="80%" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=1 >
		<Tr>
			<Th align="left" colspan=12><img src='../../Images/Common/yellowarrow.gif'>&nbsp;&nbsp;Bill To</Th>	        
		</Tr>	
		<Tr>
			<Th align="center" width='25%'>Company</Th>   
			<Th align="center" width='20%'>Address1</Th>
			<Th align="center" width='10%'>City</Th>
			<th align="center" width='10%'>Telephone</th>
			<th align="center" width='15%'>Contact</th>
			<th align="center" width='20%'>E Mail</th>    
		</Tr>
<%
			 for(int j = 0;j<retSoldCount;j++){  
			  
			  billTo = retsoldto.getFieldValueString(j,"EC_NO");
			 
%>
		<tr>
			<!--<td width='4%' align="center">
				<a href="JavaScript:funEditBillTo('<%=billTo%>')">
					<img src="../../Images/Common/view.gif" border=none >
				</a> 
			</td>-->
			<Td width='25%'><%=retsoldto.getFieldValueString(j,"ECA_COMPANY_NAME")%>
			
			</Td>
			<Td width='20%'><%=retsoldto.getFieldValueString(j,"ECA_ADDR_1")%></Td>
			<Td width='10%'><%=retsoldto.getFieldValueString(j,"ECA_CITY")%></Td>
			<td width='10%'><%=retsoldto.getFieldValueString(j,"ECA_PHONE")%></td>
			<td width='15%'>&nbsp;</td>
			<td width='20%'><%=retsoldto.getFieldValueString(j,"ECA_EMAIL")%></td>
		</tr>	 
<% 
                         }
%>

		</Table>
		<br><br><br>
		
		<Table align="center" width="80%" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=1 >
		<Tr>
			<Th colspan=8 align="left"><img src='../../Images/Common/yellowarrow.gif'>&nbsp;&nbsp;Ship To</Th>
			
		</Tr>		
		<Tr>
			<Th align="center" colspan=2 width='25%'>Company</Th>
			<Th align="center" width='20%'>Address1</Th>
			<Th align="center" width='10%'>City</Th>
			<th align="center" width='15%'>State</th>
			<th align="center" width='15%'>Telephone</th>
			
			<th align="center" width='15%'>E Mail</th>
			
		</Tr>
<%

			 for(int i = 0;i<retShipCount;i++){
			 
			 shipTo      = listShipTos.getFieldValueString(i,"EC_NO");
			 shitoAddr1  = listShipTos.getFieldValueString(i,"ECA_ADDR_1"); 
			 shipCity    = listShipTos.getFieldValueString(i,"ECA_CITY");
			 shipState   = listShipTos.getFieldValueString(i,"ECA_STATE");
			 shipPin     = listShipTos.getFieldValueString(i,"ECA_PIN");
			 shipCountry = listShipTos.getFieldValueString(i,"ECA_COUNTRY");
			 
			 shipTo       =((shipTo==null) || "null".equals(shipTo))?"":shipTo;
			 shitoAddr1   =((shitoAddr1==null) || "null".equals(shitoAddr1))?"":shitoAddr1;
			 shipCity     =((shipCity==null) || "null".equals(shipCity))?"":shipCity;
			 shipState    =((shipState==null) || "null".equals(shipState))?"":shipState;
			 shipPin      =((shipPin==null) || "null".equals(shipPin))?"":shipPin;
			 shipCountry  =((shipCountry==null) || "null".equals(shipCountry))?"":shipCountry;
%>
		<tr>
			
			
			<input type="hidden" name="shipToAddress1" value="<%=shitoAddr1%>">
			<input type="hidden" name="shipToCity" value="<%=shipCity%>">
			<input type="hidden" name="shipToState" value="<%=shipState%>">
			<input type="hidden" name="shipToZipcode" value="<%=shipPin%>">
			<input type="hidden" name="shipToCountry" value="<%=shipCountry%>">

			<td width='4%' align="center">
			<input type='radio' name ='shipTo' value='<%=shipTo%>'>
				
				<!--<a href="JavaScript:funEditShipTo('<%=shipTo%>','<%=i%>')">
					<img src="../../Images/Common/view.gif" border=none title="Edit">
				</a> -->
			</td>
			<Td width='21%'><%=listShipTos.getFieldValueString(i,"ECA_COMPANY_NAME")%></Td>
			<Td width='20%'><%=shitoAddr1%>&nbsp;</Td>
			<Td width='10%'><%=shipCity%>&nbsp;</Td>
			<td width='15%'><%=shipState%>&nbsp;</td>
			<td width='15%'><%=listShipTos.getFieldValueString(i,"ECA_PHONE")%>&nbsp;</td>
			<td width='15%'><%=listShipTos.getFieldValueString(i,"ECA_EMAIL")%>&nbsp;</td> 
			
			
		</tr>	 
<% 
			 }
%>

		</Table> 
		<div id="buttonDiv" align="center" style="visibility:visible;position:absolute;top:86%;width:100%">
		<%
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();
			buttonName.add("Edit ShipTo");
			buttonMethod.add("funEditShipTo()");	
			buttonName.add("Add ShipTo");
			buttonMethod.add("funAddShipTo()");	
			out.println(getButtonStr(buttonName,buttonMethod));
		%>
		</div>

</Form>
<Div id="MenuSol"></Div>               
</Body>
</Html>
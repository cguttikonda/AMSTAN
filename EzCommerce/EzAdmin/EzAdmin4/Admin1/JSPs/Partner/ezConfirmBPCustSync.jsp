<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Partner/iConfirmBPCustSync.jsp"%>
<html>
<head>
<Title>Synchronize Base ERP SoldTos</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<body bgcolor="#FFFFF7">
<script src="../../Library/JavaScript/Partner/ezConfirmBPCustSync.js">
</script>

<%
String FUNCTION = request.getParameter("FUNCTION");
if (FUNCTION == null)FUNCTION="AG";

String cTitle = (FUNCTION.equals("AG"))?"Customer":"Vendor";
String cFlag = (FUNCTION.equals("AG"))?"C":"V";
String arDesc = (FUNCTION.equals("AG"))?"Sales":"Purchase";
String arSel = (FUNCTION.equals("AG"))?"ERP Sold To":"ERP Pay To";
%>


<br>

<form name=myForm method=post action="ezSaveNonBaseERPSync.jsp">
  <Table  width="50%" border="2" align="center">
    <Tr>
      <Th width="44%" class="labelcell">
        <div align="right">Business Partner:</div>
      </Th>
      <Td width="56%" >
		<input type="hidden" name="BusPartner" value=<%=BusPartner%> >
		<input type=text class = "InputBox" readonly size="25" name="BPDesc" value=<%=BPDesc%> >

      </Td>
    </Tr>
    <Tr>
      <Th width="44%" class="labelcell">  <div align="right"><%=arDesc%>
      Area:</div>
      </Th>
      <Td width="56%" >

		<input type=text class = "InputBox" readonly size="25" name="SysKey" value=<%=SysKey%> >

      </Td>
    </Tr>
  </Table>
  <br>
  <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
  <Tr align="center">
    <Td class="displayheader">Sold To Party Synchronization</Td>
  </Tr>
</Table>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
    <Tr>
      <Td width="30%" valign="top" class="labelcell">
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="100%">
          <Tr align="center" valign="middle">
            <Td width="6%" class="labelcell">&nbsp;</Td>
            <Td width="32%" class="labelcell" ><b><%=arSel%></b></Td>
            <Td width="37%" class="labelcell" ><b>Address</b></Td>
          </Tr>
<%
int k = (new Integer(Index)).intValue();
int fCount = 0;
try
{
	int fillCount = 0;
	SoldTo = "ERPCUST_"+k;
	pSoldTo = request.getParameter(SoldTo);
	if(pSoldTo.length() > 0)
	{

		if ( FUNCTION.equals("AG") )
		{
			EzcCustomerParams custparams = new EzcCustomerParams();
			EzCustomerParams custnkparams = new EzCustomerParams();
			EzCustomerSyncParams ecsp = new EzCustomerSyncParams();
			custparams.setSysKey(SysKey);
			ecsp.setSystemKey(SysKey);
			ecsp.setBussPartnerNo("");
			ecsp.setCustomer(pSoldTo);
			ecsp.setLanguage("EN");
			ecsp.setPartnerFunc("");
			custnkparams.setEzCustomerSyncParams(ecsp);
			custparams.setObject(custnkparams);
			Session.prepareParams(custparams);
			buss_cust_retObj = (ReturnObjFromRetrieve)CustomerManager.getCustomersFromErp(custparams);
		}
		else
		{
			EzcVendorParams vparams = new EzcVendorParams();
			EzVendorParams vnkparams = new EzVendorParams();
			vnkparams.setSysKey(SysKey);
			vnkparams.setBussPartnerNo("");
			vnkparams.setVendor(pSoldTo);
			vnkparams.setLanguage("EN");
			vnkparams.setPartnerFunc("");
			vparams.setSysKey(SysKey);
			vparams.setObject(vnkparams);
			Session.prepareParams(vparams);
			buss_cust_retObj = (ReturnObjFromRetrieve)VendorManager.getVendorsFromErp(vparams);
		}
		buss_cust_retObj.check();

		if ( buss_cust_retObj != null )
		{
			returnObjCheck = true;
			if ( FUNCTION.equals("AG") )
			{
				busspartnerObj = (ReturnObjFromRetrieve)buss_cust_retObj.getObject("CUSTOMERDETAILS");
			}
			else
			{
				busspartnerObj = (ReturnObjFromRetrieve)buss_cust_retObj.getObject("VENDORDETAILS");
			}
			busspartnerObj.check();

			if ( busspartnerObj != null )session.putValue("busspartnerObj",busspartnerObj);
			/** Get the SoldTo for Partner function AG **/
			String selSoldTo = "";
			int row = 0;
			if ( busspartnerObj.find("PARTFUNCTIONID",FUNCTION) )
			{
				row = busspartnerObj.getRowId("PARTFUNCTIONID",FUNCTION);
				selSoldTo = busspartnerObj.getFieldValueString(row,"ERPCUSTNUMBER");
			}

			if ( FUNCTION.equals("AG") )
			{
				addressObj = (ReturnObjFromRetrieve)buss_cust_retObj.getObject("CUSTOMERADDRESSDETAILS");
			}
			else
			{
				addressObj = (ReturnObjFromRetrieve)buss_cust_retObj.getObject("VENDORADDRESSDETAILS");
			}
			addressObj.check();
			if ( addressObj != null )session.putValue("addressObj",addressObj);
			int AddRows = addressObj.getRowCount();
			for ( int i = 0 ; i < AddRows; i++ )
			{
				String cSoldTo = addressObj.getFieldValueString(i,"CUSTOMERNUMBER");
				if ( cSoldTo.equals(selSoldTo) )
				{
%>
					<input type="hidden" name="PartNum_<%=fillCount%>" value=<%=busspartnerObj.getFieldValue(row,"CUSTOMERNUMBER")%> >
					<input type="hidden" name="PartFun_<%=fillCount%>" value=<%=busspartnerObj.getFieldValue(row,"PARTFUNCTIONID")%> >
					<input type="hidden" name="ERPSoldTo_<%=fillCount%>" value=<%=busspartnerObj.getFieldValue(row,"PARTNERNUMBER")%> >

		<Tr>

            <Td  align="center">

        		<input type="checkbox" name="CheckBox<%=k%>_0" value="Selected" checked onClick="checkThis(this.name)" >

	</Td>
            <Td  align="center">

				<input type=text class = "InputBox" readonly size="10" maxlength="10" name="SoldTo<%=k%>_<%=i%>" value=<%=addressObj.getFieldValue(i,"CUSTOMERNUMBER")%> >

	</Td>
            <Td >
					<input type=text class = "InputBox" readonly size="25" maxlength="25" name="CustName<%=k%>_<%=i%>" value=<%=addressObj.getFieldValue(i,"NAME1")%> >
					<input type=text class = "InputBox" readonly size="25" maxlength="25" name="Addr1<%=k%>_<%=i%>" value=<%=addressObj.getFieldValue(i,"ADDRESS1")%> >
					<input type=text class = "InputBox" readonly size="25" maxlength="20" name="City<%=k%>_<%=i%>" value=<%=addressObj.getFieldValue(i,"CITY")%> >
					<input type=text class = "InputBox" readonly size="25" maxlength="20" name="State<%=k%>_<%=i%>" value=<%=addressObj.getFieldValue(i,"REGION")%> >
					<input type=text class = "InputBox" readonly size="25" maxlength="10" name="Zip<%=k%>_<%=i%>" value=<%=addressObj.getFieldValue(i,"POSTALCODE")%> >
					<input type=text class = "InputBox" readonly size="25" maxlength="10" name="Country<%=k%>_<%=i%>" value=<%=addressObj.getFieldValue(i,"COUNTRYKEY")%> >

	</Td>
		</Tr>
<%
						fillCount++;
						break;
				} //end if cSoldTo.equals
			}//End for
%>
			<input type="hidden" name="AddCount" value=<%=AddRows%> >
<%
		} //end if buss_cust_retObj!= null
	}//End if pSoldTo
%>
	<input type="hidden" name="TotalCount" value=<%=fillCount%> >
<%
}
catch (Exception e)
{
	returnObjCheck = false;
};
%>
        </Table>
       </Td>
      <Td width="30%" valign="top" class="labelcell">
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="100%">
          <Tr>
            <Td class="labelcell">
              <div align="center" ><b>EzC <%=cTitle%> Address</b></div>
            </Td>
          </Tr>
<%
	int i = 0;
	String ErpCust = "ERPCUST_"+k;
	String pErpCust = request.getParameter(ErpCust);
	if ( pErpCust != null)pErpCust = pErpCust.trim();
	EzcCust = "EzcCustomer_"+k;
	pEzcCust = request.getParameter(EzcCust);
		if(pEzcCust != null)
		{

			// EZC Customer number needs to take all the way upto save -- 01/09/2000 -- Manne
			// Following line added
%>
			<input type="hidden" name="Ezc_SoldTo_<%=fCount%>" value=<%=pEzcCust%> >
<%


			if ( FUNCTION.equals("AG") )
			{
				EzcCustomerParams customerParams = new EzcCustomerParams();
				EzCustomerStructure ezCustomerStructure = new EzCustomerStructure();
				ezCustomerStructure.setLanguage("EN");
				ezCustomerStructure.setCustomerNo(pEzcCust);
				customerParams.setObject(ezCustomerStructure);
				Session.prepareParams(customerParams);
				retcustadd = (ReturnObjFromRetrieve)CustomerManager.getCustomerAddress(customerParams);
			}
			else
			{
				EzcVendorParams vParams = new EzcVendorParams();
				EzVendorParams vnkparams = new EzVendorParams();
				vnkparams.setLanguage("EN");
				vnkparams.setVendor(pEzcCust);
				vParams.setObject(vnkparams);
				Session.prepareParams(vParams);
				retcustadd = (ReturnObjFromRetrieve)VendorManager.getVendorAddress(vParams);
			}

			retcustadd.check();
			if(retcustadd.getRowCount() > 0)
			{
				fCount++;
 %>
          <Tr>
            <Td >

			<input type=text class = "InputBox" readonly size="25" maxlength="25" name="Company" value=<%=retcustadd.getFieldValue(0,EC_NAME_X)%> >
			<br>
			<input type=text class = "InputBox" readonly size="25" maxlength="25" name="Address1" value=<%=retcustadd.getFieldValue(0,EC_ADDR_1_X)%> >

			<br>
			<input type=text class = "InputBox" readonly size="25" maxlength="20" name="City" value=<%=retcustadd.getFieldValue(0,EC_CITY_X)%> >
			<br>
			<input type=text class = "InputBox" readonly size="25" maxlength="20" name="State" value=<%=retcustadd.getFieldValue(0,EC_STATE_X)%> >

			<br>

			<input type=text class = "InputBox" readonly size="25" maxlength="10" name="Zip" value=<%=retcustadd.getFieldValue(0,EC_PIN_X)%> >
			<br>
			<input type=text class = "InputBox" readonly size="25" maxlength="10" name="Zip" value=<%=retcustadd.getFieldValue(0,"ECA_COUNTRY")%> >

		</Td>
          </Tr>
<%
			}
			else
			{
				// EZC Customer number needs to take all the way upto save -- 01/09/2000 -- Manne
				// Following line added---- This is to avoid script errors in case of failure
 %>
				<input type="hidden" name="Ezc_SoldTo_<%=i%>" value="" >

          <Tr >
            <Td >
 				There is no Address for the Ezc Customer you entered. Check your number

		</Td>
          </Tr>
          <%
			}//End if
		}//End if
	//}//End for
%>
        </Table>
      </Td>
    </Tr>
  </Table>
  <br>
<%if(returnObjCheck){%>
<div align="center">
    <input type="image" src = "../../Images/Buttons/<%= ButtonDir%>/synchronize.gif" name="Submit" value="Synchronize" onClick="checkAll(<%=k%>);return document.returnValue">
  </div>    
<% } else {%>
	<br><br><br><br><br><br><br><br>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
  	<Tr align="center">
    	<Th>No data has been retrieved from the <%=mySystemDesc%></Th>
  	</Tr>
	</Table>
	<br>
	<center>
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border=none></a>
	</center>
<% } %>

<input type="hidden" name="FUNCTION" value="<%=FUNCTION%>">
</form>
</body>
</html>
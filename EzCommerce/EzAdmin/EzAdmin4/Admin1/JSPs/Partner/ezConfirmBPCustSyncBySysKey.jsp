<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ page import="java.util.*" %>
<%@ include file="../../../Includes/JSPs/Partner/iConfirmBPCustSyncBySysKey.jsp"%>
<html>
<head>
<Title>Synchronize Base ERP SoldTos</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script src="../../Library/JavaScript/Partner/ezConfirmBPCustSyncBySysKey.js">
</script>

<Script src="../../Library/JavaScript/ezTabScroll.js"></script>

</head>
<body bgcolor="#FFFFF7" onLoad='scrollInit()'  onresize='scrollInit()' scroll="no">
<form name=myForm method=post action="ezSaveNonBaseERPSyncBySysKey.jsp">
<%
String Area=request.getParameter("Area");
String FUNCTION = request.getParameter("FUNCTION");
if (FUNCTION == null)FUNCTION="AG";

String cTitle = (FUNCTION.equals("AG"))?"Customer":"Vendor";
String cFlag = (FUNCTION.equals("AG"))?"C":"V";
String arDesc = (FUNCTION.equals("AG"))?"Sales":"Purchase";
String arSel = (FUNCTION.equals("AG"))?"ERP Sold To":"ERP Pay To";
String partyType = ( FUNCTION.equals("AG") )?"Sold":"Pay";
%>
<br>
<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
  <Tr align="center">
    <Td class="displayheader"><%=partyType%> To Party Synchronization</Td>
  </Tr>
</Table>
  <div id="theads">
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
    <Tr>
      <Th width="30%" class="labelcell">
        <div align="right">Business Partner:</div>
      </Th>

      <Td width="30%" >

	<a href = "../Partner/ezBPSummaryBySysKey.jsp?WebSysKey=<%=websyskey%>&Area=<%=cFlag%>&BusinessPartner=<%=BusPartner%>"><%=BPDesc%></a>
		<input type="hidden" name="BusPartner" value=<%=BusPartner%> >
		<input type="hidden" readonly size="25" name="BPDesc" value=<%=BPDesc%> >


      </Td>
      <Th width="20%" class="labelcell">  <div align="right"><%=arDesc%>
      Area:</div>
      </Th>
      <Td width="20%" >

	<a href= "../Config/ezSetBusAreaDefaults.jsp?Area=<%=cFlag%>&SystemKey=<%= sKey %>" > (<%=sKey%>)&nbsp;</a>


     </Td>
		<input type="hidden" readonly size="25" name="SysKey" value=<%=sKey%> >


    </Tr>
  </Table>
</div>


<DIV id="InnerBox1Div">
<Table id="InnerBox1Tab" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
    <Tr>
      <Td width="30%" valign="top" class="labelcell">
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="100%">
          <Tr align="center" valign="middle">
            <Td width="6%" class="labelcell">&nbsp;</Td>
            <Td width="32%" class="labelcell" ><b><%=arSel%></b></Td>
            <Td width="37%" class="labelcell" ><b>Address</b></Td>
          </Tr>
<%
try
{
	int fillCount = 0;

		if ( FUNCTION.equals("AG") )
		{
			EzcCustomerParams custparams = new EzcCustomerParams();
			EzCustomerParams custnkparams = new EzCustomerParams();
			EzCustomerSyncParams ecsp = new EzCustomerSyncParams();
			custparams.setSysKey(sKey);
			ecsp.setSystemKey(sKey);
			ecsp.setBussPartnerNo("");
			ecsp.setCustomer(ERPCust);
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
			vnkparams.setSysKey(sKey);
			vnkparams.setBussPartnerNo("");
			vnkparams.setVendor(ERPCust);
			vnkparams.setLanguage("EN");
			vnkparams.setPartnerFunc("");
			vparams.setSysKey(sKey);
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

					<input type="hidden" name="PartNum" value=<%=busspartnerObj.getFieldValue(row,"CUSTOMERNUMBER")%> >
					<input type="hidden" name="PartFun"  value=<%=busspartnerObj.getFieldValue(row,"PARTFUNCTIONID")%> >
					<input type="hidden" name="ERPSoldTo" value=<%=busspartnerObj.getFieldValue(row,"PARTNERNUMBER")%> >

		<Tr>

            <Td  align="center">

        			<input type="checkbox" name="CheckBox" value="Selected" checked onClick="checkThis(this.name)" >

	</Td>
            <Td  align="center">
					<input type=text class = "InputBox" readonly size="10" maxlength="10" name="SoldTo" value=<%=addressObj.getFieldValue(i,"CUSTOMERNUMBER")%> >

	</Td>
            <Td >

					<input type="hidden" readonly size="25" maxlength="25" name="CustName" value="<%=addressObj.getFieldValue(i,"NAME1")%>" >
					<input type="hidden" readonly size="25" maxlength="25" name="Addr1" value="<%=addressObj.getFieldValue(i,"ADDRESS1")%>" >
					<input type="hidden" readonly size="25" maxlength="20" name="City" value="<%=addressObj.getFieldValue(i,"CITY")%>" >
					<input type="hidden" readonly size="25" maxlength="20" name="State" value="<%=addressObj.getFieldValue(i,"REGION")%>" >
					<input type="hidden" readonly size="25" maxlength="10" name="Zip" value="<%=addressObj.getFieldValue(i,"POSTALCODE")%>" >
					<input type="hidden" readonly size="25" maxlength="10" name="Country" value="<%=addressObj.getFieldValue(i,"COUNTRYKEY")%>" >
					<%=addressObj.getFieldValue(i,"NAME1")%><br>
					<%=addressObj.getFieldValue(i,"ADDRESS1")%><br>
					<%=addressObj.getFieldValue(i,"CITY")%><br>
					<%=addressObj.getFieldValue(i,"REGION")%><br>
					<%=addressObj.getFieldValue(i,"POSTALCODE")%><br>
					<%=addressObj.getFieldValue(i,"COUNTRYKEY")%>

	</Td>
		</Tr>
<%
						fillCount++;
						break;
				} //end if cSoldTo.equals
			}//End for
%>

<%

		} //end if buss_cust_retObj!= null

%>

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

	pEzcCust = request.getParameter("EzcCustomer");
		if(pEzcCust != null)
		{

%>
			<input type="hidden" name="Ezc_SoldTo" value=<%=pEzcCust%> >
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

 %>
          <Tr>
            <Td >

			<input type="hidden" readonly size="25" maxlength="25" name="Company" value="<%=retcustadd.getFieldValue(0,EC_NAME_X)%> ">

			<input type="hidden" readonly size="25" maxlength="25" name="Address1" value="<%=retcustadd.getFieldValue(0,EC_ADDR_1_X)%>" >

			<input type="hidden" readonly size="25" maxlength="20" name="City" value="<%=retcustadd.getFieldValue(0,EC_CITY_X)%>" >

			<input type="hidden" readonly size="25" maxlength="20" name="State" value="<%=retcustadd.getFieldValue(0,EC_STATE_X)%>" >

			<input type="hidden" readonly size="25" maxlength="10" name="Zip" value="<%=retcustadd.getFieldValue(0,EC_PIN_X)%>" >

			<input type="hidden" readonly size="25" maxlength="10" name="Zip" value="<%=retcustadd.getFieldValue(0,"ECA_COUNTRY")%>" >
			<%=retcustadd.getFieldValue(0,EC_NAME_X)%><br>
			<%=retcustadd.getFieldValue(0,EC_ADDR_1_X)%><br>
			<%=retcustadd.getFieldValue(0,EC_CITY_X)%><br>
			<%=retcustadd.getFieldValue(0,EC_STATE_X)%><br>
			<%=retcustadd.getFieldValue(0,EC_PIN_X)%><br>
			<%=retcustadd.getFieldValue(0,"ECA_COUNTRY")%>
		</Td>
          </Tr>
<%
			}
			else
			{
%>
				<input type="hidden" name="Ezc_SoldTo" value="" >

          <Tr >
            <Td >
 				<center>There is no Address for the Ezc Customer you entered. Check your number</center>

		</Td>
          </Tr>
          <%
			}//End if
		}//End if

%>
        </Table>
      </Td>
    </Tr>
  </Table>
  </div>
<br>
<%if(returnObjCheck){%>
<div align="center" style="position:absolute;top:70%;width:100%;">
    <input type="image" src = "../../Images/Buttons/<%= ButtonDir%>/synchronize.gif" name="Submit" value="Synchronize" >
    <a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
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
<input type="hidden" name="Area" value="<%=Area%>" >
</form>
</body>
</html>

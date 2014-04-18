<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%
	String FUNCTION = request.getParameter("FUNCTION");
	String Area = request.getParameter("Area");
	if ( FUNCTION == null )FUNCTION = "AG";

	String arDesc = ( FUNCTION.equals("AG") )?"Sales":"Purchase";
	String arTitle = ( FUNCTION.equals("AG") )?"Customer":"Vendor";
	String arSel = ( FUNCTION.equals("AG") )?"ERP Sold To":"ERP Pay To";

	String genEzc = request.getParameter("genezc");
	if ( genEzc == null ) genEzc = "";

	String[] partnerFunctions = new String[3];
	if ( FUNCTION.equals( "AG" ) )
	{
		partnerFunctions[0]="RE";
		partnerFunctions[1]="WE";
		partnerFunctions[2]="ZC";
	}
	else
	{
		partnerFunctions[0] = "OA";
		partnerFunctions[1] = "PI";
	} //end if
%>
<%@ include file="../../../Includes/JSPs/Partner/iConfirmPartnerFunctionSync.jsp"%>
<% final String ERP_CUST_NO = "EC_NO"; %>
<html>
<head>
<Title>Synchronize Partner Functions</Title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script src="../../Library/JavaScript/Partner/ezConfirmPartnerFunctionSyncBySysKey.js"></script>
<Script src="../../Library/JavaScript/ezTabScroll.js"></script>
</head>
<body bgcolor="#FFFFF7" onLoad='scrollInit()' onResize='scrollInit()' scroll="no">
<form name=myForm method=post action="ezSavePartnerFunctionSyncBySysKey.jsp">
<br>
<div id="theads">
<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
  	<Tr align="center">
  		<Td nowrap class="displayheader">Synchronize <%= arTitle%> Partner Functions</Td>
  	</Tr>
</Table>
</div>
<%
	String NEW = request.getParameter("New");
	if ( NEW == null ) NEW = "N";
%>
  	<Table border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width = "89%">
    	<Tr>
      		<Td width="20%" class="labelcell">
        		<div align="right"><b>Business Partner:</b></div>
      	</Td>
      	<Td width="30%" ><a href = "../Partner/ezBPSummaryBySysKey.jsp?WebSysKey=<%=SysKey%>&Area=<%=Area%>&BusinessPartner=<%=BusPartner%>"><%=BPDesc%></a></Td>
	<input type="hidden" name="BusPartner" value=<%=BusPartner%> >
      	<Td width="16%" class="labelcell">
        	<div align="right"><b><%=arDesc %> Area:</b></div>
      	</Td>
      	<Td width="10%" >
      		<a href= "../Config/ezSetBusAreaDefaults.jsp?Area=<%=Area%>&SystemKey=<%=SysKey%>">(<%=SysKey%>)&nbsp;</a>
	</Td>
	<input type="hidden" readonly size="20" name="SysKey" value= "<%=SysKey%>" >
<%
	int fillCount = 0;
	int k = 0;
	String erpSoldTo = "";
	if ( busspartnerObj != null )
	{
		/** Get the SoldTo for Partner function RE **/
		if ( busspartnerObj.find("PARTFUNCTIONID",FUNCTION) )
		{
			int row = busspartnerObj.getRowId("PARTFUNCTIONID",FUNCTION);
			erpSoldTo = busspartnerObj.getFieldValueString(row,"ERPCUSTNUMBER");
		}
%>
      	<Td width="12%" class="labelcell">
        	<div align="right"><b><%=arSel%>:</b></div>
      	</Td>
      	<Td width="12%" ><b><%=erpSoldTo%>&nbsp;</b></Td>
    	</Tr>
    	<Tr>
    	<Td class = "blankcell" colspan = 6>
  	<div align="center">
     		<font size="1" color="red" ><b>Note :  If you do not find a matching address, choose Create Customer from List Box</b></font>
    	</div>
    	</Td>
    	</Tr>
  	</Table>
<%
	/* To get the Partner Functions */
	String sysKey[] = {SysKey};
	bnkparams.setPartnerFunctions(partnerFunctions);
	bnkparams.setErp_customer(erpSoldTo);
	bnkparams.setSysKeys(sysKey);
	ReturnObjFromRetrieve retSbpezcust = (ReturnObjFromRetrieve)BPManager.getBussPartnerPartnerFunctions(bparams);

	int AddRows = busspartnerObj.getRowCount();
	for ( int i = 0, j = 0; j < AddRows; j++)
	{
		String cSoldTo = busspartnerObj.getFieldValueString(j,"PARTNERNUMBER");
		//cSoldTo = cSoldTo.trim();

		String pFuncDesc = "";
		String pFuncId = busspartnerObj.getFieldValueString(j,"PARTFUNCTIONID");;
		pFuncId = pFuncId.trim();
		int carNo =0;
		if("AF".equals(pFuncId))
			continue;
		
       		if ( !pFuncId.equals(FUNCTION) )
		{
		
		if(!"ZC".equals(pFuncId))
		{
		
			if ( pFuncId.equals("RE") )
			{
				pFuncDesc = "Bill To";
			}
			else if ( pFuncId.equals("WE") )
			{
				pFuncDesc = "Ship To";
			}
			else if ( pFuncId.equals("OA") )
			{
				pFuncDesc = "Ordering Address";
			}
			else if ( pFuncId.equals("PI") )
			{
				pFuncDesc = "Invoice Presented By";
			}
			if ( addressObj.find("CUSTOMERNUMBER",cSoldTo) )
			{
				i = addressObj.getRowId("CUSTOMERNUMBER",cSoldTo);
				if ( i < 0 )continue;
			}
			else
			{
				continue;
			}
			carNo=i;
		}
		else{
			pFuncDesc = "Carrier Name";
			i = carNo;
		}
			String partNumb = addressObj.getFieldValueString(i,"CUSTOMERNUMBER");
		      	String isdisabled = "";
			if ( retSbpezcust.find("EC_PARTNER_NO",partNumb) )isdisabled="disabled";
%>
	<DIV id="InnerBox1Div">

  	<Table id="InnerBox1Tab"  border="1" align="center">
    	<Tr>
      		<Td width="30%" valign="top" class="labelcell">
        	<Table  width="100%" border="0" align="center">
          	<Tr align="center" valign="middle">
            		<Td width="6%" class="labelcell"><b>Select<b></Td>
            		<Td width="6%" class="labelcell"><b><%=pFuncDesc%><b></Td>
            		<Td width="32%" class="labelcell" ><b>Address</b></Td>
          	</Tr>
	  	<Tr>
            		<Td  align="center">
				<input type="checkbox" name="CheckBox" value="Selected" checked <%=isdisabled%> >
	    		</Td>
            		<Td  align="center">
				<input type=text class = "InputBox" readonly size="10" maxlength="10" name="SoldTo" value=<%=cSoldTo%> >
	        	</Td>
            		<Td>
				<%=(addressObj.getFieldValueString(i,"NAME1"))%>
				<%=addressObj.getFieldValueString(i,"ADDRESS1")%>
				<%=addressObj.getFieldValueString(i,"CITY")%>
				<%=addressObj.getFieldValueString(i,"REGION")%> <%=addressObj.getFieldValueString(i,"POSTALCODE")%>
				<br><%=addressObj.getFieldValueString(i,"COUNTRYKEY")%>
				<input type="hidden" name="CustName" value=<%=addressObj.getFieldValueString(i,"NAME1")%> >
				<input type="hidden" name="Addr1" value=<%=addressObj.getFieldValueString(i,"ADDRESS1")%> >
				<input type="hidden" name="City" value=<%=addressObj.getFieldValueString(i,"CITY")%> >
				<input type="hidden" name="State" value=<%=addressObj.getFieldValueString(i,"REGION")%> >
				<input type="hidden" name="Zip" value=<%=addressObj.getFieldValueString(i,"POSTALCODE")%> >
				<input type="hidden" name="Country" value=<%=addressObj.getFieldValueString(i,"COUNTRYKEY")%> >
				<input type=hidden name=telephone1 value="<%=addressObj.getFieldValue(i,"TELEPHONE1")%>">
				<input type=hidden name=telephone2 value="<%=addressObj.getFieldValue(i,"TELEPHONE2")%>">
				<input type=hidden name=telEtexNo value="<%=addressObj.getFieldValue(i,"TELETEXNUMBER")%>">
				<input type=hidden name=telExNo value="<%=addressObj.getFieldValue(i,"TELEXNUMBER")%>">
				<input type=hidden name=customerNo value="<%=addressObj.getFieldValue(i,"CUSTOMERNUMBER")%>">
				<input type=hidden name=title value="<%=addressObj.getFieldValue(i,"TITLE")%>">
				<input type=hidden name=address2 value="<%=addressObj.getFieldValue(i,"ADDRESS2")%>">
				<input type=hidden name=countryCode value="<%=addressObj.getFieldValue(i,"COUNTRYCODE")%>">
				<input type=hidden name=pobox value="<%=addressObj.getFieldValue(i,"POBOX")%>">
				<input type=hidden name=poboxCity value="<%=addressObj.getFieldValue(i,"POBOXCITY")%>">
				<input type=hidden name=district value="<%=addressObj.getFieldValue(i,"DISTRICT")%>">
				<input type=hidden name=telBoxNo value="<%=addressObj.getFieldValue(i,"TELBOXNUMBER")%>">
				<input type=hidden name=faxNo value="<%=addressObj.getFieldValue(i,"FAXNUMBER")%>">
				<input type=hidden name=email value="<%=addressObj.getFieldValue(i,"EMAIL")%>">
				<input type=hidden name=webAddr value="<%=addressObj.getFieldValue(i,"COMPANYWEBSITE")%>">
				<input type=hidden name=indicator value="<%=addressObj.getFieldValue(i,"INDICATOR")%>">
				<input type=hidden name=transportZone value="<%=addressObj.getFieldValue(i,"TRANSPORTZONE")%>">
				<input type=hidden name=taxJdc value="<%=addressObj.getFieldValue(i,"TAXJDC")%>">
				<input type="hidden" name="PartNum" value=<%=cSoldTo%> >
				<input type="hidden" name="PartFunc" value=<%=pFuncId%> >
	        	</Td>
		</Tr>
	        </Table>
      	</Td>
     	<Td width="30%" valign="top" class="labelcell">
        	<Table id="InnerBox1Tab"  border="0">
          	<Tr>
            		<Td class="labelcell">
              			<div align="center" >Select an address to Map:
<%
			 	int custRows = retbpezcust.getRowCount();
			 	String custvalue = null;
			 	String SelPartnerFunction = "";

			 	if ( custRows > 0 )
			 	{

			 		SelPartnerFunction = request.getParameter("PartnerFunction");

			 		if ( SelPartnerFunction == null )
			 		{

			 			if ( cSoldTo.equals(erpSoldTo) )
			 			{
			 				SelPartnerFunction = genEzc;
			 			}
			 			else
			 			{
			 				SelPartnerFunction = "C";
			 			}
			 		}
			 		SelPartnerFunction = SelPartnerFunction.trim();
%>
				<select name="PartnerFunction" onChange="partnerfunctionchange()">
<%
		 	  	boolean showOnlyEzcFlag = false;
			   	String selDesc = "";
			   	if ( !cSoldTo.equals(erpSoldTo) )
			   	{
			   		if ( SelPartnerFunction.equals("C") )selDesc = "selected";
%>
						<option value="C">---CREATE <%=arTitle%>---</option>
<%
		 	  	}
			 	else
			 	{
					showOnlyEzcFlag = true;
				}
		 	  	for ( int z = 0 ; z < custRows ; z++ )
			   	{
		 			String val = ((String)retbpezcust.getFieldValue(z,"EC_NO")).toUpperCase();
			 		if(SelPartnerFunction.equals(val.trim()))
			 		{
%>
			 	       		<option selected value=<%=val%> >
<%
			 			custvalue = (String)retbpezcust.getFieldValue(z,ERP_CUST_NAME);
			 			if (custvalue != null)
			 			{
%>
			 				<%=custvalue%> ( <%=val%>)
<%
			 			}
%>
			 	        	</option>
<%
			 		}
			 		else if ( !showOnlyEzcFlag )
			 		{
%>
			 	        	<option value="<%=(retbpezcust.getFieldValue(z,ERP_CUST_NO))%>" >
<%
			 			custvalue = (String)retbpezcust.getFieldValue(z,ERP_CUST_NAME);
			 			if (custvalue != null)
			 			{
%>
			 				<%=custvalue%> (<%= val %>)
<%
			 			}
%>
			 	        	</option>
<%
			 		}
			 	  }//End for
%>
			         </select>
<%
			 }
%>
              </div>
            	</Td>
          	</Tr>
<%
		if ( FUNCTION.equals("AG") )
		{
			EzcCustomerParams customerParams = new EzcCustomerParams();
			EzCustomerStructure ezCustomerStructure = new EzCustomerStructure();
			ezCustomerStructure.setLanguage("EN");
			ezCustomerStructure.setCustomerNo(SelPartnerFunction);
			customerParams.setObject(ezCustomerStructure);
			Session.prepareParams(customerParams);
			retcustadd = (ReturnObjFromRetrieve)CustomerManager.getCustomerAddress(customerParams);
		}
		else
		{
			EzcVendorParams vParams = new EzcVendorParams();
			EzVendorParams vnkparams = new EzVendorParams();
			vnkparams.setLanguage("EN");
			vnkparams.setVendor(SelPartnerFunction);
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
			<%=retcustadd.getFieldValueString(0,EC_NAME_X)%>
			<br>
			<%=(retcustadd.getFieldValueString(0,EC_ADDR_1_X))%>
			<br>
			<%=(retcustadd.getFieldValueString(0,EC_CITY_X))%>
			<br>
<%
			String  state=retcustadd.getFieldValueString(0,EC_STATE_X);
			if(state==null || "null".equals(state))
			{
				state="";
			}
			String  pin=retcustadd.getFieldValueString(0,EC_PIN_X);
			if(pin==null || "null".equals(pin))
			{
				pin="";
			}
%>
			<%=state%>
			&nbsp;&nbsp;
			<%=pin%>
			<br>
			<%=(retcustadd.getFieldValueString(0,"ECA_COUNTRY"))%>
		</Td>
      		</Tr>
<%
		}
		else
		{
			// EZC Customer number needs to take all the way upto save -- 01/09/2000 -- Manne
			// Following line added---- This is to avoid script errors in case of failure
 %>
          	<Tr>
            	<Td >
			<center>There is no Address for the Ezc Customer you entered. Check your number</center>
	    	</Td>
	    	</Tr>
<%
		} //end if cSoldTo
	//}//End if NEW
	fillCount++;
%>
        </Table>
        </Td>
<%
	} //end for
%>
	</Tr>
<%
	}//End if
%>
</Table>
</div>
<%
}//End for
%>
	<input type="hidden" name="ERP_SoldTo" value=<%=erpSoldTo%> >
<%
	int BPRows = busspartnerObj.getRowCount();
%>
<div align=center style="position:absolute;top:90%;width:100%">
    	<input type="image" src = "../../Images/Buttons/<%= ButtonDir%>/synchronize.gif" name="Submit" value="Synchronize" onClick="checkAll();return document.returnValue">
    	<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
    	<input type="hidden" name="FUNCTION" value="<%=FUNCTION%>">
    	<input type="hidden" name="genezc" value="<%=genEzc%>">
    	<input type="hidden" name="Area" value="<%=Area%>" >
</div>
</form>
</body>
</html>

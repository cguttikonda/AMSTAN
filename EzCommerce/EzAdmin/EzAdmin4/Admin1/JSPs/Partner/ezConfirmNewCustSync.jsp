<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Partner/iConfirmNewCustSync.jsp"%>
<%@ page import="java.util.*" %>
<html>
<head>
<Title>Synchronize Base ERP SoldTos</Title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script src="../../Library/JavaScript/Partner/ezConfirmNewCustSync.js"></script>
<Script src="../../Library/JavaScript/ezTabScroll.js"></script>
</head>
<body onLoad='scrollInit()'  onResize="scrollInit()" scroll="no">
<br>
<%
	int AddRows = 0;
	String FUNCTION = request.getParameter("FUNCTION");
	String Area = request.getParameter("Area");

	if ( FUNCTION == null )
		FUNCTION = "AG";
	String arDesc = ( FUNCTION.equals("AG") )?"Sales":"Purchase";
	String arTitle = ( FUNCTION.equals("AG") )?"Customer":"Vendor";
	String arSel = ( FUNCTION.equals("AG") )?"ERP Sold To":"ERP Pay To";

	int fCount = 0;
	try
	{
		int fillCount = 0;
		pSoldTo = request.getParameter("NonBaseERPSoldTo");
		if ( pSoldTo != null && !pSoldTo.trim().equals("") )
		{
			pSoldTo = pSoldTo.trim();
			fillCount++;
			if ( FUNCTION .equals("AG") )
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
				
				//out.println("buss_cust_retObj:"+buss_cust_retObj.toEzcString());
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
				buss_cust_retObj = (ReturnObjFromRetrieve) VendorManager.getVendorsFromErp(vparams);
			}
			buss_cust_retObj.check();
			if ( buss_cust_retObj != null )
			{
				returnObjCheck = true;
		            	if ( FUNCTION.equals("AG") )
		            	{
					busspartnerObj = (ReturnObjFromRetrieve)buss_cust_retObj.getObject("CUSTOMERDETAILS");
					
					//out.println("busspartnerObj:::"+busspartnerObj.toEzcString());
				}
				else
				{
					busspartnerObj = (ReturnObjFromRetrieve)buss_cust_retObj.getObject("VENDORDETAILS");
				}
				busspartnerObj.check();
				String selSoldTo = "";
				int row = 0;
				if ( busspartnerObj.find("PARTFUNCTIONID",FUNCTION) )
				{
					row = busspartnerObj.getRowId("PARTFUNCTIONID",FUNCTION);
					selSoldTo = busspartnerObj.getFieldValueString(row,"ERPCUSTNUMBER");
				}
				if ( busspartnerObj != null ) session.putValue("busspartnerObj",busspartnerObj);
		            	if ( FUNCTION.equals("AG") )
		            	{
					addressObj = (ReturnObjFromRetrieve)buss_cust_retObj.getObject("CUSTOMERADDRESSDETAILS");
				}
				else
				{
					addressObj = (ReturnObjFromRetrieve)buss_cust_retObj.getObject("VENDORADDRESSDETAILS");
				}
				addressObj.check();

				if ( addressObj != null ) session.putValue("addressObj",addressObj);
				AddRows = addressObj.getRowCount();
				
				//out.println("addressObj:::"+addressObj.toEzcString());
%>
<form name=myForm method=post action="ezSaveNewCustSync.jsp">
<input type ="hidden" name ="ReSynchFlag" value = "<%=ReSynchFlag%>">
<%
				if(!"Y".equals(ReSynchFlag))
				{
%>
					<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
				  	<Tr align="center">
			    			<Td class="displayheader"><%=arTitle%> Synchronization</Td>
			  		</Tr>
					</Table>
					<div id="theads">
				 	<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="89%">
			    		<Tr>
			      			<Td width="20%" class="labelcell">Business Partner:</Td>
			      			<Td width="30%" ><a href = "../Partner/ezBPSummaryBySysKey.jsp?WebSysKey=<%=SysKey%>&Area=<%=Area%>&BusinessPartner=<%=BusPartner%>"><%=BPDesc%></a></Td>
		      				<Td width="20%" class="labelcell"><%=arDesc%> Area:</Td>
		      				<Td width="30%" >

<a href= "../Config/ezSetBusAreaDefaults.jsp?Area=<%=Area%>&SystemKey=<%=SysKey%>"><%=request.getParameter("sysKeyDesc")%> (<%=SysKey%>)&nbsp;</a>						</Td>
		    			</Tr>
		  			</Table>
		  			</div>
<%
				}
				else
				{
%>
					<div id="theads">
<%
				}
%>
					<input type="hidden" name="BusPartner" value=<%=BusPartner%> >
					<input type="hidden" readonly size="20" name="BPDesc" value="<%=BPDesc%>" >
					<input type="hidden" readonly size="20" name="SysKey" value="<%=SysKey%>" >
					</div>
<%
				if ( AddRows > 0 )
				{	
					if(!"Y".equals(ReSynchFlag))
					{
%>
						<DIV id="InnerBox1Div">
						<Table id="InnerBox1Tab" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="89%">
						<Tr>
							<Td width="70%" valign="top" class="labelcell">
						        <Table  width="100%" border="0" align="center">
						        <Tr>
						        	<Th width="6%" class="labelcell">Select</Th>
						        	<Th width="10%" class="labelcell" ><b><%=arSel%></b></Th>
						        	<Th width="37%" class="labelcell" ><b>Address</b></Th>
						        </Tr>
<%
						for ( int i = 0 ; i < AddRows; i++ )
						{
							String cSoldTo = addressObj.getFieldValueString(i,"CUSTOMERNUMBER");
							if ( cSoldTo.equals(selSoldTo) )
							{
%>
								<input type="hidden" name="PartNum" value=<%=busspartnerObj.getFieldValue(row,"CUSTOMERNUMBER")%> >
								<input type="hidden" name="PartFun" value=<%=busspartnerObj.getFieldValue(row,"PARTFUNCTIONID")%> >
								<input type="hidden" name="ERPSoldTo" value=<%=busspartnerObj.getFieldValue(row,"PARTNERNUMBER")%> >
					          		<Tr>
          							<Td  align="center">
        							<input type="checkbox" name="CheckBox0" value="Selected" checked>
        							</Td>
        							<Td  align="center">
								<input type="hidden" readonly size="10" maxlength="10" name="SoldTo" value="<%=addressObj.getFieldValue(i,"CUSTOMERNUMBER")%>" >
								<%=addressObj.getFieldValue(i,"CUSTOMERNUMBER")%>
 								</Td>				
            							<Td >
									<input type="hidden" name="CustName" value="<%=addressObj.getFieldValue(i,"NAME1")%>" >
									<input type="hidden" name="Addr1" value="<%=addressObj.getFieldValue(i,"ADDRESS1")%>" >
									<input type="hidden" name="City" value="<%=addressObj.getFieldValue(i,"CITY")%>" >
									<input type="hidden" name="State" value="<%=addressObj.getFieldValue(i,"REGION")%>" >
									<input type="hidden" name="Zip" value="<%=addressObj.getFieldValue(i,"POSTALCODE")%>" >
									<input type="hidden" name="Country" value="<%=addressObj.getFieldValue(i,"COUNTRYKEY")%>" >
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
									
									<%
									for ( int b = 0 ; b < busspartnerObj.getRowCount(); b++ )
									{
										if(busspartnerObj.getFieldValueString(b,"PARTNERNUMBER").equals(addressObj.getFieldValueString(i,"CUSTOMERNUMBER")))
										{												
										%>

										<input type=hidden name=iterm value="<%=busspartnerObj.getFieldValue(b,"INCOTERMS")%>">
										<input type=hidden name=pterm value="<%=busspartnerObj.getFieldValue(b,"PAYMENTTERMS")%>">
										<input type=hidden name=bcode value="<%=busspartnerObj.getFieldValue(b,"BLOCKCODE")%>">
										<input type=hidden name=accgr value="<%=busspartnerObj.getFieldValue(b,"ACCOUNTGROUP")%>">
										<input type=hidden name=prgrp value="<%=busspartnerObj.getFieldValue(b,"PRICEGROUP")%>">
										<input type=hidden name=prdAttrs value="<%=busspartnerObj.getFieldValue(b,"PRODATTRIBUTES")%>">

										<%
										}
									}
									%>

									<%=addressObj.getFieldValue(i,"NAME1")%><br>
									<%=addressObj.getFieldValue(i,"ADDRESS1")%><br>
									<%=addressObj.getFieldValue(i,"CITY")%><br>
									<%=addressObj.getFieldValue(i,"REGION")%><br>
									<%=addressObj.getFieldValue(i,"POSTALCODE")%><br>
									<%=addressObj.getFieldValue(i,"COUNTRYKEY")%><br>
								</Td>
						  		</Tr>
<%
								fCount++;
								break;
							} //end if cSoldto
						}//End for
%>
						<input type="hidden" name="AddCount" value=<%=AddRows%> >
        					</Table>
      						</Td>
    						</Tr>
		  				</Table>
<%
					}
					else
					{
%>
						<br><br><br><br>
						<Table  border=0 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
						<tr>
							<th>Please Wait Retreiving the Data</th>
						</tr>
						</table>
						<br>
						<DIV id="InnerBox1Div">
						<Table id="InnerBox1Tab" border=0 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
						<tr>
<%
						for ( int i = 0 ; i < AddRows; i++ )
						{
							String cSoldTo = addressObj.getFieldValueString(i,"CUSTOMERNUMBER");
							if ( cSoldTo.equals(selSoldTo) )
							{
%>
								<td>
								<!-- Added By Suresh Parimi on 25th September 2003 to Delete existing ERP Customer Details when Re Synch is Called -->
								<input type="hidden" name="CheckBox" value="<%=busspartnerObj.getFieldValue(row,"PARTFUNCTIONID")%>###<%=busspartnerObj.getFieldValue(row,"PARTNERNUMBER")%>###<%=busspartnerObj.getFieldValue(row,"CUSTOMERNUMBER")%>###<%=SysKey%>" >
								<input type="hidden" name="BusinessPartner" value="<%=BusPartner%>" >
								<!-- Addition ends here -->
								<input type="hidden" name="PartNum" value=<%=busspartnerObj.getFieldValue(row,"CUSTOMERNUMBER")%> >
								<input type="hidden" name="PartFun" value=<%=busspartnerObj.getFieldValue(row,"PARTFUNCTIONID")%> >
								<input type="hidden" name="ERPSoldTo" value=<%=busspartnerObj.getFieldValue(row,"PARTNERNUMBER")%> >
								<input type="hidden" readonly size="25" maxlength="25" name="CustName" value="<%=addressObj.getFieldValue(i,"NAME1")%>" >
								<input type="hidden" readonly size="25" maxlength="25" name="Addr1" value="<%=addressObj.getFieldValue(i,"ADDRESS1")%>" >
								<input type="hidden" readonly size="25" maxlength="20" name="City" value="<%=addressObj.getFieldValue(i,"CITY")%>" >
								<input type="hidden" readonly size="25" maxlength="20" name="State" value="<%=addressObj.getFieldValue(i,"REGION")%>" >
								<input type="hidden" readonly size="25" maxlength="10" name="Zip" value="<%=addressObj.getFieldValue(i,"POSTALCODE")%>" >
								<input type="hidden" readonly size="25" maxlength="10" name="Country" value="<%=addressObj.getFieldValue(i,"COUNTRYKEY")%>" >
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
								
								<%
								for ( int b = 0 ; b < busspartnerObj.getRowCount(); b++ )
								{
									if(busspartnerObj.getFieldValueString(b,"PARTNERNUMBER").equals(addressObj.getFieldValueString(i,"CUSTOMERNUMBER")))
									{												
									%>

									<input type=hidden name=iterm value="<%=busspartnerObj.getFieldValue(b,"INCOTERMS")%>">
									<input type=hidden name=pterm value="<%=busspartnerObj.getFieldValue(b,"PAYMENTTERMS")%>">
									<input type=hidden name=bcode value="<%=busspartnerObj.getFieldValue(b,"BLOCKCODE")%>">
									<input type=hidden name=accgr value="<%=busspartnerObj.getFieldValue(b,"ACCOUNTGROUP")%>">
									<input type=hidden name=prgrp value="<%=busspartnerObj.getFieldValue(b,"PRICEGROUP")%>">
									<input type=hidden name=prdAttrs value="<%=busspartnerObj.getFieldValue(b,"PRODATTRIBUTES")%>">

									<%
									}
								}
								%>


								</td>
<%
								fCount++;
								break;
							} //end if cSoldto
						}//End for
%>
						<td><input type="hidden" name="AddCount" value=<%=AddRows%> ></td>
<%
					}
%>
<%
				} //end if AddRows > 0
			} //end if buss_cust_retObj != null
		}//End if pSoldTo
%>
		<input type="hidden" name="TotalCount" value=<%=fCount%> >
<%
	}
	catch (Exception e)
	{
		e.printStackTrace();
	}
%>
	</table>
	</div>
<%
	boolean tmpFlag=false;
%>
	<div id="ButtonDiv" align="center" style="position:absolute;top:80%;width:100%;"><br>
<%
	if(!"Y".equals(ReSynchFlag))
	{
   		if(AddRows > 0)
   		{
%>
	 		<input type="image" src="../../Images/Buttons/<%= ButtonDir%>/synchronize.gif" name="Submit" value="Synchronize" onClick="checkAll(<%=fCount%>);return document.returnValue">
 			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
<% 		} 
		else 
		{
			tmpFlag=true;
 		}
	}
	else
	{
		if(AddRows == 0)
		{
			tmpFlag=true;
		}
	}
%>
	</div>
<%
	if(tmpFlag)
	{
%>
		<br><br><br><br>
		<Table border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="80%">
			<Tr>
				<Th>No data has been retrieved from the <%=mySystemDesc%>.</Th>
			</Tr>
		</Table>
		<br>
		<center>
			<img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" style = "cursor:hand" onClick = "JavaScript:history.go(-1)">
		</center>
<%
	}
%>
	<input type="hidden" name="FUNCTION" value="<%=FUNCTION%>">
	<input type="hidden" name="Area" value="<%=Area%>" >
<%
	if("Y".equals(ReSynchFlag))
	{
%>
		<script>
			document.myForm.submit();
		</script>
<%
	}
%>
</form>
</body>
</html>

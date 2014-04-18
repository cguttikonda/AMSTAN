<%@include file="../../Library/Globals/errorPagePath.jsp"%>
<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<%@include file="../../../Includes/Jsps/Rfq/iViewReportChart.jsp" %>

<head>
      <script src="../../Library/JavaScript/Rfq/ezViewReportChart.js"></Script>
</head>


<html>

<body bgcolor='#FFFFFF'  onResize="scrollInit('SHOWTOT')"   scroll=no>
<form method="post" name="MyForm" >

<input type=hidden name=status value='<%=status%>'>

<Table id="header" style="background-color:#95b2c1" width="100%" border="0" cellspacing="0" cellpadding="0" align="left">
	<Tr>
		<Td width="100%" style="background-color:#95b2c1">
			<Table border="0" cellpadding="0" cellspacing="0" width="100%"  style="background-color:#95b2c1">
				
				<Tr valign="middle" class=trclass height=30 style="background-color:#95b2c1">
					<Td width="20%" align="left" style="background-color:#95b2c1">
						&nbsp; <table border="0" cellspacing="0" cellpadding="0" align = left>
                    <tr>
                      <td class="TDCommandBarBorder" style="background-color:#95b2c1">
                          <table border="0" cellspacing="3" cellpadding="5">
                          <tr style="background-color:#95b2c1">
                             <td nowrap class="TDCmdBtnOff" onMouseDown="changeClass(this,'TDCmdBtnDown')" onMouseUp="changeClass(this,'TDCmdBtnUp')" onMouseOver="changeClass(this,'TDCmdBtnUp')" onMouseOut="changeClass(this,'TDCmdBtnOff')" onClick="javascript:ezHome()" >
                             <b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Home&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>
                        </td>	
                          </tr>
                          </table>
                      </td>
                    </tr>
                  </table>
					</Td>
					<Td width="60%" valign="middle" align="center" left="10%" style="background-color:#95b2c1"><B>
<%
						if("VQH".equals(status))
						{
%>	
							Vendor Quotations History
<%
						}
						else if("VQWH".equals(status))
						{
%>
							Vendor Quotation Wins History
<%
						}
						else if("VQRH".equals(status))
						{
%>
							Quotation Request - Response History
<%
						}
						else if("MMMP".equals(status))
						{
%>
							Material Max - Min Price History
<%
						}
						else if("MAPH".equals(status))
						{
%>
							Materials Average Price History
<%
						}
						else if("CVQH".equals(status))
						{
%>
							Consolidated Vendor Supply History
<%
						}
						else if("MPFH".equals(status))
						{
%>
							Material Purchase Frequency History
<%
						}
						else if("PGEH".equals(status))
						{
%>
							Purchase Area Material Expenditure History
<%
						}
						else if("APGEH".equals(status))
						{
%>
							All Purchase Areas Material Expenditure History
<%
						}
						else if("PGQH".equals(status))
						{
%>
							Purchase Area Material Qunatity History
<%
						}
						else if("APGQH".equals(status))
						{
%>
							All Purchase Areas Material Quantity History
<%
						}
						else if("PGFH".equals(status))
						{
%>
							Purchase Area Material Frequency History
<%
						}
						else if("APGFH".equals(status))
						{
%>
							All Purchase Areas Material Frequency History
<%
						}
						else if("RQPA".equals(status))
						{
%>
							RFQ Wise Quotation Price Analysis
<%
						}
						else if("MAQPH".equals(status))
						{
%>
							Materials Average Quotation Price History
<%
						}
						else if("MPA".equals(status))
						{
%>
							Materials Price Analysis By RFQ						
<%
						}
%>
<script>
	function ezHome()
	{
		document.myForm.action='../Misc/ezSBUWelcome.jsp';
		document.myForm.submit();
	}
	function ezLogout()
	{
		document.myForm.action='../Misc/ezLogout.jsp';
		document.myForm.submit();
	}
</script>


    					</B></Td>
    					<Td width="20%" align="right" style="background-color:#95b2c1">
    						&nbsp; <table border="0" cellspacing="0" cellpadding="0" align = right>
                      <tr>
                        <td class="TDCommandBarBorder" style="background-color:#95b2c1">
                            <table border="0" cellspacing="3" cellpadding="5">
                            <tr>
                               <td nowrap class="TDCmdBtnOff" onMouseDown="changeClass(this,'TDCmdBtnDown')" onMouseUp="changeClass(this,'TDCmdBtnUp')" onMouseOver="changeClass(this,'TDCmdBtnUp')" onMouseOut="changeClass(this,'TDCmdBtnOff')" onClick="javascript:ezLogout()" >
                               <b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Logout&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>
                          </td>	
                            </tr>
                            </table>
                        </td>
                      </tr>
                      </table>
                <br>
    					</Td>
    					
    				</Tr>
    			</Table>
    		</Td>
    	</Tr>
</Table>

<Div id="ezClosedDates" style="position:absolute;width:100%">

   <Table  align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >

   <Tr>	






<%
     if(("PGEH".equals(status)|| "PGQH".equals(status)||"PGFH".equals(status)) && purAreaRetObjCount>0)
     {
	
%>
      <Th>Select Purchase Area</Th>
      <Td><div id="ListBoxDiv2">
	<select name=purarea>
	<option value=''>--Select Purchase Area--</option>
<%
	for(int i=0;i<purAreaRetObjCount;++i)
	{
		String purAreaName=purAreaRetObj.getFieldValueString(i,"PUR_AREA_NAME");
		String purGrp=purAreaRetObj.getFieldValueString(i,"PUR_GRP");
		String purOrg=purAreaRetObj.getFieldValueString(i,"PUR_ORG");	
%>
		<option value='<%=purGrp+"#"+purOrg%>'><%=purAreaName%></option>
<%
	}
%>
	</select>
	</div>
      </Td>		
<%
     }
     else if(("PGEH".equals(status)|| "PGQH".equals(status)|| "PGFH".equals(status)) && purAreaRetObjCount==0)
     {
       goFlag = false;
%>     
       <BR><BR><BR><BR><BR>
       <Th>There Are Purchase Areas Available.</Th>	
<%	
     }
     if("RQPA".equals(status) && retObjCount>0)
     {
	
%>
      <Th>Select Collective RFQ</Th>
      <Td><div id="ListBoxDiv2">
	<select name=rfq>
	<option value=''>--Select RFQ--</option>
<%
	for(int i=0;i<retObjCount;++i)
	{
		
		String crfqNo=retObj.getFieldValueString(i,"CRFQ_NO");
	
%>
	<option value='<%=crfqNo%>'><%=crfqNo%></option>
<%
	}
%>
	</select>
	</div>
      </Td>		
<%
     }
     else if("RQPA".equals(status) && retObjCount==0)
     {
       goFlag = false;
%>     
       <BR><BR><BR><BR><BR>
       <Th>There Are No Colletive RFQ Numbers Available.</Th>	
<%
     }
     else if("VQH".equals(status) || "VQWH".equals(status) || "VQRH".equals(status) || "MAPH".equals(status) || "MPFH".equals(status) || "MAQPH".equals(status) || "PGEH".equals(status) || "APGEH".equals(status) || "PGQH".equals(status) || "APGQH".equals(status) || "PGFH".equals(status) || "APGFH".equals(status))
     {     
%>
      <Th>Select TimePeriod</Th>
      <Td><div id="ListBoxDiv3">
	<select name=time>
	<option value=''>--Select TimePeriod--</option>
	<option value=6>Last 6 Months</option>
	<option value=12>Last 1 Year</option>
	<option value=18>Last 1.5 Years </option>
	<option value=24>Last 2 Years</option>
	</select>
	</div>
      </Td>		
<%
     }
     else if(("MMMP".equals(status)||"MVQPH".equals(status)) || "MPA".equals(status) && retObjCount>0)
     {
%>
      <Th>Select Material</Th>
      <Td><div id="ListBoxDiv2">
	<select name=material>
	<option value=''>--Select Material--</option>
<%
	for(int i=0;i<retObjCount;++i)
	{
		String matCode=retObj.getFieldValueString(i,"ERD_MATERIAL");
		String matDesc=retObj.getFieldValueString(i,"ERD_MATERIAL_DESC");		
	
%>
	<option value='<%=matCode%>'><%=Long.parseLong(matCode)%>--><%=matDesc%></option>
<%
	}
%>
	</select>
	</div>
      </Td>		
<%
     }
     else if(("MMMP".equals(status)||"MVQPH".equals(status)) || "MPA".equals(status)  && retObjCount==0)
     {
	goFlag = false;
%>
	<BR><BR><BR><BR><BR>
	<Th>There Are No Materials Available.</Th>	
<%
     }	
     else if("CVQH".equals(status) && retObjCount>0)
     {
%>
      <Th>Select Vendor</Th>
      <Td><div id="ListBoxDiv2">
	<select name=vendor>
	<option value=''>--Select Vendor--</option>
<%
	for(int i=0;i<retObjCount;++i)
	{
		String vendorCode=retObj.getFieldValueString(i,"EC_ERP_CUST_NO");
		String vendorName=retObj.getFieldValueString(i,"ECA_NAME");
	
%>
	<option value='<%=vendorCode%>'><%=vendorCode%>---><%=vendorName%></option>
<%
	}
%>
	</select>
	</div>
      </Td>		
<%
     }
     else if("CVQH".equals(status) && retObjCount==0)
     {
	goFlag = false;
%>
	<BR><BR><BR><BR><BR>
	<Th>There Are No Vendors Available.</Th>	
<%
     }
     if(goFlag)
     {
%>
      <Td>
        <table border="0" cellspacing="0" cellpadding="0" align = center>
        <tr>
          <td class="TDCommandBarBorder">
              <table border="0" cellspacing="3" cellpadding="5">
              <tr>
                 <td nowrap class="TDCmdBtnOff" onMouseDown="changeClass(this,'TDCmdBtnDown')" onMouseUp="changeClass(this,'TDCmdBtnUp')" onMouseOver="changeClass(this,'TDCmdBtnUp')" onMouseOut="changeClass(this,'TDCmdBtnOff')" onClick="javascript:validate('<%=status%>')" >
                 <b>&nbsp;&nbsp;&nbsp;Go&nbsp;&nbsp;&nbsp;</b>
            </td>	
              </tr>
              </table>
          </td>
        </tr>
        </table>
      </Td>
<%
     }
%>
</Div>

</form>
<Div id="MenuSol"></Div>
</body> 
</html>
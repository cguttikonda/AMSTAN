<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListBusAreas.jsp"%>
<%@ include file="../../../Includes/JSPs/Partner/iListBPBySysKey.jsp"%>
<%@ include file="../../../Includes/JSPs/Partner/iBPCustSyncBySysKey.jsp"%>
<%!
	String cust = "";
	String btn = "";
%>
<html>
<head>
<script src="../../Library/JavaScript/Partner/ezBPCustSyncBySysKey.js"></script>
<Script src="../../Library/JavaScript/ezTabScroll.js"></script>
<Title>Synchronize Base ERP SoldTos</Title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
</head>
<%
	if(ret.getRowCount()!=0)
	{
%>
		<body onLoad='scrollInit()'  onResize='scrollInit()' scroll="no">
<%
	}
	else
	{
%>
		<body>
<%
	}
%>
<br>
<%
	int numBPAreas = 0;
	int numEzc = 0;
	int textBoxCount = 0;
%>
<form name=myForm method=post action="ezConfirmBPCustSyncBySysKey.jsp">
<%
	if (areaFlag.equals("C"))
	{
		cust = "Customers";
		btn = "addcustomer";
	}
	else if (areaFlag.equals("V"))
	{
		cust = "Vendors";
		btn = "addvendor";
	}
	else
	{
		cust = "Service Partners";
		btn = "addservicepartner";
	}
%>
<%
	if(ret.getRowCount()==0)
	{
%>
		<br><br><br><br>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
		<Tr>
			<Td class="displayheader" align="center">No <%=areaLabel%> To List</Td>
		</Tr>
		</Table>
		<input type="hidden" name="Area" value="<%=areaFlag%>">
		<br>
		<center>
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
		</center>
<%
		return;
	}
%>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
  	<Tr align="center">
    		<Td class="displayheader">ERP <%=cTitle%> Data Synchronization</Td>
	</Tr>
	</Table>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
	<Tr align="center">
	<Th width="16%" align="right"><%=areaLabel.substring(0,areaLabel.length()-1)%></Th>
	<Td width="40%" align = "left">
<%
	String wsk=null;
	for(int i=0;i<ret.getRowCount();i++)
	{
		if(websyskey.equals(ret.getFieldValue(i,SYSTEM_KEY)))
		{
			 wsk=ret.getFieldValueString(i,SYSTEM_KEY_DESCRIPTION);
			 break;
		}
	}
%>
		<a href= "../Config/ezSetBusAreaDefaults.jsp?Area=<%=areaFlag%>&SystemKey=<%=websyskey%>"><%= wsk %> (<%=websyskey%>)&nbsp;</a>
	</Td>
      	<Th width="18%" align="right">Business Partner:</Th>
      	<Td width="26%" align = "left">
<%
	String buspar=null;
	for(int i=0;i<ret1.getRowCount();i++)
	{
		if(Bus_Partner.equals(ret1.getFieldValueString(i,"EBPC_BUSS_PARTNER")))
		{
			 buspar=ret1.getFieldValueString(i,"ECA_COMPANY_NAME");
			 break;
		}
	}
%>
	<a href = "../Partner/ezBPSummaryBySysKey.jsp?WebSysKey=<%=websyskey%>&Area=<%=areaFlag%>&BusinessPartner=<%=Bus_Partner%>"><%=buspar%></a>
      	</Td>
	</Tr>
	</Table>
<%
	if(ret1!=null)
	{
		if(ret1.getRowCount()==0 && !"sel".equals(websyskey))
		{
%>
			<input type="hidden" name="Area" value="<%=areaFlag%>">
			<input type="hidden" name="FUNCTION" value="<%=FUNCTION%>">
			<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
			<Tr>
				<Th>
					No Partners Present Under This <%=areaLabel.substring(0,areaLabel.length()-1)%>
				</Th>
			</Tr>
			</Table>
			<br>
			<center>
				<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
			</center>
<% 			
			return;
		}
	}
%>
<%
	if(websyskey!=null && !"sel".equals(websyskey))
	{
		if(!"sel".equals(Bus_Partner))
		{
			numBPAreas = retbpareas.getRowCount();
			numEzc = retFinal.getRowCount();

			String[] sortArrSyn = {"EC_NO"};
			retFinal.sort(sortArrSyn,true);

			String cEzcNo = "";
			String aEzcNo,tEzcNo = "";
			String aEzcName, aEzcAddr1, aEzcCity, aEzcState, aEzcZip, aEzcType, aEzcCountry  = "";
			String aSysKey, aSysDesc, aErpNo = "";
			if ( numBPAreas > 0 )
			{
				if ( numEzc > 0 )
				{
%>
					<div id="theads">
					<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
				    	  	<Tr border="1">
	                             			<Th width="52%"><%=cTitle%>(s)</Th>
	                          			<Th width="28%">ERP System/Organization</Th>
	                          	 		<Th width="20%">ERP <%=cTitle%></Th>
			    			</Tr>
				    	</Table>
			    		</div>
                       			<DIV id="InnerBox1Div">
                       			<Table id="InnerBox1Tab" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="89%">
<%
					for( int i = 0; i < numEzc; i++)
					{
						aEzcType = retFinal.getFieldValueString(i,"EC_PARTNER_FUNCTION").trim();
						aEzcType = aEzcType.trim();
						aEzcNo = retFinal.getFieldValueString(i,"EC_NO").trim();
						aEzcName = retFinal.getFieldValueString(i,"ECA_NAME").trim()+"<br>";
						if (aEzcName.equalsIgnoreCase("null") || aEzcName.length()==0) aEzcName = ""; else aEzcName = aEzcName + "<br>";
							aEzcAddr1 = retFinal.getFieldValueString(i,"ECA_ADDR_1").trim();
						if (aEzcAddr1.equalsIgnoreCase("null") || aEzcAddr1.length()==0) aEzcAddr1 = ""; else aEzcAddr1 = aEzcAddr1 + "<br>";
							aEzcCity = retFinal.getFieldValueString(i,"ECA_CITY").trim();
						if (aEzcCity.equalsIgnoreCase("null") || aEzcCity.length()==0) aEzcCity = ""; else aEzcCity = aEzcCity + "<br>";
							aEzcState = retFinal.getFieldValueString(i,"ECA_STATE").trim();
						if (aEzcState.equalsIgnoreCase("null") || aEzcState.length()==0) aEzcState = ""; else aEzcState = aEzcState + " ";
							aEzcZip = retFinal.getFieldValueString(i,"ECA_PIN").trim();
						if (aEzcZip.equalsIgnoreCase("null") || aEzcZip.length()==0) aEzcZip = "";
							aErpNo  = retFinal.getFieldValueString(i,"EC_ERP_CUST_NO").trim();
%>
<%
				    	  	if ( !aEzcNo.equals(cEzcNo) )
			  			{
%>
							<Tr>
							<label for="cb_<%=i%>">
      	  						<Td valign="top" width="52%"> <b><%=aEzcNo%></b> <%=aEzcName%> <%=aEzcAddr1%>
            						<%=aEzcCity%> <%=aEzcState+" "+aEzcZip%> </Td>
<%
						}
						else
						{
%>
	    			                        <Td width="52%">&nbsp;</Td>

<%
						}
						aSysKey = retFinal.getFieldValueString(i,"EC_SYS_KEY");
						aErpNo = aErpNo.trim();
%>
					       	<Td valign="bottom" width="28%">
            					<input type="radio" name="SysKey" id="cb_<%=i%>" value="<%=aSysKey%>#<%=aErpNo%>"><%=aSysKey%>
						
    						</Td>
          					<Td valign="bottom" width="20%">
          						<%=aErpNo%>
          					<input type="hidden" name="ERPCUST"   value="<%=aErpNo%>" >
    						</Td>
						</label>
				    		</Tr>
						<input type="hidden" name="EzcCustomer" value="<%=aEzcNo%>">
						<input type="hidden" name="AREA" value="<%=aSysKey%>">
<%
						cEzcNo = aEzcNo;
						textBoxCount++;
						if ( i != (numEzc-1) )
						{
							tEzcNo = retFinal.getFieldValueString(i+1,"EC_NO");
						}
						if ( !aEzcNo.equals(tEzcNo) || (i == numEzc-1) )
						{
%>
<%
						} //end if checkChange
%>
<%
					} //end for i < numEzc
%>
					</Table>
					</div>
<%

	     			} //if numEzc > 0
	     			else
				{
%>
					<br><br><br><br>
					<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
					<Tr>
						<Td class="labelcell" align="center">
					    	  <b>No <%=cust%> are Synchronized to this Partner</b>
				    	</Td>
				  	</Tr>
					 </Table>
<%
				}
			} //end if retbpareas > 0
%>
<%
	if ( numBPAreas > 0  )
	{
%>
	<br>

	<div id="ButtonDiv" align=center style="position:absolute;top:90%;width:100%">
<%   if ( numEzc > 0 ) { %>
		<input type="image" src="../../Images/Buttons/<%= ButtonDir%>/synchronize.gif"  onClick="checkAll();return document.returnValue">
<% } %>
		<img src="../../Images/Buttons/<%= ButtonDir%>/<%=btn%>.gif" onClick="addcust('<%=FUNCTION%>')" style="cursor:hand"  border=none>
		
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

	</div>
<%
	} //end if retbpareas
%>
		<input type="hidden" name="TotalCount" value=<%=textBoxCount%> >
<%
	}
	else
	{
%>
		<br><br>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
			<Tr>
				<Td class = "labelcell">
				<div align="center"><b>Please Select Bussiness Partner to continue.</b></div>
				</Td>
			</Tr>
		</Table>
		<br>
		<center><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a></center>

<%

	}
	}
	else
	{
%>
		<br><br>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
			<Tr>
				<Td class = "labelcell">
				<div align="center"><b>Please Select <%=areaLabel.substring(0,areaLabel.length()-1)%> and Bussiness Partner to continue.</b></div>
				</Td>
			</Tr>
		</Table>
		<br>
		<center><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a></center>



<%
	}
	//}//end if BPs >0

%>
<input type="hidden" name="FUNCTION" value="<%=FUNCTION%>">
<input type="hidden" name="Area" value="<%=areaFlag%>" >
<input type="hidden" name="BusinessPartner" value="<%=Bus_Partner%>" >

<input type=hidden name="WebSysKey" value="<%=websyskey%>">


</form>
</body>
</html>

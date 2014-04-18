<%@ include file="../../../Includes/JSPs/Config/iListBusAreas.jsp"%>
<%@ include file="../../../Includes/JSPs/Partner/iListBPBySysKey.jsp"%>
<%@ include file="../../../Includes/JSPs/Partner/iBPDelCustSyncBySysKey.jsp"%>
<html>
<head>
<script src="../../Library/JavaScript/Partner/ezBPDelCustSyncBySysKey.js"></script>
<Script src="../../Library/JavaScript/ezTabScroll.js"></script>
<Title>Delete ERP SoldTos and Partner Functions</Title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<body bgcolor="#FFFFF7" onLoad='scrollInit()'>
<%
	int numBPAreas = 0;
	int numEzc = 0;
	int textBoxCount = 0;
%>
<form name=myForm method=post action="ezDelCustSyncBySysKey.jsp">
<br>
<%
	if ( ret.getRowCount() == 0 )
	{
%>
		<br>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
			<Tr align="center">
				<Td class="displayheader">There are No  <%=areaLabel%> </Td>
			</Tr>
		</Table>
		<input type="hidden" name="Area" value="<%=areaFlag%>" >
		<input type="hidden" name="flag" value="" >
		<br>
		<center>
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
		</center>
<%     
		return;
	}
%>
	<Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
  	<Tr align="center">
    		<Td class="displayheader">ERP <%=cTitle%> Deletion</Td>
  	</Tr>
	</Table>
	<Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr align="center">
		<Th width="16%" align = "right"><%=areaLabel.substring(0,areaLabel.length()-1)%>&nbsp;:</Th>
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
		<a href= "../Config/ezSetBusAreaDefaults.jsp?Area=<%=areaFlag%>&SystemKey=<%=websyskey%>"><%= wsk %> (<%=websyskey%>)</a>&nbsp;
		</Td>
      		<Th width="18%" align="right">Business Partner:</Th>
      		<Td width="25%" align = "left">
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
		if(buspar == null)
			buspar=request.getParameter("BusParCompName");
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
				<br>
				<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
			  	<Tr align="center">
			    		<Td class="labelcell">There are No Business Partners In This <%=areaLabel.substring(0,areaLabel.length()-1)%> </Td>
			  	</Tr>
			</Table>
			<input type="hidden" name="Area" value="<%=areaFlag%>" >
			<input type="hidden" name="flag" value="" >
<%     
			return;
			}
		}
%>
<%
		if(ret1!=null && !"sel".equals(websyskey))
		{
			if(!"sel".equals(Bus_Partner))
			{
				numEzc = retFinal.getRowCount();
				String cEzcNo = "";
				String cSysKey = "";
				String aEzcNo,tEzcNo = "";
				String aEzcName, aEzcAddr1, aEzcCity, aEzcState, aEzcZip, aEzcType  = "";
				String aSysKey, aSysDesc, aErpNo = "";
				if ( numEzc > 0 )
				{
%>
				 	<div id="theads">
					<Table id="tabHead"  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
				    	<Tr border="1">										
						<Th width = "39%"><%=cTitle%>(s)</Th>
						<Th width = "13%">ERP System</Th>
						<Th width = "23%">Function</Th>
						<Th width = "25%">ERP <%=cTitle%></Th>
				    	</Tr>
		    			</Table>
					</div>
					<DIV id="InnerBox1Div">
					<Table id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
					<Tr>
<%
					boolean firstTextBox = true;
					int l=0;
					for( int i = 0; i < numEzc; i++)
					{					
						aEzcType = retFinal.getFieldValueString(i,"EC_PARTNER_FUNCTION").trim();
						aEzcType = aEzcType.trim();
						aEzcNo = retFinal.getFieldValueString(i,"EC_NO").trim();						
						aEzcName = retFinal.getFieldValueString(i,"ECA_NAME").trim();						
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
						<label for="cb_<%=l%>">
<%

						if ( !aEzcNo.equals(cEzcNo) )
						{
%>
							<Td valign="top" width = "39%">
							<b><%=aEzcNo%>&nbsp;</b>
<!-- 
	Added this hidden field for deleting the duplicate customers
	Modification done by satya -- 21012005 
-->							
<input type=hidden name='aEzcNo' value='<%=aEzcNo%>'>
							<%=aEzcName%>
							<%=aEzcAddr1%>
							<%=aEzcCity%>
							<%=aEzcState+" "+aEzcZip%>
							</Td>
<%					
						}
						else
						{
%>
							<Td width = "39%">&nbsp;</Td>
<%
						}
						aSysKey = retFinal.getFieldValueString(i,"EC_SYS_KEY");
				
						String ReadOnly = "";
						aErpNo = aErpNo.trim();
						ReadOnly = (aErpNo.equals(""))?"":"readonly";
%>
    						<Td valign="bottom" width = "13%"><a href= "../Config/ezSetBusAreaDefaults.jsp?Area=<%=areaFlag%>&SystemKey=<%=websyskey%>"><%= wsk %> (<%=websyskey%>)</a>&nbsp;</Td>
    						<Td valign="bottom" width = "23%">
       						<input type="checkbox" name="CheckBox" id="cb_<%=l%>" value="<%=FUNCTION%>###<%=aErpNo%>###<%=aEzcNo%>###<%=aSysKey%>" ><b><%=cDesc%></b>
    						</Td>
						<Td valign="bottom" width = "25%"><%=aErpNo%></Td>
						</label>
						</Tr>
<%
						cEzcNo = aEzcNo;
						textBoxCount++;
%>
						<%@ include file="ezDisplayPartnerFunctions.jsp"%>
<%		
						if ( i != (numEzc-1) )
						{
							tEzcNo = retFinal.getFieldValueString(i+1,"EC_NO");
						}
						if ( !aEzcNo.equals(tEzcNo) || (i == numEzc-1) )
						{
%>	
<%
						} //end if!aEzcNo.equals(tEzcNo)
						l++;
					} //end for i < numEzc
%>
					</Table>
					</div>
					<div align=center style="position:absolute;top:90%;width:100%">
						<input type="image" src="../../Images/Buttons/<%= ButtonDir%>/delete.gif" onClick="delsync();return document.returnValue" style="cursor:hand;">
						<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
						<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
					</div>
<%
		   		}
			     	else
			     	{
%>
					<br><br><br><br>
					<div align="center">
					<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
					<Tr>
						<Td class = "labelcell">
						<div align="center"><b>	This Business Partner has no ERP <%=cTitle%>.</b></div>
						</Td>
					</Tr>
					</Table>
					<br>
						<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
					</div>
<%
     			  	}
%>
<%
  			}
  			else
  			{
 %>
				 <br><br><br><br>
			 	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
			 	<Tr>
		 		<Td class = "labelcell">
		 			<div align="center"><b>Please Select Bussiness Partner  to continue.</b></div>
		 		</Td>
		 		</Tr>
				</Table>
				<br>
				<center>
					<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
				</center>
 <%
			}
		}
     		else
     		{
  %>
  			<br><br><br><br>
  			<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
  			<Tr>
  				<Td class = "labelcell">
  					<div align="center"><b>Please Select <%=areaLabel.substring(0,areaLabel.length()-1)%> and Bussiness Partner to continue.</b></div>
  				</Td>
  			</Tr>
			</Table>
			<br>
			<center>
				<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
			</center>
<%
	     	}
%>
		<input type="hidden" name="FUNCTION" value="<%=FUNCTION%>">
		<input type="hidden" name="Area" value="<%=areaFlag%>">
		<input type="hidden" name="WebSysKey" value="<%=websyskey%>" %>
		<input type="hidden" name="BusinessPartner" value="<%=Bus_Partner%>" >
		<input type="hidden" name="BusParCompName" value="<%=buspar%>"> 
</form>
<%
		String saved = request.getParameter("saved");
		if ( saved != null && saved.equals("Y") )
		{
%>
			<script language="JavaScript">
				alert('Delete successful');
			//history.go(-2);
			</script>
<%
		}
%>
</body>
</html>
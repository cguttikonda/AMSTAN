<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListBusAreas.jsp"%>
<%@ include file="../../../Includes/JSPs/Partner/iListBPBySysKey.jsp"%>
<%@ include file="../../../Includes/JSPs/Partner/iBPCustSyncBySysKey.jsp"%>

<html>
<head>
<script src="../../Library/JavaScript/Partner/ezBPSetDefaultsBySysKey.js">
</script>

<Script src="../../Library/JavaScript/ezTabScroll.js"></script>
<Title>Business Partner Defaults</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<%
	if(ret.getRowCount()!=0)
	{
%>
		<body bgcolor="#FFFFF7" onLoad='scrollInit()' onResize='scrollInit()'>
<%
	}
	else
	{
%>
		<body bgcolor="#FFFFF7" onLoad='scrollInit()'>
<%
	}
%>
<br>
<%
   if(ret.getRowCount()==0)
    {
%>
	<br><br><br>
         <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	  <Tr>
	     <Td class="displayheader">
	      <div align="center">No <%=areaLabel%> To List</div>
	    </Td>
	  </Tr>
	 </Table>
	<input type="hidden" name="Area" value="<%=areaFlag%>">
	<input type ="hidden" name="flag" value="1">
<br>
<center><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</center>

<%
	return;
	}

%>
<%
	int numBPAreas = 0;
	int numEzc = 0;
	int textBoxCount = 0;

	String SADescription=request.getParameter("SADesc");
%>

<form name=myForm method=post action="ezBPDefaultsListBySysKey.jsp">

	<Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr align="center">
		<Th width="17%" align = "right">&nbsp;<%=areaLabel.substring(0,areaLabel.length()-1)%>&nbsp;:</Th>
  		<Td width="40%" align = "left"><a href= "../Config/ezSetBusAreaDefaults.jsp?Area=<%=areaFlag%>&SystemKey=<%=websyskey%>"><%=SADescription%></a>&nbsp;</Td>
		<Th width="18%" align = "right">Business Partner:</Th>
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
				<input type ="hidden" name="flag" value="1">

				<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
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

	if(ret1!=null && !"sel".equals(websyskey))
	{
		if(Bus_Partner!=null && !"sel".equals(Bus_Partner))
		{
			numBPAreas = retbpareas.getRowCount();
			numEzc = retFinal.getRowCount();

			String[] sortArrDef = {"EC_NO"};
			retFinal.sort(sortArrDef,true);

			// variables starting with a stands for actual, c stands for changed
			String cEzcNo = "";
			String aEzcNo,tEzcNo = "";
			String aEzcName, aEzcAddr1, aEzcCity, aEzcState, aEzcZip, aEzcType  = "";
			String aSysKey, aSysDesc, aErpNo = "";
			String erpCustName="";
			if ( numBPAreas > 0 )
			{
				/** if getEzcCustomers more than 0 then only print headers **/
				if ( numEzc > 0 )
				{
%>
					<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
					<Tr align="center">
						<Td class="displayheader">Business Partner Defaults</Td>
					</Tr>
					</Table>

					<div id="theads">
					<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0">
					<Tr border="1">
						<Th width="34%"><%=cTitle%>(s)</Th>
						<Th width="37%">ERP System/Organization</Th>
						<Th width="29%">ERP <%=cTitle%></Th>
					</Tr>
					</Table>
					</div>

					<DIV id="InnerBox1Div">
					<Table id="InnerBox1Tab" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0">
<%
					boolean firstTextBox = true;
					for( int i = 0; i < numEzc; i++)
					{
						aEzcType = retFinal.getFieldValueString(i,"EC_PARTNER_FUNCTION");
						aEzcType = aEzcType.trim();
						aEzcNo = retFinal.getFieldValueString(i,"EC_NO");
						aEzcName = retFinal.getFieldValueString(i,"ECA_NAME");
						aEzcAddr1 = retFinal.getFieldValueString(i,"ECA_ADDR_1");
						aEzcCity = retFinal.getFieldValueString(i,"ECA_CITY");
						aEzcState = retFinal.getFieldValueString(i,"ECA_STATE");
						aEzcZip = retFinal.getFieldValueString(i,"ECA_PIN");
						aErpNo  = retFinal.getFieldValueString(i,"EC_ERP_CUST_NO");
						erpCustName = retFinal.getFieldValueString(i,"ECA_COMPANY_NAME");
						aSysKey = retFinal.getFieldValueString(i,"EC_SYS_KEY");
						if(!websyskey.equals(aSysKey))
							continue;
%>

						<Tr>
						<label for="cb_<%=i%>"> 
<%
						/** If EzcNo changes then only print address depending on function type C or V **/
						if ( !aEzcNo.equals(cEzcNo) )
						{
%>
							<Td valign="top" width="34%"> <b><%=aEzcNo.trim()%></b> <br>
								<%=aEzcName%>
							</Td>
<%
						}
						else
						{
%>
							<Td width="1%"></Td>
<%
						} //end if !aEzcNo

						
						String ReadOnly = "";
						aErpNo = aErpNo.trim();
						if ( !aErpNo.equals("") )
						{
%>
							<Td valign="bottom" width="37%">
								<input type="radio" name="SysKey" id="cb_<%=i%>" value="<%=aSysKey%><%=aSysKey%>">
								<a href= "../Config/ezSetBusAreaDefaults.jsp?Area=<%=areaFlag%>&SystemKey=<%=aSysKey%>"</a><%=aSysKey%>

							</Td>
							<Td valign="bottom" width="29%" title=""<%=aErpNo%>"">
								<input type="textbox" class="DisplayBox" name="ERPCUST" readonly value="<%=aErpNo%>">
								<input type=hidden name="A<%=aErpNo%>" value="<%=erpCustName%>">
							</Td>
						</label>
						</Tr>
						<input type="hidden" name="EzcCustomer" value="<%=aEzcNo%>">
						<input type="hidden" name="AREA" value="<%=aSysKey%>">
<%
						cEzcNo = aEzcNo;
						} //end if !aErpNo.equals""

						if ( i != (numEzc-1) )
						{
							tEzcNo = retFinal.getFieldValueString(i+1,"EC_NO");
						}

						if ( !aEzcNo.equals(tEzcNo) || (i == numEzc-1) )
						{
%>
						<Tr height="3">
							<Th colspan="4" bgcolor="#336699"></Th>
						</Tr>
<%
						} //end if checkChange
					} //end for i < numEzc
%>
					</Table>
					</div>


<%
				} //if numEzc > 0
 			} //if ( numBPAreas > 0 )
		}//if(Bus_Partner!=null && !"sel".equals(Bus_Partner))
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
			<center>
				<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
			</center>
<%
		}

	}//if(ret1!=null && !"sel".equals(websyskey))
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
		<center>
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
		</center>
<%
	}
	if ( numBPAreas > 0  )
	{
%>
		<br>
<%
		if ( numEzc > 0 )
		{
%>
			<div id="ButtonDiv" align=center style="position:absolute;top:90%;width:100%">
			<input type="image" src="../../Images/Buttons/<%= ButtonDir%>/setpartnerdefaults.gif" onClick="checkAll();return document.returnValue">
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
			</div>

<%
		}
		else
		{
%>
			<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
			<Tr>
			<Th>
				There are no ERP Customers or Vendors Synchronized
			</Th>
			</Tr>
			</Table>
			<br>
			<center>
				<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
			</center>


<%
		}
%>

<%
	} //end if retbpareas
%>

	<input type="hidden" name="FUNCTION" value="<%=FUNCTION%>">
	<input type="hidden" name="SoldTo" value="">
	<input type="hidden" name="Area" value="<%=areaFlag%>">
	<input type="hidden" name="area" value="" >
	<input type="hidden" name="WebSysKey" value="<%=websyskey%>" >
	<input type="hidden" name="BusinessPartner" value="<%=Bus_Partner%>" >
	<input type="hidden" name="SADesc" value="<%=SADescription%>">
</form>
</body>
</html>

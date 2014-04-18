<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Partner/iBPCustSync.jsp"%>

<html>
<head>
 <script src="../../Library/JavaScript/Partner/ezBPSetDefaults.js" >
 </script>
 
<Script src="../../Library/JavaScript/ezTabScroll.js"></script>
<Title>Business Partner Defaults</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<br>
<body bgcolor="#FFFFF7" onLoad='scrollInit()' onResize='scrollInit()' scroll="no">
<%
int numBPAreas = 0;
int numEzc = 0;
int textBoxCount = 0;
if(numBPs > 0)
{
%>

<form name=myForm method=post action="ezBPDefaultsList.jsp">
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="50%">
    <Tr>
      <Td width="43%" class="labelcell">Business Partner:</Td>
      <Td width="57%" colspan="2" >
      <%@ include file="../../../Includes/Lib/ListBox/LBBusPartner2.jsp"%></Td>
    </Tr>
  </Table>
  <br>

<%
	numBPAreas = retbpareas.getRowCount();
	numEzc = retFinal.getRowCount();

	String[] sortArr = {"EC_NO"};
	retFinal.sort(sortArr,true);

	// variables starting with a stands for actual, c stands for changed
	String cEzcNo = "";
	String aEzcNo,tEzcNo = "";
	String aEzcName, aEzcAddr1, aEzcCity, aEzcState, aEzcZip, aEzcType  = "";
	String aSysKey, aSysDesc, aErpNo = "";
	if ( numBPAreas > 0 )
	{
		/** if getEzcCustomers more than 0 then only print headers **/
		if ( numEzc > 0 )
		{
%>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
  <Tr align="center">
    <Td class="displayheader">Business Partner Defaults</Td>
  </Tr>
</Table>
  <div id="theads">
<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
    <Tr border="1">
      <Th><%=cTitle%>(s)</Th>
      <Th>ERP System/Organization</Th>
      <Th>ERP <%=cTitle%></Th>
    </Tr>
   </Table>
  </div>
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
%>

<DIV id="InnerBox1Div">
<Table id="InnerBox1Tab" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
   <Tr>
<%
				/** If EzcNo changes then only print address depending on function type C or V **/
				if ( !aEzcNo.equals(cEzcNo) )
				{
%>
      	<Td valign="top">
      	  <b><%=aEzcNo.trim()%></b>
	  <br><%=aEzcName%>

	</Td>
<%
				}
				else
				{
%>
	<Td></Td>
<%
				} //end if !aEzcNo

				aSysKey = retFinal.getFieldValueString(i,"EC_SYS_KEY");
				String ReadOnly = "";
				aErpNo = aErpNo.trim();
				if ( !aErpNo.equals("") )
				{
%>
    <Td valign="bottom">
      <input type="radio" name="SysKey" value="<%=textBoxCount%>"><%=aSysKey%>
    </Td>
    <Td valign="bottom">
      <input type="textbox" name="ERPCUST_<%=textBoxCount%>" readonly value="<%=aErpNo%>">
    </Td>
    </Tr>
	<input type="hidden" name="EzcCustomer_<%=textBoxCount%>" value="<%=aEzcNo%>">
	<input type="hidden" name="AREA_<%=textBoxCount%>" value="<%=aSysKey%>">
<%
				cEzcNo = aEzcNo;
				textBoxCount++;
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
	     	} //if numEzc > 0
	}
	else
	{
%>
	<Table  align="center">
    <Tr>
      <Td colspan="4" align="center" >Business Partner has no areas assigned to him</Td>
    </Tr>
    </Table>
<%
	} //end if retbpareas > 0
%>
</Table>
</div>


<%
	}//end if BPs >0
	else
		{
%>
		<br><br><br>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
		<Tr>
			<Td class="displayheader">
	      		<div align="center">No Partners to List</div>
	    		</Td>
	  	</Tr>
	  	</Table>
	  	<br>
		<center><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

</center>
<%
		}
	if ( numBPAreas > 0  )
	{
%>
	<br>
<div align=center style="position:absolute;top:70%;left:25%">
<%   if ( numEzc > 0 ) { %>

	<input type="image" src="../../Images/Buttons/<%= ButtonDir%>/setpartnerdefaults.gif" onClick="checkAll(<%=textBoxCount%>);return document.returnValue">
<% }
   else
   {
%>
	There are no ERP Customers or Vendors Synchronized
<%
   }
%>
	</div>
<%
	} //end if retbpareas
%>
	<input type="hidden" name="TotalCount" value=<%=textBoxCount%> >
<input type="hidden" name="FUNCTION" value="<%=FUNCTION%>">
<input type="hidden" name="SoldTo" value="">
<input type="hidden" name="area" value="">
</form>
</body>
</html>

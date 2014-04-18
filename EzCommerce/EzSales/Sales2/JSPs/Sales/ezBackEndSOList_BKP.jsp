<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iBackEndSOList_Lables.jsp"%>
<%@ include file="../../../Includes/JSPs/Sales/iBackEndSOList.jsp"%>
<html>
<head>
	<Title>List of Sales Orders-Powered by EzCommerce Inc</title>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<Script>
		  var tabHeadWidth=95
 	   	  var tabHeight="60%"
</Script>
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>

<Script>
	function movetoHome()
	{
		document.location.href="../Misc/ezWelcome.jsp";
	}
	function funShowEdit(SoNo,SoldTo)
	{
             if(document.SOForm.onceSubmit.value!=1){
		document.SOForm.onceSubmit.value=1
		document.SOForm.Back.value=SoNo
		document.SOForm.SoldTo.value=SoldTo
		document.SOForm.pageUrl.value="EditBackOrder"
		document.SOForm.status.value="O"
		document.SOForm.target = "main"
		document.SOForm.action="../Sales/ezBackWaitSalesDisplay.jsp"
		document.body.style.cursor="wait"
		document.SOForm.submit();
	       }
	}
	function funShowEdit1(SoNo,SoldTo)
	{
	     if(document.SOForm.onceSubmit.value!=1){
		document.SOForm.onceSubmit.value=1
		document.SOForm.SONumber.value=SoNo
		document.SOForm.SoldTo.value=SoldTo
		document.SOForm.status.value="O"
		document.SOForm.pageUrl.value="BackOrder"		
		document.SOForm.target = "main"		
		document.SOForm.action="../Sales/ezBackWaitSalesDisplay.jsp"
		document.body.style.cursor="wait"
		document.SOForm.submit();
        	}
	}
	function funSubmit()
	{
		if(document.SOForm.customer.selectedIndex==-1)
		{
			alert("Please Select Stockist(s)");
		}
		else
		{
			document.SOForm.action="ezBackEndSOList.jsp"
			document.SOForm.submit();
		}
	}

</Script>
</head>
<body onLoad=scrollInit() onResize=scrollInit() scroll=no >
<form name="SOForm" method="post">
<input type="hidden" name="Back">
<input type="hidden" name="status">
<input type="hidden" name="pageUrl">
<input type="hidden" name="SONumber">
<input type="hidden" name="SoldTo">
<input type=hidden name=orderType value="Open">
<input type="hidden" name="onceSubmit" value=0>



<%
	int p = 0;
	if(customer == null)
	{
%>

		<table align=center border="0" cellpadding="0" class="displayheaderback" cellspacing="0" width="100%">
		<Tr align="center">
		    <td height="35" class="displayheaderback" align="left" width="60%">Select Stockist(s) to View Accepected orders</Td>
		 </Tr>
		</Table>
<%
	}
	else if(cnt==0)
	{
%>

		<table align=center border="0" cellpadding="0" class="displayheaderback" cellspacing="0" width="100%">
		<Tr align="center">
		    <td height="35" class="displayheaderback"  align="center" width="100%">
			View Accepected orders</Td>
		 </Tr>
		</Table>
<%
	}
	else if(cnt>0)
	{
%>
		<table align=center border="0" cellpadding="0" class="displayheaderback" cellspacing="0" width="100%">
		<tr>
		    <td height="35" class="displayheaderback"  align="center" width="100%"><%=accepSaleOrdLi_L%></td>
		</tr>
		</table>


<%
	}

	if(custcount >1)
	{

%>
	<Table width="50%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0>
	<Tr align="center">
		<Th class="displayheader">Select Stockist(s)</th>
		<Td class="displayheader">
			<div id="ListBoxDiv1">
			<select name="customer" size="3" multiple>
				<%

					for(int i=0;i<custcount;i++)
					{
						String selected1="";
						String erpCode = retCustList.getFieldValueString(i,"EC_ERP_CUST_NO");
						if(customer != null)
						{

							for(int j=0;j<customer.length;j++)
							{
								if(customer[j].equals(erpCode))
								{
									selected1="selected";
									break;
								}
							}
						}
						out.println("<option value='"+erpCode+"'" +selected1+">"+retCustList.getFieldValueString(i,"ECA_NAME")+"</option>");
					}
				%>
			</select>
			</div>
		</Td>
		<Td>
			<a href='javaScript:funSubmit()'><img src="../../Images/Buttons/<%= ButtonDir%>/go.gif" <%=statusbar%> border="none"></a>
		</Td>
	 </Tr>
	</Table>
<%
	}else if(custcount == 1)
	{
		out.println("<input type=hidden name=customer value="+retCustList.getFieldValueString(0,"EC_ERP_CUST_NO")+" >");
	}

{
if(cnt >0)
{

%>

<span id="divdisplay" display="block">


<Div id="theads">
<Table id="tabHead" width="95%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0>
	<Tr align="center" valign="middle">
		<Th width="18%"><%=salOrdNo_L%></Th>
		<Th width="15%"><%=orderDate_L%></Th>
		<Th width="23%"><%=poNo_L%></Th>
		<Th width="14%"><%=poDate_L%></Th>
		<Th width="30%"><%=customer_L%></Th>
	</Tr>
	</table>
  </Div>
  </span>

<%
if(custcount >1){
%>
 		<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:95%;height:40%;left:2%">
<%}else{%>
 	   	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:95%;height:60%;left:2%">
<%}%>

	<Table id="InnerBox1Tab"  align=center  border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="100%">
<%
	String agent=(String)session.getValue("Agent");


	FormatDate fD=new FormatDate();
	int LrowCount=orderList.getRowCount();

	 for(int i=0;i<LrowCount;i++)
	{

		p++;
		String soNumber=orderList.getFieldValueString(i,"SdDoc");
		String soCust = orderList.getFieldValueString(i,"SoldTo");
		String podate=ret.getFieldValueString(i,"ValidFrom");
		String netValue=orderList.getFieldValueString(i,"NetValHd");
		String cuname=orderList.getFieldValueString(i,"Name");
		//String cuname=(String)session.getValue("Agent");


		cuname=(cuname == null || "null".equals(cuname))?"":cuname;

		podate=(podate.length()>10)?" ":podate;

		String pono = orderList.getFieldValueString(i,"PurchNo");
		if( (pono == null ) || (pono.trim().length() == 0) )
			pono ="N/A";
	%>
		<Tr>
			<Td width="18%"><a href="JavaScript:void(0)" onClick='funShowEdit1("<%=soNumber%>","<%=soCust%>")'><%try{ out.println(Long.parseLong(soNumber));}catch(Exception e){out.println(soNumber);}%></a>&nbsp;</Td>
			<Td  width="15%" align="center"><%=ret.getFieldValueString(i,"DocDate")%>&nbsp;</Td>
			<Td  width="23%">
				<% if (!pono.equals("N/A")){%>
					<a href="JavaScript:void(0)" onClick='funShowEdit("<%=soNumber%>","")' ><%=pono%></a>
				<%}else{out.println(pono); }%>
			&nbsp;</Td>
			<Td  width="14%" align="center"><%=podate%>&nbsp;</Td>
			<Td  width="30%" title="<%=cuname%>">
			<%
				if(cuname.length()>31)
				{
					out.println(cuname.substring(0,30));
				}
				else
				{
					out.println(cuname);
				}
			%>
			&nbsp;</Td>
		</Tr>
	<%

	}

	%>

	</Table>
	</Table>
	</Div>
<%
}else{
%>
<br><br><br><br>
<table align=center border="0" cellpadding="0"  cellspacing="0" width="100%">
	<Tr align="center">
		    <td height="35" class="displayalert">
		No  Accepected orders for these Customer(s)</Td>
	 </Tr>
</Table>
<%
}

%>
	<div id="buttonDiv"  align="center" style="position:absolute;top:90%;width:100%">
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	buttonName.add("Back");
	buttonMethod.add("movetoHome()");
	out.println(getButtonStr(buttonName,buttonMethod));
%>
	</div>
<%

}
%>
</form>
<Div id="MenuSol"></Div>
</body>
</html>

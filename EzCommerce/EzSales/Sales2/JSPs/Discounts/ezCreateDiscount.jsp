<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%@ include file="../../../Includes/JSPs/Discounts/iCreateDiscount.jsp"%> 
<html>
<head>
	<Title>Create Discount-- Powered by EzCommerce Inc</Title>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<Script>
	function mfrSearch()
	{
		var url="ezSelectManufacture.jsp";
		newWindow=window.open(url,"SearchWin","width=550,height=350,left=180,top=180,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
	}
	function funCreate()
	{
		var mfr = document.myForm.mfr.value;
		var discount = document.myForm.discount.value;
		var manfId = document.myForm.manfId.value;
		
		//alert(mfr);
		//alert(manfId);
		
		if(mfr=='')
		{
			alert("Please select a Manufacture");
			document.myForm.mfr.focus()
			return;
		}
		else if(discount=='')
		{
			alert("Please enter Discount");
			document.myForm.discount.focus()
			return;
		}
		else
		{
			if(isNaN(discount))
			{
				alert("Please enter valid Discount");
				document.myForm.discount.value="";
				document.myForm.discount.focus();
				return;
			}
			else
			{
				buttonsSpan=document.getElementById("EzButtonsSpan")
				buttonsMsgSpan=document.getElementById("EzButtonsMsgSpan")
				if(buttonsSpan!=null)
				{
					buttonsSpan.style.display="none"
					buttonsMsgSpan.style.display="block"
				}
			
				document.myForm.action="ezAddSaveDiscount.jsp"; 
				document.myForm.submit();
			}
		}	
	}
</Script>
<Script src="../../Library/JavaScript/Misc/ezTrim.js"></Script>

</head>
<body scroll=no>
<form method="post" name="myForm">
<%
	String display_header = "Create Discount";
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<br><br>
<input type="hidden" name="manfId" value="<%=manfId%>">

	<Div align=center>
	<Table  width="60%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1>
	<Tr>
		<Th width = "50%" align="right">Manufacturer *</Th>
		<Td width = "50%"><input type = "text" class = "InputBoxTest" name = "mfr" size = 25 value="<%=manfDesc%>" readonly>
		<a href="javascript:mfrSearch()" style="cursor:hand;text-decoration: none">
		 &nbsp;<img src="../../Images/Common/search-icon.gif" border=0></a>
		</Td>
	</Tr>
		<Tr>
			<Th width = "50%" align="right">Item Category</Th>  
			<Td width = "50%">
<%
			if(retCatCnt>0)
			{
%>
				<select name= "itemCat" id=listBoxDiv style="border:1px solid">
					<option value="">--Select--</option>
<%
				retCat.sort(new String[]{"Description"},true);
				String catID = "",catDesc="";
				
				for(int i=0;i<retCatCnt;i++)
				{
					catID = retCat.getFieldValueString(i,"CatID");
					catDesc = retCat.getFieldValueString(i,"Description");
					
					if(catID.equals(itemCat))
					{
%>
						<option value="<%=catID%>" selected><%=catDesc%></option>
<%
					}
					else
					{
%>
						<option value="<%=catID%>"><%=catDesc%></option>
<%
					}  
				}
%>
				</select>
<%
			}
			else
			{
%>
				Please select manufacturer 
<%
			}
%>
			</Td>
		</Tr>
		<Tr>      
			<Th width = "50%" align="right">Customer</Th>
			<Td width = "50%">
<%
			if(retsoldtoCount>0)
			{
%>						
				<select name="soldTo" id=listBoxDiv style="border:1px solid" >
					<option value="ALL">All Customers</option>
<%				
				retsoldto.sort(new String[]{"ECA_NAME"},true);
				String custNo = "",custDesc = "";
				
				for(int i=0;i<retsoldtoCount;i++)
				{
					custNo = retsoldto.getFieldValueString(i,"EC_ERP_CUST_NO");
					custDesc = retsoldto.getFieldValueString(i,"ECA_NAME");
					
					if(custNo.equals(soldTo))
					{
%>
						<option value="<%=custNo%>" selected><%=custDesc%>[<%=custNo%>]</option>
<%
					}
					else
					{
%>						
						<option value="<%=custNo%>"><%=custDesc%>[<%=custNo%>]</option>
<%
					}
				}
%>				
				</select>
<%			
			}
			else
			{
%>
				No Customers Available
<%
			}
%>
			</Td>
		</Tr>
		<Tr>
			<Th width = "50%" align="right">Discount *</Th>
			<Td width = "50%"><input type = "text" class = "InputBox" name = "discount" size = 6 maxlength = "6" value="<%=discount%>" style="text-align:right">&nbsp;%</Td>
		</Tr>
	    </Table>
	</Div>
<%
	String noDataStatement = dispData;
	
	if(showDisp!=null && "Y".equals(showDisp))
	{
%>
		<%@ include file="../Misc/ezDisplayNoData.jsp"%>
<%
	}
%>
	
	<Div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
	<span id="EzButtonsSpan">
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();

	buttonName.add("Create");
	buttonMethod.add("funCreate()");

	out.println(getButtonStr(buttonName,buttonMethod));
%>
	</span>
	<span id="EzButtonsMsgSpan" style="display:none">
	<Table align=center>
	<Tr>
		<Td class="labelcell">Your request is being processed. Please wait</Td>
	</Tr>
	</Table>
	</span>
	</Div>
</form>
</body>
<Div id="MenuSol"></Div>
</html>
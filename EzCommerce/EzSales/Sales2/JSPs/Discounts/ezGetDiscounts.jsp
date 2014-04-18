<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%@ include file="../../../Includes/JSPs/Discounts/iGetDiscounts.jsp"%>
<%!
	public String checkNULL(String str)
	{
		if(str==null || "null".equals(str) || "".equals(str))
			str = "";
		else
		{
			str = str.replaceAll("\"","`");
			str = str.trim();
		}	
			
		return str;	
	}
%>
<html>
<head>
	<Title>Discounts List-- Powered by EzCommerce Inc</Title>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<Script>
	var tabHeadWidth=90
	var tabHeight="45%"
</Script>
<Script src="../../Library/JavaScript/Scroll/ezTabScroll.js"></Script>
<Script src="../../Library/JavaScript/Misc/ezTrim.js"></Script>
<Script>
	function funChngStatus(id,val)
	{
		document.myForm.status.value = val;

		var dispAct = "";
		var chkDiscId = id;

		if(val=='Y')
			dispAct = "Active";
		else if(val=='N')
			dispAct = "In-Active";

		var y = confirm("Are sure to "+dispAct+" this Discount?");

		if(eval(y))
		{
			document.myForm.action="ezEditDiscount.jsp?discId="+chkDiscId;
			document.myForm.submit();
		}
	}
	function funDelete()
	{
		var len = document.myForm.rdDiscId.length;
		var cnt = 0;
		var chkDisc = "";

		if(isNaN(len))
		{
			if(document.myForm.rdDiscId.checked)
			{
				chkDisc = document.myForm.rdDiscId.value;
				cnt++;
			}
		}
		else
		{	
			for(i=0;i<len;i++)
			{	
				if(document.myForm.rdDiscId[i].checked)
				{
					chkDisc = document.myForm.rdDiscId[i].value;
					cnt++;
					break;
				}
			}
		}
		if(cnt==0)
		{
			alert("Please Select a Discount to Delete");
			return
		}
		else
		{
			var y = confirm("Are you sure to Delete?");
			
			if(eval(y))
			{
				document.myForm.action="ezEditDiscount.jsp?discId="+chkDisc+"&chkDel=DEL";
				document.myForm.submit();
			}
		}
	}
	function funSave()
	{
		var len = document.myForm.rdDiscId.length;
		var cnt = 0;
		var chkDisc = "";
		var chkVal;
		var dStatus;

		if(isNaN(len))
		{
			if(document.myForm.rdDiscId.checked)
			{
				chkDisc = document.myForm.rdDiscId.value;
				chkVal = document.myForm.editDiscount.value;
				dStatus = document.myForm.discStatus.value;
				cnt++;
			}
		}
		else
		{	
			for(i=0;i<len;i++)
			{	
				if(document.myForm.rdDiscId[i].checked)
				{
					chkDisc = document.myForm.rdDiscId[i].value;
					chkVal = document.myForm.editDiscount[i].value;
					dStatus = document.myForm.discStatus[i].value;
					cnt++;
					break;
				}
			}
		}
		if(cnt==0)
		{
			alert("Please Select a In-Active Discount to Save");
			return
		}
		else
		{
			if(dStatus=='Y')
			{
				alert("Active Discount(s) cannot be Saved");
				return
			}
			else
			{
				if(funTrim(chkVal)=='')
				{
					alert("Please enter Discount");
					return;
				}
				else if(isNaN(chkVal))
				{
					alert("Please enter valid Discount");
					return;
				}
				else
				{
					var y = confirm("Are you sure to Save?");

					if(eval(y))
					{
						document.myForm.action="ezEditDiscount.jsp?discId="+chkDisc+"&chkVal="+chkVal+"&chkDel=EDIT";
						document.myForm.submit();
					}
				}
			}
		}
	}
</Script>
</head>
<Body  onLoad="scrollInit();" onResize="scrollInit()" scroll="no">
<Form name=myForm method=post>
<input type="hidden" name="status" value="">
<br><br>
<%
	if(retDiscountsCount>0)
	{
%>
	<div id="theads">
	<Table width="90%" id="tabHead" border=0 align='center' borderColorDark="#ffffff" borderColorLight="#006666" cellPadding=5 cellSpacing=1>
	<Tr>
		<Th align="center" valign="middle" width="4%">&nbsp;</Th>
		<Th align="center" valign="middle" width="5%">No</Th>
		<Th align="center" valign="middle" width="25%">Manufacturer</Th>
		<Th align="center" valign="middle" width="18%">Item Category</Th>
		<Th align="center" valign="middle" width="28%">Customer(s)</Th>
		<Th align="center" valign="middle" width="11%">Discount</Th>
		<Th align="center" valign="middle" width="9%">Status</Th>
	</Tr>
	</Table>
	</div>
	<div id="InnerBox1Div" style="overflow:auto;position:absolute;width:90%;height:45%">
	<Table width="100%" id="InnerBox1Tab" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1>
<%
		for(int i=0;i<retDiscountsCount;i++)
		{
			String discId 	= checkNULL(retDiscounts.getFieldValueString(i,"ESD_DISC_NO"));
			String manfId 	= checkNULL(retDiscounts.getFieldValueString(i,"ESD_MFR_ID"));
			String itemCat 	= checkNULL(retDiscounts.getFieldValueString(i,"ESD_PROD_CAT"));
			String customer	= checkNULL(retDiscounts.getFieldValueString(i,"ESD_CUSTOMER"));
			String discount	= checkNULL(retDiscounts.getFieldValueString(i,"ESD_DISCOUNT"));
			String status 	= checkNULL(retDiscounts.getFieldValueString(i,"ESD_STATUS"));
			
			String itemCatDesc = checkNULL((String)itemCatHash.get(itemCat));
			String customerDesc = "All Customers";
			int rowId = -1;
			
			if(!"ALL".equals(customer))
				rowId = retsoldto.getRowId("EC_ERP_CUST_NO",customer);
			
			if(rowId!=-1)
				customerDesc = retsoldto.getFieldValueString(rowId,"ECA_NAME");
%>
		<Tr>
			<Td align="center" valign="top" width="4%">
			<input type="radio" name="rdDiscId" value="<%=discId%>">
			</Td>
			<Td align="center" valign="top" width="5%"><%=(i+1)%></Td>
			<Td align="left" valign="top" width="25%">&nbsp;<%=manfId%> [<%=(String)manfIdHash.get(manfId)%>]</Td>
			<Td align="left" valign="top" width="18%">&nbsp;<%=itemCatDesc%></Td>
			<Td align="left" valign="top" width="28%">&nbsp;<%=customerDesc%></Td>
			
			<input type="hidden" name="discStatus" value="<%=status%>">
<%
			if("Y".equals(status))
			{
%>			
			<Td align="right" valign="top" width="11%">
			<input type="text" class="tx" name="editDiscount" value="<%=discount%>" size="6" maxlength="6" style="text-align:right" readonly> %</Td>
			<Td align="center" valign="top" width="9%">
			<img src="../../Images/Others/greenball.gif">
			</Td>
<%
			}
			else if("N".equals(status))
			{
%>
			<Td align="right" valign="top" width="11%">
			<input type="text" class="InputBox" name="editDiscount" value="<%=discount%>" size="6" maxlength="6" style="text-align:right"> %</Td>
			<Td align="center" valign="top" width="9%">
			<img src="../../Images/Others/redball.gif" style="cursor:hand"  alt="Click Here To Change The Status" border=no onClick="funChngStatus(<%=discId%>,'Y')">
			</Td>
<%
			}
%>
		</Tr>
<%
		}
%>
	</Table>
	</div>
	
	<Div id="ButtonDiv" align="center" style="position:absolute;top:85%;width:100%">
	<Table>
	<Tr>
		<Td class="blankcell"><img src="../../Images/Others/greenball.gif" border=0>&nbsp; Active &nbsp;&nbsp;&nbsp;&nbsp;</Td>
		<Td class="blankcell"><img src="../../Images/Others/redball.gif" border=0>&nbsp; In-Active</Td>
	</Tr>
	<Tr align="center">
		<Td class="blankcell" colSpan=2>
<%		
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();
			
			buttonName.add("Save");
			buttonMethod.add("funSave()");

			buttonName.add("Delete");
			buttonMethod.add("funDelete()");
			
			out.println(getButtonStr(buttonName,buttonMethod));
%>
		</Td>
	</Tr>
	</Table>
	</Div>	
<%
	}
	else
	{
	
	String noDataStatement = "No Discounts Configured";
%>
	<%@ include file="../Misc/ezDisplayNoData.jsp"%>
<%
	}
%>
</Form>
</Body>
</Html>
<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp"%>
<%@ include file="../../../Includes/JSPs/PromoCode/iGetPromoCode.jsp"%>
<Html>
<Head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Script>
	var tabHeadWidth=90
	var tabHeight="50%"
</Script>
<Script src="../../Library/JavaScript/Scroll/ezTabScroll.js"></Script>
<Script src="../../Library/JavaScript/ezTrim.js"></Script>
<Script>
	function funChngStatus(id,val)
	{
		document.myForm.status.value = val;

		var dispAct = "";
		var chkPCode = id;

		if(val=='Y')
			dispAct = "Activate";
		else if(val=='N')
			dispAct = "In-Active";

		var y = confirm("Are you sure to "+dispAct+" this Promotional Code?");

		if(eval(y))
		{
			document.myForm.action="ezEditPromoCode.jsp?promoCode="+chkPCode;
			document.myForm.submit();
		}
	}
	function funAdd()
	{
		document.myForm.action="ezAddPromoCode.jsp";
		document.myForm.submit();
	}
	function funDelete()
	{
		var len = document.myForm.rdPCode.length;
		var cnt = 0;
		var chkPc = "";

		if(isNaN(len))
		{
			if(document.myForm.rdPCode.checked)
			{
				chkPc = document.myForm.rdPCode.value;
				cnt++;
			}
		}
		else
		{	
			for(i=0;i<len;i++)
			{	
				if(document.myForm.rdPCode[i].checked)
				{
					chkPc = document.myForm.rdPCode[i].value;
					cnt++;
					break;
				}
			}
		}
		if(cnt==0)
		{
			alert("Please Select a Promotion to Delete");
			return
		}
		else
		{
			var y = confirm("Are you sure to Delete?");
			
			if(eval(y))
			{
				document.myForm.action="ezEditPromoCode.jsp?promoCode="+chkPc+"&chkDel=DEL";
				document.myForm.submit();
			}
		}
	}
	function funSave()
	{
		var len = document.myForm.rdPCode.length;
		var cnt = 0;
		var chkPc = "";
		var chkVal;
		var pcStatus;

		if(isNaN(len))
		{
			if(document.myForm.rdPCode.checked)
			{
				chkPc = document.myForm.rdPCode.value;
				chkVal = document.myForm.editVal.value;
				pcStatus = document.myForm.pcStatus.value;
				cnt++;
			}
		}
		else
		{	
			for(i=0;i<len;i++)
			{	
				if(document.myForm.rdPCode[i].checked)
				{
					chkPc = document.myForm.rdPCode[i].value;
					chkVal = document.myForm.editVal[i].value;
					pcStatus = document.myForm.pcStatus[i].value;
					cnt++;
					break;
				}
			}
		}
		if(cnt==0)
		{
			alert("Please Select a In-Active Promotional Code to Save");
			return
		}
		else
		{
			if(pcStatus=='Y')
			{
				alert("Active Promotional Code(s) cannot be Saved");
				return
			}
			else
			{
				if(funTrim(chkVal)=='')
				{
					alert("Please enter discount value");
					return;
				}
				else if(isNaN(chkVal))
				{
					alert("Please enter valid discount value");
					return;
				}
				else
				{
					var y = confirm("Are you sure to Save?");

					if(eval(y))
					{
						document.myForm.action="ezEditPromoCode.jsp?promoCode="+chkPc+"&chkVal="+chkVal+"&chkDel=EDIT";
						document.myForm.submit();
					}
				}
			}
		}
	}
</Script>
</Head>
<Body  onLoad="scrollInit()" onResize="scrollInit()" scroll="no" >
<Form name=myForm method=post >
<input type="hidden" name="status" value="">
<br><br><br>

	<Div align=center>
<%
	boolean delFlag = false;
	
	if(retPromoCodesCount>0)
	{
%>
	<div id="theads">
	<Table width="90%" id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
	<Tr>
		<Th align="center" valign="middle" width="4%">&nbsp;</Th>
		<Th align="center" valign="middle" width="10%">Promo Code</Th>
		<Th align="center" valign="middle" width="11%">Promo Type</Th>
		<Th align="center" valign="middle" width="11%">Manf Part No</Th>
		<Th align="center" valign="middle" width="11%">Manufacturer</Th>
		<Th align="center" valign="middle" width="11%">Item Category</Th>
		<Th align="center" valign="middle" width="9%">Valid From</Th>
		<Th align="center" valign="middle" width="9%">Valid To</Th>
		<Th align="center" valign="middle" width="8%">Price</Th>
		<Th align="center" valign="middle" width="8%">Discount</Th>
		<Th align="center" valign="middle" width="8%">Status</Th>
	</Tr>
	</Table>
	</div>
	<div id="InnerBox1Div" style="overflow:auto;position:absolute;width:90%;height:50%">
	<Table width="100%" id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
<%
		for(int i=0;i<retPromoCodesCount;i++)
		{
			delFlag = true;
			
			String proCode 	= retPromoCodes.getFieldValueString(i,"EPC_CODE");
			String proType 	= retPromoCodes.getFieldValueString(i,"EPC_PROMO_TYPE");
			String mfrID 	= retPromoCodes.getFieldValueString(i,"EPC_MFR_ID");
			String itemCat	= retPromoCodes.getFieldValueString(i,"EPC_PROD_CAT");
			String discount = retPromoCodes.getFieldValueString(i,"EPC_DISCOUNT");
			String status 	= retPromoCodes.getFieldValueString(i,"EPC_STATUS");
			
			String validFrom = ezc.ezutil.FormatDate.getStringFromDate((Date)retPromoCodes.getFieldValue(i,"EPC_VALID_FROM"),".",ezc.ezutil.FormatDate.MMDDYYYY);
			String validTo 	 = ezc.ezutil.FormatDate.getStringFromDate((Date)retPromoCodes.getFieldValue(i,"EPC_VALID_TO"),".",ezc.ezutil.FormatDate.MMDDYYYY);
			
			String proTypeDesc = "";
			boolean mfrPNum = false;
			
			if(proType!=null && "MFRPN".equals(proType))
			{
				proTypeDesc = "Manf Part No";
				mfrPNum = true;
			}
			else if(proType!=null && "PCORD".equals(proType))
				proTypeDesc = "Order";
			else if(proType!=null && "PCMFR".equals(proType))
				proTypeDesc = "Manufacture";
			else if(proType!=null && "PCMAI".equals(proType))
				proTypeDesc = "Manf & Item Cat";
				
			String mfrDesc = "";
			String itemCatDesc = "";
			String mfrPartNo = "";
			String mfrPrice = "";
			String proDisc = "";
			String manfId = "";
			
			if(mfrPNum)
			{
				mfrPartNo = mfrID;
				mfrPrice = "$ "+discount;
			}
			else
			{
				if(mfrID!=null && !"null".equals(mfrID) && !"".equals(mfrID))
					mfrDesc = mfrID+" --> "+(String)manfIdHash.get(mfrID);

				if(itemCat!=null && !"null".equals(itemCat) && !"".equals(itemCat))
					itemCatDesc = (String)itemCatHash.get(itemCat);

				if(itemCatDesc==null || "null".equals(itemCatDesc)) itemCatDesc = "";
				
				manfId = mfrID;
				proDisc = discount+" %";
			}
%>
		<Tr>
			<Td align="center" valign="top" width="4%"><input type="radio" name="rdPCode" value="<%=proCode%>"></Td>
			<Td align="left" valign="top" width="10%">&nbsp;<%=proCode%></Td>
			<Td align="left" valign="top" width="11%">&nbsp;<%=proTypeDesc%></Td>
			<Td align="left" valign="top" width="11%">&nbsp;<%=mfrPartNo%></Td>
			<Td align="left" valign="top" width="11%" title="<%=mfrDesc%>">&nbsp;<%=manfId%></Td>
			<Td align="left" valign="top" width="11%">&nbsp;<%=itemCatDesc%></Td>
			<Td align="center" valign="top" width="9%">&nbsp;<%=validFrom%></Td>	<!--+"&nbsp;&nbsp;"+retPromoCodes.getFieldValue(i,"VFROM_TIME")-->
			<Td align="center" valign="top" width="9%">&nbsp;<%=validTo%></Td>	<!--+"&nbsp;&nbsp;"+retPromoCodes.getFieldValue(i,"VTO_TIME")-->
			
			<input type="hidden" name="pcStatus" value="<%=status%>">
<%
			if("Y".equals(status))
			{
%>
			<input type="hidden" name="editVal" value="<%=discount%>">
			<Td align="right" valign="top" width="8%">&nbsp;<%=mfrPrice%></Td>
			<Td align="right" valign="top" width="8%">&nbsp;<%=proDisc%></Td>
			<Td align="center" valign="top" width="8%">
			<img src="../../Images/newimages/greenball.gif">
			</Td>
<%
			}
			else if("N".equals(status))
			{
%>
			<Td align="right" valign="top" width="8%">&nbsp;
<%
				if(mfrPNum)
				{
%>
					$ <input type="text" class="InputBox" name="editVal" value="<%=discount%>" size="6" maxlength="6" style="text-align:right"></Td>
					</Td>
					<Td align="right" valign="top" width="8%">&nbsp;
<%
				}
				else
				{
%>			
					</Td>
					<Td align="right" valign="top" width="8%">&nbsp;
					<input type="text" class="InputBox" name="editVal" value="<%=discount%>" size="6" maxlength="6" style="text-align:right"> %</Td>
<%
				}
%>			
			</Td>
			<Td align="center" valign="top" width="8%">
			<img src="../../Images/newimages/redball.gif" style="cursor:hand"  alt="Click Here To Change The Status" border=no onClick="funChngStatus('<%=proCode%>','Y')">
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
<%
	}
	else
	{
%>
	<br><br><br><br>
	<Table   width="90%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr>
		<Th>No promotional codes created. Click on Add to create.</Th>
	</Tr>
	</Table>
<%
	}
%>
	</Div>
	<Div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
	<Table>
	<Tr>
		<Td class="blankcell"><img src="../../Images/newimages/greenball.gif" border=0>&nbsp; Active &nbsp;&nbsp;&nbsp;&nbsp;</Td>
		<Td class="blankcell"><img src="../../Images/newimages/redball.gif" border=0>&nbsp; In-Active</Td>
	</Tr>
	</Table>
		<a href="JavaScript:funAdd()"><img src="../../Images/Buttons/<%=ButtonDir%>/add.gif" border=none></a>
<%
		if(delFlag)
		{
%>		
		<a href="JavaScript:funSave()"><img src="../../Images/Buttons/<%=ButtonDir%>/save.gif" border=none></a>
		<a href="JavaScript:funDelete()"><img src="../../Images/Buttons/<%=ButtonDir%>/delete.gif" border=none></a>
<%
		}
%>
	</Div>
</Form>
</Body>
</Html>
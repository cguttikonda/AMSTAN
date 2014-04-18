<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp"%>
<%@ include file="../../../Includes/JSPs/Threshold/iAddThreshold.jsp"%>
<%
	java.util.Date fromDate = new java.util.Date();
	java.util.Date toDate = new java.util.Date();
	
	toDate.setDate(toDate.getDate()+30);

	ezc.ezutil.FormatDate format = new ezc.ezutil.FormatDate();
	
	String Hours[] = {"00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23"};
	String Mins[] = {"00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59"};
%> 

<Html>
<Head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
<%@ include file="../../../Includes/JSPs/WebStats/iCalendar.jsp"%>
<Script>
	var tabHeadWidth=95
	var tabHeight="30%"
</Script>
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
<Script src="../../Library/JavaScript/ezTrim.js"></Script>


<script>
	function getDefaultsFromTo()
	{
		document.myForm.fromDate.value = "<%=format.getStringFromDate(fromDate,"/",ezc.ezutil.FormatDate.MMDDYYYY)%>";
		document.myForm.toDate.value = "<%=format.getStringFromDate(toDate,"/",ezc.ezutil.FormatDate.MMDDYYYY)%>";
	}
	
	function formSubmit(obj)
	{
		var x = false;
		var y = false;
		var z = false;
		
		var discount = document.myForm.discount.value;
		
		if(obj=='1')
		{
			var mfrPN = document.myForm.mfrPartNo.value;
			
			if(funTrim(mfrPN)=='')
			{
				alert("Please enter manufacture part number");
				document.myForm.mfrPartNo.focus();
			}
			else if(funTrim(discount)=='')
			{
				alert("Please enter Price");
				document.myForm.discount.focus()
			}
			else if(isNaN(discount))
			{
				alert("Please enter valid Price");
				document.myForm.discount.value="";
				document.myForm.discount.focus();
			}
			else
				x = true;
		}
		else if(obj=='2')
		{
			x = checkDiscount(discount);
		}
		else if(obj=='3')
		{
			var mfr = document.myForm.mfr.value;
			
			y = checkMfr(mfr);
			if(y) x = checkDiscount(discount);
		}
		else if(obj=='4')
		{
			var mfr = document.myForm.mfr.value;
			var itemCat = document.myForm.itemCat.value;
			
			y = checkMfr(mfr);
			if(y) z = checkItemCat(itemCat);
			if(z) x = checkDiscount(discount);
		}
		
		if(eval(x) && confirm("Are you sure to create Promotional Code?"))
		{
			document.myForm.action="ezAddSavePromoCode.jsp";
			document.myForm.submit();
		}
	}
	function checkMfr(mfr)
	{
		if(funTrim(mfr)=='')
		{
			alert("Please select a Manufacturer");
			document.myForm.mfr.focus()
			return false;
		}
		else
			return true;
	}
	function checkItemCat(itemCat)
	{
		if(funTrim(itemCat)=='')
		{
			alert("Please select a Item Category");
			document.myForm.itemCat.focus()
			return false;
		}
		else
			return true;
	}
	function checkDiscount(discount)
	{
		if(funTrim(discount)=='')
		{
			alert("Please enter Discount");
			document.myForm.discount.focus()
			return false;
		}
		else if(isNaN(discount))
		{
			alert("Please enter valid Discount");
			document.myForm.discount.value="";
			document.myForm.discount.focus();
			return false;
		}
		else
			return true;
	}
	function mfrSearch()
	{
		var url="../Threshold/ezSelectManufacture.jsp";
		newWindow=window.open(url,"SearchWin","width=550,height=350,left=180,top=180,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
	}
	function funSelType()
	{
		document.myForm.action="ezAddPromoCode.jsp";
		document.myForm.submit();
	}
</script>

</Head>
<Body  onLoad="getDefaultsFromTo();scrollInit()" onResize="scrollInit()" scroll="no" >
<Form name=myForm method=post >
<input type="hidden" name="manfId" value="">
<%
	String selType = request.getParameter("selType");
	
	String chkMfrPn = "checked",chkPcOrd = "",chkPcMfr = "",chkPcMai = "";
	
	boolean selTypeMfrPn = true;
	String selFormSub = "1";
	
	if(selType!=null && "PCORD".equals(selType))
	{
		chkMfrPn = "";
		chkPcOrd = "checked";
		chkPcMfr = "";
		chkPcMai = "";
		selTypeMfrPn = false;
		selFormSub = "2";
	}
	else if(selType!=null && "PCMFR".equals(selType))
	{
		chkMfrPn = "";
		chkPcOrd = "";
		chkPcMfr = "checked";
		chkPcMai = "";
		selTypeMfrPn = false;
		selFormSub = "3";
	}
	else if(selType!=null && "PCMAI".equals(selType))
	{
		chkMfrPn = "";
		chkPcOrd = "";
		chkPcMfr = "";
		chkPcMai = "checked";
		selTypeMfrPn = false;
		selFormSub = "4";
	}
%>
<br><br>
	<Div align=center>
	    <Table  width="65%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr>
			<Th colspan='4'>Create Promotional Code</Th>
		</Tr>
		<Tr>
			<Th width="25%"><input type="radio" onClick="funSelType()" name="selType" value="MFRPN" <%=chkMfrPn%>>&nbsp;Mfr. Part No</Th>
			<Th width="25%"><input type="radio" onClick="funSelType()" name="selType" value="PCORD" <%=chkPcOrd%>>&nbsp;Order</Th>
			<Th width="25%"><input type="radio" onClick="funSelType()" name="selType" value="PCMFR" <%=chkPcMfr%>>&nbsp;Manfacture</Th>
			<Th width="25%"><input type="radio" onClick="funSelType()" name="selType" value="PCMAI" <%=chkPcMai%>>&nbsp;Manf. and Item Cat.</Th>
		</Tr>
	    </Table>
	</Div>
	<Div align=center>
	    <Table  width="65%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr>
			<Th width = "15%">Valid From</Th>
			<Td width = "35%"><nobr><input type=text class = "InputBox" name="fromDate" size=11 value="<%=fromDate%>" readonly>
				 &nbsp;<%=getDateImage("fromDate")%>
			</nobr>
			<input type="hidden" name="stHrs" value="00">
			<input type="hidden" name="stMin" value="00">
			</Td>
			<Th width = "15%">Valid To</Th>
			<Td width = "35%"><nobr><input type=text class = "InputBox" name="toDate" size=11 value="<%=toDate%>" readonly>
				&nbsp;<%=getDateImage("toDate")%>
			</nobr>
			<input type="hidden" name="endHrs" value="23">
			<input type="hidden" name="endMin" value="59">
			</Td>
		</Tr>
<%
	String mfrPartNo = request.getParameter("mfrPartNo");
	String discount = request.getParameter("discount");
	
	if(mfrPartNo==null || "null".equals(mfrPartNo)) mfrPartNo = "";
	if(discount==null || "null".equals(discount)) discount = "";
	
	if(selTypeMfrPn)
	{
%>
		<Tr>
			<Th width = "25%" align="right" colspan=2>Manufacturer Part Number&nbsp;</Th>
			<Td width = "25%" colspan=2><input type = "text" class = "InputBoxTest" name = "mfrPartNo" size = 25 value = "<%=mfrPartNo%>"></Td>
		</Tr>
		<Tr>
			<Th width = "25%" align="right" colspan=2>Price &nbsp;&nbsp;$</Th>
			<Td width = "25%" colspan=2><input type = "text" class = "InputBoxTest" name = "discount" size = 10 style="text-align:right" value = "<%=discount%>"></Td>
		</Tr>
<%
	}
	else
	{
		if(selType!=null && ("PCMAI".equals(selType) || "PCMFR".equals(selType)))
		{
%>		
		<Tr>
			<Th width = "25%" align="right" colspan=2>Manufacturer&nbsp;</Th>
			<Td width = "25%" colspan=2><input type = "text" class = "InputBoxTest" name = "mfr" size = 25 readonly>
			<a href="JavaScript:mfrSearch()"><img src="../../Images/Buttons/<%=ButtonDir%>/search.gif" border=none></a>
			</Td>
		</Tr>
<%
		}
		if(selType!=null && "PCMAI".equals(selType))
		{
%>
		<Tr>
			<Th width = "25%" align="right" colspan=2>Item Category&nbsp;</Th>
			<Td width = "25%" colspan=2>
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
%>
					<option value="<%=catID%>"><%=catDesc%></option>
<%
				}
%>
				</select>
<%
			}
			else
			{
%>
				No Item Catagories available
<%
			}
%>			
			</Td>
		</Tr>
<%
		}
%>
		<Tr>
			<Th width = "25%" align="right" colspan=2>Discount&nbsp;</Th>
			<Td width = "25%" colspan=2><input type = "text" class = "InputBoxTest" name = "discount" size = 6 maxlength = "6" style="text-align:right">&nbsp;%</Td>
		</Tr>
<%
	}
%>
	    </Table>
	</Div>
	<Div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
		<!--input type=image src = "../../Images/Buttons/<%= ButtonDir%>/go.gif"  border=no-->
		<a href="JavaScript:formSubmit('<%=selFormSub%>')"><img src="../../Images/Buttons/<%=ButtonDir%>/add.gif" border=none></a>
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border=none></a>
	</Div>
</Form>
</Body>
</Html>
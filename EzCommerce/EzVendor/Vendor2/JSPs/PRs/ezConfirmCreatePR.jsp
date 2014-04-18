<%@ page import = "ezc.ezcommon.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%
	ezc.ezutil.FormatDate fd = new ezc.ezutil.FormatDate();
	
%>
<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<%@ include file="ezCal.jsp"%>   

<Script src="../../Library/JavaScript/ezTrim.js"></Script>

<script>
function addLine()
{
	var tabObj		= document.getElementById("ezRCItemTab")
	var rowItems 		= tabObj.getElementsByTagName("tr");
	var rowCountValue 	= rowItems.length;
	
	
	
	var itemNumber_JS	= parseFloat(rowCountValue)*10;
	
	var myRCObj=eval("document.myForm.tItemNumber");
	var myRCObjLen=myRCObj.length;
	if(isNaN(myRCObjLen)) myRCObjLen="1";
	
		
	eleWidth = new Array();
	eleAlign = new Array();
  	eleVal   = new Array();

	eleWidth[0]  = "10%";	eleAlign[0] = "center";
	eleWidth[1]  = "20";	eleAlign[1] = "center";
	eleWidth[2]  = "30%"; 	eleAlign[2] = "center";
	eleWidth[3]  = "10%";	eleAlign[3] = "center";
	eleWidth[4]  = "10%";	eleAlign[4] = "center";
	eleWidth[5]  = "10%"; 	eleAlign[5] = "center";
	eleWidth[6]  = "10%";	eleAlign[6] = "center";
	
	eleVal[0] ='<input type="text" name="itemNumber'+myRCObjLen+'" class="tx" readonly size="5" value="'+itemNumber_JS+'"><input type="hidden" name="tItemNumber" value="'+itemNumber_JS+'" ><input type="hidden" name="matGroup'+myRCObjLen+'" value="">';
	eleVal[1] ='<input type="text" name="matNumber'+myRCObjLen+'" class="InputBox" size="30" maxlength="18" value="" onKeyPress=" return onlyNumbers()"><img src="../../../../EzCommon/Images/Banner/search.gif" name="findMat" style="cursor:hand" height="18" alt="Find" onClick=search("'+myRCObjLen+'")>';
	eleVal[2] ='<input type="text" name="matDesc'+myRCObjLen+'" class="InputBox" size="45" maxlength="200" value="">';
	eleVal[3] ='<input type="text" name="delvDate'+myRCObjLen+'" class="InputBox" size=11 value="'+document.myForm.toDayDate.value+'" readonly> <img src="../../Images/calender.gif" style="cursor:hand" height="20" onClick=showCal("document.myForm.delvDate'+myRCObjLen+'",120,500,"<%=cDate%>","<%=cMonth%>","<%=cYear%>") >';
	eleVal[4] ='<input type="text" name="prQty'+myRCObjLen+'" class="InputBox" size="12" maxlength="7" value="" onBlur=checkNumeric(this,"QTY")>';
	eleVal[5] ='<input type="text" name="prUOM'+myRCObjLen+'" class="InputBox" size="10" value="">';
	eleVal[6] ='<input type="text" name="valPrice'+myRCObjLen+'" class="InputBox" size="12" maxlength="12" value="" onBlur=checkNumeric(this,"VALUE")>';

	var rowId = tabObj.insertRow(rowCountValue);
	for(i=0; i<eleVal.length;i++){
		var cell0=rowId.insertCell(i);
		cell0.width = eleWidth[i];
		cell0.align = eleAlign[i];
		cell0.innerHTML =eleVal[i];
	}


}
function addLineWithInfo(material,desc,uom,price,vendor,matGrp)
{
	var tabObj		= document.getElementById("ezRCItemTab")
	var rowItems 		= tabObj.getElementsByTagName("tr");
	var rowCountValue 	= rowItems.length;
	
	
	
	
	var itemNumber_JS	= parseFloat(rowCountValue)*10;
	
	var myRCObj=eval("document.myForm.tItemNumber");
	var myRCObjLen=myRCObj.length;
	if(isNaN(myRCObjLen)) myRCObjLen="1";
	
		
	eleWidth = new Array();
	eleAlign = new Array();
  	eleVal   = new Array();

	eleWidth[0]  = "10%";	eleAlign[0] = "center";
	eleWidth[1]  = "20%";	eleAlign[1] = "center";
	eleWidth[2]  = "30";	eleAlign[2] = "center";
	eleWidth[3]  = "10%";	eleAlign[3] = "center";
	eleWidth[4]  = "10%";	eleAlign[4] = "center";
	eleWidth[5]  = "10%"; 	eleAlign[5] = "center";
	eleWidth[6]  = "10%";	eleAlign[6] = "center";
	
	eleVal[0] ='<input type="text" name="itemNumber'+myRCObjLen+'" class="tx" readonly size="5" value="'+itemNumber_JS+'"><input type="hidden" name="tItemNumber" value="'+itemNumber_JS+'" ><input type="hidden" name="matGroup'+myRCObjLen+'" value="'+matGrp+'">';
	eleVal[1] ='<input type="text" name="matNumber'+myRCObjLen+'" class="InputBox" size="30" maxlength="18" value="'+material+'" onKeyPress=" return onlyNumbers()"><img src="../../../../EzCommon/Images/Banner/search.gif" name="findMat" style="cursor:hand" height="18" alt="Find" onClick=search("'+myRCObjLen+'")>';
	eleVal[2] ='<input type="text" name="matDesc'+myRCObjLen+'" class="InputBox" size="45" maxlength="200" value="'+desc+'">';
	eleVal[3] ='<input type="text" name="delvDate'+myRCObjLen+'" class="InputBox" size=11 value="'+document.myForm.toDayDate.value+'" readonly> <img src="../../Images/calender.gif" style="cursor:hand" height="20" onClick=showCal("document.myForm.delvDate'+myRCObjLen+'",120,500,"<%=cDate%>","<%=cMonth%>","<%=cYear%>") >';
	eleVal[4] ='<input type="text" name="prQty'+myRCObjLen+'" class="InputBox" size="12" maxlength="7" value="" onBlur=checkNumeric(this,"QTY")>';
	eleVal[5] ='<input type="text" name="prUOM'+myRCObjLen+'" class="InputBox" size="10" value="'+uom+'">';
	eleVal[6] ='<input type="text" name="valPrice'+myRCObjLen+'" class="InputBox" size="12" maxlength="12" value="'+price+'" onBlur=checkNumeric(this,"VALUE")>';


	var rowId = tabObj.insertRow(rowCountValue);
	for(i=0; i<eleVal.length;i++){
		var cell0=rowId.insertCell(i);
		cell0.width = eleWidth[i];
		cell0.align = eleAlign[i];
		cell0.innerHTML =eleVal[i];
	}


}

function checkMatType(obj)
{
	if(obj.checked)
		obj.value='Y'
	else
		obj.value='N'
}

function search(index)
{
	var selPlant = document.myForm.selPlant.value
	var url="ezMatSearchOptions.jsp?myIndex="+index+"&selPlant="+selPlant+"&SAP=Y";
	newWindow=window.open(url,"ReportWin","width=500,height=500,left=160,top=120,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");

}
function checkNumeric(numObj,type)
{
	if(type == "QTY")
	{
		var quantity = numObj.value;
		if(quantity != "")
		{
			if(isNaN(quantity))
			{

				alert("Please enter valid quantity");
				numObj.value=''
				numObj.focus();
				return false;
			}
			else if(parseFloat(quantity) <= 0)
			{
				alert("Quantity should not be less than or equals to 0");
				numObj.value=''
				numObj.focus();
				return false;
			}

		}
	}
	else if(type == "VALUE")
	{
		var valPrice = numObj.value;
		if(valPrice != "")
		{
			if(isNaN(valPrice))
			{

				alert("Please enter valid valuation price");
				numObj.value=''
				numObj.focus();
				return false;
			}
			else if(parseFloat(valPrice) <= 0)
			{
				alert("Valuation price should not be less than or equals to 0");
				numObj.value=''
				numObj.focus();
				return false;
			}

		}
	}
}
function createPR()
{ 
	var tabObj		= document.getElementById("ezRCItemTab")
	var rowItems 		= tabObj.getElementsByTagName("tr");
	var rowCountValue 	= rowItems.length;
	
	

	var successMat = 0
	todayArr=(document.myForm.toDayDateOriginal.value).split(".")
	currDay =new Date(todayArr[2],(todayArr[1]-1),todayArr[0])
	for(k=0;k<parseFloat(rowCountValue)-1;k++)
	{
		matObj = eval("document.myForm.matNumber"+k)
		matDescObj = eval("document.myForm.matDesc"+k)
		uomObj = eval("document.myForm.prUOM"+k)
		delDateObj= eval("document.myForm.delvDate"+k)
		if(matObj.value!='' || matDescObj.value!='')
		{
			qtyObj = eval("document.myForm.prQty"+k)
			valPriceObj = eval("document.myForm.valPrice"+k)

			if(delDateObj.value=="")
			{
				alert("Please enter the Del Date.");
				delDateObj.focus()
				return
			}	
			tempDelvDateArr = (delDateObj.value).split(".");
			tempDelvDate =new Date(tempDelvDateArr[2],(tempDelvDateArr[1]-1),tempDelvDateArr[0]);
			if(tempDelvDate<currDay)
			{
				alert("Delivery date must be greater than Today's date")
				delDateObj.value=""
				delDateObj.focus()
				return
			}	
			if(qtyObj.value=='')
			{
				alert('Please enter quantity')
				qtyObj.focus()
				return
			}
			
			if(uomObj.value=='')
			{
				alert('Please enter UOM')
				uomObj.focus()
				return
			}
			
			if(valPriceObj.value=='')
			{
				alert('Please enter valuation price')
				valPriceObj.focus()
				return
			}
			
			successMat++
			
		}
	}
	if(successMat==0)
	{
		alert('Requisition cannot be created with no line items')
		return
	}
	var y = confirm("PR will be created for "+successMat+" line item(s) \n Click on OK to confirm");
	
	if(y)
	{
		buttonsSpan	  = document.getElementById("EzButtonsSpan")
		buttonsMsgSpan	  = document.getElementById("EzButtonsMsgSpan")
		if(buttonsSpan!=null)
		{
		buttonsSpan.style.display	= "none"
		buttonsMsgSpan.style.display	= "block"
		}

		document.myForm.action="ezCreateSAPPR.jsp";
		document.myForm.submit();
	}
	
}
function onlyNumbers(evt)
{
	var e = event || evt; 
	var charCode = e.which || e.keyCode;
	if (charCode > 31 && (charCode < 48 || charCode > 57))
	{
		//alert("Materail should be numeric");
		return false;
	}	
	return true;
}
function funcRemarks(index)
{
	var remarks = eval("document.myForm.remarks"+index).value
	var newRemarks = eval("document.myForm.newRemarks"+index).value
	newWindow=window.open("ezAddViewRemarks.jsp?index="+index+"&remarks="+remarks+"&newRemarks="+newRemarks,"Remarks","width=700,height=350,left=160,top=120,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
}
</script>
</head>

<body scroll="yes">
<form name="myForm" method="post">
<input type="hidden" name="saveSubStatus">
<%
	String display_header = "Create Purchase Requisition";
	//out.println(request.getRemoteAddr());
%>	
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<Br>
<%
	String toDayDate="";
	/*if("MM".equals(mmordd[0]))
	{
		toDayDate=fd.getStringFromDate(new java.util.Date(),".",ezc.ezutil.FormatDate.MMDDYYYY);
	}	
	else
	{
		toDayDate=fd.getStringFromDate(new java.util.Date(),".",ezc.ezutil.FormatDate.DDMMYYYY);
	}*/	

%>
<input type =hidden name="toDayDate" value="<%=toDayDate%>">
<input type =hidden name="toDayDateOriginal" value="<%=toDayDate%>">
<input type =hidden name="selPlant" value='BP01'>

<BR>
<Table align=center id="ezRCItemTab"  border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=1 cellSpacing=1 width='95%'>
	<Tr>
		<Th width="10%" height="10" align="center"><b><a href="javascript:addLine()"><font color="red" >[+]</font></b></a>Item No</Th>
		<Th width="20%" height="20" align='center'>Material</Th>
		<Th width="30%" height="30" align='center'>ShortText</Th> 
		<Th width="10%" height="10" align='center'>Delivery Date</Th>
		<Th width="10%" height="10" align='center'>Quantity</Th>
		<Th width="10%" height="10" align='center'>UOM</Th>
		<Th width="10%" height="10" align='center'>Val Price</Th>
	</Tr> 
<%
	for(int m=0;m<1;m++)
	{
		int lineItemNo = (m+1)*10; 
		
%>
	<Tr>
		<Td width="10%" align="center">
			<input type="text" name="itemNumber<%=m%>" class="tx" readonly size="5" value="<%=lineItemNo%>">
			<input type="hidden" name="tItemNumber" value="<%=lineItemNo%>" >
			<input type="hidden" name="matGroup<%=m%>" value=''>
		</Td>
		<Td width="20%" align="center">
			<input type="text" name="matNumber<%=m%>" class="InputBox" size="30" maxlength="18" value="">
			<img src="../../../../EzCommon/Images/Banner/search.gif" name="findMat" style="cursor:hand" height="18" alt="Find" onClick=search(<%=m%>)>
		</Td>
		<Td width="30%" align="center">
			<input type="text" name="matDesc<%=m%>" class="InputBox" size="45" maxlength="200" value="">
		</Td>
		<Td width="10%" align="center"><input type="text" align="center" name="delvDate<%=m%>" class="InputBox" size=11 value="<%=toDayDate%>" readonly> <img src="../../Images/calender.gif" style="cursor:hand" height="20" onClick=showCal("document.myForm.delvDate0",120,500,"<%=cDate%>","<%=cMonth%>","<%=cYear%>") ></Td>
		<Td width="10%" align="center"><input type="text" name="prQty<%=m%>" class="InputBox" size="12" maxlength="7" value="" onBlur=checkNumeric(this,"QTY")></Td>
		<Td width="10%" align="center"><input type="text" name="prUOM<%=m%>" class="InputBox" size="10" maxlength="15" value=""></Td>
		<Td width="10%" align="center"><input type="text" name="valPrice<%=m%>" class="InputBox" size="12" maxlength="12" value="" onBlur=checkNumeric(this,"VALUE")></Td>
	</Tr>
<%
	//out.println("row count::::"+lineItemNo);   
	}
%>
</Table>

<br>
<Div id="buttonDiv" align=center style="position:absolute;visibility:visible;width:100%">
	<span id="EzButtonsSpan" >
        
<%

	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();

	buttonName.add("&nbsp;&nbsp;&nbsp;Create&nbsp;&nbsp;PR&nbsp;&nbsp;&nbsp;");
	buttonMethod.add("createPR()");

	out.println(getButtonStr(buttonName,buttonMethod));
%>			

          
	</span>
	<span id="EzButtonsMsgSpan" style="display:none">
	<Table align=center>
		<Tr>
			<Td class="labelcell">Your request is being processed... Please wait</Td>
		</Tr>
	</Table>
	</span>
	</Div>	

</form>
<Div id="MenuSol"></Div>
</body>
</html>
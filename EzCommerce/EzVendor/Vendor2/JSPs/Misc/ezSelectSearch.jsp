<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<html>
<head>
<title>Welcome</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@include file="../../../Includes/Lib/AddButtonDir.jsp" %></head>

<script LANGUAGE="JavaScript">

function VerifyEmptyMat()
{
	matNo = funTrim(document.sbuForm.MaterialNumber.value);
	if(matNo.indexOf("*")!=-1)
	{
		alert("Please Enter Valid Material No.")
		return false;
	}
	if ((matNo == "")||(matNo =="0"))
	{
		alert("Please Enter Material No.");
		document.sbuForm.MaterialNumber.focus();
		return false;
	}
	else
	{
		if ( isNaN(parseInt(matNo)) ){
			document.sbuForm.MaterialNumber.value = matNo
		}else{
			matNo="000000000000000000"+matNo;
			matNo=matNo.substring(matNo.length-18,matNo.length);
			document.sbuForm.MaterialNumber.value = matNo
		}
		document.sbuForm.SearchFlag.value=document.sbuForm.SearchFlagMn.value;
		document.sbuForm.action="../../JSPs/Purorder/ezSearchPOMatList.jsp"
		document.sbuForm.submit();
	}
}

function VerifyEmptyPurOrder()
{
		document.sbuForm.PurchaseOrder.value=funTrim(document.sbuForm.PurchaseOrder.value)
		var dd = document.sbuForm.PurchaseOrder.value;
		if ((dd == "")||(dd == " ")||(dd == "  ")||(dd == "   ")||(dd == "    ")||(dd == "     "))
		{
		alert("Please enter the Purchase Order Number");
		document.sbuForm.PurchaseOrder.focus()
		return false;
		}

	else
	{

		document.sbuForm.action="../../JSPs/Purorder/ezSearchPOList.jsp"
		document.sbuForm.submit();
	}

}


//ezInvoice Scripts Starts here

function VerifyEmptySO()
{
	document.sbuForm.searchFieldSo.value=funTrim(document.sbuForm.searchFieldSo.value)
	if ((document.sbuForm.searchFieldSo.value == ""))
	{
		alert("Please enter SAP Invoice Number");
		document.sbuForm.searchFieldSo.focus();
		return false;
	}
	else
	{
		document.sbuForm.searchFieldSo.value = funTrim(document.sbuForm.searchFieldSo.value);
		document.sbuForm.searchField.value=document.sbuForm.searchFieldSo.value
		document.sbuForm.base.value=document.sbuForm.baseSo.value;
		document.sbuForm.InvStat.value=document.sbuForm.InvStatSo.value;
		document.sbuForm.action="../Purorder/ezSearchListInv.jsp"
		document.sbuForm.submit();
	}
}

function VerifyEmptyPO()
{
	document.sbuForm.searchFieldPo.value=funTrim(document.sbuForm.searchFieldPo.value)
	if(document.sbuForm.searchFieldPo.value == "")
	{
		alert("Please enter Purchase Order Number");
		document.sbuForm.searchFieldPo.focus();
		return false;
	}
	else
	{
		document.sbuForm.searchFieldPo.value = funTrim(document.sbuForm.searchFieldPo.value);
		document.sbuForm.searchField.value=document.sbuForm.searchFieldPo.value

		document.sbuForm.base.value=document.sbuForm.basePo.value;
		document.sbuForm.InvStat.value=document.sbuForm.InvStatPo.value;

		document.sbuForm.action="../../JSPs/Purorder/ezSearchListInv.jsp"
		document.sbuForm.submit();
	}
}

function VerifyEmptyVIN()
{
	document.sbuForm.searchFieldVin.value=funTrim(document.sbuForm.searchFieldVin.value)
	if(document.sbuForm.searchFieldVin.value == "")
	{
		alert("Please enter Vendor Invoice Number");
		document.sbuForm.searchFieldVin.focus();
		return false;
	}
	else
	{
		document.sbuForm.searchFieldVin.value = funTrim(document.sbuForm.searchFieldVin.value);
		document.sbuForm.searchField.value=document.sbuForm.searchFieldVin.value;

		document.sbuForm.base.value=document.sbuForm.baseVin.value;
		document.sbuForm.InvStat.value=document.sbuForm.InvStatVin.value;

		document.sbuForm.action="../../JSPs/Purorder/ezSearchListInv.jsp"
		document.sbuForm.submit();
	}
}


//Script of Delivery Challan Starts here

	function verifyEmptyDC()
	{
		document.sbuForm.DCNO.value=funTrim(document.sbuForm.DCNO.value)
		if(document.sbuForm.DCNO.value == "")
		{
			alert("Please enter Delivery Note No.");
			document.sbuForm.DCNO.focus();
			return false;
		}
		return true;
	}


	function changeAction()
	{

		if(verifyEmptyDC())
		{
			//alert(document.sbuForm.SearchFlagDc.value);
			document.sbuForm.SearchFlag.value=document.sbuForm.SearchFlagDc.value;
			if(document.sbuForm.r1[0].checked)
				 document.sbuForm.action="../Purorder/ezListPOs.jsp";
			else
			  	document.sbuForm.action="../Purorder/ezContract.jsp?OrderType=All";
				document.sbuForm.submit();

		}


	}

//script of Schedule Agreement Starts here
	function verifyEmptySA()
	{
		document.sbuForm.contractNum.value=funTrim(document.sbuForm.contractNum.value)
		if(document.sbuForm.contractNum.value == "")
		{
			alert("Please enter Schedule Agreement No.");
			document.sbuForm.contractNum.focus();
			return false;
		}
		return true;
	}
	function verifyEmptySA1()
	{
		if(verifyEmptySA())
		{
			//alert(document.sbuForm.SearchFlag.value);
			document.sbuForm.action="../Purorder/ezContract.jsp"
			document.sbuForm.submit();
		}

	}



function funLTrim(sValue)
{
	var nLength=sValue.length;
	var nStart=0;
	while ((nStart < nLength) && (sValue.charAt(nStart) == " "))
	{
		nStart=nStart+1;
	}

	if (nStart==nLength)
	{
		sValue="";
	}
	else
	{
		sValue=sValue.substr(nStart,nLength-nStart);
	}

	return sValue;

}

function funRTrim(sValue)
{

	var nLength=sValue.length;
	if (nLength==0)
	{
		sValue="";
	}
	else
	{
		var nStart=nLength-1;

		while ((nStart > 0) && (sValue.charAt(nStart)==" "))
		{
			nStart=nStart-1;
		}

		if (nStart==-1)
		{

			sValue="";


		}
		else
		{
			sValue=sValue.substr(0,nStart+1);
		}
	}

	return sValue;
}
function funTrim(sValue)
{
	sValue=funLTrim(sValue);
	sValue=funRTrim(sValue);
	return sValue;
}


//-->
</script>



<script>

  function sbuSubmit()
    {

		if(document.sbuForm.sbu.options[document.sbuForm.sbu.options.selectedIndex].value=="POStatus")
		{
			
                     if(document.getElementById("main")!=null && document.getElementById("posearch")!=null && document.getElementById("invoice")!=null && document.getElementById("deliverychallan")!=null && document.getElementById("schagreement")!=null) 
		     {	
			document.getElementById("main").style.visibility="hidden";
			document.getElementById("posearch").style.visibility="visible";
			document.getElementById("invoice").style.visibility="hidden";
			document.getElementById("deliverychallan").style.visibility="hidden";
			document.getElementById("schagreement").style.visibility="hidden";
			document.sbuForm.sbu.selectedIndex=1;
		    }	

		}
		else if(document.sbuForm.sbu.options[document.sbuForm.sbu.options.selectedIndex].value=="InVoice")
		{
                     if(document.getElementById("main")!=null && document.getElementById("posearch")!=null && document.getElementById("invoice")!=null && document.getElementById("deliverychallan")!=null && document.getElementById("schagreement")!=null) 
		     {	
			document.getElementById("main").style.visibility="hidden";
			document.getElementById("posearch").style.visibility="hidden";
			document.getElementById("invoice").style.visibility="visible";
			document.getElementById("deliverychallan").style.visibility="hidden";
			document.getElementById("schagreement").style.visibility="hidden";
			document.sbuForm.sbu.selectedIndex=2;
		     }	

		}
		else if(document.sbuForm.sbu.options[document.sbuForm.sbu.options.selectedIndex].value=="DeliveryChallan")
		{
                     if(document.getElementById("main")!=null && document.getElementById("posearch")!=null && document.getElementById("invoice")!=null && document.getElementById("deliverychallan")!=null && document.getElementById("schagreement")!=null) 
		     {	
			document.getElementById("main").style.visibility="hidden";
			document.getElementById("posearch").style.visibility="hidden";
			document.getElementById("invoice").style.visibility="hidden";
			document.getElementById("deliverychallan").style.visibility="visible";
			document.getElementById("schagreement").style.visibility="hidden";
			document.sbuForm.sbu.selectedIndex=3;
		     }	

		}
		else if(document.sbuForm.sbu.options[document.sbuForm.sbu.options.selectedIndex].value=="SchAgreement")
		{
                     if(document.getElementById("main")!=null && document.getElementById("posearch")!=null && document.getElementById("invoice")!=null && document.getElementById("deliverychallan")!=null && document.getElementById("schagreement")!=null) 
		     {	
			document.getElementById("main").style.visibility="hidden";
			document.getElementById("posearch").style.visibility="hidden";
			document.getElementById("invoice").style.visibility="hidden";
			document.getElementById("deliverychallan").style.visibility="hidden";
			document.getElementById("schagreement").style.visibility="visible";
			document.sbuForm.sbu.selectedIndex=4;
		     } 	
		}
	        else if(document.sbuForm.sbu.options[document.sbuForm.sbu.options.selectedIndex].value=="-")
		{
                     if(document.getElementById("main")!=null && document.getElementById("posearch")!=null && document.getElementById("invoice")!=null && document.getElementById("deliverychallan")!=null && document.getElementById("schagreement")!=null) 
		     {	
			document.getElementById("posearch").style.visibility="hidden";
			document.getElementById("invoice").style.visibility="hidden";
			document.getElementById("deliverychallan").style.visibility="hidden";
			document.getElementById("schagreement").style.visibility="hidden";
			document.getElementById("main").style.visibility="visible";
			document.sbuForm.sbu.selectedIndex=0;
		     }	
		}


    }
</script>
<body bgcolor="#FFFFF7" topmargin = "0" scroll="no">
<form name="sbuForm">
<br>
  <table border="0" align="center" valign="center">
    <tr><th align=left>Search Options &nbsp;&nbsp;</th>
	<td>
		<div id="listBoxDiv1">
		<select name="sbu" onChange="sbuSubmit()">
			<option value="-">Choose Search</option>
			<option value="POStatus">PO Status</option>
			<option value="InVoice">Invoice</option>
			<option value="DeliveryChallan">DN No</option>
			<option value="SchAgreement">Schedule Agreement</option>
		</select>
		</div>
	</td>
    </tr>
  </TABLE>
<br>
<br>
<div id="main" style='Position:Absolute;visibility:visible;Left:20%;WIDTH:60%;'>
  <table width="100%">
    <tr>
      <td class="blankcell">
      	 Dear Vendor, You can Search orders assigned to you and follow up on status of your Orders,Shipment and Invoices.<br><br>
	 Select a search from the above list to view the details pertaining to your dealings with a specific search.
     </td>
    </tr>
  </table>
</div>




<div id="posearch"  style='Position:Absolute;visibility:hidden;Left:10%;WIDTH:80%;height:70%;Top:15%'>
	<br>
	<table align="center" width="45%">
  		<tr align="center">
 		   <td class="displayheader">Purchase Order search</td>
 		 </tr>
	</table>

	<table width="80%" align="center">
	<tr>
        <td class="blankcell">Use this screen to View the List of Purchase Orders for a specific Material
         Provide the information for your inquiry, then click on the Search button.
	</td>
	</tr>
	</table>
	<br>
	  <table width="45%" border="2" bordercolor="#660066" align="center" cellpadding="0" cellspacing="0">
	    <tr bordercolor="#FFFFFF">
	      <th align="center" width="40%">Material No</th>
	      <td class="blankcell" valign="middle" align="left" height="17">
	        <input type="text" name="MaterialNumber" maxlength="18" size="18">
		<input type="hidden" name="SearchFlagMn" value="MaterialNumber">
	      </td>
	      <td valign="middle" align="left" height="17" class="blankcell">
	        <!-- <img  src="../../Images/Buttons/<%=ButtonDir%>/gosmall.gif" border="none" style="cursor:hand" onClick="VerifyEmptyMat()"> -->
	        <%
				
				buttonName = new java.util.ArrayList();
				buttonMethod = new java.util.ArrayList();
				
				buttonName.add("Go");
				buttonMethod.add("VerifyEmptyMat()");
				
				out.println(getButtonStr(buttonName,buttonMethod));
		%>
	      </td>
	    </tr>
	  </table>
	<br>
	<input type="hidden" name="POSearch" value="yes">
	<table width="45%" border="2" bordercolor="#660066" align="center" cellpadding="0" cellspacing="0">
	    <tr bordercolor="#FFFFFF">
	      <th align="center" width="40%">PO No</td>
	      <td class="blankcell" valign="middle" align="left" height="17">
	        <input type="text" name="PurchaseOrder" maxlength="10" size="18">
	      </td>

	      <td valign="middle" align="left" height="17" class="blankcell">
	        <!-- <img src="../../Images/Buttons/<%=ButtonDir%>/gosmall.gif" border="none" style="cursor:hand" onClick="VerifyEmptyPurOrder() "> -->
	        <%
						
				buttonName = new java.util.ArrayList();
				buttonMethod = new java.util.ArrayList();
						
				buttonName.add("Go");
				buttonMethod.add("VerifyEmptyPurOrder()");
					
				out.println(getButtonStr(buttonName,buttonMethod));
		%>
	      </td>
	    </tr>
	  </table>
</div>


	<div id="invoice"  style='Position:Absolute;visibility:hidden;Left:10%;WIDTH:80%;height:70%;Top:15%'>
	<br>	
	<table width="40%" border="0" align="center">
		<tr align="center">
			<td class="displayheader">Invoice search</td>
		</tr>
	</table>
	<table width="80%" border="0" align="center" cellspacing="0" cellpadding="0">
	<tr>
	<td class="blankcell">
	Enter Vendor Invoice Number and click on 'GO' to see the list of the invoices for that PO.
	</td>
	</tr>
	</table>

	<table width="45%" border="2" align="center" bordercolor="#660066" cellpadding="0" cellspacing="0">
		<tr bordercolor="#FFFFFF">
		<th width="60%">Vendor Inv. No </th>
		<td width="25%">
	        	<input type="text" name="searchFieldVin" size="16" maxlength="16">
			<input type="hidden" name="baseVin" value="VendorInvoiceNumber">
			<input type="hidden" name="InvStatVin" value="A">
		</td>
		<td width="15%" class="blankcell" align="right">
        		<!-- <img src="../../Images/Buttons/<%=ButtonDir%>/gosmall.gif" border="none" style="cursor:hand" onClick="VerifyEmptyVIN()"> -->
        		<%
					
					buttonName = new java.util.ArrayList();
					buttonMethod = new java.util.ArrayList();
					
					buttonName.add("Go");
					buttonMethod.add("VerifyEmptyVIN()");
					
					out.println(getButtonStr(buttonName,buttonMethod));
			%>
		</td>
		</tr>
	</table>

	<table width="80%" border="0" align="center">
	<tr>
	<td class="blankcell">
	Enter an Invoice number and then click on 'Go' to see the details.
	</td>
	</tr>
	</table>

	<table width="45%" border="2" align="center" bordercolor="#660066" cellpadding="0" cellspacing="0">
	<tr bordercolor="#FFFFFF">
	<th width="60%">SAP Inv. No </th>
	<td width="25%">
	<input type="text" name="searchFieldSo" size="16" maxlength="10">
	<input type="hidden" name="baseSo" value="Invoice">
	<input type="hidden" name="InvStatSo" value="A">
	<input type="hidden" name="compCode" value="DRL">
	</td>
	<td width="15%" class="blankcell" align="right">
	<!-- <img src="../../Images/Buttons/<%=ButtonDir%>/gosmall.gif" border="none" style="cursor:hand" onClick="VerifyEmptySO()"> -->
	<%
			
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();
			
			buttonName.add("Go");
			buttonMethod.add("VerifyEmptySO()");
			
			out.println(getButtonStr(buttonName,buttonMethod));
	%>
	</td>
	</tr>
	</table>

	<table width="80%" border="0" align="center" cellspacing="0" cellpadding="0">
	<tr>
	<td class="blankcell">
	Enter a PO Number and click on  'GO' to see the list of the invoices for that PO.
	</td>
	</tr>
	</table>

	<table width="45%" border="2" align="center" bordercolor="#660066" cellpadding="0" cellspacing="0">
	<tr bordercolor="#FFFFFF">
	<th width="60%">PO No </th>
	<td width="25%">
	<input type="text" name="searchFieldPo" size="16" maxlength="10">
	<input type="hidden" name="basePo" value="PurchaseOrder">
	<input type="hidden" name="InvStatPo" value="P">
	</td>
	<td width="15%" class="blankcell" align="right">
	<!-- <img src="../../Images/Buttons/<%=ButtonDir%>/gosmall.gif" border="none" style="cursor:hand" onClick="VerifyEmptyPO()"> -->
	<%
			
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();
			
			buttonName.add("Go");
			buttonMethod.add("VerifyEmptyPO()");
			
			out.println(getButtonStr(buttonName,buttonMethod));
	%>
	</td>
	</tr>
	</table>
	</div>

<div id="deliverychallan"  style='Position:Absolute;visibility:hidden;Left:10%;WIDTH:80%;height:70%;Top:15%'>
	<br>
	<table width="40%" border="0" align="center">
	<tr align="center">
	<td class="displayheader">DN Status search</td>
	</tr>
	</table><br>
	<table width="80%" border="0" align="center">
	<tr><td class="blankcell">
	Use this screen to View the List of Purchase Orders or Schedule Agreements for a specific Delivery Note No
	Provide the information for your inquiry, check the option on which you want to search , then click on the 'Go' button. </td>
	</tr>
	</table>
	<br>

	<table width="60%" border="2" bordercolor="#660066" align="center" cellspacing="0" cellpadding="0">
	<tr bordercolor="#FFFFFF">
	<th valign="middle" align="center" width="40%" class="labelcell" height="17">  DN No</th>
	<td valign="middle" align="left" height="17">
        	<input type="text" name="DCNO" maxlength="16" size="16">
		<input type="hidden" name="SearchFlagDc" value="DCnoSearch">
	</td>
	<td rowspan="2" valign="middle" align="left" height="17" class="blankcell">
        	<!-- <img src="../../Images/Buttons/<%=ButtonDir%>/gosmall.gif" border="none" style="cursor:hand" onClick='changeAction()'> -->
        	<%
				
				buttonName = new java.util.ArrayList();
				buttonMethod = new java.util.ArrayList();
				
				buttonName.add("Go");
				buttonMethod.add("changeAction()");
				
				out.println(getButtonStr(buttonName,buttonMethod));
		%>
	</td>
	</tr>
	<tr>
	<th align = left><input type="radio" name="r1" checked value="PO">Purchase Order</th>
	<th align = left><input type="radio" name="r1" value="SC">Schedule Agreements</th>
	</tr>
	</table>





</div>

<div id="schagreement"  style='Position:Absolute;visibility:hidden;Left:10%;WIDTH:80%;height:70%;Top:15%'>
	<br>
	<table width="40%" border="0" align="center">
	<tr align="center">
	<td class="displayheader">Schedule Agreement search</td>
	</tr>
	</table><br>
	<table width="80%" border="0" align="center">
	<tr>
	<td class="blankcell">
	Use this screen to View the List of Purchase Orders for a specific Schedule Agreement Number
	Provide the information for your inquiry, then click on the Search button.</td>
	</tr>
	</table>
	<br>

	<input type="hidden" name="SchSearch" value="yes">
	<table width="45%" border="2" bordercolor="#660066" align="center" cellspacing="0" cellpadding="0">
	<tr bordercolor="#FFFFFF">
	<th align="center" width="60%">Agreement No

	</th>
	<td class="blankcell" valign="middle" align="left" height="17">
        	<input type="text" name="contractNum" maxlength="10" size="13">
	</td>
	<td valign="middle" align="left" height="17" class="blankcell">
		<!-- <img src="../../Images/Buttons/<%=ButtonDir%>/gosmall.gif" border="none" style="cursor:hand" onClick="verifyEmptySA1()"> -->
		<%
				
				buttonName = new java.util.ArrayList();
				buttonMethod = new java.util.ArrayList();
				
				buttonName.add("Go");
				buttonMethod.add("verifyEmptySA1()");
				
				out.println(getButtonStr(buttonName,buttonMethod));
		%>
	</td>
	</tr>
	</table>


</div>

<input type="hidden" name="searchField" size="10" maxlength="10">
<input type="hidden" name="base" >
<input type="hidden" name="InvStat" >
<input type="hidden" name="SearchFlag" >
</FORM>
<Div id="MenuSol"></Div>
</body>
</html>



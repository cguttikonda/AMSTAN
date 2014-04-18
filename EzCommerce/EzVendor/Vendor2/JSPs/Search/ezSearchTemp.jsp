<%@ include file="../../Library/Globals/errorPagePath.jsp" %>
<%//@ include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<%
	String ButtonDir = "ENGLISH/GREEN";
%>
<%@ include file="../../../Includes/Jsps/Misc/iblockcontrol.jsp" %>
<html>
<head>
<style>
BODY {
	border-right:#FFFFFF 0px inset;
	border-top: #ffffff 0px inset;
	border-left: #ffffff 0px inset;
	border-bottom: #FFFFFF 0px inset;
	scrollbar-3dlight-color:#82b008;
	scrollbar-arrow-color:#FFFFFF;
	scrollbar-base-color:#82b008;
	scrollbar-darkshadow-color:#000000;
	scrollbar-highlight-color:#ffffff;
	scrollbar-shadow-color:#000000;
	Scrollbar-Track-Color :#eff6fc;
	BACKGROUND-COLOR:#ccffcc;
}
TABLE {
	FONT-SIZE: 14pt; COLOR: #330099; FONT-STYLE: normal; FONT-FAMILY: "Courier New", Courier, mono
}
TR {
	FONT-WEIGHT: normal; FONT-SIZE: 10pt; LINE-HEIGHT: normal; FONT-STYLE: normal; FONT-FAMILY: "Trebuchet MS"
}
TH{

	color: #FFF;
	text-decoration: none;
	height: 20px;
    	font-size: 10px;
    	font-family: verdana,arial,sans-serif;
    	background-color: #82b008;
}
TD {
	color: #000;
	text-decoration: none;
    	font-size: 9px;
    	font-family: verdana,arial,sans-serif;
}
</style>
<Script src="../../Library/JavaScript/Misc/ezTrim.js"></Script>
<Script>
	function showDiv(currentTab,totalTabs)
	{
	       for(var i=1;i<=totalTabs;i++)
	       {
	               if(i==currentTab)
	               {
	                        document.getElementById("tab"+i).style.visibility="visible"
	                        document.getElementById("tab"+i).style.width="100%"
	                        document.getElementById("tab"+i+"color").style.color="#000000"
	                        document.getElementById("tab"+i+"_3").src="../../Images/Buttons/<%=ButtonDir%>/Inbox_files/ImgLftUp.gif"
	                        document.getElementById("tab"+i+"_2").src="../../Images/Buttons/<%=ButtonDir%>/Inbox_files/ImgRgtUp.gif"
	                        document.getElementById("tab"+i+"_1").style.background="url('../../Images/Buttons/<%=ButtonDir%>/Inbox_files/ImgCtrUp.gif')"
			}
	                else
	                {
		                document.getElementById("tab"+i).style.visibility="hidden"
	                        document.getElementById("tab"+i+"color").style.color="#B7B7B7"
	                        document.getElementById("tab"+i+"_3").src="../../Images/Buttons/<%=ButtonDir%>/Inbox_files/ImgLftDn.gif"
	                        document.getElementById("tab"+i+"_2").src="../../Images/Buttons/<%=ButtonDir%>/Inbox_files/ImgRgtDn.gif"
	                        document.getElementById("tab"+i+"_1").style.background="url('../../Images/Buttons/<%=ButtonDir%>/Inbox_files/ImgCtrDn.gif')"
	                        document.getElementById("tab"+i).style.width="0%"
	                 }
	        }
	}
	
	function funSubmit(docType)
	{
		var selLen = eval("document.myForm."+docType+"bySel"+".length");
		var keyVal ="";
		if(selLen!=null)
		{
			for(i=0;i<selLen;i++)
			{
				if(eval ("document.myForm." +docType+"bySel["+i+"]"+".checked"))
					keyVal =eval ("document.myForm." +docType+"bySel["+i+"]"+".value")

			}
		}
		if(docType=='PO')
		{
			if(keyVal=='PObyMat')
				VerifyEmptyMat();
			else if(keyVal=='PObyNo')
				VerifyEmptyPurOrder();			
		}
		if(docType=='PR')
		{		
			PRDetails(keyVal);			
		}
		if(docType=='SA')
		{
		
			document.myForm.SA.value=funTrim(document.myForm.SA.value)
			var saVal = document.myForm.SA.value;
			document.myForm.contractNum.value=saVal;
			if(saVal == "" || saVal=="Enter Here")
			{
				alert("Please Enter Schedule Agreement No");
				document.myForm.SA.focus();
				return false;
			}
			else 
			{
				document.myForm.action="../Purorder/ezcontract.jsp"
				document.myForm.submit();
			}
		}
		if(docType=='DC')
		{
			document.myForm.DC.value=funTrim(document.myForm.DC.value);
			var dcVal= document.myForm.DC.value;
			if(dcVal == "")
			{
				alert('Please Enter Delivery Challan No');
				document.myForm.DC.focus();
				return false;
			}
			else
			{
				document.myForm.SearchFlag.value="DCnoSearch";
				document.myForm.DCNO.value=dcVal;
				if(keyVal=='DCforPO')
					 document.myForm.action="../Purorder/ezListPOs.jsp";
				else
					document.myForm.action="../Purorder/ezcontract.jsp?OrderType=All";
				document.myForm.submit();
			}
		}
		
	}
	
	function VerifyEmptyMat()
	{
		var matNo = funTrim(document.myForm.PO.value);
		if(matNo.indexOf("*")!=-1)
		{
			alert("Wild cards are not allowed by Material Search");
			document.myForm.PO.focus();
			return false;
		}
		if(matNo == "")
		{
			alert("Please enter Material No. or Description");
			document.myForm.PO.focus();
			return false;
		}
		else
		{
			if(isNaN(parseInt(matNo)))
			{
				document.myForm.PO.value = matNo
			}
			else{
				matNo="000000000000000000"+matNo;
				matNo=matNo.substring(matNo.length-18,matNo.length);
				document.myForm.PO.value = matNo
			}
			document.myForm.SearchFlag.value="MaterialNumber"
			document.myForm.MaterialNumber.value=matNo;
			document.myForm.action="../../JSPs/Purorder/ezSearchPOMatList.jsp"
			document.myForm.submit();
			return;
		}
	}
	
	function VerifyEmptyPurOrder()
	{		
		document.myForm.POSearch.value="Yes";
		var PONo = funTrim(document.myForm.PO.value);
		if ((PONo =="") || isNaN(parseInt(PONo)))
		{
			alert("Please Enter Purchase Order No");
			document.myForm.PO.focus()
			return false;
		}
		else
		{
			document.myForm.SearchFlag.value="PONO";
			document.myForm.PurchaseOrder.value=PONo;
			document.myForm.action="../../JSPs/Purorder/ezSearchPOList.jsp?PurchaseOrder="+dd;
			document.myForm.submit();
		}
	}
	function PRDetails(keyVal)
	{		
	
		var prNo = funTrim(document.myForm.PR.value);
		if(keyVal=='PRbyNo')
		{
			prNo="0000000000"+prNo;
			prNo=prNo.substring(prNo.length-10,prNo.length);
			document.myForm.prNumber.value = prNo			
		}
		else if(keyVal=='PRbyMat')
		{			
			if(isNaN(parseInt(prNo)))
			{
				document.myForm.selMaterial.value = prNo
			}
			else
			{
				prNo="000000000000000000"+prNo;
				prNo=prNo.substring(prNo.length-18,prNo.length);
				document.myForm.selMaterial.value = prNo				
			}	
		}
		document.myForm.action="../../JSPs/Rfq/ezListPR.jsp";
		document.myForm.submit();
	}
</Script>
<%
	int tabCount = 5;
	java.util.Hashtable tabHash = new java.util.Hashtable();
        tabHash.put("TAB1","Purchase Requisitions");
        //tabHash.put("TAB2","QCFs");
        tabHash.put("TAB2","Purchase Orders");       
        tabHash.put("TAB3","Schedule Agreements");    
        tabHash.put("TAB4","Invoices");    
        tabHash.put("TAB5","Delivery Challans");    
%>
</head>
<body onLoad="showDiv('1','<%=tabCount%>')">
<form name="myForm" method="post">
<%
	String display_header = "Search";	
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>

<Table align=center border=0 cellPadding=0 cellSpacing=0  width=90% height=45%>
<Tr height=10>
	<Td>
		<Table cellSpacing=0 cellPadding=0 border=0 >		
		<Tr>		
<%
	            for(int i=1;i<=tabCount;i++)
	            {
%>
			<Td ><IMG id="tab<%=i%>_3" height=27 src="../../Images/Buttons/<%=ButtonDir%>/Inbox_files/ImgLftUp.gif" width=5 border=0></Td>
			<Td id="tab<%=i%>_1" style="cursor:hand" style="background-image:url('../../Images/Buttons/<%=ButtonDir%>/Inbox_files/ImgCtrUp.gif')" onClick="showDiv('<%=i%>','<%=tabCount%>')"><font id='tab<%=i%>color'><b>&nbsp;&nbsp;&nbsp;&nbsp;<%=(String)tabHash.get("TAB"+i)%>&nbsp;&nbsp;&nbsp;</b></font></Td>
			<Td ><IMG id="tab<%=i%>_2" height=27 src="../../Images/Buttons/<%=ButtonDir%>/Inbox_files/ImgRgtUp.gif" width=10  border=0></Td>
<%
		    }
%>	
		</Tr>
		</Table>
	</Td>
</Tr>


<Tr>
<Td>
<div id="tab1" style="overflow:auto;position:absolute;height:90%;width:100%;visibility:hidden;background-color:#E6E6E6">
<br><br><br>
	<Table width="50%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0>	
		<tr>
		    <td width="30%">
				<input type="text" class=InputBox   style="width:100%" name="PR"  size="15" value="">
		    </td>	
		    <td width="5%" valign=middle align=center rowspan=2>	
				<img src="../../Images/Buttons/<%=ButtonDir%>/find.gif" alt ="Click here to Search" style="cursor:hand" height="18" onClick="funSubmit('PR')"></img>
		    </td>
		</tr>  
		<tr>
		    <th width="30%">
		    
		    		<input type="hidden" name="selMaterial">
		    		<input type="hidden" name="prNumber">
			       	<input type="radio" name="PRbySel" value=PRbyMat checked>By Material.
			    	<input type="radio" name="PRbySel" value=PRbyNo >By Purchase Requition No.
		    </th>
		</tr> 
	 </Table> 
</div>

<!--
<div id="tab2" style="overflow:auto;position:absolute;height:90%;width:100%;visibility:hidden;background-color:#E6E6E6">
</div>
-->

<div id="tab2" style="overflow:auto;position:absolute;height:90%;width:100%;visibility:hidden;background-color:#E6E6E6">
<br><br><br>
	<Table width="50%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0>	
		<tr>
		    <td width="30%">
				<input type="text" class=InputBox   style="width:100%" name="PO"  size="15" value="">
		    </td>	
		    <td width="5%" valign=middle align=center rowspan=2>	
				<img src="../../Images/Buttons/<%=ButtonDir%>/find.gif" alt ="Click here to Search" style="cursor:hand" height="18" onClick="funSubmit('PO')"></img>
		    </td>
		</tr>  
		<tr>
		    <th width="30%">
				<input type="hidden" name="PurchaseOrder" value="">
				<input type="hidden" name="POSearch" value="">
  			        <input type="hidden" name="SearchFlag">
				<input type="hidden" name="MaterialNumber">
			       	<input type="radio" name="PObySel" value=PObyMat checked>By Material.
			    	<input type="radio" name="PObySel" value=PObyNo >By Purchase Order No.
		    </th>
		</tr> 
	 </Table> 
</div>
<div id="tab3" style="overflow:auto;position:absolute;height:90%;width:100%;visibility:hidden;background-color:#E6E6E6">
<br><br><br>
	<Table width="50%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0>	
		<tr>
		    <th width="45%">
		    		Schedule Agreement No
		    </th>
		    <td width="45%">
		    		<input type="hidden" name="SAbySel" value="">
		    		<input type="hidden" name="contractNum" value="" >
				<input type="text" class=InputBox   style="width:100%" name="SA"  size="15" value="">
		    </td>	
		    <td width="10%" valign=middle align=center rowspan=2>	
				<img src="../../Images/Buttons/<%=ButtonDir%>/find.gif" alt ="Click here to Search" style="cursor:hand" height="18" onClick="funSubmit('SA')"></img>
		    </td>
		</tr>  
	 </Table> 
</div>

<div id="tab4" style="overflow:auto;position:absolute;height:90%;width:100%;visibility:hidden;background-color:#E6E6E6">
<br><br><br>
	<Table width="50%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0>	
		<tr>

		    <td width="30%">
				<input type="text" class=InputBox   style="width:100%" name="INV"  size="15" value="">
		    </td>	
		    <td width="5%" valign=middle align=center rowspan=2>	
				<img src="../../Images/Buttons/<%=ButtonDir%>/find.gif" alt ="Click here to Search" style="cursor:hand" height="18" onClick="funSubmit('INV')"></img>
		    </td>
		</tr>  
		<tr>
		    <th width="30%">
			       	<input type="radio" name="INVbySel" value=byInv checked>By Invoice No.
			    	<input type="radio" name="INVbySel" value=byPONo >By Purchase Order No.
		    </th>
		</tr> 
	 </Table> 
</div>

<div id="tab5" style="overflow:auto;position:absolute;height:90%;width:100%;visibility:hidden;background-color:#E6E6E6">
<br><br><br>
	<Table width="50%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0>	
		<tr>

		    <td width="30%">
		    		<input type="hidden" name="SearchFlag">
				<input type="hidden" name="DCNO" value="">
				<input type="text" class=InputBox   style="width:100%" name="DC"  size="15" value="">
		    </td>	
		    <td width="5%" valign=middle align=center rowspan=2>	
				<img src="../../Images/Buttons/<%=ButtonDir%>/find.gif" alt ="Click here to Search" style="cursor:hand" height="18" onClick="funSubmit('DC')"></img>
		    </td>
		</tr>  
		<tr>
		    <th width="30%">
			       	<input type="radio" name="DCbySel" value="DCforPO" checked>By Purchase Order No.
			    	<input type="radio" name="DCbySel" value="DCforSA" >By Schedule Agreement No.
		    </th>
		</tr> 
	 </Table> 
</div>
</Td>

</Tr>
</Table>
</form>
<Div id="MenuSol"></Div>
</body>
</html>


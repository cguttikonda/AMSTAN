<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@include file="../../../Includes/JSPs/Rfq/iListRFQByCollectiveRFQ.jsp"%>
<%@ include file="../../../Includes/Jsps/Misc/iGetVendorDesc.jsp"%>
<%	
	for(int i=myRet.getRowCount()-1;i>=0;i--)
	{
		if(!("R".equals(myRet.getFieldValueString(i,"RELEASE_INDICATOR").trim())))
			myRet.deleteRow(i);
	}
	int qcfCount = myRet.getRowCount();
%>
<html>
<head>
<title>Enter Contract Creation Details -- Powered By EzCommerce India</title>
<head>
<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%@ include file="../../../Includes/Jsps/Misc/iShowCal.jsp"%>
<%
	//String valuationTypes[] = {"01","02","A/L (SFG)","A/L FOR RM","C1","C2","C3","DOM. (SFG)","DOM.FOR RM","EIGEN","FREMD","LAND 1","LAND 2","MFD (FG)","MFD (SFG)","OGL (SFG)","OGL FOR RM","PROC (FG)","RAKTION","RM MOHALI","RM TOANSA","RNORMAL"};	
	String valuationTypes[] = {"C1","C2","C3"};

	java.util.Date today = new java.util.Date();
	ezc.ezutil.FormatDate format = new ezc.ezutil.FormatDate();
%> 
<Script>
	var tabHeadWidth=95
	var tabHeight="75%"
</Script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<Script src="../../Library/JavaScript/checkFormFields.js"></Script>
<Script>


function showTrgtValue(indx)
{
	var len = '<%=qcfCount%>';
	if(len>1)
	{
		var docType = document.myForm.docType[indx].value;
		var qty = document.myForm.poQuantity[indx].value;
		var trgtVal = document.myForm.tValue[indx].value;
		if(docType =='MK')
		{
			document.myForm.targetValue[indx].value = qty;
		}
		else
		if(docType =='WK')
		{
			document.myForm.targetValue[indx].value = trgtVal;
		}
		else 
		{
			document.myForm.targetValue[indx].value = "0.0";
		}
	}
	else
	{
		var docType = document.myForm.docType.value;
		var qty = document.myForm.poQuantity.value;
		var trgtVal = document.myForm.tValue.value;
		if(docType =='MK')
		{
			document.myForm.targetValue.value = qty;
		}
		else
		if(docType =='WK')
		{
			document.myForm.targetValue.value = trgtVal;
		}
		else 
		{
			document.myForm.targetValue.value = "0.0";
		}
	}
}



function createContract()
{

	
	var arr = new Array();
	var len 	= '<%=qcfCount%>';
	
<%	
		for(int k=0;k<qcfCount;k++)
		{
			if(k==0)
			{				
%>				qty = 	'<%=myRet.getFieldValueString(k,"QUANTITY")%>';
				arr['<%=k%>'] = '<%=myRet.getFieldValueString(k,"VENDOR")%>';
<%			}
			else
			{
%>				arr['<%=k%>'] = '<%=myRet.getFieldValueString(k,"VENDOR")%>';
<%			}
		}
%>	
	/*var endDate 	= document.myForm.contractEndDate.value;
	var startDate   = document.myForm.contractStartDate.value;
	var myDate	= new Date();
	var day		= myDate.getDate();	
	var month	= myDate.getMonth()+1;
	*/
	if(len>1)
	{
		for(var i=0;i<len;i++)
		{
			if(document.myForm.poQuantity[i].value=="")
			{
				alert("Please Enter Quantity for For Vendor "+arr[i])
				document.myForm.poQuantity[i].focus()
				return;
			}
			if(document.myForm.docType[i].selectedIndex==0)
			{
				alert("Please Select Document Type For Vendor "+arr[i])
				document.myForm.docType[i].focus()
				return;
			}
			
			var cntrDate = eval("document.myForm.contractEndDate"+i);
			if(cntrDate.value=="")
			{
				alert("Please select End Date from calendar For Vendor "+arr[i])
				cntrDate.focus()
				return;
			}
			else
			{
				sDate = cntrDate.value;
				selDate = sDate.split(".");
				var sd = new Date();
				var td = new Date();
				var a1 = parseInt(selDate[1],10)-1;

				sd = new Date(selDate[2],a1,selDate[0]);
				var dd=td.getDate();
				var mm=td.getMonth();
				var yy=td.getYear();

				td  = new Date(yy,mm,dd);

				if(sd<td)
				{
					alert("End Date should be greater than or equals to today's date For Vendor "+arr[i])
					cntrDate.focus();
					return;
				}	
			}
			
			
			var cntrEndDate = eval("document.myForm.contractEndDate"+i);
			var cntrStrtDate = eval("document.myForm.contractStartDate"+i);
			
			var selEndDate = cntrEndDate.value;
			var selStrtDate = cntrStrtDate.value;

			var endDate = selEndDate.split(".");
			var strtDate = selStrtDate.split(".");
			var edDate = new Date();
			var srDate = new Date();

			var a1 = parseInt(endDate[1],10)-1;
			var b1 = parseInt(strtDate[1],10)-1;

			edDate = new Date(endDate[2],a1,endDate[0]);
			srDate = new Date(strtDate[2],b1,strtDate[0]);


			if(srDate >= edDate)
			{
				alert("Contract End Date should be greater than Contract Start Date For Vendor "+arr[i])
				cntrEndDate.focus();
				return;
			}
		
		}
	}
	else
	{
		if(document.myForm.poQuantity.value=="")
		{
			alert("Please Enter Quantity")
			document.myForm.poQuantity.focus()
			return;
		}
		if(document.myForm.docType.selectedIndex==0)
		{
			alert("Please Select Document Type")
			document.myForm.docType.focus()
			return;
		}
		
		if(document.myForm.contractEndDate0.value=="")
		{
			alert("Please select End Date from calendar")
			document.myForm.contractEndDate0.focus()
			return;
		}
		else
		{
			sDate = document.myForm.contractEndDate0.value;
			selDate = sDate.split(".");
			var sd = new Date();
			var td = new Date();
			var a1 = parseInt(selDate[1],10)-1;

			sd = new Date(selDate[2],a1,selDate[0]);
			var dd=td.getDate();
			var mm=td.getMonth();
			var yy=td.getYear();

			td  = new Date(yy,mm,dd);

			if(sd<td)
			{
				alert("End Date should be greater than or equals to today's date");
				document.myForm.contractEndDate0.focus();
				return;
			}
		}
		
		var selEndDate = document.myForm.contractEndDate0.value;
		var selStrtDate = document.myForm.contractStartDate0.value;
		
		var endDate = selEndDate.split(".");
		var strtDate = selStrtDate.split(".");
		var edDate = new Date();
		var srDate = new Date();
		
		var a1 = parseInt(endDate[1],10)-1;
		var b1 = parseInt(strtDate[1],10)-1;
		
		edDate = new Date(endDate[2],a1,endDate[0]);
		srDate = new Date(strtDate[2],b1,strtDate[0]);
		
		
		if(srDate >= edDate)
		{
			alert("Contract End Date should be greater than  Contract Start Date");
			document.myForm.contractEndDate0.focus();
			return;
		}
	
	}
	
	/*
	var entrdQty = 0;
	if(len>1)
	{
		for(var k=0;k<len;k++)	
		{
			entrdQty = entrdQty + parseInt(document.myForm.poQuantity[k].value);
			//document.myForm.poQuantity[0].focus();
		}
	}
	else
	{
		entrdQty =  parseInt(document.myForm.poQuantity.value);
	}

	if(entrdQty > qty)
	{
		alert("Quantity should not be greater than desired quantity");
		if(len>1)
			document.myForm.poQuantity[0].focus();
		else
			document.myForm.poQuantity.focus();
		return;
	}
	*/
	
	
	document.getElementById("ButtonsDiv").style.visibility="hidden"
	document.getElementById("msgDiv").style.visibility="visible"
		
	document.myForm.action="ezCreateContract.jsp";
	document.myForm.submit();
}
function funShowVndrDetails(syskey,soldto)
{
	var retValue = window.showModalDialog("ezVendorContactDetails.jsp?SysKey="+syskey+"&SoldTo="+soldto,window.self,"center=yes;dialogHeight=20;dialogWidth=30;help=no;titlebar=no;status=no;minimize:yes")	
}
</Script>
</head>
<body onLoad="scrollInit()" onResize="scrollInit()" scroll=no>
<form name="myForm" method="POST">

<%
	String display_header = "Contract Creation Details";
%>
	<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<%
	String vendor="",quantity="";
	String wide 	="95%";
	String thwide 	="20%";
	
	if(qcfCount==1)
	{
		wide  = "65%";
		thwide= "50%";
	}				
%>	

<DIV id="theads" >
<TABLE id="tabHead" width="90%" align=center  border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
</Table>
</Div>

<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:90%;height:65%;top:20%;left:5%">
<TABLE  id="InnerBox1Tab" width="100%" align=center  border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>


	<Tr>
	<Th align="left" width="<%=thwide%>" >Vendor</Th>
<%
	
	for(int i=0;i<qcfCount;i++)
	{
		vendor	 = myRet.getFieldValueString(i,"VENDOR");
%>	
		<Td width=<%=80/qcfCount%>%><a href = "javascript:funShowVndrDetails('<%=(String)session.getValue("SYSKEY")%>','<%=vendor%>')"><%=vendor%>&nbsp;</a><%="["+venodorsHT.get(vendor.trim())+"]"%></Td>			
		<input type="hidden" name="vendor" value='<%=vendor%>'>
		<input type="hidden" name="material" value='<%=myRet.getFieldValueString(i,"MATERIAL")%>'>
		<input type="hidden" name="price" value='<%=myRet.getFieldValueString(i,"PRICE")%>'>
		<input type="hidden" name="rfqno" value='<%=myRet.getFieldValueString(i,"RFQ_NO")%>'>
	
<%	}
%>	
	</Tr>
	<Tr>
	<Th align="left" width="<%=thwide%>"> Quantity</Th>
<%	
	for(int i=0;i<qcfCount;i++)
	{
		quantity = myRet.getFieldValueString(i,"QUANTITY");	
%>		<Td width=<%=80/qcfCount%>%><input type="text" name="poQuantity" class="tx" size=15  maxlength="7" value="<%=quantity%>" readonly></Td>
<%	}
%>	
	</Tr>
	<Tr>
	<Th width="<%=thwide%>" align="left">Document Type*</Th>
<%	
	for(int j=0;j<qcfCount;j++)
	{			
%>	 	<Td width=<%=80/qcfCount%>%>
		<select name="docType" style="width:100%" id="CalendarDiv" onChange="showTrgtValue('<%=j%>')">
			<option value="">-Select Document Type-</option>
			<Option value='WK'>WK - ValueContract</Option>
			<Option value='MK'>MK - QuantityContract</Option>
		</select>
		</Td>
<%	}
%>		
    	</Tr>
    	<Tr>
    	<Th width="<%=thwide%>" align="left">Target Value/Quantity</Th>
<%	
	for(int j=0;j<qcfCount;j++)
	{	
		double trgtVal = 0;
			trgtVal = (Double.parseDouble(myRet.getFieldValueString(j,"QUANTITY"))*Double.parseDouble(myRet.getFieldValueString(j,"PRICE")));			
		
%>	 	<Td width=<%=80/qcfCount%>%>
			<input type="text" name="targetValue" class="tx" size=15   value="0.0" readonly> 
			<input type="hidden" name="tValue"  value="<%=trgtVal%>">
		</Td>
<%	}
%>
    	</Tr>
    	<Tr>
     	<Th align="left" width="<%=thwide%>" >Contract Start Date*</Th>
<%	
	for(int k=0;k<qcfCount;k++)
	{
		String add ="550";
		if(qcfCount>1)
		{
			if(k==0)
				add = "320";
			if(k==1)
				add = "500";
			if(k==2)
				add = "600";	
		}
%>	 	
		<Td width=<%=80/qcfCount%>%><input type="text" name="contractStartDate<%=k%>" class="InputBox" size=15 value="<%=format.getStringFromDate(today,".",ezc.ezutil.FormatDate.DDMMYYYY)%>" readonly> <img src="../../Images/calender.gif" style="cursor:hand" height="20" onClick=showCal("document.myForm.contractStartDate<%=k%>",205,<%=add%>,"<%=cDate%>","<%=cMonth%>","<%=cYear%>") ></Td>
<%	}
%>
    	</Tr>
    	<Tr>
	<Th width="<%=thwide%>" align="left">Contract End Date*</Th>
<%
	for(int k=0;k<qcfCount;k++)
	{
		String add ="550";
		if(qcfCount>1)
		{
			if(k==0)
				add = "320";
			if(k==1)
				add = "500";
			if(k==2)
				add = "600";	
		}
%>	
	<Td width=<%=80/qcfCount%>%><input type="text" name="contractEndDate<%=k%>" class="InputBox" size=15 value="" readonly> <img src="../../Images/calender.gif" style="cursor:hand" height="20" onClick=showCal("document.myForm.contractEndDate<%=k%>",205,<%=add%>,"<%=cDate%>","<%=cMonth%>","<%=cYear%>") ></Td>
<%	}
%>
  	</Tr>
<%--
	<Tr>
	<Th width="<%=thwide%>" align="left">Valuation Type</Th>
<%
	for(int k=0;k<qcfCount;k++)
	{
%>		<Td width=<%=80/qcfCount%>%>
		<select name="valuationType" style="width:100%" id="CalendarDiv">
		<option value="">-Select Valuation Type-</option>
<%		for(int i=0;i<valuationTypes.length;i++)
		{
%>			<option value="<%=valuationTypes[i]%>"><%=valuationTypes[i]%></option>
<%		}
%>		</select>
		</Td>
<%	}
%>
	</Tr>	
--%>	
	<Tr>
	<Th width="<%=thwide%>" align="left">Header text</Th>
<%
	for(int k=0;k<qcfCount;k++)
	{
%>		<Td width=<%=80/qcfCount%>%><textarea style='width:100%' rows=2 name=headerText></textarea></Td>
<%	}
%>	</Tr>


	<Tr>
		<Th align="left" width="<%=thwide%>" >Shipping Instructions</Th>
<%	
		for(int ncmnShpInstr=0;ncmnShpInstr<qcfCount;ncmnShpInstr++)
		{			
%>	
			<Td width=<%=80/qcfCount%>%><textarea style='width:100%' name="shipInstr"></textarea></Td>
<%
		}
%>	
	</Tr>		



	<Tr>
	<Th width="<%=thwide%>" align="left">Item Text</Th>
<%
	for(int k=0;k<qcfCount;k++)
	{
%>		<Td width=<%=80/qcfCount%>%><textarea style='width:100%' rows=2 name=itemText></textarea></Td>
<%	}		
%>	</Tr>

    </Table>
    </Div>
  
    <input type="hidden" name="collectiveRFQNo" value="<%=collNo%>">
   
<center>
<Div  id='ButtonsDiv' align="center" style="position:absolute;left:0%;width:100%;top:90%">
<table border="0" cellspacing="0" cellpadding="0" align = center>
<tr>
	<td class="TDCommandBarBorder">
	<table border="0" cellspacing="3" cellpadding="5">
	    <tr>
		       <td nowrap class="TDCmdBtnOff" onMouseDown="changeClass(this,'TDCmdBtnDown')" onMouseUp="changeClass(this,'TDCmdBtnUp')" onMouseOver="changeClass(this,'TDCmdBtnUp')" onMouseOut="changeClass(this,'TDCmdBtnOff')" onClick="javascript:history.go(-1)" >
			     <b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>
			</td>
			<td nowrap class="TDCmdBtnOff" onMouseDown="changeClass(this,'TDCmdBtnDown')" onMouseUp="changeClass(this,'TDCmdBtnUp')" onMouseOver="changeClass(this,'TDCmdBtnUp')" onMouseOut="changeClass(this,'TDCmdBtnOff')" onClick="javascript:createContract()">
			      <b>&nbsp;&nbsp;Create Contract&nbsp;&nbsp;</b>
			</td>
	    </tr>
	</table>			
 </Tr>
 </Td>
 </Table>
 </Div>
 <Div id="msgDiv" align="center" style="position:absolute;left:0%;width:100%;top:90%;visibility:hidden">
  	<Table>
 		<Tr>
 			<Th  align="center">Your request is being processed. Please wait ...............</th>
 		</Tr>
 	</Table>
</Div>
</center>
 
</form>

<Div id="MenuSol"></Div>
</body>
</html>

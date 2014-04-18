<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<html>
<head>
<title>Enter PO Creation Details -- Powered By EzCommerce India</title>
<head>
<%@ page import = "java.util.*"%>
<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%@ include file="../../../Includes/Jsps/Misc/iShowCal.jsp"%>
<%@ include file="../../../Includes/Jsps/Rfq/iSelectIds.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%//@include file="../../../Includes/JSPs/Rfq/iListRFQByCollectiveRFQ.jsp"%>
<%@include file="../../../Includes/JSPs/Rfq/iListRFQByColRFQs.jsp"%>
<%@ include file="../../../Includes/Jsps/Misc/iGetVendorDesc.jsp"%>

<%	
	ezc.ezutil.FormatDate fD=new ezc.ezutil.FormatDate();
	ResourceBundle TaxC = ResourceBundle.getBundle("EzTaxCodes");
	java.util.TreeMap taxTM = new java.util.TreeMap();
	Enumeration taxEnu =TaxC.getKeys();
	while(taxEnu.hasMoreElements())
	{
		String s2=(String)taxEnu.nextElement();
		taxTM.put(s2,TaxC.getString(s2));
	}
	Iterator taxIterator = null;//taxTM.keySet().iterator();
  	Object taxObj = new Object();
	
	
	//The following is for getting total of common and non common vendors count. The count is being used in script validation
	int totDispVenCnt = 0;
	for(int colRfqs=0;colRfqs<collRfqNo.length;colRfqs++)
	{
		for(int h=collRfqRet[colRfqs].getRowCount()-1;h>=0;h--)
		{

			if(!("R".equals(collRfqRet[colRfqs].getFieldValueString(h,"RELEASE_INDICATOR").trim())) || commonVendors.contains(collRfqRet[colRfqs].getFieldValueString(h,"VENDOR")+"#"+collRfqRet[colRfqs].getFieldValueString(h,"PLANT")))
				collRfqRet[colRfqs].deleteRow(h);

		}
		totDispVenCnt += collRfqRet[colRfqs].getRowCount();
	}	
	totDispVenCnt = totDispVenCnt+commonVendors.size();
	
	
%>
<Script src="../../Library/JavaScript/checkFormFields.js"></Script>
<Script>
function showLabel(indx)
{
	var len = '<%=totDispVenCnt%>';
	if(len>1)
	{
		var condVal = document.myForm.docType[indx].value;
		if(condVal=='ZCPI' || condVal=='ZFGI' || condVal=='ZRFI' || condVal=='ZRMI')
		{
			document.myForm.ccKey[indx].disabled=false;
			document.myForm.hbId[indx].disabled=false;
			
			document.myForm.ccKey[indx].selectedIndex=2;
		}
		else
		{
			document.myForm.ccKey[indx].selectedIndex=0;
			document.myForm.hbId[indx].selectedIndex=0;
			
			document.myForm.ccKey[indx].disabled=true;
			document.myForm.hbId[indx].disabled=true;
		}
	}
	else
	{
		var condVal = document.myForm.docType.value;
		if(condVal=='ZCPI' || condVal=='ZFGI' || condVal=='ZRFI' || condVal=='ZRMI')
		{
			document.myForm.ccKey.disabled=false;
			document.myForm.hbId.disabled=false;
			
			document.myForm.ccKey.selectedIndex=2;
			
		}
		else
		{
			document.myForm.ccKey.selectedIndex=0;
			document.myForm.hbId.selectedIndex=0;
			
			document.myForm.ccKey.disabled=true;
			document.myForm.hbId.disabled=true;
		}
	}
}

function showPSpan(nm)
{
	obj=document.getElementById(nm);
	if (obj!=null)
	{
		if(obj.style.display=="none")
		{
			obj.style.display="";
		}
		/*else if(obj.style.display=="")
		{
			obj.style.display="none";
		}*/
	}


}



function checkFields1()
{

	var len 	= '<%=totDispVenCnt%>';
	
	if(len>1)
	{
		for(var i=0;i<len;i++)
		{
			if(document.myForm.docType[i].selectedIndex==0)
			{
				alert("Please Select Document Type For Vendor ");
				document.myForm.docType[i].focus()
				return false;
			}
			if(!(document.myForm.ccKey[i].disabled) && document.myForm.ccKey[i].selectedIndex==0)
			{
				alert("Please Select Confirmation Control  Key  For Vendor ");
				document.myForm.ccKey[i].focus()
				return false;
			}
			if(!(document.myForm.hbId[i].disabled) && document.myForm.hbId[i].selectedIndex==0)
			{
				alert("Please Select House Bank Id For Vendor ");
				document.myForm.hbId[i].focus()
				return false;
			}
		}
	}
	else
	{
		if(document.myForm.docType.selectedIndex==0)
		{
			alert("Please Select Document Type");
			document.myForm.docType.focus()
			return false;
		}
		if(!(document.myForm.ccKey.disabled) && document.myForm.ccKey.selectedIndex==0)
		{
			alert("Please Select Confirmation Control  Key");
			document.myForm.ccKey.focus()
			return false;
		}
		if(!(document.myForm.hbId.disabled) && document.myForm.hbId.selectedIndex==0)
		{
			alert("Please Select House Bank Id");
			document.myForm.hbId.focus()
			return false;
		}

	}
	
	
	return true;
}



function funSubmit()
{
	if(checkFields1())
	{
		var len = '<%=totDispVenCnt%>';
		if(len>1)
		{
			for(var  indx=0;indx<len;indx++)
			{
				if(document.myForm.ccKey[indx].disabled==true)
					document.myForm.ccKey[indx].disabled=false;
				if(document.myForm.hbId[indx].disabled==true)
					document.myForm.hbId[indx].disabled=false;
			}
		}
		else
		{
			if(document.myForm.ccKey.disabled==true)
				document.myForm.ccKey.disabled=false;
			if(document.myForm.hbId.disabled==true)
				document.myForm.hbId.disabled=false;
		}
		
		buttonsSpan	  = document.getElementById("EzButtonsSpan")
		buttonsMsgSpan	  = document.getElementById("EzButtonsMsgSpan")
		if(buttonsSpan!=null)
		{
		     buttonsSpan.style.display		= "none"
		     buttonsMsgSpan.style.display	= "block"
		}
		
	
		document.myForm.action="ezCreatePurchaseOrder.jsp";
		document.myForm.submit();
	}
}







function funShowVndrDetails(syskey,soldto)
{
	var retValue = window.showModalDialog("ezVendorContactDetails.jsp?SysKey="+syskey+"&SoldTo="+soldto,window.self,"center=yes;dialogHeight=20;dialogWidth=30;help=no;titlebar=no;status=no;minimize:yes")	
}
</Script>
</head>
<body>
<form name="myForm" method="POST">
<%
	String display_header = "Purchase Order Creation Details";
%>
	<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<%
	int k=0;
	int docT = 0;
%>
<Div   align="center" style="position:absolute;overflow:auto;left:0%;width:100%;height:75%;top:10%">
<%
	//The follwing for loop executes for displaying non common vendors details.
	
	for(int y=0;y<collRfqNo.length;y++)
	{
		// The following for loop is for deleting vendors who has not the indicator R-->Released or in Common Vendor Set. Here we see in Cmn Vndr Set for not displaying common vendor here.
		
		for(int h=collRfqRet[y].getRowCount()-1;h>=0;h--)
		{

			if(!("R".equals(collRfqRet[y].getFieldValueString(h,"RELEASE_INDICATOR").trim())) || commonVendors.contains(collRfqRet[y].getFieldValueString(h,"VENDOR")+"#"+collRfqRet[y].getFieldValueString(h,"PLANT")))
				collRfqRet[y].deleteRow(h);
		
		}
		
		String vendor="",quantity="";
		int qcfCount = collRfqRet[y].getRowCount();

		String wide 	="95%";
		String thwide 	="20%";
		if(qcfCount==1)
		{
			wide  = "65%";
			thwide= "50%";
		}				
%>
<%
	if(qcfCount!=0)
	{
%>				

		<Table align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 width=98%>
		<Tr>
			<Td>
			<span STYLE="background-color:navy">
				<Table align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 width=100%>
				<Tr>
					<Th width="100%" align="left" onClick="JavaScript:showPSpan('<%=collRfqNo[y]%>')" style='cursor:hand'>Collective Rfq No.: <%=collRfqNo[y]%></Th>
				</Tr>
				</Table>
			</span>
			<span id="<%=collRfqNo[y]%>" STYLE="background-color:navy">
		    <Table width='<%=wide%>' align="center" border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>    	
			<Tr>
				<Th align="left" width="<%=thwide%>" >Vendor</Th>
<%
				for(int ncmnVndr=0;ncmnVndr<qcfCount;ncmnVndr++)
				{
					vendor	 = collRfqRet[y].getFieldValueString(ncmnVndr,"VENDOR");
%>	
					<Td width=<%=80/qcfCount%>%><a href = "javascript:funShowVndrDetails('<%=(String)session.getValue("SYSKEY")%>','<%=vendor%>')"><%=vendor%>&nbsp;</a><%="["+venodorsHT.get(vendor.trim())+"]"%></Td>			
					<input type="hidden" name="vendor" value='<%=vendor%>'>
					<input type="hidden" name="rfqNumbers" value="<%=collRfqRet[y].getFieldValueString(ncmnVndr,"RFQ_NO")%>">
<%	
				}
%>	
			</Tr>
			<Tr>
				<Th align="left" width="<%=thwide%>" >RFQ Number</Th>
<%
				for(int ncmnRfqNums=0;ncmnRfqNums<qcfCount;ncmnRfqNums++)
				{
					String rfqNo	 = collRfqRet[y].getFieldValueString(ncmnRfqNums,"RFQ_NO");
%>	
					<Td width=<%=80/qcfCount%>%><%=rfqNo%></Td>			
<%	
				}
%>	
			</Tr>			
			

			<Tr>
				<Th align="left" width="<%=thwide%>"> Quantity</Th>
<%	
				for(int ncmnQty=0;ncmnQty<qcfCount;ncmnQty++)
				{
					quantity = collRfqRet[y].getFieldValueString(ncmnQty,"QUANTITY");	
%>					<!--<Td width=<%=80/qcfCount%>%><input type="text" name="poQuantity" class="InputBox" size=15  maxlength="7" value="<%=quantity%>" readonly></Td>-->
					<Td width=<%=80/qcfCount%>%><%=quantity%></Td>
<%	
				}
%>	
			</Tr>
			<Tr>
				<Th align="left" width="<%=thwide%>"> Delivery Date</Th>
<%	
				for(int ncmnDelDate=0;ncmnDelDate<qcfCount;ncmnDelDate++)
				{
%>					<!--<Td width=<%=80/qcfCount%>%><input type="text" name="poQuantity" class="InputBox" size=15  maxlength="7" value="<%=quantity%>" readonly></Td>-->
					<Td width=<%=80/qcfCount%>%><%=fD.getStringFromDate((java.util.Date)collRfqRet[y].getFieldValue(ncmnDelDate,"DELIV_DATE"),".",fD.DDMMYYYY)%></Td>
<%	
				}
%>	
			</Tr>	
			<Tr>
				<Th align="left" width="<%=thwide%>"> Plant</Th>
<%	
				for(int ncmnPlant=0;ncmnPlant<qcfCount;ncmnPlant++)
				{
%>					<!--<Td width=<%=80/qcfCount%>%><input type="text" name="poQuantity" class="InputBox" size=15  maxlength="7" value="<%=quantity%>" readonly></Td>-->
					<Td width=<%=80/qcfCount%>%><%=collRfqRet[y].getFieldValueString(ncmnPlant,"PLANT")%></Td>
<%	
				}
%>	
			</Tr>	

			
    			<Tr>
    				<Th align="left" width="<%=thwide%>"> Document Type*</Th>
<%	
				for(int ncmnDocType=0;ncmnDocType<qcfCount;ncmnDocType++)
				{		
%>	 				<Td width=<%=80/qcfCount%>%>
						<div id="listBoxDiv1">
						<select name="docType" style="width:100%" onChange="javascript:showLabel('<%=docT%>')">
							<option value="">-Select Document Type-</option>
<%
							for(int inDocType=0;inDocType<PoTypes.length;inDocType++)
							{
%>
								<option value="<%=PoTypes[inDocType][0]%>"><%=PoTypes[inDocType][1]%></option>
<%
							}
%>
						</select>
					</Td>
					</DIv>
<%
					docT++;
				}
%>	
			    	</Tr>
				<Tr>
				<Th align="left" width="<%=thwide%>"> Valuation Type*</Th>
<%	
				String valType = "";
				for(int ncmnValType=0;ncmnValType<qcfCount;ncmnValType++)
				{
					valType = collRfqRet[y].getFieldValueString(ncmnValType,"VAL_TYPE");
					if(valType==null || "null".equals(valType) || "".equals(valType))
						valType = "DOM.FOR RM";
					
%>	    				<Td width=<%=80/qcfCount%>%>
					<div id="listBoxDiv2">
					<select name="valuationType" style="width:100%">
					
					<option value="">-Select Valuation Type-</option>
<%				
					for(int inValType=0;inValType<valuationTypes.length;inValType++)			
					{
						if(valType.equals(valuationTypes[inValType].trim()))
						{
%>							<option value="<%=valuationTypes[inValType]%>" selected><%=valuationTypes[inValType]%></option>			
<%						}
						else
						{
%>							<option value="<%=valuationTypes[inValType]%>"><%=valuationTypes[inValType]%></option>			
<%						}
					}			
%>
					</select>
					</Div>
					</Td>
<%				}
%>	
				</Tr>
				<Tr>
				<Th align="left" width="<%=thwide%>" >Tax Code*</Th>
<%	
				String taxCode = "";
				for(int ncmnCode=0;ncmnCode<qcfCount;ncmnCode++)
				{	
					 taxIterator = taxTM.keySet().iterator();
  					 taxObj = new Object();
					taxCode = collRfqRet[y].getFieldValueString(ncmnCode,"TAX_CODE");
					if(taxCode==null || "null".equals(taxCode) || "".equals(taxCode))
						taxCode = "AA";
					
%>					
				<Td width=<%=80/qcfCount%>%>
				<div id="listBoxDiv3">
				<select name="taxCode"  style="width:100%">
					<option value="">Select Tax Code</option>

<%	
					while(taxIterator.hasNext())
					{
						taxObj = taxIterator.next();
						String taxStr = taxObj.toString();
						if(taxCode.equals(taxStr))
						{
%>	
							<Option value="<%=taxStr%>" selected><%=taxStr%>--><%=taxTM.get(taxStr)%></Option>
<%
						}
						else
						{
%>	
							<Option value="<%=taxStr%>" ><%=taxStr%>--><%=taxTM.get(taxStr)%></Option>
<%						}
					}
%>		
				</select>
				</div>				
				</Td>
<%				}
%>				</Tr>	
				<Tr>
					<Th align="left" width="<%=thwide%>"  style="visibility:visible">Confirmation Control Key*</Th>
<%	
					for(int ncmnConCKey=0;ncmnConCKey<qcfCount;ncmnConCKey++)
					{
%>						<Td width=<%=80/qcfCount%>%>
						<div id="listBoxDiv4">
							<select name="ccKey" style="width:100%" id="CalendarDiv">
								<option value="" >-Select Confirmation Control- </option>				
<%								for(int inConCKey=0;inConCKey<confctrlKeys.length;inConCKey++)
								{
%>										<option value="<%=confctrlKeys[inConCKey][0]%>"><%=confctrlKeys[inConCKey][1]%></option>
<%								}
%>							</select>
						</Div>
						</Td>
<%					}
%>	
    				</Tr>
    				<Tr>
    					<Th align="left" width="<%=thwide%>"  style="visibility:visible">House Bank ID*</Th>
<%	
					for(int ncmnHsbId=0;ncmnHsbId<qcfCount;ncmnHsbId++)
					{			
%>	 					<Td width=<%=80/qcfCount%>%>
							<select name="hbId" style="width:100%" id="CalendarDiv"> 
								<option value="" selected>-Select House Bank ID-</option>
<%
								for(int inHsbId=0;inHsbId<houseBankIds.length;inHsbId++)
								{
%>	
									<option value="<%=houseBankIds[inHsbId][0]%>"><%=houseBankIds[inHsbId][1]%></option>
<%
								}
%>	
							</select>
						</Td>
<%	
					}
%>	
			    	</Tr>
				<Tr>
					<Th align="left" width="<%=thwide%>" >Header Text</Th>
<%	
					for(int ncmnHdrTxt=0;ncmnHdrTxt<qcfCount;ncmnHdrTxt++)
					{			
%>	
						<Td width=<%=80/qcfCount%>%><textarea style='width:100%' name="headerText"></textarea></Td>
<%
					}
%>	
				</Tr>
				
				
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
					<Th align="left" width="<%=thwide%>" >Item Text</Th>
<%	
					for(int ncmnItmTxt=0;ncmnItmTxt<qcfCount;ncmnItmTxt++)
					{		
%>	
						<Td width=<%=80/qcfCount%>%>
							<textarea style='width:100%' name="itemText" ></textarea>
						</Td>
<%	
					}
%>	
				</Tr>
   		 </Table>

		</Td>
	</Tr>
</Table>	 

<%
	}
}	

//The follwing is for displaying common vendor details.

if(commonVendors.size()>0)
{
	int cmnVendCnt = commonVendors.size();
	String cmnVendorSpan = "COMMONVENDORS";

		String wide 	="95%";
		String thwide 	="20%";
		if(cmnVendCnt==1)
		{
			wide  = "65%";
			thwide= "50%";
		}				
%>
<%
	if(cmnVendCnt!=0)
	{
%>				
		<Table align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 width=98%>
		<Tr>
			<Td>
			<span STYLE="background-color:navy">
				<Table align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 width=100%>
				<Tr>
					<Th width="100%" align="left" onClick="JavaScript:showPSpan('<%=cmnVendorSpan%>')" style='cursor:hand'>Common Vendors</Th>
				</Tr>
				</Table>
			</span>
			<span id="<%=cmnVendorSpan%>" STYLE="background-color:navy">
		    <Table width='<%=wide%>' align="center" border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>    	
			<Tr>
				<Th align="left" width="<%=thwide%>" >Vendor</Th>
<%
				java.util.Iterator cmnVenitr = commonVendors.iterator();
				while(cmnVenitr.hasNext())
				{
					String cmnVndrs	 = (String)cmnVenitr.next();
					java.util.StringTokenizer cmVendor = new java.util.StringTokenizer(cmnVndrs,"#");
					String vendor = cmVendor.nextToken();
%>	
					<Td width=<%=80/cmnVendCnt%>%><a href = "javascript:funShowVndrDetails('<%=(String)session.getValue("SYSKEY")%>','<%=vendor%>')"><%=vendor%>&nbsp;</a><%="["+venodorsHT.get(vendor.trim())+"]"%></Td>			
					<input type="hidden" name="vendor" value='<%=vendor%>'>
					
<%	
				}
%>	
			</Tr>

			<Tr>
				<Th align="left" width="<%=thwide%>" >Plant</Th>
<%
				java.util.Iterator  cmnVenitrtor = commonVendors.iterator();
				while(cmnVenitrtor.hasNext())
				{
					String venSt	 = (String)cmnVenitrtor.next();
					java.util.StringTokenizer plantVenStr = new java.util.StringTokenizer(venSt,"#");
					String vendor = plantVenStr.nextToken();
					String plant = plantVenStr.nextToken();
%>	
					<Td width=<%=80/cmnVendCnt%>%><%=plant%></Td>			
					
<%	
				}
%>	
			</Tr>
		
			<Tr>
				<Th align="left" width="<%=thwide%>" >RFQ Numbers</Th>
<%
				java.util.Iterator cmnVenitrtr1 = commonVendors.iterator();
				while(cmnVenitrtr1.hasNext())
				{
					String venSt	 = (String)cmnVenitrtr1.next();
					java.util.StringTokenizer strtok = new  java.util.StringTokenizer(venSt,"#");
					String ven = strtok.nextToken();
					String rfqNo	 = "";
					int rfqcnt =0;
					for(int cmnVndrs=0;cmnVndrs<cmnVndrsRetObj.getRowCount();cmnVndrs++)
					{
						if(ven.equals(cmnVndrsRetObj.getFieldValueString(cmnVndrs,"VENDOR")))
						{
							if(rfqcnt==0)
								rfqNo  = cmnVndrsRetObj.getFieldValueString(cmnVndrs,"RFQ_NOs");
							else
								rfqNo = rfqNo+","+cmnVndrsRetObj.getFieldValueString(cmnVndrs,"RFQ_NOs");
							rfqcnt++;	
						}
					}					
%>
					<input type="hidden" name="rfqNumbers" value="<%=rfqNo%>">
					<Td width=<%=80/cmnVendCnt%>%>
						<input type=text size=10 value="<%=rfqNo%>" class="tx" style='width:100%' readonly>
					</Td>			
<%	
				}
%>	
			</Tr>			
			
    			<Tr>
    				<Th align="left" width="<%=thwide%>"> Document Type*</Th>
<%	
				for(int cmnDocType=0;cmnDocType<cmnVendCnt;cmnDocType++)
				{		
%>	 				<Td width=<%=80/cmnVendCnt%>%>
						<div id="listBoxDiv1">
						<select name="docType" style="width:100%" id="CalendarDiv" onChange="javascript:showLabel('<%=docT%>')">
							<option value="">-Select Document Type-</option>
<%
							for(int inDocType=0;inDocType<PoTypes.length;inDocType++)
							{
%>
								<option value="<%=PoTypes[inDocType][0]%>"><%=PoTypes[inDocType][1]%></option>
<%
							}
%>
						</select>
						</Div>
					</Td>
<%
					docT++;
				}
%>	
			    	</Tr>
				<Tr>
				<Th align="left" width="<%=thwide%>"> Valuation Type*</Th>
<%	
				for(int cmnValType=0;cmnValType<cmnVendCnt;cmnValType++)
				{
%>	    				<Td width=<%=80/cmnVendCnt%>%>
					<Div id="listBoxDiv2">
					<select name="valuationType" style="width:100%" id="CalendarDiv">
					<option value="">-Select Valuation Type-</option>
<%				
					for(int inVType=0;inVType<valuationTypes.length;inVType++)			
					{	
%>					
						<option value="<%=valuationTypes[inVType]%>"><%=valuationTypes[inVType]%></option>			
<%					
					}			
%>
					</select>
					</Div>
					</Td>
<%
				}
%>	
				</Tr>
				
	
				<Tr>
				<Th align="left" width="<%=thwide%>" >Tax Code*</Th>
<%	
				for(int cmnTxCode=0;cmnTxCode<cmnVendCnt;cmnTxCode++)
				{
					taxIterator = taxTM.keySet().iterator();
					 taxObj = new Object();
%>				
				<Td width=<%=80/cmnVendCnt%>%>
				<div id="listBoxDiv3">
				<select name="taxCode"  style="width:100%">
					<option value="">Select Tax Code</option>

<%	
					while(taxIterator.hasNext())
					{
						taxObj = taxIterator.next();
						String taxStr = taxObj.toString();
						if("AA".equals(taxStr))
						{
%>	
							<Option value="<%=taxStr%>" selected><%=taxStr%>--><%=taxTM.get(taxStr)%></Option>
<%
						}
						else
						{
%>	
							<Option value="<%=taxStr%>" ><%=taxStr%>--><%=taxTM.get(taxStr)%></Option>
<%						}
					}
%>		
				</select>
				</div>				
				</Td>
<%
				}
%>				
				</Tr>	
				<Tr>
					<Th align="left" width="<%=thwide%>"  style="visibility:visible">Confirmation Control Key*</Th>
<%	
					for(int cmnConfCKey=0;cmnConfCKey<cmnVendCnt;cmnConfCKey++)
					{
%>		
						<Td width=<%=80/cmnVendCnt%>%>
							<div id="listBoxDiv4">	
							<select name="ccKey" style="width:100%" id="CalendarDiv">
								<option value="" >-Select Confirmation Control- </option>				
<%
									for(int inConfCKey=0;inConfCKey<confctrlKeys.length;inConfCKey++)
									{
%>
										<option value="<%=confctrlKeys[inConfCKey][0]%>"><%=confctrlKeys[inConfCKey][1]%></option>
<%									}

%>							</select>
							</Div>
						</Td>
<%
					}

%>	
    				</Tr>
    				<Tr>
    					<Th align="left" width="<%=thwide%>"  style="visibility:visible">House Bank ID*</Th>
<%	
					for(int cmnHsbId=0;cmnHsbId<cmnVendCnt;cmnHsbId++)
					{			
%>	 					<Td width=<%=80/cmnVendCnt%>%>
							<select name="hbId" style="width:100%" id="CalendarDiv"> 
								<option value="" selected>-Select House Bank ID-</option>
<%
								for(int inHsbId=0;inHsbId<houseBankIds.length;inHsbId++)
								{
%>	
									<option value="<%=houseBankIds[inHsbId][0]%>"><%=houseBankIds[inHsbId][1]%></option>
<%
								}
%>	
							</select>
						</Td>
<%	
					}
%>	
			    	</Tr>
				<Tr>
					<Th align="left" width="<%=thwide%>" >Header Text</Th>
<%	
					for(int cmnHdrTxt=0;cmnHdrTxt<cmnVendCnt;cmnHdrTxt++)
					{			
%>	
						<Td width=<%=80/cmnVendCnt%>%><textarea style='width:100%' name="headerText"></textarea></Td>
<%
					}
%>	
				</Tr>
				
				<Tr>
					<Th align="left" width="<%=thwide%>" >Shipping Instructions</Th>
<%	
					for(int cmnShpInstr=0;cmnShpInstr<cmnVendCnt;cmnShpInstr++)
					{		
%>	
						<Td width=<%=80/cmnVendCnt%>%>
							<textarea style='width:100%' name="shipInstr" ></textarea>
						</Td>
<%	
					}
%>	
				</Tr>				
				
				
				
				<Tr>
					<Th align="left" width="<%=thwide%>" >Item Text</Th>
<%	
					for(int cmnItmTxt=0;cmnItmTxt<cmnVendCnt;cmnItmTxt++)
					{		
%>	
						<Td width=<%=80/cmnVendCnt%>%>
							<textarea style='width:100%' name="itemText" ></textarea>
						</Td>
<%	
					}
%>	
				</Tr>
   		 </Table>
   		
		</Td>
	</Tr>
</Table>	 

<%
	}
}	


%>	
</Div>
<input type="hidden" name="collectiveRFQNo" value="<%=colNums.substring(0,colNums.length())%>">
<Div   align="center" style="position:absolute;left:0%;width:100%;top:90%">
<table border="0" cellspacing="0" cellpadding="0" align = center>
<tr>
	<td class="TDCommandBarBorder">
	<span id="EzButtonsSpan" >
	<table border="0" cellspacing="3" cellpadding="5">
	    <tr>
	       <td nowrap class="TDCmdBtnOff" onMouseDown="changeClass(this,'TDCmdBtnDown')" onMouseUp="changeClass(this,'TDCmdBtnUp')" onMouseOver="changeClass(this,'TDCmdBtnUp')" onMouseOut="changeClass(this,'TDCmdBtnOff')" onClick="javascript:history.go(-1)" >
		     <b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>
		</td>
		<td nowrap class="TDCmdBtnOff" onMouseDown="changeClass(this,'TDCmdBtnDown')" onMouseUp="changeClass(this,'TDCmdBtnUp')" onMouseOver="changeClass(this,'TDCmdBtnUp')" onMouseOut="changeClass(this,'TDCmdBtnOff')" onClick="javascript:funSubmit()">
		      <b>&nbsp;&nbsp;Create PO&nbsp;&nbsp;</b>
		</td>
	    </tr>
	</table>		
	</span>
	<span id="EzButtonsMsgSpan" style="display:none">
	<Table align=center>
		<Tr>
			<Td class="labelcell">Your request is being processed... Please wait</Td>
		</Tr>
	</Table>
	</span>
	</Td>
</Tr>
</Table>		
</Div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>

<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<html>
<head>
<title>Enter PO Creation Details -- Powered By EzCommerce India</title>
<head>
<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%@ include file="../../../Includes/Jsps/Misc/iShowCal.jsp"%>
<%@ include file="../../../Includes/Jsps/Rfq/iSelectIds.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%//@include file="../../../Includes/JSPs/Rfq/iListRFQByCollectiveRFQ.jsp"%>
<%@include file="../../../Includes/JSPs/Rfq/iListRFQByColRFQs.jsp"%>
<%	
	/*for(int i=myRet.getRowCount()-1;i>=0;i--)
	{
	
		if(!("R".equals(myRet.getFieldValueString(i,"RELEASE_INDICATOR").trim())))
			myRet.deleteRow(i);

	}
	int cnt = myRet.getRowCount();
	*/
%>
<Script src="../../Library/JavaScript/checkFormFields.js"></Script>
<Script>
function showLabel(indx)
{
	var len = document.myForm.docType.length;
	
	if(document.myForm.docType.value=="")
	{
		var condVal = document.myForm.docType.value;
		if(condVal=='ZCPI' || condVal=='ZFGI' || condVal=='ZRFI' || condVal=='ZRMI')
		{
			document.myForm.ccKey.disabled=false;
			document.myForm.hbId.disabled=false;
		}
		else
		{
			document.myForm.ccKey.disabled=true;
			document.myForm.hbId.disabled=true;
		}
	}
	else
	if(len>1)
	{
		var condVal = document.myForm.docType[indx].value;
		if(condVal=='ZCPI' || condVal=='ZFGI' || condVal=='ZRFI' || condVal=='ZRMI')
		{
			document.myForm.ccKey[indx].disabled=false;
			document.myForm.hbId[indx].disabled=false;
		}
		else
		{
			document.myForm.ccKey[indx].disabled=true;
			document.myForm.hbId[indx].disabled=true;
		}
	}

}

function showPSpan(nm)
{
<%
	for(int v=0;v<collNo1.length;v++)
	{	
%>
		if(nm == '<%=collNo1[v]%>')
		{
			obj=document.getElementById(nm);
			if (obj!=null)
			{
				if(obj.style.display=="none")
				{
					obj.style.display="";
				}
				else if(obj.style.display=="")
				{
					obj.style.display="none";
				}
			}
		}
		else
		{
			obj=document.getElementById('<%=collNo1[v]%>');
			if (obj!=null)
			{
				if(obj.style.display=="")
				{
					obj.style.display="none";
				}
			}
		
		}
<%		
	}	
%>	

	if(nm == 'COMMONVENDORS')
	{
		obj=document.getElementById(nm);
		if (obj!=null)
		{
			if(obj.style.display=="none")
			{
				obj.style.display="";
			}
			else if(obj.style.display=="")
			{
				obj.style.display="none";
			}
		}
	}
	else
	{
		obj=document.getElementById('COMMONVENDORS');
		if (obj!=null)
		{
			if(obj.style.display=="")
			{
				obj.style.display="none";
			}
		}

	}

}
function funShowVndrDetails(syskey,soldto)
{
	var retValue = window.showModalDialog("ezVendorContactDetails.jsp?SysKey="+syskey+"&SoldTo="+soldto,window.self,"center=yes;dialogHeight=20;dialogWidth=30;help=no;titlebar=no;status=no;minimize:yes")	
}
function closeWin()
{
	alert(document.myForm.headerText.length);
	if(!(document.myForm.ccKey.disabled) && document.myForm.ccKey.selectedIndex==0)
	{
		alert("Please Select Confirmation Control  Key");
		document.myForm.ccKey.focus()
		return;
	}
	if(!(document.myForm.hbId.disabled) && document.myForm.hbId.selectedIndex==0)
	{
		alert("Please Select House Bank Id");
		document.myForm.hbId.focus()
		return;
	}
	document.myForm.action="ezPOCrt.jsp";
	document.myForm.submit();
}

</Script>
</head>
<body>
<form name="myForm">
<%
	String display_header = "Purchase Order Creation Details";
%>
	<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<%
	int k=0;
	int docT = 0;
%>
<Br><Br>	
<%
	
	for(int y=0;y<collNo1.length;y++)
	{
		for(int h=myRet1[y].getRowCount()-1;h>=0;h--)
		{

			if(!("R".equals(myRet1[y].getFieldValueString(h,"RELEASE_INDICATOR").trim())) || commonVendors.contains(myRet1[y].getFieldValueString(h,"VENDOR")+"#"+myRet1[y].getFieldValueString(h,"PLANT")))
				myRet1[y].deleteRow(h);
		
		}
		
		String vendor="",quantity="";
		int qcfCount = myRet1[y].getRowCount();
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

		<Table align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 width=80%>
		<Tr>
			<Td>
			<span STYLE="background-color:navy">
				<Table align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 width=100%>
				<Tr>
					<Th width="100%" align="left" onClick="JavaScript:showPSpan('<%=collNo1[y]%>')" style='cursor:hand'><%=collNo1[y]%></Th>
				</Tr>
				</Table>
			</span>
			<span id="<%=collNo1[y]%>" STYLE="background-color:navy">
		    <Table width='<%=wide%>' align="center" border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>    	
			<Tr>
				<Th align="left" width="<%=thwide%>" >Vendor</Th>
<%
				for(int i=0;i<qcfCount;i++)
				{
					vendor	 = myRet1[y].getFieldValueString(i,"VENDOR");
%>	
					<Td width=<%=80/qcfCount%>%><a href = "javascript:funShowVndrDetails('<%=(String)session.getValue("SYSKEY")%>','<%=vendor%>')"><%=vendor%>&nbsp;</a></Td>			
					<input type="hidden" name="vendor" value='<%=vendor%>'>
					<input type="hidden" name="rfqDetails" value="<%=vendor%>##<%=myRet1[y].getFieldValueString(i,"MATERIAL")%>##<%=myRet1[y].getFieldValueString(i,"UOM")%>##<%=myRet1[y].getFieldValueString(i,"PLANT")%>##<%=myRet1[y].getFieldValueString(i,"PRICE")%>##<%=myRet1[y].getFieldValueString(i,"RFQ_NO")%>">
					<!--
					<input type="hidden" name="material" value='<%=myRet1[y].getFieldValueString(i,"MATERIAL")%>'>
					<input type="hidden" name="uom" value='<%=myRet1[y].getFieldValueString(i,"UOM")%>'>	
					<input type="hidden" name="plant" value='<%=myRet1[y].getFieldValueString(i,"PLANT")%>'>
					<input type="hidden" name="price" value='<%=myRet1[y].getFieldValueString(i,"PRICE")%>'>
					<input type="hidden" name="rfqno" value='<%=myRet1[y].getFieldValueString(i,"RFQ_NO")%>'>
					-->
<%	
				}
%>	
			</Tr>
			<Tr>
				<Th align="left" width="<%=thwide%>" >RFQ Number</Th>
<%
				for(int i=0;i<qcfCount;i++)
				{
					String rfqNo	 = myRet1[y].getFieldValueString(i,"RFQ_NO");
%>	
					<Td width=<%=80/qcfCount%>%><%=rfqNo%></Td>			
<%	
				}
%>	
			</Tr>			
			

			<Tr>
				<Th align="left" width="<%=thwide%>"> Quantity*</Th>
<%	
				for(int i=0;i<qcfCount;i++)
				{
					quantity = myRet1[y].getFieldValueString(i,"QUANTITY");	
%>					<!--<Td width=<%=80/qcfCount%>%><input type="text" name="poQuantity" class="InputBox" size=15  maxlength="7" value="<%=quantity%>" readonly></Td>-->
					<Td width=<%=80/qcfCount%>%><%=quantity%></Td>
<%	
				}
%>	
			</Tr>
    			<Tr>
    				<Th align="left" width="<%=thwide%>"> Document Type*</Th>
<%	
				for(int j=0;j<qcfCount;j++)
				{		
%>	 				<Td width=<%=80/qcfCount%>%>
						<select name="docType" style="width:100%" id="CalendarDiv" onChange="javascript:showLabel('<%=docT%>')">
							<option value="">-Select Document Type-</option>
<%
							for(int i=0;i<PoTypes.length;i++)
							{
%>
								<option value="<%=PoTypes[i][0]%>"><%=PoTypes[i][1]%></option>
<%
							}
%>
						</select>
					</Td>
<%
					docT++;
				}
%>	
			    	</Tr>

				<Tr>
					<Th align="left" width="<%=thwide%>"  style="visibility:visible">Confirmation control key*</Th>
<%	
					for(int l=0;l<qcfCount;l++)
					{
%>		
						<Td width=<%=80/qcfCount%>%>
							<select name="ccKey" style="width:100%" id="CalendarDiv">
								<option value="" >-Select Confirmation Control- </option>				
<%
									for(int i=0;i<confctrlKeys.length;i++)
									{
%>
										<option value="<%=confctrlKeys[i][0]%>"><%=confctrlKeys[i][1]%></option>
<%									}

%>							</select>
						</Td>
<%
					}

%>	
    				</Tr>
    				<Tr>
    					<Th align="left" width="<%=thwide%>"  style="visibility:visible">House Bank ID*</Th>
<%	
					for(int m=0;m<qcfCount;m++)
					{			
%>	 					<Td width=<%=80/qcfCount%>%>
							<select name="hbId" style="width:100%" id="CalendarDiv"> 
								<option value="" selected>-Select House Bank ID-</option>
<%
								for(int i=0;i<houseBankIds.length;i++)
								{
%>	
									<option value="<%=houseBankIds[i][0]%>"><%=houseBankIds[i][1]%></option>
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
					<Th align="left" width="<%=thwide%>" >Header text</Th>
<%	
					for(int i=0;i<qcfCount;i++)
					{			
%>	
						<Td width=<%=80/qcfCount%>%><textarea style='width:100%' name="headerText"></textarea></Td>
<%
					}
%>	
				</Tr>
				<Tr>
					<Th align="left" width="<%=thwide%>" >Item Text</Th>
<%	
					for(int i=0;i<qcfCount;i++)
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
   		<script>
			document.getElementById('<%=collNo1[y]%>').style.display="none";
		</script>
		</Td>
	</Tr>
</Table>	 

<%
	}
}	
if(commonVendors.size()>0)
{
	int cmnCnt = commonVendors.size();
	String cmnVendorSpan = "COMMONVENDORS";

		String wide 	="95%";
		String thwide 	="20%";
		if(cmnCnt==1)
		{
			wide  = "65%";
			thwide= "50%";
		}				
%>
<%
	if(cmnCnt!=0)
	{
%>				
		<Table align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 width=80%>
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
				java.util.Iterator itrtr = commonVendors.iterator();
				while(itrtr.hasNext())
				{
					String venSt	 = (String)itrtr.next();
					java.util.StringTokenizer st1 = new java.util.StringTokenizer(venSt,"#");
					String vendor = st1.nextToken();
					//String vendor	 = (String)itrtr.next();
%>	
					<Td width=<%=80/cmnCnt%>%><a href = "javascript:funShowVndrDetails('<%=(String)session.getValue("SYSKEY")%>','<%=vendor%>')"><%=vendor%>&nbsp;</a></Td>			
<%	
				}
%>	
			</Tr>
			<Tr>
				<Th align="left" width="<%=thwide%>" >RFQ Numbers</Th>
<%
				java.util.Iterator itrtr1 = commonVendors.iterator();
				while(itrtr1.hasNext())
				{
					String venSt	 = (String)itrtr1.next();
					java.util.StringTokenizer strtok = new  java.util.StringTokenizer(venSt,"#");
					String ven = strtok.nextToken();
					String rfqNo	 = "";
					for(int h=0;h<myRet3.getRowCount();h++)
					{
						if(ven.equals(myRet3.getFieldValueString(h,"VENDOR")))
						{
							rfqNo = rfqNo+myRet3.getFieldValueString(h,"RFQ_NOs")+",";
%>							
							<input type="hidden" name="rfqDetails" value="<%=myRet3.getFieldValueString(h,"RFQ_DATA")%>">					
<%
						}
					}
					
%>	
					<Td width=<%=80/cmnCnt%>%>
						<input type=text size=10 value="<%=rfqNo.substring(0,rfqNo.length()-1)%>" class="tx" style='width:100%' readonly>
					</Td>			
<%	
				}
%>	
			</Tr>			
			
    			<Tr>
    				<Th align="left" width="<%=thwide%>"> Document Type*</Th>
<%	
				for(int j=0;j<cmnCnt;j++)
				{		
%>	 				<Td width=<%=80/cmnCnt%>%>
						<select name="docType" style="width:100%" id="CalendarDiv" onChange="javascript:showLabel('<%=docT%>')">
							<option value="">-Select Document Type-</option>
<%
							for(int i=0;i<PoTypes.length;i++)
							{
%>
								<option value="<%=PoTypes[i][0]%>"><%=PoTypes[i][1]%></option>
<%
							}
%>
						</select>
					</Td>
<%
					docT++;
				}
%>	
			    	</Tr>

				<Tr>
					<Th align="left" width="<%=thwide%>"  style="visibility:visible">Confirmation control key*</Th>
<%	
					for(int l=0;l<cmnCnt;l++)
					{
%>		
						<Td width=<%=80/cmnCnt%>%>
							<select name="ccKey" style="width:100%" id="CalendarDiv">
								<option value="" >-Select Confirmation Control- </option>				
<%
									for(int i=0;i<confctrlKeys.length;i++)
									{
%>
										<option value="<%=confctrlKeys[i][0]%>"><%=confctrlKeys[i][1]%></option>
<%									}

%>							</select>
						</Td>
<%
					}

%>	
    				</Tr>
    				<Tr>
    					<Th align="left" width="<%=thwide%>"  style="visibility:visible">House Bank ID*</Th>
<%	
					for(int m=0;m<cmnCnt;m++)
					{			
%>	 					<Td width=<%=80/cmnCnt%>%>
							<select name="hbId" style="width:100%" id="CalendarDiv"> 
								<option value="" selected>-Select House Bank ID-</option>
<%
								for(int i=0;i<houseBankIds.length;i++)
								{
%>	
									<option value="<%=houseBankIds[i][0]%>"><%=houseBankIds[i][1]%></option>
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
					<Th align="left" width="<%=thwide%>" >Header text</Th>
<%	
					for(int i=0;i<cmnCnt;i++)
					{			
%>	
						<Td width=<%=80/cmnCnt%>%><textarea style='width:100%' name="headerText"></textarea></Td>
<%
					}
%>	
				</Tr>
				<Tr>
					<Th align="left" width="<%=thwide%>" >Item Text</Th>
<%	
					for(int i=0;i<cmnCnt;i++)
					{		
%>	
						<Td width=<%=80/cmnCnt%>%>
							<textarea style='width:100%' name="itemText" ></textarea>
						</Td>
<%	
					}
%>	
				</Tr>
   		 </Table>
   		<script>
			document.getElementById('<%=cmnVendorSpan%>').style.display="none";
		</script>
		</Td>
	</Tr>
</Table>	 

<%
	}
}	




























%>	
<!--<input type="hidden" name="collectiveRFQNo" value="">-->
<Div   align="center" style="position:absolute;left:0%;width:100%;top:90%">		
<%
	  butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
	  butNames.add("&nbsp;&nbsp;Create PO&nbsp;&nbsp;");   
	  butActions.add("history.go(-1)");
	  butActions.add("closeWin()");
	  out.println(getButtons(butNames,butActions));
%>

</Div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>

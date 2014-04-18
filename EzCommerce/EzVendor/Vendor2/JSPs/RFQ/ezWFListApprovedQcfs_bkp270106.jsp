<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ page import="ezc.ezutil.FormatDate,java.util.Date,javax.xml.parsers.*,org.w3c.dom.*,ezc.ezparam.ReturnObjFromRetrieve" %>
<%@ page import="javax.xml.transform.*,javax.xml.transform.dom.DOMSource,javax.xml.transform.stream.StreamResult" %>
<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<%@include file="../../../Includes/Jsps/Rfq/iWFListQcfs.jsp" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<Script>
	var tabHeadWidth=96
	var tabHeight="65%"
</Script>
<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<Script>

var newWindow

function showComments(qcfNumber,quantity,action,type,stat,isdelpart)
{
	newWindow=window.open("ezQcfComments.jsp?qcfNumber="+qcfNumber+"&quantity="+quantity+"&action="+action+"&type="+type+"&status="+stat+"&isdelegate="+isdelpart,"myWin","width=750,height=550,left=20,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
}

function funUnload()
{
	if(newWindow!=null && newWindow.open)
	{
		 newWindow.close();
	}
}
function openWin(num)
{
	var url="ezQcfSAPView.jsp?qcfNumber="+num;
	var sapWindow=window.open(url,"newwin","width=750,height=550,left=20,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
}	
function showVendors(collRfq,proc)
{
	var url="ezShowVendors.jsp?collRfq="+collRfq+"&process="+proc;
	newWindow=window.open(url,"VendWin","width=550,height=350,left=20,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
}
function ProcessFun(indicator)
{
	var len = document.myForm.chk1.length
	var flag = false;
	var collNo;
	var validityObj;
	var cnt = 0;
	var validityFlag=false;
	if(isNaN(len))
	{
		if(document.myForm.chk1.checked)
		{
			collNo = document.myForm.chk1.value;
			validityObj=document.myForm.validityFlag;
			cnt++;
			flag = true;
			if(validityObj!=null && validityObj.value=="Y")
				validityFlag=true;	
			
		}	
	}
	else
	{
		for(var a=0;a<len;a++)
		{
			if(document.myForm.chk1[a].checked)
			{
				collNo = document.myForm.chk1[a].value;	
				validityObj=document.myForm.validityFlag[a];
				cnt++;
				flag = true;
				if(validityObj!=null && validityObj.value=="Y")
					validityFlag=true;
			}	
		}
	}
	
	if(validityFlag){
		if("PO"==indicator){
			alert("Purchase Order creation restricted against expired RFQ(s)");
			return;
		}else{
			alert("Contract creation restricted against expired RFQ(s)");
			return;
		}
	}
	if(flag)
	{
		if("PO"==indicator)
		{
			var colRFQNo  = "";
			var PoOrCon = "";
<%			
			if(myRetCount>0)
			{
				for(int r=0;r<myRetCount;r++)
				{
%>
					colRFQNo = '<%=myRet.getFieldValueString(r,"COLLETIVE_RFQ_NO")%>';
					PoOrCon = '<%=myRet.getFieldValueString(r,"POORCON")%>';
					if(isNaN(len))
					{
						collNo = document.myForm.chk1.value;
						if(collNo == colRFQNo && PoOrCon != 'null' && PoOrCon != 'P')
						{
							alert("PO cannot be created against this QCF as already contract has been created against this QCF.");
							return false;
						}
					}
					else
					{
						if(document.myForm.chk1[<%=r%>].checked)
						{
							collNo = document.myForm.chk1[<%=r%>].value;
						
							if(collNo == colRFQNo && PoOrCon != 'null' && PoOrCon != 'P')
							{
								alert("PO cannot be created against this QCF as already contract has been created against this QCF.");
								return false;
							}
						}	
					
					}
					
<%
				}
			}
%>		
			
 			document.myForm.action="ezCmnVndrValidation.jsp"
			document.myForm.submit();
		}
		else if("CONTRACT"==indicator)
		{
			if(cnt==1)
			{
			var colRFQNo  = "";
			var PoOrCon = "";
<%			
			if(myRetCount>0)
			{
				for(int r=0;r<myRetCount;r++)
				{
%>
					colRFQNo = '<%=myRet.getFieldValueString(r,"COLLETIVE_RFQ_NO")%>';
					PoOrCon = '<%=myRet.getFieldValueString(r,"POORCON")%>';
					if(isNaN(len))
					{
						collNo = document.myForm.chk1.value;
						if(collNo == colRFQNo && PoOrCon != 'null' && PoOrCon != 'C')
						{
							alert("Contract cannot be created against this QCF as already PO has been created against this QCF.");
							return false;
						}
					}
					else
					{
						if(document.myForm.chk1[<%=r%>].checked)
						{
							collNo = document.myForm.chk1[<%=r%>].value;

							if(collNo == colRFQNo && PoOrCon != 'null' && PoOrCon != 'C')
							{
								alert("Contract cannot be created against this QCF as already PO has been created against this QCF.");
								return false;
							}
						}	

					}

<%
				}
			}
%>		
			
			
				document.myForm.collectiveRFQNo.value = collNo;
				document.myForm.action="ezContractCreateData.jsp";
		  		document.myForm.submit();
		  	}
		  	else
		  	{
		  		alert("Please select only one Collective RFQ No. to create Contract");
		  	}
		}
	}
	else
	{
		if("PO"==indicator)
		{
			alert("Please select Collective RFQ No. to create PO");
		}
		else if("CONTRACT"==indicator)
		{
			alert("Please select Collective RFQ No. to create Contract");
		}
	}
}

function CloseQCF()
{
	var radLen = document.myForm.chk1.length
	var colno = 0
	var count = 0
	if(!isNaN(radLen))
	{	
		for(i=0;i<radLen;i++)
		{
			if(document.myForm.chk1[i].checked)
				count++
		}
		if(count == 0 || count >= 2)
		{
			alert("Please select only 1 QCF to Close");
			return;
		}

		for(i=0;i<radLen;i++)
		{
			if(document.myForm.chk1[i].checked)
			{
				colno = document.myForm.chk1[i].value
				break;
			}
		}
	}
	else
	{
		if(document.myForm.chk1.checked)
		{
			colno = document.myForm.chk1.value
		}
		else
		{
			alert("Please select the Collective RFQ No to Close");
			return;
		}
 	}

	if(confirm("Are you sure to close QCF(s)?"))
	{
		url = "ezRemarks.jsp";
		values="";
		dialogvalue=window.showModalDialog(url,values,"center=yes;dialogHeight=18;dialogWidth=25;help=no;titlebar=no;status=no;resizable=no")
		if ((dialogvalue=='Canceld~~')||(dialogvalue==null))
		{
			return;
		}
		else
		{
			
			document.myForm.collectiveRFQNo.value = colno;
			document.myForm.reasons.value = dialogvalue;
			document.myForm.action="ezCloseQCF.jsp";
			document.myForm.submit();
		}
	}	
}



function openPrintWin(num)
{
	var len = document.myForm.chk1.length;
	var num = "";
	var counter = 0
	if(!(isNaN(len)))
	{
		for(var i=0;i<len;i++)
		{
			if(document.myForm.chk1[i].checked)
			{
				num = document.myForm.chk1[i].value;
				counter++
			}	
		}
	}
	else
	{
		num = document.myForm.chk1.value;
	}
	
	if(counter > 1)
	{
		alert("Please select Only 1 Collective RFQ No. for printing");
		return;
	}
	
	if(num=="")
	{
		alert("Please select Collective RFQ No.");
		return;
	}
	else
	{
		var url="ezQCFSAPPrint.jsp?qcfNumber="+num;
		var sapWindow=window.open(url,"newwin","width=850,height=650,left=20,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
	}	
}
 function showTrail()
 {
 	var radLen = document.myForm.chk1.length
 	var colno = 0
 	var count = 0
 	if(!isNaN(radLen))
 	{	
 		for(i=0;i<radLen;i++)
 		{
 			if(document.myForm.chk1[i].checked)
 				count++
 		}
 		if(count > 1)
 		{
 			alert("Please select only 1 Collective RFQ No to see Audit");
 			return;
 		}
 		if(count = 0)
 		{
 			alert("Please select only atleast 1 Collective RFQ No to see Audit");
 			return;
 		}
 		
 		for(i=0;i<radLen;i++)
 		{
			if(document.myForm.chk1[i].checked)
			{
				colno = document.myForm.chk1[i].value
				break;
			}
 		}
 	}
 	else
 	{
		if(document.myForm.chk1.checked)
		{
			colno = document.myForm.chk1.value
		}
		else
		{
 			alert("Please select the Collective RFQ No to see Audit");
 			return;
		}
 	}
 	document.myForm.wf_trail_list.value = colno
 	document.myForm.action = "../Misc/ezWFAuditTrailList.jsp"
 	document.myForm.submit()
}
</Script>
</head>
<body onLoad="scrollInit()" onResize="scrollInit()" scroll=no>
<form name="myForm" method="Post">
<input type=hidden name='wf_trail_list'>
<input type=hidden name='wf_trail_type' value='QCF_RELEASE'>
<%
	String display_header = "";
	if(myRetCount>0)
	{
		display_header = "Approved QCF List";
%>
	<%@ include file="../Misc/ezDisplayHeader.jsp"%>

	<Div id="theads">
		<Table  id="tabHead" width="96%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
			<Tr align="center" valign="middle">
				<Th width="5%">&nbsp;</Th>
				<Th width="15%">Collective RFQ No.</Th>
				<Th width="20%">Material</Th>
				<Th width="10%">RFQ Date</Th>
				<Th width="10%">RFQ Valid Upto</Th>
				<Th width="20%">Approved By</Th>
				<Th width="10%">Approved On</Th>
				<Th width="10%">Proposed Vendors</Th>
			</Tr>
		</Table>
	</Div>
	<Div id="InnerBox1Div" style="overflow:auto;position:absolute;width:96%;height:60%;left:2%">
	<Table id="InnerBox1Tab" width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1>
<%

	FormatDate fD = new FormatDate();
	String validityFlag=null;
	java.util.Date today= new java.util.Date();
	today.setHours(0);today.setMinutes(0);today.setSeconds(0);	
	for(int i=0;i<myRetCount;i++)
	{
		java.util.Date rfqDate 		= (java.util.Date)myRet.getFieldValue(i,"RFQ_DATE");
		java.util.Date validUpto 	= (java.util.Date)myRet.getFieldValue(i,"VALID_UPTO");
		if(validUpto!=null) validUpto.setHours(12);
		
		
		String approvedDate 		= myRet.getFieldValueString(i,"APPROVEDON");
		
		
		
		
		if(validUpto!=null && validUpto.compareTo(today) < 0){
			validityFlag="Y";
		}else{
			validityFlag="N";
		}
		String nextPart 	= (String)nextParticipants.get(myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO"));
		String delPart 		= (String)delParticipants.get(myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO"));
		String concat 		= "";
		String recStatus 	= "";
		String isDelParticipant = "";
		int rowId = retobj.getRowId("DOCID",myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO"));
		if(rowId != -1)
		{
			recStatus = retobj.getFieldValueString(rowId,"STATUS");
			if(!participant.equals(retobj.getFieldValueString(rowId,"NEXTPARTICIPANT")) && participant.equals(retobj.getFieldValueString(rowId,"DELPARTICIPANT")))
				isDelParticipant = retobj.getFieldValueString(rowId,"NEXTPARTICIPANT");
			else
				isDelParticipant = "NO";
		}	
		
		
		if(!type.equals("D"))
		{
			if(!userRole.equals("VP"))
			{
				if(nextPart.equals((String)Session.getUserId()))
					concat = "'"+myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")+"','"+myRet.getFieldValueString(i,"QUANTITY")+"','A','"+type+"'";
				else
					concat = "'"+myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")+"','"+myRet.getFieldValueString(i,"QUANTITY")+"','N','"+type+"'";
			}
			else
			{
				if(nextPart.equals((String)session.getValue("ROLE")))
				{
					if(rowId==-1)
					{
						concat = "'"+myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")+"','"+myRet.getFieldValueString(i,"QUANTITY")+"','A','"+type+"'";
					}
					else
					{
						//if(retobj.getFieldValueString(rowId,"STATUS").equals("QCFSUBMITTEDBYVP"))
						if(retobj.getFieldValueString(rowId,"STATUS").equals("SUBMITTED"))
							concat = "'"+myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")+"','"+myRet.getFieldValueString(i,"QUANTITY")+"','N','"+type+"'";
						else
							concat = "'"+myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")+"','"+myRet.getFieldValueString(i,"QUANTITY")+"','A','"+type+"'";
					}
				}	
				else
				{
					concat = "'"+myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")+"','"+myRet.getFieldValueString(i,"QUANTITY")+"','N','"+type+"'";
				}	
			}
		}
		else
		{
				if(delPart.equals((String)Session.getUserId()))
					concat = "'"+myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")+"','"+myRet.getFieldValueString(i,"QUANTITY")+"','A','"+type+"'";
				else
					concat = "'"+myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")+"','"+myRet.getFieldValueString(i,"QUANTITY")+"','N','"+type+"'";
		
		}
%>   
		<tr>
			<Td width="5%" align=center><input type=checkbox name=chk1 value="<%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%>">
			</Td>	
			<!--<td width="15%"><a href = "javascript:openWin('<%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%>')" ><%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%></a></td>-->
			<td width="15%" align=center><%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%></td>
			<td width="20%"><%=myRet.getFieldValueString(i,"MATERIAL_DESC")%></td>
			<td width="10%" align=center><%=fD.getStringFromDate(rfqDate,".",fD.DDMMYYYY)%></td>
			<td width="10%" align=center><%=fD.getStringFromDate(validUpto,".",fD.DDMMYYYY)%></td>
			<td width="20%"><%=myRet.getFieldValueString(i,"APPROVEDBY")%></td>
			<td width="10%" align=center><%=modifyDate(approvedDate)%></td>
			<td width="10%" align=center><a href ="javascript:showVendors('<%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%>','R')"><%=myRet.getFieldValueString(i,"TOT_PROPOSED")%></a></td>
			<input type="hidden" name="validityFlag" value="<%=validityFlag%>">
	      	</tr>
<%
	}
%>
	</table>
	</div>

<input type="hidden" name="QcfNumber">
<input type="hidden" name="comments">
<input type="hidden" name="actionNum">
<input type="hidden" name="Created">
<input type="hidden" name="reasons">
<input type="hidden" name="collectiveRFQNo">


<Div id="buttonDiv"  style="position:absolute;left:0%;width:100%;top:90%">
<table border="0" cellspacing="0" cellpadding="0" align = center>
<tr>
	<td class="TDCommandBarBorder">
  <span id="EzButtonsSpan" >
<%
	if(editable)
	{
			String chkUserRole = (String)session.getValue("USERROLE");
			if("MG".equals(chkUserRole) || "SM".equals(chkUserRole))
			{
%>
				 <table border="0" cellspacing="3" cellpadding="5">
				 <tr>
				       <td nowrap class="TDCmdBtnOff" onMouseDown="changeClass(this,'TDCmdBtnDown')" onMouseUp="changeClass(this,'TDCmdBtnUp')" onMouseOver="changeClass(this,'TDCmdBtnUp')" onMouseOut="changeClass(this,'TDCmdBtnOff')" onClick="javascript:CloseQCF()" >
					     <b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Close&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>
				       </td>

				
<%
			}
%>

				
				       <td nowrap class="TDCmdBtnOff" onMouseDown="changeClass(this,'TDCmdBtnDown')" onMouseUp="changeClass(this,'TDCmdBtnUp')" onMouseOver="changeClass(this,'TDCmdBtnUp')" onMouseOut="changeClass(this,'TDCmdBtnOff')" onClick="javascript:ProcessFun('PO')" >
					     <b>&nbsp;Create PO&nbsp;</b>
				       </td>
				       <td nowrap class="TDCmdBtnOff" onMouseDown="changeClass(this,'TDCmdBtnDown')" onMouseUp="changeClass(this,'TDCmdBtnUp')" onMouseOver="changeClass(this,'TDCmdBtnUp')" onMouseOut="changeClass(this,'TDCmdBtnOff')" onClick="javascript:ProcessFun('CONTRACT')" >
					     <b>&nbsp;Create Contract&nbsp;</b>
				       </td>

				
				
<%
	}
%>	

				
				       <td nowrap class="TDCmdBtnOff" onMouseDown="changeClass(this,'TDCmdBtnDown')" onMouseUp="changeClass(this,'TDCmdBtnUp')" onMouseOver="changeClass(this,'TDCmdBtnUp')" onMouseOut="changeClass(this,'TDCmdBtnOff')" onClick="javascript:openPrintWin()" >
					     <b>&nbsp; Display/Print &nbsp;</b>
				       </td>
				       <td nowrap class="TDCmdBtnOff" onMouseDown="changeClass(this,'TDCmdBtnDown')" onMouseUp="changeClass(this,'TDCmdBtnUp')" onMouseOver="changeClass(this,'TDCmdBtnUp')" onMouseOut="changeClass(this,'TDCmdBtnOff')" onClick="javascript:showTrail()" >
					     <b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Audit&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>
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
<% }else{ %>

	<%@ include file="../Misc/ezDisplayHeader.jsp"%>

	<br><br><br>
	<table width="60%" align="center" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
	<tr align="center">
	<th>No QCFs Found.</th>
	</tr>
	</table>
	<%}%>
	<input type="hidden" name="Type" value="<%=type%>">
</form>
<Div id="MenuSol"></Div>
</body>
</html>

<%@page import="ezc.ezutil.*,java.util.*"%>
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Jsps/Misc/iblockcontrol.jsp" %>
<%@ include file="../../../Includes/Lib/PurchaseBean.jsp"%>
<%//@ include file="../../../Includes/Jsps/Misc/iBannerSelectSoldTo.jsp" %>
<%@include file="../../../Includes/Jsps/Rfq/iListRFQsToInvite.jsp"%>
<%@ include file="../../../Includes/Jsps/Misc/iGetVendorDesc.jsp"%>

<html>
<head>
<Script>
	var tabHeadWidth=80
	var tabHeight="60%"
</Script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>	<title>List of RFqs</title>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<script src="../../Library/JavaScript/Rfq/ezListRFQs.js"></Script>
<Script>
	function funShowVndrDetails(syskey,soldto)
	{
		var retValue = window.showModalDialog("../RFQ/ezVendorContactDetails.jsp?SysKey="+syskey+"&SoldTo="+soldto,window.self,"center=yes;dialogHeight=25;dialogWidth=40;help=no;titlebar=no;status=no;minimize:yes")	
	} 
	function viewRFQDetailsFun(orderNo,closeDate,vendor)
	{
		document.myForm.PurchaseOrder.value = orderNo
		document.myForm.EndDate.value = closeDate
		document.myForm.rfqVendor.value = vendor
		document.myForm.type.value="InviteGrp";
		document.myForm.action = "ezViewRFQDetails.jsp";
		document.myForm.submit()
	}
	function sendInvitation()
	{
/*		if(!checkRoleAuthorizations("SEND_INVITATION"))
		{
			alert("You are not authorized to send invitation to Vendor");
			return;
		}	*/
		var args = ""
		var selRfq = ""
		var soldTo = ""
		var rfqObj = document.myForm.chk1
		var rfqLen 
		var chooseRfq
		if(rfqObj != null)
		{
			rfqLen = document.myForm.chk1.length
			if(!isNaN(rfqLen))
			{

				for(i=0;i<rfqLen;i++)
				{
					if(document.myForm.chk1[i].checked)
					{
						args = (document.myForm.chk1[i].value).split("¥")
						selRfq = args[0]
						soldTo = args[1]
						chooseRfq = true
						break
					}
					else
					{
						chooseRfq = false
					}
				}
			}
			else
			{
				if(document.myForm.chk1.checked)
				{
					args = (document.myForm.chk1.value).split("¥")
					selRfq = args[0]
					soldTo = args[1]
					chooseRfq = true
				}	
				else
				{
					//chooseRfq = true
				}
			}
			if(chooseRfq)
			{
				if(confirm("Do you want to send invitation for the selected RFQ"))
				{
					document.myForm.action="ezCounterOffer.jsp";
					document.myForm.submit();
				}	
			}	
			else
			{
				alert("Please select the RFQ to Invite")
			}	
		}
	}
	function RFQPrint()
	{
		var args = ""
		var selRfq = ""
		var soldTo = ""
		var rfqObj = document.myForm.chk1
		var rfqLen 
		var chooseRfq
		var chkCounter = 0
		if(rfqObj != null)
		{
			rfqLen = document.myForm.chk1.length
			if(!isNaN(rfqLen))
			{
				for(i=0;i<rfqLen;i++)
				{
					if(document.myForm.chk1[i].checked)
					{				
						chkCounter++;
					}
				}	
				if(chkCounter == 1)
				{
					for(i=0;i<rfqLen;i++)
					{
						if(document.myForm.chk1[i].checked)
						{
							args = (document.myForm.chk1[i].value).split("¥")
							selRfq = args[0]
							soldTo = args[1]
							chooseRfq = true
							break;
						}
						else
						{
							chooseRfq = false
						}
					}
				}	
			}
			else
			{
				if(document.myForm.chk1.checked)
				{
					chkCounter++;
					args = (document.myForm.chk1.value).split("¥")
					selRfq = args[0]
					soldTo = args[1]
					chooseRfq = true
				}	
				else
				{
					chooseRfq = true
				}
			}
			if(chkCounter > 1)
			{
				alert("Please select only 1 RFQ to Print");
				return;
			}
			
			if(chooseRfq)
			{
				document.myForm.PurchaseOrder.value = selRfq
				document.myForm.rfqVendor.value = soldTo
				document.myForm.action = "ezRFQPrint.jsp";
				document.myForm.submit();	
			}
			else
			{
				alert("Please select the RFQ to print");
			}
		}	
	}
</Script>
</head>

<body  onLoad="scrollInit()" onResize="scrollInit()" scroll=no>
<form name="myForm" method="post">
<input type="hidden" name="PurchaseOrder">
<input type="hidden" name="EndDate">
<input type="hidden" name="OrderDate">
<input type="hidden" name="rfqVendor">
<input type="hidden" name="reqFrom" value="InviteGrp">
<input type="hidden" name="type" value="<%=type%>">
<%
	String display_header = "";
	if(Count>0)
     	{
     		Vector types = new Vector();
	        types.addElement("date");
	        types.addElement("date");	        
	        EzGlobal.setColTypes(types);
	        
	        EzGlobal.setDateFormat("dd.MM.yyyy hh:mm");
	
	        Vector names = new Vector();
		names.addElement("RFQ_DATE");		
        	EzGlobal.setColNames(names);
        	
        	ezc.ezparam.ReturnObjFromRetrieve ret = EzGlobal.getGlobal((ezc.ezparam.ReturnObjFromRetrieve)myRetrfq);
		if(type.equals("New"))
		{
			display_header = "List of New RFQs";
		}
		else
		{
			display_header = "List of RFQs To Invite ";
		}
		//display_header += " For "+(String)session.getValue("Vendor");
%>
		<%@ include file="../Misc/ezDisplayHeader.jsp"%>
		<br>
		<Div id="theads">
		<table id="tabHead" width="80%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
			<tr align="center" valign="middle">
				<th width="18%">RFQ No</th>
				<th width="18%">Vendor</th>
				<th width="28%">Vendor Name</th>
 				<th width="18%">RFQ Date</th>
 				<th width="18%">RFQ Closing Date</th>
 			</tr>
		</table>
		</Div>

		<Div id="InnerBox1Div" style="overflow:auto;position:absolute;width:70%;height:60%;left:2%">
		<Table id="InnerBox1Tab" width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
<%
   		FormatDate fd = new FormatDate();
   		for(int i=0;i<Count;i++)
   		{	
   			String collectiveRFQNo =  myRetrfq.getFieldValueString(i,"COLLETIVE_RFQ_NO");
			String orderNo = myRetrfq.getFieldValueString(i,"RFQ_NO");
			String soldToInfo=myRetrfq.getFieldValueString(i,"SOLD_TO");
			//String soldToName=myRetrfq.getFieldValueString(i,"SOLD_TO_NAME");
			String closeDate ="";
			String orderDate ="";
			closeDate = fd.getStringFromDate((Date)myRetrfq.getFieldValue(i,"VALID_UPTO"),".",fd.DDMMYYYY);
			//closeDate = ret.getFieldValueString(i,"VALID_UPTO");
      String clDate = closeDate;
			orderDate = ret.getFieldValueString(i,"RFQ_DATE");
			
%>
    			<tr>
    			<td width="5%" align="center"><input type=checkbox name=chk1 value='<%=orderNo%>¥<%=soldToInfo%>¥<%=collectiveRFQNo%>'></td>
		      	<td width="13%" align="center">
<%			if("List".equalsIgnoreCase(type))
			{
%>
				<a href="JavaScript:viewQuoteDetails('<%=orderNo%>','<%=clDate%>','<%=orderDate%>')"><%=orderNo%></a> 
				</td>
<%			}
			else
			{
%>
      				<A HREF ="JavaScript:viewRFQDetailsFun('<%=orderNo%>','<%=clDate%>','<%=soldToInfo%>')"  onMouseover="window.status='Click to view the RFQ Lines '; return true" onMouseout="window.status=' '; return true"><%=orderNo%></a> 
      				</td>
<%			}
%>
      			<td align="center" width="18%"><a href = "javascript:funShowVndrDetails('<%=(String)session.getValue("SYSKEY")%>','<%=soldToInfo%>')"><%=soldToInfo%></a>&nbsp;</Td>
      			<td align="left" width="28%"><%=venodorsHT.get(soldToInfo.trim())%>&nbsp;</td>
      			<td align="center" width="18%"><%=orderDate%>&nbsp;</td>
      			<td align="center" width="18%">&nbsp;
      				<%=closeDate%>
      			</td>
    			</tr>
<%		}	
%>
  		</table>
		</div>
		
		<Div id="ButtonDiv" align=center style="position:absolute;width:100%;top:90%">
		
<%
    butNames.add("&nbsp;&nbsp;&nbsp;&nbsp; Back &nbsp;&nbsp;&nbsp;&nbsp;");
    butNames.add("&nbsp;&nbsp; Print Version &nbsp;&nbsp;&nbsp;");
    butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Invite &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
   
    butActions.add("history.go(-1)");
    butActions.add("RFQPrint()");
    butActions.add("sendInvitation()");

    out.println(getButtons(butNames,butActions));
%>
      
		</Div>
<%	}
   	else
   	{
%>	
		<%@ include file="../Misc/ezDisplayHeader.jsp"%>
		<br><br><br><br>
		<table width="50%" border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 align="center">
		<tr align="center">
<%		if(type.equals("New"))
		{
%>
			<th>No New RFQs Exist.</th>
<%		}
		else
		{
%>
			<th>No RFQs Exist.</th>
<%		}
%>
		</tr>
		</table>
<%
	}
%>
</form>
<Div id="MenuSol"></Div>
</body>
</html>


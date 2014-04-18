<%@ include file="../../Library/Globals/errorPagePath.jsp" %>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<%@ include file="../../../Includes/JSPs/Misc/iblockcontrol.jsp" %>
<%@ include file="../../../Includes/JSPs/Rfq/iGetAgreementDetails.jsp" %>
<%@ page import="java.util.*"%>
<%!
	private String getInteger(String ItemNo)
	{
		String ItmNo = ItemNo;

		try
		{
			ItmNo = Integer.parseInt(ItmNo)+"";
		}
		catch(Exception e)
		{
			ItmNo = ItemNo;
		}
		return ItmNo;
	}
%>
<html>
<head>
<Script>
	var tabHeadWidth=92
	var tabHeight="30%"
</Script>
<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<Script src="../../Library/JavaScript/Purorder/ezPOLineItems.js"></Script>
<Script src="../../Library/JavaScript/UploadFiles/ezOpenUploadWindow.js"></Script>
<script language="javascript" type="text/javascript">
	var color = 0;
	var increment = 20;
	function lastPODtlsWin(matNum)
	{
		var url="../RFQ/ezGetLastPODetails.jsp?matNumber="+matNum;
		var poDtlWin=window.open(url,"powin","width=850,height=650,left=100,top=120,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
	}	
	function fade(theId)
	{
		color += increment;
		document.getElementById(theId).style.color = "rgb("+color+","+color+","+color+")";
		if (color >= 255)
		{
			increment = -increment;
		}
		else if (color <= 0)
		{
		      increment = -increment;
		}
		setTimeout("fade('" + theId + "')", 150);
	}
	
	function showHeaderText()
	{
		document.myForm.target = "PopUp";
		document.myForm.action= "../Purorder/ezShowHeaderText.jsp";
		newWindow=window.open("","PopUp","width=550,height=300,left=280,top=200,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=no");
		document.myForm.onsubmit = newWindow;
		document.myForm.submit();
	}

	function showItemText(indx)
	{
		document.myForm.target = "PopUp";
		document.myForm.action= "../Purorder/ezShowItemText.jsp?myIndx="+indx;
		newWindow=window.open("","PopUp","width=550,height=300,left=280,top=200,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=no");
		document.myForm.onsubmit = newWindow;
		document.myForm.submit();
	}
	
	
	
	
	
	
</script>
</head>
<Body>
<Form name="myForm" method="POST" >
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<Br>
<%
	//The below is used in delete uploded file page for disabling delete option.
	String workFlowStatus 	= "APPROVED"; 
	
	String type = request.getParameter("viewType");
	if(cnt>0)
	{

		conPONum 	= agmtNo;
		vndr 		= ConHeader.getFieldValueString(0,"VENDOR");
		//conType 	= ConHeader.getFieldValueString("DOC_TYPE");
%>
		<input type="hidden" name='commentType'   value=''>
		<input type="hidden" name='QcfNumber'     value='<%=Long.parseLong(agmtNo)%>'>
		<input type=hidden name='isDelegate' value='<%=request.getParameter("ISDELEGATE")%>'>
		<input type=hidden name='nextPart' 	value='<%=nextParticipant%>'>
		
		<input type="hidden" name='qcsCommentNo'  value='<%=(qcsCount+1)%>'>
		<input type="hidden" name="chk1"          value="<%=conPONum%>">
		<input type="hidden" name="POrCON"        value="<%=POORCONTRACT%>" >
		<input type='hidden' name='type'          value='<%=orderType%>' >
		<input type="hidden" name="OrderDate"     value="<%=orderDate%>">
		<input type="hidden" name="POPrice"       value="<%=contractTargetValue%>">
		<input type="hidden" name="PurchaseOrder" value="<%=conPONum%>" >    
		<input type="hidden" name="agmtNo"        value="<%=ConHeader.getFieldValueString(0,"PO_NUMBER")%>">
		<input type="hidden" name="vendor"        value="<%=ConHeader.getFieldValueString(0,"VENDOR")%>">
		<input type="hidden" name="actionCode">
		<input type=hidden name=rejectToUser>
		<input type=hidden name="attachflag">
		<input type="hidden" name="attachString">
		<input type="hidden" name="myIndx">
		
	
		
       
		    
		        <Table align="center" width="95%" border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=1 >
			<Tr>
				<Th align="left" colspan=8><img src='../../yellowarrow.gif'>&nbsp;&nbsp;Header Details</Th>	        
			</Tr>
		        <Tr> 
		          <Th align="left" width="10%">Contract </Th>
		          <Td width="12%"><%=agmtNo%></Td>
		          <Th align="left" width="7%">Type</Th>
		          <Td width="17%"><%=conType%></Td>
		          <Th align="left" width="11%">Start Date</Th>
		          <Td width="15%"><%=fd.getStringFromDate((Date)ConHeader.getFieldValue(0,"CREATED_ON"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%></Td>
		          <Th align="left" width="10%">End Date</Th>
		          <Td width="16%"><%=fd.getStringFromDate((Date)ConHeader.getFieldValue(0,"VPER_END"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%></Td>
		        </Tr>
		        <Tr> 
		          <Th align="left">QCF</Th>
		          <Td><%=poconQCFNumber%></Td>
		          <Th align="left">Currency</Th>
		          <Td>
		          	<%=ConHeader.getFieldValueString(0,"CURRENCY")%>
		          	<input type="hidden" name="contractCurr" value="INR">
		          </Td>
		          <Th align="left">Vendor</Th>
		          <Td ><input type=text size=50 value='<%=ConHeader.getFieldValueString(0,"VENDOR")%>[<%=ConHeader.getFieldValueString(0,"VEND_NAME")%>]' title='<%=ConHeader.getFieldValueString(0,"VENDOR")%>(<%=ConHeader.getFieldValueString(0,"VEND_NAME")%>)' class="tx"  readonly></Td>
		          <Th align="left">Text</Th>
		          <td>
				<input type="hidden" name="hText" value="<%=headerText%>">
				<a href="javascript:onClick=showHeaderText()">
				<img   src="../../Images/Common/edit-button.gif" border="none" valign=bottom style="cursor:hand">
				</a>
			  </td>
		          
		        </Tr>
		        </Table>

        		<Br>
		
		
<%
	Hashtable poMaterials=new Hashtable();
	String displayStr = "";
	if(ConItemsCnt>0)
	{
%>	
		
			<Table align="center" width="95%" border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=1 >
			<Tr>
				<Th align="left" colspan=8><img src='../../yellowarrow.gif'>&nbsp;&nbsp;Item Details</Th>	        
			</Tr>
			<Tr> 
				<Th width="10%">Line No.</Th>
				<Th width="15%">Material</Th>
				<Th width="25%">Description</Th>
				<Th width="15%"><%=conTypeHeader%></Th>
				<Th width="13%">Net Price</Th>
				<Th width="8%">UOM</Th>
				<Th width="10%">Plant</Th>
				<Th width="4%">Text</Th>
			</Tr>
		
<%
		String material = "";
		java.math.BigDecimal totContractVal=new java.math.BigDecimal(0.0);
		java.math.BigDecimal exchRate=new java.math.BigDecimal(1);
		try{
			exchRate=new java.math.BigDecimal(ConHeader.getFieldValueString(0,"EXCH_RATE"));
		}catch(Exception err){exchRate=new java.math.BigDecimal(1);}
		
		
		String contractUOM="";
		
		
		for(int c=0;c<ConItems.getRowCount();c++)
		{
			
			
			if(conType.indexOf("WK") != -1)
			{
				targetData = ConHeader.getFieldValueString(0,"TARGET_VAL");
			}	
			if(conType.indexOf("MK") != -1)
			{
				targetData = ConItems.getFieldValueString(c,"TARGET_QTY");
			}	
		
			if(conType.indexOf("WK") != -1){
				totContractVal=totContractVal.add(new java.math.BigDecimal(targetData));

			}else{
				totContractVal=totContractVal.add(new java.math.BigDecimal(targetData).multiply(new java.math.BigDecimal(ConItems.getFieldValueString(c,"NET_PRICE"))));
			
			}
			
			if(!"INR".equalsIgnoreCase(ConHeader.getFieldValueString(0,"CURRENCY")))
				totContractVal=totContractVal.multiply(exchRate);

			if("".equals(contractUOM)){
				contractUOM=ConItems.getFieldValueString(c,"ORDERPR_UN");
			}else if(!contractUOM.equalsIgnoreCase(ConItems.getFieldValueString(c,"ORDERPR_UN"))){
				contractUOM="MLUOM";
              		}
		
			material = ConItems.getFieldValueString(c,"MATERIAL");
			try{
				material = String.valueOf(Integer.parseInt(material));	
			}catch(Exception e){ }
			poMaterials.put(agmtNo+ConItems.getFieldValueString(c,"PO_ITEM"),material);
			
			String myItemText=(String)itemTextHT.get(ConItems.getFieldValueString(c,"PO_ITEM"));
								
			if(myItemText==null || "null".equals(myItemText))
			myItemText="";
			
			
			
			
%>
			<Tr align="center"> 
				<Td width="10%" align="center"><%=ConItems.getFieldValueString(c,"PO_ITEM")%>&nbsp;</Td>
				<Td width="15%" align="center"><%=material%>&nbsp;</Td>
				<Td width="25%" align="left"><%=ConItems.getFieldValueString(c,"SHORT_TEXT")%>&nbsp;</Td>
				<Td width="15%" align="right"><%=targetData%>&nbsp;</Td>
				<Td width="15%" align="right"><%=ConItems.getFieldValueString(c,"NET_PRICE")%>&nbsp;</Td>
				<Td width="8%" align="center"><%=ConItems.getFieldValueString(c,"ORDERPR_UN")%>&nbsp;</Td>
				<Td width="13%" align="center"><a href="Javascript:void(0)" onClick="goToPlantAddr('<%=ConItems.getFieldValueString(c,"PLANT")%>')"  onMouseover="window.status='Click to view the Plant Address. '; return true" onMouseout="window.status=' '; return true"><%=ConItems.getFieldValueString(c,"PLANT")%></a>&nbsp;</Td>
				<td width="4%" align="center">
										
					<input type="hidden" name="iText" value="<%=myItemText%>">
					<a href="javascript:onClick=showItemText('<%=c%>')">
					<img   src="../../Images/Common/edit-button.gif" border="none" valign=bottom style="cursor:hand">
					</a>
										
										
				</td>
				
				
				
			</Tr>  
<%		
            	}
%>            	
            	</Table>
            	
<%
	if(POsToConCnt>0)
	{
%>
		<Br>
		<Table align="center" width="95%" border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=1 >			
			<Tr> 
				<Th align="left" colspan=8><img src='../../yellowarrow.gif'>&nbsp;&nbsp;PO(s) Against Contract</Th>
			</Tr>
			<Tr> 
				<Th width="20%">PO No.</Th>
				<Th width="10%">PO Item</Th>
				<Th width="10%">Con. Item</Th>
				<Th width="15%">Material</Th>
				<Th width="15%">PO Date</Th>				
				<Th width="10%">Quantity</Th>
				<Th width="10%">UOM</Th>
				<Th width="10%">Plant</Th>
			</Tr>
		</Table>
		<Table align="center" width="95%" border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=1 >
<%
		material = null;
		for(int p=0;p<POsToCon.getRowCount();p++)
		{
			material = (String)poMaterials.get(POsToCon.getFieldValueString(p,"KONNR")+POsToCon.getFieldValueString(p,"KTPNR"));
			if(material == null || "null".equals(material))
				material = "";	
			else	
				material = material+"&nbsp;";
				//material = "<a href=\"javascript:lastPODtlsWin('"+material+"')\">"+material+"&nbsp;</a>";
%>
			<Tr align="center"> 
				<Td width="20%">
					<a href='../Purorder/ezBlockedPoLineitems.jsp?poSysKey=<%=(String)session.getValue("SYSKEY")%>&type=QUERY_DETAILS&vendorNo=<%=ConHeader.getFieldValueString(0,"VENDOR")%>&PurchaseOrder=<%=POsToCon.getFieldValueString(p,"EBELN")%>'><%=POsToCon.getFieldValueString(p,"EBELN")%></a>&nbsp;
				</Td>
				<Td width="10%" align="center"><%=getInteger(POsToCon.getFieldValueString(p,"EBELP"))%>&nbsp;</Td>
				<Td width="10%" align="center"><%=getInteger(POsToCon.getFieldValueString(p,"KTPNR"))%>&nbsp;</Td>
				<Td width="15%" align=center>
				<%=material%>&nbsp;
				</Td>
				<Td width="15%"  align="center"><%=fd.getStringFromDate((Date)POsToCon.getFieldValue(p,"BEDAT"),".",ezc.ezutil.FormatDate.DDMMYYYY)%>&nbsp;</Td>
				<Td width="10%" align="right"><%=POsToCon.getFieldValueString(p,"MENGE")%>&nbsp;</Td>
				<Td width="10%" align="center"><%=POsToCon.getFieldValueString(p,"MEINS")%>&nbsp; </Td>
				
				<Td width="10%" align="center">
					<a href="JavaScript:void(0)" onClick=goToPlantAddr('<%=POsToCon.getFieldValueString(p,"WERKS")%>') title="Click here to see the address of plant"><%=POsToCon.getFieldValueString(p,"WERKS")%></a>&nbsp;
				</Td>
			</Tr> 
<%		}
%>
		</Table>
<%	
	}
%>          	
            	
            	
<%            	
            if(qcsCount > 0)
            {
            	ezc.ezparam.ReturnObjFromRetrieve globalCmRet = null;
													
		Vector vc = new Vector();	
		Vector types = new Vector();
		types.addElement("date");
		EzGlobal.setColTypes(types);
		EzGlobal.setDateFormat("dd.MM.yyyy hh:mm:ss");

		Vector colNames = new Vector();
		colNames.addElement("QCF_DATE");
       		EzGlobal.setColNames(colNames);
				
		globalCmRet = EzGlobal.getGlobal(commentsRet);
            
%>	
              <Br><Table align="center" width="95%" border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=1 >
		<Tr>
			<Th align="left" colspan=3><img src='../../yellowarrow.gif'>&nbsp;&nbsp;Comments</Th>	        
		</Tr>
<%
                  for(int i=0;i<qcsCount;i++)
                  {
                    if(i == 0)
                    {
%>	
                      <Tr><Th width=10%>User</Th><Th width=15%>Date</Th><Th width=75%>Comments</Th></Tr>
<%
                    }
                    displayStr = commentsRet.getFieldValueString(i,"QCF_COMMENTS");
%>				
                      <Tr>
                        <Td width=10% ><%=commentsRet.getFieldValueString(i,"QCF_USER")%></Td>
                        <!--<Td width=10% ><%=fd.getStringFromDate((Date)commentsRet.getFieldValue(i,"QCF_DATE"),".",ezc.ezutil.FormatDate.DDMMYYYY)%></Td>-->
                        <Td width=15% ><%=globalCmRet.getFieldValue(i,"QCF_DATE")%></Td>
                        <Td width=75% title='<%=displayStr%>'><%=displayStr%></TD>
                      </Tr>
<%		
                  }
%>
                  </Table>	
                
<%
            }
%>
		
                  <Br><Table align="center" width="95%" border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=1 >
<%                  
			if("UNREL".equals(type.trim()))
  			{
				workFlowStatus 	= ""; 
	
%>
			<Tr>
				<Th align=left ><input type=hidden name=remLen value="2000"><img src='../../yellowarrow.gif'>&nbsp;&nbsp;<B><a href="javascript:commentsSpace('ezQCFCommentSpace.jsp')"><Font color=white>Enter your comments here</Font></a></B></Th>
			</Tr>
			<Tr>	
				<Td class='blankcell'>
					<textarea style='width:100%' rows=6 name=reasons onKeyDown="textCounter(document.myForm.reasons,document.myForm.remLen,2000);" onKeyUp="textCounter(document.myForm.reasons,document.myForm.remLen,2000);"></textarea>
					<input type=hidden name=remLen value="2000">
				</Td>
			</Tr>
<%
  			}
%>  			
			</table>
			<Br><Table align="center" width="95%" border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=1 >
			<Tr>
<%
			if("UNREL".equals(type.trim()))
			{
%>
			<Th align="left" width=60%>
				<Table width=100%><Tr><Th align=left><img src='../../yellowarrow.gif'>&nbsp;&nbsp;
				<a href="JavaScript:funAttach()" title="Click Here To Attach A File"><Font color="white"><B>Attach</B> </Font></a>
				</Th><Th align=right>
				<a href="JavaScript:funRemove()" title="Click Here To Remove Attached File"><Font color="white"><B>Remove</B> </Font></a>
				</Th></Tr></Table>
			</Th>
<%
			}
			if(noOfDocs>0)
			{			
%>
			<Th align="center" >
				View Attached Files
			</Th>
<%
			}
%>
			</Tr>
			<Tr>
<%
			if("UNREL".equals(type.trim()))
			{
%>			
			<Td align="center" width=60% class='blankcell' >
				<select name="attachs" style="width:100%" size=5 ondblclick='funOpenFile()'>
				</select>
			</Td>
<%
			}
			if(noOfDocs>0)
			{			
%>
			<Td borderColorDark=#ffffff width=40% align='center' class='blankcell'>
				<iframe src='../UploadFiles/ezQcfAttachments.jsp?docNum=<%=agmtNo%>&docType=CONT&workFlowStatus=<%=workFlowStatus%>' frameborder=1 width=100% scrolling=auto scrolling=yes height='75'></iframe>
			</Td>
<%
			}
%>	
			</Tr>
			</Table>
		
		



           <input type="hidden" name="totContractVal" value="<%=totContractVal.toString()%>">
           <input type="hidden" name="contractUOM" value="<%=contractUOM%>">
<%	
	}
%>	

		
		
		
		
		

			<DIV id="ButtonsDiv" align="center" style="position:relative;width:100%;">
<%	
				buttonName = new java.util.ArrayList();
				buttonMethod = new java.util.ArrayList();


				buttonName.add("Back");
				if("PO".equals(viewType))
				buttonMethod.add("history.go(-1)");
				else
				buttonMethod.add("funNavigate(\""+navigateFileName+"\")");

		if(!("UNREL".equals(type.trim()) || "QUERY_DETAILS".equals(type.trim())))
		{
			buttonName.add("Print Version");
			buttonMethod.add("getConDetPDF(\""+conPONum+"\",\""+vndr+"\")"); 
		}

		if(showSubmit)
		{
			buttonName.add("Submit");
			buttonMethod.add("funSubmit(\"../PurOrder/ezSubmitPurchaseOrder.jsp\",\"100066\",\"Submit\",\""+queryCheck+"\")");
		}


		if(showReject)
		{
			buttonName.add("Reject");
			buttonMethod.add("funSubmit(\"../PurOrder/ezSubmitPurchaseOrder.jsp\",\"100068\",\"Reject\",\""+queryCheck+"\")");
		}

		if(showRelease)
		{
		buttonName.add("Release Order");
		buttonMethod.add("funSubmit(\"../PurOrder/ezReleasePurchaseOrder.jsp\")");
		}

		if("UNREL".equals(viewType) || "QUERY_DETAILS".equals(viewType))	
					{
%>
					<Td>
		<%
						buttonName.add("WF Hierarchy");
						buttonMethod.add("showStatusWindow(\""+agmtNo+"\",\""+netOrderAmount+"\",\"N\",\"CON\",\""+vndr+"\")");	
		%>
					</Td>
					<Td>
		<%                                
						buttonName.add("Query");
						buttonMethod.add("funOpenWin(\""+agmtNo+"\",\""+vndr+"\",\"CON\")");	
		%>
					</Td>			
		<%			
					}
		%>
					<Td>
		<%
						buttonName.add("AmendmentDetails");
						buttonMethod.add("getAmndPODtl(\""+agmtNo+"\")");	
		%>
					 </Td>

<%


			out.println(getButtonStr(buttonName,buttonMethod));

	%>
	</Div>
		
		
		
		
		

		
		<Div id="msgDiv" style="width:100%;visibility:hidden;position:relative;" align="center">
			<Table width="60%" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
				<Tr>
					<Th  align="center">Your request is being processed. Please wait ...............</Th>
				</Tr>
			</Table>
		</Div>
		
<%
	}
	else
	{
%>
		<div style="position:absolute;top:40%;width:100%;visibility:visible" align="center">
			<Table id="header" align=center width="60%" border=1 borderColorDark=#ffffff borderColorLight=#000000  cellspacing="0" cellpadding="2">
				<Tr>
					<Th>Contract Details Not Found</Th>
				</Tr>
			</Table>
		</div>
		<div id="buttons" style="position:absolute;top:90%;width:100%;visibility:visible" align="center">
<%
			buttonName.add("Back");
			if("PO".equals(viewType))
			buttonMethod.add("history.go(-1)");
			else
			buttonMethod.add("funNavigate(\""+navigateFileName+"\")");

			out.println(getButtonStr(buttonName,buttonMethod));
%>
 		</div>
<%
	}
%>
</form>
<Div id="MenuSol"></Div>
</body>
</html>


<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%//@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Rfq/iListRFQByCollectiveRFQ.jsp" %>
<%@ include file="../../../Includes/JSPs/Rfq/iQuotationComparisionForm.jsp" %>
<%@ include file="../../../Includes/JSPs/Rfq/iExecuteQCFReport.jsp"%>
<Html>
<Head>
	<Script>
		var tabHeadWidth=70
		var tabHeight	="<%=tabHeight%>"
	function showTrail(colno)
 	{
	 	var url="../Misc/ezOfflineWFAuditTrailList.jsp?wf_trail_type=QCF_RELEASE&wf_trail_list="+colno;
	 	var mywind=window.open(url,"ReportWin","width=700,height=300,left=150,top=150,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=no");
	}	
	</Script>
	<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
	<Script src="../../Library/JavaScript/UploadFiles/ezOpenUploadWindow.js"></Script>
	<Script src="../../Library/JavaScript/Rfq/ezQCS.js"></Script>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
</Head>
<Body  onLoad="setDimensions()" scroll=no>
<Form name="myForm" method="post">
<input type=hidden name="PAGE" value="<%=PAGE%>">
<%
	int colcount 		= qcfCount+1;
	String display_header	= "";
	String materialNo	= "";
	String collectiveRFQNo	= "";
	String qcfReport	= "";
	String vendNumber 	= "";
	String checkVendorNumber= "";
	String quoted 		= "";
	String vendorProposed	= "";
	String alertStat 	= "";
	String subAlert		= "";
	String displayStr 	= "";
	String wfsheight 	= "100";
	String atchmntheight 	= "62";	
	String commentsRows 	= "rows=3";
	String attachSize 	= "size=3";
	
	//The below is used in delete uploded file page for disabling delete option.
	String workFlowStatus 	= "APPROVED"; 
	
	boolean submitionFlag	= true;	
	if("100067".equals(actionCheck) || (!showApprove && !showSubmit))
	{
		wfsheight 	= "170";	//These heights are applied to those QCFs which are approved or expired.
		atchmntheight 	= "110";
	}		
		
			
	
	if(qcfCount>0)
	{
		String viewAttachHeight="";
		if(!showApprove && !showSubmit)
			viewAttachHeight="50%";
		else
			viewAttachHeight="20%";
		java.util.Date currentDayDate = new java.util.Date();
		currentDayDate.setHours(0);currentDayDate.setMinutes(0);currentDayDate.setSeconds(0);
		for(int j=0;j<qcfCount;j++)
		{
			java.util.Date expiredDate=(Date)qcfRet.getFieldValue(j,"BNDDT");
			if(expiredDate!=null)
			{
				expiredDate.setHours(23);expiredDate.setMinutes(59);expiredDate.setSeconds(0);
				if(expiredDate.compareTo(currentDayDate)<0)
				{
					submitionFlag=false;
				}

			}
			if(!submitionFlag)
			{
				if(showSubmit)
				{
					subAlert="QCF can't be submitted as some of the RFQ's in list are expired";
				}
				else if(showApprove)
				{
					subAlert="QCF can't be approved as some of the RFQ's in list are expired";
				}

			}
%>		
			<input type="hidden" name=allrfqs value='<%=qcfRet.getFieldValueString(j,"EBELN")%>'>
<%		
		}	
		
		materialNo 	= qcfRet.getFieldValueString(0,"MATNR");
		collectiveRFQNo = qcfRet.getFieldValueString(0,"SUBMI");
		display_header 	= "Quotation Comparision Form for Collective RFQ No: "+collectiveRFQNo;
		
		try
		{
			StringBuffer qcfReportBuffer = new StringBuffer();
			int outTableCount = outTable.getRowCount();
			if ( outTable != null )
			{
				for ( int i = 0 ; i < outTableCount; i++ )
				{
					String line = outTable.getLine(i);
					if (line.length() == 257)
						line = line.substring(1,line.length()-1);
					else
						line = line.substring(1,line.length());
					qcfReportBuffer.append(line);
				}
			}
			qcfReport = qcfReportBuffer.toString();
			qcfReport = qcfReport.substring(qcfReport.indexOf("</tr>")+5);
			qcfReport = qcfReport.substring(qcfReport.indexOf("</tr>")+5);
			qcfReport = qcfReport.substring(0,qcfReport.indexOf("</table>"));
%>	
			<%@ include file="../Misc/ezDisplayHeader.jsp"%>
			
			<input type=hidden name='nextPart' 	value='<%=nextParticipant%>'>
			<input type=hidden name='qcsCommentNo' 	value='<%=(qcsCount+1)%>'>
			<input type=hidden name='lastPOPrice' 	value='<%=lastPOPrice%>'>
			<input type=hidden name='lastPOCurr' 	value='<%=lastPOCurr%>'>
			<input type=hidden name='QcfNumber' 	value='<%=collNo%>'>
			<input type=hidden name='type' 		value='<%=type%>'>
			<input type=hidden name='isdelegate' 	value='<%=isdelegate%>'>
			<input type=hidden name='initiator' 	value='<%=initiator%>'>
			<input type=hidden name='proposeFlg' 	value="<%=disableByUsrRole%>">
			<input type=hidden name='lastModifiedDate' value="<%=lastModifiedDate%>">			
			
			<input type=hidden name='hideBypassCount' value='-'>
			<input type=hidden name='byPassAllow' 	value='-'>
			
			<input type=hidden name='actionNum'	value=''>
			<input type=hidden name='prevStatus'	value=''>
			<input type=hidden name='commentType' 	value=''>
			<input type=hidden name='attachflag' 	value=''>
			<input type=hidden name='attachString' 	value=''>
			<input type=hidden name='rejectToUser'  value=''>
			<input type=hidden name='filePaths' 	value=''>
    
        
		
	
			<Table width="100%" borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 border=0>
			<Tr>
				<Td width="70%" height='575' valign="top" class=blankcell>
					<Div  align="left" style="position:absolute;width:97%;">
						<Table id="tabHead" width="100%"  border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
						<Tr align="left" valign="middle">
							<Th width="26.5%" align=right>Propose Vendor</Th>
<%
							for(int i=0;i<qcfCount;i++)
							{
								vendNumber = qcfRet.getFieldValueString(i,"LIFNR");
								for(int k=0;k<myRetCnt;k++)
								{
									if((myRet.getFieldValueString(k,"RFQ_NO").trim().equals(qcfRet.getFieldValueString(i,"EBELN").trim())) && ("R".equals(myRet.getFieldValueString(k,"RELEASE_INDICATOR").trim())))
										vendorProposed ="checked";
								}
								if(!"disabled".equals(disableByUsrRole))
									globalDisFlg=true;
								
								int 	myRFQRank	= 0;
								double  myRFQPrice	= 0;
								String 	myRFQCurr	= qcfRet.getFieldValueString(i,"WAERS");
								String myRFQUOM		= qcfRet.getFieldValueString(i,"BPRME");
								try
								{
								  	myRFQRank=Integer.parseInt(qcfRet.getFieldValueString(i,"RANK1"));
								}
								catch(Exception err)
								{
									myRFQRank=0;
								}
								try
								{
									myRFQPrice=Double.parseDouble(qcfRet.getFieldValueString(i,"NETPR_ORG"));
								}
								catch(Exception err)
								{
									myRFQPrice=0;
								}
								alertStat = "N";
								if(myRFQRank>1 && lastPODtlCount>0 && myRFQCurr.equals(lastPOCurr) && myRFQPrice>lastPOPrice )
									alertStat = "Y";
%>				
								<Th width=24%>
									<input type=checkbox onClick="showConfirmAlert(this,'<%=vendNumber%>','<%=myRFQRank%>','<%=alertStat%>');" name=propose  value="<%=qcfRet.getFieldValueString(i,"EBELN")%>" <%=vendorProposed%> <%=disableByUsrRole%>><B><a href = "javascript:funShowVndrDetails('<%=(String)session.getValue("SYSKEY")%>','<%=vendNumber%>')" style="text-decoration: none"><font color="white"><B><%=vendNumber%></B></a>
								</Th>
								<input type="hidden" name="myRFQRank" 	value="<%=myRFQRank%>">
								<input type="hidden" name="myRFQPrice" 	value="<%=myRFQPrice%>">
								<input type="hidden" name="myRFQCurr" 	value="<%=myRFQCurr%>">
								<input type="hidden" name="myRFQUOM" 	value="<%=myRFQUOM%>">
								<input type="hidden" name="alertStat" 	value="<%=alertStat%>">
<%		
							}
							if(qcfCount<3)
							{
								for(int i=qcfCount;i<3;i++)
								{
									out.println("<Th width='24%'>&nbsp;</Th>");
								}
							}	
%>
						</Tr>
						</Table>
					</Div>
					<Div align="left" id="InnerBox1Div" style="overflow:auto;position:absolute;width:100%;height:85%;top:9%">
						<Table id="InnerBox1Tab" width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
<%
							out.println(qcfReport);
							if(qcsCount > 0)
							{
%>	
								<Tr>
									<Td colspan=4>
										<Table width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>			
<%
										for(int i=0;i<qcsCount;i++)
										{
											displayStr = commentsRet.getFieldValueString(i,"QCF_COMMENTS");
											if(i == 0)
											{
%>	
												<Tr><Th width=10%>User</Th><Th width=10%>Date</Th><Th width=80%>Comments</Th></Tr>
<%
											}
%>				
											<Tr>
												<Td width=10% style="background-color='#EEF9FF'"><%=commentsRet.getFieldValueString(i,"QCF_USER")%></Td>
												<Td width=10% style="background-color='#EEF9FF'"><%=fd.getStringFromDate((Date)commentsRet.getFieldValue(i,"QCF_DATE"),".",ezc.ezutil.FormatDate.DDMMYYYY)%></Td>
												<Td width=80% style="background-color='#EEF9FF'" title='<%=displayStr%>'><%=displayStr%></TD>
											</Tr>
<%		
										}
%>
										</Table>	
									</Td>
								</Tr>
<%
							}
%>
						</Table>	
					</Div>	

				</Td>
				<Td width="30%" valign="top" class=blankcell>
					<Div align="left" id="commentsDiv" style="position:absolute;width:100%;height:100%;top:7%">
					<Table width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellSpacing=1>
					<Tr> 
						<Td class=blankcell align=right width="30%">
							<a href="JavaScript:javascript:SAPView('<%=collectiveRFQNo%>')"><img src="../../Images/Buttons/<%=ButtonDir%>/Printer.gif" style="cursor:hand" title="Click here to print & save QCF" border="none"></a>
<%
							if(showQuery)
							{				
%>		
								<img src="../../Images/Buttons/<%=ButtonDir%>/query.gif" style="cursor:hand" title="Click here to View & Send Queries" border="none" onClick="JavaScript:funOpenWin('<%=collNo%>')">
<%
							}
%>
							<a href="JavaScript:lastPODtlsWin('<%=matNumber%>')"><Font color="black" size="2.5">Last PO(s)</B></Font></a>
	          				</Td>
	        			</Tr>					
<%
					if(propPrices.size() > 0)
					{
%>
						<Tr>
							<Td>
								<Table border=0 width=100% cellSpacing=1>
								<Tr>
									<Th width=60%>Total Proposed Value</Th>
									<Td class='blankcell'>
									    <input type="hidden" value="<%=propsdValue.toString()%>" name="totAPPQCFVal">
									    <input type="hidden" value="<%=propsdQty%>" name="totAPPQCFQty">
									    <input type="hidden" value="<%=propsdUOM%>" name="totAPPQCFUOM">
<%
									    	ezc.ezbasicutil.EzCurrencyFormat myCurFormat = new ezc.ezbasicutil.EzCurrencyFormat();
										myCurFormat.setLocale((java.util.Locale)session.getValue("LOCALE"));
										myCurFormat.setNeedSybmol(((Boolean)session.getValue("SREQUIRED")).booleanValue());
										myCurFormat.isPre(((Boolean)session.getValue("CPOSITION")).booleanValue());
										myCurFormat.setSymbol((String)session.getValue("CURRENCY"));
%>
									    <%=myCurFormat.getCurrencyString(propsdValue.toString())%>
									</Td>
								</Tr>
								</Table>
							</Td>
						</Tr>
<%
					}
%>
					</Table>
					<Table width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellSpacing=1>
					<Tr> 	
<%
					if(showStatus)
					{		
						commentsRows = "rows=7";
						attachSize = "size=6";
%>
						<Tr>
							<Th align=left>
								Approval Heirarchy	
							</Th>
						</Tr>

						<Tr>
							<Td class='blankcell' height=175>
								<iframe src='../Rfq/ezShowQcfStatusInOffline.jsp?COLNO=<%=qcfRet.getFieldValueString(0,"SUBMI")%>&NETPR=<%=propsdValue.toString()%>&loginType=<%=loginType%>' height=100% width=100% scrolling=auto frameborder=0 scrolling=yes ></iframe>
							</Td>
						</Tr>	
<%
					}
					else
					{
						commentsRows = "rows=20";
						attachSize = "size=9";
					}	
					if(noOfDocs>0)
					{
						commentsRows = "rows=4";
						attachSize = "size=3";
			
					}  					
					if(!"100067".equals(actionCheck)) 
					{
						if(showTextAreas)
						{
							workFlowStatus = "";
				
%>		
							<Tr>
								<Th align=left><input type=hidden name=remLen value="2000"><B><a href='javascript:commentsSpace()'><Font color=white>Comments</Font></a></B></Th>
							</Tr>
							<Tr>	
								<Td class='blankcell' >
									<Textarea  style="width:99%" name=qcfComments <%=commentsRows%>></Textarea>
								</Td>
							</Tr>
							<Tr>
								<Th align="left">
									<Table width=100%><Tr><Th align=left>
									<a href="JavaScript:funAttach()" title="Click Here To Attach A File"><Font color="white"><B>Attach</B> </Font></a>
            								</Th><Th align=right>
            								<a href="JavaScript:funRemove()" title="Click Here To Remove Attached File"><Font color="white"><B>Remove</B> </Font></a>
            								</Th></Tr></Table>
            							</Th>
							</Tr>
							<Tr>
								<Td align="center" class='blankcell' align=left>
									<select name="attachs" style="width:99%" <%=attachSize%> ondblclick='funOpenFile()'>
									</select>
								</Td>
							</Tr>
<%
						}
					}
					if(noOfDocs>0)
					{
%>			
						<Tr>
							<Th align=left>
								View Attached Files	
							</Th>
						</Tr>						
						<Tr height=<%=viewAttachHeight%>>
							<Td borderColorDark=#ffffff align='center' class='blankcell' >
								<iframe src='../UploadFiles/ezQcfAttachments.jsp?docNum=<%=collNo%>&docType=QCF&workFlowStatus=<%=workFlowStatus%>' frameborder=0 width=100% scrolling=auto frameborder=0 scrolling=yes height=100%></iframe>
							</Td>
						</Tr>	
<%			
					} 					
					
					if(((!"APPROVED".equals(wfStatus)) && (actionsList.indexOf("APPROVED") == -1) && ("VP".equals(userRole) || "PR".equals(userRole)) && !showApprove))
					{
%>	
						<Tr>
							<Th align=left class='blankcell'>
								<input type=checkbox name=bypass value='BYPASS' onclick="openByPassList(<%=qcfNetPrice%>,'<%=qcfQueryCount%>')"><B>ByPass</B>
							</Th>
						</Tr>
<%
					}
%>						
					</Table>
					</Div>
				</Td>
			</Tr>
			</Table>


<Div id="2" style="position:absolute;left:0%;width:100%;top:90%">
	<Table align=center>
	<Tr>
		<Td class=blankcell align="center"> <Font color="red"><%=subAlert%></Font></Td>
	</Tr>
	</Table>
</Div>

<Div id="ButtonsDiv" align=center style="position:absolute;visibility:visible;width:100%;top:93%">    
<%
      butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
      butActions.add("history.go(-1)");
      butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Audit&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
      butActions.add("showTrail("+collectiveRFQNo+")");

		if(showApprove&&submitionFlag)		
		{
        butNames.add("&nbsp;&nbsp;&nbsp;Approve&nbsp;&nbsp;&nbsp;");   
        butActions.add("funSubmit('100067','"+qcfQueryCount+"')");
		}
		if(showSubmit&&submitionFlag)
		{
    
       butNames.add("&nbsp;&nbsp;&nbsp;Submit&nbsp;&nbsp;&nbsp;");   
       butActions.add("funSubmit('100066','"+qcfQueryCount+"')");
		}
		if(showReject)
		{
        butNames.add("&nbsp;&nbsp;&nbsp;Rejected&nbsp;&nbsp;&nbsp;");   
        butActions.add("funSubmit('100068','"+qcfQueryCount+"')");
		}
		if(showRequote && (!"APPROVED".equals(wfStatus)))
		{
    
      butNames.add("&nbsp;&nbsp;&nbsp;Requote&nbsp;&nbsp;&nbsp;");   
      butActions.add("reQuote()");
		}
        out.println(getButtons(butNames,butActions));
%>
</Div>

<Div id="msgDiv" style="position:absolute;top:93%;width:100%;visibility:hidden" align="center">
	<Table align="center" width="60%" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1>
		<Tr>
			<Th  align="center">Your request is being processed. Please wait ...............</Th>
		</Tr>
	</Table>
</Div>
<%

	}
	catch(Exception e)
	{
	
		out.println("<Br><Br><Br><Br><Center><H3> There is no output for passed    parameters </H3></Center>");//+e.getMessage());
%>
		<Div id="buttons" style="position:absolute;top:92%;width:100%;visibility:visible" align="center">
<%
		butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
		butActions.add("history.go(-1)");	
	        out.println(getButtons(butNames,butActions));

%>    
</Div>
<%		
	}	
}
else
{
%>
		<%@ include file="../Misc/ezDisplayHeader.jsp"%>
		<Br><Br><Br><Br>
		<Table width="50%" border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 align="center">
		<Tr align="center">
			<Th>No RFQs Exist With collective RFQ:<%=collNo%> in SAP.</Th>
		</Tr>
		</Table>
		<Br>
<Div id="buttons" style="position:absolute;top:95%;width:100%;visibility:visible" align="center">
<%
      butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
    	butActions.add("history.go(-1)");
   	  out.println(getButtons(butNames,butActions));
 	
   %> 	
</Div>
<%
}
	if(globalDisFlg)
		disableByUsrRole="";
	else
		disableByUsrRole="disabled";
		
	if(showSubmit)	
	{
%>
		<Script>
			var commentsDiv = document.getElementById("commentsDiv");
			var InnerBox1Div = document.getElementById("InnerBox1Div");
			if(commentsDiv != null)
			{
				commentsDiv.style.height = "60%"
			}	
			
			if(InnerBox1Div != null)
			{
				InnerBox1Div.style.height = "95%";
			}				
		</Script>
<%
	}
%>

<Div id="MenuSol"></Div>


</Form>
</Body>
</Html>	

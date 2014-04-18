<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Rfq/iListRFQByCollectiveRFQ.jsp" %>
<%@ include file="../../../Includes/JSPs/Rfq/iOfflineQuotationComparisionForm.jsp" %>
<%@ include file="../../../Includes/JSPs/Rfq/iExecuteQCFReport.jsp"%>
<Html>
<Head>
	<Script>
		var tabHeadWidth=90
		var tabHeight="75%"
		
	function showTrail(colno)
 	{
	 	var url="../Misc/ezOfflineWFAuditTrailList.jsp?wf_trail_type=QCF_RELEASE&wf_trail_list="+colno;
	 	var mywind=window.open(url,"ReportWin","width=700,height=300,left=150,top=150,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=no");
	}
 	
	</Script>
	<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
	<Script src="../../Library/JavaScript/Rfq/ezQCS.js"></Script>
	<Script src="../../Library/JavaScript/UploadFiles/ezOpenUploadWindow.js"></Script>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
</Head>
<Body  scroll=yes>
<Form name="myForm" method="post">
<input type=hidden name='PAGE' value='OFFLINE'>
<%
	String display_header 	= "";
	String totvend		= "";
	String quotedVen	= "";
	String notQuotedVend	= "";
	String vendNumber 	= "";
	String checkVendorNumber= "";
	String quoted 		= "";
	String Chkd 		= "";

	String materialNo 	= qcfRet.getFieldValueString(0,"MATNR");
	String collectiveRFQNo 	= qcfRet.getFieldValueString(0,"SUBMI");

	java.util.Hashtable quoteHash = (java.util.Hashtable)session.getValue("QUOTEHASH");
	if(quoteHash!=null)
	{
		String quotedStr=(String)quoteHash.get(collectiveRFQNo);
		if(quotedStr!=null)
		{
			java.util.StringTokenizer st=new java.util.StringTokenizer(quotedStr,"##");
			if(st.countTokens()>2)
			{
				totvend=(String)st.nextToken();
				quotedVen=(String)st.nextToken();
				notQuotedVend=(String)st.nextToken();
			}
		}
	}
	
	ReturnObjFromRetrieve myRetObj = new ReturnObjFromRetrieve(new String[]{"TITLE","VENDOR1","VENDOR2","VENDOR3","ALIGN"});
	String []TabHeaders 	= {"Quotation","Quantity","Vendor","Vendor Name","Country","Manufacturer","Currency","Basic Price/Unit-Cur","Basic Price/Unit(INR)","Excise/CVD % ","Central Sales Tax %  ","Local Sales Tax % ","Customs Duty % ","Exchange Rate","Basic Price(Val) INR","Landed Price/CIF(INR)","Landed Price/Unt(INR)","Rank (Landed P/Unit)","Delivery Terms","Terms of Payment","Valuation Type","Expiry Date"};
	String []TabVals 	= {"EBELN","KTMNG","LIFNR","VEND_NAME","COUNTRY","KOLIF","WAERS","NETPR_ORG","NETPR","EXCRT","RATE1","RATE2","RATE3","WKURS","ZWERT","EFFWR","PUNIT","RANK3","INCO1","ZBTXT","BWTAR","BNDDT"};
	String []TdAligns	= {"left","right","left","left","left","left","left","right","right","right","right","right","right","left","right","right","right","center","left","left","left","left","left"};
	int TabHeaderLen 	= TabHeaders.length;
	for(int i=0;i<TabHeaderLen;i++)
	{
		myRetObj.setFieldValue("TITLE",TabHeaders[i]);		
		for(int j=0;j<qcfCount;j++)
		{
			int appender = j+1;	
			myRetObj.setFieldValue("VENDOR"+appender,qcfRet.getFieldValueString(j,TabVals[i]));
			
		}
		myRetObj.setFieldValue("ALIGN",TdAligns[i]);
		myRetObj.addRow();
	}	
	int myRetObjCount= myRetObj.getRowCount();
	int myRetColCount= myRetObj.getColumnCount();
%>
	

	<input type=hidden name='actionNum'>
	<input type=hidden name='prevStatus'>
	<input type=hidden name=rejectToUser>	

	<input type=hidden name='QcfNumber' 	value='<%=collNo%>'>
	<input type=hidden name='type' 		value='<%=type%>'>
	<input type=hidden name='qcsCommentNo' 	value='<%=(qcsCount+1)%>'>
	<input type=hidden name='isdelegate' 	value='<%=isdelegate%>'>
	<input type=hidden name='nextPart'	value='<%=nextParticipant%>'>
	<input type=hidden name='templateVal' 	value='<%=newtemplet%>'>
	<input type=hidden name='lastPOPrice' 	value="<%=lastPOPrice%>">
	<input type=hidden name='lastPOCurr' 	value="<%=lastPOCurr%>">
	<input type=hidden name='initiator' 	value='<%=initiator%>'>

	<input type=hidden name='commentType' 	  value=''>
	<input type=hidden name='attachflag' 	  value=''>
	<input type=hidden name='attachString' 	  value=''>
	<input type=hidden name='hideBypassCount' value='-'>
	<input type=hidden name='byPassAllow' 	  value='-'>
	<input type=hidden name='filePaths' 	value=''>

	
	

	
	<Table align="center" width="100%" height='95%' border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
		<Tr valign=middle halign=middle> 
			<Td colspan=2 class=blankcell>
				<Table><Tr><Td>
					<Td align=center width="70%" class='blankcell'>
						<Font color='#F48417' face="Verdana" size=2><B>Quotation Comparision Form : <%=collectiveRFQNo%></B></Font>
					</Td>
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
				</Tr></Table>
			</Td>	
		</Tr>
		<Tr>
			<Td width="70%" height="95%" valign="bottom" class='blankcell'>
				<Div id="theads" align="left" style="width:100%">
				<Table id="tabHead" width="100%"  border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=3 cellSpacing=1>
					<Tr>
						<Th width="10%" align=left>Vendors Sent To</Th>
						<Td width="20%"><a href="javascript:showVendors('<%=collectiveRFQNo%>','A')"><%=totvend%></a></Td>
						<Th width="10%" align=left>Quoted Vendors</Th>
<%			
						if("0".equals(quotedVen.trim()))
						{
%>
							<Td width="20%"><%=quotedVen%></Td>					
<%
						}
						else
						{
%>
							<Td width="20%"><a href="javascript:showVendors('<%=collectiveRFQNo%>','Y')"><%=quotedVen%></a></Td>	
<%
						}
%>			
					</Tr>
					<Tr align="center" valign="middle">
					<Th align=right width=27%>Propose Vendor</Th>
<%
					for(int i=0;i<qcfCount;i++)
					{
						vendNumber = qcfRet.getFieldValueString(i,"LIFNR");
%>			
						<Th width=24% wrap>
							<Table width=100%>
								<Tr>
<%
								for(int k=0;k<myRetCnt;k++)
								{
									if((myRet.getFieldValueString(k,"RFQ_NO").trim().equals(qcfRet.getFieldValueString(i,"EBELN").trim())) && ("R".equals(myRet.getFieldValueString(k,"RELEASE_INDICATOR").trim())))
										Chkd ="checked";
								}
								if(!"disabled".equals(disableByUsrRole))
									globalDisFlg=true;
								int myRFQRank		=0;
								double  myRFQPrice	=0;
								String alertStat	="N";
								String myRFQCurr	=qcfRet.getFieldValueString(i,"WAERS");
								String myRFQUOM		=qcfRet.getFieldValueString(i,"BPRME");
								try
								{
									myRFQRank=Integer.parseInt(qcfRet.getFieldValueString(i,"RANK1"));
								}catch(Exception err){myRFQRank=0;}
								try
								{
									myRFQPrice=Double.parseDouble(qcfRet.getFieldValueString(i,"NETPR_ORG"));
								}catch(Exception err){myRFQPrice=0;}
								if(myRFQRank>1 && lastPODtlCount>0 && myRFQCurr.equals(lastPOCurr) && myRFQPrice>lastPOPrice )
									alertStat="Y";
%>				
								      <Th><input type=checkbox onClick="showConfirmAlert(this,'<%=vendNumber%>','<%=myRFQRank%>','<%=alertStat%>');" name=propose value="<%=qcfRet.getFieldValueString(i,"EBELN")%>" <%=Chkd%> <%=disableByUsrRole%>><B><a href = "javascript:funShowVndrDetails('<%=(String)session.getValue("SYSKEY")%>','<%=vendNumber%>')"><font color="white"><B><%=vendNumber%></B></a></Th>
								      <input type="hidden" name="myRFQRank" value="<%=myRFQRank%>">
								      <input type="hidden" name="myRFQPrice" value="<%=myRFQPrice%>">
								      <input type="hidden" name="myRFQCurr" value="<%=myRFQCurr%>">
								      <input type="hidden" name="myRFQUOM" value="<%=myRFQUOM%>">
								      <input type="hidden" name="alertStat" value="<%=alertStat%>">
								</Tr>
							</Table>
						</Th>
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
			
				<Div id="InnerBox1Div" style="overflow:auto;position:absolute;left:1%;width:100%;height:90%;">
				<Table id="InnerBox1Tab" width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
<%
	try
	{
		StringBuffer sb=new StringBuffer();
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
	                        sb.append(line);
			}
		}
		String str=sb.toString();
		str = str.substring(str.indexOf("</tr>")+5);
		str = str.substring(str.indexOf("</tr>")+5);
		int a=str.indexOf("</table>");
		out.println(str.substring(0,a));
	}catch(Exception e)
	{
		//out.println(e);
		out.println("<br><br><br><br><Center><H3>There is no output for passed parameters</H3></Center>");
	}
%>

<%	
	boolean submitionFlag=true;
	String subAlert="";
	for(int inc=0;inc<myRetObjCount;inc++)
	{
		for(int kim=0;kim<qcfCount;kim++)
		{
			if("Quotation".equals(myRetObj.getFieldValueString(inc,"TITLE")))
			{
%>
				<input type="hidden" name=allrfqs value='<%=qcfRet.getFieldValueString(kim,"EBELN")%>'>
<%
			}
			java.util.Date currentDayDate = new java.util.Date();
			currentDayDate.setHours(0);currentDayDate.setMinutes(0);currentDayDate.setSeconds(0);
			java.util.Date expiredDate=(Date)qcfRet.getFieldValue(kim,"BNDDT");
			if(expiredDate!=null)
			{
				expiredDate.setHours(23);expiredDate.setMinutes(59);expiredDate.setSeconds(0);
				if(expiredDate.compareTo(currentDayDate)<0)
				{
					submitionFlag=false;
				}
			}
		}
	}
	if(!submitionFlag)
	{
		if(showSubmit)
		{
			subAlert="You can't submit QCF,some of the RFQ's in list are expired";
		}
		else if(showApprove)
		{
			subAlert="You can't Approve QCF,some of the RFQ's in list are expired";
		}			
	}
	if(qcsCount > 0)
	{
%>	
		<Table width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>			
<%
		String displayStr ="";
		
		for(int i=0;i<qcsCount;i++)
		{
			if(i == 0)
			{
%>	
				<Tr><Th width=10%>User</Th><Th width=20%>Date</Th><Th width=70%>Comments</Th></Tr>
<%
			}
			displayStr = commentsRet.getFieldValueString(i,"QCF_COMMENTS");
			
%>				<Tr>
					<Td width=10% style="background-color='#EEF9FF'"><%=commentsRet.getFieldValueString(i,"QCF_USER")%></Td>
					<Td width=20% style="background-color='#EEF9FF'"><%=globalRet.getFieldValue(i,"QCF_DATE")%></Td>
					<Td width=70% style="background-color='#EEF9FF'" title='<%=displayStr%>'><%=displayStr%></TD>
				</Tr>
<%		
		}
%>
		</Table>		
<%	
	}
%>
	
	
</Div>
</Td>

<Td width="30%" height="550" valign="top" class='blankcell'>
	<Div align="left" id="commentsDiv" style="overflow:auto;position:absolute;width:100%;height:100%;">
	<Table width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
<%
	if(propPrices.size() > 0)
	{
%>		
		<Tr><Td>
		<Table border=0 width=100% cellSpacing=1>
		<Tr><Th width=60%>Total Proposed Value</Th>
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
		</Td></Tr>
		</Table>
		</Td></Tr>	
<%
	}	
		boolean textalign=true;
		if(!"100067".equals(actionCheck)) 
		{
			textalign=false;
			if(showTextAreas)
			{
	

				if(showStatus)
				{		
%>
					<Tr>
						<Td borderColorDark=#ffffff width=10%  align='center' class='blankcell'>
							<iframe src='../Rfq/ezShowQcfStatusInOffline.jsp?COLNO=<%=qcfRet.getFieldValueString(0,"SUBMI")%>&NETPR=<%=propsdValue.toString()%>&loginType=<%=loginType%>&requestFrom=OFFLINE' frameborder=0 <%=wfHrchyHeight%> width=100% scrolling=yes ></iframe>
						</Td>
					</Tr>	
<%
				}
%>
				<Tr>
					<Th align=left><input type=hidden name=remLen value="2000"><B><a href='javascript:commentsSpace()'><Font color=white>Comments</Font></a></B></Th>
				</Tr>
				<Tr>	
					<Td width=50% class='blankcell'>
						<textarea style='width:100%' rows=6 name=qcfComments onKeyDown="textCounter(document.myForm.qcfComments,document.myForm.remLen,2000);" onKeyUp="textCounter(document.myForm.qcfComments,document.myForm.remLen,2000);"></textarea>
						<input type=hidden name=remLen value="2000">
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
					<Td align="center" width=20% class='blankcell'>
						<select name="attachs" style="width:100%" <%=attachSize%> ondblclick='funOpenFile()'>
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
				<Td borderColorDark=#ffffff width=10%  align='center' class='blankcell'>
					<iframe src='../UploadFiles/ezQcfAttachments.jsp?docNum=<%=collNo%>&docType=QCF&requestFrom=OFFLINE' frameborder=0 height=90% width=100% scrolling=yes ></iframe>
				</Td>
			</Tr>	
<%			
		} 
		if(("VP".equals(userRole) || "PR".equals(userRole)) && !showApprove)
		{
%>
			<Tr>
				<Th align=left>
					<input type=checkbox name=bypass value='BYPASS' onclick="openByPassList(<%=qcfNetPrice%>,'<%=qcfQueryCount%>')"><B>ByPass Approvers</B>
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

<Div id="ButtonsDiv" style="position:absolute;top:95%;width:100%;" align="center">
<%
	butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");  
	butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Audit&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");  
	butActions.add("goBack('"+type+"')");
	//butActions.add("showAuditTrail()");							                  							
	butActions.add("showTrail("+collectiveRFQNo+")");	

	if(showApprove&&submitionFlag)		
	{
		butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;Approve&nbsp;&nbsp;&nbsp;&nbsp;"); 
		butActions.add("funSubmit('100067','"+qcfQueryCount+"')");
	}
	if(showSubmit&&submitionFlag)
	{
		butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;Submit&nbsp;&nbsp;&nbsp;&nbsp;"); 
		butActions.add("funSubmit('100066','"+qcfQueryCount+"')");

	}
	if(showReject)
	{
		butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;Reject&nbsp;&nbsp;&nbsp;&nbsp;"); 
		butActions.add("funSubmit('100068','"+qcfQueryCount+"')");

	}
	if(showRequote && (!"APPROVED".equals(wfStatus)))
	{
		butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;Requote&nbsp;&nbsp;&nbsp;&nbsp;"); 
		butActions.add("reQuote()");		
	}
	out.println(getButtons(butNames,butActions));
%>
</Div>

<Div id="msgDiv" style="position:absolute;top:95%;width:100%;visibility:hidden" align="center">
	<Table align="center" width="60%" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1>
		<Tr>
			<Th  align="center">Your request is being processed. Please wait ...............</th>
		</Tr>
	</Table>
</Div>
<%!
	public String ezCheckForNull(String str,String defStr)
	{
		if((str==null) || ("null".equals(str)) || ((str.trim()).length() == 0) || ("0".equals(str)))
			str = defStr;
		return str.trim();
	}
%>
<input type="hidden" name="wf_trail_list" value="<%=collectiveRFQNo%>">
<%
	if(globalDisFlg)
		disableByUsrRole="";
	else
		disableByUsrRole="disabled";
%>

<input type="hidden" name="proposeFlg" value="<%=disableByUsrRole%>">
<input type="hidden" name="lastModifiedDate" value="<%=lastModifiedDate%>">
</Form>
<Div id="MenuSol"></Div>
</Body>
</Html>	
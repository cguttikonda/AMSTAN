<%@ page import ="java.math.*,java.util.*,ezc.ezutil.*,ezc.ezparam.*" %>
<%//@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Jsps/Purorder/iBlockedOfflinePoLineItems.jsp"%>
<%@ include file="../../../Includes/Jsps/Labels/iBlockedPoLineItems_Labels.jsp"%>
<%@ include file="../../../Includes/Jsps/Misc/iGetVendorDesc.jsp"%>
<%
	String display_header  = poDetails_L;
%>

<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>

<Script src="../../Library/JavaScript/Purorder/ezPOLineItems.js"></Script>
<Script src="../../Library/JavaScript/UploadFiles/ezOpenUploadWindow.js"></Script>
<script language="javascript" type="text/javascript">
		var color = 0;
		var increment = 20;
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
			document.myForm.action= "ezShowHeaderText.jsp";
			newWindow=window.open("","PopUp","width=550,height=300,left=280,top=200,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=no");
			document.myForm.onsubmit = newWindow;
			document.myForm.submit();
		}
		function showItemText(indx)
		{
			document.myForm.target = "PopUp";
			document.myForm.action= "ezShowItemText.jsp?myIndx="+indx;
			newWindow=window.open("","PopUp","width=550,height=300,left=280,top=200,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=no");
			document.myForm.onsubmit = newWindow;
			document.myForm.submit();
		}
		function lastPODtlsWin(matNum)
		{
			var url="../Rfq/ezGetLastPODetails.jsp?matNumber="+matNum;
			var poDtlWin=window.open(url,"powin","width=850,height=650,left=100,top=120,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
		} 
		
		function showItemReport(indx)
		{
			var matNo,plant 
			var len = document.myForm.matNo.length
			
			if(isNaN())
			{
				matNo = document.myForm.matNo.value;
				plant = document.myForm.plant.value;				
			}	
			else
			{
				matNo = document.myForm.matNo[indx].value;
				plant = document.myForm.plant[indx].value;
			}	
				//alert("matNomatNomatNo		"+matNo)
			
			document.myForm.target = "PopUp";
			document.myForm.action= "../Reports/ezOffLineStockBucketReport.jsp?matNo="+matNo+"&plant="+plant+"&OffLine=Y";
			newWindow=window.open("","PopUp","width=1000,height=1000,left=0,top=0,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=no");
			document.myForm.onsubmit = newWindow;
			document.myForm.submit();
		}
	</script>
</head>
<Body scroll=yes>
<form  name="myForm" method="post">
<input type=hidden name='commentType' value=''>
<input type=hidden name='PAGE' value='OFFLINE'>
<input type=hidden name='QcfNumber' value='<%=Long.parseLong(poNum)%>'>
<input type=hidden name='isDelegate' value='<%=request.getParameter("ISDELEGATE")%>'>
<input type=hidden name='nextPart' 	value='<%=nextParticipant%>'>

<input type=hidden name='qcsCommentNo' value='<%=(qcsCount+1)%>'>
<input type=hidden name=rejectToUser>
<%//@ include file="../../../Offline/JSPs/ezOfflineDisplayHeader.jsp"%>
<%
	
	if (polines ==0)
	{
%>
		<br><br>
		<TABLE width="50%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
			<Tr align="center">
				<Th height="21"><%=noOrdLiPres_L%></Th>
			</Tr>
		</Table>
		
		<Div id="back"  align="center" style="position:absolute;width:100%;top:90%;visibility:visible">
			
<%  
	        butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");  
	        butActions.add("history.go(-1)");
	        out.println(getButtons(butNames,butActions));	
	        butNames.clear();
	        butActions.clear();
%> 
					
		</Div>
<%
	}
	else
	{
%>
		
	<input type=hidden name="attachflag">
	<input type="hidden" name="attachString">
        
         <Table align="center" width="100%" border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
          <Tr valign=middle halign=middle> 
           <Td align=center width="100%" class='blankcell'>
              <Font color='#083D65' face="Verdana" size=2><B>Purchase Order Details</B></Font>
            </Th>
          </Tr>
        </Table>     
    
         <Table align="center" width="95%" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=1 >
		<Tr>
				<Th align="left" colspan=6><img src='../../yellowarrow.gif'>&nbsp;&nbsp;Header Details</Th>	        
		</Tr>
        
		<Tr>
			<Th align="right">Purchase Order</Th>
			<Td><%=poNum%></Td>
			<Th align="right"><%=orderDate_L%></Th>
			<Td><%=orderDate%></Td>
			<Th align="right">QCF</Th>
			<Td>
<%
			if(!"N/A".equals(poconQCFNumber))
			{
%>
				<a href='javascript:SAPView(<%=poconQCFNumber%>)'><%=poconQCFNumber%></a>
<%
			}
			else
			{
				out.println(poconQCFNumber);
			}
%>
			</Td>
		</Tr>	
		<Tr>
			<th align="right">Payment Terms</th>
			<td><%=payTerms%></td>
			<th align="right">Inco Terms1</th>
			<td><%=incoTerms1%></td>
			<th align="right">Inco Terms2</th>
			<td><%=incoTerms2%></td>
		</Tr>	


			<Th align="right"><%=netValue_L%>[<%=currency%>]</Th>
			<Td ><%=netOrderAmount%>&nbsp;&nbsp;</Td>
			<Th align="right">Vendor</Th>
			<Td ><%=vendorNo%>[<%=venodorsHT.get(vendorNo.trim())%>]&nbsp;</Td>

			<th align="right">Text</th>
			<td>
			<input type="hidden" name="hText" value="<%=headerText%>">
			<a href="javascript:onClick=showHeaderText()">
			<img   src="../../Images/Buttons/<%=ButtonDir%>/edit-button.gif" border="none" valign=bottom style="cursor:hand">
			</a>
			</td>

			<input type="hidden" name="totContractVal" value="<%=tempNetamount%>">
			<input type="hidden" name="contractCurr" value="INR">
			<input type="hidden" name="contractUOM" value="<%=documentUOM%>">
					
					
		</Tr>
	</Table>
		
		<br>
		
		 <Table align="center" width="95%" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=1 >
		<Tr>
			<Th align="left" colspan=12><img src='../../yellowarrow.gif'>&nbsp;&nbsp;Item Details</Th>	        
		</Tr>
		<Tr>
			<Th width="5%" ><%=line_L%></Th>
      			<Th width="9%"><%=mat_L%></Th>
	      		<Th width="20%"><%=desc_L%></Th>
      			<Th width="6%"><%=uom_L%></Th>
	      		<Th width="8%"><%=orQty_L%></Th>
      			<Th width="9%"><%=price_L%></Th>
	      		<Th width="9%"><%=value_L%></Th>
     			<Th width="6%"><%=plant_L%></Th>
     			<Th width="9%">Agmt No</Th>
	      		<Th width="9%"><%=edDate_L%></Th>
	      		<Th width="4%">Text</Th>
	      		<Th width="6%">Report</Th>
		</Tr>
		
<%
			String bd = "";
			for(int i=0; i<polines; i++)
			{
				String lineNum 	= (String)dtlXML.getFieldValue(i, LINENO);
				String matNum 	= ((String)dtlXML.getFieldValue(i, MATERIAL)).trim();
				try
				{
					matNum=String.valueOf(Long.parseLong(matNum));
				}
				catch(Exception nfe){}
				String matDesc	= ((String)dtlXML.getFieldValue(i, MATDESC)).trim();
				
				String contract= dtlXML.getFieldValueString(i, "CONTRACT");
				String contractItem= dtlXML.getFieldValueString(i, "CONTRACTPOSITION");
				
				String myItemText=(String)itemTextHT.get(lineNum);
							
				if(myItemText==null || "null".equals(myItemText))
				myItemText="";
			

				if(contract==null || "null".equals(contract) ||"".equals(contract.trim())){
					contract="&nbsp;";
				}else{

					contract="<a href=../Rfq/ezGetAgrmtDetails.jsp?agmtNo="+contract+"&viewType=PO alt=View>"+contract+ "("+  contractItem + ")</a>";
				}
				
				
				
				String uom 	= (String)dtlXML.getFieldValue(i, UOM);
				String qty 	= dtlXML.getFieldValueString(i, ORDQTY);
				String plant 	= dtlXML.getFieldValueString(i, "PLANT");

				java.math.BigDecimal price1 = (java.math.BigDecimal)dtlXML.getFieldValue(i, PRICE);
				String price = dtlXML.getFieldValueString(i, AMOUNT);
				price = myFormat.getCurrencyString(price);
				if("JPY".equals(currency))
					price = (Double.parseDouble(replaceString(price,",",""))*100)+"";				
				double amnt = 0.0;
				try{
					amnt = Double.parseDouble(dtlXML.getFieldValueString(i, "NET_VALUE"));
				}catch(Exception e){}
				BigDecimal BD = new BigDecimal(amnt);
				bd = BD.toString();
				bd = myFormat.getCurrencyString(bd);
				
				String netAmount =dtlXML.getFieldValueString(i, AMOUNT);
		
				Date eDDate =(Date)dtlXML.getFieldValue(i, DDATE);
				String edDate = formatDate.getStringFromDate(eDDate,".",FormatDate.DDMMYYYY);

%>
	    			<Tr align="center">
	    				<input type="hidden" name="matNo" value="<%= matNum %>">
	    				<input type="hidden" name="plant" value="<%=plant%>">
			      		<Td width="5%" align="center"><%if(lineNum != null)out.println(lineNum); %></Td>
					<Td width="9%" title="Click here to view last 6 PO details for this material" align=center>
					<a href="JavaScript:lastPODtlsWin('<%= matNum %>')"><%= matNum %>&nbsp;</a></Td>
		    			<Td width="20%" align=center title="<%=matDesc%>"><%=matDesc%></Td>
					<Td width="6%" align=center><%=uom %>&nbsp;</Td>
					<Td width="8%" align="center"><%=qty%>&nbsp</Td>
					<Td width="9%" align="center"><%=price%>&nbsp
					</Td><Td width="9%" align="center"><%=bd%>&nbsp;</Td>
					<Td width="6%">
						<a href="Javascript:void(0)" onClick="goToPlantAddr('<%=plant%>')"  onMouseover="window.status='Click to view the Plant Address. '; return true" onMouseout="window.status=' '; return true">
							<%=plant%>
						</a>&nbsp;
					</Td>
					<Td width="9%" align="center"><%=contract%></Td>
    					<Td width="9%" align="center">&nbsp;
<%
					if(edDate.length() == 10)
					{
						if(dtlXML.getFieldValueString(i,"INDICATOR").equalsIgnoreCase("X"))
						{
%>							
							<a href="ezDelDetPO.jsp?orderNum=<%=dtlXML.getFieldValue(0,ORDER)%>&line=<%=lineNum%>&OrderDate=<%=dtlXML.getFieldValue(0,ORDDATE)%>"><%=edDate%></a>
<%			
						}
						else
						{
							out.println(edDate);
						}
					}
%>
					</Td>
					
					<td width="4%" align="center">
											
						<input type="hidden" name="iText" value="<%=myItemText%>">
						<a href="javascript:onClick=showItemText('<%=i%>')">
						<img   src="../../Images/Buttons/<%=ButtonDir%>/edit-button.gif" border="none" valign=bottom style="cursor:hand">
						</a>
											
											
					</td>
					<td width="6%" align="center">																					
						<a href="javascript:onClick=showItemReport('<%=i%>')">
						<img   src="../../Images/Buttons/<%=ButtonDir%>/stock_image.gif"  height=20 width=20 border="none" valign=bottom style="cursor:hand">
						</a>																																
					</td>
					
					
	  			</Tr>
<%
			}
%>
			</Table>
			
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
		<Br>
		<Table align="center" width="95%" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=1 >
		<Tr>
			<Th align="left" colspan=3><img src='../../yellowarrow.gif'>&nbsp;&nbsp;Comments</Th>	        
		</Tr>
<%
		String displayStr ="";
		for(int i=0;i<qcsCount;i++)
		{
			if(i == 0)
			{
%>	
				<Tr><Th width=10% align=left>User</Th><Th width=15% align=left>Date</Th><Th width=75% align=left>Comments</Th></Tr>
<%
			}
				displayStr = commentsRet.getFieldValueString(i,"QCF_COMMENTS");
%>				<Tr>
					<Td width=10% ><%=commentsRet.getFieldValueString(i,"QCF_USER")%></Td>
					<!--<Td width=10% ><%=formatDate.getStringFromDate((Date)commentsRet.getFieldValue(i,"QCF_DATE"),".",ezc.ezutil.FormatDate.DDMMYYYY)%></Td>-->
					<Td width=15% ><%=globalCmRet.getFieldValue(i,"QCF_DATE")%></Td>
					<Td width=75% title='<%=displayStr%>'><%=displayStr%></TD>
				</Tr>
<%		}
%>
		</Table>	
		
<%
	}
%>



 
<%                  
			if("Amend".equals(orderType.trim()))
  			{
%>
				<Br>
				<Table align="center" width="95%" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=1 >
				<Tr>
					<Th align=left ><input type=hidden name=remLen value="2000"><img src='../../yellowarrow.gif'>&nbsp;&nbsp;<B><a href="javascript:commentsSpace('../RFQ/ezQCFCommentSpace.jsp')"><Font color=white>Enter your comments here</Font></a></B></Th>
				</Tr>
				<Tr>	
					<Td  class='blankcell'>
						<textarea style='width:100%' rows=6 name=reasons onKeyDown="textCounter(document.myForm.reasons,document.myForm.remLen,2000);" onKeyUp="textCounter(document.myForm.reasons,document.myForm.remLen,2000);"></textarea>
						<input type=hidden name=remLen value="2000">
					</Td>
				</Tr>
				</Table>
<%
  			}
%>  			
			<BR><Table align="center" width="95%" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=1 >
			<Tr>
<%
			if("Amend".equals(orderType.trim()))
			{
%>
				<Th align="left" width=60%>
					<Table width=100%><Tr><Th align=left>
					<img src='../../yellowarrow.gif'>&nbsp;&nbsp;<a href="JavaScript:funAttach()" title="Click Here To Attach A File"><Font color="white"><B>Attach</B> </Font></a>
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
			if("Amend".equals(orderType.trim()))
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
				<iframe src='../UploadFiles/ezQcfAttachments.jsp?docNum=<%=poNum%>&docType=PO' frameborder=1 width=100% scrolling=auto scrolling=yes height='75'></iframe>
			</Td>
<%
			}
%>	
			</Tr>
			</Table>
		
		
		<input type="hidden" name="actionCode">
		
		<Div id="ButtonsDiv" align=center style="visibility:visible;width:100%;">
		<Table>
		<Tr>
			<Td  class='TDCommandBarBorder'>
<%  
		butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");  
		butActions.add("history.go(-1)");
%> 
			</Td>
<%
			if("Amend".equals(orderType))
			{
				if(showSubmit)
				{
%>
					<Td class='TDCommandBarBorder'>
					
<%  
		butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;Submit&nbsp;&nbsp;&nbsp;&nbsp;");  
		butActions.add("funSubmit('ezSubmitPurchaseOrder.jsp','100066','Submit','"+queryCheck+"')");

%> 					
					</Td>	
<%		
				}
				if(showReject)
				{
%>			
					<Td class='TDCommandBarBorder'>
<%  
		butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;Reject&nbsp;&nbsp;&nbsp;&nbsp;");  
		butActions.add("funSubmit('ezSubmitPurchaseOrder.jsp','100068','Reject','"+queryCheck+"')");

%> 			
		</Td>	
<%		
				}
				if(showRelease)
				{
%>
					<Td class='TDCommandBarBorder'>
					
<%  
		butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;Release&nbsp;&nbsp;&nbsp;&nbsp;");  
		butActions.add("funSubmit('ezReleasePurchaseOrder.jsp','100080','Release','"+queryCheck+"')");

%> 					
		</Td>
<%
				}
%>				
				
				
<%	
				
			}	
			else if(!"QUERY_DETAILS".equals(orderType))
			{
%>
			
		<Td class='blankcell'>
					
<%  
		butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;Print Version&nbsp;&nbsp;&nbsp;&nbsp;");  
		butActions.add("formEvents('ezPrint.jsp')");

%> 						
 		</Td>
<%
			}
%>
			<Td class='TDCommandBarBorder'>
<%
			butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;WF Hierarchy&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
			butActions.add("showStatusWindow('"+poNum+"','"+tempNetamount+"','N','PO','"+vendorNo+"')");
%>	
			</Td>
				<Td class='TDCommandBarBorder'>
			<%
			butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Query&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
			butActions.add("funOpenWin('"+poNum+"','"+vendorNo+"','PO')");
			%>				
				
				</Td>
			<Td>
<%
				butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Amendment Details&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
				butActions.add("getAmndPODtl('"+poNum+"')");	
%>
			</Td>
<%			
			out.println(getButtons(butNames,butActions));	
			butNames.clear();
			butActions.clear();

%>
		</Tr>	
		</Table>
		</Div>
		
		<Div id="msgDiv" style="width:100%;visibility:hidden" align="center">
			<Table align="center" width="60%" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
				<Tr>
					<Th  align="center">Your request is being processed. Please wait ...............</Th>
				</Tr>
			</Table>
		</Div>
	
		<input type=hidden name="chk1" value="<%=poNum%>">
		<input type="hidden"  name="POrCON" value="<%=POORCONTRACT%>" >
		<input type='hidden' name='type' value='<%=orderType%>' >
		<input type="hidden" value="<%=poNum%>" name="PurchaseOrder">
		<input type="hidden" name="OrderDate" value="<%=orderDate%>">
		<input type="hidden" name="POPrice" value="<%=bd%>">
		<input type="hidden" name="myIndx">
<%
	}
%>
</form>
<Div id="MenuSol"></Div>
</body>
</html>

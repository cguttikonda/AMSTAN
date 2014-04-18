<%@ include file="../../Library/Globals/errorPagePath.jsp" %>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<%@ include file="../../../Includes/Jsps/Misc/iblockcontrol.jsp" %>
<%@ include file="../../../Includes/JSPs/Rfq/iGetOfflineAgreementDetails.jsp" %>
<html>
<head>
<Title>Contract Details for <%=agmtNo%></Title>
<Script>
	var tabHeadWidth=90
	var tabHeight="35%"
</Script>
<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
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
	function ezConBack()
	{
	document.myForm.action = '../Purorder/ezListOfflineBlockedContracts.jsp?type=Contract'
	document.myForm.submit();
	}
	function ezNavBack()
	{
		document.myForm.action = '<%=navigateFileName%>'
		document.myForm.submit();
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
<Body scroll=yes>
<Form name="myForm">
<%//@ include file="../../../Offline/JSPs/ezOfflineDisplayHeader.jsp"%>
<%
    if(cnt>0)
    {
 %>    
        <input type="hidden" name='commentType'   value=''>
        <input type="hidden" name='QcfNumber'     value='<%=Long.parseLong(agmtNo)%>'>
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
        <input type="hidden" name="viewType" value='UNREL'>
        <input type="hidden" name="POORCONTRACT" value='CON'>
        <input type="hidden" name="RQSTFROM" value='PORTAL'>
        
        <input type=hidden name=rejectToUser>
	<input type=hidden name="attachflag">
	<input type="hidden" name="attachString">
	<input type="hidden" name="myIndx">
        
        
  	<Table align="center" width="100%" border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
          <Tr valign=middle halign=middle> 
           <Td align=center width="100%" class='blankcell'>
              <Font color='#083D65' face="Verdana" size=2><B>Contract Details</B></Font>
            </Th>
          </Tr>
        </Table>	
 
        
        <Table align="center" width="95%" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=1 >
	<Tr>
		<Th align="left" colspan=8><img src='../../yellowarrow.gif'>&nbsp;&nbsp;Header Details</Th>	        
	</Tr>
        
        <Tr> 
          <Th align="left" width="12%">No. </Th>
          <Td width="10%"><%=agmtNo%></Td>
          <Th align="left" width="15%">Type</Th>
          <Td width="20%"><%=conType%></Td>
          <Th align="left" width="15%">Contract Date</Th>
           <Td width="10%"><%=fd.getStringFromDate((Date)ConHeader.getFieldValue(0,"CREATED_ON"),".",ezc.ezutil.FormatDate.DDMMYYYY)%></Td>
          <Th align="left" width="15%">End Date</Th>
          <Td width="10%"><%=fd.getStringFromDate((Date)ConHeader.getFieldValue(0,"VPER_END"),".",ezc.ezutil.FormatDate.DDMMYYYY)%></Td
        </Tr>
        <Tr> 
          <Th align="left">QCF</Th>
          <Td><%=poconQCFNumber%></Td>
          <Th align="left">Currency</Th>
          <Td>
          	<%=ConHeader.getFieldValueString(0,"CURRENCY")%>
          	<input type="hidden" name="contractCurr" value="<%=ConHeader.getFieldValueString(0,"CURRENCY")%>">
          </Td>
          <Th align="left">Vendor</Th>
          <Td ><input type=text size=50 value='<%=ConHeader.getFieldValueString(0,"VENDOR")%>(<%=ConHeader.getFieldValueString(0,"VEND_NAME")%>)' title='<%=ConHeader.getFieldValueString(0,"VENDOR")%>(<%=ConHeader.getFieldValueString(0,"VEND_NAME")%>)' class="tx"  readonly></Td>
          <Th align="left">Text</Th>
	  <td>
	  <input type="hidden" name="hText" value="<%=headerText%>">
	  <a href="javascript:onClick=showHeaderText()">
	  <img   src="../../Images/Buttons/<%=ButtonDir%>/edit-button.gif" border="none" valign=bottom style="cursor:hand">
	  </a>
	  </td>
        </Tr>
        </Table>
  
        <Br>
<%
        String material   = "";
        String displayStr = "";
        Hashtable poMaterials=new Hashtable();
        if(ConItemsCnt>0)
        {
%>	
            <Table align="center" width="95%" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=1 >
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
            
            java.math.BigDecimal totContractVal=new java.math.BigDecimal(0.0);
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
              
              material = ConItems.getFieldValueString(c,"MATERIAL");
              
              try{
              		if(conType.indexOf("WK") != -1){
              			totContractVal=totContractVal.add(new java.math.BigDecimal(targetData));
              			
              		}else{
              			totContractVal=totContractVal.add(new java.math.BigDecimal(targetData).multiply(new java.math.BigDecimal(ConItems.getFieldValueString(c,"NET_PRICE"))));
              		}
              		
              		if("".equals(contractUOM)){
              			contractUOM=ConItems.getFieldValueString(c,"ORDERPR_UN");
              		}else if(!contractUOM.equalsIgnoreCase(ConItems.getFieldValueString(c,"ORDERPR_UN"))){
              			contractUOM="MLUOM";
              		}
              		
              	
              }catch(Exception err){}
              try{
                  material = String.valueOf(Integer.parseInt(material));	
              }catch(Exception e){}
              poMaterials.put(agmtNo+ConItems.getFieldValueString(c,"PO_ITEM"),material);
              String myItemText=(String)itemTextHT.get(ConItems.getFieldValueString(c,"PO_ITEM"));
	      if(myItemText==null || "null".equals(myItemText))
	      myItemText="";
              
              
%>
              <Tr align="center"> 
                <Td width="10%" align="center"><%=ConItems.getFieldValueString(c,"PO_ITEM")%>&nbsp;</Td>
                <Td width="15%" align="center"><%=material%>&nbsp;</Td>
                <Td width="25%" align="center"><%=ConItems.getFieldValueString(c,"SHORT_TEXT")%>&nbsp;</Td>
                <Td width="15%" align="center"><%=targetData%>&nbsp;</Td>
                <Td width="13%" align="center"><%=ConItems.getFieldValueString(c,"NET_PRICE")%>&nbsp;</Td>
                <Td width="8%" align="center"><%=ConItems.getFieldValueString(c,"ORDERPR_UN")%>&nbsp;</Td>
                <Td width="10%" align="center"><%=ConItems.getFieldValueString(c,"PLANT")%>&nbsp;</Td>
                <Td width="4%" align="center">
                <input type="hidden" name="iText" value="<%=myItemText%>">
		<a href="javascript:onClick=showItemText('<%=c%>')">
		<img   src="../../Images/Buttons/<%=ButtonDir%>/edit-button.gif" border="none" valign=bottom style="cursor:hand">
		</a>
                </Td>
                
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
             <BR> <Table align="center" width="95%" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=1 >
	      	<Tr>
	      		<Th align="left" colspan=3><img src='../../yellowarrow.gif'>&nbsp;&nbsp;Comments</Th>	        
		</Tr>
<%
                  for(int i=0;i<qcsCount;i++)
                  {
                    if(i == 0)
                    {
%>	
                      <Tr><Th width=10% align=left>User</Th><Th width=15% align=left>Date</Th><Th width=75% align=left>Comments</Th></Tr>
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
                  <BR> <Table align="center" width="95%" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=1 >

			<Tr>
				<Th align=left colspan=4><input type=hidden name=remLen value="2000"><img src='../../yellowarrow.gif'>&nbsp;&nbsp;<B><a href="javascript:commentsSpace('ezQCFCommentSpace.jsp')"><Font color=white>Enter your comments here </Font></a></B></Th>
			</Tr>
			<Tr>	
				<Td colspan=4 class='blankcell'>
					<textarea style='width:100%' rows=6 name=reasons onKeyDown="textCounter(document.myForm.reasons,document.myForm.remLen,2000);" onKeyUp="textCounter(document.myForm.reasons,document.myForm.remLen,2000);"></textarea>
					<input type=hidden name=remLen value="2000">
				</Td>
			</Tr>
 			

			<Tr>
		</Table>
		<BR>

			<Table align="center" width="95%" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=1 >
			<Th align="left" width=60%>
				<Table width=100%><Tr><Th align=left><img src='../../yellowarrow.gif'>&nbsp;&nbsp;
				<a href="JavaScript:funAttach()" title="Click Here To Attach A File"><Font color="white"><B>Attach</B> </Font></a>
				</Th><Th align=right>
				<a href="JavaScript:funRemove()" title="Click Here To Remove Attached File"><Font color="white"><B>Remove</B> </Font></a>
				</Th></Tr></Table>
			</Th>
<%
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
			
			<Td align="center" width=60% class='blankcell' >
				<select name="attachs" style="width:100%" size=5 ondblclick='funOpenFile()'>
				</select>
			</Td>
<%
			
			if(noOfDocs>0)
			{			
%>
			<Td borderColorDark=#ffffff width=40% align='center' class='blankcell'>
				<iframe src='../UploadFiles/ezQcfAttachments.jsp?docNum=<%=agmtNo%>&docType=CONT' frameborder=1 width=100% scrolling=auto scrolling=yes height='75'></iframe>
			</Td>
<%
			}
%>	
			</Tr>
			</Table>
				
      	    
     	    <BR><BR>
     	    
            <Div id="ButtonsDiv" style="width:100%;visibility:visible" align="center">
            <Table align=center width="100%" border=0 borderColorDark=#ffffff borderColorLight=#000000  cellspacing="0" cellpadding="2">
            <Tr>
              <Td class=TDCommandBarBorder align=center>
<%  
		butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");  
		butActions.add("ezConBack()");
%>               
		</Td>
             
<%              
                if(showSubmit)
                {
%>
		 <Td class=TDCommandBarBorder align=center>
<%  
			butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;Submit&nbsp;&nbsp;&nbsp;&nbsp;");  
			butActions.add("funSubmit('../PurOrder/ezSubmitPurchaseOrder.jsp','100066','Submit','"+queryCheck+"')");
%>               
		</Td>
                   
<%
                }
                if(showReject)
                {
%>     
		 <Td class=TDCommandBarBorder align=center>
<%  
			butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;Reject&nbsp;&nbsp;&nbsp;&nbsp;");  
			butActions.add("funSubmit('../PurOrder/ezSubmitPurchaseOrder.jsp','100068','Reject','"+queryCheck+"')");
%>               
		</Td>
<%            
                }          
                if(showRelease)
                {
%>
		<Td class=TDCommandBarBorder align=center>
<%  
			butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;Release Order&nbsp;&nbsp;&nbsp;&nbsp;");  
			butActions.add("funSubmit('../PurOrder/ezReleasePurchaseOrder.jsp')");
%>               
		</Td>
                    <!-- <img src="../../Images/Buttons/<%=ButtonDir%>/releaseorder.gif" border="none" style="cursor:hand" onClick='funSubmit("../PurOrder/ezReleasePurchaseOrder.jsp")'>-->
<%
                }

			
%>
			<Td>
<%
				butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;WF Hierarchy&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
				butActions.add("showStatusWindow('"+agmtNo+"','"+netOrderAmount+"','N','CON','"+vndr+"')");	
%>
			</Td>
			<Td>
<%
				butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Query&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
				butActions.add("funOpenWin('"+agmtNo+"','"+vndr+"','CON')");	
%>
			</Td>			
			
			<Td>
<%
				butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Amendment Details&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
				butActions.add("getAmndPODtl('"+agmtNo+"')");	
%>
			</Td>
			
<%                
                	out.println(getButtons(butNames,butActions));	
			butNames.clear();
			butActions.clear();
%>			
                </Td>
            </Tr>
          </Table>
          </Div>
		
          <Div id="msgDiv" style="position:absolute;top:90%;width:100%;visibility:hidden" align="center">
          <Table align="center" width="60%" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
          <Tr>
            <Th  align="center">Your request is being processed. Please wait ...............</Th>
          </Tr>
          </Table>
          </Div>
           <input type="hidden" name="totContractVal" value="<%=totContractVal.toString()%>">
           <input type="hidden" name="contractUOM" value="<%=contractUOM%>">
           
<%
        }
    }
    else
    {
%>
      <div style="position:absolute;top:40%;width:100%;visibility:visible" align="center">
      <Table id="header" align=center width="60%" border=0 borderColorDark=#ffffff borderColorLight=#000000  cellspacing="0" cellpadding="2">
			<Tr>
        <Th>Contract Details Not Found</Th>
			</Tr>
			</Table>
      </div>
      <div id="buttons" style="position:absolute;top:90%;width:100%;visibility:visible" align="center">
<%  
	butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");  
	butActions.add("ezNavBack()");
	out.println(getButtons(butNames,butActions));	
	butNames.clear();
	butActions.clear();
%>  
      </div>
<%
    }
%>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
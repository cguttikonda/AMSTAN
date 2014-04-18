<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iShipmentDetails_Labels.jsp"%>
<%@ include file="../../../Includes/JSPs/Shipment/iModeOfTransport.jsp" %>
<%@ include file="../../../Includes/JSPs/Shipment/iEditShipmentDetails.jsp" %>
<%@ page import="ezc.ezutil.*,java.util.*,java.text.*" %>
<html>
<head>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<Script>
	var tabHeadWidth=94
	var tabHeight="40%"
</Script>   
<script src="../../Library/JavaScript/ezTabScroll.js"></Script> 
<%@ include file="../../../../EzCommon/Includes/iShowCal.jsp"%>
<script src="../../Library/JavaScript/ezTrim.js"></script>
<script>
		var refdGtSdt_L = '<%=refdGtSdt_L%>'
		var invdGteSdt_L = '<%=invdGteSdt_L%>'
		var sdtGteOdt_L = '<%=sdtGteOdt_L%>'
		var arrdtGteSdt_L = '<%=arrdtGteSdt_L%>'
		var arrdtGteTdt_L = '<%=arrdtGteTdt_L%>'
		var refdLteSdt_L = '<%=refdLteSdt_L%>'
		var plzVldQty_L = '<%=plzVldQty_L%>'
		var plzQtyZero_L = '<%=plzQtyZero_L%>'
		var plzEnRdcno_L = '<%=plzEnRdcno_L%>'
		var plzEnRdcdt_L = '<%=plzEnRdcdt_L%>'
		var plzEnInvNo_L = '<%=plzEnInvNo_L%>'
		var plzEnInvdt_L = '<%=plzEnInvdt_L%>'
		var plzEnLrno_L = '<%=plzEnLrno_L%>'
		var plzShDate_L = '<%=plzShDate_L%>'
		var plzEnCrrn_L = '<%=plzEnCrrn_L%>'
		var plzExparrDt_L = '<%=plzExparrDt_L%>'
		var plzEnShdet_L = '<%=plzEnShdet_L%>'
		var plzEnShOneDet_L = '<%=plzEnShOneDet_L%>'
		var plzShLine_L = '<%=plzShLine_L%>'
		var plzAtlOneSh_L = '<%=plzAtlOneSh_L%>'
		var plsActDel_L = '<%=plsActDel_L%>'
		var thisDelBatch_L = '<%=thisDelBatch_L%>'
	
</script>
<script src="../../Library/JavaScript/ezShipValidations.js"></script>
<script src="../../Library/JavaScript/ezConvertDates.js"></Script>
<%
	String poDate="";
	String ss="";
	String orderDate="";
	ezc.ezutil.FormatDate fd = new ezc.ezutil.FormatDate();
	if (retHead.getRowCount () > 0)
	{
		Date dd=new Date();
		ss=fd.getStringFromDate(dd,(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
		orderDate=fd.getStringFromDate((java.util.Date)retHead.getFieldValue(0,"PO_DATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
	}
%>
<script>
	 dateFormat='<%=Integer.parseInt((String)session.getValue("DATEFORMAT"))%>';
	function formEvents(obj)
	{
		var flg3=false;
		var flg2=false;
		
		flg1=validateFields();
		if(flg1)
		{
			var ss=ConvertDate('<%=ss%>','<%=Integer.parseInt((String)session.getValue("DATEFORMAT"))%>')
			var orderDate=ConvertDate('<%=orderDate%>','<%=Integer.parseInt((String)session.getValue("DATEFORMAT"))%>')

			flg3=funDateCheck(ss,orderDate);
		}
		if (flg1&&flg3)
		{
			if(!funValidateQty())
				return;
			if(confirm('<%=donotSub_L%>'))
			{
				//document.getElementById("ButtonDiv").style.visibility="hidden"  //by suresh	
				//document.getElementById("msgDiv").style.visibility="visible"    //for msg displaying
				document.myForm.status.value="N";
				if(document.myForm.shipflag.value=="")
				{
					document.myForm.shipflag.value="N";
				}
				document.myForm.RqstType.value="SAVE";
				
				
				
				document.myForm.action="ezUpdateShipmentDetails.jsp";
				document.myForm.submit();
			}
			
			document.forms[0].DeliveryChallan.focus();
		}
	}
	
	function getQty(i){
		//////NA§NA§NA§30§NA§µNA§NA§NA§40§NA§-->70
		/////NA§NA§NA§30§NA§-->30
		var len = document.myForm.batches.length;
		var addedQty = 0.00; 
		
		if(isNaN(len)){
			var batch =  document.myForm.batches.value;
			var lines= batch.split("µ");
			for(var k=0;k<lines.length;k++){
				allbatchs = lines[k].split("§");
				//////alert(allbatchs+"-------->"+allbatchs[3])
				if(!isNaN(parseFloat(allbatchs[3])))
					addedQty = parseFloat(addedQty)+parseFloat(allbatchs[3]);
			}
		}
		else{
			
			try{
				var batch = document.myForm.batches[i].value;
				var lines= batch.split("µ");
				for(var k=0;k<lines.length;k++){
					allbatchs = lines[k].split("§");
					//////alert(allbatchs+"-------->"+allbatchs[3])
					if(!isNaN(parseFloat(allbatchs[3])))
						addedQty = parseFloat(addedQty)+parseFloat(allbatchs[3]);
				}		
			}catch(e){}

		}
		
		return addedQty;
	}
	function funValidateQty(){
		var chkr = document.myForm.Quantity.length;
		var Quantity = 0.0;
		var displayQty = 0.0;
		var lineItem;
		var flag = true;
		

		if(isNaN(chkr)){

				Quantity = getQty('1');
				displayQty = document.myForm.tobedelqty.value;
				lineItem = document.myForm.Line.value;
				if(parseFloat(Quantity)>parseFloat(displayQty)){
					alert('<%=plzChkGvnQty_L%>'+lineItem);
					return false;
					
					
				}
		}
		else{
			for(i=0;i<chkr;i++)
			{
				
				Quantity = getQty(i);
				displayQty = document.myForm.tobedelqty[i].value;
				lineItem = document.myForm.Line[i].value;
				
				if(parseFloat(Quantity)>parseFloat(displayQty)){
					alert('<%=plzChkGvnQty_L%>'+lineItem);
					return false;

				}	

			}
		}
		
		return true;
		
	}
	
		
	function doSendMailConfirm(obj)
	{
		flg2=false;
		flg3=false;
		flg1=validateFields();
		if(flg1)
		{
			var ss=ConvertDate('<%=ss%>','<%=Integer.parseInt((String)session.getValue("DATEFORMAT"))%>')
			var orderDate=ConvertDate('<%=orderDate%>','<%=Integer.parseInt((String)session.getValue("DATEFORMAT"))%>')

			flg3=funDateCheck(ss,orderDate);
		}
		if (flg1&&flg3)
			flg2= funBatchCheck();
		if (flg1&&flg2)
		{
			//document.getElementById("ButtonDiv").style.visibility="hidden"  //by suresh
			//document.getElementById("msgDiv").style.visibility="visible"    //for msg displaying
			document.myForm.status.value="Y";
			
			if(document.myForm.shipflag.value=="")
			{
				document.myForm.shipflag.value="N";
			}
			
			if(!funValidateQty())
				return;
			document.myForm.sendMail.value="Yes";
			document.myForm.RqstType.value="SUBMIT";
			document.myForm.action="ezUpdateShipmentDetails.jsp";
			setMessageVisible();
			document.myForm.submit();
		}
	}

var totalbatches;
function addBatches(index)
{

	var args="";
	var lineNo="";
	var matdesc="";
	var Qtytobeship="";
	var batches="";
	var uom="";
	var sfiles="";
	if(isNaN(document.myForm.UOM.length))
	{
		//alert("ISNAN")
		lineNo=document.myForm.Line.value;
		matdesc=document.myForm.matdesc.value;
		uom=document.myForm.UOM.value;
		Qtytobeship=document.myForm.tobedelqty.value;
		displayQty=document.myForm.displayQty.value;
		sfiles=document.myForm.serverfiles.value;
		if(document.myForm.batches.value!="")
		{
			batches=escape(document.myForm.batches.value);
			args=lineNo+"¤"+matdesc+"¤"+uom+"¤"+batches;
		}
		else
		{
			args=lineNo+"¤"+matdesc+"¤"+uom;
		}
	}
	else
	{
		//alert("ELSE")
		lineNo=document.myForm.Line[index].value;
		sfiles=document.myForm.serverfiles[index].value;
		matdesc=document.myForm.matdesc[index].value;
		uom=document.myForm.UOM[index].value;
		Qtytobeship=document.myForm.tobedelqty[index].value;
		displayQty=document.myForm.displayQty[index].value;
		if(document.myForm.batches[index].value!="")
		{
			//alert("NEQ")
			batches=escape(document.myForm.batches[index].value);
			//alert(batches)
			args=lineNo+"¤"+matdesc+"¤"+uom+"¤"+batches;
		}
	    	else
		{
			//alert("EQL")
			args=lineNo+"¤"+matdesc+"¤"+uom;
		}
	}

///added for coa

	var dcno=document.myForm.DeliveryChallan.value;
	var dcdate=document.myForm.DCDate.value;
	if(dcno=="")
	{
		dcno="-";
	}
	if(dcdate=="")
	{
		dcdate="-";
	}
	if(isNaN(document.myForm.UOM.length))
	{
		coastr=dcno+"¤"+document.myForm.matdesc.value+"¤"+dcdate;
	}
	else
	{
		coastr=dcno+"¤"+document.myForm.matdesc[index].value+"¤"+dcdate;
	}
	var type=document.myForm.Type.value;
	
	//alert(args)
	
	specChrsStr = "#&";
	function spChar(strkey){
		var nLength=specChrsStr.length;
		for(nLoop=0;nLoop<nLength;nLoop++){
			pChar=specChrsStr.charAt(nLoop);
			if (strkey.indexOf(pChar)>0){
				strkey 	= strkey.replace(pChar,"¥");
			}
		}
		return 	strkey;	
	}
	/*if(args.indexOf("#") != -1)
	{
		args 	= args.replace("#","¥");
		coastr 	= coastr.replace("#","¥");
	}
	if(args.indexOf("&") != -1){
		args 	= args.replace("&","¥");
		coastr 	= coastr.replace("&","¥");
	}*/
	args 	= spChar(args);
	coastr 	= spChar(coastr);
	
	totalbatches= window.open("ezEditShipQty.jsp?args="+args+"&Qtytobeship="+Qtytobeship+"&index="+index+"&sfiles="+sfiles+"&rowCount=<%=retCount%>"+"&coastr="+coastr+"&displayQty="+displayQty+"&type="+type,"UserWindow","width=700,height=470,left=50 top=50,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no");
}

var attach;
function openUploadWindow()
{
	var filestring=document.myForm.shipuploads.value
	var serverfiles=document.myForm.shipserverfiles.value;
	attach=window.open("ezEditAttachmentFile.jsp?filestring="+filestring+"&serverfiles="+serverfiles,"UserWindow1","width=420,height=330,left=150,top=100,resizable=no,scrollbars=yes,toolbar=no,menubar=no");
}

function funUnLoad()
{
	if(totalbatches!=null && totalbatches.open)
	{
		totalbatches.close();
	}
	if(attach!=null && attach.open)
	{
		attach.close();
	}
}
</script>
</head>
<body onLoad="scrollInit()" onResize="scrollInit()" scroll=no onUnLoad="funUnLoad()">
<form name="myForm" method="post" onSubmit="return false">
<input type="hidden" name="status">
<input type="hidden" name="shipId" 	value="<%=shipid%>">
<input type="hidden" name=sendMail 	value="No">
<input type="hidden" name="baseValue" 	value="<%= ponum %>" >
<input type="hidden" name="base" 	value="<%= base %>" >
<input type="hidden" name="OrderValue" 	value="<%= OrderValue %>" >
<input type="hidden" name="currency" 	value="<%= currency%>" >
<input type="hidden" name="orderCurrency" value="<%= orderCurrency%>" >
<input type="hidden" name="orderBase" value="<%=orderBase%>" >


<%
	String modeCode = "";
	String modeDesc = "";
	String dcno     = "";
	String selected = "";
	if (retHead.getRowCount () > 0)
	{
		poDate=fd.getStringFromDate((java.util.Date)retHead.getFieldValue(0,"PO_DATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
		String display_header = shpDetPoNo_L+" :"+Long.parseLong(ponum)+"/"+poDate;
		modeCode = "";
		modeDesc = "";
		java.util.Enumeration modeEnum = modeHash.keys();
		int modeCount = modeHash.size();		
%>
		<%@ include file="../Misc/ezDisplayHeader.jsp" %>

		<BR>
		<Table width="94%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
			<tr valign="middle">
				<th align="left" width="25%"><%=modeOfTra_L%></th>
				<td  align="left" width="25%">
					<!--<input type="text" name="DeliveryChallan" class=InputBox tabindex="1" maxlength="30" value="<%//=retHead.getFieldValue(0,"DC_NR")%>">-->
					<Select name="DeliveryChallan" style="width:100%" id="ListBoxDiv1">
					<option value=''>Select</option>
<%					
					dcno = retHead.getFieldValueString(0,"DC_NR");
					for(int i=0;i<modeCount;i++)
					{
						modeCode = (String)modeEnum.nextElement();
						modeDesc = (String)modeHash.get(modeCode);
						if(dcno.equals(modeCode))
							selected = "selected";
						else
							selected = "";
%>
						<option value='<%=modeCode%>' <%=selected%>><%=modeDesc%></option>;
<%
					}
%>					
					</Select>					
				</td>
				<th align="left" width="25%"><%=dNoteDate_L%></th>
				<Td width="25%">
<%
					String dcDate="";
					if (retHead.getFieldValue(0,"DC_DATE")!=null)
						dcDate=fd.getStringFromDate((java.util.Date)retHead.getFieldValue(0,"DC_DATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
%>
					<input type="text" readonly class=InputBox name="DCDate" size=12 onfocus=this.blur() value ="<%=dcDate%>">
					<%//=getDateImage("DCDate")%>
				</td>
	    		</tr>
		    	<tr>
				<th align="left" width="25%"><%=invno_L%></th>
				<td width="25%">
<%
					String invNum="";
					if (retHead.getFieldValue(0,"INV_NUM")!=null)
						invNum=retHead.getFieldValueString(0,"INV_NUM");
%>
					<input type="text" name="InvoiceNo" class=InputBox tabindex="2" maxlength="20" value="<%=invNum%>">
				</td>
				<th align="left" width="25%"><%=invdate_L%></th>
				<td width="25%">
<%
					String invDate="";
					if (retHead.getFieldValue(0,"INV_DATE")!=null)
						invDate=fd.getStringFromDate((java.util.Date)retHead.getFieldValue(0,"INV_DATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
						if(invDate.equals("01.01.1900"))
							invDate="";
%>
					<input type="text" name="InvoiceDate" class=InputBox  size=12 readonly onfocus=this.blur() value="<%=invDate%>">
					<%=getDateImage("InvoiceDate")%>
				</td>
			</tr>
			<tr>
				<th align="left" width="25%"><%=lrbrno_L%> </th>
				<td width="25%">
					<input type="text" name="LR" tabindex="3" class=InputBox maxlength="30" value ="<%=retHead.getFieldValue(0,"LR_RR_AIR_NR")%>">
				</td>
				<th align="left" width="25%"><%=shipdate_L%></th>
				<td width="25%">
<%
					String shipDate="";
					if (retHead.getFieldValue(0,"SHIPMENT_DATE")!=null)
						shipDate=fd.getStringFromDate((java.util.Date)retHead.getFieldValue(0,"SHIPMENT_DATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
%>
					<input type="text"  name="ShipDate"  class=InputBox size=12  value="<%=shipDate%>" readonly onfocus=this.blur()>
					<%=getDateImage("ShipDate")%>
				</td>
			</tr>
			<tr>
				<th align="left" width="25%"><%=caname_L%></th>
				<td width="25%">
					<input type="text" name="CarrierName" class=InputBox tabindex="4" maxlength="50" value="<%=retHead.getFieldValue(0,"CARRIER")%>">
				</td>
				<th width="25%" align="left"><%=expardate_L%> </th>
				<td width="25%">
<%
					String arrDate="";
					if (retHead.getFieldValue(0,"EXP_ARIVAL_TIME")!=null)
						arrDate=fd.getStringFromDate((java.util.Date)retHead.getFieldValue(0,"EXP_ARIVAL_TIME"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
%>
					<input type="text"  name="ExpectedArivalTime" class=InputBox  size=12 readonly value="<%=arrDate%>" onfocus=this.blur()>
					<%=getDateImage("ExpectedArivalTime")%>
				</td>
			</tr>
			<Tr>
				<th align="left"width="25%"><%=genText_L%></th>
				<Td colspan="3"  width="75%">
<%
					String hText="";
					if (retHead.getFieldValue(0,"TEXT")!=null)
						hText=retHead.getFieldValueString(0,"TEXT");
%>
					<Textarea name="Text" cols="60" style="overflow:auto;width:100%" rows="2" tabindex="5" class=inputbox><%=hText%></Textarea>
				</Td>
			</Tr>
<%
	}
%>
</Table>

<DIV id="theads">
<TABLE id="tabHead" width="94%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
	<Tr>
		<th align="center" width="4%">&nbsp;</th>
		<th align="center" width="8%"><%=line_L%></th>
		<th align="center" width="15%"><%=mat_L%></th>
          	<th align="center" width="38%"> <%=desc_L%></th>
          	<th align="center" width="8%"><%=totQty_L%></th>
          	<th align="center" width="15%"><%=toBeDeliQty_L%></th>
          	<th align="center" width="12%"><%=qty_L%></th>

        </Tr>
</Table>
</Div>
<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:96%;height:40%;left:2%">
<TABLE id="InnerBox1Tab" width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
<%
	String tempStr = "";
	String serverfiles="";
	ReturnObjFromRetrieve retfiles =null;
	StringTokenizer stf=null;
	double tobedelqty=0;
	double totqtyVal =0;
	double TotBatchQty = 0;
	String lineNo="";
	String matnum="";
	String matDesc="";
	String uomQty="";
	String ToBeDelQty="";
	String totQtyDisp="";
	String batchQty = "";
	
	for(int km=0;km<retCount;km++)
	{
		boolean itemflag=false;
		String tempPos = "";
		try{
			tempPos = Integer.parseInt(dtlXML.getFieldValueString(km,"POSITION"))+"";
		}catch(Exception ex){tempPos=dtlXML.getFieldValueString(km,"POSITION");}
		
		if(!itemNums.contains(tempPos))
		{
			lineNo = dtlXML.getFieldValueString(km,"POSITION");
			try{
				lineNo = Integer.parseInt(lineNo)+"";
			}catch(Exception e){}
			
			matnum=dtlXML.getFieldValueString(km,"ITEM");
			matDesc=dtlXML.getFieldValueString(km,"ITEMDESCRIPTION");
			uomQty=dtlXML.getFieldValueString(km,"UOMPURCHASE");
			itemflag=true;
			if(delqty.containsKey(lineNo))
			{
				tobedelqty=Double.parseDouble((String)delqty.get(lineNo));
			}
			//NumberFormat nfmt = NumberFormat.getInstance();
			//nfmt.setMaximumFractionDigits(2);
			//nfmt.setMinimumFractionDigits(2);
			//ToBeDelQty = nfmt.format(tobedelqty);
			ToBeDelQty = getNumberFormat(tobedelqty+"",0);
		}
		
		
		
		if(!itemflag)
		{
			for (int i = 0; i < lineCount ; i ++ )
			{
				
				String position="";
				lineNo = retLines.getFieldValueString(i,"LINE_NR");  
				position=dtlXML.getFieldValueString(km,"POSITION");
				try{
					position = Integer.parseInt(position)+"";
				}catch(Exception e){}
				
				tempPos = "";
				try
				{
					tempPos = Integer.parseInt(position)+"";
				}
				catch(Exception ex){tempPos=position;}
				
				if(lineNo.equals(tempPos))
				{
					
					TotBatchQty = 0;
					matnum=(String)retLines.getFieldValueString(i,"MAT_NR");
					matDesc=(String)retLines.getFieldValueString(i,"MAT_DESC");
					uomQty=(String)retLines.getFieldValueString(i,"UOM_QTY");
					 if(delqty.containsKey(position))
					{
						tobedelqty=Double.parseDouble((String)delqty.get(position));
					}
					if(totqty.containsKey(position))
					{
						totqtyVal=Double.parseDouble((String)totqty.get(position));
					}
					try{
						retfiles=(ReturnObjFromRetrieve)UploadLines.get(shipid+lineNo);
					}catch(Exception e){
						retfiles = null;
					}
					int SCount = retSchd.getRowCount() ;
					for(int j=0;j< SCount ;j++)
					{
						String stempfiles="NA";
						if(lineNo.equals(retSchd.getFieldValueString(j,"LINE_NR")))
						{
							String schNo = retSchd.getFieldValueString(j,"SCHD_LINE");
							String mfgDate ="NA";
							if (retSchd.getFieldValue(j,"MFG_DATE")!=null)
							mfgDate=FormatDate.getStringFromDate((Date) retSchd.getFieldValue(j,"MFG_DATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
							 String expDate ="NA";
							if (retSchd.getFieldValue(j,"EXP_DATE")!=null)
								expDate =FormatDate.getStringFromDate((Date) retSchd.getFieldValue(j,"EXP_DATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
								String batch ="NA";
							if (retSchd.getFieldValue(j,"BATCH")!=null && !retSchd.getFieldValue(j,"BATCH").equals(""))
							batch =retSchd.getFieldValueString(j,"BATCH");
							String UfileName="NA";

							 if (retfiles!=null)
							{
								int fcount = retfiles.getRowCount();
								for (int k=0; k< fcount; k++)
								{
									if (schNo.equals(retfiles.getFieldValueString(k,"TYPE")))
									{
										UfileName = retfiles.getFieldValueString(k,"CLIENTFILENAME");
										stempfiles= retfiles.getFieldValueString(k,"SERVERFILENAME");
										break;
									}
								}
							}
							tempStr = tempStr+batch+"§"+mfgDate+"§"+expDate+"§"+retSchd.getFieldValueString(j,"BATCH_QTY")+"§"+UfileName+"µ";
							serverfiles =serverfiles+stempfiles+"µ";
							batchQty = retSchd.getFieldValueString(j,"BATCH_QTY");
							TotBatchQty = TotBatchQty+Double.parseDouble(batchQty);
						}
					}

%>
					<Tr>
						<Td width="4%"><input type="checkbox" name="Chk" value = "<%=lineNo%>"></Td>
						<td width="8%">
							<input type="hidden" name="lineFlag" value="true">
							<input type="hidden" name="Line" value="<%=lineNo%>"><%=position%>
						</td>
<%
						if(matnum==null || "".equals(matnum) || "null".equals(matnum))
						{
							matnum="";
						}
						try{
							matnum = String.valueOf(Long.parseLong(matnum));
						}catch(Exception e){}
					///NumberFormat nfmt = NumberFormat.getInstance();
					///nfmt.setMaximumFractionDigits(2);
					///nfmt.setMinimumFractionDigits(2);
					///ToBeDelQty = nfmt.format(tobedelqty);
					///totQtyDisp = nfmt.format(totqtyVal);
					ToBeDelQty = getNumberFormat(tobedelqty+"",0);
					totQtyDisp = getNumberFormat(totqtyVal+"",0);
%>
					<td width="15%"><input type="hidden" name="MaterialNr" value="<%=matnum%>"><%=matnum%>&nbsp;</td>
					<td width="38%"><input type="hidden" name="matdesc" value="<%=matDesc%>"><input type="text" class="tx" value="<%=matDesc%>" readonly style="width:100%"></td>
					<td width="8%" align=right><input type="hidden" name="UOM" value="<%=uomQty%>"><%=totQtyDisp%>
					<input type="hidden" name="tobedelqty" value="<%=tobedelqty%>">
					<input type="hidden" name="displayQty" value="<%=ToBeDelQty%>">
					</td>
					<td width="15%" align=right><%=ToBeDelQty%></td>
					<td width="12%" align=center>
					<input type="hidden" name="Quantity" value='<%=TotBatchQty%>'>
					<input type="hidden" name="Plant" value="<%=dtlXML.getFieldValueString(i,"PLANT")%>">
					<input type="hidden" name="confKey" value="<%=dtlXML.getFieldValueString(km,"CONFIRMATION_KEY")%>">
					<input type="hidden" name="batches" value="<%=(tempStr.length()>0)?tempStr.substring(0,tempStr.length()-1):tempStr%>">
					<a href="JavaScript:addBatches('<%=km%>')" id="Entry_<%=km%>" >View</a>
					&nbsp;
					<input type="hidden" name="serverfiles" value="<%=(serverfiles.length()>0)?serverfiles.substring(0,serverfiles.length()-1):serverfiles%>">
					</td>
					</Tr>
					<input type=hidden name=coaData value="<%=mainCoaData[i]%>">
					<input type=hidden name=coaLong value="<%=mainCoaLong[i]%>">
<%				
					tempStr = "" ;
					serverfiles="";
					break;
				}
			}
	}
	else
	{
%>
			<Td width="4%">&nbsp;<input type="hidden" name="lineFlag" value="false"></Td>
			<td width="8%"><input type="hidden" name="Line" value="<%=lineNo%>"><%=lineNo%></td>
			<td width="15%"><input type="hidden" name="MaterialNr" value="<%=matnum%>"><%=matnum%>&nbsp;</td>
			<td width="38%"><input type="hidden" name="matdesc" value="<%=matDesc%>"><input type="text" class="tx" value="<%=matDesc%>" readonly style="width:100%"></td>
			<td width="8%" align="right"><input type="hidden" name="UOM" value="<%=uomQty%>"><%=getNumberFormat(dtlXML.getFieldValueString(km,"ORDEREDQUANTITY"),0)%>
				<input type="hidden" name="tobedelqty" value="<%=tobedelqty%>">
				<input type="hidden" name="displayQty" value="<%=ToBeDelQty%>">
			</td>
					<td width="15%" align=right><%=ToBeDelQty%></td>
<%
		if(tobedelqty!=0)
		{
		
%>			
				<td width="12%" align=center>
				<a href="JavaScript:addBatches('<%=km%>')" id="Entry_<%=km%>">Select</a>
			</td>
<%
		}
		else
		{
%>
			<Td width="12%" >&nbsp;</Td>
<%
		}
%>
		</Tr>
		
		<input type="hidden" name="Quantity">
		<input type="hidden" name="Plant" value="<%=dtlXML.getFieldValueString(km,"PLANT")%>">
		<input type="hidden" name="confKey" value="<%=dtlXML.getFieldValueString(km,"CONFIRMATION_KEY")%>">
		<input type="hidden" name="batches" value="<%=(tempStr.length()>0)?tempStr.substring(0,tempStr.length()-1):tempStr%>">
		<input type="hidden" name="serverfiles" value="<%=(serverfiles.length()>0)?serverfiles.substring(0,serverfiles.length()-1):serverfiles%>">
		
		<input type=hidden name=coaData value="">
		<input type=hidden name=coaLong value="">
<%
		}
	} 
%>
</table>
</div>

<div id='ButtonDiv' align='center' style='position:absolute;top:90%;width:100%;'>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();

	buttonName.add("Back");
	buttonMethod.add("navigateBack(\"ezViewShipmentHeader.jsp?showData=Y&ponum="+ponum+"&orderBase="+orderBase+"&PurchaseOrder="+ponum+"\")");

	buttonName.add("Delete");
	buttonMethod.add("deleteLine()");

	buttonName.add("Save");
	buttonMethod.add("formEvents(\"N\")");

	buttonName.add("Submit");
	buttonMethod.add("doSendMailConfirm(\"Y\")");

	buttonName.add("Reset");
	buttonMethod.add("document.myForm.reset()");
	
	out.println(getButtonStr(buttonName,buttonMethod));
%>
</div>
<%@ include file="../Misc/AddMessage.jsp" %>
<!-- <div id="msgDiv" style="position:absolute;top:92%;width:100%;visibility:hidden" align="center">
<TABLE width="60%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
  <tr align="center">
    <td class="displayheader">Your request is being processed please wait ........</td>
  </tr>
</table>
</div> -->
<input type="hidden" name="shipuploads" value="<%=fstring%>" >
<input type="hidden" name="shipserverfiles" value="<%=sfstr%>">
<input type="hidden" name="schdflag" value="<%=schdflag%>" >
<input type="hidden" name="shipflag" value="<%=shipflag%>">
<input type="hidden" name="Type" value="<%=doctype%>" >

<input type="hidden" name="RqstType">

</form>
<Div id="MenuSol"></Div>
</body>
</html>

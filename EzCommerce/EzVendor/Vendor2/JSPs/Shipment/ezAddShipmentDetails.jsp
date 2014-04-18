<%//@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ page import="java.util.*,java.text.*" %>
<%@ include file="../../../Includes/JSPs/Labels/iAddShipmentDetails_Labels.jsp"%>
<jsp:useBean id="shipManager" class="ezc.ezshipment.client.EzShipmentManager" />
<%@ include file="../../../Includes/JSPs/Shipment/iModeOfTransport.jsp" %>
<%@ include file="../../../Includes/JSPs/Shipment/iAddShipmentDetails.jsp" %>
<%@ include file="../Shipment/ezOpenIBDQtyJCO.jsp" %>
<html>
<head>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
	<%@ include file="../../../../EzCommon/Includes/iShowCal.jsp"%>
	<script src="../../Library/JavaScript/ezTrim.js"></script>
	<script src="../../Library/JavaScript/ezConvertDates.js"></Script>
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
<Script>    
var tabHeadWidth=94
var tabHeight="35%"
</Script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>

<%
		ezc.ezutil.FormatDate fd = new ezc.ezutil.FormatDate();
		
		Date dd=new Date();
		String ss=fd.getStringFromDate(dd,(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
		String orderDate=fd.getStringFromDate((java.util.Date)dtlXML.getFieldValue(0,"ORDERDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
		int checkForButtons = 0;  //Added by sudhir on 30.04.2003
		
%>

	<script>
	plzSelPONo_L = '<%=plzSelPONo_L%>';
	var plzEnShOneItm_L = '<%=plzEnShOneItm_L%>';
	var dontSubShip_L = '<%=dontSubShip_L%>';
	dateFormat='<%=Integer.parseInt((String)session.getValue("DATEFORMAT"))%>';
	var totalbatches;
	
	function funSelect(){
	
	//alert(document.myForm.orderType[0].checked);
	if(document.myForm.orderType[0].checked && 'po'==document.myForm.orderType[0].value){
		document.myForm.orderBase.value = 'po';
		SendQuery('po');
		//document.myForm.submit();
		
	}
	if(document.myForm.orderType[1].checked && 'con'==document.myForm.orderType[1].value){
		document.myForm.orderBase.value = 'con';
		SendQuery('con');
		//document.myForm.submit();
	}
	
	}
	var req;	
	function SendQuery(orderBase){
		try{
			req = new ActiveXObject("Msxml2.XMLHTTP");
		}
		catch(e)
		{
			try{
				req = new ActiveXObject("Microsoft.XMLHTTP");
			}
			catch(oc)
			{
				req = null;
			}
		}
		if(!req&&typeof XMLHttpRequest!="undefined"){
			req = new XMLHttpRequest();
		}
		
		var url="http://"+location.host+"/EZP/EzCommerce/EzVendor/Vendor2/JSPs/Shipment/ezSelShipDocAjax.jsp?orderBase="+orderBase+"&noCache='"+((new Date()).valueOf())+"'";
		if(req!=null){
			req.onreadystatechange = Process;
			req.open("GET", url, true);
			req.send(null);
		}
	}
	function Process(){
		if (req.readyState == 4)
		{
			var resText = req.responseText;	 	        	
			var resultText	= resText.split("¥");	
			if (req.status == 200)
			{
				if(resultText[0]=="")
					HideDiv("SP"+resultText[1]);
				else
				{
					//var spid = "SP"+resultText[1];
					//alert(resText);
					//document.getElementById('selectPO').innerHTML =resultText[0];	
					for(slen=document.myForm.selectPO.options.length-1;slen>0;slen--)
						document.myForm.selectPO.options[slen]=null
					for(i=0;i<(resultText.length-2);i++)
					{
						document.myForm.selectPO.options[i]=new Option(resultText[i+1],resultText[i+1])
						if('<%=ponum%>'== resultText[i+1])
						document.myForm.selectPO.options[i].selected = true;
					}
					
					//alert(document.myForm.orderBase.value); 
					if(document.myForm.orderBase.value ==''){
						if('<%=orderBase%>'== 'po'){
							document.myForm.orderType[0].checked = true 
							document.myForm.orderType[0].value = 'po'
						}else if('<%=orderBase%>'== 'con'){
							document.myForm.orderType[1].checked = true 
							document.myForm.orderType[1].value = 'con'
						}
					
					}
					if(document.myForm.orderBase.value == 'po'  ){
					document.myForm.orderType[0].checked = true 
					document.myForm.orderType[0].value = 'po'
					}else if(document.myForm.orderBase.value == 'con'){
					document.myForm.orderType[1].checked = true 
					document.myForm.orderType[1].value = 'con'
					} 
				}
			}
			else
			{
				document.myForm.selectPO.options[0]= new Option('No Orders to select','')
				
			}
		}
	}

	
	
	function getQty(){
		var len = document.myForm.batches.length;
		var addedQty = 0.00; 
		if(len>0){
			for(var i=0;i<len;i++)
			{
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
		}	
		else{
			var batch =  document.myForm.batches.value;
			var allbatchs= batch.split("§");
			addedQty = parseFloat(allbatchs[3]);
			
		}
		
		if(addedQty>0)
			return true;
		else
			return false;
	}
	
	function formEvents(obj)
	{
		
		var flg2=false;
		var flg3=false;
		flg1=validateFields();
		if(flg1)
		{
			var ss=ConvertDate('<%=ss%>','<%=Integer.parseInt((String)session.getValue("DATEFORMAT"))%>')
			var orderDate=ConvertDate('<%=orderDate%>','<%=Integer.parseInt((String)session.getValue("DATEFORMAT"))%>')
			
			flg3=funDateCheck(ss,orderDate)
		}

		if (flg1&&flg3)
		{
			
			
			if(!getQty()){
			alert(plzEnShOneItm_L)
			return;
			
			}
			
			if(confirm(dontSubShip_L))
			{
				//document.getElementById("ButtonDiv").style.visibility="hidden"
				//document.getElementById("msgDiv").style.visibility="visible"
				document.myForm.status.value="N";
				if(document.myForm.shipflag.value=="")
				{

					document.myForm.shipflag.value="N";
				}

				document.myForm.action="ezAddSaveShipmentDetails.jsp";
				setMessageVisible();
				document.myForm.submit();
			}
			document.forms[0].DeliveryChallan.focus();
		}
		
		
	}
	
	
	//Calling when click on Submit Button
	function doSendMailConfirm(obj){
		var flg2=false;
		var flg3=false;
		flg1=validateFields();
		if(flg1)
		{
			var ss=ConvertDate('<%=ss%>','<%=Integer.parseInt((String)session.getValue("DATEFORMAT"))%>')
			var orderDate=ConvertDate('<%=orderDate%>','<%=Integer.parseInt((String)session.getValue("DATEFORMAT"))%>')
			
			flg3=funDateCheck(ss,orderDate)
		}


		if (flg1 && flg3)
			flg2= funBatchCheck();
		if (flg1&&flg2)
		{
			//document.getElementById("msgDiv").style.visibility="visible"
			if(document.myForm.shipflag.value=="")
			{
				document.myForm.shipflag.value="N";
			}
			document.myForm.status.value="Y";
			document.myForm.sendMail.value="Yes";
			document.myForm.action="ezAddSaveShipmentDetails.jsp";
			setMessageVisible();
			document.myForm.submit();
		}
	}
	function addBatches(index)
	{
		var args="";
		var lineNo="";
		var matdesc="";
		var Qtytobeship="";
		var batches="";
		var uom="";
		var displayQty="";
		var matCode = "" 
	    	if(isNaN(document.myForm.UOM.length))
	    	{
			lineNo=document.myForm.Line.value;
    			matdesc=document.myForm.Description.value;
	
    			uom=document.myForm.UOM.value;
    			Qtytobeship=document.myForm.QuanToBeShip.value;
    			displayQty=document.myForm.displayQty.value;
    			matCode = document.myForm.matNum.value;
    			
	    		if(document.myForm.batches.value!="")
	    		{
	    			batches=document.myForm.batches.value;
	    			args=lineNo+"¤"+matdesc+"¤"+uom+"¤"+escape(batches)+"¤"+matCode;
	    		}
	    		else
	    			args=lineNo+"¤"+matdesc+"¤"+uom+"¤"+matCode;
	    	}
	    	else
	    	{
			lineNo=document.myForm.Line[index].value;
    			matdesc=document.myForm.Description[index].value;
    			uom=document.myForm.UOM[index].value;
    			Qtytobeship=document.myForm.QuanToBeShip[index].value;
			displayQty=document.myForm.displayQty[index].value;
			matCode = document.myForm.matNum[index].value;
	    		if(document.myForm.batches[index].value!="")
	    		{
	    			batches=escape(document.myForm.batches[index].value);
	    			args=lineNo+"¤"+matdesc+"¤"+uom+"¤"+batches+"¤"+matCode;
	    		}
	    		else
	    			args=lineNo+"¤"+matdesc+"¤"+uom+"¤"+matCode;
	    	}

	    		//added for COA
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
	    		coastr=dcno+"¤"+document.myForm.Description.value+"¤"+dcdate;
	    	}
	    	else
	    	{
	    		coastr=dcno+"¤"+document.myForm.Description[index].value+"¤"+dcdate;
	    	}
			//alert(coastr);
	    	///End for Coa
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
	    	
	/*
	if(args.indexOf("#") != -1)
	{
		args 	= args.replace("#","¥");
		coastr 	= coastr.replace("#","¥");
	}
	*/
	args 	= spChar(args);
	coastr 	= spChar(coastr);

	    	totalbatches= window.open("ezEnterShipQty.jsp?args="+args+"&Qtytobeship="+Qtytobeship+"&index="+index+"&rowCount=<%=retCount%>"+"&coastr="+coastr+"&type=<%=Type%>"+"&displayQty="+displayQty,"UserWindow","width=650,height=450,left=50,top=50,resizable=1,scrollbars=1,toolbar=no,menubar=no,directories=no,location=no,status=no");
	}

	var shipattach;
	function openUploadWindow()
	{
		var filestring=document.myForm.shipupload.value
		shipattach=window.open("ezAttachmentFile.jsp?filestring="+filestring,"UserWindow1","width=450,height=400,left=150,top=100,resizable=no,scrollbars=yes,toolbar=no,menubar=no");
	}

	function funUnLoad()
	{
		if(totalbatches!=null && totalbatches.open)
		{

			totalbatches.close();
		}
		if(shipattach!=null && shipattach.open)
		{
			shipattach.close();
		}
	}
	function submitIt1()
	{
			if (document.myForm.selectPO.options[document.myForm.selectPO.selectedIndex].value=='' || document.myForm.selectPO.options[0].value=='')
			{
				alert ('Please select Order Number');
				document.myForm.selectPO.focus();
				return false;
			}
			else{
				document.myForm.showData.value='Y'
				try{
					//orderBase
					if(document.myForm.orderType[0].checked && 'po'==document.myForm.orderType[0].value)
						document.myForm.orderBase.value = 'po';
						
					if(document.myForm.orderType[1].checked && 'con'==document.myForm.orderType[1].value)
						document.myForm.orderBase.value = 'con';
						
					document.myForm.ponum.value=document.myForm.selectPO.options[document.myForm.selectPO.selectedIndex].value
				}catch(e){
					
					
				}
				document.myForm.submit()
			}
	}
	
	
	</script>
</head>
<%
	String loadCalls="scrollInit()";
	if("Y".equals(showData)){
		loadCalls="scrollInit();SendQuery('"+orderBase+"')";
	}
%>
<body onLoad="<%=loadCalls%>" onResize="scrollInit()" scroll=no onUnLoad="funUnLoad()">
<form name="myForm" method="post">
<input type='hidden' name='orderBase' value=''>
<%	
	String fromPage = request.getParameter("FROM"); 
	if(rowCount >= 0)
	{
		String display_header = addshpdet_L;
		String selected = ""; 
%>
		<%@ include file="../Misc/ezDisplayHeader.jsp" %>
		<input type=hidden name="showData" >

		<Div id='inputDiv' style='position:relative;align:center;top:1%;width:100%;height:5%'>
		<Table width="40%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
		<Tr>
			<Td height="5" style="background-color:'F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"></Td>
			<Td height="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"></Td>
			<Td height="5" style="background-color:'F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"></Td>
		</Tr>
		<Tr >
			<Td width="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"></Td>
			<Td style="background-color:'F3F3F3'" valign=middle>
				<Table border="0" align="center" valign=middle width="100%" cellpadding=1 cellspacing=1 class=welcomecell>
				<Tr>
					<Td style='background:#F3F3F3;font-size=11px;color:#00355D;font-weight:bold' width='45%' align=left>
						
						<Table align=center>
							<Tr align="center"><Td style="background-color:'F3F3F3'" align="left"><input type='radio' name='orderType' value='po' onclick='javascript:funSelect()' >&nbsp;<b><%=purOrder_L%></b></Td><Tr>
							<Tr align="center"><Td style="background-color:'F3F3F3'" align="left"><input type='radio' name='orderType' value='con'onclick='javascript:funSelect()' >&nbsp;<b>Schedule Agreement</b></Td><Tr>
						</Table>	
							
						
					</Td>
					<Td style='background:#F3F3F3;font-size=11px;color:#00355D;font-weight:bold' width='45%' align=right>
					
					<Select name="selectPO" style="width:100%" id="ListBoxDiv1">
						<option value=" ">Select Order</option>
						
<%
						/*for(int i=0;i<rowCount;i++)
						{
							if(ponum.equals(retObj.getFieldValueString(i,"ORDER")))  
								selected = "selected";
							else{
								selected = "";
								
							}	
							out.println("<option value='"+retObj.getFieldValueString(i,"ORDER")+"' "+selected+">"+retObj.getFieldValueString(i,"ORDER")+"</option>");
						}*/
%>
					</select>
					
					</Td>
					<Td id='goButton' style='background:#F3F3F3' align=center>
						<Img src="../../../../EzCommon/Images/Body/left_arrow.gif" style="cursor:hand" border="none" onClick="submitIt1()" onMouseover="window.status=' Add  the Shipment '; return true" onMouseout="window.status=' '; return true">
					</Td>
				</TR>
				</Table>
			</Td>
			<Td width="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e3.gif"><img width="5" height="1" src="Cb_e3.gif"></Td>
		</Tr>
		<Tr>
			<Td width="5" style="background-color:'F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"></Td>
			<Td height="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"></Td>
			<Td width="5" style="background-color:'F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"></Td>
		</Tr>
		</Table>
		</Div>
		<input type="hidden" name="ponum" value='<%=ponum%>'>
<%		
		String modeCode = "";
		String modeDesc = "";
		if("Y".equals(showData))
		{
			modeCode = "";
			modeDesc = "";
			java.util.Enumeration modeEnum = modeHash.keys();
			int modeCount = modeHash.size();
%>		
			<input type="hidden" name="base" value="<%=base%>">
			<input type="hidden" value="<%=poNum%>" name="baseValue">
			<input type="hidden" value="<%= OrderValue %>" name="OrderValue">
			<input type="hidden" value="<%= orderCurrency%>" name="orderCurrency">
			<input type="hidden" value="<%=formatDate.getStringFromDate(ordDate,(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%>" name="OrderDate">
			<input type="hidden"  name="status">
			<input type="hidden" name="Type" value="<%=Type%>" >
			<input type="hidden" name="PONumber" value="<%=order%>">
			<input type="hidden" name="PODate" value="<%=formatDate.getStringFromDate(ordDate,(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%>">
			<input type="hidden" name="shipupload" value="">
			<input type="hidden" name="schdflag" value="" >
			<input type="hidden" name="shipflag" value="">

			
			<BR><BR><BR><BR><BR>
			<Table width="94%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
			<tr align="center" valign="middle">
				<th align="left"><%=modOfTrans_L%></th>
				<td align="left">
					<!--<input type="text" class=InputBox  name="DeliveryChallan" value="<%//=dcno%>" tabindex="1" maxlength="30">-->
					<Select name="DeliveryChallan" style="width:100%" id="ListBoxDiv1">
					<option value=''><%=select_L%></option>
<%					
					for(int i=0;i<modeCount;i++)
					{
						modeCode = (String)modeEnum.nextElement();
						modeDesc = (String)modeHash.get(modeCode);
						
						if((dcno.trim()).equals((modeCode.trim())))
							selected = "selected";
						else
							selected = ""; 
%>
						<option value='<%=modeCode%>' <%=selected%> ><%=modeDesc%></option>;
<%
					}
					if("".equals(dcdate) || "null".equals(dcdate) || dcdate==null )
						dcdate = formatDate.getStringFromDate(new Date(),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT"))) ;
					
					if("".equals(shipdate) || "null".equals(shipdate) || shipdate==null ){
					
						try{
						if(shipDates.get(ponum)!=null) 
							shipdate = formatDate.getStringFromDate((Date)shipDates.get(ponum),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT"))) ;
						else
							shipdate = "";
						}catch(Exception e){shipdate = "";}	
					}	
%>					
					</Select>
				</td> 
				<th align="left"><%=dnoteDate_L%> </th>
				<td align="left" valign=center>
					<input type="text" class=InputBox  name="DCDate" id="DCDate"  value="<%=dcdate%>" size=12 readonly onfocus=this.blur()>
					<%//=getDateImage("DCDate")%>
				</td>
				
 			</tr>
 			<tr>
				<th align="left"><%=invno_L%></th>
				<td align="left"><input type="text" class=InputBox  name="InvoiceNo" value="<%=invno%>" tabindex="2" maxlength="20"></td>
				<th align="left"><%=invdate_L%></th>
				<td align="left" valign=center>
					<input type="text" class=InputBox  name="InvoiceDate"  id="InvoiceDate" value="<%=invdate%>" size=12 readonly onfocus=this.blur()>
					<%=getDateImage("InvoiceDate")%>
				</td>
			</tr>
			<tr>
				<th align="left"><%=lrrr_L%></th>
				<td align="left"><input type="text" class=InputBox  name="LR" value="<%=lrno%>" tabindex="3" maxlength="30"></td>
				<th align="left"><%=shipdate_L%></th>
				<td align="left" valign=center><input type="text" class=InputBox  name="ShipDate"  id="ShipDate" value="<%=shipdate%>" size=12 readonly onfocus=this.blur()>
					<%=getDateImage("ShipDate")%>
				</td>
			</tr>
			<tr>
				<th align="left"><%=caname_L%> </th>
				<td><input type="text" class=InputBox  name="CarrierName" value="<%=cname%>" tabindex="4" maxlength="50"></td>
				<Th align="left"><%=exparrdate_L%></Th>
				<Td valign=center><input type="text" class=InputBox  value="<%=expTime%>" name="ExpectedArivalTime"  id="ExpectedArivalTime" size=12 readonly onfocus=this.blur()>
					<%=getDateImage("ExpectedArivalTime")%>
				</Td>
			</tr>
			<Tr>
				<Th align="left"><%=genText_L%></Th>
				<Td colspan="3" align="left" >
				
				<Textarea name="Text" cols="60" style="overflow:auto;width:100%" rows="2" tabindex="5" class=inputbox><%=text%></Textarea>
				</Td>
			</Tr>
			</Table>
  
<%
		if(dtlXML.getRowCount() != 0) 
		{
		ezc.ezcommon.EzLog4j.log("MY CHK VALUE>>>"+dtlXML.toEzcString(),"I");
		//dtlXML.toEzcString(); 
%>		
			<div id="theads">
			<TABLE id="tabHead" width="94%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
			<tr>
				<th width="7%"><%=line_L%></th>
				<th width="18%"><%=material_L%></th>
				<th width="30%"><%=desc_L%></th>
				<th width="5%"><%=uom_L%></th>   
				<th width="15%"><%=totQty_L%></th>
				<th>Open/To Be Del Qty</th>
				<!--<th width="15%"><%=toBeDelQty_L%></th>-->
				<th width="10%"><%=qty_L%></th>
			</tr>
			</Table>
			</div>
			<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:96%;height:35%;left:2%">
			<TABLE id="InnerBox1Tab" width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<%
			//out.println("historyTablehistoryTablehistoryTable	"+historyTable);
			for(int i=0;i<dtlXML.getRowCount();i++)
			{
				lineNum = dtlXML.getFieldValueString(i, "POSITION"); 
				try{
				lineNum = Integer.parseInt(lineNum)+"";
				}catch(Exception e){}
				matNum 	= dtlXML.getFieldValueString(i, "ITEM");
				matNum 	= matNum.trim();
				matDesc = dtlXML.getFieldValueString(i, "ITEMDESCRIPTION");
				matDesc = matDesc.trim();
				uom = dtlXML.getFieldValueString(i, "UOMPURCHASE");
				qty = dtlXML.getFieldValueString(i, "ORDEREDQUANTITY");
				price = dtlXML.getFieldValueString(i, "PRICE");
				netAmount = dtlXML.getFieldValueString(i, "AMOUNT");
				eDDate =(Date)dtlXML.getFieldValue(i, "PLANNEDDELIVERYDATE");
				plant=dtlXML.getFieldValueString(i, "PLANT");
				confKey = dtlXML.getFieldValueString(i, "CONFIRMATION_KEY");

				double TotQty = 0;		// Total PO Item Qty
				try{
					TotQty = Double.parseDouble(qty);
					
				}catch(Exception e){}

				double DelQty = 0;		// Allready Delivered Qty from PO History

				 if (historyTable.containsKey(lineNum))
				{
					try{
						DelQty = Double.parseDouble((String)historyTable.get(lineNum));
					}catch(Exception e){}
				}

				double BeDelQty = TotQty - DelQty ;
				double ToBeDelQtyDouble = 0;
				//out.println("BeDelQty>"+BeDelQty+">TotQty>"+TotQty+">DelQty>"+DelQty);
				
				/*if (BeDelQty <= 0)
				{
					BeDelQty = 0;
					checkForButtons++; 
				}*/
				

				
				//NumberFormat nfmt = NumberFormat.getInstance();
				//nfmt.setMaximumFractionDigits(2);
				//nfmt.setMinimumFractionDigits(2);
				
				//out.println("openIBDItemsHT:"+openIBDItemsHT);
				String ToBeDelQty = "";//getNumberFormat(BeDelQty+"",0);
				if(openIBDItemsHT.containsKey(lineNum))
				{
					ToBeDelQty = (String)openIBDItemsHT.get(lineNum);
					ToBeDelQty = ToBeDelQty.substring(0,ToBeDelQty.indexOf("."));
				}
				else
				{
					ToBeDelQty = "0";
					//openIBDItemsHT.put(lineNum,BeDelQty+"");
				}	
					
				try
				{
					ToBeDelQtyDouble = Double.parseDouble(ToBeDelQty);
				}
				catch(Exception e)
				{
					ToBeDelQtyDouble = 0;
					out.println("::::"+e);
				}
				
				if (ToBeDelQtyDouble <= 0)
				{
					ToBeDelQtyDouble = 0;
					checkForButtons++; 
				}
					
				String finalqty=ToBeDelQty;//""+BeDelQty;
				
				String TotalQty = getNumberFormat(TotQty+"",0);
				count=count+1;
				
				
%>
				<input type="hidden" name="MaterialNr" value="<%=matNum%>">
				<input type="hidden" name="UOM" value="<%=uom%>">
				<input type="hidden" name="QuanToBeShip" value="<%=finalqty%>">
				<input type="hidden" name="displayQty" value="<%=ToBeDelQty%>">
				<input type="hidden" name="Plant" value="<%=plant%>">
				<input type="hidden" name="confKey" value="<%=confKey%>">
				<input type="hidden" name="Quantity" style="text-align:right">
				<input type="hidden" name="coaLong" >
				<input type="hidden" name="coaData" >

			<tr>
				<td align="center" width="7%"><%=lineNum%><input type="hidden" name="Line" value="<%=lineNum%>"></td>
				<td align="left" width="18%">
<%
				try
				{
					out.println(Long.parseLong(matNum));
				}
				catch(Exception numFmtEx){out.println(matNum);}
%>
				&nbsp;
				<input type="hidden" name="matNum" value="<%=matNum%>">
				</td>
				<td width="30%"><%=matDesc%><input type="hidden" name="Description" value="<%=matDesc%>"></td>
				<td width="5%" align="center"><%= uom %></td>
				<td width="15%" align="right"><%=TotalQty%>&nbsp;</td> 
				<td width="15%" align="right"><%=ToBeDelQty%>&nbsp;</td> 
<%
				if(ToBeDelQtyDouble!=0)
				{
%>
					<td width="10%" align="center"><input type="hidden" name="batches" ><a id="Entry_<%=i%>" href="JavaScript:addBatches(<%=i%>)">Select</a>
<%
				}
				else
				{
%>	
					<td width="10%" align="center"><input type="hidden" name="batches" >
<%
				}
%> 
				&nbsp;
				</td>
			</tr>
<%
			}
%>
			</table>
			</div>
<%
		}
		else
		{
			String noDataStatement = nopurorder_L; 
%>
			<%@ include file="../Misc/ezDisplayNoData.jsp" %>
			<Div id="BackButtonDiv" style="position:absolute;top:90%;width:100%;visibility:visible">
			<Center>
<%
				buttonName = new java.util.ArrayList();
				buttonMethod = new java.util.ArrayList();
				buttonName.add("Back");
				buttonMethod.add("navigateBack(\"../Misc/ezSBUWelcome.jsp\")");
				out.println(getButtonStr(buttonName,buttonMethod)); 	 
%>
			</Center>
			</Div>
<%
		}
%>		
		<input type="hidden" name="count" value="<%= count %>">
<%
		
		if(userType == null) 
			userType="";
			
		//out.println("userTypeuserTypeuserType	"+userType);	
		
		if((!("2".equals(userType.trim()))))
		{
%>
			<input type=hidden name=sendMail value="No">

			<div id="ButtonDiv" style="position:absolute;top:95%;width:100%;visibility:visible">
			<center>
<%
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();

			if("Y".equals(backFlg)){
				
				buttonName.add("Back");
				buttonMethod.add("history.go(-1)");
				
			}
			

			if(checkForButtons<dtlXML.getRowCount())
			{
				buttonName.add("Add Documents");
				buttonMethod.add("openUploadWindow()");

				buttonName.add("Save");
				buttonMethod.add("formEvents(\"N\")");

				buttonName.add("Submit");
				buttonMethod.add("doSendMailConfirm(\"Y\")");

				buttonName.add("Reset");
				buttonMethod.add("document.myForm.reset()");
			}	

			out.println(getButtonStr(buttonName,buttonMethod));
%>
			</center>
			</div>
			<%@ include file="../Misc/AddMessage.jsp" %>
<%
		}
		}
		else
		{
			if("MENU".equals(fromPage))
			{
				String noDataStatement = "Please select the Purchase Order / Schedule Agreement for adding the Shipment";
%>
				<%@ include file="../Misc/ezDisplayNoData.jsp" %>
				<Div id="BackButtonDiv" style="position:absolute;top:90%;width:100%;visibility:visible">
				<Center>
<%
					buttonName = new java.util.ArrayList();
					buttonMethod = new java.util.ArrayList();
					buttonName.add("Back");
					buttonMethod.add("navigateBack(\"../Misc/ezSBUWelcome.jsp\")");
					out.println(getButtonStr(buttonName,buttonMethod));	
%>
				</Center>
				</Div>	
<%			
			}
		}
	}
	else
	{
		String noDataStatement = nopoExAddsh_L;;
%>
		<%@ include file="../Misc/ezDisplayNoData.jsp" %>
		<%@ include file="../Misc/ezDisplayNoData.jsp" %>
		<Div id="BackButtonDiv" style="position:absolute;top:90%;width:100%;visibility:visible">
		<Center>
<%
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();
			buttonName.add("Back");
			buttonMethod.add("navigateBack(\"../Misc/ezSBUWelcome.jsp\")");
			out.println(getButtonStr(buttonName,buttonMethod));	
%>
		</Center>
		</Div>
<%
	}
%>
	<Div id="BackButtonDiv" style="position:absolute;top:90%;width:100%;visibility:visible">
	<Center>
<%
	if(!"Y".equals(showData))	
	{
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		buttonName.add("Back");
		buttonMethod.add("navigateBack(\"../Misc/ezSBUWelcome.jsp\")");
		out.println(getButtonStr(buttonName,buttonMethod));	
	}
%>
	</Center>
	</Div>
	
</form>
<Div id="MenuSol"></Div>
</body>
</html>  
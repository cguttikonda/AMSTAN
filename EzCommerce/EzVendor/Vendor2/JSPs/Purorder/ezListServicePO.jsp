<%@ page import="java.util.*,java.text.*" %>
<%@ page import = "ezc.ezutil.FormatDate"%>
<%//@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Jsps/Purorder/iListServicePO.jsp"%>
<%@ include file="../../../Includes/Jsps/Labels/iListPO_Labels.jsp"%>
<%@ include file="../../../Includes/Jsps/Misc/iGetVendorDesc.jsp"%>


<Html>
<Head>
<Script>
	var tabHeadWidth=95
	var tabHeight="57%"
</Script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<script src="../../Library/JavaScript/ezTrim.js"></Script>

<title><%=listPo_L%></title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<%@ include file="../../../Includes/Jsps/Misc/iShowCal.jsp"%>
<Script>
	function funLinkOpen(fileName,PurchaseOrder,NetAmount,Currency,orderType,vendorNo)
	{
		document.location.href=fileName+"?PurchaseOrder="+PurchaseOrder+"&NetAmount="+NetAmount+"&Currency="+Currency+"&orderType="+orderType+"&vendorNo="+vendorNo;
	}
	function funShowVndrDetails(syskey,soldto)
	{
			var retValue = window.showModalDialog("../RFQ/ezVendorContactDetails.jsp?SysKey="+syskey+"&SoldTo="+soldto,window.self,"center=yes;dialogHeight=25;dialogWidth=40;help=no;titlebar=no;status=no;minimize:yes")	
	}
	
	function showDiv()
	{
		var mySearchObj=document.myForm.searchBy;
		var mySearchKeyObj=document.myForm.searchKey;
		
		var myObjVal="";
		var len=mySearchObj.length;
		var myDivObj=document.getElementById("myCalDiv");
		
		
		
		var toDate = new Date();
		toDate.setMonth(toDate.getMonth()-1);
		today = toDate.getDate();
		thismonth = toDate.getMonth()+1;
		thisyear = toDate.getYear();
		
		
		
		if(today < 10)
			today = "0"+today;
		if(thismonth < 10)
			thismonth = "0" + thismonth;

		if(thisyear<1900)
		thisyear = thisyear+1900
		
		
		if(isNaN(len)){
			if(mySearchObj.checked){
				myObjVal=mySearchObj.value;
			}
		}else{
			for(var i=0;i<len;i++){
				if(mySearchObj[i].checked){
					myObjVal=mySearchObj[i].value;
				}
			}
		}
		mySearchKeyObj.value="";
		if("D"==myObjVal){
			
			mySearchKeyObj.value=today+"."+thismonth+"."+thisyear;
			mySearchKeyObj.readOnly = true;
			if(myDivObj.style.visibility=="hidden")
				myDivObj.style.visibility="visible";
		}else{
			mySearchKeyObj.readOnly = false;
			if("V"==myObjVal)
			mySearchKeyObj.value="<%=(String)session.getValue("SOLDTO")%>";
			
			if(myDivObj.style.visibility=="visible")
				myDivObj.style.visibility="hidden";
		}	
		
		
		
	}
	function setVal(searchBy)
	{
		var mySearchObj=document.myForm.searchBy;
		var mySearchKeyObj=document.myForm.searchKey;
		if(mySearchObj!=null){
			var len=mySearchObj.length;
			var myDivObj=document.getElementById("myCalDiv");
			if(isNaN(len)){
				if(mySearchObj.value==searchBy){
					mySearchObj.checked=true;
				}
			}else{
				for(var i=0;i<len;i++){
					if(mySearchObj[i].value==searchBy){
						mySearchObj[i].checked=true;
					}
				}
			}

			if("D"==searchBy){
				mySearchKeyObj.readOnly=true;
				if(myDivObj.style.visibility=="hidden")
					myDivObj.style.visibility="visible";
			}else{
				mySearchKeyObj.readOnly=false;
				if(myDivObj.style.visibility=="visible")
					myDivObj.style.visibility="hidden";
			}
		}
		
	}
	function funSubmit()
	{
		var mySearchKeyObj=document.myForm.searchKey;
		if('Open'!=document.myForm.OrderType.value){
			if(funTrim(mySearchKeyObj.value)==""){
				alert("Please Enter Search Key");
				mySearchKeyObj.focus();
				return;
				
			}
		}
		document.myForm.action="ezListServicePO.jsp";
		document.myForm.submit();
		
	}

</Script>
</Head>

<%
	String message="";
	String display_header = "";
     	if(orderType == null) orderType="";
     	if(orderType.equals("Open")){
        	message = "No Open Service Purchase Orders Exist";
        	display_header="Open Service Purchase Orders";
     	}else if(orderType.equals("Closed")){
            	message = "No Closed Service Purchase Orders Exist";
            	display_header="Closed Service Purchase Orders";
     	}else{
  		message = "No Service Purchase Orders Exist";
  		display_header="Service Purchase Orders";
     	}
%>


<Body bgcolor="#FFFFF7"  onLoad="scrollInit();setVal('<%=searchBy%>');" onResize="scrollInit()" scroll=no>
<Form name="myForm">
<input type="hidden" name="OrderType" value="<%=orderType%>" >
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<%
	if(!"3".equals(userType))
	{
%>
		<br>
		<Table width="45%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=0 cellSpacing=0 >
		<tr align="center" valign="middle">
			<td rowspan=3  align="right" width="25%"> Search By</td>
			<td align="left" width="25%">
				<input type="radio"  name="searchBy" onClick="showDiv();" value="V">Vendor<br>
				<input type="radio"  name="searchBy" onClick="showDiv();" value="D">From Date<br>
				<input type="radio"  name="searchBy" onClick="showDiv();" value="P">PO Number<br>
			</td>
			<td align="right" width="25%" rowspan=3 >
				<input type="text" name="searchKey" class="InputBox" size=12 maxlength=10 value="<%=searchKey%>">
			</td>
			<td align="left" width="25%" rowspan=3 no wrap>
				<Div id="myCalDiv" style="position:relative;visibility:hidden;width:100%;">
					<img src="../../Images/calender.gif" style="cursor:hand" height="18" onClick=showCal("document.myForm.searchKey",150,450,"<%=cDate%>","<%=cMonth%>","<%=cYear%>") >
				</Div>

			</td>
			<td rowspan=3  align="center" width="25%"> 
<%
			butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Search&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
			butActions.add("funSubmit();");	
			out.println(getButtons(butNames,butActions));
%>
			</td>
	
	
	
	
		</tr>
		</Table>
		
<%
	}
	if(hdrXMLCount==0)
	{

%>		
		<Div id="nocount" style="position:absolute;top:40%;width:100%;visibility:visible">
			<Table width="30%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
			 <Tr align="center">
			  	<Th><%=message%></Th>
			 </Tr>
			</Table>
		</Div>
<%
		
	}else{
%>


		<Br><Br><Br>
		<Div id="theads">
		<Table id="tabHead" width="95%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
			<tr align="center" valign="middle">

				<th rowspan=2 width="10%"> <%=poNum_L%></th>
				<th rowspan=2 width="10%">Vendor</th>
				<Th rowspan=2 width="28%">Vendor Name</Th>
				<th rowspan=2 width="10%"> <%=orderDate_L%></th>
				<th colspan=2 width="20%"><%=deliveryDate_L%></th>
				<th colspan=2 width="22%"><%=value_L%></th>
			</tr>
			<tr>
				<th width="10%"><%=early_L%></th>
				<th width="10%"><%=latest_L%></th>
				<th width="8%"><%=curre_L%>.</th>
				<th width="14%"><%=value_L%></th>
			</tr>
		</Table>
		</Div>
		<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:96%;height:57%;left:2%">
		<Table id="InnerBox1Tab" align=center width=100%  border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
<%

		Vector types = new Vector();
		types.addElement("currency");
		types.addElement("date");
		types.addElement("date");
		types.addElement("date");
		EzGlobal.setColTypes(types);

		Vector names = new Vector();
		names.addElement("NETAMOUNT");
		names.addElement("CONFIRMDELIVERYDATE");
		names.addElement("DELIVERYDATE");
		names.addElement("ORDERDATE");
		EzGlobal.setColNames(names);

		ezc.ezparam.ReturnObjFromRetrieve ret = EzGlobal.getGlobal((ezc.ezparam.ReturnObjFromRetrieve)hdrXML);
		
		


		for(int i=0; i< hdrXMLCount; i++)
		{
	
	
			String poNumber = hdrXML.getFieldValueString(i, ORDER);	
			String vendorNo = ret.getFieldValueString(i, "VENDOR_NUMBER");	
			String vendName = (String)venodorsHT.get(vendorNo.trim());
			if(vendName==null||"null".equals(vendName))
			vendName="Not Syncronized";
%>
			<tr>
				<td  width="10%" align="center"> <A href="JavaScript:funLinkOpen('ezServicePOLineItems.jsp','<%=poNumber%>','<%=hdrXML.getFieldValueString(i,"NETAMOUNT")%>','<%=hdrXML.getFieldValueString(i,"CURRENCY")%>','<%=orderType%>','<%=vendorNo%>')"  onMouseover="window.status='Click to view the PurchaseOrder Lines '; return true" onMouseout="window.status=' '; return true"><%=Long.parseLong(poNumber)%></a></td>				
				<td align="center" width="10% "><a href = "javascript:funShowVndrDetails('<%=(String)session.getValue("SYSKEY")%>','<%=vendorNo%>')"><%=vendorNo%></a></td>
				<Td width="28%" align="left"><%=vendName%>&nbsp;</Td>
				<td align="center" width="10% "><%=ret.getFieldValueString(i, ORDERDATE)%></td>
				<td align="center" width="10%"><%=ret.getFieldValueString(i,DELIVERYDATE)%></td>
				<td align="center" width="10%"><%=ret.getFieldValueString(i,"CONFIRMDELIVERYDATE")%></Td>
				<td width="8%" align="center"><%=hdrXML.getFieldValueString(i,"CURRENCY")%></td>
				<Td align="right" width="14%"><%=ret.getFieldValueString(i,"NETAMOUNT")%></Td>
			</tr>
<%	
		}
%>
		</Table>
		</Div>
		<Div align=center style="position:absolute;top:91%;visibility:visible;width:100%">
		<span id="EzButtonsSpan" >
		</span>
				<span id="EzButtonsMsgSpan" style="display:none">
				<Table align=center>
					<Tr>
						<Td class="labelcell">Your request is being processed... Please wait</Td>
					</Tr>
				</Table>
		</span>
		</Div>
<%
	}
%>
	
</Form>
<Div id="MenuSol"></Div>
</Body>
</Html>

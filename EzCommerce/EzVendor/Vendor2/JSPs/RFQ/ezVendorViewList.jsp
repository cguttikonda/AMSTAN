<%//@ include file="../../Library/Globals/errorPagePath.jsp" %>


<%@include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iblockcontrol.jsp" %>
<%@ include file="../../../Includes/JSPs/Rfq/iListSOS.jsp" %>
<%@ include file="../../../Includes/JSPs/Misc/iGetVendorDesc.jsp"%>
<%@ page import="java.util.*" %>
<html>
<head>
<Script>
function funBack()
{
	var backflag ='<%=backChk%>'; 
	if(backflag=='MAT')
		document.myForm.action="ezPreSelectVendors.jsp";
	else 
		document.myForm.action="ezListPR.jsp";
	/*if(backflag=='PRS')
		document.myForm.action="ezListPR.jsp";
	else
		document.myForm.action="ezListPR.jsp?Status=R";	
	*/	 
	
	
	document.myForm.submit();
}
function getAgmtDtl(agmtNo)
{
	var url="ezGetAgreementDetails.jsp?agmtNo="+agmtNo;
	var sapWindow=window.open(url,"newwin","width=500,height=350,left=270,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
}

function ezAlphabet(alphabet)
{
	document.myForm.tabNo.value='2';
	searchstring=alphabet+"*";
	if(searchstring=="All*")
		document.myForm.searchcriteria.value="";
	else
		document.myForm.searchcriteria.value=searchstring;
	if(searchstring!=null)
	{
		if(searchstring.length!=0)
		{
			document.myForm.action="ezVendorViewList.jsp";
			document.myForm.submit();
		}
	}
}

function showQMInfo(vendorNo)
{
	var material = document.myForm.material.value
	var plant = document.myForm.plant.value
	
	var retValue = window.showModalDialog("ezQMInfo.jsp?material="+material+"&plant="+plant+"&vendor="+vendorNo,window.self,"center=yes;dialogHeight=35;dialogWidth=45;help=no;titlebar=no;status=no;minimize:yes")		
}
function createPO()
{

	/*if(!checkRoleAuthorizations("ADD_PO"))
	{
		alert("You are not authorized to create Purchase Order");
		return;
	}*/
	
	
	
        appendQuantities();   
     	var len = document.myForm.selChk.length     
     	var Count = 0;
     	var valCount = 0; 
     	var vendType; 
     	if(!isNaN(len))
     	{
     		for(var i=0;i<len;i++)
     		{
    		     if(document.myForm.selChk[i].checked)
     		     {
			   Count++;										     			
			   var str = document.myForm.selChk[i].value
			//alert("*str**"+str);   
			   //alert(str);
			   var values = str.split("#")
			   if(values[0]=="-" && values[3]=="A")
			   {
				valCount++;		   
			   }
			   else if(values[3]=="S")
			   {
				vendType ="S";	
			   }
     		     }
     		}	
     	}
     	else
     	{
     		if(document.myForm.selChk.checked)
     		{
     		    Count++;	
     		    var str = document.myForm.selChk.value
     		    //alert("*else str**"+str);   
		    var values = str.split("#")		   
		    if(values[0]=="-"  && values[3]=="A")
		    {
		    	valCount++;
		    }
		     else if(values[3]=="S")
		    {
		    	vendType ="S";	
		    }
     		}
     	}
	if(vendType=="S")
	{
		alert("You can not Create PO with Non Approved Vendors");
		return;
	}
     	else if(Count == 0 || valCount > 0)	
     	{
     		alert("Please Select Vendor With Contract To Create PO");
     		return;
     	}
     	else if(Count > 1)	
     	{
     		alert("Please Select Only One Vendor With Contract To Create PO");
     		return;
     	}     
     	
     	var plantObj=document.myForm.plant;
	if(plantObj!=null && plantObj.value=="NA")
	{
		alert("You can't create PO without selecting plant,Please select plant from material search to create PO")
		return false;
	}
     	
     	var vndr = "";
     	var qty = "";
     	var len = document.myForm.selChk.length;
     	if(!(isNaN(len)))
     	{
		for(var i=0;i<len;i++)
		{
			if(document.myForm.selChk[i].checked)
			{
				vndr = document.myForm.selChk[i].value;
				qty =  document.myForm.qtyTxt[i].value;
			}	
		}
     	}
     	else
     	{
     		vndr = document.myForm.selChk.value;
     		qty =  document.myForm.qtyTxt.value;
     	}
     	var chkdStr = vndr.split("#");
   	
   	buttonsSpan	  = document.getElementById("EzButtonsSpan");
	buttonsMsgSpan	  = document.getElementById("EzButtonsMsgSpan");
	if(buttonsSpan!=null)
	{
	     	buttonsSpan.style.display	= "none"
	        buttonsMsgSpan.style.display	= "block"
     	}
     	
     	var url = "ezPopPoCreate.jsp?vendor="+chkdStr[1]+"&Quantity="+qty+"&valtype="+document.myForm.valuationType.value;
	dialogvalue=window.showModalDialog(url,window.self,"center=yes;dialogHeight=30;dialogWidth=40;help=no;titlebar=no;status=no;resizable=no")
	
	if(dialogvalue=="SUBMIT")
	{
		document.myForm.action="ezCreatePOByPopUp.jsp";
		document.myForm.submit();
	}
	else
	if(dialogvalue=="Cancel")
	{
		buttonsSpan	  = document.getElementById("EzButtonsSpan");
		buttonsMsgSpan	  = document.getElementById("EzButtonsMsgSpan");
		if(buttonsSpan!=null)
		{
			buttonsSpan.style.display	= "block"
			buttonsMsgSpan.style.display	= "none"
     		}
	}
	else
	{
		buttonsSpan	  = document.getElementById("EzButtonsSpan");
		buttonsMsgSpan	  = document.getElementById("EzButtonsMsgSpan");
		if(buttonsSpan!=null)
		{
			buttonsSpan.style.display	= "block"
			buttonsMsgSpan.style.display	= "none"
		}

     	}
	
     	
/*     	
     	buttonsSpan	  = document.getElementById("EzButtonsSpan")
     	buttonsMsgSpan	  = document.getElementById("EzButtonsMsgSpan")
     	if(buttonsSpan!=null)
     	{
     	      	buttonsSpan.style.display	= "none"
           	buttonsMsgSpan.style.display	= "block"
     	}
     	document.myForm.action = "ezCreatePO.jsp";
     	document.myForm.submit();
*/     	

}


function checkVendor()
{
	var vendChkObj 		= 	document.myForm.selChk
	var vendChkObjLen	=	vendChkObj.length
	var chkdValue 		= 	""
	var ezAppVendors 	= new Array()
	var ezAppAgents 	= new Array()
	var vndCount 	= 0;
	var agntCount 	= 0;

	if(!isNaN(vendChkObjLen))
	{
		for(i=0;i<vendChkObjLen;i++)
		{
			if(vendChkObj[i].checked)
			{
				chkdValue = (vendChkObj[i].value).split("#")
				if(chkdValue[3] == "A")
				{
					ezAppVendors[vndCount] = chkdValue[1]
					vndCount++
				}
				if(chkdValue[3] == "N")
				{
					ezAppAgents[agntCount] = ((chkdValue[1]).split("$"))[0]
					agntCount++
				}

			}
		}
	}

	vndCount	=	ezAppVendors.length;
	agntCount	=	ezAppAgents.length;

	var checkFlag = false

	for(i=0;i<vndCount;i++)
	{
		for(j=0;j<agntCount;j++)
		{
			if(ezAppVendors[i]	==	ezAppAgents[j])
			{
				alert("Agent for the selected approved vendor "+ezAppVendors[i]+" cannot be selected to create the RFQ")
				checkFlag = true
				break;
			}
		}
	}

	return checkFlag;
}

function createRFQ()
{

	if(qtyFun())
	{
					
		appendQuantities();
		var reqDate = document.myForm.reqDate.value;
		var len = document.myForm.selChk.length
		var Count = 0;
		var valCount = 0; 
		var agrmntCount = 0;
		var soldTos = "";

		if(!isNaN(len))
		{
			for(var i=0;i<len;i++)
			{
				if(document.myForm.selChk[i].checked)
				{
					var str = document.myForm.selChk[i].value
					var values = str.split("#")		   
					if(values[0]=="AGR")
					{
						document.myForm.selChk[i].value = values[0]+"#"+values[1]+"#"+document.myForm.qtyTxt[i].value+"#"+"A";
						//alert(document.myForm.selChk[i].value);
						agrmntCount++;		   
					}
					else
					{
						valCount++;		   
					}

					if(Count == 0)
						soldTos = values[0]
					else	
						soldTos += ","+values[0]
					Count++;	
				}
			}	
		}
		else
		{
			if(document.myForm.selChk.checked)
			{

				var str = document.myForm.selChk.value     	    
				var values = str.split("#")		   
				if(values[0]=="AGR")
				{
					document.myForm.selChk.value = values[0]+"#"+document.myForm.qtyTxt.value+"#"+values[2]+"#"+"A";
					agrmntCount++;		   
				}
				else
				{
					valCount++;		   
				}
				soldTos = values[0]
				Count++;
			}
		}


		if(Count == 0)	
		{
			alert("Please Select Atleast One Vendor To Create RFQ");
			return;
		}


		if(agrmntCount > 0)
		{
			//alert("Please Select Only Vendors Without Contract To Create RFQ");

			if(!confirm("Contract already exists for selected vendor(s).Do you want to create RFQ for selected vendor(s)?"))
			return;
		}


		if(checkVendor())
			return;

		var entryWindow;
		buttonsSpan	  = document.getElementById("EzButtonsSpan");
		buttonsMsgSpan	  = document.getElementById("EzButtonsMsgSpan");
		if(buttonsSpan!=null)
		{
			buttonsSpan.style.display	= "none"
			buttonsMsgSpan.style.display	= "block"
		}
		arguments = document.myForm.qtnEndDate.value;
		material  = document.myForm.material.value;
		matDesc	  = document.myForm.matDesc.value;
		entryWindow = window.showModalDialog("ezEnterEndDate.jsp?reqDate="+reqDate+"&material="+material+"&soldTos="+soldTos+"&matDesc="+matDesc,arguments,"center=yes;dialogHeight=30;dialogWidth=30;help=no;titlebar=no;status=no;minimize:yes")

		if((entryWindow!="Cancel") && (entryWindow!=null))
		{
			buttonsSpan	  = document.getElementById("EzButtonsSpan")
			buttonsMsgSpan  = document.getElementById("EzButtonsMsgSpan")
			if(buttonsSpan!=null)
			{
				buttonsSpan.style.display	= "none"
				buttonsMsgSpan.style.display	= "block"
			}
			var entryWindowValues = entryWindow.split('##');
			document.myForm.qtnEndDate.value=entryWindowValues[0];
			document.myForm.commentText.value=entryWindowValues[1];
			document.myForm.collNo.value=entryWindowValues[2];
			document.myForm.delivDate.value=entryWindowValues[3];
			document.myForm.matDesc.value=entryWindowValues[4];
			document.myForm.action="ezCreateRFQ.jsp";
			document.myForm.submit(); 
		}
		else
		{
			buttonsSpan	  = document.getElementById("EzButtonsSpan");
			buttonsMsgSpan	  = document.getElementById("EzButtonsMsgSpan");
			if(buttonsSpan!=null)
			{
				buttonsSpan.style.display	= "block"
				buttonsMsgSpan.style.display	= "none"
			}

		}
     	}	
}	 



function appendQuantities()
{
	if(document.myForm.selChk != null)
	{
		var approvedVendorLength = document.myForm.selChk.length
		if(!isNaN(approvedVendorLength))
		{
			for(i=0;i<approvedVendorLength;i++)
			{
				if(document.myForm.selChk[i].checked)
				{
			
					var chkdValue = document.myForm.selChk[i].value
					//alert("*chkdValue**"+chkdValue);
					var chkdArgs = chkdValue.split('#')
					if(chkdArgs[0] == "AGR")
						document.myForm.selChk[i].value = "AGR#"+chkdArgs[1]+"#"+chkdArgs[2]+"#"+document.myForm.qtyTxt[i].value+"#"+chkdArgs[3]
					else
						document.myForm.selChk[i].value = "-#"+chkdArgs[1]+"#"+document.myForm.qtyTxt[i].value+"#"+chkdArgs[3]
						
					//alert(i+"**"+document.myForm.selChk[i].value);
				}
			}
		}
		else
		{
			if(document.myForm.selChk.checked)
			{
				var chkdValue = document.myForm.selChk.value
				//alert("else *chkdValue**"+chkdValue);
				var chkdArgs = chkdValue.split('#')
				if(chkdArgs[0] == "AGR")
					document.myForm.selChk.value = "AGR#"+chkdArgs[1]+"#"+chkdArgs[2]+"#"+document.myForm.qtyTxt.value+"#"+chkdArgs[3]
				else	
					document.myForm.selChk.value = "-#"+chkdArgs[1]+"#"+document.myForm.qtyTxt.value+"#"+chkdArgs[3]
				//alert("else="+i+"**"+document.myForm.selChk[i].value);
			}	
		}
	}
}
function funShowVndrDetails(syskey,soldto)
{
	var retValue = window.showModalDialog("ezVendorContactDetails.jsp?SysKey="+syskey+"&SoldTo="+soldto,window.self,"center=yes;dialogHeight=25;dialogWidth=40;help=no;titlebar=no;status=no;minimize:yes")	
}

function qtyFun()
{
	qtyFlag = true;
	var approvedVendorLength = document.myForm.selChk.length
	if(!isNaN(approvedVendorLength))
	{
		for(i=0;i<approvedVendorLength;i++)
		{
		
			if(document.myForm.selChk[i].checked)
			{
				var qtyObj	= document.myForm.qtyTxt[i];
				var qtyVal	= qtyObj.value;
				var qtyLen	= qtyVal.length;

				if(qtyVal.indexOf('.')!=-1)
				{
					if(qtyLen>13)
					{
						alert("Quantity value Exceeded")
						qtyFlag = false;
					}
					else
					{
						var substr = qtyVal.substring(qtyVal.indexOf('.')+1,qtyLen);
						if(substr.length>3)
						{
							alert("Quantity value Exceeded")
							qtyFlag = false;
							document.myForm.qtyTxt[i].focus();
							break;
						}	
					}
				}
				else
				{
					if(qtyLen>9)
					{
						alert("Quantity value Exceeded")
						qtyFlag = false;
						document.myForm.qtyTxt[i].focus();
						break;
					}

				}	
				
			}
		}
	}
	else
	{
		if(document.myForm.selChk.checked)
		{
			var qtyObj	= document.myForm.qtyTxt;
			var qtyVal	= qtyObj.value;
			var qtyLen	= qtyVal.length;

			if(qtyVal.indexOf('.')!=-1)
			{
				if(qtyLen>13)
				{
					alert("Quantity Exceeded")
					qtyFlag = false;
				}
				else
				{
					var substr = qtyVal.substring(qtyVal.indexOf('.')+1,qtyLen);
					if(substr.length>3){
						alert("Quantity value Exceeded")
						qtyFlag = false;
						document.myForm.qtyTxt.focus();
					}	
				}				
			}
			else
			{
				if(qtyLen>9)
				{
					alert("Quantity value Exceeded")
					qtyFlag = false;
					document.myForm.qtyTxt.focus();
					//break;
				}

			}
					
		}
	}
	return qtyFlag;
}

</Script>
</head>
<%
	int tabCount = 3;  
	java.util.Hashtable tabHash = new java.util.Hashtable();
	tabHash.put("TAB1","Source List");
	tabHash.put("TAB2","SAP Vendors");
	tabHash.put("TAB3","Non SAP Vendors");	
	
	String tabNum = "1";
	if(request.getParameter("tabNo")!=null)
		tabNum = "2"; 
%>
<!--<body topmargin=0 rightmargin=0 leftmargin=0 onload="showDiv('<%=tabNum%>','<%=tabCount%>')">-->
<body topmargin=0 rightmargin=0 leftmargin=0 >
<form name="myForm" method="post">
<input type="hidden" name="searchcriteria" value="$">
<input type="hidden" name="ccKey"   	   value="">
<input type="hidden" name="hbId" 	   value="">
<input type="hidden" name="taxCode"    	   value="">
<input type="hidden" name="headerText" 	   value="">
<input type="hidden" name="shipInstr" 	   value="">

<input type="hidden" name="itemText" 	   value="">	
<%
	String display_header = "Vendors List";
%>	
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<Br>


<Table align=center border=0 cellPadding=0 cellSpacing=0  width=90% height="80%">
	<Tr height=10>
	<Td class='blankcell'>
		<%//@ include file="../Misc/ezTabDisplay.jsp"%>	
	</Td>
	</Tr>
	<Tr>
	<Td valign="top" class='blankcell' style="background-color:'#E6E6E6'">	<BR>

		<Div id="tab1" style="overflow:auto;position:absolute;height:86%;width:100%;">
			<%@ include file="ezListSOS.jsp"%>    
		</Div>
		<!--<Div id="tab2" style="position:absolute;height:86%;width:100%;visibility:hidden">
			<%//@ include file="ezListIRL.jsp"%>
		</Div>
		<Div id="tab3" style="position:absolute;height:86%;width:100%;visibility:hidden">
			<%//@ include file="ezListAgents.jsp"%>
		</Div>-->
	</Td>
	</Tr>
</Table>	

<Div id="buttonDiv" align="center" style="position:absolute;left:0%;width:100%;top:90%">
<span id="EzButtonsSpan" >
<%
     buttonName = new java.util.ArrayList();
     buttonMethod = new java.util.ArrayList();
    
    buttonName.add("&nbsp;&nbsp;Back&nbsp;&nbsp");
  //  buttonName.add("&nbsp;&nbsp;Create&nbsp;PO&nbsp;&nbsp;");
    buttonName.add("&nbsp;&nbsp;Create&nbsp;RFQ&nbsp;&nbsp;");

    buttonMethod.add("funBack()");
    //buttonMethod.add("history.go(-1)");
   // buttonMethod.add("createPO()");
    buttonMethod.add("createRFQ()"); 

    out.println(getButtonStr(buttonName,buttonMethod));
%>
					  
	</span>
	<span id="EzButtonsMsgSpan" style="display:none">
	<Table align=center>
		<Tr>
			<Td class="labelcell">Your request is being processed... Please wait</Td>
		</Tr>
	</Table>
	</span>
				  
</Div>
<Script> 
<%
	//System.out.println("^^^^^^^^^^^^^^^^^^^^6"+request.getParameter("tabNo"));
	//if(request.getParameter("tabNo")!=null)
	//{
%>
		//alert('<%=request.getParameter("tabNo")%>');
		//showDiv(parseInt('<%=request.getParameter("tabNo")%>'));
<%
	//}
%>
</Script>
<input type="hidden" name="material"   value="<%=matNo%>">
<input type="hidden" name="matDesc"    value="<%=matDesc%>">
<input type="hidden" name="reqDate"    value="<%=delDate%>">
<input type="hidden" name="quantity"   value="<%=qty%>">
<input type="hidden" name="uom"        value="<%=uom%>">
<input type="hidden" name="plant"      value="<%=plant%>">
<input type="hidden" name="reqNo"      value="<%=reqNo%>">
<input type="hidden" name="prItmNo"    value="<%=itmNo%>">
<input type="hidden" name="qtnEndDate" value="">
<input type="hidden" name="delivDate"  value="">
<input type="hidden" name="commentText" value="">
<input type="hidden" name="collNo"     value="">
<input type="hidden" name="Status"     value="R">
<input type="hidden" name="purchReq1"  value="<%=purchReq%>">
<input type="hidden" name="vendor"  value="">
<input type="hidden" name="price"  value="26.00">
<%
	/************* The following hidden fields are for PO Creation ******************/

%>

<input type="hidden" name="docType"   	   value="">
<input type="hidden" name="valuationType"  value="<%=valType%>">
<input type="hidden" name="SOS" 	   value="SOS">	
<input type="hidden" name="purchaseHidden"   value="<%=purchReq%>">	
<input type="hidden" name="tabNo"   value="">	


<input type="hidden" name="matNo" value="<%=request.getParameter("matNo")%>">
<input type="hidden" name="selplant" value="<%=request.getParameter("selplant")%>">
<input type="hidden" name="fromDate" value="<%=request.getParameter("fromDate")%>">
<input type="hidden" name="toDate" value="<%=request.getParameter("toDate")%>">


<%	
	/************* The following is for storing pr details in db as for knowing RFQ created against PR(s) or not ******************/
	
	String purchRequisition[]=request.getParameterValues("purchReq");
	int prLen = 0;
	if(purchRequisition!=null)
		prLen = purchRequisition.length;
		
	for(int h=0;h<prLen;h++)
	{
%>		<input type=hidden name="purchReq" value="<%=purchRequisition[h]%>">
<%	}
%>

 
<Div id="MenuSol"></Div>
</form>
</body>
</html>

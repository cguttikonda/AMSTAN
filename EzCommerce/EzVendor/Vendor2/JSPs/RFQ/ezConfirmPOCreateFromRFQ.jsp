<%--*************************************************************************************

       /* Copyright Notice ===================================================
	* This file contains proprietary information of Answerthink Ind Ltd.
	* Copying or reproduction without prior written approval is prohibited.
	* Copyright (c) 2005-2006 =====================================*/
		Author: smaddipati
		Team:   EzcSuite
		Date:   30/09/2005
*****************************************************************************************--%>
<%@ page import = "ezc.ezparam.*,ezc.ezpreprocurement.params.*,ezc.ezbasicutil.*"%>
<%//@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ page import="java.util.*"%> 
<%@ page import="javax.xml.parsers.*,org.w3c.dom.*,ezc.ezparam.ReturnObjFromRetrieve" %>

<%@ include file="../../../Includes/Jsps/Rfq/iConfirmPOCreateFromRFQ.jsp"%>
<%@ include file="../../../Includes/Jsps/Rfq/iSelectIds.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iSbuPlantAddress.jsp"%>
<%
	ezc.ezutil.FormatDate fd = new ezc.ezutil.FormatDate();
	ResourceBundle TaxC = ResourceBundle.getBundle("EzTaxCodes");
	java.util.TreeMap taxTM = new java.util.TreeMap();
	Enumeration taxEnu =TaxC.getKeys();
	while(taxEnu.hasMoreElements())
	{
	String s2=(String)taxEnu.nextElement();
	taxTM.put(s2,TaxC.getString(s2));
	}
	Iterator taxIterator = null;
	Object taxObj = new Object();
%>
<Html>
<Head>
<Title>PO Creation From RFQ -- Powered By Answerthink.</Title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<%@ include file="../../../Includes/Jsps/Misc/iShowCal.jsp"%>

<Script src="../../Library/JavaScript/Rfq/ezViewRFQDetails.js"></Script>
<Script src="../../Library/JavaScript/ezTrim.js"></Script>
<Script>

var ezConfCtrlDiv=document.createElement("Div");
var ezConfCtrlPosX="";
var ezConfCtrlPosY="";

var lineType="";
var controlType="";

var ezTaxCodeDiv=document.createElement("Div");
var ezTaxCodePosX="";
var ezTaxCodePosY="";

function showMyDiv(myDivName,myId,PosX,PosY,type,conType)
{
	
	var myShowDiv=document.getElementById(myDivName);
	myShowDiv.style.visibility="hidden";
	var myObj=document.getElementById(myId);
	myShowDiv.style.top=findPosY(myObj)+"px"
	if(conType=='C')
		myShowDiv.style.left=findPosX(myObj)+"px";
	else
		myShowDiv.style.left=(findPosX(myObj)-170)+"px";
	myShowDiv.style.visibility="visible";
	ezConfCtrlPosX=PosX;
	ezConfCtrlPosY=PosY;
	lineType=type;
	controlType=conType;
	
	var myControlVal="";
	var myObjectControl="";
	var myObjectControlLen="";
	
	
	if(conType=='T'){
		if(lineType=='N')
		myObjectControl=eval("document.myForm.taxCode"+ezConfCtrlPosX);
		else
		myObjectControl=eval("document.myForm.rcTaxCode"+ezConfCtrlPosX);
	}else{
		if(lineType=='N')
		myObjectControl=eval("document.myForm.ccKey"+ezConfCtrlPosX);
		else
		myObjectControl=eval("document.myForm.rcCCKey"+ezConfCtrlPosX);
		
	}
	
	myObjectControlLen=myObjectControl.length;
	if(isNaN(myObjectControlLen)){
		myControlVal=funTrim(myObjectControl.value);
	}else{
		myControlVal=funTrim(myObjectControl[ezConfCtrlPosY].value);
	}
	
	
	
	
	var myConfCtrlSel="";
	if(myDivName=='ezConfCtrlDiv'){
		myConfCtrlSel=document.getElementById("myConfCtrl");
	}else{
		myConfCtrlSel=document.getElementById("myTaxCode");
	}
	
	if(myControlVal!="")
	myConfCtrlSel.value=myControlVal;
	
	myConfCtrlSel.focus();
	
}

function selectedVal()
{
	
	
	var obj="";
	if('C'==controlType){
		obj=document.getElementById("myConfCtrl");
	}else{
		obj=document.getElementById("myTaxCode");
	}
	if(obj.selectedIndex==-1)
	{
		if('C'==controlType){
			alert("Please select confirmation control");
		}else if('T'==controlType){
			alert("Please select tax code");
		}	
	}else{
		ezConfCtrlDiv.style.visibility="hidden";
		ezTaxCodeDiv.style.visibility="hidden";
		var mySetField="";
		if('C'==controlType){
			if(lineType=='N')
			mySetField=eval("document.myForm.ccKey"+ezConfCtrlPosX);
			else
			mySetField=eval("document.myForm.rcCCKey"+ezConfCtrlPosX);
		}else{
			if(lineType=='N')
			mySetField=eval("document.myForm.taxCode"+ezConfCtrlPosX);
			else
			mySetField=eval("document.myForm.rcTaxCode"+ezConfCtrlPosX);
		}
			
		var len=mySetField.length;
		if(isNaN(len)){
			mySetField.value=obj.value;
		}else{
			mySetField[ezConfCtrlPosY].value=obj.value;
		}
		
		
		
		
	}

}



function findPosX(obj)
{
	var curleft = 0;
	if (obj.offsetParent)
	{
		while (obj.offsetParent)
		{
			curleft += obj.offsetLeft
			obj = obj.offsetParent;
		}
	}
	else if (obj.x)
		curleft += obj.x;
	curleft=curleft-160;
	return curleft;
}

function findPosY(obj)
{
	var curtop = 0;
	if (obj.offsetParent)
	{
		while (obj.offsetParent)
		{
			curtop += obj.offsetTop
			obj = obj.offsetParent;
		}
	}
	else if (obj.y)
		curtop += obj.y;

	curtop=curtop+16;
	return curtop;
}

function ezCCDivOut()
{
	ezConfCtrlDiv.style.visibility="hidden";
	ezTaxCodeDiv.style.visibility="hidden";
}

function ezMakeDivs()
{
	document.body.appendChild(ezConfCtrlDiv);
	var htmlStr="<Table border='0' >";
	//htmlStr+="<Tr><Td align='center'>Select Confirmation Control</Td></Tr>";
	htmlStr+="<Tr><Td>";
	htmlStr+="<Select name='myConfCtrl' id='myConfCtrl' size='4' onBlur='ezCCDivOut();' onClick='selectedVal();'>";
	<%						
		for(int inConCKey=0;inConCKey<confctrlKeys.length;inConCKey++)
		{
	%>
			htmlStr+="<Option value='<%=confctrlKeys[inConCKey][0]%>'><%=confctrlKeys[inConCKey][1]%></Option>";
	
	<%	      
		}
	%>		
	
	htmlStr+="<Select>";
	htmlStr+="</Td></Tr>";
	htmlStr+="</Table>";
	
	ezConfCtrlDiv.innerHTML=htmlStr;
	
	with(ezConfCtrlDiv)
	{
		id="ezConfCtrlDiv"
		style.position="absolute"
		style.top="0px"
		style.visibility="hidden";
	}
	
	
	document.body.appendChild(ezTaxCodeDiv);
	var htmlStr="<Table border='0' >";
	//htmlStr+="<Tr><Td align='center'>Select Tax Code</Td></Tr>";
	htmlStr+="<Tr><Td>";
	htmlStr+="<Select name='myTaxCode' id='myTaxCode' size='10' onBlur='ezCCDivOut();' onClick='selectedVal();'>";
	<%						
		taxIterator = taxTM.keySet().iterator();
		while(taxIterator.hasNext())
		{
			taxObj = taxIterator.next();
			String taxStr = taxObj.toString();
	%>
			htmlStr+="<Option value='<%=taxStr%>'><%=taxStr+"-->"+taxTM.get(taxStr)%></Option>";
	
	<%	      
		}
	%>		
	
	htmlStr+="<Select>";
	htmlStr+="</Td></Tr>";
	htmlStr+="</Table>";
	
	ezTaxCodeDiv.innerHTML=htmlStr;
	
	with(ezTaxCodeDiv)
	{
		id="ezTaxCodeDiv"
		style.position="absolute"
		style.top="0px"
		style.visibility="hidden";
	}
	
	
	

}

function addLine(index)
{

	var tabObj		= document.getElementById("ezRCItemTab"+index)
	var rowItems 		= tabObj.getElementsByTagName("tr");
	var rowCountValue 	= rowItems.length;
	
	var myRCObj=eval("document.myForm.rcMat"+index);
	var myRCObjLen=myRCObj.length;
	if(isNaN(myRCObjLen)) myRCObjLen="1";
	

	eleWidth = new Array();
	eleAlign = new Array();
  	eleVal   = new Array();

	eleWidth[0]  = "10%";	eleAlign[0] = "left";
	eleWidth[1]  = "12%";	eleAlign[1] = "left";
	eleWidth[2]  = "12%";	eleAlign[2] = "left";
	eleWidth[3]  = "7%";	eleAlign[3] = "left";
	eleWidth[4]  = "4%";	eleAlign[4] = "left";
	eleWidth[5]  = "7%";	eleAlign[5] = "left";
	eleWidth[6]  = "8%";	eleAlign[6] = "left";
	eleWidth[7]  = "6%";	eleAlign[7] = "left";
	eleWidth[8]  = "11%";	eleAlign[8] = "left";
	eleWidth[9]  = "11%";	eleAlign[9] = "center";
	eleWidth[10] = "8%";	eleAlign[10]= "center";
	eleWidth[11] = "4%";	eleAlign[11]= "center";

	eleVal[0] ='<input type="text" name="rcMat'+index+'" class="InputBox" size="8" value=""><img src="../../Images/Buttons/<%=ButtonDir%>/find.gif" style="cursor:hand" height="18" alt="Find" onClick="javascript:searchMatByNumber(\''+index+'\',\''+myRCObjLen+'\',\'CODE\')">';
	eleVal[1] ='<input type="text" name="rcMatDesc'+index+'" class="InputBox" size="13" value=""><img src="../../Images/Buttons/<%=ButtonDir%>/find.gif" style="cursor:hand" height="18" alt="Find" onClick="javascript:searchMatByNumber(\''+index+'\',\''+myRCObjLen+'\',\'DESC\')">';
	eleVal[2] ='<input type="text" name="rcDelDt'+index+myRCObjLen+'" class="InputBox" size=11 value="'+document.myForm.toDayDate.value+'" readonly> <img src="../../Images/calender.gif" style="cursor:hand" height="20" onClick=showCal("document.myForm.rcDelDt'+index+myRCObjLen+'",205,200,"<%=cDate%>","<%=cMonth%>","<%=cYear%>") >';
	eleVal[3] ='<input type="text" name="rcPOQty'+index+'" class="InputBox" size="7" value="">';
	eleVal[4] ='<Select name="rcUOM'+index+'"><Option value="KG">KG</Option><Option value="LT">LT</Option></Select>';
	eleVal[5] ='<select name="rcPlant'+index+'" style="width:100%" >';
<%	  						
	for(int p=0;p<count;p++)
	{
%>	
		eleVal[5] +='<option value="<%=ret.getFieldValueString(p,"CODE")%>"><%=ret.getFieldValueString(p,"CODE")%></option>';
<%	   						
	}
%>  

	eleVal[5] +='</select>';
	eleVal[6] ='<input type="text" name="rcSLoc'+index+'" class="InputBox" size="8" value="">';
	eleVal[7] ='<select name="rcFOC'+index+'"><option value="Y">Yes</option><option value="N">No</option></select>';
	eleVal[8] ='<select name="rcValType'+index+'" style="width:100%" id="ListBox1Div"><option value="">-Valuation Type-</option>';

<%				

	for(int inVType=0;inVType<valuationTypes.length;inVType++)			
	{	

%>					
		eleVal[8] +='<option value="<%=valuationTypes[inVType]%>" ><%=(valuationTypes[inVType]).replace('\'','`')%></option>'
<%					
	}			
%>
	eleVal[8] +='</select>';


	eleVal[9] ='<input type="text" class="InputBox" value="" size="8" name="rcTaxCode'+index+'" >';
	eleVal[9]+='<Div id="myRCTCDiv'+index+myRCObjLen+'" style="position:absolute"><a style="text-decoration:none" id="myAn" onClick="showMyDiv(\'ezTaxCodeDiv\',\'myRCTCDiv'+index+myRCObjLen+'\',\''+index+'\',\''+myRCObjLen+'\',\'R\',\'T\')"><b><img src="../../Images/Buttons/<%=ButtonDir%>/down_arrow.gif" style="cursor:hand" height="18" alt="Select" ></a></Div>';
	eleVal[10]='<input type="text" class="InputBox" size="5" value="" name="rcCCKey'+index+'">';
	eleVal[10]+='<Div id="myRCCCDiv'+index+myRCObjLen+'" style="position:absolute"><a style="text-decoration:none" id="myAn" onClick="showMyDiv(\'ezConfCtrlDiv\',\'myRCCCDiv'+index+myRCObjLen+'\',\''+index+'\',\''+myRCObjLen+'\',\'R\',\'C\')"><b><img src="../../Images/Buttons/<%=ButtonDir%>/down_arrow.gif" style="cursor:hand" height="18" alt="Select" ></a></Div>';
	eleVal[11]='<input type="hidden" name="rcText'+index+'" value=""><a href="javascript:onClick=rcItemText(\''+index+'\',\''+myRCObjLen+'\')"><img   src="../../Images/Buttons/<%=ButtonDir%>/edit-button.gif" border="none" valign=bottom style="cursor:hand"></a>';
	var elementsArray = "";
	var rowId = tabObj.insertRow(rowCountValue);
	for(i=0; i<eleVal.length;i++){
		var cell0=rowId.insertCell(i);
		cell0.width = eleWidth[i];
		cell0.align = eleAlign[i];
		cell0.innerHTML =eleVal[i];
	}


}
function createPO()
{
	var rfqVendors="<%=rfqVendors.size()%>";
<%
	for(int v=0;v<rfqVendors.size();v++)
	{
%>
		var qtyObj = eval("document.myForm.poQty<%=v%>");
		var qtyObjLen=qtyObj.length;

		var rcMatObj = eval("document.myForm.rcMat<%=v%>");
		var rcMatObjLen=rcMatObj.length;
		var rcMatDescObj = eval("document.myForm.rcMatDesc<%=v%>");
		var rcPOQtyObj=eval("document.myForm.rcPOQty<%=v%>");

		if(isNaN(document.myForm.vendor.length))
		{
			vendor = document.myForm.vendor.value;
			if(document.myForm.docType.value == "")
			{
				alert("Please select Document Type for Vendor "+vendor);
				document.myForm.docType.focus();
				return;

			}


		}else{
			vendor = document.myForm.vendor[<%=v%>].value;
			if(document.myForm.docType[<%=v%>].value == "")
			{
				alert("Please select Document Type for Vendor "+vendor);
				document.myForm.docType[<%=v%>].focus();
				return;
			}

		} 
		if(isNaN(qtyObjLen))
		{
			if(isNaN(qtyObj.value)|| qtyObj.value<=0){
				alert("Qunatity should be grater than or equals to zero");
				qtyObj.focus();
				return;
			}
		}else{
			var bval=false;
			for(i=0;i<qtyObjLen;i++){
			if(isNaN(qtyObj[i].value))
			bval=true;
			else if(qtyObj[i].value>0)
			bval=true;
			}
			if(!bval){
				if(rfqVendors=="1")
					vendor = document.myForm.vendor.value;
				else
					vendor = document.myForm.vendor[<%=v%>].value;

				alert("Please enter atleast one material quantity for the vendor :"+vendor);
				return;
			}
		}
    
		if(isNaN(rcMatObjLen))
		{
			rcMatVal=funTrim(rcMatObj.value);
			rcMatDescVal=funTrim(rcMatDescObj.value);
			rcDelDtObj=eval("document.myForm.rcDelDt<%=v%>0");
			rcDelDtVal=funTrim(rcDelDtObj.value);
			rcPOQtyObjVal=funTrim(rcPOQtyObj.value);

			if(rcMatVal!=""){
				if(rcMatDescVal==""){
					alert("Please enter material description");
					rcMatDescObj.focus();
					return;
				}else if(rcDelDtVal==""){
					alert("Please enter delivery date");
					rcDelDtObj.focus();
					return;
				}else if(rcPOQtyObjVal==""){
					alert("Please enter valid quantity");
					rcPOQtyObj.focus();
					return;

				}else if(isNaN(rcPOQtyObjVal) || rcPOQtyObjVal==0){
					alert("Please enter valid quantity");
					rcPOQtyObj.focus();
					return;
				}


			}

		}else{
			for(i=0;i<rcMatObjLen;i++)
			{
				rcMatVal=funTrim(rcMatObj[i].value);

				rcMatDescVal=funTrim(rcMatDescObj[i].value);
				rcDelDtObj=eval("document.myForm.rcDelDt<%=v%>"+i);
				rcDelDtVal=funTrim(rcDelDtObj.value);
				rcPOQtyObjVal=funTrim(rcPOQtyObj[i].value);
				if(rcMatVal!=""){
					if(rcMatDescVal==""){
						alert("Please enter material description");
						rcMatDescObj[i].focus();
						return;
					}else if(rcDelDtVal==""){
						alert("Please enter delivery date");
						rcDelDtObj.focus();
						return;
					}else if(rcPOQtyObjVal==""){
						alert("Please enter valid quantity");
						rcPOQtyObj[i].focus();
						return;
					}else if(isNaN(rcPOQtyObjVal) || rcPOQtyObjVal==0){
						alert("Please enter valid quantity");
						rcPOQtyObj[i].focus();
						return;
					}
				}	


			}
		}


<%
	}
%>

		

	buttonsSpan	  = document.getElementById("EzButtonsSpan")
	buttonsMsgSpan  = document.getElementById("EzButtonsMsgSpan")
	if(buttonsSpan!=null)
	{
	buttonsSpan.style.display	= "none"
	buttonsMsgSpan.style.display	= "block"
	}


	document.myForm.target="_self";
	document.myForm.action="ezCreateRbxPOFromRFQ.jsp";
	document.myForm.submit();
}
  
function showLabel(indx)
{
	var len = '<%=rfqVendors.size()%>';
	if(len>1)
	{
		var condVal = document.myForm.docType[indx].value;
		var ccKeyObj=eval("document.myForm.ccKey"+indx);
		var rfqObj=eval("document.myForm.rfqNo"+indx);
		var ccKeyObjLen=rfqObj.length;
		var hbidObj=document.myForm.hbId[indx];

		if(condVal=='ZCPI' || condVal=='ZFGI' || condVal=='ZRFI' || condVal=='ZRMI')
		{
			hbidObj.disabled=false;
			if(isNaN(ccKeyObjLen))
			{
			ccKeyObj.disabled=false;
			ccKeyObj.selectedIndex=2;
			}else{
				for(var i=0;i<ccKeyObjLen;i++){
					ccKeyObj[i].disabled=false;
					ccKeyObj[i].selectedIndex=2;
				}
			}
		}
		else
		{

			hbidObj.selectedIndex=0;
			hbidObj.disabled=true;
			if(isNaN(ccKeyObjLen))
			{
				ccKeyObj.selectedIndex=0;
				ccKeyObj.disabled=true;
			}else{
				for(var i=0;i<ccKeyObjLen;i++){
					ccKeyObj[i].selectedIndex=0;
					ccKeyObj[i].disabled=true;
				}
			}

		}
	}
	else
	{
		var condVal = document.myForm.docType.value;
		var ccKeyObj=eval("document.myForm.ccKey"+indx);
		var rfqObj=eval("document.myForm.rfqNo"+indx);
		var ccKeyObjLen=rfqObj.length;

		if(condVal=='ZCPI' || condVal=='ZFGI' || condVal=='ZRFI' || condVal=='ZRMI')
		{

			document.myForm.hbId.disabled=false;
			if(isNaN(ccKeyObjLen))
			{

				ccKeyObj.disabled=false;
				ccKeyObj.selectedIndex=2;

			}else{
				for(var i=0;i<ccKeyObjLen;i++){

					ccKeyObj[i].disabled=false;
					ccKeyObj[i].selectedIndex=2;

				}
			}

		}else{

			document.myForm.hbId.selectedIndex=0;
			document.myForm.hbId.disabled=true;
			if(isNaN(ccKeyObjLen))
			{
				ccKeyObj.selectedIndex=0;
				ccKeyObj.disabled=true;
			}else{
				for(var i=0;i<ccKeyObjLen;i++){
					ccKeyObj[i].selectedIndex=0;
					ccKeyObj[i].disabled=true;
				}
			}

		}
	}
}
function headerText(indx,flg)
{
	var headText;
	var index;
	var len=document.myForm.headerText.length;

	if(isNaN(len)){
		if("H"==flg)
			headText=document.myForm.headerText.value;
		else
			headText=document.myForm.shipmentText.value;

	}else{
		if("H"==flg)
			headText=document.myForm.headerText[indx].value;
		else
			headText=document.myForm.shipmentText[indx].value;

	}

	document.myForm.target = "PopUp";
	document.myForm.action= "../Rfq/ezGetHeaderText.jsp?headText="+headText+"&rowIndex="+indx+"&flag="+flg;
	newWindow=window.open("","PopUp","width=550,height=300,left=280,top=200,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=no");
	document.myForm.onsubmit = newWindow;
	document.myForm.submit();

}
	
	
function itemText(hdrIndx,itemIndx)
{
	var itemText;
	var index;

	if(isNaN(eval("document.myForm.itemText"+hdrIndx).length))
	{
		itemText=eval("document.myForm.itemText"+hdrIndx).value;
	}else{
			itemText=eval("document.myForm.itemText"+hdrIndx)[itemIndx].value;
	}

	document.myForm.target = "PopUp";
	document.myForm.action= "../Rfq/ezGetItemTextRFQPO.jsp?itemText="+itemText+"&hdrIndx="+hdrIndx+"&itemIndx="+itemIndx;
	newWindow=window.open("","PopUp","width=550,height=300,left=280,top=200,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=no");
	document.myForm.onsubmit = newWindow;
	document.myForm.submit();
}
	
function rcItemText(hdrIndx,itemIndx)
{
	var itemText;


	if(isNaN(eval("document.myForm.rcText"+hdrIndx).length))
	{
		itemText=eval("document.myForm.rcText"+hdrIndx).value;
	}else{
			itemText=eval("document.myForm.rcText"+hdrIndx)[itemIndx].value;
	}

	document.myForm.target = "PopUp";
	document.myForm.action= "../Rfq/ezGetRCItemTextRFQPO.jsp?itemText="+itemText+"&hdrIndx="+hdrIndx+"&itemIndx="+itemIndx;
	newWindow=window.open("","PopUp","width=550,height=300,left=280,top=200,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=no");
	document.myForm.onsubmit = newWindow;
	document.myForm.submit();
}
	
	
function checkQty(qtyObj,pendingQty)
{
	var quantity = qtyObj.value;

	if(quantity != "")
	{
		if(isNaN(quantity))
		{

			alert("Please enter valid quantity");
			qtyObj.focus();
			return;

		}
		else if(parseFloat(quantity) > parseFloat(pendingQty))
		{
			alert("PO quantity should be less than or equals to pending quantity : "+pendingQty);
			qtyObj.focus();
			return;
		}

	}

}
	
function searchMatByNumber(index,itemIndex,searchType)
{
	var myObj=eval("document.myForm.rcMat"+index);
	var myObj1=eval("document.myForm.rcMatDesc"+index);
	
	var objLen=myObj.length;
	var matNo="";
	var matDesc="";
	
	if(isNaN(objLen)){
		matNo= myObj.value; 
		matDesc=myObj1.value;
	}else{
		matNo= myObj[itemIndex].value; 
		matDesc=myObj1[itemIndex].value; 
	}
	
	if(searchType=="DESC"){
		if(matDesc=="")
		{
			alert("Please enter material description");
			if(isNaN(objLen))
			myObj1.focus();
			else
			myObj1[itemIndex].focus();
			return;
		}
	}else{
		if(matNo=="")
		{
			alert("Please enter material number");
			if(isNaN(objLen))
			myObj.focus();
			else
			myObj[itemIndex].focus();
			return;
		}
	}

	var url="ezReturnableContainerMtrlSearch.jsp?matCode="+matNo+"&myIndex="+index+"&itemIndex="+itemIndex+"&searchType="+searchType+"&matDesc="+matDesc;
	newWindow=window.open(url,"ReportWin","width=700,height=500,left=160,top=120,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");

}
	
	
	
	
	
	
	
	
	
	
</Script>
</Head>
<Body scroll="yes" onLoad="ezMakeDivs();">
<%
	int docT = 0;
	String toDayDate="";
	if(rfqVendors.size()==0){
	
%>
		<br><br><br><br><br>
		<TABLE width="50%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
			<Tr align="center">
				<Th height="21">No Materials Approved to Create Purchase Order</Th>
			</Tr>
		</Table>

		<Div id="back"  align="center" style="position:absolute;width:100%;top:90%;visibility:visible">
<%          
			butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Back &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");  
			butActions.add("history.go(-1)");
			out.println(getButtons(butNames,butActions));
%>                      
		</Div>
<%
	
		return;
	}
%>
<form name="myForm" method="post">

<%
	
	String display_header = "Create Purchase Order";
%>	
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<Br>
<%
	
  
	for(int i=0;i<rfqVendors.size();i++)
	{
		ReturnObjFromRetrieve newRetTemp=(ReturnObjFromRetrieve)venInfo.get((String)rfqVendors.get(i));
		String pnmtTerms=newRetTemp.getFieldValueString(0,"PAYMENT_TERMS");
		
		java.util.ResourceBundle PayT	= java.util.ResourceBundle.getBundle("EzPurPayTerms");
		
		try{
			if(pnmtTerms!=null && !"null".equals(pnmtTerms))
			pnmtTerms=PayT.getString(pnmtTerms.trim());
			
		}catch(Exception err){}
		
		if(pnmtTerms==null||"null".equals(pnmtTerms)||"".equals(pnmtTerms.trim()))
		pnmtTerms="N/A";
		
		
			
		
%>
		 <Fieldset style="border-width:3px;border-color:#000000;border-style:double;" >
		<Legend><b>Vendor: <%=(String)rfqVendors.get(i)%><input type="hidden" name="vendor" value="<%=(String)rfqVendors.get(i)%>"></b></Legend>
			<Table align=center  border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 width='98%'>
				<Tr>
					<Th width="25%">Document Type*</Th>
					<Th width="25%">House Bank Id*</Th>
					<Th width="20%">Payment Terms</Th>
					<Th width="15%">Header Text</Th>
          				<Th width="15%">Shipping Instructions</Th>
				</Tr>
				<Tr>
					<Td width="25%">
					
					
					<select name="docType" style="width:100%" onChange="javascript:showLabel('<%=i%>')">
						<option value="">-Select Document Type-</option>
<%
						for(int inDocType=0;inDocType<PoTypes.length;inDocType++)
						{
%>
							<option value="<%=PoTypes[inDocType][0]%>"><%=PoTypes[inDocType][1]%></option>
<%
						}
%>
					</select>
					
					
					</Td>
					<Td width="25%">
					
					<select name="hbId" style="width:100%" id="CalendarDiv"> 
						<option value="" selected>-Select House Bank ID-</option>
<%
						for(int inHsbId=0;inHsbId<houseBankIds.length;inHsbId++)
						{
%>	
							<option value="<%=houseBankIds[inHsbId][0]%>"><%=houseBankIds[inHsbId][1]%></option>
<%
						}
%>	
					</select>
					
					</Td>
					<Td width="20%" align="center">
						<%=pnmtTerms%>
					</Td>
					<Td width="15%" align="center">
					<input type="hidden" name="headerText" value=""><a href="javascript:onClick=headerText('<%=i%>','H')">
					<img   src="../../Images/Buttons/<%=ButtonDir%>/edit-button.gif" border="none" valign=bottom style="cursor:hand"></a>
					</Td>
					<Td width="15%" align="center">
					<input type="hidden" name="shipmentText" value=""><a href="javascript:onClick=headerText('<%=i%>','S')">
					<img   src="../../Images/Buttons/<%=ButtonDir%>/edit-button.gif" border="none" valign=bottom style="cursor:hand"></a>
					</Td>
				</Tr>
			</Table>
			<br>
			<Table align=center  border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 width='98%'>
				<Tr>
					
					<Th width="10%">RFQ No</Th>
					<Th width="4%">Item</Th>
					<Th width="13%">Material</Th>
					<Th width="12%">Del.Date</Th>
					<Th width="7%">RFQ Qty</Th>
					<Th width="7%">PO.Qty</Th>
					<Th width="4%">UOM</Th>
					<Th width="6%">Price</Th>
					<Th width="4%">Curr</Th>
					<Th width="7%">Plant</Th>
					<Th width="11%">Val Type</Th>
					<Th width="8%">Tax Code</Th>
					<Th width="7%">CC Key</Th>
					<Th width="4%">Text</Th>
				</Tr>
<%
				int rCount=0;
				String selected="";
				
				String delDate="";
        
				for(int j=0;j<newRetTemp.getRowCount();j++)
				{
				
					String rfqNo=newRetTemp.getFieldValueString(j,"RFQ_NO");
          				String collRFQNo=newRetTemp.getFieldValueString(j,"COLLECTIVE_RFQ_NO");
					String rfqLine=newRetTemp.getFieldValueString(j,"LINE_NO");
					delDate=fd.getStringFromDate((Date)newRetTemp.getFieldValue(j,"DELIVERY_DATE"),".",ezc.ezutil.FormatDate.DDMMYYYY);
          				toDayDate=fd.getStringFromDate(new java.util.Date(),".",ezc.ezutil.FormatDate.DDMMYYYY);
					String material=newRetTemp.getFieldValueString(j,"MATERIAL");
					String matDesc=newRetTemp.getFieldValueString(j,"MATERIAL_DESC");
					String qty=newRetTemp.getFieldValueString(j,"QUANTITY");
					String price=newRetTemp.getFieldValueString(j,"PRICE");
					String currency=newRetTemp.getFieldValueString(j,"CURRENCY");
					if(currency==null||"null".equals(currency) ||"".equals(currency.trim())) currency="&nbsp";
					String plant=newRetTemp.getFieldValueString(j,"PLANT");
					String uom=newRetTemp.getFieldValueString(j,"UOM");
					String valType=newRetTemp.getFieldValueString(j,"VAL_TYPE");
					String taxCode=newRetTemp.getFieldValueString(j,"TAX_CODE");
					double actualRFQQtyDou=0;
					double consumedQtyDou=0;
					double pendingQtyDou=0;
					String myKey="";
					String myKeyVal="";
					if(rfqNo!=null&&rfqLine!=null){
						myKey=rfqNo.trim()+rfqLine.trim();
						myKeyVal=(String)consumedRFQQtyHT.get(myKey);
						if(myKeyVal!=null){
							try{
							consumedQtyDou=Double.parseDouble(myKeyVal);
							}catch(Exception err){consumedQtyDou=0;}
						}

					}

					try{
						actualRFQQtyDou=Double.parseDouble(qty);
					}catch(Exception err){actualRFQQtyDou=0;}

					pendingQtyDou=actualRFQQtyDou-consumedQtyDou;
					if(pendingQtyDou<0)
					pendingQtyDou=0;
					rCount++;
          
					
%>

					<Tr>
										
						<Td width="10%" align="center"><input type="hidden" name="rfqNo<%=i%>" value="<%=rfqNo%>"><%=rfqNo%></Td>
						<Td width="4%" align="center"><input type="hidden" name="rfqLine<%=i%>" value="<%=rfqLine%>"><%=rfqLine%></Td>
						<Td width="13%"><input type="hidden" name="matNo<%=i%>" value="<%=material%>"><%=matDesc%></Td>
						<Td width="12%" align="center"><input type="text" class="InputBox" size=11 name="delDate<%=i%><%=(rCount-1)%>" value="<%=delDate%>" readonly>
						
						<img src="../../Images/calender.gif" style="cursor:hand" height="20" onClick=showCal("document.myForm.delDate<%=i%><%=(rCount-1)%>",150,200,"<%=cDate%>","<%=cMonth%>","<%=cYear%>") >
						
						
						</Td>
						<Td width="7%" align="center"><input type="hidden" name="rfqQty<%=i%>" value="<%=qty%>"><%=qty%></Td>
						<Td width="7%" align="center">
						<input type="hidden" name="collRFQNo<%=i%>" size="8" value="<%=collRFQNo%>">
						<input type="hidden" name="pendQty<%=i%>" size="8" value="<%=pendingQtyDou%>">
						<input type="text" name="poQty<%=i%>" class="InputBox" onBlur="checkQty(this,'<%=pendingQtyDou%>')" size="8" value="<%=pendingQtyDou%>">
						</Td>
						<Td width="4%" align="center"><%=uom%></Td>
						<Td width="6%" align="center"><%=price%></Td>
						<Td width="4%" align="center"><%=currency%></Td>
						<Td width="7%" align="center">
<%
            
						if(plant==null||"null".equals(plant)||"".equals(plant)||"-".equals(plant)){
%>
							<select name="plant<%=i%>" style="width:100%" id="ListBox1Div">> 
<%	  						
							for(int p=0;p<count;p++)
							{
%>	
								<option value="<%=ret.getFieldValueString(p,"CODE")%>"><%=ret.getFieldValueString(p,"CODE")%></option>
<%	   						
							}
%>  
            						</select>
<%
             					}else{
%>
                					<input type="hidden" name="plant<%=i%>" value="<%=plant%>"><%=plant%>                   
<%             
             					}
%>
              
            					</Td>
						
						<Td width="11%">
						<select name="valuationType<%=i%>" style="width:100%" id="ListBox1Div">
						<option value="">-Valuation Type-</option>
<%				
						
						for(int inVType=0;inVType<valuationTypes.length;inVType++)			
						{	
							selected="";
							if((valuationTypes[inVType]).equals(valType))
							selected="selected";
%>					
							<option value="<%=valuationTypes[inVType]%>" <%=selected%>><%=valuationTypes[inVType]%></option>			
<%					
						}			
%>
						</select>
						</Td>
						<Td width="8%" align="left">
<%	
		
						if(taxCode==null || "null".equals(taxCode) || "".equals(taxCode))
						taxCode = "AA";
						
%>		
						<input type="text" class="InputBox" size="8" name="taxCode<%=i%>"  value="<%=taxCode%>">
						<Div id="myTCDiv<%=i%><%=(rCount-1)%>" style="position:absolute">
							<a style="text-decoration:none" id="myAn" onClick="showMyDiv('ezTaxCodeDiv','myTCDiv<%=i%><%=(rCount-1)%>','<%=i%>','<%=(rCount-1)%>','N','T')"><b><img src="../../Images/Buttons/<%=ButtonDir%>/down_arrow.gif" style="cursor:hand" height="18" alt="Select" ></a>
						</Div>
						
						</Td>
						<Td width="7%" align="left">
							<input type="text" class="InputBox" name="ccKey<%=i%>" size=5 value="">
							<Div id="myCCDiv<%=i%><%=(rCount-1)%>" style="position:absolute">
								<a style="text-decoration:none" id="myAn" onClick="showMyDiv('ezConfCtrlDiv','myCCDiv<%=i%><%=(rCount-1)%>','<%=i%>','<%=(rCount-1)%>','N','C')"><b><img src="../../Images/Buttons/<%=ButtonDir%>/down_arrow.gif" style="cursor:hand" height="18" alt="Select" ></a>
							</Div>
						</Td>

						<Td width="5%" align="center"><input type="hidden" name="itemText<%=i%>" value=""><a href="javascript:onClick=itemText('<%=i%>','<%=j%>')"><img   src="../../Images/Buttons/<%=ButtonDir%>/edit-button.gif" border="none" valign=bottom style="cursor:hand"></a></Td>
					</Tr>
<%
					
				}
%>
			</Table>
      <br>
      
<%
        if(rCount>0){
%>
            
            <Fieldset style="border-width:1px;border-color:#000000;" >
            <Legend>ADD FREE GOOD LINE ITEMS HERE</Legend>
            <Table align=center id="ezRCItemTab<%=i%>"  border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 width='98%'>
            <Tr>
              
              <Th width="10%" align="left"><b><a href="javascript:onClick=addLine('<%=i%>')"><font color="red" >[+]</font></b></a>&nbsp;Material</Th>
              <Th width="13">Description</Th>
              <Th width="12%">Del.Date</Th>
              <Th width="7%">PO Qty</Th>
              <Th width="4%">UOM</Th>
              <Th width="6%">Plant</Th>
              <Th width="8%">S.Loc</Th>
              <Th width="6%">FOC</Th>
              <Th width="11%">Val Type</Th>
              <Th width="11%">Tax Code</Th>
              <Th width="8%">CC Key</Th>
              <Th width="4%">Text</Th>
            </Tr>  
            
            <Tr>
                          
              <Td width="10%">
              <input type="text" name="rcMat<%=i%>" class="InputBox" size="8" value="">
              <img src="../../Images/Buttons/<%=ButtonDir%>/find.gif" style="cursor:hand" height="18" alt="Find" onClick="javascript:searchMatByNumber('<%=i%>','0','CODE')">
              </Td>
              <Td width="12%">
              	<input type="text" name="rcMatDesc<%=i%>" class="InputBox" size="13" value="">
              	<img src="../../Images/Buttons/<%=ButtonDir%>/find.gif" style="cursor:hand" height="18" alt="Find" onClick="javascript:searchMatByNumber('<%=i%>','0','DESC')">
              </Td>
              <Td width="12%">
                <input type="text" name="rcDelDt<%=i%>0" class="InputBox" size=11 value="<%=toDayDate%>" readonly> <img src="../../Images/calender.gif" style="cursor:hand" height="20" onClick=showCal("document.myForm.rcDelDt<%=i%>0",205,200,"<%=cDate%>","<%=cMonth%>","<%=cYear%>") >
              </Td>
              <Td width="7%"><input type="text" name="rcPOQty<%=i%>" class="InputBox" size="7" value=""></Td>
              <Td width="4%">
             
              <Select name="rcUOM<%=i%>">
                <Option value="KG">KG</Option>
                <Option value="LT">LT</Option>
              </Select>
              </Td>
              <Td width="7%">
              
              
              <select name="rcPlant<%=i%>" style="width:100%" > 
<%	  						
		for(int p=0;p<count;p++)
		{
%>	
			<option value="<%=ret.getFieldValueString(p,"CODE")%>"><%=ret.getFieldValueString(p,"CODE")%></option>
<%	   						
		}
%>  
              </select>
              
              
              </Td>
              <Td width="8%"><input type="text" name="rcSLoc<%=i%>" class="InputBox" size="8" value=""></Td>
              <Td width="6%">
              
              <select name="rcFOC<%=i%>">
                <option value="Y">Yes</option>
                <option value="N">No</option>
              </select>
              </Td>
              <Td width="11%">
             
              <select name="rcValType<%=i%>" style="width:100%" id="ListBox1Div">
              <option value="">-Valuation Type-</option>
<%				
              
		for(int inVType=0;inVType<valuationTypes.length;inVType++)			
		{	

%>					
			<option value="<%=valuationTypes[inVType]%>" ><%=valuationTypes[inVType]%></option>			
<%					
		}			
%>
      	      </select>

              
              </Td>
              <Td width="11%" align="center">
              
		<input type="text" class="InputBox" value="" size="8" name="rcTaxCode<%=i%>" >
		<Div id="myRCTCDiv<%=i%>0" style="position:absolute">
			<a style="text-decoration:none" id="myAn" onClick="showMyDiv('ezTaxCodeDiv','myRCTCDiv<%=i%>0','<%=i%>','0','R','T')"><b><img src="../../Images/Buttons/<%=ButtonDir%>/down_arrow.gif" style="cursor:hand" height="18" alt="Select" ></a>
		</Div>
		
	      </Td>
	      
              <Td width="8%" align="center">
 	           <input type="text" class="InputBox" name="rcCCKey<%=i%>" size="5">
 	           <Div id="myRCCCDiv<%=i%>0" style="position:absolute">
		   	<a style="text-decoration:none" id="myAn" onClick="showMyDiv('ezConfCtrlDiv','myRCCCDiv<%=i%>0','<%=i%>','0','R','C')"><b><img src="../../Images/Buttons/<%=ButtonDir%>/down_arrow.gif" style="cursor:hand" height="18" alt="Select" ></a>
		   </Div>
              </Td>
              <Td width="4%" align="center">
               <input type="hidden" name="rcText<%=i%>" value=""><a href="javascript:onClick=rcItemText('<%=i%>','0')"><img   src="../../Images/Buttons/<%=ButtonDir%>/edit-button.gif" border="none" valign=bottom style="cursor:hand"></a>
              </Td>
                           
            </Tr>
            </Table>
            </Fieldset>
            <br>
            
<%
          
        }
%>
			
		</Fieldset>
		
<%
	}
%>
<br>
<Div id="buttonDiv" align=center style="position:absolute;visibility:visible;width:100%">
	<span id="EzButtonsSpan" >
        
<%
          butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
          butNames.add("&nbsp;&nbsp;&nbsp;Create PO&nbsp;&nbsp;&nbsp;");   
          butActions.add("history.go(-1)");
          butActions.add("createPO()");
          out.println(getButtons(butNames,butActions));
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
<%
	for(int c=0;c<collRFQCount;c++)
	{
		String qcfStat=(String)openQCFHT.get(collectiveRFQNo[c]);
		if(qcfStat==null||"null".equals(qcfStat)||"".equals(qcfStat))
		qcfStat="Y";
		else
		qcfStat="N";
%>
		<input type="hidden" name="collRFQNo" value="<%=collectiveRFQNo[c]%>">
    		<input type="hidden" name="collRFQStat" value="<%=qcfStat%>">
<%
	}
%>
	<input type =hidden value="<%=qcfCloseFlg%>" name="qcfCloseFlg">
	<input type =hidden value="" name="attachFlag">
	<input type =hidden value="" name="attachDocs">	
	<input type =hidden name="toDayDate" value="<%=toDayDate%>">

</Form>
<Div id="MenuSol"></Div>
</Body>
</Html>
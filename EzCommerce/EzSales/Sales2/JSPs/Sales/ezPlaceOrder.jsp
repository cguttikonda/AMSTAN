<%//@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ page import = "ezc.ezutil.FormatDate,java.util.*" %>
<%@ page import = "ezc.ezbasicutil.*" %>
<%@ include file="../../../Includes/JSPs/Sales/iGetShoppingCart.jsp" %>
<%@ include file="../../../Includes/JSPs/Lables/iPlaceOrder_Lables.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iTermsConditions_Lables.jsp"%>
<%
	ezc.ezcommon.EzLog4j log = new ezc.ezcommon.EzLog4j(); 
	Double grandTotal =new Double("0");
	Hashtable getprices = new Hashtable();
	int cartcount=0;
	int cartItems=0;

	if(Cart != null)
		cartcount= Cart.getRowCount();
		
	for(int i=0;i<cartcount;i++){
		try{
		     cartItems+=Double.parseDouble(Cart.getOrderQty(i));
		   }catch(Exception e){
                  
		}
	}

	 
	log.log("template>>>>>>>>>>>>>>"+(String)session.getValue("Template"),"W");

	String from = request.getParameter("from");
	EzCurrencyFormat myFormat = new EzCurrencyFormat();
	boolean sessionValue=false; if(session.getAttribute("getprices")!=null) sessionValue=true;
	if(sessionValue)
	{	
		if(from != null)
   		{
  			session.removeAttribute("getprices"); 
  		}	
  		else
  		{
			getprices =(Hashtable)session.getAttribute("getprices"); 
   		}
	}

	if(session.getAttribute("getprices")==null)
	{
%>		<%@ include file="../../../Includes/JSPs/Sales/iGetMaterials.jsp" %>
<%
		
		
		Hashtable selMet= new Hashtable();
		if(cartcount>0)
		{
			/*
			int tMetCount=retpro.getRowCount();
	    		for(int i=0;i<cartcount;i++)
	    		{
				for(int m=0;m<tMetCount;m++)
				{
					if((Cart.getMaterialNumber(i)).equals(retpro.getFieldValueString(m,"MATNO")))
					{
						String Upc_No = retpro.getFieldValueString(m,"UPC_NO");
						if(Upc_No!=null)
							Upc_No = Upc_No.trim();
						selMet.put(retpro.getFieldValueString(m,"MATNO"),retpro.getFieldValueString(m,"GROUP_ID")+"¥"+Upc_No);						
					}
				}
	    		}
	    		
	    		*/
	    		for(int i=0;i<cartcount;i++)
	    		{
	    			selMet.put(Cart.getMaterialNumber(i),Cart.getMaterialNumber(i)+"¥"+"");						
	    		}
		}		
		session.putValue("SELECTEDMET",selMet);
	}		
	String pageUrl 		= request.getParameter("pageUrl");
	String requiredDate 	= request.getParameter("requiredDate");
	String SCDoc 		= request.getParameter("scDoc");
	String RefDocType 	= request.getParameter("refDocType");
	String SCDocNr 		= request.getParameter("scDocNr");
	String incoterms1 	= request.getParameter("inco1");
	String IncoTerms2 	= request.getParameter("inco2");
	String payterms 	= request.getParameter("payterms");
	String generalNotes 	= request.getParameter("generalNotes");
	String pGroupNumber 	= request.getParameter("ProductGroup");
	String carrierName = request.getParameter("carrierName"); 
	carrierName = ("null".equals(carrierName)||carrierName==null)?"":carrierName;
	carrierName = carrierName.toUpperCase();

	incoterms1 	= (incoterms1 == null)?"":incoterms1;
	IncoTerms2 	= (IncoTerms2 == null)?"":IncoTerms2;
	payterms 	= (payterms == null)?"":payterms;
	RefDocType 	= (RefDocType == null)?"":RefDocType;
	
	String[] shippingTypeDesc	= new String[2];
	String shippingType 		= request.getParameter("shippingType");
		
	if("null".equals(shippingType)||shippingType==null ||"".equals(shippingType)|| shippingType=="")
	 {
		shippingTypeDesc[0]="";
		shippingTypeDesc[1]="";
	 }
	else
	{ 
		shippingTypeDesc	= shippingType.split("#"); 	

	}
	
	String Agent	= request.getParameter("agent");
	String SoldTo	= request.getParameter("soldTo");
	String ShipTo	= request.getParameter("shipTo");
	String PONO 	= request.getParameter("poNo");
	String PODate 	= request.getParameter("poDate");
	String OrderDate= request.getParameter("orderDate");
	String Currency = request.getParameter("currency");
	String UserRole	=(String)session.getValue("UserRole");
	UserRole.trim();
	String agentName  = request.getParameter("soldToName");
	String ShipToName = request.getParameter("shipToName");
	String cmnotes="";
	String[] HeaderNotesD=new String[]{"generalNotes","packingInstructions","labelInstructions","inspectionClauses","handlingSpecifications","regulatoryRequirements","documentsRequired","others"} ;
	String[] HeaderNotes=new String[8];
	String[] HeaderNotesT=new String[]{"Special Remarks",pacins_L,labins_L,insclas_L,hanspec_L,regreq_L,docreq_L,others_L} ;
	
	session.setAttribute("pono_porder",PONO);
	session.setAttribute("reqdate_porder",requiredDate);
	session.setAttribute("carname_porder",carrierName);
	
	if(generalNotes != null)
	{
		EzStringTokenizer st = new EzStringTokenizer(generalNotes,"^^ezc^^");
		try
		{
			for(int j=0;j <HeaderNotes.length;j++)
			{
				HeaderNotes[j] = (String) st.getTokens().elementAt(j);
			 	EzStringTokenizer st1 = new EzStringTokenizer(HeaderNotes[j],"@@ezc@@");
				HeaderNotes[j] =(String) st1.getTokens().elementAt(1);
			}
		}catch(Exception e)
		{
		}
	}
%>
<html>
<head>

<Title>Create Sales Order -- Powered by Answerthink Ind Ltd</Title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
<Script>
	  var tabHeadWidth=95
 	  var tabHeight="45%"
</Script>
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
<Script>
<%--
 	these variables are used in ezVerifyField.js changes will effect ezAddSalesSh.jsp
 --%>
	var cannotbelessthan0	="<%=notLessthanZero_A%>"
	var entervalid		="<%=plzEnterValid_A%>"
	var inNumbers 		="<%=inNum_A%>"
	
	
</Script>
<script src="../../Library/JavaScript/ezVerifyField.js"></script>
<script src="../../Library/JavaScript/Misc/ezTrim.js"></script>
<script>
<%
	String  forkey=(String)session.getValue("formatKey");
%>
var retVal;
var prlen;
var getpric;
var total = "<%=cartcount%>";
top.menu.document.msnForm.cartHolder.value = "<%=cartItems%>"; 
var today ="<%= FormatDate.getStringFromDate(new Date(),forkey,FormatDate.MMDDYYYY) %>"
<%
	int cc1=0;
	if(sessionValue)
		cc1=4;
	else
		cc1=5;
	if(cartcount >cc1)
	{
	    	out.println("prlen=1");
	}

	if(sessionValue)
	{
		out.println("getpric=1");
	}
	else
	{
		out.println("getpric=0");
	}
%>

var notesCount = new Array();
function openNewWindow(obj,i)
{
	x=(eval("document.generalForm.del_sch_date.length"))
	if(x>1)
	{
		deldate = eval("document.generalForm.del_sch_date["+i+"]");
		delqty = eval("document.generalForm.del_sch_qty["+i+"]");
	}else{
		deldate = eval("document.generalForm.del_sch_date");
		delqty = eval("document.generalForm.del_sch_qty");

	}
	obj=obj + "&dates=" + deldate.value +"&qtys="+delqty.value
	newWindow = window.open(obj,"multi","resizable=no,left=250,top=100,height=400,width=400,status=no,toolbar=no,menubar=no,location=no")
}

function mselect(j)
{
	var one=j.split(",");
	if(eval("document.generalForm."+one[0]+".selectedIndex")==0)
	{
		alert(one[1]);
	 	return false;
	}
	else{
		return true;
	}
}
function formSubmit(obj,obj2)
{
	if(total==0)
	{
		alert("Please add atleast one product");
		return;
	}
	document.generalForm.status.value=obj2;
	buttonsSpan=document.getElementById("EzButtonsSpan")
	buttonsMsgSpan=document.getElementById("EzButtonsMsgSpan")
	
	if(buttonsSpan!=null)
	{
		buttonsSpan.style.display="none"
		buttonsMsgSpan.style.display="block"
	}
	if(obj=="ezGetPricesSh.jsp")
	{
		y=chk();
		//y =true;
	}
	else
	{
		y=chkdate()
		/*if(eval(y))
			y=chk1(obj2);*/
	}
	if(eval(y))
	{	
		if(obj != "ezGetPricesSh.jsp" )
		{
			var z=document.generalForm.status.value
			if(z=="NEW")
			{
				y=confirm("<%=saveFurModifi_A%>")
			}
			else if(z=="SUBMITTED")
			{
				y=confirm("<%=subEnterApproval_A%>")
			}
			else if(z=="APPROVED")
			{
				 y=confirm("<%=approvOrder_A%>")
			}
		}
	}
	if(eval(y))
	{
		document.body.style.cursor="wait";
		document.generalForm.target="_self";
		document.generalForm.action=obj;
		//document.generalForm.onceSubmit.value=1;
		document.generalForm.submit();
	}
	else
	{
		if(buttonsSpan!=null)
		{
			buttonsSpan.style.display="block"
		        buttonsMsgSpan.style.display="none"
		}
	}
}

function chk1(obj)
{
	return true
}
function chkdate()
{
	for(i=0;i<total;i++)
	{
	        l=document.generalForm.desiredDate.length
	        if(l>1)
	        {
	        	x=eval("document.generalForm.desiredDate["+i+"].value");
	       		if( funTrim(x) == "")
			{
				document.getElementById("desiredDate["+i+"]").className="labelcell"
			}else
			{
				document.getElementById("desiredDate["+i+"]").className=""
			}
		}else{
			x=eval("document.generalForm.desiredDate.value");
			if( funTrim(x) == "")
			{
				document.getElementById("desiredDate").className="labelcell"
			}else
			{
				document.getElementById("desiredDate").className=""
			}
		}
	}
	for(i=0;i<total;i++)
	{
	        if(l>1)
	        {
			if( funTrim(eval("document.generalForm.desiredDate["+i+"].value")) == "")
			{
				alert("<%=entDeliDts_A%>\n"+eval("document.generalForm.prodDesc["+i+"].value"));
				return false;
			}
		}else{
			if( funTrim(eval("document.generalForm.desiredDate.value")) == "")
			{
				alert("<%=entDeliDts_A%>\n"+eval("document.generalForm.prodDesc.value"));
				return false;
			}
		}
	}
	return true
}


var MValues = new Array();
MValues[0] = "desiredQty";

var UserRole = "<%=UserRole%>";
//var total = "<%=cartcount%>";

function chk()
{
	for(b=0;b<MValues.length;b++)
	{
		y= chkQtyone(MValues[b]);
		
		if(eval(y))
		{
			alert("Please enter Quantity for atleast one Product");
			return false;
		}
	}
	return true;
}


function qtyFocus()
{
   document.generalForm.desiredQty.focus();
}
function ezBackMain()
{
	document.body.style.cursor="wait"
<%	if("ezAddSales".equals(pageUrl) ){
%>
		//document.generalForm.action="ezAddSales.jsp"
		document.generalForm.action="ezCreateSalesOrder.jsp"
		document.generalForm.submit();
<%	}else if("shop".equals(pageUrl) || "contract".equals(pageUrl) || "reorder".equals(pageUrl)){
%>		document.generalForm.action="ezAddSalesSh.jsp"
		document.generalForm.submit();
<%	}else{
		if(sessionValue)
		{
%>			top.history.back()
<%		}
		else
		{
%>			document.generalForm.action="../Misc/ezMenuFrameset.jsp";
			document.generalForm.target="_parent"
			document.generalForm.submit();
<%		}
	}
%>
}

function showTab(tabToShow)
{
}


function select1()
{
}
function showConditions()
{
}
function HideNetDiv()
{
}
function ezShowFocus()
{
<%
	if(cartcount>0){
		if(session.getAttribute("getprices")==null){
			if(cartcount==1){
%>				document.generalForm.desiredQty.focus()
<%			}else{
%>				document.generalForm.desiredQty[0].focus()
<%			}
		}
	}
%>
}

function verifyQty(field,val,prd)
{	
	var fValue=field.value	
	/*
	if((val!=0) && (val!="")&&(!isNaN(val)))
	{
		if((fValue%val)!=0)
		{	
			alert("Quantity of "+ prd +" is : " +fValue+"\nSolution :Please enter multiples of "+ val)
			field.value="";
			field.focus();
			return false;
		}
	}
	*/
	return true;
}

function funDelete()
{
	var tabObj	= document.getElementById("InnerBox1Tab")
	var rowItems 	= tabObj.getElementsByTagName("tr");
	var len 	= rowItems.length;
	var code;
	count = 0;
	if(len<=1)
	{
		alert("Sales Order must have atleast one product");
		return;
	}
	
	var chkObj = document.generalForm.chk;

	if(len==1)
	{
		if(chkObj.checked)
		{
			code = chkObj.value;
			count = 1;
		}	
	}
	else
	{
		for(i=len-1;i>=0;i--)
		{

			if(chkObj[i].checked)
			{
				if(count == 0)
				{
					code = chkObj[i].value;

				}else
				{
					code += ","+chkObj[i].value;


				}
				count++;
			}

		}
	}
	
	if(count<=0)
	{
		alert("Please select atleast one product to delete")
		return;
	}
	else
	{
		document.generalForm.DelFlag.value='DEL'
		
		
		var myObj = document.generalForm.chk;
		
		if(confirm("Do You want to delete the product(s) that you select?"))
		{
			SendQuery(code);
			count = 0;
			for(i=len-1;i>=0;i--)
			{
				if(len==1)
				{
					if(myObj.checked)
						tabObj.deleteRow(i)	
				}
				else
				{
					if(myObj[i].checked)
					{
						tabObj.deleteRow(i);	
					}
				}
			}			
		}
		
	}
	document.generalForm.total.value = rowItems.length;
	total = rowItems.length;
	scrollInit();
}

function ezAddProducts()
{
	var returnVal 	= document.generalForm.returnValue.value;
	var tabObj	= document.getElementById("InnerBox1Tab")
	var rowItems 	= tabObj.getElementsByTagName("tr");
	var len 	= rowItems.length;
	var retValue	= "";	

	count = 0;
	var selPrdList;
	
	if(len==1)
	{
		selPrdList	= document.generalForm.product.value;
	}
	else
	{
		for(i=0;i<len;i++)
		{	
			if(count==0)
				selPrdList	= eval("document.generalForm.product["+i+"]").value;
			else	
				selPrdList	+= "@@@"+eval("document.generalForm.product["+i+"]").value;  
			count++;
		}
	}
	str = "../BusinessCatalog/ezProductSearchForSales.jsp?retVal="+selPrdList;
	
	retVal=window.showModalDialog(str,"",'center:yes;dialogWidth:50;dialogHeight:25;status:no;minimize:yes');
	
	
	
	if(retVal!=null && retVal!=undefined)
	{
		if(retVal.retProd=='CLOSE')
		{
			retValue = "N";
		}
		else
		{
			retValue = "Y";
		}
	}
	else
		retValue = "N";
	
	return retValue;
}

myProdCode	= new Array();
myProducts	= new Array();
myProdDesc	= new Array();
myProdUom	= new Array();
myProdUpc	= new Array();

function moreProducts()
{

	/*
	ret = ezAddProducts();



	if(ret!='N' )
	{
	
		var prodcnt =0;
		myProdCode	= retVal.retProd.split(",");	
		myProdDesc	= retVal.retDesc.split(",");	
		myProdUom	= retVal.retUom.split(",");	
		myProdUpc	= retVal.retUpc.split(",");	

		var tabObj		= document.getElementById("InnerBox1Tab")
		var rowItems 		= tabObj.getElementsByTagName("tr");

		var rowCountValue 	= rowItems.length;

		document.generalForm.total.value = rowCountValue;

		prodcnt	= myProdCode.length;
		var lineCount=0;
		for (lineCount=0;lineCount<prodcnt;lineCount++)
		{
			ezAddNewRow(lineCount);
		}
		total = rowItems.length;
	}
	scrollInit();
	
	*/
	
	document.generalForm.target = "_parent";
	document.generalForm.action = "../DrillDownCatalog/ezDrillDownVendorCatalog.jsp";
	document.generalForm.submit();

	
}

function ezAddNewRow(lineCount)
{
	var myProductsLength	= myProducts.length;
	
	
	
	var tabObj		= document.getElementById("InnerBox1Tab")
	var rowItems 		= tabObj.getElementsByTagName("tr");
	var rowCountValue 	= rowItems.length;
	
	
	
	var rowId 		= tabObj.insertRow(rowCountValue);
	elementsArray		= new Array();
	rowCount 		= rowCountValue;
	var titleStr 	= "";	

	hiddenFields="<input type='hidden' 	name='desiredDate'   	value=''>";
	hiddenFields+="<input type='hidden' 	name='prodsForDelete'   value=''>";
	hiddenFields+="<input type='hidden' 	name='qtysForDelete' 	value=''>";
	hiddenFields+="<input type='hidden' 	name='datesForDelete' 	value=''>";
	//hiddenFields+="<input type='hidden' 	name='product' 		value="+myProdCode[lineCount]+">";

	titleStr = myProdCode[lineCount] + "--->" + myProdDesc[lineCount];
	
	elementsArray[0]  ='<input type="checkbox" name="chk" value='+myProdCode[lineCount]+'>'
	elementsArray[1]  ='<input type="text" class="tx"  size=25 name=product      	style="text-align:left" 	readonly	value='+myProdCode[lineCount]+'>'
	elementsArray[2]  ='<input type="text" class="tx"  size=40 name=prodDesc        style="text-align:left"  	readonly	value="'+myProdDesc[lineCount]+'">'
	elementsArray[3]  ='<input type="text" class="tx"  size=10 name=pack       	style="text-align:center"  	readonly	value='+myProdUom[lineCount]+'>'+hiddenFields
	elementsArray[4]  ='<input type="text" class=InputBox size="10" maxlength="15" STYLE="text-align:right" tabIndex=\''+rowCount+1+'\'	name="desiredQty" onBlur="verifyQty(this,\''+funTrim(myProdUpc[lineCount])+'\',\''+myProdCode[lineCount]+'\')" value="" >&nbsp;['+funTrim(myProdUpc[lineCount])+']'

	eleWidth = new Array();
	eleAlign = new Array();
	
	eleWidth[0]  = "5%";	eleAlign[0] = "left";
	eleWidth[1]  = "25%";	eleAlign[1] = "left";
	eleWidth[2]  = "40%";	eleAlign[2] = "left";
	eleWidth[3]  = "10%";	eleAlign[3] = "center";
	eleWidth[4]  = "20%";	eleAlign[4] = "left";
	
	
	len=elementsArray.length
	
	for (i=0;i<len;i++){
		cell0Data = elementsArray[i]
		cell0=rowId.insertCell(i);
		cell0.innerHTML=cell0Data;
		cell0.align=eleAlign[i];
		cell0.width= eleWidth[i]
	}
	rowCount++;
}


	function Process()
	{
		if (req.readyState == 4)
		{
			var resText = req.responseText;	 	        	
			var resultText	= resText.split("#");
			
			if (req.status == 200)
			{
				top.menu.document.msnForm.cartHolder.value = resultText[1]; 
			} 
		}
	}
	
	function Initialize()
	{
	
		try
		{
			req=new ActiveXObject("Msxml2.XMLHTTP");
		}
		catch(e)
		{
			try
			{
				req=new ActiveXObject("Microsoft.XMLHTTP");
			}
			catch(oc)
			{
				req=null;
			}
		} 
		if(!req&&typeof XMLHttpRequest!="undefined")
		{
			req=new XMLHttpRequest();
		}
	}
	
	function SendQuery(code)
	{
		Initialize();
		var url=location.protocol+"//<%=request.getServerName()%>/CRI/EzCommerce/EzSales/Sales2/JSPs/Sales/ezUpdateCartProducts.jsp?productNo="+code+"&pageFlag=DELETE"+"&date="+new Date();
		if(req!=null)
		{
			req.onreadystatechange = Process;
			req.open("GET", url, true);
			req.send(null);
		}
	}

</script>
</head>
<body   onLoad="scrollInit();ezShowFocus()" onresize="scrollInit()" scroll=no>

<form name="generalForm" method="post" onSubmit="return false">
<input type="hidden" name="obj123">
<input type="hidden" name="chkBrowser" 		value="0">
<input type="hidden" name="ProductGroup" 	value="<%=pGroupNumber%>">
<input type="hidden" name="DelFlag" 		value=''>
<input type="hidden" name="returnValue" 	value=''>

<input type="hidden" name="retProd">
<input type="hidden" name="retDesc">
<input type="hidden" name="retUom" >
<input type="hidden" name="retUpc" >
<input type="hidden" name="flag" value='N'>
<input type="hidden" name="backFlag" value='ADDDELETE'>
<input type="hidden" name="agentName" value="<%=agentName%>">
<%
	String display_header = ""; 
	
	if("S".equals(RefDocType))
		display_header=COrderAGNo_L+":"+SCDoc;
	else
	        display_header=COrderFor_L+" "+agentName;
	
%>
<%@ include file="../../../Sales2/JSPs/Misc/ezDisplayHeader.jsp"%>

<Div id="div1" align="center" style="visibility:visible;width:100%">  
<Table width='95%' valign='top'  align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
      <Tr>
		<th class="labelcell" align="left"><%=pono_L%></th>
		<td> <input type="hidden" name="poNo"  value="<%=PONO%>"><%=PONO%></td>
		<th class="labelcell" align="left"><%=podate_L%></th>
		<td><input type="hidden" name="poDate" value="<%=PODate%>"><%=PODate%></td>
		<th class="labelcell" align="left">Req.Deliv.Date</th>
		<td><input type="hidden" name="requiredDate" value="<%=requiredDate%>"><%=requiredDate%></td>
      </Tr>
      <Tr>
		<th class="labelcell" align="left"><%=soldto_L %> </th>
		<td> <input type="hidden" name="soldTo" value="<%=SoldTo%>">
		<input type="hidden" name="soldToName" value="<%=agentName%>">
		<%=agentName%>
		</Td>
	<Th class="labelcell" align="left"><%=shipto_L%> </Th> 
        <Td>
		<input type="hidden" name="shipTo" value="<%=ShipTo%>">
		<input type="hidden" name="shipToName" value="<%=ShipToName%>">
		<input type="hidden" name="carrierName" value="<%=carrierName%>">
		<%=ShipToName%>
        </Td>
        <Th class="labelcell" align="left" >Ship Type</Th>
	<Td nowrap><%=shippingTypeDesc[1]%>&nbsp;</Td>
        
</Tr>
</table>
<input type="hidden" name="agent" 	value="<%=Agent%>">
<input type="hidden" name="orderDate"  	value="<%=OrderDate%>">
<input type="hidden" name="refDocType" 	value="<%=RefDocType%>">
<input type="hidden" name="scDoc" 	value="<%=SCDoc%>">
<input type="hidden" name="scDocNr" 	value="<%=SCDocNr%>">
<input type="hidden" name="status">
<input type="hidden" name="shippingType" 		value="<%=shippingType%>">
<input  type="hidden"  name="shippingTypeDesc" 		value="<%=shippingTypeDesc[1]%>">
<input  type="hidden"  name="shippingTypeValue" 	value="<%=shippingTypeDesc[0]%>">

</Div>
<Div id='theads'>
	<Table  width='95%'  id='tabHead'  width='99%'  align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
	<%@ include file="../../../Includes/JSPs/Sales/iProductDetailTr.jsp" %>
	</Table>
</Div>
<Div id='InnerBox1Div' style='overflow:auto;position:absolute;width:98%;height:45%;left:2%'>
	<Table id='InnerBox1Tab' width='100%' align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1>
	<%@ include file="../../../Includes/JSPs/Sales/iProductDetailTd.jsp" %>  
	</Table>
</Div>

<input type="hidden" name="total" value="<%=cartcount%>">

<div id="buttonDiv" align="center" style="visibility:visible;position:absolute;top:86%;width:100%">
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	
	buttonName.add("Delete Products");
	buttonMethod.add("funDelete()");	
	buttonName.add("Obtain Prices");
	buttonMethod.add("formSubmit(\"ezGetPricesSh.jsp\",\"NO\")");	
	buttonName.add("Add Products");
	buttonMethod.add("moreProducts()");
	buttonName.add("Back");
	buttonMethod.add("ezBackMain()");
	out.println(getButtonStr(buttonName,buttonMethod));
%>
</div>

<input type="hidden" name="delBlock">
<input type="hidden" name="onceSubmit" value=0>
<input type="hidden" name="pageUrl" value="<%=pageUrl%>">
</form>
<Div id="MenuSol"></Div>
</body>
</html>
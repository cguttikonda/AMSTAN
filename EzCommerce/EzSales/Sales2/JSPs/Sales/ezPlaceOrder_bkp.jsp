<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ page import = "ezc.ezutil.FormatDate,java.util.*" %>
<%@ page import = "ezc.ezbasicutil.*" %>
<%@ include file="../../../Includes/JSPs/Sales/iGetShoppingCart.jsp" %>
<%@ include file="../../../Includes/JSPs/Lables/iPlaceOrder_Lables.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iTermsConditions_Lables.jsp"%>
<%
	Double grandTotal =new Double("0");
	Hashtable getprices = new Hashtable();
	int cartcount=0;

	if(Cart != null)
		cartcount= Cart.getRowCount();

	ezc.ezcommon.EzLog4j log = new ezc.ezcommon.EzLog4j(); 
	log.log("RameshRameshRameshRameshRameshRameshcartcount"+(String)session.getValue("Template"),"W");

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
<Script src="../../Library/JavaScript/ezCalValue.js"></Script>
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
<script src="../../Library/JavaScript/ezSelSelect.js"></script>
<script>
<%
	String  forkey=(String)session.getValue("formatKey");
%>
var prlen;
var getpric;
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
var total = "<%=cartcount%>";

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
%>
		//document.generalForm.desiredQty.focus();
		
<%			}else{
%>
			//document.generalForm.desiredQty[0].focus();
<%			}
		}
	}
%>
}

function verifyQty(field,val,prd)
{	
	var fValue=field.value	
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
	return true;
}
</script>
</head>
<body   onLoad="scrollInit();ezShowFocus()" onresize="scrollInit()" scroll=no>

<form name="generalForm" method="post" onSubmit="return false">
<input type="hidden" name="obj123">
<input type="hidden" name="chkBrowser" value="0">
<input type="hidden" name="ProductGroup" value="<%=pGroupNumber%>">


<table align=center border="0" cellpadding="0" class="displayheaderback" cellspacing="0" width="100%">
<tr>
    <td height="35" align="center" class="displayheaderback"  width="100%">
<%
		   if("S".equals(RefDocType))
			out.println(COrderAGNo_L+": "+SCDoc );
		 else
			out.println(COrderFor_L+"  " + agentName);
%>		<input type="hidden" name="agentName" value="<%=agentName%>">
    </td>
</tr>
</table>

<Div id="div1" align="center" style="visibility:visible;width:100%">
<Table width='95%' valign='top'  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
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
		<%=ShipToName%>
        </Td>
        <Th class="labelcell" align="left">Carrier Name</Th>
        <Td>
		<input type="hidden" name="carrierName" value="<%=carrierName%>">
		<%=carrierName%>
        </Td>
</Tr>
</table>
<input type="hidden" name="agent" 	value="<%=Agent%>">
<input type="hidden" name="orderDate"  	value="<%=OrderDate%>">
<input type="hidden" name="refDocType" 	value="<%=RefDocType%>">
<input type="hidden" name="scDoc" 	value="<%=SCDoc%>">
<input type="hidden" name="scDocNr" 	value="<%=SCDocNr%>">
<input type="hidden" name="status">
</Div>
<Div id='theads'>
	<Table  width='95%'  id='tabHead'  width='99%'  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
	<%@ include file="../../../Includes/JSPs/Sales/iProductDetailTr.jsp" %>
	</Table>
</Div>
<Div id='InnerBox1Div' style='overflow:auto;position:absolute;width:98%;height:45%;left:2%'>
	<Table id='InnerBox1Tab' width='100%' align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0>
	<%@ include file="../../../Includes/JSPs/Sales/iProductDetailTd.jsp" %>
	</Table>
</Div>

<input type="hidden" name="total" value="<%=cartcount%>">

<div id="buttonDiv" align="center" style="visibility:visible;position:absolute;top:86%;width:100%">
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	buttonName.add("Back");
	buttonMethod.add("ezBackMain()");
	buttonName.add("Obtain Prices");
	buttonMethod.add("formSubmit(\"ezGetPricesSh.jsp\",\"NO\")");	
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
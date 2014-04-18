<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"  %>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp" %>
<%@ include file="../../../Includes/JSPs/Lables/iEditSaleswithmod_Lables.jsp" %>
<%@ include file="../../../Includes/JSPs/Lables/iTermsConditions_Lables.jsp"  %>
<%@ page import = "ezc.ezutil.FormatDate,java.util.*" %>
<%@ include file="../../../Includes/JSPs/Lables/iButton_Lables.jsp"%>
<%

Hashtable getprices = new Hashtable();
Hashtable getValues = new Hashtable();
boolean sessionValue = false;

if(session.getAttribute("getprices")!=null) sessionValue=true;

if(sessionValue)
{
	getprices =(Hashtable)session.getAttribute("getprices");
	getValues = (Hashtable)session.getAttribute("getValues");
}

ezc.ezbasicutil.EzCurrencyFormat myFormat = new ezc.ezbasicutil.EzCurrencyFormat();
String formatkey =(String)session.getValue("formatKey");
FormatDate fD=new FormatDate();

String WebOrNo = sdHeader.getFieldValueString(0,"WEB_ORNO");
String incoterms1 = request.getParameter("incoTerms1");
String IncoTerms2 = sdHeader.getFieldValueString(0,"INCO_TERMS2");
String payterms = request.getParameter("paymentTerms");

UserRole = UserRole.trim();

String DisCash = sdHeader.getFieldValueString(0,"DISCOUNT_CASH");
String DisPer =sdHeader.getFieldValueString(0,"DISCOUNT_PERCENTAGE");
String Freight=sdHeader.getFieldValueString(0,"FREIGHT");

DisCash=( (DisCash == null)||(DisCash.trim().length()==0)||("null".equals(DisCash) )  )?"0":DisCash;
DisPer = ( (DisPer == null)||(DisPer.trim().length()==0)||("null".equals(DisPer)) )?"0":DisPer;
Freight = ( (Freight == null)||(Freight.trim().length()==0)||("null".equals(Freight)) )?"0":Freight;

String agentName ="";
int count=1,i=0;

incoterms1=(  (incoterms1==null) || (incoterms1.length() == 0) )?sdHeader.getFieldValueString(0,"INCO_TERMS1"):incoterms1;
payterms=(  (payterms==null) || (payterms.length() == 0) )?sdHeader.getFieldValueString(0,"PAYMENT_TERMS"):payterms;

String SoldTo = request.getParameter("soldTo");
SoldTo = ( (SoldTo==null)||( ("").equals(SoldTo) ) )?sdSoldTo.getFieldValueString(0,"SOLD_TO_CODE"):SoldTo;

// ******************* end of if to get plant address from properties file
%>

<%@ include file="../../../Includes/JSPs/Sales/iNotesValues.jsp" %>
 
<%

String cmnotes ="None";
if( CM ||LF || BP)
{
	cmnotes = sdHeader.getFieldValueString(0,"TEXT2");
	cmnotes = ( (cmnotes==null) || ("null").equals(cmnotes))?"None":cmnotes;
}
String bpnotes ="None";
String lfnotes ="None";
if( BP ||LF)
{
	bpnotes = sdHeader.getFieldValueString(0,"TEXT3");
	lfnotes = sdHeader.getFieldValueString(0,"TEXT4");

	bpnotes = ( (bpnotes==null) || ("null").equals(bpnotes))?"None":bpnotes;
	lfnotes = ( (lfnotes==null) || ("null").equals(lfnotes))?"None":lfnotes;

}

%>

<%
	String ordDate = sdHeader.getFieldValueString(0,"ORDER_DATE");

	java.util.Date ord=(java.util.Date)sdHeader.getFieldValue(0,"ORDER_DATE");
	java.util.Date std=(java.util.Date)sdHeader.getFieldValue(0,"STATUS_DATE");

	String Reason = sdHeader.getFieldValueString(0,"RES2");

	Reason = ( (Reason == null) || ("null".equals(Reason)) )?"":Reason;
	Reason=Reason.replace((char)13,' ');
	Reason=Reason.replace((char)10,' ');

%>

<html>
<head>

	<Title>Sales Order Details-- Powered by EzCommerce Inc</Title>
	<%//@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>

	<script src="../../Library/JavaScript/ezSniffer.js">
	</script>
	<script>
	function chkProdQty(obj,prd,val)
	{
		/*var fValue=obj.value
		if((val!="")&&(!isNaN(val)))
		{
			if((fValue%val)!=0)
			{
				alert("Shipper quantity of "+ prd +" is  : " + val  +"\nSolution :Please enter multiple of "+ val)
				return false;
			}
		}*/
		return true;
	}	
	function calValue(obj,prodDesc,val,ProdLine,ind,oldVal)
	{
	
		var y=chkProdQty(obj,prodDesc,val,oldVal)
		y=true;
		if(eval(y))
		{
			document.generalForm.chkprice.value="0";
			var  objstr="ezDatesEntry.jsp?ind="+ind+"&matdesc="+prodDesc+"&unitQty="+val+"&itemNo="+ProdLine;
			openNewWindow(objstr,ind)
		}else{
		
			obj.value=oldVal
			obj.focus();
		}
		
		
	}
	
	function showMsg()
	{
		if(document.all)
		{
			retVal=showModalDialog('ezDea.jsp'," ",'center:yes;dialogWidth:25;dialogHeight:8;status:no;minimize:yes');
			if(retVal=='Y') 
				showSign()
		}
		else
		{
			//createPopUPWindow1()
		}
	}
	var retSign='N'
	function showSign()
	{
		if(document.all)
		{
			retSign=showModalDialog('ezSignature.jsp'," ",'center:yes;dialogWidth:35;dialogHeight:15;status:no;minimize:yes');
		}
		else
		{
			//createPopUPWindow2()
		}
	}



function confirmEditOrder(obj1,obj2)
{
	var  deaValue='<%=(String)session.getValue("DEANUMBER")%>'
	var deaFlag=true
	if(deaValue==null || deaValue=="" || deaValue==" ") 
		{
			deaFlag=false
			retSign='Y'	
		}	
	var flag;
	if(deaFlag)
	{
	flag=true
	var countDea=0
	var prdlen=document.generalForm.product.length
	
	if(isNaN(prdlen))		
	{
		if((funTrim(document.generalForm.product.value)=='PH-555555') || (funTrim(document.generalForm.product.value)=='PH-6501'))
			countDea++;
	}
	else		
	{
		for(var t=0;t<document.generalForm.product.length;++t)
		{	
			if((funTrim(document.generalForm.product[t].value)=='PH-555555') || (funTrim(document.generalForm.product[t].value)=='PH-6501'))
			countDea++;
		}			
	}
	
	if(countDea>0)
		{
			flag=false
			showMsg()
		}
	}
	
	if(retSign=='Y' || flag)
	{
		var cFlag=true;
		var pname="";
		var rCount=<%=retLines.getRowCount()%>;


		if(rCount==1)
		{
			chFlag=eval("document.generalForm.changeFlag_0").value
			if (chFlag=="false")
			{
				cFlag=false;
				pname=eval("document.generalForm.productDesc").value;

			}

		}else{

			for( i=0;i<rCount;i++)
			{
				var stObj=eval("document.generalForm.changeFlag_"+i)
				chFlag=stObj.value
				if (chFlag=="false")
				{
					cFlag=false;
					pname=eval("document.generalForm.productDesc["+i+"]").value;
				}

			}
		}

		if(cFlag)
		{
			formSubmit(obj1,obj2)

		}else{
			alert("Please Make equal quantites and Required Dates for \""+pname+"\"\nSolution : Please Click On \""+pname+"\" Delivery Dates")
		}
	}
}	
	function showATP(ind)
	{
		prodCode = "";
		prodDesc ="";
		reqDate ="";
		reqQty ="";
		uom="";
		lineNo="";
		plant="US21"
		if (document.generalForm.product[ind]!=null)
		{
			prodCode = document.generalForm.product[ind].value
			prodDesc =document.generalForm.productDesc[ind].value
			reqDate =document.generalForm.desiredDate[ind].value
	 		reqQty =document.generalForm.desiredQty[ind].value
	 		uom=document.generalForm.pack[ind].value
			lineNo=document.generalForm.lineNo[ind].value

		}
		else
		{
			prodCode = document.generalForm.product.value
			prodDesc =document.generalForm.productDesc.value
			reqDate =document.generalForm.desiredDate.value
	 		reqQty =document.generalForm.desiredQty.value
	 		uom=document.generalForm.pack.value
	 		lineNo=document.generalForm.lineNo.value
		}
	
		myurl ="ezGetATP.jsp?ProductCode="+prodCode+"&ProdDesc="+prodDesc+"&ReqDate="+reqDate+"&ReqQty="+reqQty+"&UOM="+uom+"&itemNumber="+lineNo+"&plant="+plant
		///retVal=showModalDialog(myurl," ",'center:yes;dialogWidth:25;dialogHeight:14;status:no;minimize:yes')
		retVal=window.open(myurl,"ATP","modal=yes,resizable=no,left=200,top=200,height=200,width=500,status=no,toolbar=no,menubar=no,location=no")
	}
	
	
	
	var compfoc = new Array()
	var compprice = new Array()
	var compqty = new Array()
	var statusOrder = "<%=StatusButton %>";
	
	function chkcompqty()
	{
		var cFlag=true;
		var pname="";
		var rCount=<%=retLines.getRowCount()%>;


		if(rCount==1)
		{
			chFlag=eval("document.generalForm.changeFlag_0").value

			if (chFlag=="false")
			{
				cFlag=false;
				pname=eval("document.generalForm.productDesc").value;
			}
		}else{
		
			for( i=0;i<rCount;i++)
			{
				var stObj=eval("document.generalForm.changeFlag_"+i)
				chFlag=stObj.value
				if (chFlag=="false")
				{
					cFlag=false;
					pname=eval("document.generalForm.productDesc["+i+"]").value;
				}

			}
		}
		if(cFlag)
		{
			return true

		}else{
			alert("Please Make equal quantites and Required Dates for \""+pname+"\"\nSolution : Please Click On \""+pname+"\" Delivery Dates")
			return false
		}
	}
	function chkchange()
	{
	
		for(h=0;h<compprice.length;h++)
		{
			if(document.generalForm.commitedPrice.length>1)
				obj5 = eval("document.generalForm.commitedPrice["+h+"]");
			else
				obj5 = eval("document.generalForm.commitedPrice");
			if( obj5.value != compprice[h] )
			{
				alert("As you have edited prices please return the order to Customer")
				return false
			}
		}
		return true;
	}
	var retlen
	var log
	
	function displayWindow(fieldName)
	{
		newWindow = window.open("ezReturnEntry.jsp?Reason=<%=Reason%>","Mywin","resizable=no,left=250,top=100,height=350,width=400,status=no,toolbar=no,menubar=no,location=no")
		newWindow.name="parent.opener."+fieldName
	}
	function displayReturn()
	{
		newWindow = window.open("ezReturn.jsp?Reason=<%=Reason%>","Mywin","resizable=no,left=250,top=100,height=350,width=400,status=no,toolbar=no,menubar=no,location=no")

	}
	
	function ezListPage(obj)
	{
	   document.generalForm.urlPage.value="listPage"
	   document.generalForm.orderStatus.value="'"+obj+"'"
	   document.generalForm.action="../Misc/ezMenuFrameset.jsp"
	   document.generalForm.target="main"
	   document.generalForm.submit()
	}
	
<%
     	
	if( retLines.getRowCount()>4)
	{
  	  out.println("retlen=1");
	}
	if( CU || AG || NEW)
	{
	  out.println("log=1");
	}
	else if(LF)
	{
	  out.println("log=2");
	}
	else
	{
	  out.println("log=0");
	}
	%>
	function chkDiscount(obj)
	{
         
	  name=obj.name;
	  obj.value=funTrim(obj.value)
	if(name=="disPercentage")
	{
		obj1=document.generalForm.disCash;
		obj1.value = funTrim(obj1.value);
		if(obj1.value != "0")
		{
			if(obj.value !=0)
			{
			alert("<%=notEntValDisPer_A%>");
			obj.value="0"
			}

		}else
		{
			if(obj.value < 0)
			{
			  alert("<%=disPerNotZero_A%>");
			  obj.value="0"
			}
			else if ( isNaN( parseFloat(obj.value) ))
			{
			 alert("<%=plzEntValiDis_A%>")
 			 obj.value="0"
			}
		}

	}

	if(name=="disCash")
	{
		obj1=document.generalForm.disPercentage;
		obj1.value = funTrim(obj1.value);
		if(obj1.value != "0")
		{
			if(obj.value !=0)
			{
				alert("<%=notEntValDisPer_A%>");
				obj.value="0";
			}

		}else
		{
			if(obj.value < 0)
			{
			  alert("<%=disCashNotZero_A%>");
			  obj.value="0"
			}
			else if ( isNaN( parseFloat(obj.value) ))
			{
			 alert("<%=plzEntDisNum_A%>")
 			 obj.value="0"
			}
		}
	}

}
	function qtyFocus()
	{
		if( ("CU" == UserRole) || ("AG"== UserRole))
		document.generalForm.desiredQty.focus();

	}


	function chkDelSumbit()
	{

		var chkbox = document.generalForm.chk.length;

		chkCount=0
		if(isNaN(chkbox))
		{
			if(document.generalForm.chk.checked)
			{
				chkCount++;

			}
		}
		else
		{
			for(a=0;a<chkbox;a++)
			{
				if(document.generalForm.chk[a].checked)
				{
					chkCount++;

					break;
				}
			}
		}
		if(chkCount == 0)
		{
			alert("<%=plzSelLinesToDel_A%>");
			return false;
		}

		return true;
	}

	function ezDelSOLines()
	{

		var chkValue=""
		if(chkDelSumbit())
		{
                     
                     	/*
		       if(confirm("<%=permaDelLines_A%>"))
		       {
				var chkbox = document.generalForm.chk.length;
				netValue=0
				chkCount=0
				totalValue = document.generalForm.estNetValue.value;
				if(isNaN(chkbox))
				{
					if(document.generalForm.chk.checked)
					{
						
						
						chkValue=document.generalForm.chk.value
						netValue=document.generalForm.value2.value
					}
				}
				else
				{
					
					for(a=0;a<chkbox;a++)
					{
						if(document.generalForm.chk[a].checked)
						{
							if(chkValue=="")
							{
								chkValue=document.generalForm.chk[a].value
								netValue=eval("document.generalForm.value2["+a+"].value");
								
							}
							else
							{
								chkValue=chkValue+ "," + document.generalForm.chk[a].value
								netValue1=eval("document.generalForm.value2["+a+"].value");
								netValue=parseFloat(netValue)+parseFloat(netValue1);
							}

						}
					}
				}


			sono=document.generalForm.soNo.value
			soldTo ="<%=SoldTo%>" 
			sysKey ="<%= sdHeader.getFieldValueString(0,"SALES_AREA") %>"
			document.location.replace("ezDeleteSales.jsp?chk=" + chkValue+"&SONO=" + sono + "&total="+total+"&netValue="+netValue +"&TotalValue="+totalValue+"&status="+statusOrder+"&sysKey="+sysKey+"&soldTo="+soldTo);
			
			}
			*/
			
	
			var chkbox = document.generalForm.chk.length;
			if(isNaN(chkbox))
			{
				if(document.generalForm.chk.checked)
				{
					alert("There must be atleast one product in sales order");
					return;

					//chkValue=document.generalForm.chk.value
					//netValue=document.generalForm.value2.value
				}
			}
			else
			{
				if(confirm("<%=permaDelLines_A%>"))
				{
					netValue=0
					chkCount=0
					totalValue = document.generalForm.estNetValue.value;				
					for(a=0;a<chkbox;a++)
					{
						if(document.generalForm.chk[a].checked)
						{
							if(chkValue=="")
							{
								chkValue=document.generalForm.chk[a].value
								netValue=eval("document.generalForm.value2["+a+"].value");

							}
							else
							{
								chkValue=chkValue+ "," + document.generalForm.chk[a].value
								netValue1=eval("document.generalForm.value2["+a+"].value");
								netValue=parseFloat(netValue)+parseFloat(netValue1);
							}

						}
					}
					sono=document.generalForm.soNo.value
					soldTo ="<%=SoldTo%>" 
					sysKey ="<%= sdHeader.getFieldValueString(0,"SALES_AREA") %>"
					document.location.replace("ezDeleteSales.jsp?chk=" + chkValue+"&SONO=" + sono + "&total="+total+"&netValue="+netValue +"&TotalValue="+totalValue+"&status="+statusOrder+"&sysKey="+sysKey+"&soldTo="+soldTo);
				}	
			}

		}
	}


	var product = new Array(); //to get selected on Load
	var packs = new Array();   //to get selected on Load
	var total = "<%=retLines.getRowCount()%>"; //to check mandatory
	var ship= new Array();
	var sold= new Array();

	var UserRole = "<%=UserRole%>";
	var UserLogin = "<%= UserLogin %>";
	var CreatedBy = "<%= CreatedBy %>";
	
	var StatusDate  = "<%=fD.getStringFromDate(std,formatkey,FormatDate.MMDDYYYY)%>";
	var notesCount = new Array();
	var jsp="Edit"
        var compDates = new Array();
	var incoterms1 ="<%=  sdHeader.getFieldValueString(0,"INCO_TERMS1")%>"
	var paymentterms ="<%=  sdHeader.getFieldValueString(0,"PAYMENT_TERMS")%>"
	var incoterms2 ="<%= sdHeader.getFieldValueString(0,"INCO_TERMS2")%>"

	notesLength=0;

	var selSelect = new Array();

	if(   ("RETURNEDBYCM"==statusOrder)|| ("NEW"==statusOrder) )
	{
		//selSelect[0]="IncoTerms1,<%= incoterms1 %>"
		//selSelect[1]="PaymentTerms,<%=  payterms.trim() %>"

	}
	function select1()
	{

		for(j=0;j<selSelect.length;j++)
		{	alert(selSelect.length)
			selselect(selSelect[j]);
		}

	}
        function showSpan(spId)
        {
	spanStyle=document.getElementById(spId).style
	if(spanStyle.display=="none")
		spanStyle.display=""
	else
		spanStyle.display="none"
    }

    function chkEqualDates()
    {
	if(total==1)
	{
		if( compDates[0] != funTrim(document.generalForm.commitedDate.value))
			return false;
	}
	else if(total > 1)
	{
		for(i=0;i<total;i++)
		{
			if( compDates[i] != funTrim(eval("document.generalForm.commitedDate["+i+"].value")))
				return false;
		}
	}
	var doc =document.generalForm
	if( (incoterms1 !=doc.incoTerms1.options[doc.incoTerms1.selectedIndex].value )||(incoterms2 != doc.incoTerms2.value )||(paymentterms != doc.paymentTerms.options[doc.paymentTerms.selectedIndex].value) )
	{
 		return false;
	}
	return true;
   }

  var today ="<%= FormatDate.getStringFromDate(new Date(),formatkey,FormatDate.MMDDYYYY) %>"

 function chkCompDates()
 {

	if( (statusOrder == "NEW") || (statusOrder == "RETURNEDBYCM") )
	{
		if(total==1)
		{
			obj=document.generalForm.desiredDate;
			obj.value=funTrim(obj.value)
			
			if( obj.value == "")
			{
				alert("<%=plzSelReqDt_A%>");
				return false;
			}
			else
			{
				a=(obj.value).split('<%=formatkey%>');
				b=(today).split('<%=formatkey%>');
					d1=new Date(a[2],a[0]-1,a[1])
					d2=new Date(b[2],b[0]-1,b[1])
				 if(   d1  <  d2)
				{
					alert("<%=reqDtGtToday_A%>");
					return false;
				}

			}
		}else
		{
			for(i=0;i<total;i++)
			{
				obj = eval("document.generalForm.desiredDate["+i+"]")
				obj.value=funTrim(obj.value)
				if( obj.value == "")
				{
					alert("<%=plzSelReqDt_A%>");
					return false;
				}
				else
				{
					a=(obj.value).split('<%=formatkey%>');
					b=(today).split('<%=formatkey%>');

					d1=new Date(a[2],(a[1]-1),a[0])
					d2=new Date(b[2],(b[1]-1),b[0])

					if( d1 < d2)
					{
						alert("<%=plzSelReqDt_A%>");
						return false;
					}
				}
			}
		}
	}else
	{
		if(total==1)
		{
			obj=document.generalForm.commitedDate;
			obj.value=funTrim(obj.value)

			if( obj.value == "")
			{
				alert("<%=plzSelConfDt_A%>");
				return false;
			}
			else
			{
				a=(obj.value).split('<%=formatkey%>');
				b=(compDates[0]).split('<%=formatkey%>');
					d1=new Date(a[2],(a[1]-1),a[0])
					d2=new Date(b[2],(b[1]-1),b[0])
				 if(   d1  <  d2)
				{
					alert("<%=confDtGtToday_A%>");
					return false;
				}

			}
		}else
		{
			/*
			for(i=0;i<total;i++)
			{
				obj = eval("document.generalForm.commitedDate["+i+"]")
				obj.value=funTrim(obj.value)
				if( obj.value == "")
				{
					alert("<%=plzSelConfDt_A%>");
					return false;
				}
				else
				{
					a=(obj.value).split('<%=formatkey%>');
					b=(compDates[i]).split('<%=formatkey%>');
					c=(today).split('<%=formatkey%>');

					d1=new Date(a[2],(a[1]-1),a[0])
					d2=new Date(b[2],(b[1]-1),b[0])
					d3=new Date(c[2],(c[1]-1),c[0])
					if(d1 <d3 )
					{
						alert("<%=confDtGtToday_A%>");
						return false;

					}
					if( d1 < d2)
					{
						alert("<%=confDtGtReqDt_A%>");
						return false;
					}
				}

			}*/
		}

	}
	return true;
 }
function openNewWindow(obj,i)
{

	if(!(obj.substring(0,14)=='ezDatesDisplay'))
		eval("document.generalForm.changeFlag_"+i+".value=false")
	if(total==1)
		totQty=document.generalForm.desiredQty.value
	else
		totQty=document.generalForm.desiredQty[i].value
		
	obj=obj + "&status="+statusOrder+"&totQty="+totQty	
	newWindow = window.open(obj,"multi","resizable=no,left=250,top=90,height=450,width=400,status=no,toolbar=no,menubar=no,location=no")
}
function nextEdit()
{
	y="true";
	y= chkcompqty()
		
	if(eval(y))
	{
		res = chkCompDates()
		
		if(!eval(res))
			return false
		
		showTabEdit("2");
	}
}
function showTabEdit(tabToShow)
	{

	obj1=document.getElementById("div1")
	obj2=document.getElementById("div2")
	obj3=document.getElementById("theads")
	obj4a=document.getElementById("InnerBox1Div")
	obj5=document.getElementById("div5")
	obj6=document.getElementById("div6")
	obj7=document.getElementById("div7")


		if(tabToShow==1)
		{
			obj1.style.visibility="visible"
			obj3.style.visibility="visible";
			obj4a.style.visibility="visible";
			obj5.style.visibility="visible"
			obj2.style.visibility="hidden"
			obj6.style.visibility="hidden"
			obj7.style.visibility="hidden"
			scrollInit();
		}
		else if(tabToShow==2)
		{
			obj1.style.visibility="hidden"
			obj2.style.visibility="visible"
			obj6.style.visibility="visible"
			obj7.style.visibility="visible"
			obj3.style.visibility="hidden";
			obj4a.style.visibility="hidden";
			obj5.style.visibility="hidden"
		}
	}


  </script>
<script>
<%--
 these variables are used in ezSalesDetails.js ,ezSalesValidations.js
 --%>
var pleaseenter ="<%=plzEnter_A%>"
var permenantlydelete="<%=permaDelLines_A%>"
var PleaseclickongetPrices="<%=plzPriceChanQuant_A%>"
var SavetheOrderforMod ="<%=saveFurModifi_A%>"
var SavetheOrder="<%=saveOrder_A%>"
var AccepttheOrder= "<%=accOrdeApproval_A%>"
var Submittheorder="<%=subOrdeApproval_A%>"
var Approvetheorder="<%=approOrder_A%>"
var Deletetheorder = "<%=delOrder_A%>"
var Rejecttheorder="Reject the order"
var Returntheorder="<%=returnOrder_A%>"
var Posttheorder="<%=postOrder_A%>"
var Accepttheordercu = "<%=acceptOrder_A%>"
var Changingthequantitywillgetprices="<%=changeQutConti_A%>"
var selectShipTo="<%=plzSelShipTO_A%>"
var SelectINCOTerms="<%=plzIncoTerms_A%>"
var SelectPaymentTerms="<%= plzSelPTerms_A%>"
var enterQuantitybyclickingonDeliveryDates ="<%=plzQutDeliDate_A%>"
var enterConfirmedPrice="<%=plzConfiPrice_A%>"
var Quantitycannotbelessthanorequalto0="<%=quanLessEqual_A%>"
var ConfirmedPricecannotbelessthanorequalto0="<%=confiLessEqual_A%>"
var entervalidQuantity="<%=plzValidQty_A%>"
var entervalidConfirmedPrice="<%=plzValidCPrice_A%>"
var FOCcannotbelessthan0="<%=focLessZero_A%>"
var entervalidFOCinNumbers="<%=plzFOCNum_A%>"
var enterFreight="<%=plzFreight_A%>"
var Freightcannotbelessthanorequalto0="<%=freightLessZero_A%>"
var entervalidFreightinNumbers="<%=plzValidFrightNum_A%>"
</script>	

<script src="../../Library/JavaScript/Sales/ezSalesDetails.js"></script>
<script src="../../Library/JavaScript/Sales/ezSalesValidations.js"></script>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
<script src="../../Library/JavaScript/Misc/ezTrim.js"></script>
<script src="../../Library/JavaScript/changeAddress.js"></script>
<Script>
		  var tabHeadWidth=95
 	   	  var tabHeight="45%"
</Script>
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>


</head>
<body onLoad="scrollInit();select1()" onresize="scrollInit()" scroll=no> 
<form method="post" name="generalForm">
<input type="hidden" name="urlPage">
<input type="hidden" name="orderStatus">

<table align=center border="0" cellpadding="0" class="displayheaderback" cellspacing="0" width="100%" id="header" >
<tr>
       <td height="35" align=center class="displayheaderback"  width="100%">Sales Order</td>
  </tr>
</table>



<input type="hidden" name="poNo" value="<%=sdHeader.getFieldValueString(0,"PO_NO") %>">
<input type="hidden" name="poDate" value="<%= sdHeader.getFieldValueString(0,"RES1") %>">
<input type="hidden" name="newFilter" value="<%=request.getParameter("newFilter")%>">
<input type="hidden" name="status" value="<%= StatusButton %>">
<input type="hidden" name="statusDate"  value="<%=fD.getStringFromDate(std,formatkey,FormatDate.MMDDYYYY)%>">
<input type="hidden" name="webOrNo" value="<%= WebOrNo %>">
<input type="hidden" name="createdBy"  value="<%= CreatedBy %>">
<input type="hidden" name="agent" value="<%=sdSoldTo.getFieldValueString(0,"AGENT_CODE")%>">
<input type="hidden" name="docType"  value="<%= sdHeader.getFieldValueString(0,"REF_DOC_TYPE") %>">
<input type="hidden" name="refdoc"  value="<%= sdHeader.getFieldValueString(0,"REF_DOC_NO") %>">

<%

Vector types = new Vector();
types.addElement("date");
types.addElement("date");
types.addElement("currency");
types.addElement("date");
EzGlobal.setColTypes(types);

Vector names = new Vector();
names.addElement("ORDER_DATE");
names.addElement("STATUS_DATE");
names.addElement("NET_VALUE");
names.addElement("RES1");

EzGlobal.setColNames(names);
ezc.ezparam.ReturnObjFromRetrieve ret = EzGlobal.getGlobal(sdHeader);


%>

<div id="div1" style="visibility:visible">
<Table id="table1" width="95%"  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
    <Tr>
       <th class="labelcell" align="left"><%=weorno_L%>:</th>
       <td><input type="hidden" name="soNo" value="<%= WebOrNo %>"><%= WebOrNo %></td>
  	<th class="labelcell" align="left"><%=weordate_L%>:</th>
        <td>
		<input type="hidden" name="orderDate" value="<%=ret.getFieldValueString(0,"ORDER_DATE")%>"><%=ret.getFieldValueString(0,"ORDER_DATE")%>
		<input type="hidden" name="createdBy" value="<%=CreatedBy%>">
		<input type="hidden" name="modifiedBy" value="<%=ModifiedBy%>">
	  </td>
	  <% if(!CU){  %>
        <Th class="labelcell" align="left"><%=crby_L%>:</Th>
	  <Td><%= CreatedBy %></Td>
	  <%}else{
	  %>
	   <Th class="labelcell" align="left"><%=lamoby_L%>:</Th>
	  <Td><%= ModifiedBy %></Td>
	  <%} %>
     </Tr>
<%
	 String netValue = null;
	 String Currency = null;


	if(sessionValue)
	{
		netValue= request.getParameter("netValue");
		Currency = request.getParameter("currency");
		if(( (Currency == null) && (Currency.trim().length()==0))||("null".equals(Currency)))
		{
%>
		<%@ include file="../../../Includes/JSPs/Sales/iGetUserCurrency.jsp" %>
<%
		Currency = UserCurrency;
		}

	}
	else
	{
		/* if( (delete1 != null) && (delete1.trim().length() !=0) )
		 {
			java.math.BigDecimal netValue1 = new java.math.BigDecimal("0");
			for( i=0;i<retLines.getRowCount();i++)
			{
				java.math.BigDecimal bUprice = new java.math.BigDecimal( retLines.getFieldValueString(i,"DESIRED_PRICE") );
				///bUprice=bUprice.setScale(3,java.math.BigDecimal.ROUND_HALF_UP);
				java.math.BigDecimal bQty = new java.math.BigDecimal(retLines.getFieldValueString(i,"DESIRED_QTY"));
	     			java.math.BigDecimal bPrice = bQty.multiply(bUprice);
				netValue1 = netValue1.add(bPrice);
			}
			netValue = netValue1.toString();
		 }
		 else
		 {*/
			netValue = ret.getFieldValueString(0,"NET_VALUE");
		// }
		  Currency = sdHeader.getFieldValueString(0,"DOC_CURRENCY");

	}

%>

     <Tr>
	  <th class="labelcell" align="left"><%=pono_L%>:</th>
        <td><%=sdHeader.getFieldValueString(0,"PO_NO") %></td>
 	  <th class="labelcell" align="left"><%=podate_L%>:</th>
<%
	String podate = sdHeader.getFieldValueString(0,"RES1");
	if(podate== null || "null".equals(podate))
		podate=" ";
	try {
		StringTokenizer podateF=new StringTokenizer(podate,".");
		String  forkey=(String)session.getValue("formatKey");
		String dd = (String)podateF.nextElement();
		String mm = (String)podateF.nextElement();
		String yy = (String)podateF.nextElement();
		podate=mm+forkey+dd+forkey+yy;
	}catch(Exception e){

	}

	
%>
        <Td><%= podate%>&nbsp;</Td>
	  <Th align="left"><%=curr_L%>:</Th>
	  <Td><input type="hidden" name="docCurrency" value="<%= Currency %>"><%= Currency %></Td>
    </Tr>
    <Tr >
      <th class="labelcell" align="left"><%=soldto_L%>: </th>
	<td>
		 <input type="hidden" name="soldTo" value="<%= sdSoldTo.getFieldValueString(0,"SOLD_TO_CODE") %>">

			<%
		 			String name = sdSoldTo.getFieldValueString(0,"SOTO_NAME");
					out.println("<input type='hidden' name='soldToName' value='"+name+"'>");
					if(name.length() > 17)
					{
						name = name.substring(0,17)+"..";
					}out.println(name);
		 	%>
	</Td>
	<th class="labelcell" align="left"><%=shipto_L%>: </th>
	<Td>
		<input type="hidden" name="shipTo" value="<%=sdShipTo.getFieldValueString(0,"SHIP_TO_CODE")%>">
		<%
			name =sdShipTo.getFieldValueString(0,"SHTO_NAME") ;
			out.println("<input type='hidden' name='shipToName' value='"+name+"'>");
			if(name.length() > 17)
			{
				name = name.substring(0,17)+"..";
			}out.println(name);
 		%>
	</Td>
	  <Th align="left"><%=esnet_L%>:</Th>
	  <Td><input type="hidden" name="estNetValue" value="<%=netValue%>"><%=netValue%>
	  <input type="hidden" name="disCash"  value="<%=DisCash%>">
	  <input type="hidden" name="disPercentage" value="<%=DisPer%>">
	  <input type="hidden" name="freight" value="<%=Freight%>">
	  </Td>

    </Tr>
    <%--
    <Tr>
	<Th class="labelcell" align="left"><%=disCash_L%>:</Th>
	<Td>
	<%
		if( (NEW || RETURNEDBYCM || LF) && (!sessionValue || LF))
		{
	%>
			<input type="text" name="disCash" size="8" onBlur="chkDiscount(this)" value="<%=DisCash%>">
	<%
		}else{
	%>
			<input type="hidden" name="disCash"  value="<%=DisCash%>"><%=DisCash%>
	<%	}%>
	</Td>
	<Th class="labelcell" align="left"><%=discount_L%>(%):</Th>
	<Td>
	<%
		if( (NEW || RETURNEDBYCM || LF) && (!sessionValue || LF) )
		{
	%>
			<input type="text" name="disPercentage" size="3" maxlength="2" onBlur="chkDiscount(this)" value="<%=DisPer%>">
	<%
		}else{
	%>
			<input type="hidden" name="disPercentage" value="<%=DisPer%>"><%=DisPer%>
	<%    }%>
	%</Td>
	<Th class="labelcell" align="left"><%=friCharg_L%>:</Th>
	<Td>
	<%
		if(LF){//onBlur="verifyFOC(this)"
	%>
		<input type="text" name="freight" size="8" onBlur="chkFreight(this)" value="<%=Freight%>">
	<%	}else{
	%>
		<input type="hidden" name="freight" value="<%=Freight%>"><%=Freight%>
	<%	} %>
	</Td>

    </Tr>
    --%>
</Table>


<!--      ******************************    END OF HEADER ********************************** -->

<% 
  out.println("</div>");

	out.println("<Div id='theads'>");
	out.println("<Table width='95%' id='tabHead'  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >");
%>

<tr align="center" width="100%">
     <%  if( LF ){%>
	  <th  colspan="11"><b> <%=podet_L%></b></th>
    <%}else{%>
 	  <th  colspan="10"><b> <%=podet_L%></b></th>
      <%}%>
</tr>
<%if(NEW || RETURNEDBYCM)
  {%>
         <Tr align="center" valign="middle">
	  <%
	    if(sessionValue )
	    {
	   %>
		   <th width="35%" ><%=prdesc_L%></th>
	    <%
	    }else{
	    %>
		   <th width="5%">&nbsp;</th>
		   <th width="30%" ><%=prdesc_L%></th>
	   <% } %>
	      <th width="5%" ><%=uom_L%></th>
	    <%if(sessionValue)
	    {%>  
	      	<th width="10%"><%=quan_L%></th>
	    <%
	    }else{
	    %>	
	      	<th width="10%"><%=quan_L%>[UQ]</th>
	      <%}%>
	      <th width="10%" ><%=price_L%> [<%=Currency%>]</th>
	      <Th width="13%"><%=value_L%> [<%=Currency%>]</Th>
	      <th width="12%"><%=delDate_L%></th>
	
	   <%if(CM){%>
	    <th width="5%">ATP</th>
	   <%}%>
	</Tr>
<%}else
  {%>
     <%if( LF || BP ){%>
		<Tr>
		       <th rowspan=2 colspan="2" width="25%"><%=prdesc_L%></th>
		       <th rowspan=2 width="5%"><%=uom_L%></th>
		       <th rowspan=2 width="11%"><%=quan_L%></th>
		       <th colspan=2 width="30%" valign="top"><%=price_L%> [<%=Currency%>]</th>
		       <Th rowspan=2 width="12%"><%=value_L%> [<%=Currency%>]</Th>
		       <th rowspan=2 width="12%"><%=delDate_L%></th>
		       <Th rowspan=2  width=5%>ATP</Th>
		</Tr>
		<Tr>
			<Th width="15%" valign="top"><%=req_L%></Th>
			<Th width="15%" valign="top"><%=con_L%></Th>
		<Tr>

	     <%}else{%>
		<Tr>
		     <th width="28%"><%=prdesc_L%></th>
		     <th width="5%"><%=uom_L%></th>
		     <th width="14%"><%=quan_L%></th>
		     <th width="10%"><%=price_L%> [<%=Currency%>]</th>
		     <Th width="16%" ><%=value_L%> [<%=Currency%>]</Th>
		     <th width="13%" valign="top"><%=dat_L%></th>
		     <th width="5%">ATP</th>
		</Tr>


	    <%}
  }

	out.println("</Table>");
	out.println("</div>");
	out.println("<DIV id='InnerBox1Div' style='overflow:auto;position:absolute;width:98%;height:60%;left:2%'>");
	out.println("<Table width='100%' id='InnerBox1Tab'  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >");

     int rows=1;

java.text.NumberFormat nformat = java.text.NumberFormat.getCurrencyInstance((java.util.Locale)session.getValue("LOCALE"));

Vector types1= new Vector();
types1.addElement("currency");
types1.addElement("currency");
types1.addElement("date");
types1.addElement("date");
EzGlobal.setColTypes(types1);

Vector names1= new Vector();
names1.addElement("DESIRED_PRICE");
names1.addElement("COMMIT_PRICE");
names1.addElement("REQ_DATE");
names1.addElement("PROMISE_FULL_DATE");
EzGlobal.setColNames(names1);
ezc.ezparam.ReturnObjFromRetrieve ret1 = EzGlobal.getGlobal(retLines);
java.math.BigDecimal bPrice =null;
     for( i=0;i<retLines.getRowCount();i++)
     {
		String delSchQty="";
		String delSchDates="";
		String delProdLine="";
		String prodNo = retLines.getFieldValueString(i,"PROD_CODE");
		String prodDesc = retLines.getFieldValueString(i,"PROD_DESC");
		
		
		  prodDesc = prodDesc.replace('\"',' ');

		  prodDesc = prodDesc.replace('\'',' ');

		String prodPack = retLines.getFieldValueString(i,"UOM");
		String ProdLine = retLines.getFieldValueString(i,"SO_LINE_NO");
		int chkcount =0;
 		String RefDocItem =retLines.getFieldValueString(i,"REF_DOC_ITEM");
		String prodDesiredprice="";
		String prodCommitedprice="";
		String prodDesiredQty="";
		String prodCommitedQty="";
		String unitQty="";
		String prodDesiredPriceFormat ="";
		String prodCommitedPriceFormat="";
		java.util.Date rd=null;
		java.util.Date cd = null;
		String crd=null,ccd=null;
		String a = prodNo;
		String foc="";
		
		for(int k=0;k<retDeliverySchedules.getRowCount();k++)
		{
			delProdLine = retDeliverySchedules.getFieldValueString(k,"EZDS_ITM_NUMBER");
			if(ProdLine.equals(delProdLine))
			{
				if(! ("0").equals(retDeliverySchedules.getFieldValueString(k,"EZDS_REQ_QTY") ))
					chkcount++;
			}
		}
		try{
			a = String.valueOf(Long.parseLong(a));
		}catch(Exception e)
		{
		}
		String a1= a+"---"+prodDesc;
		if(sessionValue)
		{
			StringTokenizer stpro = new StringTokenizer((String)getValues.get(prodNo),",");
			String qty="";
			String date="";
			try{
				prodDesiredQty = stpro.nextToken();
				crd=stpro.nextToken();
				foc=stpro.nextToken();

			}catch(Exception e)
			{

			}
			prodDesiredprice =(String)getprices.get(prodNo);
			prodDesiredprice = ( (prodDesiredprice==null) || (prodDesiredprice=="") || (("").equals(prodDesiredprice)) || (("null").equals(prodDesiredprice)) )?"0":prodDesiredprice;
			prodCommitedprice = prodDesiredprice;
			prodCommitedQty = prodDesiredQty;
			ccd=crd;

		}
		else
		{

			prodDesiredprice = retLines.getFieldValueString(i,"DESIRED_PRICE");
			prodCommitedprice = retLines.getFieldValueString(i,"COMMIT_PRICE");
			prodDesiredQty = retLines.getFieldValueString(i,"DESIRED_QTY");
			prodCommitedQty = retLines.getFieldValueString(i,"COMMITED_QTY");
			unitQty = retLines.getFieldValueString(i,"UOM_QTY");
			foc = retLines.getFieldValueString(i,"FOC");
			rd=(java.util.Date)retLines.getFieldValue(i,"REQ_DATE");
			cd=(java.util.Date)retLines.getFieldValue(i,"PROMISE_FULL_DATE");
			crd = ret1.getFieldValueString(i,"REQ_DATE");
			ccd =ret1.getFieldValueString(i,"PROMISE_FULL_DATE");
			foc= ( ("null".equals(foc) )||(foc==null) || (foc.trim().length() ==0) ) ?"0":foc;
		}

	      java.math.BigDecimal bUprice = new java.math.BigDecimal( prodDesiredprice );
	      java.math.BigDecimal bUCprice = new java.math.BigDecimal(prodCommitedprice);
	      bUprice=bUprice.setScale(3,java.math.BigDecimal.ROUND_HALF_UP);
	      java.math.BigDecimal bQty = new java.math.BigDecimal(prodDesiredQty);
	      bPrice = bQty.multiply(bUCprice);
	      prodDesiredPriceFormat = bUprice.setScale(3,java.math.BigDecimal.ROUND_HALF_UP).toString();//myFormat.getCurrencyString(bUprice.doubleValue());
	      prodCommitedPriceFormat= bUCprice.setScale(3,java.math.BigDecimal.ROUND_HALF_UP).toString();//myFormat.getCurrencyString(bUCprice.doubleValue());
		//this is temparary only
			prodCommitedprice=prodCommitedPriceFormat;
	String DatesEntry="";
	String DatesDisplay="";
	
	if(chkcount >=2)
	{
		DatesEntry="<a href=\"JavaScript:openNewWindow('ezDatesEntry.jsp?ind="+i+"&matdesc="+prodDesc+"&unitQty="+unitQty+"&itemNo="+ProdLine+"','"+i+"')\">"+multiple_L+"</a>";
		DatesDisplay="<a href=\"JavaScript:openNewWindow('ezDatesDisplay.jsp?ind="+i+"&matdesc="+prodDesc+"&unitQty="+unitQty+"&itemNo="+ProdLine+"','"+i+"')\">"+multiple_L+"</a>";
	}else
	{
		DatesEntry="<a href=\"JavaScript:openNewWindow('ezDatesEntry.jsp?ind="+i+"&matdesc="+prodDesc+"&unitQty="+unitQty+"&itemNo="+ProdLine+"','"+i+"')\"><Div id=editDateEntry_"+i+">"+crd+"</div></a>";
		DatesDisplay="<a href=\"JavaScript:openNewWindow('ezDatesDisplay.jsp?ind="+i+"&matdesc="+prodDesc+"&unitQty="+unitQty+"&itemNo="+ProdLine+"','"+i+"')\"><Div id=editDateDisplay_"+i+">"+crd+"</div></a>";
	}

	%>
	<script>
		compDates[<%=i%>] ="<%= ccd.trim() %>";
		compfoc[<%=i%>]="<%=foc%>"
		compprice[<%=i%>] = "<%= prodCommitedprice %>"
		compqty[<%=i%>] = "<%= prodDesiredQty %>"
	</script>

	<tr  valign="middle">
	<%
	
	
	if( NEW || RETURNEDBYCM)
      	{
		if(!sessionValue)
		{
	%>
		<td width="5%" align=center><input type=checkbox name="chk" value="<%= ProdLine %>" ></td>
		<td width="30%" title="<%= a1 %>" alt="<%= a1 %>">
			<input type="text" name="waste" class="tx" size="28" value="<%=prodDesc %>">
		</Td>
	<%
		}else
		{
	%>
		<td width="35%" title="<%= a1 %>" alt="<%= a1 %>">
			<input type="text" name="waste" class="tx" size="28" value="<%=prodDesc %>">
		</Td>
	<%
		}
	%>
		<Td width="5%">
			<input type="hidden" name="productDesc"   value="<%=prodDesc %>">
			<input type="hidden" name="pack" value="<%= prodPack %>"><%= prodPack %>
		</Td>
		<Td width="10%" align="left">
		
		
		<%if(sessionValue)
		{%>
			
			<input type="hidden" name="desiredQty" value="<%= prodDesiredQty %>"><%= prodDesiredQty %>
		<%}else{
		%>
			<input type="text" size=6 STYLE="text-align: right" class=InputBox  name="desiredQty" onChange="calValue(this,'<%=prodDesc %>','<%= unitQty %>','<%=ProdLine%>','<%=i%>','<%= prodDesiredQty %>')" value="<%= prodDesiredQty %>">[<%= unitQty %>]
		<%}%>
		 <input type="hidden" name="focVal"  value="<%= foc %>">
		</Td>
		<Td width="10%" align="right"><input type="hidden" name="desiredPrice"  value="<%=prodDesiredprice %>"><%= prodDesiredPriceFormat %></Td>
		<Td width="13%" align="right"><input type="hidden" name="value2" value="<%= bPrice %>"><%=myFormat.getCurrencyString(bPrice)%></Td>
	      	<Td width="12%" align="center" nowrap>
		  <input type="hidden" name="desiredDate" value="<%=crd%>">
		  <input type="hidden" name="changeFlag_<%=i%>" value="true">
		  <input type="hidden" name="commitedQty"  value="<%= prodDesiredQty %>">
		  <input type="hidden" name="commitedPrice"  value="<%= prodDesiredprice %>">
		  <input type="hidden" name="commitedDate"  value="<%=crd%>">
		  <input type="hidden" name="unitQty"  value="<%= unitQty %>">
		  
		  <input type="hidden" name="lineNo" value="<%= ProdLine %>">
		  <input type="hidden" name="product" value="<%=prodNo %>">
		<input type="hidden" name="refDocItem"  value="<%=RefDocItem %>">
		<%
			if(!sessionValue)
			out.println(DatesEntry);
			else
			out.println(DatesDisplay);
		%>
		</Td>
		<%if(CM){%>
		<Td width="5%"  align=center><img src="../../Images/Buttons/<%= ButtonDir%>/atp.gif" style="cursor:hand" onClick="showATP(<%= i %>)"  border="none" valign="center" ></td>
		<%}%>

	<%
	}else
	{
          if( LF || BP)
	  {
%>
		<td width="25%" colspan="2" title="<%= a1 %>" alt="<%= a1 %>">
			<input type="text" name="productDesc"  size="25" class="tx" readonly onFocus="blur()" value="<%=prodDesc %>">
			<input type="hidden" name="waste" value="<%= prodDesc %>">
		</Td>
	        <Td width="5%"><input type="hidden" name="pack" value="<%= prodPack %>"><%= prodPack %></Td>
	        
		<Td width="11%" align="right">
		<input type="hidden" name="changeFlag_<%=i%>" value="true">
		<input type="hidden" name="desiredQty"   value="<%= prodDesiredQty %>">
		<input type="hidden" name="commitedQty"  value="<%= prodCommitedQty %>"><%= myFormat.getCurrencyString(prodCommitedQty) %>
		<input type="hidden" name="focVal" value="<%= foc %>">
		</Td>
		<Td width="15%" align="right"><input type="hidden" name="desiredPrice"  value="<%= prodDesiredprice %>"><%=prodDesiredPriceFormat %></Td>
		<Td width="15%" align="right"><input type="text" tabIndex="<%=rows+1%>" name="commitedPrice"  class=InputBox STYLE="text-align: right;width:100%"  value="<%=prodCommitedprice %>"></Td>
		<Td width="12%" align="right">
		  <input type="hidden" name="value2" value="<%=bPrice%>"><%=myFormat.getCurrencyString(bPrice)%>
		  <input type="hidden" name="lineNo" value="<%= ProdLine %>">
		  <input type="hidden" name="product" value="<%=prodNo %>">
		<input type="hidden" name="refDocItem"  value="<%=RefDocItem %>">
		<input type="hidden" name="unitQty"  value="<%= unitQty %>">

		</Td>
		<Td width="12%" align="center" nowrap>
			<input type="hidden" name="desiredDate"  value="<%= crd %>">
	       		<input type="hidden" name="commitedDate"  value="<%=ccd%>">
			<%=DatesDisplay%>
		</Td>
		<Td width="5%"  align=center><img src="../../Images/Buttons/<%= ButtonDir%>/atp.gif" style="cursor:hand" onClick="showATP(<%= i %>)"  border="none" valign="center" ></Td>
	<%}else{%>
		<td width="28%" title="<%= a1 %>" alt="<%= a1 %>">
			<input type="text" name="waste"   onFocus="blur()" size="27" class="tx" readonly value="<%=prodDesc %>">
			<input type="hidden" name="productDesc" value="<%=prodDesc %>">
		</Td>
  		<Td width="5%"><input type="hidden" name="pack" value="<%= prodPack %>"><%= prodPack %></Td>
		<Td width="14%" align="right">
			<input type="hidden" name="changeFlag_<%=i%>" value="true">
			<input type="hidden" name="desiredQty"   value="<%= prodDesiredQty %>">
			  <input type="hidden" name="commitedQty"  value="<%= prodCommitedQty %>"><%= myFormat.getCurrencyString(prodCommitedQty) %>
			  <input type="hidden" name="focVal"  value="<%= foc %>">
		</Td>
		<Td width="10%" align="right"><input type="hidden" name="desiredPrice"  value="<%= prodDesiredprice %>">
			  <input type="hidden" name="commitedPrice"  value="<%=prodCommitedprice %>" ><%=prodCommitedPriceFormat %>
		</Td>
		<Td width="16%" align="right">
			  <input type="hidden" name="value2" value="<%=bPrice%>"><%=nformat.format(bPrice)%>
			  <input type="hidden" name="lineNo" value="<%=ProdLine %>">
			  <input type="hidden" name="product" value="<%=prodNo %>">
			  <input type="hidden" name="unitQty"  value="<%= unitQty %>">
		</Td>
		<Td width="13%" align="center" nowrap>
			<input type="hidden" name="desiredDate"  value="<%= crd %>">
			<input type="hidden" name="commitedDate"  value="<%=ccd%>">
			<input type="hidden" name="refDocItem"  value="<%=RefDocItem %>">

			<%
			if(chkcount >=2)
			{
				out.println(DatesDisplay);
			}
			else
			{
				out.println(crd);
			}%>

		</Td>
		<Td width="5%" align=center><img src="../../Images/Buttons/<%= ButtonDir%>/atp.gif" style="cursor:hand" onClick="showATP(<%= i %>)"  border="none" valign="center" ></Td>
	    	<%}
		rows=rows+2;
	}%>
	</tr>
<%}
%>
</Table>
</Div>
<input type="hidden" value="1" name="count">
<input type="hidden" value="<%=i%>" name="total">
<input type="hidden" name="reasonForRejection" value="<%=Reason%>">
<%
	//java.math.BigDecimal netValueB = new java.math.BigDecimal(netValue);
	int cop =bPrice.compareTo(new java.math.BigDecimal("10000"));

%>
	<div  id="div5" align="center" style="visibility:visible;position:absolute;top:86%;width:100%">

	<Table align="center" width="100%">
<Tr>
	<Td align="center" class="blankcell" width="100%"><font color="blue"><%=taxDutiAppli_L%></font></Td>
</Tr>
	<Tr>
		<Td  class="blankcell" align="center" width="100%">
			<span id="EzButtonsSpan" style="width:100%"><nobr>
				
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();

	buttonName.add("Back");
	buttonMethod.add("ezListPage(\""+StatusButton+"\")");
%>
	<%@ include file="../../../Includes/JSPs/Sales/iButtons.jsp" %>
<%				
	if(CU||CM)
	{
		buttonName.add("Get Prices");
		buttonMethod.add("formSubmit(\"ezGetPricesEdit.jsp\",\"NO\")");
	}
	if(NEW)
	{
		
		buttonName.add("Delete Lines");
		buttonMethod.add("ezDelSOLines()");
		
	}

	buttonName.add("Remarks");
	buttonMethod.add("nextEdit()");
	out.println(getButtonStr(buttonName,buttonMethod));
%>
		
		</nobr>
	</span>
	
	<span id="EzButtonsMsgSpan" style="display:none">
			<Table align=center>
			<Tr>
				<Td class="labelcell">Your request is being processed. Please wait</Td>
			</Tr>
			</Table>
	</span>
	
</td>
</tr>
</table>
</div>
<!--  *************************************Details of products over ******************** -->

<%
IncoTerms2 = ( (IncoTerms2==null) ||("null".equals(IncoTerms2)) )?"None":IncoTerms2;

/*
ResourceBundle rbInco= ResourceBundle.getBundle("EzIncoTerms");
ResourceBundle rbpay= ResourceBundle.getBundle("EzPaymentTerms");
Enumeration incoEnu =rbInco.getKeys();
Enumeration payEnu =rbpay.getKeys();
*/

%>


<input type="hidden" name="delBlock">
<div id="div2" style="visibility:hidden;position:absolute;left:2%;top:9%;width:98%">
<%--<Table width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
  <tr align="center">
    <th colspan="2"><b><%=tecondweb_L%>:<%= WebOrNo %></b></th>
  </tr>
</Table>
--%>
</div>
<div id="div6" style="overflow:auto;visibility:hidden;position:absolute;top:15%;left:2%;height:70%;width:98%">
<Table align=center  class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="60%">
<tr><th>Remarks</th></tr>
<td>
<textarea cols="90" rows="12" style="overflow:auto;border:0" name="generalNotes1" class=txarea><%=sdHeader.getFieldValueString(0,"TEXT2")%></textarea>
</table>
</div>
<div id="div7" style="visibility:hidden;position:absolute;left:0%;top:89%;width:100%">
<table align="center">
<Tr>
<Td>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	buttonName.add("Back");
	buttonMethod.add("showTabEdit(\"1\")");	
%>
	<%@ include file="../../../Includes/JSPs/Sales/iButtons.jsp" %>
<%
	out.println(getButtonStr(buttonName,buttonMethod));
%>
</Td>
</Tr>
</Table>
</div>
<input type="hidden" name="chkprice" value="1">
<div id="div3"></div>
<div id="div4"></div>
<div id="div5"></div>
<div id="buttonDiv"></div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>

<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"  %>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp" %>
<%@ include file="../../../Includes/JSPs/Lables/iEditSaleswithmod_Lables.jsp" %>
<%@ include file="../../../Includes/JSPs/Lables/iTermsConditions_Lables.jsp"  %>
<%@ page import = "ezc.ezutil.FormatDate,java.util.*" %>
<%@ include file="../../../Includes/JSPs/Lables/iButton_Lables.jsp"%>
<%@ page import ="ezc.ezparam.*,ezc.sales.local.params.*,ezc.client.*" %>
<%@ include file="../../../Includes/JSPs/Sales/iSalesDetails.jsp" %>
<%@ include file="../../../Includes/JSPs/Sales/iGetMaterials.jsp"%>
<%@ include file="../../../Includes/Lib/ezGlobalBean.jsp"%>
<%!
	public String eliminateDecimals(String myStr)
	{
		String remainder = "";
		if(myStr.indexOf(".")!=-1)
		{
			remainder = myStr.substring(myStr.indexOf(".")+1,myStr.length());
			myStr = myStr.substring(0,myStr.indexOf("."));
		}
		return myStr;
	}
%>
<%

	//ezc.ezcommon.EzLog4j log4j = new ezc.ezcommon.EzLog4j();

	// Added by Balu on 8th August 2006 to get case lot. we get from iGetMaterials.jsp
	java.util.Hashtable caseLots = new java.util.Hashtable(); 
	
	try
	{
		for(int i=0;i<retpro.getRowCount();i++)
			caseLots.put(retpro.getFieldValueString(i,"MATNO").trim(),retpro.getFieldValueString(i,"UPC_NO"));
	}catch(Exception e)
	{
	
	}
	// Ends here


	/*
	try
	{
		ezc.eztrans.EzTransactionParams params=new ezc.eztrans.EzTransactionParams();
		params.setSite("100");			//connection group number.
		params.setObject("SALESORDER");		//the table name.
		params.setKey(webOrNo.trim());		//the row which u want to lock
		params.setUserId(Session.getUserId());	//login user id
		params.setId(session.getId());		//http session id
		java.util.Date upToTime=new java.util.Date();
		upToTime.setTime(upToTime.getTime()+ 500000);	//5*60*1000
		params.setUpto(upToTime);		//till the time you want to keep the lock
		params.setOpType("LOCK");		//to keep lock on the particular row.
		ezc.eztrans.EzTransaction trans=new ezc.eztrans.EzTransaction();
		trans.ezTrans(params);
	}catch(ezc.eztrans.EzLockTransException  e)
	{
		response.sendRedirect("ezTransLockError.jsp?webOrNo="+webOrNo+"&exp="+e.getLockedId());
	}
	
	*/
	
	
	Hashtable getPrices = new Hashtable();
	Hashtable getValues = new Hashtable();
	boolean sessionValue= false;

	String frmConfirm  =request.getParameter("confirm");
	
	String backFlg = request.getParameter("backFlg");

	if(session.getAttribute("getPrices")!=null) sessionValue=true;


	log4j.log("222222222::sessionValue"+sessionValue,"W");
	sessionValue = false;
	if(sessionValue)
	{
		getPrices =(Hashtable)session.getAttribute("getPrices");
		getValues =(Hashtable)session.getAttribute("getValues");
		
	}

	log4j.log("getPricesgetPrices::getPrices"+getPrices,"W");
	log4j.log("getValuesgetValues::getValues"+getValues,"W");

	ezc.ezbasicutil.EzCurrencyFormat myFormat = new ezc.ezbasicutil.EzCurrencyFormat();
	String formatkey =(String)session.getValue("formatKey");
	FormatDate fD=new FormatDate();

	String WebOrNo 		= sdHeader.getFieldValueString(0,"WEB_ORNO");
	String incoTerms1 	= sdHeader.getFieldValueString(0,"INCO_TERMS1");
	String Incoterms2 	= sdHeader.getFieldValueString(0,"INCO_TERMS2");
	String payterms 	= sdHeader.getFieldValueString(0,"PAYMENT_TERMS");

	String UserRole 	= (String)session.getValue("UserRole");
	UserRole 		= UserRole.trim();
	String StatusButton 	= sdHeader.getFieldValueString(0,"STATUS").trim();
	String UserLogin 	= Session.getUserId();
	UserLogin 		= UserLogin.trim();
	String ModifiedBy 	= sdHeader.getFieldValueString(0,"MOD_ID");
	ModifiedBy 		= ModifiedBy.trim();
	String CreatedBy 	= sdHeader.getFieldValueString(0,"CREATE_USERID");	
	CreatedBy 		= CreatedBy.trim();
	
	log4j.log("3333333333::CreatedBy"+CreatedBy,"W");

	String DisCash	=sdHeader.getFieldValueString(0,"DISCOUNT_CASH");
	String DisPer 	=sdHeader.getFieldValueString(0,"DISCOUNT_PERCENTAGE");
	String Freight	=sdHeader.getFieldValueString(0,"FREIGHT");

	DisCash	=((DisCash == null)||(DisCash.trim().length()==0)||("null".equals(DisCash)))?"0":DisCash;
	DisPer 	=((DisPer == null)||(DisPer.trim().length()==0)||("null".equals(DisPer)))?"0":DisPer;
	Freight =((Freight == null)||(Freight.trim().length()==0)||("null".equals(Freight)))?"0":Freight;

	String agentName ="";
	int count=1,i=0;

	String SoldTo = sdSoldTo.getFieldValueString(0,"SOLD_TO_CODE");

	boolean CU = false ;if(("CU").equalsIgnoreCase(UserRole)) CU = true;
 	boolean AG = false ;if(("AG").equalsIgnoreCase(UserRole)) AG = true;
	boolean CM = false ;if(("CM").equalsIgnoreCase(UserRole)) CM = true;
	boolean LF = false ;if(("LF").equalsIgnoreCase(UserRole)) LF = true;
	boolean BP = false ;if(("BP").equalsIgnoreCase(UserRole)) BP = true;

	boolean NEW= false ;if(("New").equalsIgnoreCase(StatusButton)) NEW = true;
//******************* end of if to get plant address from properties file
	String ordDate 		= sdHeader.getFieldValueString(0,"ORDER_DATE");
	java.util.Date ord	=(java.util.Date)sdHeader.getFieldValue(0,"ORDER_DATE");
	java.util.Date std	=(java.util.Date)sdHeader.getFieldValue(0,"STATUS_DATE");
	String Reason 		= sdHeader.getFieldValueString(0,"RES2");
	Reason = ( (Reason == null) || ("null".equals(Reason)) )?"":Reason;
	Reason=Reason.replace((char)13,' ');
	Reason=Reason.replace((char)10,' ');
	
	log4j.log("4444444444::Reason"+Reason,"W");
	
%>

<html>
<head>

	<Title>Sales Order Details-- Powered by Answerthink Ind Ltd</Title>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>


	
	
	<script>

	function calValue(obj,prodDesc,val,ProdLine,ind,oldVal)
	{

		var prodlen	= document.generalForm.product.length
		
		if(isNaN(prodlen))
		{
			caseLot 	= document.generalForm.caseLot.value
			reqQty 		= document.generalForm.desiredQty.value
			productDesc 	= document.generalForm.productDesc.value
			
			if((caseLot!=0) && (caseLot!="") && (reqQty!=0) && (reqQty!="")){
				if(parseInt(reqQty) % parseInt(caseLot)!= 0){
					alert("Quantity of "+ productDesc +" is : " +reqQty+"\nSolution :Please enter multiples of "+ caseLot)
					document.generalForm.desiredQty.value='';
					document.generalForm.desiredQty.focus();
					return;
				}
			}
			
			if((reqQty!=0) && (reqQty!="")){
				unitPrice	= document.generalForm.desiredPrice.value
				netValue	= (parseFloat(reqQty) * parseFloat(unitPrice)).toString();
				var subStrLen; 

				if(netValue.indexOf(".")!=-1)
				{
					subStr	 = netValue.substring(netValue.indexOf("."),netValue.length);
					subStrLen= subStr.length;
					if(subStrLen>=4)
						netValue = netValue.substring(0,netValue.indexOf(".")+4);
				}
				document.generalForm.value2.value = netValue;
			}
			else
				document.generalForm.value2.value = '0' 
		}
		else
		{
			caseLot 	= document.generalForm.caseLot[ind].value
			reqQty 		= document.generalForm.desiredQty[ind].value
			productDesc 	= document.generalForm.productDesc[ind].value
			
			if((caseLot!=0) && (caseLot!="") && (reqQty!=0) && (reqQty!="")){
				if(parseInt(reqQty) % parseInt(caseLot)!= 0){
					alert("Quantity of "+ productDesc +" is : " +reqQty+"\nSolution :Please enter multiples of "+ caseLot)
					document.generalForm.desiredQty[ind].value='';
					document.generalForm.desiredQty[ind].focus();
					return;
				}
			}
			
			if((reqQty!=0) && (reqQty!="")){
				unitPrice	= document.generalForm.desiredPrice[ind].value
				netValue	= (parseFloat(reqQty) * parseFloat(unitPrice)).toString();
				var subStrLen; 

				if(netValue.indexOf(".")!=-1)
				{
					subStr	 = netValue.substring(netValue.indexOf("."),netValue.length);
					subStrLen= subStr.length;
					if(subStrLen>=4)
						netValue = netValue.substring(0,netValue.indexOf(".")+4);
				}
				document.generalForm.value2[ind].value = netValue;
			}
			else
				document.generalForm.value2[ind].value = '0';
		}	
		
		//document.generalForm.chkprice.value="0";
	}
	
	function showMsg()
	{
		if(document.all)
		{
			retVal=showModalDialog('ezDea.jsp'," ",'center:yes;dialogWidth:25;dialogHeight:8;status:no;minimize:yes');
			if(retVal=='Y') 
				showSign()
		}
	}
	var retSign='N'
	function showSign()
	{
		if(document.all)
		{
			retSign=showModalDialog('ezSignature.jsp'," ",'center:yes;dialogWidth:35;dialogHeight:15;status:no;minimize:yes');
		}
	}

	function confirmEditOrder(obj1,obj2)
	{
	
		// Added by Balu for Delivery scheduels date
		
		var prodlen	= document.generalForm.product.length
		var reqDate	= document.generalForm.ReqDate.value
		
		if(isNaN(prodlen))		
			document.generalForm.desiredDate.value = reqDate;
		else		
		{
			for(var t=0;t<prodlen;t++)
			{	
				document.generalForm.desiredDate[t].value = reqDate;
			}			
		}
		// Ends Here
	
		var  deaValue	= '<%=(String)session.getValue("DEANUMBER")%>'
		
		var deaFlag	= true
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
			}else
			{
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
	
	var compfoc = new Array()
	var compprice = new Array()
	var compqty = new Array()
	var statusOrder = "<%=StatusButton%>";
	
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
		document.generalForm.orderStatus.value="'"+obj+"'"
		document.generalForm.action="ezSavedOrdersList.jsp"		
		document.generalForm.submit()
	}
	
	function ezSearchListPage()
	{
		var backFlg='<%=backFlg%>'
		if(backFlg=="SUBMITTED")
		{
			document.generalForm.action="ezSubmittedOrdersList.jsp"		
			document.generalForm.submit()
		}
		else
		{
			document.generalForm.action="ezListSalesOrders.jsp"		
			document.generalForm.submit()
		}
	}
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
				else if( isNaN( parseFloat(obj.value)))
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
				else if(isNaN(parseFloat(obj.value)))
				{
					alert("<%=plzEntDisNum_A%>")
 					obj.value="0"
				}
			}	
		}
	}
	function qtyFocus()
	{
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
			var chkbox = document.generalForm.chk.length;
			if(isNaN(chkbox))
			{
				if(document.generalForm.chk.checked)
				{
					alert("There must be atleast one product in sales order");
					return;
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

	function select1()
	{
		for(j=0;j<selSelect.length;j++)
		{	
			alert(selSelect.length)
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
					if(d1 < d2)
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
					if(d1 < d2)
					{
						alert("<%=confDtGtToday_A%>");
						return false;
					}
				}
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
			obj6.style.visibility="hidden"
			obj7.style.visibility="hidden"
			scrollInit();
		}
		else if(tabToShow==2)
		{
			obj1.style.visibility="hidden"
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
	var pleaseenter 		= "<%=plzEnter_A%>"
	var permenantlydelete		= "<%=permaDelLines_A%>"
	var PleaseclickongetPrices	= "<%=plzPriceChanQuant_A%>"
	var SavetheOrderforMod 		= "<%=saveFurModifi_A%>"
	var SavetheOrder		= "<%=saveOrder_A%>"
	var AccepttheOrder		= "<%=accOrdeApproval_A%>"
	var Submittheorder		= "<%=subOrdeApproval_A%>"
	var Approvetheorder		= "<%=approOrder_A%>"
	var Deletetheorder 		= "<%=delOrder_A%>"
	var Rejecttheorder		= "Reject the order"
	var Returntheorder		= "<%=returnOrder_A%>"
	var Posttheorder		= "<%=postOrder_A%>"
	var Accepttheordercu 		= "<%=acceptOrder_A%>"
	var selectShipTo		= "<%=plzSelShipTO_A%>"
	var SelectINCOTerms		= "<%=plzIncoTerms_A%>"
	var SelectPaymentTerms		= "<%= plzSelPTerms_A%>"
	var enterConfirmedPrice		= "<%=plzConfiPrice_A%>"
	var entervalidQuantity		= "<%=plzValidQty_A%>"
	var entervalidConfirmedPrice	= "<%=plzValidCPrice_A%>"
	var FOCcannotbelessthan0	= "<%=focLessZero_A%>"
	var entervalidFOCinNumbers	= "<%=plzFOCNum_A%>"
	var enterFreight		= "<%=plzFreight_A%>"
	var entervalidFreightinNumbers	= "<%=plzValidFrightNum_A%>"
	var Changingthequantitywillgetprices 		= "<%=changeQutConti_A%>"
	var enterQuantitybyclickingonDeliveryDates 	= "<%=plzQutDeliDate_A%>"
	var Quantitycannotbelessthanorequalto0 		= "<%=quanLessEqual_A%>"
	var ConfirmedPricecannotbelessthanorequalto0 	= "<%=confiLessEqual_A%>"
	var Freightcannotbelessthanorequalto0		= "<%=freightLessZero_A%>"
	
</script>	

<script src="../../Library/JavaScript/Sales/ezSalesDetails.js"></script>
<script src="../../Library/JavaScript/Sales/ezSalesValidations.js"></script>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
<script src="../../Library/JavaScript/Misc/ezTrim.js"></script>

<Script>
	  var tabHeadWidth=95
	  var tabHeight="45%"
</Script>
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
</head>
<%
	ReturnObjFromRetrieve delRet=(ReturnObjFromRetrieve) session.getValue("EzDeliveryLines");
	String reqDate = "";
	reqDate = delRet.getFieldValueString(0,"EZDS_REQ_DATE");
	
	
	String reqDateStr = request.getParameter("reqDateStr");
	
	if(reqDateStr!=null && !"null".equals(reqDateStr))
		reqDate	= reqDateStr; 
		
		
	String srType = request.getParameter("srType");		
%>


<body onLoad="scrollInit();select1()" onresize="scrollInit()" scroll=no> 
<form method="post" name="generalForm">

<input type="hidden" name ="urlPage">
<input type="hidden" name ="SearchType" value="<%=request.getParameter("SearchType")%>">
<input type="hidden" name ="searchPatern" value="<%=request.getParameter("searchPatern")%>">
<input type="hidden" name ="sortOn" 	value="<%=request.getParameter("sortOn")%>">
<input type="hidden" name ="sortOrder" 	value="<%=request.getParameter("sortOrder")%>">
<input type="hidden" name ="RefDocType" value="<%=request.getParameter("RefDocType")%>">

<%
	String display_header = "Sales Order Details"; 	
%>
<%@ include file="../../../Sales2/JSPs/Misc/ezDisplayHeader.jsp"%>


<%--orderStatus=<%=orderStatus%>&RefDocType=<%=refDocType%>&SearchType=<%=searchType%>&searchPatern=<%=request.getParameter("searchPatern")%>&sortOn=<%=request.getParameter("sortOn")%>&sortOrder=<%=request.getParameter("sortOrder")--%>


<input type="hidden" name="poNo" 	value="<%=sdHeader.getFieldValueString(0,"PO_NO")%>">
<input type="hidden" name="poDate" 	value="<%=sdHeader.getFieldValueString(0,"RES1")%>">
<input type="hidden" name="newFilter" 	value="<%=request.getParameter("newFilter")%>">
<input type="hidden" name="" 	value="'<%=StatusButton %>'">
<input type="hidden" name="statusDate"  value="<%=fD.getStringFromDate(std,formatkey,FormatDate.MMDDYYYY)%>">
<input type="hidden" name="webOrNo" 	value="<%=WebOrNo%>">
<input type="hidden" name="createdBy"  	value="<%=CreatedBy%>">
<input type="hidden" name="agent" 	value="<%=sdSoldTo.getFieldValueString(0,"AGENT_CODE")%>">
<input type="hidden" name="docType"  	value="<%=sdHeader.getFieldValueString(0,"REF_DOC_TYPE")%>">
<input type="hidden" name="refdoc"  	value="<%=sdHeader.getFieldValueString(0,"REF_DOC_NO")%>">
<input type="hidden" name="srType"      value='<%=srType%>'>
<input type="hidden" name="orderStatus"      value="<%=request.getParameter("ordType")%>">


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
	
	String displayStr = "InputBox",readOnlyStr="",tdWidth="28%";
	if("confirm".equals(frmConfirm))
	{
		displayStr 	= "tx";
		readOnlyStr	= "readonly";
		tdWidth		= "33%";
	}
%>

<div id="div1" style="visibility:visible">
<Table id="table1" width="95%"  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0> 
	<Tr>
	       <th class="labelcell" align="left"><%=weorno_L%>:</th>
	       <td><input type="hidden" name="soNo" value="<%=WebOrNo%>"><%=WebOrNo%></td>
  	       <th class="labelcell" align="left"><%=weordate_L%>:</th>
<%		       	String orddate = sdHeader.getFieldValueString(0,"ORDER_DATE");
		       	if(orddate== null || "null".equals(orddate))
	       			orddate="";
	       	try {
	       		StringTokenizer orddateF=new StringTokenizer(orddate,"-");
	       		String yy	= (String)orddateF.nextElement();
	       		String mm 	= (String)orddateF.nextElement();
	       		String ddTime 	= (String)orddateF.nextElement();
	       		StringTokenizer ddF=new StringTokenizer(ddTime," ");
	       		String dd = (String)ddF.nextElement();
	       		orddate=mm+"/"+dd+"/"+yy;
	       	}catch(Exception e){
	       		System.out.println("Exception Occured in ezEditSales.jsp"+e);
	       	} 
	       	
%>             <td><%=orddate%>               
               <input type="hidden" name="orderDate"	value="<%=ret.getFieldValueString(0,"ORDER_DATE")%>">
	       <input type="hidden" name="createdBy" 	value="<%=CreatedBy%>">
	       <input type="hidden" name="modifiedBy" 	value="<%=ModifiedBy%>">
	       </td>
               <Th class="labelcell" align="left"><%=crby_L%>:</Th>
	       <Td><%=CreatedBy%></Td>
	</Tr>
<%
	 String netValue = ret.getFieldValueString(0,"NET_VALUE");
	 String Currency = sdHeader.getFieldValueString(0,"DOC_CURRENCY");
	 String carrierName      = sdHeader.getFieldValueString(0,"REF1");
	 carrierName = ("null".equals(carrierName)||carrierName==null)?"":carrierName;	

	 
	 
	 
	 
%>
	<Tr>
		<th class="labelcell" align="left"><%=pono_L%>:</th>
        	<td><%=sdHeader.getFieldValueString(0,"PO_NO") %></td>
 	  	<th class="labelcell" align="left"><%=podate_L%>:</th>
<%
		String podate = sdHeader.getFieldValueString(0,"RES1");
		if(podate== null || "null".equals(podate))
			podate=" ";
		try{
			StringTokenizer podateF=new StringTokenizer(podate,".");
			String  forkey=(String)session.getValue("formatKey");
			String dd = (String)podateF.nextElement();
			String mm = (String)podateF.nextElement();
			String yy = (String)podateF.nextElement();
			podate=mm+forkey+dd+forkey+yy;
		}catch(Exception e){}
%>
        	<Td><%=podate%>&nbsp;</Td>
	  	<Th class="labelcell" align="left" >Carrier Name</Th>
		<Td nowrap>
			<!--<%=carrierName%>-->&nbsp;
		</Td>
    	</Tr>
    	<Tr>
      		<th class="labelcell" align="left"><%=soldto_L%>:</th>
		<td title="<%=sdSoldTo.getFieldValueString(0,"SOTO_NAME")%>">
		<input type="hidden" name="soldTo" value="<%= sdSoldTo.getFieldValueString(0,"SOLD_TO_CODE") %>">
<%
		String name = sdSoldTo.getFieldValueString(0,"SOTO_NAME");
		out.println("<input type='hidden' name='soldToName' value='"+name+"'>");
		if(name.length() > 17)
		{
			name = name.substring(0,17)+"..";
		}
		out.println(name);
%>		</Td>
		<th class="labelcell" align="left"><%=shipto_L%>: </th>
		<Td title="<%=sdShipTo.getFieldValueString(0,"SHTO_NAME")%>">
		<input type="hidden" name="shipTo" value="<%=sdShipTo.getFieldValueString(0,"SHIP_TO_CODE")%>">
<%
		name =sdShipTo.getFieldValueString(0,"SHTO_NAME") ;
		out.println("<input type='hidden' name='shipToName' value='"+name+"'>");
		if(name.length() > 17)
		{
			name = name.substring(0,17)+"..";
		}
		out.println(name);
%>
		</Td>
		<Th align='left'>Required Date:</Th>
		<Td><input type="hidden"  name="DatesFlag" value="DATES">
			<%=reqDate%>

		<input type="hidden" name="estNetValue" value="<%=netValue%>">
		<input type="hidden" name="requiredDate" value="">			
	  	<input type="hidden" name="disCash"  value="<%=DisCash%>">
	  	<input type="hidden" name="disPercentage" value="<%=DisPer%>">
	  	<input type="hidden" name="freight" value="<%=Freight%>">
	  	</Td>
	 </Tr>  
</Table>
</Div>
<!--****************************** END OF HEADER **********************************-->

 
	<Div id='theads'>
	<Table width='95%' id='tabHead'  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr>		    
		     <th  colspan="10"><b> <%=podet_L%></b></th>
		</Tr>     
		<Tr>

			<th width="15%">Ordered Part#</th>
			<th width='<%=tdWidth%>'><%=prdesc_L%></th>
			<!--<th width="5%"><%=uom_L%></th>-->
			<th width="14%"><%=quan_L%></th>
			<th width="14%"><%=price_L%> [<%=Currency%>]</th>
			<Th width="14%"><%=value_L%> [<%=Currency%>]</Th>
		</Tr>
 	</Table>
	</div>
	
	<Div id='InnerBox1Div' style='overflow:auto;position:absolute;width:98%;height:60%;left:2%'>
	<Table width='100%' id='InnerBox1Tab'  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<%

	log4j.log("55555555555555","W");
	
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
	
	
	log4j.log("retLinesretLines","W");
	retLines.toEzcString();
	retDeliverySchedules.toEzcString();
	log4j.log("retLinesretLines","W");
	
	
    	for( i=0;i<retLines.getRowCount();i++)
     	{
		String delSchQty	= "";
		String delSchDates	= "";
		String delProdLine	= "";
		String prodNo 		= retLines.getFieldValueString(i,"PROD_CODE");
		String custMat 		= retLines.getFieldValueString(i,"CUST_MAT");
		String prodDesc 	= retLines.getFieldValueString(i,"PROD_DESC");
	        prodDesc 		= prodDesc.replace('\"',' ');
                prodDesc 		= prodDesc.replace('\'',' ');
		String prodPack 	= retLines.getFieldValueString(i,"UOM");
		String ProdLine 	= retLines.getFieldValueString(i,"SO_LINE_NO");
		int chkcount 		= 0;
 		String RefDocItem 	= retLines.getFieldValueString(i,"REF_DOC_ITEM");
		String prodDesiredprice	= "",prodCommitedprice="",prodDesiredQty="",prodCommitedQty="",unitQty="",prodDesiredPriceFormat="",prodCommitedPriceFormat="",foc="";
		java.util.Date rd	=null;
		java.util.Date cd 	= null;
		String crd=null,ccd=null;
		String a = prodNo;
		
		if(custMat!=null && !"null".equals(custMat))
		prodNo = custMat;
		
		String caseLotStr	= (String)caseLots.get(prodNo.trim());
		
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
			System.out.println("Exception Occured while in ezEditSales.jsp while getting Delivery schedule Quantity:"+e);
		}
		String a1= a+"---"+prodDesc;
		
		log4j.log("sessionValuesessionValue::"+sessionValue,"W");
		sessionValue = false;
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
				System.out.println("Exception Occured while in ezEditSales.jsp while using string tokenizer:"+e);
			}
			prodDesiredprice 	= (String)getPrices.get(prodNo);
			prodDesiredprice 	= ((prodDesiredprice==null) || (prodDesiredprice=="") || (("").equals(prodDesiredprice)) || (("null").equals(prodDesiredprice)) )?"0":prodDesiredprice;
			prodCommitedprice 	= prodDesiredprice;
			prodCommitedQty 	= prodDesiredQty;
			ccd=crd;
		}
		else
		{
		
			prodDesiredprice  = retLines.getFieldValueString(i,"DESIRED_PRICE");
			prodCommitedprice = retLines.getFieldValueString(i,"COMMIT_PRICE");
			prodDesiredQty 	  = retLines.getFieldValueString(i,"DESIRED_QTY");
			prodCommitedQty   = retLines.getFieldValueString(i,"COMMITED_QTY");
			
			unitQty 	  = retLines.getFieldValueString(i,"UOM_QTY");
			foc 		  = retLines.getFieldValueString(i,"FOC");
			rd		  = (java.util.Date)retLines.getFieldValue(i,"REQ_DATE");
			cd		  = (java.util.Date)retLines.getFieldValue(i,"PROMISE_FULL_DATE");
			crd 		  = ret1.getFieldValueString(i,"REQ_DATE");
			ccd 		  = ret1.getFieldValueString(i,"PROMISE_FULL_DATE");
			foc		  = (("null".equals(foc))||(foc==null)||(foc.trim().length() ==0))?"0":foc;
		}
		
		log4j.log("prodDesiredpriceprodDesiredprice::"+prodDesiredprice,"W");
		
		java.math.BigDecimal bUprice  = new java.math.BigDecimal(prodDesiredprice);
	        java.math.BigDecimal bUCprice = new java.math.BigDecimal(prodCommitedprice);
	      	bUprice=bUprice.setScale(3,java.math.BigDecimal.ROUND_HALF_UP);
	      	java.math.BigDecimal bQty = new java.math.BigDecimal(prodDesiredQty);
	      	
	      	bPrice = bQty.multiply(bUCprice);
	      	prodDesiredPriceFormat = bUprice.setScale(3,java.math.BigDecimal.ROUND_HALF_UP).toString();//myFormat.getCurrencyString(bUprice.doubleValue());
	      	prodCommitedPriceFormat= bUCprice.setScale(3,java.math.BigDecimal.ROUND_HALF_UP).toString();//myFormat.getCurrencyString(bUCprice.doubleValue());
		prodCommitedprice=prodCommitedPriceFormat;
		String DatesEntry="";
		String DatesDisplay="";
		
		System.out.println("chkcountchkcountchkcount::"+chkcount);	
	
	if(chkcount >=2)
	{
		DatesEntry	= "<a href=\"JavaScript:openNewWindow('ezDatesEntry.jsp?ind="+i+"&matdesc="+prodDesc+"&unitQty="+unitQty+"&itemNo="+ProdLine+"','"+i+"')\">"+multiple_L+"</a>";
		DatesDisplay	= "<a href=\"JavaScript:openNewWindow('ezDatesDisplay.jsp?ind="+i+"&matdesc="+prodDesc+"&unitQty="+unitQty+"&itemNo="+ProdLine+"','"+i+"')\">"+multiple_L+"</a>";
	}else
	{
		DatesEntry	= "<a href=\"JavaScript:openNewWindow('ezDatesEntry.jsp?ind="+i+"&matdesc="+prodDesc+"&unitQty="+unitQty+"&itemNo="+ProdLine+"','"+i+"')\"><Div id=editDateEntry_"+i+">"+crd+"</div></a>";
		DatesDisplay	= "<a href=\"JavaScript:openNewWindow('ezDatesDisplay.jsp?ind="+i+"&matdesc="+prodDesc+"&unitQty="+unitQty+"&itemNo="+ProdLine+"','"+i+"')\"><Div id=editDateDisplay_"+i+">"+crd+"</div></a>";
	}

	%>
	<script>
		compDates[<%=i%>] 	= "<%=ccd.trim()%>";
		compfoc[<%=i%>]		= "<%=foc%>"
		compprice[<%=i%>] 	= "<%=prodCommitedprice%>"
		compqty[<%=i%>] 	= "<%= prodDesiredQty %>"
	</script>

	<tr  valign="middle">

      		<td width="15%" title="<%= a1 %>" alt="<%= a1%>">
			<input type="text" name="prodNo" class="tx" size="15" value="<%=prodNo%>">
			
		</Td>
		<td width='<%=tdWidth%>' title="<%= a1 %>" alt="<%= a1%>">
		<%=prodDesc%>
			
			<input type="hidden" name="productDesc"   value="<%=prodDesc%>">
		</Td>
		<!--<Td width="5%">			
			<%=prodPack%>
		</Td>-->
		<input type="hidden" name="pack" value="<%= prodPack %>">
		<Td width="14%" align="center">
			<%=eliminateDecimals(prodDesiredQty)%>
			<!--[<%=caseLotStr%>]-->
			<input type="hidden" name="focVal"  value="<%=foc%>">
			<input type="hidden" name="caseLot"  value="<%=caseLotStr%>">
		</Td>
		<Td width="14%" align="right"><input type="hidden" name="desiredPrice"  value="<%=prodDesiredprice %>"><%= prodDesiredPriceFormat %></Td>
		<Td width="14%" align="right"><input type="inputbox" class=tx name="value2" size="15" maxlength=10 style="text-align:right" value="<%= myFormat.getCurrencyString(bPrice)%>" readonly>
	      	  <input type="hidden" name="desiredDate" 	value="<%=crd%>">
		  <input type="hidden" name="changeFlag_<%=i%>" value="true">
		  <input type="hidden" name="commitedQty"  	value="<%=prodDesiredQty %>">
		  <input type="hidden" name="commitedPrice"  	value="<%=prodDesiredprice %>">
		  <input type="hidden" name="commitedDate"  	value="<%=crd%>">
		  <input type="hidden" name="unitQty"  		value="<%=unitQty %>">
		  <input type="hidden" name="lineNo" 		value="<%=ProdLine %>">
		  <input type="hidden" name="product" 		value="<%=prodNo %>">
		  <input type="hidden" name="refDocItem"  	value="<%=RefDocItem %>">
		</Td>
		</Tr>
<%	}
%>
</Table>
</Div>

<input type="hidden" value="1" 		 name="count">
<input type="hidden" value="<%=i%>" 	 name="total">
<input type="hidden" value="<%=Reason%>" name="reasonForRejection">
<%
	int cop = bPrice.compareTo(new java.math.BigDecimal("10000"));
%>
	<div  id="div5" align="center" style="visibility:visible;position:absolute;top:86%;width:100%">
	<Table align="center" width="100%">		
		<Tr>
			<Td  class="blankcell" align="center" width="100%">
			<span id="EzButtonsSpan" style="width:100%"><nobr>
<%
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();
			
			
			
					buttonName.add("Back");
					buttonMethod.add("ezSearchListPage()");			
			
			
			
			out.println(getButtonStr(buttonName,buttonMethod));
%>			</nobr>
			</span>
			<span id="EzButtonsMsgSpan" style="display:none">
				<Table align=center>
					<Tr>
						<Td class="labelcell">Your request is being processed. Please wait</Td>
					</Tr>
				</Table>
			</span>
			</Td>
		</Tr>
	</table>
	</div>

<!--*************************************Details of products over ********************-->
<input type="hidden" name="delBlock">

<input type="hidden" name="welcome" value="<%=request.getParameter("welcome")%>">
<input type="hidden" name="chkprice" value="1">
<div id="buttonDiv"></div>
<Div id="MenuSol"></Div>
</form>
</body>
</html>

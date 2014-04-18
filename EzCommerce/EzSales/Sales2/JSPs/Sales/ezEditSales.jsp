<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"  %>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp" %>
<%@ include file="../../../Includes/JSPs/Lables/iEditSaleswithmod_Lables.jsp" %>
<%@ include file="../../../Includes/JSPs/Lables/iTermsConditions_Lables.jsp"  %>
<%@ page import = "ezc.ezutil.FormatDate,java.util.*" %>
<%@ include file="../../../Includes/JSPs/Lables/iButton_Lables.jsp"%>
<%@ page import ="ezc.ezparam.*,ezc.sales.local.params.*,ezc.client.*" %>
<%@ include file="../../../Includes/JSPs/Sales/iEditSalesDetails.jsp" %> 
<%@ include file="../../../Includes/JSPs/Sales/iEditSaveCart.jsp" %>
<%@ include file="../../../Includes/JSPs/Sales/iGetMaterials.jsp"%> 
<%@ include file="../../../Includes/JSPs/Sales/iShippingTypes.jsp" %>
<%@ include file="../../../Includes/Lib/ezGlobalBean.jsp"%>
<%@ include file="../DrillDownCatalog/ezCountryStateList.jsp" %> 
<%@ page import="ezc.sales.material.params.*" %>
<jsp:useBean id="EzcMaterialManager" class="ezc.sales.material.client.EzcMaterialManager" scope="session"></jsp:useBean>

<%! 
	public String eliminateDecimals(String myStr)
	{
		String remainder = "";
		if(myStr.indexOf(".")!=-1)
		{
			remainder 	= myStr.substring(myStr.indexOf(".")+1,myStr.length());
			myStr 		= myStr.substring(0,myStr.indexOf("."));
		}
		return myStr;
	}
%>
<%

	String mesg = request.getParameter("mesg");
	ReturnObjFromRetrieve itemoutTable=(ReturnObjFromRetrieve)session.getValue("ITEMSOUT");
	
	// Added by Balu on 8th August 2006 to get case lot. we get from iGetMaterials.jsp  
	java.util.Hashtable caseLots = new java.util.Hashtable(); 
	try
	{
		for(int i=0;i<retpro.getRowCount();i++)
			caseLots.put(retpro.getFieldValueString(i,"MATNO").trim(),retpro.getFieldValueString(i,"UPC_NO").trim());
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
	
	ezc.client.EzcUtilManager UtilManager = new ezc.client.EzcUtilManager(Session);
	ReturnObjFromRetrieve  listShipTos_ent = (ReturnObjFromRetrieve)UtilManager.getListOfShipTos((String)session.getValue("AgentCode"));
	ReturnObjFromRetrieve  listBillTos_ent = (ReturnObjFromRetrieve)UtilManager.getListOfBillTos((String)session.getValue("AgentCode"));

	
	Hashtable getPrices = new Hashtable();
	Hashtable getValues = new Hashtable();
	boolean sessionValue= false;

         	String frmConfirm  =request.getParameter("confirm");
         	frmConfirm 	= (frmConfirm==null || "null".equals(frmConfirm))?"":frmConfirm;


	if(session.getAttribute("getPrices")!=null && session.getAttribute("getValues")!=null) sessionValue=true;


	if(sessionValue)
	{
		getPrices =(Hashtable)session.getAttribute("getPrices");
		getValues =(Hashtable)session.getAttribute("getValues");  
		
	}
	log4j.log("222222222::sessionValue"+sessionValue,"W");
	log4j.log("23232::getValues"+getValues,"W");
	log4j.log("sdHeadersdHeader::sdHeader"+sdHeader,"W");
	
	
	
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
	String carrierName      = request.getParameter("carrierName");
	
	if(carrierName==null || "null".equals(carrierName))
	{
		carrierName      =  sdHeader.getFieldValueString(0,"REF1");
	}	
	carrierName = ("null".equals(carrierName)||carrierName==null)?"":carrierName;	

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
	
	log4j.log("sdHeadersdHeadersdHeadersdHeader::Reason"+Reason,"W");
	
	String displayStr = "InputBox",readOnlyStr="",tdWidth="20%";
	String shipAddrDisp="tx";
	if("confirm".equals(frmConfirm))
	{
		displayStr 	= "tx";
		readOnlyStr	= "readonly";
		tdWidth		= "25%";
		shipAddrDisp    = "InputBox"; 
	}
	
	String ShipTo_A = sdShipTo.getFieldValueString(0,"SHIP_TO_CODE");
	int rowId = -1;
	if(listShipTos_ent!=null && listShipTos_ent.getRowCount()>0)
	{
		rowId = listShipTos_ent.getRowId("EC_PARTNER_NO",ShipTo_A);

	}
	
	String shipAddr1  	= listShipTos_ent.getFieldValueString(rowId,"ECA_ADDR_1");
	String shipAddress2  	= listShipTos_ent.getFieldValueString(rowId,"ECA_ADDR_2");
	String shipAddr2  	= listShipTos_ent.getFieldValueString(rowId,"ECA_CITY");
	String shipState  	= listShipTos_ent.getFieldValueString(rowId,"ECA_STATE"); 
	String shipCountry  	= listShipTos_ent.getFieldValueString(rowId,"ECA_COUNTRY");
	String shipZip    	= listShipTos_ent.getFieldValueString(rowId,"ECA_PIN");
	
	String tpZone	  = listShipTos_ent.getFieldValueString(rowId,"ECA_TRANSORT_ZONE");
	String jurCode	  = listShipTos_ent.getFieldValueString(rowId,"ECA_JURISDICTION_CODE");
	String shPhone    = listShipTos_ent.getFieldValueString(rowId,"ECA_PHONE");
	String shFax    = listShipTos_ent.getFieldValueString(rowId,"ECA_WEB_ADDR");

	shipAddr1 	= (shipAddr1==null || "null".equals(shipAddr1))?"":shipAddr1;
	shipAddress2 	= (shipAddress2==null || "null".equals(shipAddress2))?"":shipAddress2;// for shipping address2
	shipAddr2 	= (shipAddr2==null || "null".equals(shipAddr2))?"":shipAddr2;// for city
	shipState 	= (shipState==null || "null".equals(shipState))?"":shipState;
	shipCountry 	= (shipCountry==null || "null".equals(shipCountry))?"":shipCountry.trim();
	shipZip 	= (shipZip==null || "null".equals(shipZip))?"":shipZip;
	
	tpZone =(tpZone==null || "null".equals(tpZone))?"":tpZone;
	jurCode =(jurCode==null || "null".equals(jurCode))?"":jurCode;
	shPhone =(shPhone==null || "null".equals(shPhone))?"":shPhone;
	shFax =(shFax==null || "null".equals(shFax))?"":shFax;

	
	String billAddr1  	= listBillTos_ent.getFieldValueString(0,"ECA_ADDR_1");
	String billAddress2  	= listBillTos_ent.getFieldValueString(0,"ECA_ADDR_2");
	String billAddr2  	= listBillTos_ent.getFieldValueString(0,"ECA_CITY");
	String billState  	= listBillTos_ent.getFieldValueString(0,"ECA_STATE");
	String billCountry  	= listBillTos_ent.getFieldValueString(0,"ECA_COUNTRY");
	String billZip   	= listBillTos_ent.getFieldValueString(0,"ECA_PIN");
	
	String billTPZone	  = listBillTos_ent.getFieldValueString(0,"ECA_TRANSORT_ZONE");
	String billJurCode	  = listBillTos_ent.getFieldValueString(0,"ECA_JURISDICTION_CODE");

	if(billTPZone!=null)
	billTPZone = billTPZone.trim();

	if(billJurCode!=null)
	billJurCode = billJurCode.trim(); 

	billAddr1 =(billAddr1==null || "null".equals(billAddr1))?"":billAddr1;
	billAddress2 	= (billAddress2==null || "null".equals(billAddress2))?"":billAddress2;//for address2
	billAddr2 	= (billAddr2==null || "null".equals(billAddr2))?"":billAddr2;//for city
	billState 	= (billState==null || "null".equals(billState))?"":billState;
	billCountry	= (billCountry==null || "null".equals(billCountry))?"":billCountry;
	billZip =(billZip==null || "null".equals(billZip))?"":billZip;

	
	String[] prodNo_A = null;
	String[] mfrNrs = null;
	String[] mfrParts = null;
	String[] lineIDs = null;
	String[] EanUPCs = null;
	
	
	
	ReturnObjFromRetrieve myObj =null;

	Vector atpMat        = new Vector();
	Hashtable atpMatHt   = new Hashtable();
	Hashtable atpMatQty  = new Hashtable();
	Hashtable atpMatDate = new Hashtable();

	int retLinesCount_A = 0;
	
	if(retLines!=null)
		retLinesCount_A = retLines.getRowCount();
		
	

	if(retLinesCount_A>0)
	{
		   prodNo_A   = new String[retLinesCount_A];
		   mfrNrs     = new String[retLinesCount_A];
		   mfrParts   = new String[retLinesCount_A];
		   lineIDs    = new String[retLinesCount_A];
		   EanUPCs    = new String[retLinesCount_A];
		   
		   for(int j=0;j<retLinesCount_A;j++)
		   {
			String prodCode_A     = retLines.getFieldValueString(j,"PROD_CODE");
			String custprodCode_A = retLines.getFieldValueString(j,"CUST_MAT");
			String eanupc         = retLines.getFieldValueString(j,"INCOTERMS2");
			String mfrNr          = retLines.getFieldValueString(j,"INVOICE");
			String ordLine         =retLines.getFieldValueString(j,"SO_LINE_NO"); 
			
						
			if (custprodCode_A!=null && !"null".equals(custprodCode_A) && !"".equals(custprodCode_A))
				prodNo_A[j]= custprodCode_A;
			else
				prodNo_A[j]= prodCode_A;
				
				
			mfrNrs[j] = mfrNr;
			mfrParts[j] = prodNo_A[j];
			lineIDs[j] = ordLine;
			EanUPCs[j] = eanupc;				
			
			
		   }	   
	}
	
	/*try{
		EzcMaterialParams ezMatParams = new EzcMaterialParams();
		EziMaterialParams eiMatParams = new EziMaterialParams();  


		eiMatParams.setMatIds(lineIDs);
		eiMatParams.setMaterialCodes(prodNo_A);
		eiMatParams.setUPCNumbers(EanUPCs);
		eiMatParams.setVendorCodes(mfrNrs);  		
		eiMatParams.setMaterial("");
		eiMatParams.setUnit(""); 

		ezMatParams.setObject(eiMatParams);
		Session.prepareParams(ezMatParams);  


		EzoMaterialParams eoMatParams = (EzoMaterialParams) EzcMaterialManager.getMaterialAvailability(ezMatParams);
		myObj = (ReturnObjFromRetrieve) eoMatParams.getReturn();
		
		

	}catch(Exception e){
	}
	int myObjCount=0;
	String matNo="",status="",availableQty="",leadTime="",tempLeadTime="",cumQty="";
	String linkStr="N";
	String plantT ="";

	Date tempDate = null;

	if(myObj!=null)
		myObjCount = myObj.getRowCount();

	String myMatIDTemp ="";
	for(int k=0;k<myObjCount;k++)
	{
		linkStr="N";
		matNo  = myObj.getFieldValueString(k,"MATERIAL");
		myMatIDTemp = myObj.getFieldValueString(k,"MATID");
		
		try{
		      matNo = Integer.parseInt(matNo)+"";
		}
		catch(Exception E){  }
		plantT              = myObj.getFieldValueString(k,"PLANT");
		status              = myObj.getFieldValueString(k,"STATUS");
		availableQty        = myObj.getFieldValueString(k,"AVAIL_QTY");
		String availDateStr = myObj.getFieldValueString(k,"ENDLEADTME");
		Date availDate      = (Date)myObj.getFieldValue(k,"ENDLEADTME");
		
		if(plantT!=null)
		plantT = plantT.trim();

		if(atpMat.contains(myMatIDTemp))
			linkStr="Y";
		else
			atpMat.addElement(myMatIDTemp);

		if("A".equals(status))
		{
			if("QU".equals(plantT) || "BK".equals(plantT) || "XX".equals(plantT) ) {
				
				if(atpMatQty.containsKey(myMatIDTemp)){
					cumQty =(String)atpMatQty.get(myMatIDTemp);

					try{
						//availableQty = (Double.parseDouble(availableQty)+Double.parseDouble(cumQty))+"";
						availableQty = (new java.math.BigDecimal(availableQty).add(new java.math.BigDecimal(cumQty))).toString();
						atpMatQty.put(myMatIDTemp,availableQty);
					}catch(Exception e){  }
				}else{
					atpMatQty.put(myMatIDTemp,availableQty);
				}
			}
		}
		if("O".equals(status) && availDate!=null)
		{
			if(atpMatDate.containsKey(myMatIDTemp)){
				tempDate =(Date)atpMatDate.get(myMatIDTemp); 

				if(tempDate.compareTo(availDate)<0)
				     atpMatDate.put(myMatIDTemp,availDate);
				else
				     atpMatDate.put(myMatIDTemp,tempDate);
			}
			else 
			     atpMatDate.put(myMatIDTemp,availDate);
		}

		Date atpDate     = (Date)atpMatDate.get(myMatIDTemp);
		String atpDateStr = FormatDate.getStringFromDate(atpDate,formatkey,FormatDate.DDMMYYYY);

		String atpQty    = (String)atpMatQty.get(myMatIDTemp);
		
		
		
		if(atpMatQty.containsKey(myMatIDTemp)){
			status ="A";
		}else if(atpMatDate.containsKey(myMatIDTemp)){
			status ="O";  
		} 

		atpMatHt.put(myMatIDTemp,status+"¥"+atpQty+"¥"+atpDateStr+"¥"+linkStr);  
		
		
	}*/ 
	
	
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
			
			
			if(reqQty == "")
			{
			   alert("Please enter quantity")
			   document.generalForm.desiredQty.focus();
			   return false;
			}
			else 
			{
				if(reqQty < 0)
				{
					alert("quantity can not be less than zero" );
					document.generalForm.desiredQty.value="";
					document.generalForm.desiredQty.focus();
					return false;
				}
				else if(isNaN(reqQty))
				{
					alert("Please enter valid quantity");
					document.generalForm.desiredQty.value="";
					document.generalForm.desiredQty.focus();
					return false;
				}
		       }
			
			/*
			if((caseLot!=0) && (caseLot!="") && (reqQty!=0) && (reqQty!="")){
				if(parseInt(reqQty) % parseInt(caseLot)!= 0){
					alert("Quantity of "+ productDesc +" is : " +reqQty+"\nSolution :Please enter multiples of "+ caseLot)
					document.generalForm.desiredQty.value='';
					document.generalForm.desiredQty.focus();
					return;
				}
			}
			*/
			
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
			
			if(reqQty == "")
			{
			   alert("Please enter quantity")
			   document.generalForm.desiredQty[ind].focus();
			   return false;
			}
			else 
			{
				if(reqQty < 0)
				{
					alert("quantity can not be less than zero" );
					document.generalForm.desiredQty[ind].value='';
					document.generalForm.desiredQty[ind].focus();
					return false;
				}
				else if(isNaN(reqQty))
				{
					alert("Please enter valid quantity");
					document.generalForm.desiredQty[ind].value='';
					document.generalForm.desiredQty[ind].focus();
					return false;
				}
			}
			
			/*
			if((caseLot!=0) && (caseLot!="") && (reqQty!=0) && (reqQty!="")){
				if(parseInt(reqQty) % parseInt(caseLot)!= 0){
					alert("Quantity of "+ productDesc +" is : " +reqQty+"\nSolution :Please enter multiples of "+ caseLot)
					document.generalForm.desiredQty[ind].value='';
					document.generalForm.desiredQty[ind].focus();
					return;
				}
			}
			*/
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
				flag=true
				//showMsg()
			}
		}
		
		if(retSign=='Y' || flag)
		{
		
			
			var cFlag=true;
			var pname="";
			var rCount=<%=cartRows%>;
			
			/*
			if(rCount==1)
			{
				chFlag=eval("document.generalForm.changeFlag_0").value
				alert(chFlag)
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
			*/
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
		var rCount=<%=cartRows%>;
		
		/*
		
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
		*/
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
		document.generalForm.action="ezListSalesOrders.jsp"		
		document.generalForm.submit()
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
					document.location.replace("ezDeleteSales.jsp?chk=" + chkValue+"&SONO=" + sono + "&totalItems="+totalItems+"&netValue="+netValue +"&TotalValue="+totalValue+"&status="+statusOrder+"&sysKey="+sysKey+"&soldTo="+soldTo);
				}	
			}

		}
	}

	var product = new Array(); //to get selected on Load
	var packs = new Array();   //to get selected on Load
	var total = "<%=cartRows%>";
	var totalItems = "<%=retLines.getRowCount()%>";
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
				obj=document.generalForm.ReqDate;
				obj.value=funTrim(obj.value)
				
				if( obj.value == "")
				{
					alert("<%=plzSelReqDt_A%>");
					return false;
				}
				/*else
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
				*/
			}else	
			{
				for(i=0;i<total;i++)
				{
					obj = document.generalForm.ReqDate;
					obj.value=funTrim(obj.value)
					if( obj.value == "")
					{
						alert("<%=plzSelReqDt_A%>");
						return false;
					}
					/*else
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
					*/
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
			obj5.style.visibility="visible";
			obj6.style.visibility="hidden";
			obj7.style.visibility="hidden";
			scrollInit();
		}
		else if(tabToShow==2)
		{
			obj1.style.visibility="hidden";
			obj6.style.visibility="visible";
			obj7.style.visibility="visible";
			obj3.style.visibility="hidden";
			obj4a.style.visibility="hidden";
			obj5.style.visibility="hidden";
		}
	}
	
	var retcount = "<%=retLines.getRowCount()%>"
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
	
		ret = ezAddProducts();
	
	
	
		if(ret!='N')
		{
		
			var prodcnt = 0;
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
	}
	
	function ezAddNewRow(lineCount)
	{
		var myProductsLength	= myProducts.length;
		var atpcount = 0;
		
		if(retcount!=null && retcount!=undefined)
		{
			try
			{
				atpcount = lineCount+parseInt(retcount)
			}
			catch(error)
			{}
		
		}
		var tabObj		= document.getElementById("InnerBox1Tab")
		var rowItems 		= tabObj.getElementsByTagName("tr");
		var rowCountValue 	= rowItems.length;
		
		
		
		var rowId 		= tabObj.insertRow(rowCountValue);
		elementsArray		= new Array();
		rowCount 		= rowCountValue;
		var titleStr 	= "";	
	
		hiddenFields="<input type='hidden' 	name='productDesc'  value=''>";
		hiddenFields+="<input type='hidden' 	name='pack'   	    value=''>";
		hiddenFields+="<input type='hidden' 	name='focVal' 	    value='0'>";
		hiddenFields+="<input type='hidden' 	name='caseLot' 	    value=''>";
		hiddenFields+="<input type='hidden' 	name='product' 	    value='+myProdCode[lineCount]+'>";
		hiddenFields+="<input type='hidden' 	name='desiredDate'  value=''>";
	
		titleStr = myProdCode[lineCount] + "--->" + myProdDesc[lineCount];
		
		elementsArray[0]  ='<input type="checkbox" 				name="chk" value='+myProdCode[lineCount]+'>'
		elementsArray[1]  ='<input type="text" class="tx"  	size=15 	name=prodNo        style="text-align:left" 	readonly	value='+myProdCode[lineCount]+'>'
		elementsArray[2]  ='<input type="text" class="tx"  	size=35 	name=waste         style="text-align:left"  	readonly	value="'+myProdDesc[lineCount]+'">'
		elementsArray[3]  ='<input type="text" class="tx"  	size=5 		name=pack          style="text-align:center"  	readonly	value='+myProdUom[lineCount]+'>'
		elementsArray[4]  ='<input type="text" class=InputBox   size=15		name="desiredQty"  STYLE="text-align:right" 			maxlength="15" tabIndex=\''+rowCount+1+'\'	 onBlur="verifyQty(this,\''+funTrim(myProdUpc[lineCount])+'\',\''+myProdCode[lineCount]+'\')" value="" >&nbsp;['+funTrim(myProdUpc[lineCount])+']'
		elementsArray[5]  ='<input type="text" class="tx"  	size=10 	name=desiredPrice  style="text-align:left" 	readonly	value="">'
		elementsArray[6]  ='<input type="text" class="tx"  	size=10 	name=value2        style="text-align:left"  	readonly	value="">'
		elementsArray[7]  ='<input type="text" class="tx"  	size=10 	name=DatesDisplay  style="text-align:center"  	readonly	value="">'+hiddenFields
		elementsArray[8]  ='<a href="JavaScript:showATP(\''+atpcount+'\')"><img src="../../Images/Buttons/BROWN/atp.gif"  border="none" valign="center" >'

		eleWidth = new Array();
		eleAlign = new Array();

		eleWidth[0]  = "5%";		eleAlign[0] = "center";
		eleWidth[1]  = "13%";		eleAlign[1] = "left";
		eleWidth[2]  = "28%";		eleAlign[2] = "left";
		eleWidth[3]  = "5%";		eleAlign[3] = "left";
		eleWidth[4]  = "13%";		eleAlign[4] = "left";
		eleWidth[5]  = "11%";		eleAlign[5] = "center";
		eleWidth[6]  = "11%";		eleAlign[6] = "left";
		eleWidth[7]  = "12%";		eleAlign[7] = "left";
		eleWidth[8]  = "7%";		eleAlign[8] = "left";
					
		
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
			var url=location.protocol+"//<%=request.getServerName()%>/j2ee/EzCommerce/EzSales/Sales2/JSPs/Sales/ezUpdateCartProducts.jsp?productNo="+code+"&pageFlag=DELETE"+"&date="+new Date();
			//alert("urlurlurl	"+url);
			//document.write(url);
			if(req!=null)
			{
				req.onreadystatechange = Process;
				req.open("GET", url, true);
				req.send(null);
			}
		}
		
		function validateAddress()
		{
			if(document.generalForm.shipToAddress1.value==""){
				alert("Please enter ship to Address");
				document.generalForm.shipToAddress1.focus();
				return false;
			}

			if(document.generalForm.shipToAddress2.value==""){
				alert("Please enter ship to City");
				document.generalForm.shipToAddress2.focus();
				return false;
			}

			if(document.generalForm.shipToState.value==""){
				alert("Please ship to State");
				document.generalForm.shipToState.focus();
				return false;
			}

			if(document.generalForm.shipToZipcode.value==""){
				alert("Please enter Postal Code");
				document.generalForm.shipToZipcode.focus();
				return false;
			}

			return true;

		}
		function selectState()
		{
			var sel = document.generalForm.shipToCountry.value;
			//alert(sel)
			var stateInputObj  = document.generalForm.shipToState;
			stateInputObj.value="";

			if(sel=="US")
			{
			    document.getElementById("ListBoxDiv1").style.display="block";
			    document.getElementById("stateId").style.display="None";
			}
			else
			{
			    document.getElementById("stateId").style.display="block";
			    document.getElementById("ListBoxDiv1").style.display="None";
			}		
				
		}
		function funSelState()
		 {
			var sel = '<%=shipCountry%>'
			var confirm = '<%=frmConfirm%>';
			if(confirm=="confirm")
			{
				if(sel=="US")
				{
				    document.getElementById("ListBoxDiv1").style.display="block";
				    document.getElementById("stateId").style.display="None";
				}
				else
				{
				    document.getElementById("stateId").style.display="block";
				    document.getElementById("ListBoxDiv1").style.display="None";
				}
			}		   
		 }
		function changeShipAdrs(status)
		{
			var addr1_js = document.generalForm.shipToAddress1.value;
			var city_js  = document.generalForm.shipToAddress2.value
			var state_js = document.generalForm.shipToState.value 	
			var pcode_js = document.generalForm.shipToZipcode.value 

			var arrangedValue = addr1_js+"¥"+city_js+"¥"+state_js+"¥"+pcode_js;


			respArray = new Array();
			var retVal = showModalDialog("ezChangeShipAddress.jsp?status="+status,arrangedValue,"center:yes;dialogWidth:40;dialogHeight:15;status:no;minimize:yes;help:no");
			if(retVal=='') return;
			else
			{
				respArray = retVal.split("¥");
				document.generalForm.shipToAddress1.value = respArray[0]
				document.generalForm.shipToAddress2.value = respArray[1]
				document.generalForm.shipToState.value = respArray[2]
				document.generalForm.shipToZipcode.value = respArray[3] 
			}

		}


	     function showATP(ind)
	     {

		obj=document.generalForm;

		x =obj.productDesc.length

		if(isNaN(x))
		{
			schdate = obj.desiredDate
			schqty = obj.commitedQty

		}else{

			schdate = obj.desiredDate[ind]
			schqty = obj.commitedQty[ind]

		}

		prodCode = ""
		prodDesc =""
		reqDate =""
		reqQty =""
		uom=""
		plant=""
		custprodCode=""

		if (obj.product[ind]!=null)
		{
			prodCode = obj.prodNo[ind].value
			prodDesc =obj.productDesc[ind].value
			reqDate =schdate.value
			reqQty =schqty.value
			uom=obj.pack[ind].value
			plant=obj.plant[ind].value
			custprodCode =obj.custATPMat[ind].value
		}
		else
		{
			prodCode = obj.prodNo.value
			prodDesc =obj.productDesc.value
			reqDate =schdate.value
			reqQty =schqty.value
			uom=obj.pack.value
			plant=obj.plant.value
			custprodCode =obj.custATPMat.value
		}
		myurl ="ezGetATP.jsp?ProductCode="+prodCode+"&ProdDesc="+prodDesc+"&ReqDate="+reqDate+"&ReqQty="+reqQty+"&UOM="+uom+"&plant="+plant	
		retVal=window.open(myurl,"ATP","modal=yes,resizable=no,left=200,top=200,height=200,width=500,status=no,toolbar=no,menubar=no,location=no")

	}
	
	function showATPDetails(prodCode,prdDesc,vcode,matId,upc)
	{
		prodCode = prodCode.replace('#','@@@');  
		myurl ="../Sales/ezGetATPDetails.jsp?matId="+matId+"&vendCode="+vcode+"&upc="+upc+"&ProductCode="+prodCode+"&prdDesc="+prdDesc
		
		retVal=window.open(myurl,"ATP","modal=yes,resizable=no,left=200,top=200,height=400,width=500,status=no,toolbar=no,menubar=no,location=no")
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
	  var tabHeight="25%"
</Script>
<Script>
	var serverName = "<%=request.getServerName()%>";
	top.menu.document.msnForm.cartHolder.value = "<%=cartItems%>"; 
</Script>
<Script src="../../Library/JavaScript/Sales/ezCarrierAjax.js"></Script>
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script> 
<Script src="../../Library/JavaScript/ezChkATPFromEdit.js"></Script>


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


<body onLoad="scrollInit();funSelState();select1();" onresize="scrollInit()" scroll=auto> 
<form method="post" name="generalForm">

<input type="hidden" name ="urlPage">
<input type="hidden" name ="newFilter"	value="<%=request.getParameter("newFilter")%>">
<input type="hidden" name ="SearchType" value="<%=request.getParameter("SearchType")%>">
<input type="hidden" name ="searchPatern" value="<%=request.getParameter("searchPatern")%>">
<input type="hidden" name ="sortOn" 	value="<%=request.getParameter("sortOn")%>">
<input type="hidden" name ="sortOrder" 	value="<%=request.getParameter("sortOrder")%>">
<input type="hidden" name ="RefDocType" value="<%=request.getParameter("RefDocType")%>">
<input type="hidden" name="returnValue" 	value=''>
<input type="hidden" name="frmConfirm" 	value='<%=frmConfirm%>'> 



<%--orderStatus=<%=orderStatus%>&RefDocType=<%=refDocType%>&SearchType=<%=searchType%>&searchPatern=<%=request.getParameter("searchPatern")%>&sortOn=<%=request.getParameter("sortOn")%>&sortOrder=<%=request.getParameter("sortOrder")--%>
<%
	String display_header = "Edit Sales Order";
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>


<input type="hidden" name="poNo" 	value="<%=sdHeader.getFieldValueString(0,"PO_NO")%>">
<input type="hidden" name="poDate" 	value="<%=sdHeader.getFieldValueString(0,"RES1")%>">
<input type="hidden" name="newFilter" 	value="<%=request.getParameter("newFilter")%>">
<input type="hidden" name="status" 	value="<%=StatusButton %>">
<input type="hidden" name="statusDate"  value="<%=fD.getStringFromDate(std,formatkey,FormatDate.MMDDYYYY)%>">
<input type="hidden" name="webOrNo" 	value="<%=WebOrNo%>">
<input type="hidden" name="createdBy"  	value="<%=CreatedBy%>">
<input type="hidden" name="agent" 	value="<%=sdSoldTo.getFieldValueString(0,"AGENT_CODE")%>">
<input type="hidden" name="docType"  	value="<%=sdHeader.getFieldValueString(0,"REF_DOC_TYPE")%>">
<input type="hidden" name="refdoc"  	value="<%=sdHeader.getFieldValueString(0,"REF_DOC_NO")%>">
<input type="hidden" name="srType"      value='<%=srType%>'>
<input type="hidden" name="orderStatus"      value='<%=request.getParameter("ordType")%>'>


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
<Table id="table1" width="95%"  align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=3 cellSpacing=0> 
	<Tr>
	       <th class="labelcell" align="left" width="10%"><%=weorno_L%></th>
	       <td width="10%"><input type="hidden" name="soNo" value="<%=WebOrNo.trim()%>"><%=WebOrNo.trim()%></td>
  	       <th class="labelcell" align="left" width="10%"><%=weordate_L%></th>
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
	       		log4j.log("Exception Occured in ezEditSales.jsp"+e,"W");
	       	} 
	       	
%>             <td width="10%"><%=orddate%>               
               <input type="hidden" name="orderDate"	value="<%=ret.getFieldValueString(0,"ORDER_DATE")%>">
	       <input type="hidden" name="createdBy" 	value="<%=CreatedBy%>">
	       <input type="hidden" name="modifiedBy" 	value="<%=ModifiedBy%>">
	       </td>
               <Th class="labelcell" align="left" width="10%"><%=crby_L%></Th>
	       <Td width="10%"><%=CreatedBy%></Td>
	       <Th align='left' width="10%">ShippingType</Th> 
		<%
			String shippingTypeDesc = (String)ezShippingTypes.get(sdHeader.getFieldValueString(0,"REF1"));
			if(shippingTypeDesc==null || "null".equals(shippingTypeDesc))
				shippingTypeDesc = "&nbsp";

		%>
	       <Td width="10%"><%=shippingTypeDesc%>
	       <input type='hidden' name='carrierName' value='<%=carrierName%>'>

		</Td>

	</Tr>
<%
//sdHeader.toEzcString();
	 String netValue = ret.getFieldValueString(0,"NET_VALUE");
	 String Currency = sdHeader.getFieldValueString(0,"DOC_CURRENCY");
%>
	<Tr>
		<th class="labelcell" align="left"><%=pono_L%></th>
        	<td><%=sdHeader.getFieldValueString(0,"PO_NO") %></td>
 	  	<th class="labelcell"  colspan=2><%=podate_L%></th>
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
        	<Th  colspan=2>Req.Deliv.Date</Th>
				<Td><input type="hidden"  name="DatesFlag" value="DATES">
			<input type=text name="ReqDate" class=InputBox value="<%=reqDate%>"  size=12 maxlength="10" readonly><%=getDateImageFromToday("ReqDate")%>
		</Td>	
	  	
	  	<input type="hidden" name="docCurrency" value="<%=Currency%>">
	  	
    	</Tr>
    	<Tr>
      		<th class="labelcell"  colspan = 4 align="left"><%=soldto_L%> Address
      		<input type="hidden" name="soldTo" value="<%= sdSoldTo.getFieldValueString(0,"SOLD_TO_CODE") %>">
<%
		String soldToName = sdSoldTo.getFieldValueString(0,"SOTO_NAME");
		out.println("<input type='hidden' name='soldToName' value='"+soldToName+"'>");
		/*if(name.length() > 17)
		{
			name = name.substring(0,17)+"..";
		}*/
		//out.println(name);
%>
      		</th>
		
		<th class="labelcell"  colspan = 4 align="left"><%=shipto_L%> Address
		<input type="hidden" name="shipTo" value="<%=sdShipTo.getFieldValueString(0,"SHIP_TO_CODE")%>">
<%
		String shipToName =sdShipTo.getFieldValueString(0,"SHTO_NAME") ;
		out.println("<input type='hidden' name='shipToName' value='"+shipToName+"'>");
		/*if(name.length() > 17)
		{
			name = name.substring(0,17)+"..";
		}*/
		//out.println(name);
%>
		</th>	
		<input type="hidden" name="estNetValue" value="<%=netValue%>">
		<input type="hidden" name="requiredDate" value="">			
		<input type="hidden" name="disCash"  value="<%=DisCash%>">
		<input type="hidden" name="disPercentage" value="<%=DisPer%>">
		<input type="hidden" name="freight" value="<%=Freight%>">

       </Tr> 
       <Tr>
				
		<Td align=right>Name:</Td>
		<td colspan=2><%=soldToName%></Td>
		<Td align=right>Name:</Td>
		<Td colspan = 2 ><%=shipToName%></Td>
		<Td align=right>Attn.:</Td>
		<Td >
		<input type="text"  class='<%=shipAddrDisp%>' name="shAttn"  maxlength="40" value=''>
	        </Td>

       </Tr>
       <Tr>
		<Td align=right>Address1:</Td>
		<td colspan = 2><%=billAddr1%></Td>
		<Td align=right>Address1*:</Td>
		<Td colspan = 2 >
		<input type="text"  class='<%=shipAddrDisp%>' name="shipToAddress1"  maxlength="60" value='<%=shipAddr1%>'>
		</Td>
		<Td align=right>Tel# 1</Td>
		<Td >
		<input type="text"  class='<%=shipAddrDisp%>' name="telNumber"  maxlength="16" value='<%=shPhone%>'>
	        </Td>

       </Tr>
       <Tr>
		<Td align=right>Address2:</Td>
		<td colspan=2><%=billAddress2%></Td>
		<Td align=right>Address2*:</Td>
		<Td  colspan=2>
		<input type="text"  class='<%=shipAddrDisp%>' name="shipToAddr2"  maxlength="60" value='<%=shipAddress2%>'>
		</Td>
		<Td align=right>Tel# 2</Td>
		<Td >
		<input type="text"  class='<%=shipAddrDisp%>' name="mobileNumber"  maxlength="16" value=''>
		</Td>
	</Tr>
       <Tr>
		<Td align=right>City:</Td>
		<td colspan = 2><%=billAddr2%></Td>
		 <Td align=right>City*:</Td>
		 <Td colspan = 2 >
			<input type="text"  class='<%=shipAddrDisp%>' name="shipToAddress2" maxlength="40" value='<%=shipAddr2%>'>
		 </Td>
		 <Td align=right>Fax #</Td>
		<Td >
		<input type="text"  class='<%=shipAddrDisp%>' name="faxNumber"  maxlength="16" value='<%=shFax%>'>
		</Td>

       </Tr>
       <Tr>
		<Td align=right>State:</Td>
		<td colspan = 2><%=billState%></Td>
		 <Td align=right>State*:</Td>
		 <Td colspan = 4 >
<%

    if("confirm".equals(frmConfirm))
    {
%>
		<select name="shipToState" class='<%=shipAddrDisp%>'  id ="ListBoxDiv1" style="width:25%">

<%
		Enumeration enum1S =  ezStates.keys();
		String enum1Key=null;
		String enum1Desc=null;

		while(enum1S.hasMoreElements())
		{
			enum1Key = (String)enum1S.nextElement();
			enum1Desc = (String)ezStates.get(enum1Key);
			if(enum1Key.equals(shipState))
			{
%>
			<option value="<%=enum1Key%>" selected><%=enum1Desc%>(<%=enum1Key%>)</Option>
<%
			}
			else
			{
%>
			<option value="<%=enum1Key%>"><%=enum1Desc%>(<%=enum1Key%>)</Option>
<%
			}
		}
%>				
		</select>
		<input type="text" id="stateId" class="inputbox" style="display:none" name="shipToState" size=25 >

<%
    }else{
%>
		<input type="text"  class='<%=shipAddrDisp%>'  size='26' name="shipToState" 	value='<%=shipState%>'>
<%
    }
%>
		 </Td>
		 
		<!-- <Td align=right>Fax #</Td> 
		<Td >
			<input type="text"  class='<%=shipAddrDisp%>' name="faxNumber"  maxlength="16" value='<%=shFax%>'>
		</Td> -->

       </Tr>
       <Tr>
		 <Td align=right>Country:</Td>
		<td colspan=2>
		<%=billCountry%>
		</Td>
		 <Td align=right>Country:</Td>
		<Td  colspan=4>
<%

		if("confirm".equals(frmConfirm))
		{
%>
			<select name="shipToCountry" class='<%=shipAddrDisp%>' onChange="selectState()" style="width:25%" value="<%=shipCountry%>">
<%

			Enumeration enum2S =  ezCountry.keys();
			String enum2Key=null;
			String enum2Desc=null;

			while(enum2S.hasMoreElements())
			{
				enum2Key = (String)enum2S.nextElement();
				enum2Desc = (String)ezCountry.get(enum2Key);
				if(enum2Key.equals(shipCountry))
				{

%>					<option value="<%=enum2Key%>" selected><%=enum2Desc%></Option>
<%	                        }
				else
				{
%>					<option value="<%=enum2Key%>"><%=enum2Desc%></Option>
<%		 		}
			}
%>
		 </select>
<%
    }else{
%>
		<input type="text"  class='<%=shipAddrDisp%>'  size='30' name="shipToCountry" 	value='<%=shipCountry%>'>
<%
    }
%>
	 </td>	
             
      </Tr>
       <Tr>
		<Td align=right>Postal Code:</Td>
		<td colspan = 2>
		<%=billZip%>
			<input type ="hidden" name="billTPZone" value="<%=billTPZone%>">
			<input type ="hidden" name="billJurCode" value="<%=billJurCode%>"> 
		</Td>
		<Td align=right>Postal Code*:</Td>
		<Td colspan = 4 >
			<input type="text" class='<%=shipAddrDisp%>' size = '10' name="shipToZipcode"   maxlength="10" value='<%=shipZip%>'>
		</Td>

       </Tr>

</Table>
</Div>
<!--****************************** END OF HEADER **********************************-->

 
	<Div id='theads'>
	<Table width='95%' id='tabHead'  align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
		<Tr>		    
		     <th  colspan="10"><b> <%=podet_L%></b></th>
		</Tr>     
		<Tr>
<%
		if(!"confirm".equals(frmConfirm))
		{	
%>
			<th width="5%">&nbsp;</th>
<%
		}
%>
			<th width="13%">Product Code</th>
			<th width='<%=tdWidth%>'><%=prdesc_L%></th>
			<th width="5%"><%=uom_L%></th>
			<th width="10%">List Price[USD]</th>
			<th width="10%"><%=quan_L%></th>
			<th width="10%"><%=price_L%> [<%=Currency%>]</th>
			<Th width="10%"><%=value_L%> [<%=Currency%>]</Th>
			<th width="8%"><%=delDate_L%></th>
			<!--<Th width="9%" valign="top">ATP</Th>-->
		</Tr>
 	</Table>
	</div>

	
	<Div id='InnerBox1Div' style='overflow:auto;position:absolute;width:98%;left:2%'>
	<Table width='100%' id='InnerBox1Tab'  align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
	<%	
		 if(mesg!=null && !"null".equals(mesg) && !"".equals(mesg.trim())){
	%>     
			<Tr colspan=9  align="center">
				<Td align="center" class="blankcell" width="100%"><font color="red">Error:<b><%=mesg%></b> </font></Td>
			</Tr>
	<%
			
		}
	%>	
<%

	log4j.log("55555555555555","W");  
	
     	int rows=1;
     	int chkCnt=-1;
     	int expCnt=0;

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
	if(mesg==null || "null".equals(mesg) || "".equals(mesg.trim())){
	for( i=0;i<retLines.getRowCount();i++)
        {
		String delSchQty	= "";
		String delSchDates	= "";
		String delProdLine	= "";
		String custMatNo        = "";
		String productNo        = "";
		String prodNo 		= retLines.getFieldValueString(i,"PROD_CODE");
		String custMat          = retLines.getFieldValueString(i,"CUST_MAT");
		String venCatalogNo 	= retLines.getFieldValueString(i,"VENDOR_CATALOG");
		
		String eanupc         = retLines.getFieldValueString(i,"INCOTERMS2");
		String mfrNr          = retLines.getFieldValueString(i,"INVOICE");
		String soLine	      = retLines.getFieldValueString(i,"SO_LINE_NO"); 
		String itemListPrice    = "";
		String atpDispStr  ="";
		String atpStatus   ="";
		String atpQty      ="";
		String atpLeadTime ="";
		String atpLinkStatus ="";
		
		
		
		
		
		String myMatId = (String)myLineID.get(soLine);

		
		
                CartRow cartRow[]       = new CartRow[1];
		
		String cartMat          = "";
		String cartMatId          = "";
		boolean cartFlg= false;
		
		if(custMat!=null && !"null".equals(custMat))
		{
			custMat = custMat.trim();
			productNo=prodNo;
			custMatNo=custMat;
		}
		else
		{
		        productNo=prodNo;
		        custMatNo=prodNo;  
		}
		
		if(myMatId!=null){
			cartRow[0]=Cart.getCartRow(myMatId,custMatNo,venCatalogNo); 
		}
		
		if(cartRow[0]!=null)
		{
		    cartMat = cartRow[0].getMaterialNumber(); 
		    itemListPrice = cartRow[0].getUnitPrice();
		    cartMatId    = cartRow[0].getMatId();
		}
		
		
		
				
	        if(Cart!=null &&myMatId!=null&&myMatId.equals(cartMatId)){ 
			cartFlg =true;
	        }else{
	     	  	cartFlg =false;   
	        }
	        
	        	        
	        if(itemListPrice==null || "null".equals(itemListPrice) || "".equals(itemListPrice))
	        	itemListPrice ="0";
	        
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
		//String a = custMatNo; 

		log4j.log("5555555555555511111111111111111111111"+retDeliverySchedules,"W");  
		log4j.log("ProdLineProdLineProdLine"+ProdLine,"W");  
		
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
		log4j.log("getPricesgetPricesgetPrices::"+getPrices,"W");
		log4j.log("getPricesgetPricesgetPrices::"+myMatId,"W");
		
                
                if(sessionValue && !(getPrices.containsKey(myMatId)))
                	continue;

		log4j.log("sessionValuesessionValue::"+sessionValue,"W");

		if(sessionValue)
		{
			log4j.log("sessionValuesessionValue::"+custMatNo,"W");
			log4j.log("sessionValuesessionValue::"+(String)getValues.get(myMatId),"W");
			StringTokenizer stpro = new StringTokenizer((String)getValues.get(myMatId),","); 
			String qty="";
			String date="";
			try{
				prodDesiredQty = stpro.nextToken(); 
				crd=stpro.nextToken();
				foc=stpro.nextToken();
			}catch(Exception e)
			{
				log4j.log("Exception Occured while in ezEditSales.jsp while using string tokenizer:"+e,"W");
			}
			prodDesiredprice 	= (String)getPrices.get(myMatId);
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
		java.math.BigDecimal bUItemListprice = new java.math.BigDecimal(itemListPrice);
		
		
		bUprice=bUprice.setScale(2,java.math.BigDecimal.ROUND_HALF_UP);
		java.math.BigDecimal bQty = new java.math.BigDecimal(prodDesiredQty);

                bPrice = bQty.multiply(bUCprice);
			
		prodDesiredPriceFormat = bUprice.setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();//myFormat.getCurrencyString(bUprice.doubleValue());
		prodCommitedPriceFormat= bUCprice.setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();//myFormat.getCurrencyString(bUCprice.doubleValue());
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

<%
    
  if(cartFlg){
                chkCnt++;
%>

    <tr  valign="middle"> 
    <%
	 if(!"confirm".equals(frmConfirm) ) 
	 {  
    %>
	         <td width="5%" align=center><input type=checkbox name="chk" value="<%=ProdLine%>"></td>
    <%     
	 }
	 else{
    %>
		<input type='hidden' name="chk" value="<%=ProdLine%>">
    <%
	 }
    %>
		<td width="13%" title="<%= a1 %>" alt="<%= a1%>">
		<input type="text" name="prodNo" class="tx" size="15" value="<%=custMatNo%>">
		</Td>
		<td width='<%=tdWidth%>' title="<%= a1 %>" alt="<%= a1%>">
			<input type="text" name="waste" class="tx" size="30" value="<%=prodDesc%>">
			<input type="hidden" name="productDesc"   value="<%=prodDesc%>"> 
		</Td>
		<Td width="5%" align="center">			
			<input type="hidden" name="pack" value="<%= prodPack %>"><%=prodPack%>
		</Td>
		<Td width="10%" align="right">			
			<input type="hidden" name="listPrice" value="<%=itemListPrice %>"><%=itemListPrice%> 
		</Td>
		
		<Td width="10%" align="left">
			<input type="text" size=5 STYLE="text-align: right" class='<%=displayStr%>'  name="desiredQty" onBlur="calValue(this,'<%=prodDesc %>','<%= unitQty %>','<%=ProdLine%>','<%=chkCnt%>','<%= prodDesiredQty %>')" value="<%=eliminateDecimals(prodDesiredQty)%>" <%=readOnlyStr%>>
			<!--[<%=caseLotStr%>]-->
			<input type="hidden" name="focVal"  value="<%=foc%>">
			<input type="hidden" name="caseLot"  value="<%=caseLotStr%>">      
		</Td>
		<Td width="10%" align="right"><input type="hidden" name="desiredPrice"  value="<%=prodDesiredprice %>"><%= prodDesiredPriceFormat %></Td>
		<Td width="10%" align="right"><input type="inputbox" STYLE="text-align:right" class=tx name="value2" size="10" maxlength=10 value="<%= myFormat.getCurrencyString(bPrice)%>" readonly>
		</Td>		
		<Td width="8%" align="center" nowrap>
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
			}
		%>
		</Td>

		<!--<Td width="9%" align="center">
			<a href="JavaScript:showATP(<%= chkCnt %>)"><img src="../../Images/Buttons/BROWN/atp.gif" <%=statusbar%>  border="none" valign="center" ></a>-->
<%

			/*if(atpMatHt!=null){
			        
				String atpMatStr   = (String)atpMatHt.get(soLine);  
				try{
					StringTokenizer st = new StringTokenizer(atpMatStr,"¥");
					atpStatus      	   = (String)st.nextElement();
					atpQty             = (String)st.nextElement();
					atpLeadTime        = (String)st.nextElement();
					atpLinkStatus      = (String)st.nextElement();

				}catch(Exception e){ }
			}  
			
			atpQty=(atpQty==null || "null".equals(atpQty))?"":atpQty; 
			atpLeadTime=(atpLeadTime==null || "null".equals(atpLeadTime))?"":atpLeadTime;
			
			if("S".equals(atpStatus)){
				atpDispStr = "Special";  
			}else if("A".equals(atpStatus)){
				atpDispStr = "In stock<br>"+atpQty;        
			}else if("O".equals(atpStatus) && !"".equals(atpLeadTime)){
				atpDispStr = "Call for<br>Availability Date";
				//atpDispStr = "Available&nbsp;<br>On<br>"+atpLeadTime;                       
			}else {
				atpDispStr ="Out of stock";   
			}	

			if("N".equals(atpLinkStatus))
				out.println(atpDispStr);
			else{
				out.println(atpDispStr);*/
				
				
				

%>
			<!--<a href="JavaScript:showATPDetails('<%//=custMatNo%>','<%//=prodDesc%>','<%//=mfrNr%>','<%//=soLine%>','<%//=eanupc%>')"> ATP</a>-->
		 	

<%
			//}
%>
			
		<!--</Td>-->
		<input type="hidden" name="desiredDate" 	value="<%=crd%>">
		<input type="hidden" name="changeFlag_<%=chkCnt%>" value="true">
		<input type="hidden" name="commitedQty"  	value="<%=prodDesiredQty %>">
		<input type="hidden" name="commitedPrice"  	value="<%=prodDesiredprice %>">
		<input type="hidden" name="commitedDate"  	value="<%=crd%>">
		<input type="hidden" name="unitQty"  		value="<%=unitQty %>">
		<input type="hidden" name="lineNo" 		value="<%=ProdLine %>">
		<input type="hidden" name="product" 		value="<%=productNo %>">
		<input type="hidden" name="custprodCode"        value="<%=custMatNo%>">
		<input type="hidden" name="custATPMat" value="<%= custMat%>">
		<input type="hidden" name="itemListPrice"        value="<%=itemListPrice%>">
		<input type="hidden" name="venCatalogNo"        value="<%=venCatalogNo%>">
		<input type="hidden" name="mfrNr"               value="<%=mfrNr%>">
		<input type="hidden" name="EanUPC"              value="<%=eanupc%>">
		<input type="hidden" name="matId"               value="<%=myMatId%>">
		<input type="hidden" name="refDocItem"  	value="<%=RefDocItem %>">
		<input type="hidden" name="plant" 		value="BP01">
		<input type="hidden" name="index" 		value="<%=i%>"> 
		</Tr>
<%
   }else{
            expCnt++;
%>
	<tr  valign="middle" bgcolor="red">
	<%
	 if(!"confirm".equals(frmConfirm) )
	 {
	%>
		
		<td width="5%" align=center class=InvalidMaterial><input type=checkbox name="chk" value="<%=ProdLine%>" ></td>
	<%   
	 }
	 
	 %>
			<td width="13%" title="<%= a1 %>" alt="<%= a1%>" class=InvalidMaterial>
			<%=custMatNo%>


		</Td>
		<td width='<%=tdWidth%>' title="<%= a1 %>" alt="<%= a1%>" class=InvalidMaterial>
			<%=prodDesc%>
			
		</Td>
		<Td width="5%" align="center" class=InvalidMaterial>			
		<%=prodPack%>	
		</Td>
		<Td width="10%" align="right" class=InvalidMaterial>			
		<%=itemListPrice%>	
		</Td>

		<Td width="10%" align="right" class=InvalidMaterial>
			<%=eliminateDecimals(prodDesiredQty)%>
		</Td>
		<Td width="10%" align="right" class=InvalidMaterial>
		
		<%= prodDesiredPriceFormat %></Td>
		<Td width="10%" align="right" class=InvalidMaterial>
		<%= myFormat.getCurrencyString(bPrice)%>
		<input type="hidden" STYLE="text-align:right" name="value2"  value="<%= myFormat.getCurrencyString(bPrice)%>" readonly>
		
		</Td>		
		<Td width="8%" align="center"  class=InvalidMaterial>
		<%
			if(chkcount >=2)
			{
				out.println(DatesDisplay);
			}
			else
			{
				out.println(crd);
			}
		%>
		</Td>

		<!--<Td width="9%" align="center" class=InvalidMaterial>
		
			<a href="JavaScript:showATP(<%= i %>)"><img src="../../Images/Buttons/BROWN/atp.gif" <%=statusbar%>  border="none" valign="center" ></a>-->
		<%

			/*if(atpMatHt!=null){
				
				String atpMatStr   = (String)atpMatHt.get(soLine);    
				try{
					StringTokenizer st = new StringTokenizer(atpMatStr,"¥");
					atpStatus      	   = (String)st.nextElement();
					atpQty             = (String)st.nextElement();
					atpLeadTime        = (String)st.nextElement();
					atpLinkStatus      = (String)st.nextElement();

				}catch(Exception e){ }
			}  
			atpQty=(atpQty==null || "null".equals(atpQty))?"":atpQty; 
			atpLeadTime=(atpLeadTime==null || "null".equals(atpLeadTime))?"":atpLeadTime;

			if("S".equals(atpStatus))
				atpDispStr = "Special";  
			else if("A".equals(atpStatus))
				atpDispStr = "In stock<br>"+atpQty;        
			else if("O".equals(atpStatus) && !"".equals(atpLeadTime))
				atpDispStr = "Available&nbsp;<br>On<br>"+atpLeadTime;                       
			else 
				atpDispStr ="Out of stock";    

			if("N".equals(atpLinkStatus))
				out.println(atpDispStr);
			else{
				out.println(atpDispStr);*/
		%>
			<!--<a href="JavaScript:showATPDetails('<%//=custMatNo%>','<%//=prodDesc%>','<%//=mfrNr%>','<%//=soLine%>','<%//=eanupc%>')"> ATP</a>-->

		<%
			//}
		%>
		<!--</Td>-->
		<input type="hidden" name="changeFlag_<%=i%>" value="true"> 
		<input type="hidden" name="index" 		value="<%=i%>"> 
		</Tr>
<%	
         }
      }
      }
%>
		
</Table>    
</Div>

<input type="hidden" value="1" 	name="count">
<input type="hidden" value="<%=cartRows%>" name="total">
<input type="hidden" value="<%=retLines.getRowCount()%>" name="totalItems">  
<input type="hidden" value="<%=Reason%>" name="reasonForRejection">

	<div  id="div5" align="center" style="overflow:auto;visibility:visible;position:absolute;top:99%;width:100%">
	<Table align="center" width="100%">
		<%
		     if(expCnt>0){
		%>
			<Tr>
				<Td align="center" class="blankcell" width="100%"><font color="blue"><b>This order contains invalid product codes marked with red please delete the lines before going to process this order</b> </font></Td>
			</Tr>
		<%
		     }
		
		    
		%>
		
		<Tr>
			<Td align="center" class="blankcell" width="100%"><font color="blue"><%=taxDutiAppli_L%></font></Td>
		</Tr>
		<Tr>
			<Td  class="blankcell" align="center" width="100%">
			<span id="EzButtonsSpan" style="width:100%"><nobr>
<%
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();
			
			
			
			
			
			if("confirm".equals(frmConfirm))
			{
				//buttonName.add("Change Shipping Address");
				//buttonMethod.add("changeShipAdrs(\"E\")");	
				if(mesg==null || "null".equals(mesg) || "".equals(mesg.trim())){
					buttonName.add("Save to Local");
					buttonMethod.add("confirmEditOrder(\"ezEditSaveSales.jsp\",\"NO\")");
					buttonName.add("Submit to SAP");
					buttonMethod.add("confirmEditOrder(\"ezEditSaveSales.jsp\",\"TRANSFERED\")");
				}
			}
			else
			{
				if(expCnt==0)
				{
					buttonName.add("Obtain Prices");
					buttonMethod.add("formSubmit(\"ezGetPricesEdit.jsp\",\"NO\")");
				}
				buttonName.add("Delete Lines");
				buttonMethod.add("ezDelSOLines()");			
			}		
		        if(cartRows>0 && expCnt==0)
		        {
				buttonName.add("Remarks");
				buttonMethod.add("nextEdit()");
			}
			if(srType!=null && !"null".equals(srType)) 
			{
				if(srType.equalsIgnoreCase("Y"))
				{
					buttonName.add("Back");
					buttonMethod.add("ezSearchListPage()");			
				}
			}	
			else
			{
				buttonName.add("Back");				
				buttonMethod.add("ezListPage(\"NEW\")");
			}
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

<div id="div6" style="overflow:auto;visibility:hidden;position:absolute;top:15%;left:2%;height:70%;width:98%">
	<Table align=center  class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="60%">
	<tr><th>Remarks</th></tr>
		<td>
			<textarea cols="90" rows="12" style="overflow:auto;border:0" name="generalNotes1" class=txarea><%=sdHeader.getFieldValueString(0,"TEXT2")%></textarea>
		</td>	
	</table>
</div>

<div id="div7" style="visibility:hidden;position:absolute;left:0%;top:89%;width:100%">
<center>	
<%
				buttonName = new java.util.ArrayList();
				buttonMethod = new java.util.ArrayList();
				buttonName.add("Back");
				buttonMethod.add("showTabEdit(\"1\")");	
				buttonName.add("Save to Local");
				buttonMethod.add("confirmEditOrder(\"ezEditSaveSales.jsp\",\"NO\")");
				if("confirm".equals(frmConfirm))
				{
					buttonName.add("Submit to SAP");
					buttonMethod.add("confirmEditOrder(\"ezEditSaveSales.jsp\",\"TRANSFERED\")");
				}				
				out.println(getButtonStr(buttonName,buttonMethod));
%>
</center>			
</div>
<input type="hidden" name="chkprice" value="1">
<div id="buttonDiv"></div>
<% 		
	String creditChk=request.getParameter("creditChk"); 
	if("Yes".equals(creditChk))
	{
%>	<script>
		alert("Credit limit Exceeded.Kindly advice when payement may be \n forwarded so your order may be executed.");
	</script>
<%
	}
%>
</form>
<Div id="MenuSol"></Div>  
</body>
</html>



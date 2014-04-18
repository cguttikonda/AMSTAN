/****************************************************************************************
        * Copyright Notice ===================================================
	* This file contains proprietary information of Answerthink Ind Ltd.
	* Copying or reproduction without prior written approval is prohibited.
	* Copyright (c) 2005-2006 =====================================*
		Author: Girish Pavan Cherukuri
		Team:   EzcSuite
		Date:   20/09/2005
*****************************************************************************************/

function funActivate(docType)
			{
	
				var Doc = docType;
				var defaultDiv = document.getElementById("defDIV");
				var poDiv = document.getElementById("PODIV");
				var invDiv = document.getElementById("INVDIV");
				var dcDiv = document.getElementById("DCDIV");
				var saDiv = document.getElementById("SADIV");
	
				defaultDiv.style.visibility="hidden";
				invDiv.style.visibility="hidden";
				dcDiv.style.visibility="hidden";
				saDiv.style.visibility="hidden";
				poDiv.style.visibility="hidden";
	
				var activateVal = document.getElementById(Doc+"DIV");
				activateVal.style.visibility="visible";
	
				var defVal='',defKeyVal='';
				
				try{
				
				if(eval("document.myForm."+Doc+"bySel[0]")!=null )
				{
					defVal = eval("document.myForm."+Doc+"bySel[0]");
					defVal.checked="true";
				}
				}catch(e){}
				if(eval("document.myForm."+Doc)!=null)
				{
					defKeyVal = eval("document.myForm."+Doc);
					defKeyVal.value="Enter Here";
				}
				
				if(Doc!='SA')
				{
					var labelObj1 = document.getElementById(Doc+"Label1");
					var labelObj2 = document.getElementById(Doc+"Label2");
				
					labelObj2.style.display="NONE";
					labelObj1.style.display="";
				}	
				
			}
			function funClick(docType)
			{
				var myobj = eval ("document.myForm." +docType);
	
				var labelObj1 = document.getElementById(docType+"Label1");
				var labelObj2 = document.getElementById(docType+"Label2");
				
				var labelObj3 = document.getElementById(docType+"Label3");
	
				var sel0 = eval ("document.myForm." +docType+"bySel[0]"+".checked");
				var sel1 = eval ("document.myForm." +docType+"bySel[1]"+".checked");
	
				if(sel0)
				{
					labelObj2.style.display="NONE";
					labelObj1.style.display="";
					if(docType=="PO")
						labelObj3.style.display="";
				}else if(sel1)
				 {
					labelObj1.style.display="NONE";
					labelObj2.style.display="";
					if(docType=="PO")
						labelObj3.style.display="NONE";
				 }
	
				myobj.value="Enter Here";
					return;
	
			}
			function funFocus(keyVal)
			{
				
				var myobj = eval ("document.myForm." + keyVal);
				if(myobj.value=="Enter Here")
					myobj.value="";
	
			}
			function funSubmit(docType)
			{
				var keyVal ="";
				var selLen = null;
				
				
				if(!(docType=='DC'))
				{
				selLen = eval("document.myForm."+docType+"bySel"+".length");
				
				
				if(selLen!=null)
				{
					for(i=0;i<selLen;i++)
					{
						if(eval ("document.myForm." +docType+"bySel["+i+"]"+".checked"))
							keyVal =eval ("document.myForm." +docType+"bySel["+i+"]"+".value")
					
					}
				}
				}
				
				if(docType=='PO')
				{
					if(keyVal=='PObyMat'){
						VerifyEmptyMat();
					}else if(keyVal=='PObyNo'){
						VerifyEmptyPurOrder();
					}
					
				}else if(docType=='INV')
				{	
					if(keyVal=='INVbyNO')
						VerifyEmptyVIN();
					else if(keyVal=='INVbyPO')
						VerifyEmptyPO();
				}
				else if(docType=='DC')
				{
					/*
					if(keyVal=='DCforPO')
						verifyEmptyDC(keyVal);
					else if(keyVal=='DCforSA')
						verifyEmptyDC(keyVal);
					//no schedule agreements exists commented by girish	
					*/	
					keyVal='DCforPO';
					verifyEmptyDC(keyVal);
					
				}
				else if(docType=='SA')
				{
					verifyEmptySA()
				}
	
	
			}
			function VerifyEmptyMat()
			{
	
				
				var matNo = funTrim(document.myForm.PO.value);
	/*
				if(matNo.indexOf("*")!=-1)
				{
					alert("Wild cards are not allowed by Material Search");
					document.myForm.PO.focus();
					return false;
				}
	
	*/
				if ((matNo == "")||(matNo =="0")||(matNo == "Enter Here") )
				{
					alert(plzMatNum_L);
					document.myForm.PO.focus();
					return false;
				}
				else
				{
					if ( isNaN(parseInt(matNo)) )
					{
						document.myForm.PO.value = matNo
					}
					else{
						matNo="000000000000000000"+matNo;
						matNo=matNo.substring(matNo.length-18,matNo.length);
						document.myForm.PO.value = matNo
					}
					document.myForm.SearchFlag.value="MaterialNumber"
					document.myForm.MaterialNumber.value=matNo;
					document.myForm.action="../../JSPs/Purorder/ezSearchPOMatList.jsp"
					document.myForm.submit();
					return;
				}
			}
			function VerifyEmptyPurOrder()
			{
				
				document.myForm.PO.value=funTrim(document.myForm.PO.value)
				document.myForm.POSearch.value="Yes";
				var dd = document.myForm.PO.value;
				if ((dd =="")||(dd =="Enter Here"))
				{
					alert(plzPoNum_L);
					document.myForm.PO.focus()
					return false;
				}
				else
				{
					document.myForm.SearchFlag.value="PONO";
					document.myForm.PurchaseOrder.value=dd;
					
					document.myForm.action="../../JSPs/Purorder/ezSearchPOList.jsp?PurchaseOrder="+dd;
					document.myForm.submit();
				}
	
			}
			function VerifyEmptyVIN()
			{
				
				
				document.myForm.INV.value=funTrim(document.myForm.INV.value)
				var invVal = document.myForm.INV.value; 
				if(invVal == ''||invVal=='Enter Here')
				{
					alert(plzInvNum_L);
					document.myForm.INV.focus();
					return false;
				}
				else
				{
					document.myForm.INV.value = funTrim(document.myForm.INV.value);
					document.myForm.searchField.value=document.myForm.INV.value;
			
					document.myForm.base.value="VendorInvoiceNumber";
					document.myForm.InvStat.value="A";
			
					document.myForm.action="../../JSPs/Purorder/ezSearchListInv.jsp"
					document.myForm.submit();
				}
			}
			function VerifyEmptyPO()
			{
				
				
				document.myForm.INV.value=funTrim(document.myForm.INV.value)
				var poInvVal = document.myForm.INV.value; 
				if(poInvVal ==''|| poInvVal=='Enter Here')
				{
					alert(plzPoNum_L);
					document.myForm.INV.focus();
					return false;
				}
				else
				{
					document.myForm.INV.value = funTrim(document.myForm.INV.value);
					document.myForm.searchField.value=document.myForm.INV.value
			
					document.myForm.base.value="PurchaseOrder";
					document.myForm.InvStat.value="P";
			
					document.myForm.action="../../JSPs/Purorder/ezSearchListInv.jsp"
					document.myForm.submit();
				}
			}
			function verifyEmptyDC(keyVal)
			{
				
				
				document.myForm.DC.value=funTrim(document.myForm.DC.value);
				var dcVal= document.myForm.DC.value;
				if(dcVal == ""||dcVal=="Enter Here")
				{
					alert(plzDcNum_L);
					document.myForm.DC.focus();
					return false;
				}
				else
				{
					document.myForm.SearchFlag.value="DCnoSearch";
					document.myForm.DCNO.value=dcVal;
					if(keyVal=='DCforPO')
						 document.myForm.action="../Purorder/ezListPOs.jsp";
					else
						document.myForm.action="../Purorder/ezcontract.jsp?OrderType=All";
					document.myForm.submit();
				}
			}
			function verifyEmptySA()
			{
				
				
				document.myForm.SA.value=funTrim(document.myForm.SA.value)
				var saVal = document.myForm.SA.value;
				document.myForm.contractNum.value=saVal;
				if(saVal == "" || saVal=="Enter Here")
				{
					alert(plzSchAgrNum_L);
					document.myForm.SA.focus();
					return false;
				}
				else 
				{
					document.myForm.action="../Purorder/ezcontract.jsp"
					document.myForm.submit();
				}
			}
			
	
	
		
		
			function funLTrim(sValue)
			{
				var nLength=sValue.length;
				var nStart=0;
				while ((nStart < nLength) && (sValue.charAt(nStart) == " "))
				{
					nStart=nStart+1;
				}
	
				if (nStart==nLength)
				{
					sValue="";
				}
				else
				{
					sValue=sValue.substr(nStart,nLength-nStart);
				}
	
				return sValue;
	
			}
			function funRTrim(sValue)
			{
	
				var nLength=sValue.length;
				if (nLength==0)
				{
					sValue="";
				}
				else
				{
					var nStart=nLength-1;
	
					while ((nStart > 0) && (sValue.charAt(nStart)==" "))
					{
						nStart=nStart-1;
					}
	
					if (nStart==-1)
					{
	
						sValue="";
	
	
					}
					else
					{
						sValue=sValue.substr(0,nStart+1);
					}
				}
	
				return sValue;
			}
			function funTrim(sValue)
			{
				sValue=funLTrim(sValue);
				sValue=funRTrim(sValue);
				return sValue;
			}


		
	

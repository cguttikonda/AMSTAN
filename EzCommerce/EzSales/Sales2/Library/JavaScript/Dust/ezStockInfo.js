/*
      Copyright Notice =====================================*
    * This file contains proprietary information of EzCommerce Inc.
    * Copying or reproduction without prior written approval is prohibited.
    * Copyright (c) 1999 ===================================*
*/

//This is for ezAddStock Functions
myProducts= new Array();
prodLength=0;
function displayPack(pos,ind)
{
	obj = document.forms[0]
	if(obj.pack[0] == null)
	{
		if (obj.product.selectedIndex==0){
			obj.pack.value=""
			obj.unitPrice.value=""
			obj.Transit.value="0"
		}else{
			obj.pack.value=myProducts[obj.product.selectedIndex-1].pack
			obj.unitPrice.value=myProducts[obj.product.selectedIndex-1].unitPrice
			obj.Transit.value=myProducts[obj.product.selectedIndex-1].quantity
		}
	}else
	{
		var pp1=pos.options[pos.selectedIndex].value
		if(funTrim(pp1)=="")
		{
			obj.pack[ind].value=""
			obj.unitPrice[ind].value=""
			obj.Transit[ind].value="0"
		}else
		{
			var matLength=myProducts.length
			for(k=0;k < matLength;k++)
			{
				if(funTrim(myProducts[k].code) == funTrim(pp1))
				{
					obj.pack[ind].value=myProducts[k].pack
					obj.unitPrice[ind].value=myProducts[k].unitPrice
					obj.Transit[ind].value=myProducts[k].quantity
				}
			}
		}
	}
}
function EzProduct(code,desc,pack,uPrice,eStock)
{
	this.code=code;
	this.desc=desc;
	this.pack=pack;
	this.unitPrice=uPrice;
	this.quantity=eStock;
}

function formEvents(formEvent)
{

	var sflag=true;
	var noOfRows=document.forms[0].sales.length	
	var form=document.forms[0]
	if(isNaN(noOfRows))	
	{
	
		/*
		if((form.sales.value!=0)||(form.OpenBal.value!=0)||(form.receipt.value!=0)||(form.Returnco.value!=0)||(form.Returnmrk.value!=0))
		{
			if(form.product.value==null)
			{
				sflag=false;
				break;
		 	}
		 	else
				sflag=true;
		}*/
		totVal1=parseFloat(form.OpenBal.value)+parseFloat(form.receipt.value)-parseFloat(form.sales.value)-parseFloat(form.Returnco.value)+parseFloat(form.Returnmrk.value);

		if(totVal1>=0)
			sflag=true;
		else{
			alert(valueshouldnotbeNegative);
			sflag=false;
			
		    }
			
	}//end of if	
	else		
	{
		for(i=0;i<noOfRows;++i)
		{
			if((form.sales[i].value!=0)||(form.OpenBal[i].value!=0)||(form.receipt[i].value!=0)||(form.Returnco[i].value!=0)||(form.Returnmrk[i].value!=0))
			{
				if(form.product[i].value==null)
				{
					sflag=false;
					break;
		 		}else
					sflag=true;
			}
			totVal1=parseFloat(form.OpenBal[i].value)+parseFloat(form.receipt[i].value)-parseFloat(form.sales[i].value)-parseFloat(form.Returnco[i].value)+parseFloat(form.Returnmrk[i].value);

			if(totVal1>=0)
				sflag=true;
			else{
				alert(valueshouldnotbeNegative);
				sflag=false;
				break;
			}
		}//end of for loop
	}//end of if
	var js_flag=false
	if(sflag==true)
		js_flag=chkMultiple();
	
	if (js_flag && sflag)
	{
		flag=confirm("About to submit the changes you have made in Stock Statement. Are you sure of it ?");
		if (flag)
		{
			form.action=formEvent
			form.submit();
		}
	}


}


function validateField(obj,ind,val)
{
	var noOfRows=document.forms[0].sales.length

	if(isNaN(obj.value))
	{
		alert(ValueshouldbeNumeric);
		obj.value=val;
		obj.focus();
	}
	else if (parseInt(obj.value)< 0)
	{
		alert(ValueshouldbePositive);
		obj.value=val;
		obj.focus();
		return false
	}
	else if(funTrim(obj.value)=='')
	{    
	obj.value=val	
	
	/*if (isNaN(noOfRows))
		{					
 			clsVal=parseFloat(document.forms[0].OpenBal.value)+parseFloat(document.forms[0].receipt.value)-parseFloat(document.forms[0].sales.value);
			document.forms[0].CloseBal.value=clsVal;
		}else{
			clsVal=parseFloat(document.forms[0].OpenBal[ind].value)+parseFloat(document.forms[0].receipt[ind].value)-parseFloat(document.forms[0].sales[ind].value);
			document.forms[0].CloseBal[ind].value=clsVal;
					}
	*/
	
	}	
	else
	{
		if(obj.name!='CloseBal')
		return calCloseStock(obj,ind)
		else
		return false
	}
}


function calCloseStock(pos,ind)
{
	var noOfRows=document.forms[0].sales.length
	if (isNaN(noOfRows))
	{
		totVal=parseFloat(document.forms[0].OpenBal.value)+parseFloat(document.forms[0].receipt.value)-parseFloat(document.forms[0].sales.value)-parseFloat(document.forms[0].Returnco.value)+parseFloat(document.forms[0].Returnmrk.value);
		if (totVal < 0){
			alert(valueshouldnotbeNegative)
			return false;
		}else{
		       document.forms[0].CloseBal.value=totVal;
		       return true;
		}
	}else{
		totVal=parseFloat(document.forms[0].OpenBal[ind].value)+parseFloat(document.forms[0].receipt[ind].value)-parseFloat(document.forms[0].sales[ind].value)-parseFloat(document.forms[0].Returnco[ind].value)+parseFloat(document.forms[0].Returnmrk[ind].value);
		if (totVal < 0){
			alert(valueshouldnotbeNegative)
			return false;
		}
		else{
			document.forms[0].CloseBal[ind].value=totVal;
			
			return true;
		}
	}
}

function chkMultiple()
{
	obj = document.forms[0]
	var OpenBalLength=obj.OpenBal.length
	var productLength=obj.product.length
//alert("opnbalance::"+OpenBalLength);
//alert("prdLength::"+productLength);
	if(OpenBalLength >= 1)
        {
		for(i=0;i<productLength;i++)
		{
	 		if(obj.product[i].type!="hidden")
	 		{
				if ((obj.OpenBal[i].value==0)&&(obj.receipt[i].value==0)&&(obj.sales[i].value==0)&&(obj.CloseBal[i].value==0)&&(obj.Transit[i].value==0))
				{
					if(obj.product[i].value!="")
					{
						alert(entertheStockInfo)
						obj.product[i].focus()
						return false;
					}
				}else{
					if(obj.product[i].value=="")
					{
						alert(selectMaterial)
						obj.product[i].focus()
						return false;
					}
				}
			}
		}
	}else{
		if(obj.product.type!="hidden")
	 	{
	 		if ((obj.OpenBal.value==0)&&(obj.receipt.value==0)&&(obj.sales.value==0)&&(obj.CloseBal.value==0)&&(obj.Transit.value==0))
	 		{
	 			if(obj.product.value!="")
	 			{
	 				alert(entertheStockInfo)
	 				obj.product.focus()
	 				return false;
	 			}
	 		}
	 		else
	 		{
	 			if(obj.product.value=="")
	 			{
	 				alert(selectMaterial)
	 				obj.product.focus()
	 				return false;
	 			}
	 		}
	 	}
	 }
	if (isNaN(obj.pack.length))
		return true;
	else
	{
		for(i=0;i<productLength-1;i++)
		{
			for(j=i+1;j<productLength;j++)
			{
				if(obj.product[i].value=="")
					continue;
				if(obj.product[i].value==obj.product[j].value)
				{
					alert (Youhaveselected+ " '"+obj.product[j].options[obj.product[j].selectedIndex].text+"'"+selectproductonlyonce);
					obj.product[j].focus()
					return false;
				}
			}
		}
	}
	return true
}
//End for ezAddStock Functions

//This is used in ezEditStock,ezAddStock
function movetoHome()
{
		document.location.replace("../Misc/ezMenuFrameset.jsp");
}
//This is used in ezEditStock,ezAddStock
function openWindowEdit(fieldName)
{
	str = "ezRemarksEntry.jsp?fieldName="+fieldName
	newWindow = window.open(str,"MyWin","resizable=no,left=250,top=180,height=270,width=350,status=no,toolbar=no,menubar=no,location=no")
}
//This is used in ezEditStock,ezAddStock
function openWindowShow(fieldName)
{
	str = "ezShowRemarks.jsp?fieldName="+fieldName
	newWindow = window.open(str,"MyWin","resizable=no,left=250,top=180,height=270,width=350,status=no,toolbar=no,menubar=no,location=no")
}

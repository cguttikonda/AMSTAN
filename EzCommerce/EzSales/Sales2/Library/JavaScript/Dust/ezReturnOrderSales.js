
function setSoldToName()
{
	pp1=document.generalForm.SoldTo.options[document.generalForm.SoldTo.selectedIndex].text
	document.generalForm.SoldToName.value=pp1
}


function mselect(j)
{
	var one=j.split(",");	
	
	if(eval("document.generalForm."+one[0]+".selectedIndex")==0){
 		return false;
	}else{
		return true;
	}

}

function verifyField(obj,name)
{
	if(funTrim(obj.value) != "")
	{
		if(parseFloat(obj.value) <= parseFloat("0"))
		{
			alert(name + " "+cannotbelessthan0);
			obj.value="";
			obj.focus();
			return false;
		}
		else if(isNaN(obj.value))
		{
			alert(Pleaseentervalid+" "+name);
			obj.value="";
			obj.focus();
			return false;
		}
	}return true;
}


function chkField()
{
	// to check if valid quantity and price are ebntered
	var p=document.generalForm.matNo.length;
	for(var j=0;j<validNosArr.length;j++)
	{
		var obj
		for(var i=0;i<p;i++)
		{
			if(j==0)
				obj=document.generalForm.Qty[i];
			else
				obj=document.generalForm.price[i];
			obj.value = funTrim(obj.value)
			y=verifyField(obj,validNosArr[j])
		}
	}return true
}


function chkSelectMat()
{
	//to check if at least one material is selected .
	var p=document.generalForm.matNo.length;

	var count=0
	for(var i=0;i<p;i++)
	{
		obj=document.generalForm.matNo[i]
		if(obj.selectedIndex !=0)
		{
			count=1
			break;
		}
	}
	if(count==0)
	{
		alert(PleaseSelectatleastoneProduct);

		return false
	}
	else
	{
		return true
	}
}


function chkValidLine()
{
	// to check if full line is complect
	gform = document.generalForm
	var p=gform.matNo.length;



	objdoctype=gform.ordReason
	if(objdoctype.selectedIndex==0)
	{
		alert("Please Select Order Reason");
		objdoctype.focus()
	    return false;
	}
	for(var i=0;i<p;i++)
	{
		obj=gform.matNo[i]
		if(obj.selectedIndex !=0)
		{

			pp1=obj.options[obj.selectedIndex].text
			objQty=gform.Qty[i]
			objpric=gform.price[i]
			objinvdate=gform.invDate[i]
			objinvno=gform.invNo[i]
			objbatchno=gform.batchNo[i]
			objcategory=gform.category[i]

			objQty.value=funTrim(objQty.value);
			objpric.value=funTrim(objpric.value);
			objinvno.value=funTrim(objinvno.value);
			objinvdate.value=funTrim(objinvdate.value);
			objbatchno.value=funTrim(objbatchno.value);
			objcategory.value=funTrim(objcategory.value);


			if( (objQty.value == "") || (parseFloat(objQty.value) == parseFloat("0")) )
			{
				alert(PleaseenterQuantityforProduct+" "+pp1)
				objQty.focus()
				return false;
			}
			if(objdoctype.value=="054")
			{
				if( (objinvno.value == "") || (parseFloat(objinvno.value) == parseFloat("0") ))
				{
					alert("Please Enter Invoice No. For Product "+pp1)
					objinvno.focus();
					return false;
				}
			}

			if( (objinvno.value != "") && (parseFloat(objinvno.value) != parseFloat("0") ))
			{
				
				if( (objinvdate.value == "") || (objinvdate.value == "0"))
				{
					alert("Please Enter Invoice Date Of "+pp1)
					return false;
				}
			}

			if(objinvdate.value != "") 
			{
				if( (objinvno.value == "") || (parseFloat(objinvno.value) == parseFloat("0") )){
					alert("Please Enter Invoice No. For Product "+pp1)
					return false;
				}
			}


			
			if(objdoctype.value=="055")
			{
				if( (objbatchno.value == "") || (parseFloat(objbatchno.value) == parseFloat("0") ))
				{
					alert("Please Enter Batch Number Of "+pp1)
					//objbatchno.focus()
					return false;
				}

			}

			if( (objpric.value == "") || (objpric.value == "0"))
			{
				alert("Please Enter MRP For Product "+pp1)
				//objpric.focus()
				return false;
			}
			/*if( (objcategory.value == "") || (objcategory.value == "0"))
			{
				alert("Please select category for product "+pp1)
				objcategory.focus()
				return false;
			}*/
			
		}
	}return true;
}





function podate()
{
	// to check if po date is greate than today
         obj=funTrim(document.generalForm.poDate.value);
        if(obj != null)
       {
	a=(obj).split(".");
	b=(today).split(".");
		
	d1=new Date(a[2],(a[1]-1),a[0])
	d2=new Date(b[2],(b[1]-1),b[0])
			
	if( d1 > d2)
	{
		alert(poDateshouldbeToday);
		return false;
	}
      }return true;
}
   
function chkAll()
{
	var p=document.generalForm.matNo.length;
	for(j=0;j<p;j++)
	{
		Mat=document.generalForm.matNo[j]
		Qty=document.generalForm.Qty[j]
		Pric=document.generalForm.price[j]
				
		Qty.value=funTrim(Qty.value)
		Pric.value=funTrim(Pric.value)
		Mat.options[Mat.selectedIndex].value=funTrim(Mat.options[Mat.selectedIndex].value);

		
		if( (Mat.options[Mat.selectedIndex].value !="") || ( (Qty.value != "") && (Qty.value != "0") )||( (Pric.value !="") && (Pric.value !="0")))
			{
				if( (Mat.options[Mat.selectedIndex].value =="") || (Qty.value == "") || (Pric.value ==""))
				{
					alert(LineItemisUnCompleteFillit);
					Mat.focus()
					return false
				}
			}

	}return true
}
function chk()
{

	objpo =eval("document.generalForm.poNo");
	objpoVal = funTrim(objpo.value)

	if(objpoVal=="")
	{
		alert("Please Enter Ref No.")
		objpo.value = objpoVal
		objpo.focus();
		return false
	}


	objpodat =eval("document.generalForm.poDate");
	objpodatVal = funTrim(objpodat.value)
	
	if(objpodatVal=="")
	{
		alert("Please Enter Ref Date")
		objpodat.focus();
		return false
	}


	// to check if po date is greate than today
	y=podate()
	if(!eval(y))
	    return false;
	    
	  
	  
        if(document.generalForm.ordReason.selectedIndex==0)
	 {
	 	alert("Please Select Order Reason");
	 	document.generalForm.ordReason.focus()
	 	
	    return false;
	  }
 
	// to check if at least one material is selected	
	y=chkSelectMat()
	if(!eval(y))
	    return false;


	// to check if valid quantity and price are ebntered
	y=chkField()
	if(!eval(y))
	    return false;

	// to check if full line is complect 
	y=chkValidLine();
	if(!eval(y))
	    return false; 


	y=chkAll()
	if(!eval(y))
	    return false; 
	
	for(i=0;i<document.generalForm.matNo.length;i++)
	{
	
		if(document.generalForm.soldTo!=null)
		{
			if(document.generalForm.soldTo.selectedIndex==0)
			{
				alert("Please Select SoldTo");
				return false;
			}
		}
		
	     if(funTrim(document.generalForm.Qty[i].value) != "")
	     {	
		if( funTrim(document.generalForm.prodDate[i].value) == "")
		{
			alert(chooseaRequiredDate);
			return false;
		}
		else 
		{
			a=(funTrim(document.generalForm.prodDate[i].value)).split(".");
			b=(today).split(".");
		
			d1=new Date(a[2],(a[1]-1),a[0])
			d2=new Date(b[2],(b[1]-1),b[0])
			
			if( d1 < d2)
			{
				alert(RequiredDateshouldbeToday);
				document.generalForm.price[i].focus()
				return false;
			}
		}
	    }
	}

	return true;
}

function formSubmit(obj,type)
{
	
	y="true";
	
	if(obj=="ezAddSaveReturnSalesOrder.jsp")   
		y=chk();
	
	
	if(eval(y))
	{
		if('REMARKS'==type)
		{
			
			showTabRSOrder(2)
			y="false"
			
		}
	}
	if(eval(y))
	{
	
		document.forms[0].orderStatus.value=type
       		document.forms[0].action=obj
		if(obj=="ezAddSaveReturnSalesOrder.jsp")       		
		{
	       		document.getElementById("EzButtonsSpan").style.display="none";
	       		document.getElementById("EzButtonsMsgSpan").style.display="block";
	       		document.getElementById("EzButtonsRemarksSpan").style.display="none";
	       		document.getElementById("EzButtonsRemarksMsgSpan").style.display="block";	       		
	       	}
		document.forms[0].submit();
	}
	
}
function setShipName()
{

}
function setMatDescUom(obj,ind)
{
//alert(obj+"-----"+ind)
	pp1=obj.options[obj.selectedIndex].value
	var p=document.generalForm.matNo.length;
	var changeflag=false;
   	for(i=0;i<p;i++)
	{
		if(obj.sourceIndex == document.generalForm.matNo[i].sourceIndex)
		{
			if(funTrim(pp1)=="")
			{
				document.generalForm.prodDesc[i].value=""
				document.generalForm.uom[i].value=""
			}else
			{
				for(k=0;k<document.generalForm.matNo[i].length;k++)
				{
					if(funTrim(ezMatList[k].matno) == funTrim(pp1))
					{

						document.generalForm.uom[ind].value=ezMatList[k].uom
						document.generalForm.prodDesc[ind].value=obj.options[obj.selectedIndex].text
						changeflag=true;
						break;
					}
				}

				//alert(document.generalForm.prodDesc[i].value)
			}
		}
		if(changeflag)
			break;
	}

}

function openNewWindow1(urlStr,pos)
{
	syskey=" "
		urlStr=urlStr+"?ind="+pos
		if (document.generalForm.ShipTos[pos]!=null)
			shipVal=document.generalForm.ShipTos[pos].value
		else	
			shipVal=document.generalForm.ShipTos.value

		aa=showModalDialog(urlStr,shipVal,'center:yes;dialogWidth:35;dialogHeight:30;status:no;minimize:yes')
		if (aa!=null){
			if (document.generalForm.ShipTos[pos]!=null)
				document.generalForm.ShipTos[pos].value=aa
			else
				document.generalForm.ShipTos.value=aa

			document.getElementById("ShipLink_"+pos).innerText=view22
		}
}

function openNewWindow2(obj)
{

}

function changeHref(pos)
{
	if (document.getElementById("ShipLink_"+pos)!=null)
	{
		if(shipToCount ==1)
		{
			document.getElementById("ShipLink_"+pos).innerText=view22
		}else
		{
			document.getElementById("ShipLink_"+pos).innerText="Select"
		}
	}
}

var MSelect = new Array();
var MValues = new Array();
var MDate = new Array();

if(statusOrder=="NEW")
{
MValues[0]="desiredQty";
}
else if(UserLogin == "LF" )
{
//MValues[0]="commitedQty";
MValues[0]="commitedPrice";
}

if(statusOrder=="NEW" || statusOrder=="RETURNEDBYCM")
{
MDate[0]="desiredDate";
}
else if((statusOrder=="SUBMITTED")||(statusOrder=="APPROVED")||(statusOrder=="TRANSFERED"))
{
MDate[0]="commitedDate";
}
function chk()
{
	
        var res=true;
	for(b=0;b<MValues.length;b++)
	{  
		res= chkQty(MValues[b]);
		if(!res)
		{
			return false;
		}
	}
	
	for(c=0;c<MDate.length;c++)
	{
		if(total==1)
		{       
			if( funTrim(eval("document.generalForm."+MDate[c]+".value")) == "")
			{
			alert(pleaseenter+" "+MDate[c]);
			showTab("1");;
			return false;		
			}
		}
		else if(total > 1)
		{
			for(i=0;i<total;i++)
			{	
				if( funTrim(eval("document.generalForm."+MDate[c]+"["+i+"].value")) == "")
				{
				alert(pleaseenter+" "+MDate[c]);
				showTab("1");
				return false;
				}
			}	
		}
		
	}
	
	/*if( (CreatedBy == UserLogin) && (document.generalForm.status.value != "NEW" ) )
	{ 
		MSelect[0]="shipTo,"+selectShipTo;
		MSelect[1]="incoTerms1,"+SelectINCOTerms;
		MSelect[2]="payementTerms,"+SelectPaymentTerms;

		for(var a=0;a<MSelect.length;a++)
		{
			res=mselect(MSelect[a]);
			
			if(!res)
			{
				if(a>0)
				   showTab("2");
				else
                                    showTab("1");

				 one=MSelect[a].split(",");	
				eval("document.generalForm."+one[0]+".focus()")
				return false;
			}
		}
	}*/
	
	return true;
	
}

function showAll(divId)
{
	myDivIds= new Array("div1","div2");
	if(document.getElementById)
	{
		for(dLength=0;dLength<myDivIds.length;dLength++)
		{
			if (divId==myDivIds[dLength])
			{
				document.getElementById(myDivIds[dLength]).style.visibility="visible"
			}
			else
			{
				document.getElementById(myDivIds[dLength]).style.visibility="hidden"
			}
		}
	}
}
//TO CHECK MANDATORY FOR SELECT BOXES

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
function verifyField(theField,name)
{
	theField.value = funTrim(theField.value)
	if(theField.value == "")
	{
		if(MValues[0] == "desiredQty")
		alert(enterQuantitybyclickingonDeliveryDates);
		else
		alert(enterConfirmedPrice);
		if(UserRole == "LF")
			showTab("1");

		if(MValues[0] != "desiredQty")
		theField.focus();
		return false;
	}
	else if(theField.value <= 0)
	{
		if(MValues[0] == "desiredQty")
		alert(Quantitycannotbelessthanorequalto0);
		else
		alert(ConfirmedPricecannotbelessthanorequalto0);
		if(UserRole == "LF")
			showTab("1");
		theField.value="";
		if(MValues[0] != "desiredQty")
		theField.focus();
		return false;
	}
	else if( isNaN( parseFloat( theField.value ) ) )
	{
		if(MValues[0] == "desiredQty")
		alert(entervalidQuantity);
		else
		alert(entervalidConfirmedPrice);
		if(UserRole == "LF")
			showTab("1");
		theField.value="";

		if(MValues[0] != "desiredQty")
		theField.focus();
		return false;
	}
	return true;
	
}

function chkQty(name)
{
	if(total==1)
	{
		y= verifyField(eval("document.generalForm."+name),name);
		if(!y)
		{
			showTab("1");
			if(name != "desiredQty")
			eval("document.generalForm."+name+".focus()")
			return false;
		}
	}
	else if(total > 1)
	{
		for(i=0;i<total;i++)
		{
			y= verifyField(eval("document.generalForm."+name+"["+i+"]"),name);
			if(!y)
			{
			   showTab("1");
			 if(name != "desiredQty")
			   eval("document.generalForm."+name+"["+i+"].focus()")
			   return false;
			}
		}
	}
	
	return true;
}

var MSelect = new Array();

if((UserRole == "CU")&& (shipRowCount != 1))
{
      MSelect[0]="shipTo,Please select ShipTo";
}
else if( (UserRole != "CU")&& (SoldTo =="") )
{
       MSelect[0]="soldTo,Please select SoldTo";
}
else if((UserRole != "CU")&& (SoldTo !="" ))
{
	if(shipRowCount != 1)
	{
	         MSelect[0]="shipTo,"+PleaseselectShipTo;
        	 MSelect[1]="soldTo,"+PleaseselectSoldTo;
	}else
	{
		MSelect[0]="soldTo,"+PleaseselectSoldTo;
	}
}

function mselect(j)
{
	var one=j.split(",");	
	if(eval("document.generalForm."+one[0]+".selectedIndex")==0)
	{
		alert(one[1]);
		eval("document.generalForm."+one[0]+".focus()");
	 	return false;
	}
	else{
		return true;
	}
}
function selselect(j)
{
	var one=j.split(",");	
	var Length=eval("document.generalForm."+one[0]+".options.length");
	for(var k=0;k<Length;k++)
	{
		if(eval("document.generalForm."+one[0]+".options[k].value")==one[1])
		{			
			eval("document.generalForm."+one[0]+".options[k].selected=true")
			 break;
		}
	}
}
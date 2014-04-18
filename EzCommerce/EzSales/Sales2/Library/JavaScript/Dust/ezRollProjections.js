
function submitPage()
{
	if(chkMonthAndYear())
	{
		document.forms[0].count.value="0";
		document.forms[0].action="ezRollProjections.jsp";
		document.forms[0].needReset.value="Y";
		document.forms[0].submit();
	}
	else
		return false
		
}

function chkProduct()
{
	noDupe=true
	
	if (! isNaN(document.forms[0].product.length))
	{
			
		for(i=0;i<document.forms[0].product.length-1;i++)
		{
			if(document.forms[0].product[i].value=="NO")
				 continue;

			for(j=i+1;j<document.forms[0].product.length;j++)	
			{
				if(document.forms[0].product[i].value==document.forms[0].product[j].value)
				{
					noDupe=false
					msg=document.forms[0].product[j].options[document.forms[0].product[j].selectedIndex].text;
					document.forms[0].product[i].focus();
					break;
				}
			}
			if(! noDupe)
				break;
		}
	
	if(! noDupe)
	{	
		alert(Youhaveselected + msg + morethanonce+" \n"+ PlsDontSelect);
		return false;
	}
	}
	return true;
	
}
	
myRF= new Array();
function EzRF(product,val1,val2,val3)
{
	if(val1=="null")
		val1="0"

	if(val2=="null")
		val2="0"
	if(val3=="null")
		val3="0"

	this.product=product;
	this.val1=val1;
	this.val2=val2;
	this.val3=val3;
}

function doUpdateRF()
{
	if(chkNumber())
	{
		if(chkProduct())
		{
			document.forms[0].action="ezAddRollingForecast.jsp";
			document.forms[0].submit();
		}
	}
}

function formEvents(formEvent)
{
	if(chkNumber())
	{
		
		if("ezRollProjections.jsp"==formEvent)
		{
			document.forms[0].count.value=parseInt(document.forms[0].count.value)+1;
		}
		document.forms[0].action=formEvent
		document.forms[0].submit();
	
	}

}

function chkNumber()
{
	 for(i=0;i<document.forms[0].elements.length;i++)
	 {
		if(document.forms[0].elements[i].type=="text" && document.forms[0].elements[i].name !="pack")
		{
			if(isNaN(document.forms[0].elements[i].value))
			{
				alert(EnterValidNumber);
				document.forms[0].elements[i].focus();
				return false;
			}
			else if(document.forms[0].elements[i].value<0)
			{
				alert(ValuemustnbeNegative);
				document.forms[0].elements[i].focus();
				return false;
			}
			else if(funTrim(document.forms[0].elements[i].value)=="")
			{
				alert(PleaseEnteravalue);
				document.forms[0].elements[i].focus();
				return false;
			}
			else if(! funDecimalTest(document.forms[0].elements[i].value))
			{
				alert(PleaseEnterOnlyTwodigits)
				document.forms[0].elements[i].focus();
				return false;
			}				
				
		}
	}	
	return true;	
}
function funDecimalTest(aValue)
{
	dIndex=aValue.indexOf(".");
	if(dIndex==-1)
		return true;
	else if(dIndex < (aValue.length-3))	
		return false
	return true
}
	
	

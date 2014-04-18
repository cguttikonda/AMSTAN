
function chkNumber()
{
	 for(i=0;i<document.forms[0].elements.length;i++)
	 {
		if(document.forms[0].elements[i].type=="text" && document.forms[0].elements[i].name !="pack")
		{
		}
	}	
	return true;	
}
function validate(obj,val1)
{	
	if(isNaN(obj.value))
	{
		alert(ValueshouldbeNumeric);
		obj.focus();
		return false
	}
	else if(funTrim(obj.value)=='')
	{
		obj.value="0"
	}	
	else if (parseInt(funTrim(obj.value))< 0)
	{
		alert(ValueshouldbePositive);
		obj.focus();
	}
	else
	{
		obj.value=funTrim(obj.value)
		calculate(val1)
	}
}
function validateField(obj)
{
	if(isNaN(obj.value))
	{
		alert(ValueshouldbeNumeric);
		//obj.focus();
		return false
	}
	else if(funTrim(obj.value)=='')
	{
		obj.value="0";
	}
	else if (parseInt(obj.value)< 0)
	{
		alert(ValueshouldbePositive);
		//obj.focus();
		return false
	}
	else
	{
		return calCloseStock(obj)
	}
}

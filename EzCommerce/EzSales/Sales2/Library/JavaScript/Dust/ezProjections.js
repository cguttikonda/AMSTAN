
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
function validate(obj)
{
	if(isNaN(obj.value))
	{
		alert(ValueshouldbeNumeric);
		obj.focus();
		return false
	}
	else if(funTrim(obj.value)=='')
	{
		obj.value="0";
	}
	else if (parseInt(obj.value) < parseInt(0) )
	{
		alert(ValueshouldbePositive);
		obj.focus();
		return false
	}
	return true
}
function validateField(obj)
{
	if(isNaN(obj.value))
	{
		alert(ValueshouldbeNumeric);
		obj.focus();
		return false
	}
	else if(funTrim(obj.value)=='')
	{
		obj.value="0";
	}
	else if (parseInt(obj.value)< 0)
	{
		alert(ValueshouldbePositive);
		obj.focus();
		return false
	}
	else
	{
		calculateSales(obj)
	}
}
function chkMultiple()
{
	js_arr=new Array();
	var i=0	
	if ((document.forms[0].product1!=null)&&(document.forms[0].pack1!=null))
	{
		if (isNaN(document.forms[0].pack1.length))
			js_arr[0]=document.forms[0].product1.value
		else{
			for (i=0;i<document.forms[0].product1.length;i++)
				js_arr[i]=document.forms[0].product1[i].value
		}
		i=js_arr.length
	}

	if (isNaN(document.forms[0].pack.length))
		js_arr[i]=document.forms[0].product.value
	else{
		for (j=0;j<document.forms[0].product.length;j++)
		{
			if (document.forms[0].product[j].value!="")
			js_arr[j+i]=document.forms[0].product[j].value
		}
	}
		
	
	for(i=0;i<js_arr.length-1;i++)
	{
		for(j=i+1;j<js_arr.length;j++)	
		{
			if(js_arr[i]==js_arr[j])
			{
				alert (Multipleselection);
				return false;
			}
		}
	}
	return true	
}


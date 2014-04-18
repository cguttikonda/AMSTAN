function verifyone(theField)
{
	theField.value = funTrim(theField.value);
	if( (theField.value != "") && (theField.value > 0) )
	{
			return false;
	}else
	{
		return true
	}
	

}
function chkQtyone(name)
{
	var y
	if(total==1)
	{
		y= verifyone(eval("document.generalForm."+name));
		if(!eval(y))
		{
			return false
		}
		
		
	}
	else if(total > 1)
	{
		for(i=0;i<total;i++)
		{
			y=verifyone(eval("document.generalForm."+name+"["+i+"]"));
			
			if(!eval(y))
			{
				return false
			}
			
		}
	}
	return true
	

}
function verifyField(theField,name)
{
	theField.value = funTrim(theField.value)
	if(theField.value == "")
	{
	}
	else 
	{
		if(theField.value < 0)
		{
			alert(name+ " "+cannotbelessthan0 );

			theField.value="";
			theField.focus();
			return false;
		}
		else if(isNaN(theField.value))
		{
			alert(entervalid+" " + name +" "+ inNumbers);

			theField.value="";
			theField.focus();
			return false;
		}
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
			   return false;
			}
		}
	}
	
	return true;
}

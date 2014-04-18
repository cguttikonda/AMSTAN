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
function verifyBanker(obj,name)
{
	if(funTrim(obj.value) != "")
	{
		if(obj.value <= 0 )
		{
			alert(PleaseEnterValid+" "+name);
			obj.value="";
			///obj.focus();
			return false;
		}else if(isNaN(obj.value))
		{
			alert( PleaseEntervalid+" "+name+" "+code);
			obj.value="";
			///obj.focus();
			return false;
		}
	}
		return true;
}
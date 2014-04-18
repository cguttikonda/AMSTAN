function funLTrim(sValue)
{	
	var nLength=sValue.length;
	var nStart=0;
	while ((nStart < nLength) && (sValue.charAt(nStart) == " "))
	{
		nStart=nStart+1;
	}

	if (nStart==nLength)
	{
		sValue="";
	}
	else
	{
		sValue=sValue.substr(nStart,nLength-nStart);
	}

	return sValue;
	
}
function funRTrim(sValue)
{
	
	var nLength=sValue.length;
	if (nLength==0) 
	{
		sValue="";
	}
	else
	{
		var nStart=nLength-1;
		
		while ((nStart > 0) && (sValue.charAt(nStart)==" "))
		{
			nStart=nStart-1;
		}
	
		if (nStart==-1)
		{
			
			sValue="";
		
		
		}
		else
		{
			sValue=sValue.substr(0,nStart+1);
		}
	}
	
	return sValue;
}
function funTrim(sValue)
{
	sValue=funLTrim(sValue);
	sValue=funRTrim(sValue);
	return sValue;
}
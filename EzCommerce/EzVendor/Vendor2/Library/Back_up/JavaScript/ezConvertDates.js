function ConvertDate(reqDate,dateFormat)
{
	var mm=0;
	var dd=0;
	var yy=0;
	if("1"==dateFormat)
	{
        	yy=parseInt(reqDate.substring(0,4),10);
        	mm=parseInt(reqDate.substring(5,7),10);
		dd=parseInt(reqDate.substring(8,10),10);		
	}
	else if("2"==dateFormat)
	{
        	yy=parseInt(reqDate.substring(0,4),10);
        	dd=parseInt(reqDate.substring(5,7),10);	
        	mm=parseInt(reqDate.substring(8,10),10);
		
	}
	else if("3"==dateFormat)
	{
		mm=parseInt(reqDate.substring(0,2),10);
        	dd=parseInt(reqDate.substring(3,5),10);	
        	yy=parseInt(reqDate.substring(6,10),10);
	}
	else if("4"==dateFormat)
	{
		dd=parseInt(reqDate.substring(0,2),10);	
		mm=parseInt(reqDate.substring(3,5),10);
        	yy=parseInt(reqDate.substring(6,10),10);		
	}
	else if("5"==dateFormat)
	{
		yy=parseInt(reqDate.substring(0,2),10);	
		mm=parseInt(reqDate.substring(3,5),10);		
		dd=parseInt(reqDate.substring(6,8),10);	
	}
	else if("6"==dateFormat)
	{
		yy=parseInt(reqDate.substring(0,2),10);	
		dd=parseInt(reqDate.substring(3,5),10);		
		mm=parseInt(reqDate.substring(6,8),10);		
	}
	else if("7"==dateFormat)
	{
		mm=parseInt(reqDate.substring(0,2),10);	
		dd=parseInt(reqDate.substring(3,5),10);		
		yy=parseInt(reqDate.substring(6,8),10);	
	}
	else if("8"==dateFormat)
	{
		dd=parseInt(reqDate.substring(0,2),10);		
		mm=parseInt(reqDate.substring(3,5),10);	
		yy=parseInt(reqDate.substring(6,8),10);			
	}

	if(parseInt(dd,10)<10)
	{
		dd="0"+dd;
	}

	if(parseInt(mm,10)<10)
	{
		mm="0"+mm;
	}
	

	finalString = dd+'.'+mm+'.'+yy
	return finalString;
}

function ConvertDateFormat(reqDate,dateFormat,seperator)
{
	var mm=0;
	var dd=0;
	var yy=0;
	
	var rDate = reqDate.split(".");
	dd = rDate[0]
	mm = rDate[1]
	yy = rDate[2]

	var finalString = reqDate	
	if("1"==dateFormat)
	{
	     finalString = yy+seperator+mm+seperator+dd	
	}
	else if("2"==dateFormat)
	{
	     finalString = yy+seperator+dd+seperator+mm	
	}
	else if("3"==dateFormat)
	{
 	     finalString = mm+seperator+dd+seperator+yy	
	}
	else if("4"==dateFormat)
	{
             finalString = dd+seperator+mm+seperator+yy	
	}
	else if("5"==dateFormat)
	{
	     finalString = yy.substring(2,4)+seperator+mm+seperator+dd		
	}
	else if("6"==dateFormat)
	{
	     finalString = yy.substring(2,4)+seperator+dd+seperator+mm			
	}
	else if("7"==dateFormat)
	{
	     finalString = mm+seperator+dd+seperator+yy.substring(2,4)			
	}
	else if("8"==dateFormat)
	{
	     finalString = dd+seperator+mm+seperator+yy.substring(2,4)			
	}
	return finalString;
}

var msgString=""
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
		var nStart=nLength;
		
		while ((nStart > 0) && (sValue.charAt(nStart)==" "))
		{
			nStart=nStart-1;
		}
	
		if (nStart==0)
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
function funIPaddress(sValue)
 {
 
 	var validchars="0123456789.";
 	var nLoop=0;
 	var ncnt=0;
 	var nLength=sValue.length;
 	for(nLoop=0;nLoop<=nLength-1;nLoop++)
 	{
		cChar=sValue.charAt(nLoop);
		if(validchars.indexOf(cChar)==-1)
		{
			return false;
		}
		if(sValue.charAt(nLoop)== ".")
		{
			ncnt ++;
		}
	}
	if(ncnt != 3)
	{
		return false;
	}

	 var firstdot = sValue.substr(0,sValue.indexOf("."));
	 if(firstdot.length != 3)
	 {
	 	return false;
	 }

	 var secdot = sValue.substr(sValue.indexOf(".")+1,sValue.length);
	 var ssecdot = secdot.substr(0,secdot.indexOf("."));
	 if(ssecdot.length != 3)
	 {
	  	return false;
	 }

	var thirddot = secdot.substr(secdot.indexOf(".")+1,secdot.length);
	var sthirddot = thirddot.substr(0,thirddot.indexOf("."));
	if(sthirddot.length ==0 || sthirddot.length > 3)
	{
		return false;
	}

	var last = thirddot.substr(thirddot.indexOf(".")+1,thirddot.length);
	if(last.length ==0 || last.length > 3)
	{
		return false;
	}


 	return true;
}
 
function funNoSpecialChar(sValue)
{
	
	var nLoop=0;
	var nLength=sValue.length;
	for(nLoop=0;nLoop<nLength-1;nLoop++)
	{
		cChar=sValue.charAt(nLoop);
		if(! ( ((cChar>= "A") && (cChar <= "Z")) || ((cChar >= "a") && (cChar <= "z")) || ((cChar >= "0") && (cChar <= "9")) ) )
		{
			alert(cChar)
			return false;
		}
	}
	return true;
} 
 

function funFile(sValue)
{
	var nLength=sValue.length;
	var val = sValue.substr(sValue.indexOf(".")+1,nLength);
	if(val.length != 3)
 	{
 		return false;
 	}
 	if(val != "txt")
 	{
 		return false;
 	}
	 return true;
 }
 

function funDate(sValue)
{
	// Checks for the following valid date formats:
	// MM/DD/YY   MM/DD/YYYY   MM-DD-YY   MM-DD-YYYY
	// Also separates date into month, day, and year variables 

	var datePat = /^(\d{1,2})(\/|-)(\d{1,2})\2(\d{2}|\d{4})$/;

	// To require a 4 digit year entry, use this line instead:
	// var datePat = /^(\d{1,2})(\/|-)(\d{1,2})\2(\d{4})$/;

	var matchArray = sValue.match(datePat); // is the format ok?
	if (matchArray == null)
	{
		msgString ="Date is not in a valid format.\n Solution:Please Enter Date in any of the following formats \n mm-dd-yyyy ,mm-dd-yy"
		return false;
	}
	month = matchArray[1]; // parse date into variables
	day = matchArray[3];
	year =parseInt(matchArray[4]);
	if (month < 1 || month > 12)
	{ 
		// check month range
		msgString ="Month must be between 1 and 12."

		return false;

	}

	if (day < 1 || day > 31)
	{
		msgString="Day must be between 1 and 31."

		return false;
	}
	if ((month==4 || month==6 || month==9 || month==11) && day==31)
	{
		msgString="Month "+month+" doesn't have 31 days!"
		return false;
	}
	if (month == 2)
	{
		// check for february 29th
		var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
		if (day>29 || (day==29 && !isleap))
		{
			msgString ="February of Year" + year + " doesn't have " + day + " days!"
			return false;
		}
	}
		return true;  // date is valid
}
function funName(sValue,sthis)
{
	var validChars="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz. ";
	var nLoop=0;
	var nLength=sValue.length;
	for(nLoop=0;nLoop<(nLength-1);nLoop++)
	{
		cChar=sValue.charAt(nLoop);
		if (validChars.indexOf(cChar)==-1)
		{
			alert('Please enter Alphabets only');
			sthis.focus();
			return false;
		}
	}
	return true;
}

function funNumber(sValue)
{
	var nValue=parseInt(sValue);
	nValue=nValue+"";

	if ((sValue != nValue) || nValue <0)
	{
		return false;
	}
	return true;
}

function funHour(sValue)
{
	for(i=0;i<sValue.length;i++)
			if(isNaN(sValue.substr(i,1)))
			return false;
	

	if(parseInt(sValue)<0 || parseInt(sValue)>12)
		return false;

	return true;
}

function funMin(sValue)
{
	for(i=0;i<sValue.length;i++)
			if(isNaN(sValue.substr(i,1)))
			return false;
	

	if(parseInt(sValue)<0 || parseInt(sValue)>59)
		return false;

	return true;
}

function funNumaricchk(sValue,sthis)
{
	var validChars="0123456789 ";
	var nLoop=0;
	var nLength=sValue.length;
	for(nLoop=0;nLoop<nLength;nLoop++)
	{
		cChar=sValue.charAt(nLoop);
		if (validChars.indexOf(cChar)==-1)
		{
			alert('Please enter Numeric Values only');
			sthis.focus();
			return false;
		}
	}
	return true;
}

function funZip(sValue)
{	
	var validChars="0123456789 ";
	var nLoop=0;
	var nLength=sValue.length;
	for(nLoop=0;nLoop<nLength;nLoop++)
	{
		cChar=sValue.charAt(nLoop);
		if (validChars.indexOf(cChar)==-1)
		{
			return false;
		}
	}
	return true;
}

function funEmail(sValue) 
{	
	
	var s="";
	invalidChars = "' /:,;";
	if (sValue == "")
	{
		return false;
	}

	for (i = 0; i< invalidChars.length; i++)
	{
		badChar = invalidChars.charAt(i)
		if (sValue.indexOf(badChar,0) != -1)
		{
			msgString = "You can't use following characters " + invalidChars +" in your Email address."
			return false;
		}
	}
	atPos = sValue.indexOf("@",1)
	if (atPos == -1)
	{
	      
		msgString = "You need to provide your Email UserId. i.e  your email should be in this format info@ezcommerceinc.com ."
		return false;
	}
	if (sValue.indexOf("@",atPos+1) != -1)
	{
       		msgString ="The Email address you have provided does not have @ symbol. Please enter valid Email address."
		return false;
	}

	periodPos = sValue.lastIndexOf(".")
	if (periodPos == -1)
	{
		msgString ="The Email address you have provided does not have .com or .net etc. Please provide a valid Email address."
		
		return false;
	}
	if (! ( (periodPos+3 == sValue.length) || (periodPos+4  == sValue.length) ))
	{
		msgString ="The Email address you have provided does not have .com or .net etc. Please provide a valid Email address."
		return false;
	}
	return true;
}

function funEmails(sValue) 
{
	var obj=sValue.split(",");
	
	for(var i=0;i<obj.length;i++)
	{
		
		if((obj[i].indexOf("@")>=0) || ((obj[i].indexOf(".")>=0)))
		{
			
			if(! funEmail(obj[i]))
			{
				return false;
			
			}
		}
	}
	return true;
}

function changeChar(sValue)
{
		fIndex=sValue.indexOf("-")
		if(fIndex != -1)
		{
			sValue1=sValue.substring(0,fIndex);
			sValue2=sValue.substring(fIndex+1,sValue.length);
			sValue=sValue1+"/"+sValue2;
			sValue=changeChar(sValue);

		}
	return sValue;
}
	
function chkDates(Field1,Field2)
{ 
		Field1=eval(Field1)
		Field2=eval(Field2)

				
		FieldName1=Field1.name
		FieldName2=Field2.name
	
		FieldValue1=Field1.value
		FieldValue2=Field2.value


		
		FieldValue1=changeChar(FieldValue1);
		FieldValue2=changeChar(FieldValue2);

		d1= new Date(FieldValue1);
		d2= new Date(FieldValue2);
	
		if(d1.getYear()<100)
		{
			d1.setYear(2000+d1.getYear())
		}
		if(d2.getYear()<100)
		{
			d2.setYear(2000+d2.getYear())
		}

	
		if(d1>=d2)
		{
			alert(FieldName1 + "     must be always before   "  + FieldName2)
			Field1.focus();
			return false;
		}


return true;		
		
}




function funCheckFormFields(formName,FieldNames,CheckType,Messages)
{	

	var nTotalFields=formName.length;
	for (nOuterLoop=0;nOuterLoop<nTotalFields;nOuterLoop++)
	{		
		sField=formName.elements[nOuterLoop];
		sFieldName=sField.name;
		sFieldName=sFieldName.toUpperCase();
		nFieldPos=-1;
		sField.value=funTrim(sField.value);
		
		for(nInnerLoop=0;nInnerLoop<FieldNames.length;nInnerLoop++)
		{	
			sCheckFieldName=FieldNames[nInnerLoop];
			sCheckFieldName=sCheckFieldName.toUpperCase();
			
			if (sCheckFieldName==sFieldName)
			{	
				nFieldPos=nInnerLoop;
				break;
			}	
		}

		if (nFieldPos != -1)
		{	
			sCheckType=CheckType[nFieldPos];
			sCheckType=sCheckType.toUpperCase();
			bValid="Y";
			if (sCheckType.charAt(0)=="M")
			{	
				if (funTrim(sField.value)=="")
				{
					bValid="N";
				}
			}
			else
			{
				if (funTrim(sField.value)=="")
				{
					
					bValid="P";
				}
			}
			
			if(bValid=="Y")
			{				
				sCheckType=sCheckType.substr(1,sCheckType.length);
				msgString="";
				switch (sCheckType)
				{
					case "NUMBER": 	bRetValue=funNumber(funTrim(sField.value));
							if (! bRetValue)
							{	
								bValid="N";
							}	
							break;
							
					case "NAME": 
							bRetValue=funName(sField.value);
							if (! bRetValue)
							{
								bValid="N";
							}
							break;
							
					case "DATE":	
							bRetValue=funDate(funTrim(sField.value));
							if (! bRetValue)
							{
								bValid="N";
							}
							break;
							
					case "NUMA":	bRetValue=funNumaricchk(sField.value);
							if(! bRetValue)
							{
								bValid="N";
							}
							break;
							
					case "ZIP":	bRetValue=funZip(sField.value);
							if(! bRetValue)
							{
								bValid="N";
							}
							break;

					case "HOUR":	bRetValue=funHour(sField.value);
							if(! bRetValue)
							{
								bValid="N";
							}
							break;
							
					case "MIN":	bRetValue=funMin(sField.value);
							if(! bRetValue)
							{
								bValid="N";
							}
							break;
							
					case "EMAIL":	bRetValue=funEmail(sField.value);
							if(! bRetValue)
							{
								bValid="N";
								sField.focus();
							}
							break;
							
					case "EMAILS":	
							bRetValue=funEmails(sField.value);
							if(! bRetValue)
							{
								bValid="N";
								sField.focus();
							}
							break;
							
                                        case "PK"  : 	if(sField.value!="")
                            			        {
                                   		         	bRetValue=finalfun(sField);
                                   		         	if(!bRetValue)
                                   			 	{  
							 		bValid="N";
							 		sField.value="";
							 		sField.focus();
                                   			 	}
                                  		         
                                                          }
						          break;  
						          
                                        case "IPADDRESS":  if(sField.value!="")
                                        		   {
							         bRetValue=funIPaddress(sField.value);
							         if(!bRetValue)
							 	 {  
									 bValid="N";
									 sField.value="";
									 sField.focus();
							 	 }
							    }
							    break;  
                                                            
                                         case "NOSPECIALCHAR":	bRetValue=funNoSpecialChar(sField.value);
								if(! bRetValue)
								{	
									bValid="N";
								}
								break;		                   
                                        case "MFILE":                    
                                        
                                        		if(sField.value!=""){
								bRetValue=funFile(sField.value);
								if(!bRetValue)
								{  
									 bValid="N";
									 sField.value="";
									 sField.focus();
								 }
							   }
																				
                                                            break;  
                                                            
                                        
					case "NULL":	sValue=funTrim(sField.value);
							if(sValue=="")
							{
								bValid="N";
								sField.focus();
							}
							else
							{
								c=sValue.indexOf("'")
								if(c!=-1)
								   { 	
									//alert(" '  is Invalid Character")
									msgString=" '  is Invalid Character";
									 sField.focus();
									bValid="N";
								   }
								   else
								   {
									c=sValue.indexOf("\"")
									if(c!=-1)
									{
										msgString=" \" is Invalid Character";
										bValid="N";
										sField.focus();
									}
								   }

							}
							
							break;


				}
			}
		
		
		if (bValid=="N")
		{	if(msgString!="")
			{	
			   
                           alert(msgString);
                        }   
                        else
                   	{
                              sField.focus();
			     alert(Messages[nFieldPos]);
			 }  
                             
                       return false;
		}
		else
		{
			c=sField.value.indexOf("'")
			if(c!=-1)
		      { 	
				alert(" '  is Invalid Character")
				return false
 		 	}

		}
	}
}
	return true;
}





function Ltrim(name2)
{

var count=0,count1=0,i=0;
var inter=name2;
var num1;
	
	while(count1<inter.length)
	{
		if(inter.charAt(i)==" ")
		{	
			
			count=count+1;	
			i++;
		}
		count1=count1+1;
	}
	num1=inter.substr(count,inter.length);
	
return num1;
}
	

	function Rtrim(name3)
{
	
	var inter =name3.value;
	var num;
	i=inter.length-1;
	count=inter.length-1;
	count1=inter.length-1;
	
	while(count1>0)
	{
		if(inter.charAt(i)==" ")
		{	
			//alert(""+i);
			count=count-1;	
			i--;
		}
		count1=count1-1;
	}
	
	 num=inter.substr(0,count+1);
	
	return num;	
}


function finalfun(name4){

var res=Rtrim(name4);


var res1=Ltrim(res);

var final1=middlesp(res1);

return final1;	
}
function middlesp(name)
{
	var num=name;
	var len=num.length;
	var i;
	var flag=1;
	if(num.length!="")
	{
		for(i=0;i<len;i++)
		{
			if(num.charAt(i)==" ")
			{
			alert("u can't give space in the primary key");
			flag=0;
			break;
			}
		}
		if(flag==1)
		{
			return true;	
		}	
		else
			return false;
	}
	else
        {
		alert("first enter the skill code");
		return false;
        }
}



function selectAll()
	{
	var chkLen=document.myForm.chk1.length
	selected=!selected
	if(isNaN(chkLen))
		{
			document.myForm.chk1.checked=selected
		}
	else
		{
		for(i=0;i<chkLen;i++)
			document.myForm.chk1[i].checked=selected
		}
	}


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
		msgString ="Date is not in a valid format.\n Solution:Please Enter Date in any of the following formats \n mm-dd-yyyy ,mm-dd-yy or mm/dd/yy or mm/dd/yyyy"
		return false;
	}
	month = matchArray[1]; // parse date into variables
	day = matchArray[3];
	year =parseInt(matchArray[4]);
	
	
	if (day < 1 || day > 31)
	{
		msgString="Day must be between 1 and 31."

		return false;
	}
	if (month < 1 || month > 12)
	{ 
		// check month range
		msgString ="Month must be between 1 and 12."
		return false;

	}
	/*if (year < 1900  || year > 2050)
	{ 
		// checkYear range
		msgString="Year must be between 1900  and 2050."
		return false;

	}*/

	if ((month==4 || month==6 || month==9 || month==11) && day==31)
	{
		msgString="Month "+month+" doesn't have 31 days!"
		return false
	}
	if (month == 2)
	{
		// check for february 29th
		var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
		if (day>29 || (day==29 && !isleap))
		{
			if (year<100)
			{
			  year=year+2000;
			}
			msgString ="February of Year" + year + " doesn't have " + day + " days!"
			return false;
		}
	}
		return true;  // date is valid
}
function funName(sValue)
{
	var validChars="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz. ";
	var nLoop=0;
	var nLength=sValue.length;
	for(nLoop=0;nLoop<nLength-1;nLoop++)
	{
		cChar=sValue.charAt(nLoop);
		if (validChars.indexOf(cChar)==-1)
		{
			return false;
		}
	}
	return true;
}
function funUserID(sValue)
{
	var validChars="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
	var validStartChar = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
	var nLoop=0;
	
	if(validStartChar.indexOf(sValue.charAt(nLoop))==-1)
	{
		return false;
	}
	
	var nLength=sValue.length;
	for(nLoop=0;nLoop<nLength-1;nLoop++)
	{
		cChar=sValue.charAt(nLoop);
		if (validChars.indexOf(cChar)==-1)
		{
			return false;
		}
	}
	return true;
}


function funNumber(sValue)
{
	var nValue=parseInt(sValue);
	nValue=nValue+"";
	if ((sValue != nValue) || nValue < 0)
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

function funTele(sValue)
{
	var validChars="0123456789()-+ ";
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

function funZip(sValue)
{	
	var validChars="0123456789";
	var nLoop=0;
	var nLength=sValue.length;
	if(nLength!=6)
	{
		return false;
	}
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
{	var s=""
	invalidChars = "' /:,;"
	if (sValue == "")
	{
		//alert("You must provide your Email address.")
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
		msgString = "You need to provide your Email UserId. i.e  your email should be in this format info@EzCommerceInc.com ."
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

function changeChar(sValue)
{
		fIndex=sValue.indexOf("-")
		if(fIndex != -1)
		{
			sValue1=sValue.substring(0,fIndex)
			sValue2=sValue.substring(fIndex+1,sValue.length)
			sValue=sValue1+"/"+sValue2
			sValue=changeChar(sValue)

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

		if(d1 > d2)
		{
			alert(FieldName1 + "     must be always before   "  + FieldName2)
			return false;
		}
		

	return true;		
		
}


function chkDateValues(sValue1,sValue2,aMessage)
{

		sValue1=changeChar(sValue1);
		sValue2=changeChar(sValue2);

		d1= new Date(sValue1);
		d2= new Date(sValue2);
	
		if(d1.getYear()<100)
		{
			d1.setYear(2000+d1.getYear())
		}
		if(d2.getYear()<100)
		{
			d2.setYear(2000+d2.getYear())
		}

	
		if(d1>d2)
		{
			alert(aMessage)
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
		if(sField.type=="text")
		{
			sField.value=funTrim(sField.value);
		}
				
		
			
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
					case "NUMBER": 	bRetValue=funNumber(sField.value);
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
					case "PHONE":	bRetValue=funTele(sField.value);
								if(! bRetValue)
								{
									bValid="N";
								}
								break;
					case "ZIP":		bRetValue=funZip(sField.value);
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
					case "MIN":		bRetValue=funMin(sField.value);
								if(! bRetValue)
								{
									bValid="N";
								}
								break;
					case "EMAIL":	bRetValue=funEmail(sField.value);
								if(! bRetValue)
								{
									bValid="N";
								}
								break;			
					case "NULL":	sValue=funTrim(sField.value);
								if(sValue=="")
								{
									bValid="N";
								}
								else
								{
									c=sField.value.indexOf("'")
									if(c!=-1)
								      { 	
										alert(" '  is Invalid Character")
 								 		bValid="N";
									}
 
								}
								break;


				}
			}
		
		
		if (bValid=="N")
		{	if(msgString!="")
				alert(msgString);
			else
				alert(Messages[nFieldPos]);
			sField.focus();
			return false;
		}
		else
		{
			c=sField.value.indexOf("'")
			if(c!=-1)
		      { 	
				alert(" '  is Invalid Character")
 		 	}

		}
	}
}
	return true;
}
//TO CHECK VALUES IN A SELECT BOXES

function selselect(j)
{
	var one=j.split(",");	
	Length=eval("document.myForm."+one[0]+".options.length");
	for(var k=0;k<Length;k++)
	{
		if(eval("document.myForm."+one[0]+".options[k].value")==one[1])
		{			
			eval("document.myForm."+one[0]+".options[k].selected=true")
			 break;
		}
	}

}
//TO CHECK MANDATORY FOR SELECT BOXES

function mselect(j)
{
	var one=j.split(",");	
	
	if(eval("document.myForm."+one[0]+".selectedIndex")==0)
	{
	alert(one[1]);
 	return false;
	}
	else{
	return true;
	}
}

function autoDuration(fod,tod)
{
	
        var findex=fod.indexOf('/');
	var mm1=fod.substring(0,findex);
  	fod=fod.substring(findex+1);
  	findex=fod.indexOf('/');	
        var dd1=fod.substring(0,findex);
        fod=fod.substring(findex+1);
  	var yy1=fod;
        var tindex=tod.indexOf('/');
	var mm2=tod.substring(0,tindex);
  	tod=tod.substring(tindex+1);
  	tindex=tod.indexOf('/');	
        var dd2=tod.substring(0,tindex);
        tod=tod.substring(tindex+1);
  	var yy2=tod;
	var dmon;
	var imonth;
	if(parseInt(mm2) >= parseInt(mm1))
	{	
		dmon=(parseInt(mm2)-parseInt(mm1));	
		imonth=mm2;
	}
	else
	{
		dmon=(parseInt(mm1)-parseInt(mm2));	
		imonth=mm1;
	}
	var dday;
	if(parseInt(dd1) >= parseInt(dd2))
	{
		dday=(parseInt(dd1)-parseInt(dd2))
	}
	else
	{
		dday=(parseInt(dd2)-parseInt(dd1))
	}
	var dyr;
	var iyear;
	if(yy1>=yy2)
	{
		dyr=(yy1-yy2);	
		iyear=yy2;
	}
	else
	{
		dyr=(yy2-yy1);
		iyear=yy1;
	}
	var i;
	var tdays1=0;
	for(i=0;i<dyr;i++)
	{		
		var yday=0;
		var yr=iyear;
		if(((yr % 4 == 0) && (yr % 100 != 0 || yr % 400 == 0)))
		{
			yday=366;
		}
		else
		{	
			yday=365.25;
		}
		yr=yr+1;
		tdays1=tdays1+yday;
	} 
	var j;
	var k;
	var tdays2=0;
	for(j=0;j<dmon;j++)
	{		
		var mday=0;
		var mn=imonth;
		if(mn==2)
		{
			if(((iyear % 4 == 0) && (iyear % 100 != 0 || iyear % 400 == 0)))
			{
				mday=29;
			}
			else
			{
				mday=28;
			}
		}	
		else if((mn==4)||(mn==6)||(mn==9)||(mn==11))
		{
			mday=30;
		}
		else 
		{
			mday=31;
		}	
		mn=mn+1;		
		tdays2=tdays2+mday;

	} 
	var tdays3=0;
	tdays3=dday;
	var tdays11=0;
	if(parseInt(mm1)>parseInt(mm2))
	{
		if(parseInt(tdays2)<parseInt(tdays1))
		{
			tdays11=(tdays1-tdays2);
		}
		else
		{			
			tdays11=(tdays2-tdays1);
		}
	}
	else if(parseInt(mm1)<parseInt(mm2))
	{
		tdays11=(tdays1+tdays2);
	}
	else
	{
		tdays11=tdays1;
	}
	var tdays=0;
	if(parseInt(dd1) > parseInt(dd2))
	{
		tdays=(tdays11+tdays3);
	}
	else if(parseInt(dd1) < parseInt(dd2))
	{
		if(parseInt(tdays3)<parseInt(tdays11))
		{
			tdays=(tdays11-tdays3);
		}
		else
		{
			tdays=(tdays3-tdays11);
		}
	}
	else
	{
		tdays=tdays11;
	}
	return tdays;
}



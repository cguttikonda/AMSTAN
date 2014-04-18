function trim( inputStringTrim) 
{
	fixedTrim = "";
	lastCh = " ";
	for( x=0;x < inputStringTrim.length; x++)
	{
		ch = inputStringTrim.charAt(x);
		if ((ch != " ") || (lastCh != " ")) 
		{ fixedTrim += ch; }
		lastCh = ch;
	}
	if (fixedTrim.charAt(fixedTrim.length - 1) == " ") 
	{
		fixedTrim = fixedTrim.substring(0, fixedTrim.length - 1); 
	}
	return fixedTrim
} //end trim

function isDate(sValue) 
{
	// Checks for the following valid date formats:
	// MM/DD/YY   MM/DD/YYYY   MM-DD-YY   MM-DD-YYYY
	// Also separates date into month, day, and year variables 

	// To require a 2 digit year entry, use this line instead:
	//var datePat = /^(\d{1,2})(\/|-)(\d{1,2})\2(\d{2}|\d{4})$/;

	// To require a 4 digit year entry, use this line instead:
	 var datePat = /^(\d{1,2})(\/|-)(\d{1,2})\2(\d{4})$/;

	var matchArray = sValue.match(datePat); // is the format ok?
	if (matchArray == null)
	{
		msgString ="Date is not in a valid format.";
		return false;
	}
	month = matchArray[1]; // parse date into variables
	day = matchArray[3];
	year =parseInt(matchArray[4]);
	if (month < 1 || month > 12)
	{ 
		// check month range
		msgString ="Month must be between 1 and 12.";
		return false;
	}

	/*if (year < 1900  || year > 2050)
	{ 
		// checkYear range
		msgString="Year must be between 1900  and 2050.";
		return false;
	}*/
	if (day < 1 || day > 31)
	{
		msgString="Day must be between 1 and 31.";
		return false;
	}
	if ((month==4 || month==6 || month==9 || month==11) && day==31)
	{
		msgString="Month "+month+" doesn't have 31 days!";
		return false;
	}
	if (month == 2)
	{
		// check for february 29th
		var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
		if (day>29 || (day==29 && !isleap))
		{
			msgString ="February of Year" + year + " doesn't have " + day + " days!";
                        return false;
		}
	}
		return true;  // date is valid
} //end isDate

function VerifyDate( field, form ) {
	var rdate;

	//=============================================================
	//TBD: ********* Once the isDate function is implemented. *****
	// Uncomment all the below commented lines
	//=============================================================
	if (form == undefined)
		form = 0
	rdate = document.forms[form].elements[field].value;
	rdate = trim(rdate);
      if ( rdate == '' )
	{
		alert('Required Date cannot be empty');
		document.forms[form].elements[field].select();
		document.forms[form].elements[field].focus();
		document.returnValue = false;
	}
	else
	{
		if ( !isDate(rdate ) )
		{
			alert("Date Format Wrong")
			document.forms[form].elements[field].select();
			document.forms[form].elements[field].focus();
			document.returnValue = false;
		}
		else
		{
			//document.forms[0].elements['CheckBox_' + i].checked = true;
			document.returnValue = true;
		}
	} //end if
}


function rqDate()
{
		if ( !isDate(document.forms[0].REQDATE.value ) )
		{
			alert("Date Format Wrong")
			document.forms[0].elements['REQDATE'].select();
			document.forms[0].elements['REQDATE'].focus();
			document.returnValue = false;
		}
		else
		{
			//document.forms[0].elements['CheckBox_' + i].checked = true;
			document.returnValue = true;
		}
}

function reloadPage(){
	tc1 = document.forms[0].elements['TotalCount'].value;
	tc = tc1 - 1;
	myurl = document.URL;
	index = myurl.indexOf(".jsp");
 	newurl = myurl.substring(0, index);
	mUrl1 =  newurl + ".jsp?";
	mUrl2 = "sCount=1";    // + document.forms[0].elements['TotalCount'].value;
	mUrl3 = "&sMat=" + document.forms[0].elements['MATERIAL_' + tc].value;
	mUrl4 = "&sQty=" + document.forms[0].elements['ORDER_' + tc].value;
	mUrl5 = "&sDate=" + document.forms[0].elements['DATE_' + tc].value;
	mUrl =  mUrl1 + mUrl2 + mUrl3 + mUrl4 + mUrl5;
	parent.frames['display'].location.href = mUrl;
}

function setAction(){
	document.forms[0].action = "../SalesOrder/ezsoCartUpdate.jsp";
	document.returnValue = true;
}
function VerifyNum( i ) {
	var quant;
	quant = document.forms[0].elements['ORDER_' + i].value;
	quant= trim(quant);
	if (isNaN(quant) || (quant == ""))
	{
		//alert("Quantity must be a number");
		document.forms[0].elements['ORDER_' + i].select();
		document.forms[0].elements['ORDER_' + i].focus();
		document.returnValue = false;
	}
	else
	{
		iquant = parseInt(quant,10);
		alert( iquant );
		if (iquant > 0)
			document.returnValue = true;
		else 
		{
			alert("Quantity must be greater than zero");
			document.forms[0].elements['ORDER_' + i].select();
			document.forms[0].elements['ORDER_' + i].focus();
			document.returnValue = false;
		}
	}
}

function CheckCart() {
	var pCount, ponum;
	pCount = document.forms[0].elements['TotalCount'].value;
	ponum = document.createSO.PONO.value;
	if (pCount < 2){
		alert("Add Line Items Before Creating Sales Order");
		document.returnValue = false;
	}
	else{
		if (ponum == ""){
		alert("Enter PO Number Before Creating Sales Order");
		document.returnValue = false;
		}
		else{
			document.returnValue = true;
		}
	}
}

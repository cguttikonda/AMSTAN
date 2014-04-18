function isValidChar (c)
{   return ( ((c >= "A") && (c <= "Z")) || ((c >= "a") && (c <= "z")) || ((c >= "0") && (c <= "9")) )
}

function checkKey(s)
{
    var i;
    // Search through string's characters one by one
    // until we find a non-numeric character.
    // When we do, return false; if we don't, return true.

    for (i = 0; i < s.length; i++)
    {
        // Check that current character is number.
        var c = s.charAt(i);

        if (!isValidChar(c)) return false;
    }

    // All characters are numbers or alphabets.
    return true;

}

function isSpecial(s)
{   var i;

    // Search through string's characters one by one
    // until we find a non-numeric character.
    // When we do, return false; if we don't, return true.
    var a = '';
    for (i = 0; i < s.length; i++)
    {
        // Check that current character is number.
        var c = s.charAt(i);

        if (c == "\'")
        {
           a = a+"'"+c;
        }
        else
        {
           a = a + c;
        }
    }
    //return new string
    return a;
}

function trim( inputStringTrim) {
fixedTrim = "";
lastCh = " ";
for( x=0;x < inputStringTrim.length; x++)
{
   ch = inputStringTrim.charAt(x);
 if ((ch != " ") || (lastCh != " ")) { fixedTrim += ch; }
lastCh = ch;
}
if (fixedTrim.charAt(fixedTrim.length - 1) == " ") {
fixedTrim = fixedTrim.substring(0, fixedTrim.length - 1); }
return fixedTrim
}

/*function CheckValue() {

	var Key = document.forms[0].Code.value;
	var Desc = document.forms[0].Desc.value;
      Key = trim(Key);
      Desc = trim(Desc);
      document.forms[0].Desc.value = Desc;

	if((Key == ""))
		{
		alert("Please enter Area Code");
        	document.forms[0].Code.focus();
		document.returnValue = false;
		}
	else
		{
		if(document.forms[0].SystemNumber.selectedIndex==0)
			{
			alert("Please Select System");
            		document.forms[0].SystemNumber.focus();			
			document.returnValue = false;
			}
		else
			{
			if(Desc=="")
				{
				alert("Please enter Description");
			        document.forms[0].Desc.focus();
				document.returnValue = false;
				}
			else
				{
				document.returnValue = true;
				}			
			}
	}
	  if(document.returnValue==true)
	  {
      	if ( !checkKey( Key ) )
      	{
      	    alert('Area Code should be alphabets or numbers');
      	    document.returnValue = false;
      	    document.forms[0].Code.focus();
      	}
      }
}*/


function CheckValue()
{
	var FieldNames=new Array;
	var CheckType=new Array;
	var Messages=new Array;
		FieldNames[0]="Code";
		CheckType[0]="MNull";
		Messages[0]="Please enter Area Code";
		FieldNames[1]="Desc";
		CheckType[1]="MNull";
		Messages[1]="Please enter Description";
		if(funCheckFormFields(document.myForm,FieldNames,CheckType,Messages))
		{
			if(document.forms[0].SystemNumber.selectedIndex==0)
			{
				alert("Please Select System");
            			document.forms[0].SystemNumber.focus();			
				return false;
			}
			else
			{
				return true;
			}
		}
		else
		{
			return false;
		}
}


function checkAll() {
	var form = document.forms[0]
	var tFlag ="true"
	var tName
	var tValue

	for (var i = 0; i < form.elements.length; i++){
		tName=form.elements[i].name
		tValue=form.elements[i].value

		if(tName =="Key" ||tName =="Desc"){
			tFlag = isEmpty(tValue,tName)

			if(tFlag ==true){
				alert ("Enter a value for your " + tName )
				eval("document.forms" + "[" + "0" +"]" +"." + tName +".value" + "=" + "''")
				eval("document.forms" + "[" +"0" + "]" +"." + tName +".focus()")
				return false
				break
			}
		}//end if
	}//end for

	if(tFlag==true){
		document.returnValue = true;
	}else{
		if(tFlag ==false){
			document.returnValue = false;
		}
	}//end if
}//end function


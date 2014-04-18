function isDigit(c)
{   
	return ((c >= "0") && (c <= "9"))
}

function isnum(s){
	var tBoolean
	var i
	for (i = 0; i < s.length; i++){  
		// Check that current character is number.
		var c = s.charAt(i);
		if(isDigit(c)){
			tBoolean ="Y"
		}else{
			tBoolean ="N"
			break
		}
	}
		if(tBoolean =="Y"){
			return true
		}else{
			if(tBoolean =="N"){
				return false
			}
		}
}//end function

function isValidNumber(s,valuelength,fieldname)
{
	if (isEmpty(s)){
		if(fieldname == "phone11" || fieldname == "phone12" || fieldname == "phone13" ){
			alert("Please Enter your Work Phone number")
			return false
		}else{
			if(fieldname == "phone21" || fieldname == "phone22" || fieldname == "phone23"){
				alert("Please Enter your Home Phone number")
				return false
			}else{
				alert ("Enter a value for your " + fieldname )
				eval("document.forms" + "[" + "0" +"]" +"." + fieldname +".value" + "=" + "''") 
				eval("document.forms" + "[" +"0" + "]" +"." + fieldname +".focus()")
				return false
			}//end if
		}//end if
	}//end if for isEmpty
						
	if(!(isnum(s))){
		if(fieldname == "phone11" || fieldname == "phone12" || fieldname == "phone13" ){
			alert("Please Enter your Work Phone number")
			return false
		}else{
			if(fieldname == "phone21" || fieldname == "phone22" || fieldname == "phone23"){
				alert("Please Enter your Home Phone number")
				return false
			}else{
				alert ("Invalid "+ fieldname +", Please  enter a valid " + fieldname);
				eval("document.forms" + "[" + "0" +"]" +"." + fieldname +".value" + "=" + "''") 
				eval("document.forms" + "[" +"0" + "]" +"." + fieldname +".focus()")
				return false
			}//end if
		}//end if
	}//end if for isnum
	
	if(isnum(s)){	
		if( !(s.length == valuelength)){
			if(fieldname == "phone11" || fieldname == "phone12" || fieldname == "phone13" ){
			alert("Please Enter your Work Phone number")
				return false
			}else{
				if(fieldname == "phone21" || fieldname == "phone22" || fieldname == "phone23"){
					alert("Please Enter your Home Phone number")
					return false
				}else{
					alert (" Please check the number of digits in your " + fieldname +" it should be "+valuelength+" digits");
					eval("document.forms" + "[" + "0" +"]" +"." + fieldname +".value" + "=" + "''") 
					eval("document.forms" + "[" +"0" + "]" +"." + fieldname +".focus()")
					return false
				}//end if
			}//end if
		}//end if
	}//end if	

	return true

}//end function

function isLetter (c)
{   
	return ( ((c >= "a") && (c <= "z")) || ((c >= "A") && (c <= "Z")) || (c == " ") )
}

function isEmpty(s)
{
   return ((s == null) ||(s.length == 0))
}

function isAlphabetic(s,fieldname)
{   
	var i;
	if (isEmpty(s)){
		alert("Please enter a value in "+fieldname)
		eval("document.forms" + "[" + "0" +"]" +"." + fieldname +".value" + "=" + "''") 
		eval("document.forms" + "[" +"0" + "]" +"." + fieldname +".focus()")
		return false;
	}   

	for (i = 0; i < s.length; i++){   
		// Check that current character is letter.
		var c = s.charAt(i);

		if (!isLetter(c)){
			alert("Please enter a valid value in "+fieldname)
			eval("document.forms" + "[" + "0" +"]" +"." + fieldname +".value" + "=" + "''") 
			eval("document.forms" + "[" +"0" + "]" +"." + fieldname +".focus()")
			return false;
		}
	}//end for

	// All characters are letters.
	return true;
}//end function

function validateEmail(eMailstr,fieldname)
{
				if (eMailstr.length == 0){
						alert ("Please enter your E-mail address");
						return false;
				}
				if (eMailstr.indexOf("@") < 0){
						alert ("Invalid E-mail, Pl  enter a valid email");
						eval("document.forms" + "[" + "0" +"]" +"." + fieldname +".value" + "=" + "''") 
					        eval("document.forms" + "[" +"0" + "]" +"." + fieldname +".focus()")
						return false
				}
				if (eMailstr.indexOf(".") < 0){
						alert ("Invalid E-mail, Pl  enter a valid email");
						eval("document.forms" + "[" + "0" +"]" +"." + fieldname+".value" + "=" + "''") 
						eval("document.forms" + "[" +"0" + "]" +"." + fieldname +".focus()")
						return false
				}						
				if (eMailstr.indexOf(" ") >= 0){
						alert ("Invalid E-mail, Pl  enter a valid email");
						eval("document.forms" + "[" + "0" +"]" +"." + fieldname+".value" + "=" + "''") 
						eval("document.forms" + "[" +"0" + "]" +"." + fieldname +".focus()")
						return false
				}
				if (eMailstr.indexOf("@") == 0){
						alert ("Invalid E-mail, Pl  enter a valid email");
						eval("document.forms" + "[" + "0" +"]" +"." + fieldname+".value" + "=" + "''") 
						eval("document.forms" + "[" +"0" + "]" +"." + fieldname +".focus()")
						return false
				}
				if (eMailstr.indexOf(".") == 0){
						alert ("Invalid E-mail, Pl  enter a valid email");
						eval("document.forms" + "[" + "0" +"]" +"." + fieldname+".value" + "=" + "''") 
					  	eval("document.forms" + "[" +"0" + "]" +"." + fieldname +".focus()")
						return false
				}	
				if (eMailstr.charAt(eMailstr.length - 1) == ("@")){
						alert ("Invalid E-mail, Pl  enter a valid email");
						eval("document.forms" + "[" + "0" +"]" +"." + fieldname+".value" + "=" + "''") 
						eval("document.forms" + "[" +"0" + "]" +"." + fieldname +".focus()")
						return false
				}
				if (eMailstr.charAt(eMailstr.length - 1) == (".")){
						alert ("Invalid E-mail, Pl  enter a valid email");
						eval("document.forms" + "[" + "0" +"]" +"." + fieldname+".value" + "=" + "''") 
						eval("document.forms" + "[" +"0" + "]" +"." + fieldname +".focus()")
						return false
				}
				if (eMailstr.indexOf("@",(eMailstr.indexOf("@")+1)) >= 0){
						alert ("Invalid E-mail, Pl  enter a valid email");
						eval("document.forms" + "[" + "0" +"]" +"." + fieldname+".value" + "=" + "''") 
						eval("document.forms" + "[" +"0" + "]" +"." + fieldname +".focus()")
						return false
				}
				if (eMailstr.indexOf(",") >= 0){
						alert ("Invalid E-mail, Pl  enter a valid email");
						eval("document.forms" + "[" + "0" +"]" +"." + fieldname+".value" + "=" + "''") 
						eval("document.forms" + "[" +"0" + "]" +"." + fieldname +".focus()")
						return false
				}
				if (eMailstr.indexOf(":") >= 0){
						alert ("Invalid E-mail, Pl  enter a valid email");
						eval("document.forms" + "[" + "0" +"]" +"." + fieldname+".value" + "=" + "''") 
						eval("document.forms" + "[" +"0" + "]" +"." + fieldname +".focus()")
						return false
				}
				if (eMailstr.indexOf("chr(62)") >= 0){
						alert ("Invalid E-mail, Pl  enter a valid email");
						eval("document.forms" + "[" + "0" +"]" +"." + fieldname+".value" + "=" + "''") 
						eval("document.forms" + "[" +"0" + "]" +"." + fieldname +".focus()")
						return false
				}
				if (eMailstr.indexOf("chr(60)") >= 0){
						alert ("Invalid E-mail, Pl  enter a valid email");
						eval("document.forms" + "[" + "0" +"]" +"." + fieldname+".value" + "=" + "''") 
						eval("document.forms" + "[" +"0" + "]" +"." + fieldname +".focus()")
						return false
				}
				if (eMailstr.indexOf("chr(34)") >= 0){
						alert ("Invalid E-mail, Pl  enter a valid email");
						eval("document.forms" + "[" + "0" +"]" +"." + fieldname+".value" + "=" + "''") 
						eval("document.forms" + "[" +"0" + "]" +"." + fieldname +".focus()")
						return false
				}
				if (eMailstr.indexOf("(") >= 0){
						alert ("Invalid E-mail, Pl  enter a valid email");
						eval("document.forms" + "[" + "0" +"]" +"." + fieldname+".value" + "=" + "''") 
						 eval("document.forms" + "[" +"0" + "]" +"." + fieldname +".focus()")
						return false
				}
				if (eMailstr.indexOf(")") >= 0){
						alert ("Invalid E-mail, Pl  enter a valid email");
						eval("document.forms" + "[" + "0" +"]" +"." + fieldname+".value" + "=" + "''") 
						eval("document.forms" + "[" +"0" + "]" +"." + fieldname +".focus()")
						return false
				}
				if (eMailstr.indexOf("*") >= 0){
						alert ("Invalid E-mail, Pl  enter a valid email");
						eval("document.forms" + "[" + "0" +"]" +"." + fieldname+".value" + "=" + "''") 
						 eval("document.forms" + "[" +"0" + "]" +"." + fieldname +".focus()")
						return false
				}
				if (eMailstr.indexOf(";") >= 0){
						alert ("Invalid E-mail, Pl  enter a valid email");
						eval("document.forms" + "[" + "0" +"]" +"." + fieldname+".value" + "=" + "''") 
						 eval("document.forms" + "[" +"0" + "]" +"." + fieldname +".focus()")
						return false
				}
				if (eMailstr.indexOf("..") >= 0){
						alert ("Invalid E-mail, Pl  enter a valid email");
						document.forms[0].email.value =""
						 eval("document.forms" + "[" +"0" + "]" +"." + fieldname +".focus()")
						return false
				}
				if (eMailstr.indexOf("@.") >= 0){
						alert ("Invalid E-mail, Pl  enter a valid email");
						eval("document.forms" + "[" + "0" +"]" +"." + fieldname+".value" + "=" + "''") 
						eval("document.forms" + "[" +"0" + "]" +"." + fieldname +".focus()")
						return false
				}
				if (eMailstr.indexOf(".@") >= 0){
						alert ("Invalid E-mail, Pl  enter a valid email");
						eval("document.forms" + "[" + "0" +"]" +"." + fieldname+".value" + "=" + "''") 
						eval("document.forms" + "[" +"0" + "]" +"." + fieldname +".focus()")
						return false
				}
				if (eMailstr.indexOf(".",(eMailstr.indexOf("@")+2)) < 0){
						alert ("Invalid E-mail, Pl  enter a valid email");
						eval("document.forms" + "[" + "0" +"]" +"." + fieldname+".value" + "=" + "''") 
						eval("document.forms" + "[" +"0" + "]" +"." + fieldname +".focus()")
						return false
			}
	return true
}//end function
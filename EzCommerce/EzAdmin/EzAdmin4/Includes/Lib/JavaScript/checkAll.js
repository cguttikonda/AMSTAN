function checkAll() {
	var form = document.forms[0]
	var tFlag ="true"
	var tName
	var tValue
	var valuelength
	var tCardCompany
	var tCardNumber
	var tDate = new Date()
	var tMonth
	var tMonthSelected
	var DMonth
	var DDate
	var DYear

	for (var i = 0; i < form.elements.length; i++){
		tName=form.elements[i].name
		tValue=form.elements[i].value
		
		if(tName =="Company" ||tName =="BPDescription" ||tName =="ContactName"||tName =="WebAddress" ||tName=="City"||tName=="MemberID"||tName=="password"||tName=="password1"){
			tFlag = isAlphabetic(tValue,tName)
			if(tFlag ==false){
				break
			}
		}//end if

		if(tName =="Address1"){
			tFlag = isEmpty(tValue)
			if(tFlag == true){
				alert("Please Enter A Value For Address1")
				tFlag = false
				break
			}else{
				if(tFlag == true){
					tFlag = true
				}
			}//end if
		}//end if

		if(tName =="Email"){
			tFlag =validateEmail(tValue,tName)
			if(tFlag ==false){
				break
			}
		}

		if(tName =="Zip"|| tName =="Phone11" ||tName =="Phone12"||tName =="Phone13"||tName =="Phone21" ||tName =="Phone22"||tName =="Phone23"){ 
			switch(tName)
			{
			case "zipCode":
				valuelength = 5
			break
			case "phone11":
				valuelength = 3
			break
			case "phone12":
				valuelength = 3
			break
			case "phone13":
				valuelength =4
			break
			case "phone21":
				valuelength = 3
			break
			case "phone22":
				valuelength = 3
			break
			case "phone23":
				valuelength = 4
			break
			}//end switch

			tFlag =isValidNumber(tValue,valuelength,tName)
			if(tFlag ==false){
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
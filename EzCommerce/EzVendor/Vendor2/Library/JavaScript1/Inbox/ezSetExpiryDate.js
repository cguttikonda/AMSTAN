function CheckValue(){
if(document.myForm.ExpiryDate.value ==""){
alert("Plese enter the ExpiryDate ");
document.returnValue = false;
}
else{
document.returnValue = true;
}
	
}
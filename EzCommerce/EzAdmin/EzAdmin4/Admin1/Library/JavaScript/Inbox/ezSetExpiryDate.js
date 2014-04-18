function CheckValue(){
if(document.remDate.ExpiryDate.value ==""){
alert("Plese enter the ExpiryDate ");
document.returnValue = false;
}
else{
document.returnValue = true;
}
	
}
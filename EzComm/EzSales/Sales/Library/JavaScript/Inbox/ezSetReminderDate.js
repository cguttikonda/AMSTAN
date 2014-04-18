function CheckValue(){
if(document.myForm.ReminderDate.value ==""){
alert("Plese enter the AlertDate ");
document.returnValue = false;
}
else{
document.returnValue = true;
}
	
}

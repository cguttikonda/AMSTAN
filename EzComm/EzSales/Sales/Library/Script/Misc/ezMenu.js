function getAccDtl()
{
	document.menuForm.newsFilter.value="PS"	
	document.menuForm.action="../News/ezListNewsDash.jsp"
	Popup.showModal('headermodal');
	document.menuForm.submit()		
}	
function funClick(actionPage){
	//Popup.showModal('headermodal');
	document.menuForm.action = actionPage;
	document.menuForm.submit();
}

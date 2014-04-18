function showMessages(){
	myurl = document.URL;
	index = myurl.indexOf(".jsp");
 	newurl = myurl.substring(0, index);
	mUrl1 =  newurl + ".jsp?";
	mUrl2 = "msgFlag=" + document.myForm.newFlag.value;
	mUrl3 = "&FolderID=" + document.myForm.FolderID.value;
	mUrl4 = "&FolderName="+ document.myForm.FolderName.value;;
	mUrl =  mUrl1 + mUrl2 + mUrl3 + mUrl4;
	location.href= mUrl;
}
   function CheckSelect() {

	var pCount=0;
	var selCount=0;
	pCount = document.myForm.CheckBox.length;
	
        var cn=0;
        for(j=0;j<pCount;j++)
        {

           if(document.myForm.CheckBox[j].disabled)
           {

                  cn++;
           }
        }
          if(cn==pCount)
          {
             alert(urUnbDel_L);
             document.returnValue = false;
          }

	var i = 0;
	for ( i = 0 ; i < pCount; i++ ) {
		if(document.myForm.CheckBox[i].checked){
			selCount = selCount + 1;
		}
	}
	if(selCount<1){
		alert(plzSelMsgDel_L);
		document.returnValue = false;
	}else{
		document.myForm.DelFlag.value = 'Y';
		document.returnValue=true;
	}
}


function CheckSelectNew() {

	var pCount=0;
	var selCount=0;
	
	pCount = document.myForm.CheckBox.length;

	var i = 0;

	if(document.myForm.CheckBox.checked)
        {
	  selCount=selCount+1;
	}
	for ( i = 0 ; i < pCount; i++ )
	{
		if(document.myForm.CheckBox[i].checked)
		{
			selCount = selCount + 1;
		}
	}
	if(selCount<1){
		alert(plzSelMsgDel_L);
		document.returnValue = false;
	}else{

		document.myForm.DelFlag.value = 'Y';
		document.myForm.action="ezDelPersMsgs.jsp";
		setMessageVisible();
		document.myForm.submit();
	}
}
function CheckSelectForMove() {
	
	
	var pCount=0;
	var selCount=0;
	pCount = document.myForm.CheckBox.length;
	var cn=0;
        for(j=0;j<pCount;j++)
        {
		if(document.myForm.CheckBox[j].disabled)
		{
			cn++;
		}
	}
	var i = 0;
	if(document.myForm.CheckBox.checked)
		selCount=selCount+1;
	for ( i = 0 ; i < pCount; i++ ) {
		if(document.myForm.CheckBox[i].checked)
			selCount = selCount + 1;
	}
        if(document.myForm.ToFolder.length > 1)
	{
		if(document.myForm.ToFolder.selectedIndex!=0)
		{
			if(cn==pCount)
			{
				alert(unbMovNoFile_L);
             			document.returnValue = false;
          		}else{
				if(selCount<1){
					alert(plzSelMsgMov_L);
					document.returnValue = false;
	  			}else{
					document.myForm.DelFlag.value = 'N';
					document.myForm.action="ezDelPersMsgs.jsp";
					setMessageVisible();
					document.myForm.submit();
	   			}
           		}
         	}else{
             		alert(plzSelFolMov_L);
             		document.returnValue = false;
         	}
        }
	else
	{
		alert(curNoFold_L);
		document.returnValue = false;
	}
}

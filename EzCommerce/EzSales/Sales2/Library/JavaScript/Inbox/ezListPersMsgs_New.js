function showMessages()
	{
	myurl = document.URL;
	index = myurl.indexOf(".jsp");
 	newurl = myurl.substring(0, index);
	mUrl1 =  newurl + ".jsp?";
	mUrl2 = "msgFlag=" + document.ListPersMsgs.newFlag.value;
	mUrl3 = "&FolderID=" + document.ListPersMsgs.FolderID.value;
	mUrl4 = "&FolderName="+ document.ListPersMsgs.FolderName.value;;
	mUrl =  mUrl1 + mUrl2 + mUrl3 + mUrl4;
	location.href= mUrl;
	}
function CheckSelect() 
	{
	var pCount=0;
	var selCount=0;
	pCount = document.ListPersMsgs.TotalCount.value;
	var i = 0;
	for ( i = 0 ; i < pCount; i++ ) 
		{
		if(document.ListPersMsgs.CheckBox[i].checked)
			{
			selCount = selCount + 1;
			}
		}
	if(selCount<1)
		{
		alert("Select Message(s) Before Deleting From Pesonal Messages");
		document.returnValue = false;
		}
	else
		{
		document.ListPersMsgs.DelFlag.value = 'Y';
		document.returnValue = true;
		}
	}
   function CheckSelectForMove() 
   	{
	var pCount=0;
	var selCount=0;
	pCount = document.ListPersMsgs.TotalCount.value;
	var i = 0;
	for ( i = 0 ; i < pCount; i++ ) 
		{
		if(document.ListPersMsgs.CheckBox[i].checked)
			{
			selCount = selCount + 1;
			}
		}
	if(selCount<1)
		{
		alert("Select Message(s) From Pesonal Messages Before Move");
		document.returnValue = false;
		}
	else
		{
		document.ListPersMsgs.DelFlag.value = 'N';
		document.returnValue = true;
		}
	}

var subUser;
var subAuth;
function checkAuth()
{

	subUser = '<%=session.getValue("IsSubUser")%>'
	//alert("subUser:::::"+subUser)
	if(subUser=='Y')
	{
		subAuth = '<%=session.getValue("SuAuth")%>'
		if(subAuth=='VONLY')
		{
			alert("You are not authorised for this transaction.Please Contact administartor for any queries.")
			return false;

		}
		else
			return true;
	}
}

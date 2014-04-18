


function checkField()
{

var FieldNames1= new Array()
var CheckTypes1= new Array()
var Messages1= new Array()

var FieldNames2= new Array()
var CheckTypes2= new Array()
var Messages2= new Array()

var FieldNames3= new Array()
var CheckTypes3= new Array()
var Messages3= new Array()

var FieldNames4= new Array()
var CheckTypes4= new Array()
var Messages4= new Array()



	if(document.myForm.groupId.value=="")
 	{
		FieldNames1[0]="groupId"
    		CheckTypes1[0]="MNull"
    		Messages1[0]="Please enter group Id"
	}
	else
 	{
		FieldNames1[0]="groupId"
    		CheckTypes1[0]="MNospecialchar"
    		Messages1[0]="Group Id cannot contain spechial characters"
	}

		FieldNames1[1]="groupDesc"
    		CheckTypes1[1]="MNull"
    		Messages1[1]="Please enter group description"
		
		FieldNames1[2]="host"
		CheckTypes1[2]="MNull"
		Messages1[2]="Please enter  host"

   	if(document.myForm.from.value=="")
	{
		FieldNames1[3]="from"
		CheckTypes1[3]="MNull"
		Messages1[3]="Please enter from"

	}
	else
    	{
		FieldNames1[3]="from"
    		CheckTypes1[3]="MEmail"
		Messages1[3]="Please enter  from"
	}
		FieldNames1[4]="listener"
		CheckTypes1[4]="MNull"
		Messages1[4]="Please enter exception listener"

			FieldNames1[5]="logfile"
		      	CheckTypes1[5]="MNull"
			Messages1[5]="Please enter logfile"


	if(document.myForm.authRequired.checked )
	{
		FieldNames1[6]="user"
		CheckTypes1[6]="MNull"
		Messages1[6]="Please enter User Name"
		
		if(document.myForm.pass.value=="")
		{

			FieldNames1[7]="pass"
	     		CheckTypes1[7]="MNull"
	         	Messages1[7]="Please enter password"
		}
		else
		{
			FieldNames1[7]="pass"
	     		CheckTypes1[7]="MNospecialchar"
	        	Messages1[7]="Special characters are not allowed in password"
		
		 }
	}

			if(document.myForm.supportInMail.checked)
			{
				if(document.myForm.inPort.value=="")
				{
				FieldNames2[0]="inPort"
		   		CheckTypes2[0]="MNull"
		   		Messages2[0]="Please enter incoming mail port number"
				}
				else
				{
				FieldNames2[0]="inPort"
		   		CheckTypes2[0]="MNumber"
		   		Messages2[0]="Incoming port can contain only numbers"
				}
  			}

			if(document.myForm.supportOutMail.checked)
			{
				if(document.myForm.inPort.value=="")
				{
		           	FieldNames3[0]="outPort"
		   	   	CheckTypes3[0]="MNull"
		   	   	Messages3[0]="Please enter outgoing mail port number"
				}
				else
				{	           	
	        	   	FieldNames3[0]="outPort"
		   	   	CheckTypes3[0]="MNumber"
		   	   	Messages3[0]="Outgoing mail port can contain numbers only"
				}
	           	
			}

        	if(document.myForm.JMSEnabled.checked)
	        {
	        	FieldNames4[0]="destName"
			CheckTypes4[0]="MNull"
			Messages4[0]="Please enter topic name"

	        	FieldNames4[1]="destFactory"
			CheckTypes4[1]="MNull"
			Messages4[1]="Please enter destination factory"

	        	FieldNames4[2]="providerURL"
			CheckTypes4[2]="MNull"
			Messages4[2]="Please enter provider URL"
                	
	         	FieldNames4[3]="contextFactory"
	     		CheckTypes4[3]="MNull"
	         	Messages4[3]="Please enter context factory"
	         	

	      }

	funHeader();
	if(!(funCheckFormFields(document.myForm,FieldNames1,CheckTypes1,Messages1)))
		return false
	if(document.myForm.supportInMail.checked) funIncoming();
	if(!(funCheckFormFields(document.myForm,FieldNames2,CheckTypes2,Messages2)))
		return false
	if(document.myForm.supportOutMail.checked) funOutgoing();
	if(!(funCheckFormFields(document.myForm,FieldNames3,CheckTypes3,Messages3)))
		return false
	if(document.myForm.JMSEnabled.checked) funAsynchronous();
	if(!(funCheckFormFields(document.myForm,FieldNames4,CheckTypes4,Messages4)))
		return false

	document.myForm.action="ezAddSaveMailGroup.jsp";
	return true;

}


function funChange()
{
	if(document.myForm.inProtocol.value=="IMAP")
	{
		document.myForm.inPort.value="143";
	}
	if(document.myForm.inProtocol.value=="POP3")
	{
		document.myForm.inPort.value="110";
	}
}



	

	






	











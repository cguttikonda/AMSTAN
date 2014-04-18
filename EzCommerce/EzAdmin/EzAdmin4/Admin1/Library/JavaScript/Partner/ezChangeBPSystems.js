
function init()
 {
 
 	var InnerdivId1=document.getElementById("InnerBox1Div")
  	//var OuterdivId1=document.getElementById("OuterBox1Div")
  	if(InnerdivId1!=null)
 	{
 		myInit(2)
		if(getposition())
		{
			ScrollBox.show()
		}
	}

}

function selectSystems(Aval)
{
    var form = document.forms[0];
    var totCnt = document.myForm.TotalCount.value;
    var selBox = 0;

    for(i=0;i<totCnt;i++)
    {
        var newVal = form.elements['ChkSys_'+i].value;
        if ( Aval == newVal )
        {
            form.elements['ChkSys_'+i].checked = true;
        }
    }
}

function CHG(fieldname, cBox)
{
     var AreaBox = 'ChkSys_'+cBox;
     if ( document.forms[0].elements[AreaBox].value != null )
     {
	     document.forms[0].elements[AreaBox].checked = true;
     }

      var newField = fieldname+'_CHG';
	var form = document.forms[0];
	for (i = 0; i < form.elements.length; i++) {
	if (form.elements[i].type == "hidden"  )
            {
		  if ( form.elements[i].name == newField )
              {
               var getVal = form.elements[i].value;
               if ( getVal == "Y" ) {getVal = "N";} else {getVal = "Y";}
               form.elements[i].value = getVal;
               //alert(form.elements[i].name+ ' '+form.elements[i].value);
                 }
		}//End if
	}//End for
}

function checkAll()
{
    var form = document.forms[0];
    var totCnt = document.myForm.TotalCount.value;
    var areacnt = document.myForm.AreaCount.value;

    var selBox = 0;
    for(i=0;i<totCnt;i++)
    {
        if ( !form.elements['ChkSys_'+i].disabled )
        {
           if ( form.elements['ChkSys_'+i].checked )
           {
			selBox = 1;
                  break;
           }
        }
    }

    for(i=0;i<areacnt;i++)
    {
           if ( form.elements['OrgArea_'+i+'_CHG'].value == 'Y' )
           {
			selBox = 1;
                  break;
           }
	}

    if ( selBox == 0 )
    {
       alert('Select atleast one system or organization');
       document.returnValue = false;
    }
    else
    {
       document.returnValue = true;
    }

} //end checkAll

function myalert(){
	myurl = document.URL;
	index = myurl.indexOf(".jsp");
 	newurl = myurl.substring(0, index);
	mUrl1 =  newurl + ".jsp?";
	mUrl2 = "BusinessPartner=" + document.myForm.BusPartner.value;
	mUrl =  mUrl1 + mUrl2;
	location.href= mUrl;

}

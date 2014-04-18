function checkAreaBox(cBox)
{
     var AreaBox = 'ChkSys_'+cBox;
     document.forms[0].elements[AreaBox].checked = true;
}
function selectSystems(Aval,scnt)
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
            if ( i != scnt )
            {
            	form.elements['ChkSys_'+i].disabled = true;
            }
        }
    }
}

function checkAll() {
	var form = document.forms[0]
      var totCnt = document.myForm.TotalCount.value;
      var selBox = 0;
	for (i = 0; i < totCnt; i++) {
		if (form.elements['ChkSys_'+i].checked)
            {
                selBox = selBox + 1;
		}//End if
	}//End for
      if ( selBox == 0 )
      {
          alert("Select atleast one System or Organization");
          document.returnValue = false;
      }
      else
      {
	    document.returnValue = true;
      }
} //end checkAll
var tabHeadWidth=96

var tabHeight="55%"
var boxTop=0,boxLeft=0,boxWidth=0,addwidth=0;
tabHeadWidth=100/(100-tabHeadWidth);
var bversion;
x=window.navigator.userAgent;
if(window.navigator.appName =="Microsoft Internet Explorer")
	bversion=x.substring(  (x.indexOf("MSIE ")+4), x.indexOf(";",(x.indexOf(";")+1)) );
if (parseFloat(bversion)>=5.1)
	scrollAdj=0
else
	scrollAdj=15
if (!(window.navigator.appName =="Microsoft Internet Explorer"))
	scrollAdj=0
var leftAdj=0;
if(parent.document.forms.length==0)
leftAdj=9;

function scrollInit()
{
	headDiv=document.getElementById("theads");
	headTab=document.getElementById("tabHead");
	linesDiv=document.getElementById("InnerBox1Div");
	linesTab=document.getElementById("InnerBox1Tab");

	buttonsDiv=document.getElementById("ButtonDiv");
	if(buttonsDiv!=null)
	buttonsDiv.style.top="70%"
	buttonsDiv.style.left="30%"	
	if((linesDiv != null)&&(headTab != null)&&(headDiv != null))
	{
		boxTop=headDiv.offsetTop+headDiv.offsetHeight;
		linesDiv.style.position="absolute";
		linesDiv.style.top=boxTop;
		linesDiv.style.overflow="auto";
		linesDiv.style.height=tabHeight;
		headTab.style.width="96%"
		linesTab.style.width="100%"
		if(linesDiv.offsetHeight < linesTab.offsetHeight)
		{
			addwidth=19
		}
		else
		{
			addwidth=0+scrollAdj
		}
		boxWidth=headDiv.offsetWidth+addwidth
		boxWidth=boxWidth-(boxWidth/tabHeadWidth)
		boxWidth=Math.round(boxWidth)
		linesDiv.style.width=boxWidth
		boxLeft = ((headDiv.offsetWidth-boxWidth)/2)+(addwidth/2)+leftAdj
		boxLeft=Math.round(boxLeft)
		linesDiv.style.left=boxLeft
	}
}
function submitForm()
{
    	var chkBoxNum=document.myForm.CheckBox.length
    	var selectedCount=0
        if(isNaN(chkBoxNum))
      	{
        	if(document.myForm.CheckBox.checked)
        		selectedCount++
      	}
      	else
      	{
        	for(i=0;i<chkBoxNum;i++)
         	{
           		if(document.myForm.CheckBox[i].checked)
             			selectedCount++
         	}
      	}
     	if(selectedCount==0) //if user did not select atleast one checkbox
     	{
       		alert("Please select atleast one product to change description")
       		return false
     	}
    	if(isNaN(chkBoxNum))
      	{
        	if(document.myForm.CheckBox.checked && document.myForm.WebDesc.value=="")
            	{
                	alert("Please enter description for selected product") 
                	document.myForm.WebDesc.focus()
                	return false
            	}
      	}
      	else
      	{
        	for(i=0;i<chkBoxNum;i++)
        	{
           		if(document.myForm.CheckBox[i].checked && document.myForm.WebDesc[i].value=="")
           		{
              			alert("Please enter description for selected product(s)") 
              			document.myForm.WebDesc[i].focus()
              			return false
           		}
        	}
	}  
     	return true
}

function selectAll()
	  {

	  	len=document.myForm.CheckBox.length
		    if(isNaN(len))
		    {
	  		if(document.myForm.chk1Main.checked)
	  		{
	  			document.myForm.CheckBox.checked=true
	  		}else{
	  			document.myForm.CheckBox.checked=false
	  		}
		    }
	  	   else
	  	   {
	  		for(i=0;i<len;i++)
	  		{
			  if(document.myForm.chk1Main.checked)
	  		  document.myForm.CheckBox[i].checked=true
	  		  else
	  		  document.myForm.CheckBox[i].checked=false
	  		}
	  	   }
	  }

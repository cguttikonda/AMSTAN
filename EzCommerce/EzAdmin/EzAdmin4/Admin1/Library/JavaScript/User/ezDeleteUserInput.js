function init()
 {
 	var InnerdivId1=document.getElementById("InnerBox1Div")
// 	var OuterdivId1=document.getElementById("OuterBox1Div")
 	if(InnerdivId1!=null)
 	{
		myInit(2)
		if(getposition())
		{
			ScrollBox.show()
		}
	}

}
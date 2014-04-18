  <!DOCTYPE html>
  <html>
      <head>
      <!--Theme-->
             <link href="http://cdn.wijmo.com/themes/arctic/jquery-wijmo.css" rel="stylesheet" type="text/css" title="rocket-jqueryui" />
      
             <!--Wijmo Widgets CSS-->
             <link href="http://cdn.wijmo.com/jquery.wijmo-pro.all.3.20132.8.min.css" rel="stylesheet" type="text/css" />
      
             <!--SpreadJS Css-->
             <link href="http://cdn.wijmo.com/spreadjs/jquery.wijmo.wijspread.3.20141.9.css" rel="stylesheet" type="text/css" />
      
             <!--jQuery References-->
             <script src="http://code.jquery.com/jquery-1.8.2.min.js" type="text/javascript"></script>
             <script src="http://code.jquery.com/ui/1.9.1/jquery-ui.min.js" type="text/javascript"></script>
      
             <!--Wijmo Widgets JavaScript-->
             <script src="http://cdn.wijmo.com/jquery.wijmo-open.all.3.20132.8.min.js" type="text/javascript"></script>
             <script src="http://cdn.wijmo.com/jquery.wijmo-pro.all.3.20132.8.min.js" type="text/javascript"></script>
             
             <Script src="../../Library/Script/popup.js"></Script>
      
      
             <!--To make sure run compatible mode in IE/7/8, first must include slcanvas, which is-->
             <!--[if lt IE 9]>
             <script type="text/javascript" src="http://cdn.wijmo.com/spreadjs/silverlightLoader.js"></script>
             <![endif]-->
      
             <script type="text/javascript" src="http://cdn.wijmo.com/spreadjs/jquery.wijmo.wijspread.all.3.20141.9.min.js"></script>
      
             <!--Silverlight spreadsheet bridge module, for SpreadJS compatible mode-->
             <!--[if lt IE 9]>
             <script type="text/javascript" src="http://cdn.wijmo.com/spreadjs/ssbridge.js"></script>
             <![endif]-->
      
             <style type="text/css">
                 .theme-title {
                     width: 50px;
                     height: 50px;
                     margin: 2px 2px 2px 2px;
                     border: 1px solid gray;
                 }
      
                 .theme-smalltitle {
                     width: 50px;
                     height: 20px;
                     margin: 2px 2px 2px 2px;
                     border: 1px solid gray;
                 }
      
                 td {
                     border-collapse: collapse;
                 }
             </style>
      

      <script type="text/javascript">
  
  	    $(document).ready(function () {
  	    
		$("#ss").wijspread({ sheetCount: 1 }); // create wijspread widget instance
		var spread = $("#ss").wijspread("spread"); // get instance of wijspread widget
		var sheet = spread.getActiveSheet(); // get active worksheet of the wijspread widget
		
		sheet.setActiveCell(0, 0);

		 //sheet.getColumn(6, $.wijmo.wijspread.SheetArea.viewport).locked(true);
		 
		//sheet.showHorizontalScrollbar(false);
		//sheet.showVerticalScrollbar(false);

		sheet.clipBoardOptions($.wijmo.wijspread.ClipboardPasteOptions.Values);
		
		sheet.setRowCount(50, $.wijmo.wijspread.SheetArea.viewport);
		sheet.setColumnCount(7, $.wijmo.wijspread.SheetArea.viewport);

		sheet.setValue(0,0,"Product", $.wijmo.wijspread.SheetArea.colHeader);
		sheet.setValue(0,1,"Qty [EA]", $.wijmo.wijspread.SheetArea.colHeader);
		sheet.setValue(0,2,"My SKU", $.wijmo.wijspread.SheetArea.colHeader);
		sheet.setValue(0,3,"My PO Line", $.wijmo.wijspread.SheetArea.colHeader);
		sheet.setValue(0,4,"Job Quote", $.wijmo.wijspread.SheetArea.colHeader);
		sheet.setValue(0,5,"Job Quote Line", $.wijmo.wijspread.SheetArea.colHeader);
		sheet.setValue(0,6,"Message", $.wijmo.wijspread.SheetArea.colHeader);


		//Change the column header height.
		sheet.setRowHeight(0, 90.0,$.wijmo.wijspread.SheetArea.colHeader);


		sheet.setColumnWidth(0, 120.0,$.wijmo.wijspread.SheetArea.colHeader);
		sheet.setColumnWidth(1, 90.0,$.wijmo.wijspread.SheetArea.colHeader);
		sheet.setColumnWidth(2, 90.0,$.wijmo.wijspread.SheetArea.colHeader);
		sheet.setColumnWidth(3, 90.0,$.wijmo.wijspread.SheetArea.colHeader);
		sheet.setColumnWidth(4, 120.0,$.wijmo.wijspread.SheetArea.colHeader);
		sheet.setColumnWidth(5, 100.0,$.wijmo.wijspread.SheetArea.colHeader);
		sheet.setColumnWidth(6, 160.0,$.wijmo.wijspread.SheetArea.colHeader);



		$("#button1").click(function(){
			//Add one row to Row 2.
			var sheet = $("#ss").wijspread("spread").getActiveSheet();
			sheet.addRows(sheet.getRowCount(), 1);
			//sheet.setValue(0, 0, "Added row");
		});
		
		$("#clsifr").click(function(){
		
		parent.jQuery.fancybox.close();  
		
		document.jsForm.action="ezViewCart.jsp";
		document.jsForm.target="_parent";
		document.jsForm.submit(); 
					
		});

		$("#valCart").click(function(e){
		
		

		var sheet = $("#ss").wijspread("spread").getActiveSheet();

		var strCon = "";
		for (var i = 0; i < sheet.getRowCount(); i++)
		{
		    //sheet.setValue(i,1, i);

			var prod 		= notNull(sheet.getText(i, 0));
			var qty 		= notNull(sheet.getText(i, 1));
			var sku 		= notNull(sheet.getText(i, 2));
			var po 			= notNull(sheet.getText(i, 3));
			var quote 		= notNull(sheet.getText(i, 4));
			var quoteline 		= notNull(sheet.getText(i, 5));

			if(i==0)
			{
				strCon = prod+"¥"+qty+"¥"+sku+"¥"+po+"¥"+quote+"¥"+quoteline;
			}
			else
			{
				strCon = strCon+"§"+prod+"¥"+qty+"¥"+sku+"¥"+po+"¥"+quote+"¥"+quoteline;
			}
		}

		//alert(strCon);
		addToCartFromSpread(strCon);
		

		});
  	    });
  
  
  	    function notNull(cellVal)
  	    {
  	    	if(cellVal=="")
  	    		return "N/A";
  	    	else
  	    		return cellVal;
  	    }
  	    
  	    var req;
	 
	    
	    function addToCartFromSpread(splitMat)
	    {		
	    
	    	Popup.showModal('modal');
	    	req=Initialize();
	    
	    	if (req==null)
	    	{
	    	alert ("Your browser does not support Ajax HTTP");
	    	return;
	    	}	
	    	
		url="../ShoppingCart/ezAddCartSpread.jsp";
		url=url+"?splitMat="+splitMat;
	    		
	    	
	    	if(req!=null)
	    	{			
	    		req.onreadystatechange = Process;  
	    		req.open("GET", url, true);
	    		req.send(null); 
	    	} 	
	    }
	    
	    function Process() 
	    {
	    	Popup.hide('modal');
	    	if (req.readyState == 4)
	    	{
	    		var resText     = req.responseText;	 	        	
	    		if (req.status == 200)
	    		{			
	    			//alert(resText);
	    			console.log(resText);
	    			var sheet = $("#ss").wijspread("spread").getActiveSheet();
	    			
	    			var prdsLen =0;
				var selPrdsSplitArr = null;
				if(resText!="")
				{
					selPrdsSplitArr = resText.split("¥");
					prdsLen = selPrdsSplitArr.length;
				}
								
				var j=0;	
					    	
				for (var i = 0; i < prdsLen; i++)
				{				    
			            if(sheet.getValue(i,0)!=null)
			            {			            	
				    	sheet.setValue(i,6,selPrdsSplitArr[i+1]);
				    }
				   
				}
	    		}
	    		else
	    		{
	    			if(req.status == 500)	 
	    			alert("Error in adding product(s)");
	    		}	    		
	    	}
	    }
	    
	    function Initialize()
	    {
	    	if (window.XMLHttpRequest)
	    	{
	    		return new XMLHttpRequest();
	    	}
	    	if (window.ActiveXObject)
	    	{
	    		return new ActiveXObject("Microsoft.XMLHTTP");
	    	}
	    	return null;	
	    }
	    

  	    </script>
  	    <style type="text/css">
  	        .loading {
  	            font-family: Arial, sans-serif;
  	            color: #4f4f4f;
  	            background: #ffffff;
  	            border: 1px solid #a8a8a8;
  	            border-radius: 3px;
  	            -webkit-border-radius: 3px;
  	            box-shadow: 0 0 10px rgba(0, 0, 0, 0.25);
  	            font-size: 20px;
  	            padding: 0.4em;
  	            position: absolute;
  	        }
  	    </style>
  
  
  
      </head>
      <body>
      <form name="jsForm">
	  <div id="ss" style="height:250px;width:830px;border:solid gray 1px;"/>
	  
	  <div id="modal" style="border:0px solid black; background-color:white; padding:1px; font-size:10;width:40%;height:180px; text-align:center; display:none;">
	  	<ul>
	  		<li>&nbsp;</li>
	  		<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
	  		<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
	  	</ul>
	</div>

	  <input type="button" value="add row" id="button1">

	  <input type="button" value="Validate and Update Cart" id="valCart">
	  <input type="button" value="Close" id="clsifr">
      </form>
      </body>
</html>
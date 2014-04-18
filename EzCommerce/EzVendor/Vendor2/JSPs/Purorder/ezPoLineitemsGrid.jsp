<%
	Hashtable ht = new Hashtable();
	Hashtable ht1= new Hashtable();
	String lineNum = "";
	out.println("<?xml version=\"1.0\"?>");
	out.println("<rows>");
	for(int i=0; i<polines; i++){

		lineNum = (String)dtlXML.getFieldValue(i, LINENO);
		String matNum = (String)dtlXML.getFieldValue(i, MATERIAL);
		matNum = matNum.trim();
		String matDesc = (String)dtlXML.getFieldValue(i, MATDESC);
		matDesc = matDesc.trim();
		String uom = (String)dtlXML.getFieldValue(i, UOM);
		String qty = dtlXML.getFieldValueString(i, ORDQTY);
		String plant = dtlXML.getFieldValueString(i, "PLANT");
		//ht.put(matNum,matDesc);
		//ht.put((String)dtlXML.getFieldValue(i, "ITEM"),matDesc);
		//out.println("lineNum: "+lineNum+" "+lineNum.length());
		ht.put(lineNum,matDesc);
	
	
		qty = getNumberFormat(qty,0);

		// SOMA.starts commenting here
		// This field is not coming proerly.Price is comining in Amount field.
		java.math.BigDecimal price1 = (java.math.BigDecimal)dtlXML.getFieldValue(i, PRICE);
	
		// SOMA.ends

		String price = dtlXML.getFieldValueString(i, AMOUNT);// Soma --- Amount is mapped to price.

		double amnt = Double.parseDouble(dtlXML.getFieldValueString(i, "NET_VALUE"));
		//out.println("qty: "+ qty +"price:"+price);
		//amnt = (Double.parseDouble(qty) * Double.parseDouble(price))/ (price1.doubleValue());
		//out.println((Double.parseDouble(qty) * Double.parseDouble(price))+":::::::::::"+price1.doubleValue());
		//out.println("amnt:"+amnt);
		BigDecimal BD = new BigDecimal(amnt);
		//BD.divide(price1);
		//out.println(BD);
		String netAmount =dtlXML.getFieldValueString(i, AMOUNT);
		//String netAmount = (new Float(amnt)).toString()+"0000";

		Date eDDate =(Date)dtlXML.getFieldValue(i, DDATE);
		String edDate = formatDate.getStringFromDate(eDDate,(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
	
		//for receipts details ezPoReceiptDetails.jsp?order=" + poNum + "&line=" + lineNum + "&desc=" + matDesc +">");

		// THE FOLLOWING CHECK IS DONE ON 27.10.2001

		/*if( (uom != null && !uom.equals("")) && (qty != null && !qty.equals("")))
		{*************/ // THIS CHECK IS REMOVED ON 29.10.2001
		
		if(lineNum == null)
			lineNum = "";
		try
		{
			matNum=String.valueOf(Long.parseLong(matNum));
		}
		catch(NumberFormatException nfe){}
		ht1.put(lineNum,matNum);

		price = myFormat.getCurrencyString(price);
		String bd = BD.toString();
		bd = myFormat.getCurrencyString(bd);
		
		
		if(edDate.length() == 10)
		{
			if(dtlXML.	getFieldValueString(i,"INDICATOR").equalsIgnoreCase("X"))
			{
			      out.println("<row><cell>"+lineNum+"</cell><cell>"+matNum+"</cell><cell>"+matDesc+"</cell><cell>"+uom+"</cell><cell>"+qty+"</cell><cell>"+price+"</cell><cell>"+bd+"</cell><cell><![CDATA[<nobr><a href='Javascript:void(0)' onClick='goToPlantAddr(\'"+plant+"\')'></a></nobr>]]></cell><cell><![CDATA[<nobr><a href='ezDelDetPO.jsp?orderNum="+poNum+"&line="+lineNum+"&OrderDate="+dtlXML.getFieldValue(0,ORDDATE)+"'>"+edDate+"</a></nobr>]]></cell></row>");
			}
			else
		               out.println("<row><cell>"+lineNum+"</cell><cell>"+matNum+"</cell><cell>"+matDesc+"</cell><cell>"+uom+"</cell><cell>"+qty+"</cell><cell>"+price+"</cell><cell>"+bd+"</cell><cell><![CDATA[<nobr><a href='Javascript:void(0)' onClick='goToPlantAddr(\'"+plant+"\')'></a></nobr>]]></cell><cell>"+edDate+"</cell></row>");
		}
		
			//	}  //end if (qty != null and uom != null)
	}		//end for
	out.println("</rows>");
	session.setAttribute("materialDesc",ht);
	session.setAttribute("materialNos",ht1);
%>

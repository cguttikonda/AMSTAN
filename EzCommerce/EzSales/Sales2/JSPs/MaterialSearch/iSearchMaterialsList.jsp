
<%@ page import="java.util.*" %>
<%@ page import="ezc.ezparam.*" %>
<%
	
	
	String[] selClassCharacter       = request.getParameterValues("selectedClassCharacter"); 
	String[] selValues       = request.getParameterValues("selectedValues"); 
	java.util.Vector selValuesVector  = new java.util.Vector();
	
	StringTokenizer stVal = null;
	for(int i=0; i<selClassCharacter.length; i++)
	{
		if(!("".equals(selValues[i])))
		{
			stVal = new StringTokenizer(selValues[i],"¥");
			while(stVal.hasMoreElements())
			{
				selValuesVector.addElement(selClassCharacter[i]+"¥"+(String)stVal.nextToken());
			}
		}
	}
	
		//String[] classVal       = request.getParameterValues("classValue");
		String className 	= request.getParameter("className");


		ReturnObjFromRetrieve retMaterialList     =null;
		ReturnObjFromRetrieve retMaterialObjList     =null;
		int retMaterialListCount=0;
		String classType = "001";
		String maxRows 	 = "10000";
	
		ezc.ezparam.EzcParams   myParams	=new ezc.ezparam.EzcParams(true);
		ezc.ezmaterialsearch.client.EzMaterialSearchManager msManager	=new ezc.ezmaterialsearch.client.EzMaterialSearchManager();
		ezc.ezmaterialsearch.params.EziMaterialSearchParams msParams	=new ezc.ezmaterialsearch.params.EziMaterialSearchParams();
		ezc.ezmaterialsearch.params.EzSearchMaterialTable msTable 	= new ezc.ezmaterialsearch.params.EzSearchMaterialTable();
		ezc.ezmaterialsearch.params.EzSearchMaterialTableRow msTableRow = null;

		
		msParams.setClassType(classType);
		msParams.setMaxRows(maxRows);
		msParams.setKeyDate(new Date());
		myParams.setObject(msParams);
		msParams.setClassNum(className);
		msParams.setWithValues("X");
		
		//out.println("classType"+classType);
		//out.println("maxRows"+maxRows);
		//out.println("className"+className);
		
		
		java.util.StringTokenizer st = null;
		
		String tempClassVal="";
		for(int i=0; i<selValuesVector.size(); i++)
		{
			tempClassVal = (String)selValuesVector.elementAt(i);
			st	 = new java.util.StringTokenizer((String)selValuesVector.elementAt(i),"¥");
			if(!("".equals(tempClassVal)))
			{
				msTableRow = new ezc.ezmaterialsearch.params.EzSearchMaterialTableRow();
				msTableRow.setSearchNameChar((String)st.nextElement());
				msTableRow.setSearchValChar((String)st.nextElement());
				msTable.appendRow(msTableRow);
				//out.println("classetSearchNameCharsName"+msTableRow.getSearchNameChar());
				//out.println("classetSearchNameCharsName"+msTableRow.getSearchValChar());
			}	
		}
		msParams.setSearchMaterialTable(msTable);
		myParams.setObject(msParams);
		Session.prepareParams(myParams);
		
		ezc.ezparam.ReturnObjFromRetrieve retMaterialMain		 = (ezc.ezparam.ReturnObjFromRetrieve)msManager.ezGetObjects(myParams);
		
		if(retMaterialMain!=null)
		{
			retMaterialList = (ezc.ezparam.ReturnObjFromRetrieve)retMaterialMain.getFieldValue("SELECTEDOBJECTS");
			//retMaterialObjList = = (ezc.ezparam.ReturnObjFromRetrieve)retMaterialMain.getFieldValue("OBJECTCLASSIFICATION");
			if(retMaterialList!=null) retMaterialListCount =retMaterialList.getRowCount();
		}
		
		
%>		
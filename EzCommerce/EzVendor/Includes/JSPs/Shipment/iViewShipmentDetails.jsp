<%@ page import="java.util.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.ezshipment.client.*" %>
<%@ page import = "ezc.ezshipment.params.*" %>
<%@ page import = "ezc.ezcommon.*" %>
<%@ page import="ezc.ezupload.params.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="PoManager" class="ezc.client.EzPurchaseManager" scope="page" />
<jsp:useBean id="PcManager" class ="ezc.client.EzPurContractManager" scope="page" />
<jsp:useBean id="EzUploadManager" class="ezc.ezupload.client.EzUploadManager" scope="session" />
<%
	String currSysKey 	= (String) session.getValue("SYSKEY");
	String defErpVendor 	= (String) session.getValue("SOLDTO");
	String Status		= request.getParameter("Status");
	String base 		= request.getParameter("base");
	String OrderValue  	= request.getParameter("OrderValue");
	String orderCurrency 	= request.getParameter("orderCurrency");
	String currency 	= request.getParameter("currency");
	String OrderDate 	= request.getParameter("OrderDate");
	String ponum		= request.getParameter("ponum");
	String shipid		= request.getParameter("ShipId");
	String orderBase        = request.getParameter("orderBase");
	boolean isEditable = false;
	if ((Status != null)&&("N".equalsIgnoreCase(Status)))
		isEditable = true ;

	EzShipmentManager shipManager= new EzShipmentManager();
	EziShipmentInfoParams inParams =new EziShipmentInfoParams();
	inParams.setSelection("A");			// A--All	D--Details	H--Headers
	inParams.setPurchaseOrderNumber(ponum);
	inParams.setShipId(shipid);
	EzcParams ezcparams= new EzcParams(true);
	ezcparams.setLocalStore("Y");
	ezcparams.setObject(inParams);
	Session.prepareParams(ezcparams);
	ReturnObjFromRetrieve ret=(ReturnObjFromRetrieve)shipManager.ezGetShipmentInfo(ezcparams);
	ReturnObjFromRetrieve retHead = new ReturnObjFromRetrieve();
	ReturnObjFromRetrieve retLines = new ReturnObjFromRetrieve();
	ReturnObjFromRetrieve retSchd = new ReturnObjFromRetrieve();
	if (ret.getRowCount() > 0)
	{
		retHead = (ReturnObjFromRetrieve)ret.getFieldValue("HEADER");
		retLines=(ReturnObjFromRetrieve)ret.getFieldValue("LINES");
		retSchd=(ReturnObjFromRetrieve)ret.getFieldValue("SCHEDULES");
	}

	int lineCount = retLines.getRowCount ();
	int retLinesCount = retLines.getRowCount();
	String[] mainCoaData = new String[lineCount];
	String[] mainCoaLong = new String[lineCount];
	String shipflag=retHead.getFieldValueString(0,"FILES_ATTACHED");
	String schdflag="";
	for(int i=0;i<retSchd.getRowCount();i++)
	{
		schdflag=retSchd.getFieldValueString(i,"SCHD_ATTACHMENTS");
		if(schdflag.equals("Y"))
		break;
	}

	///For Getting Schedule Level Uploads.

	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezupload.params.EziUploadDocsParams params= new ezc.ezupload.params.EziUploadDocsParams();
	ezc.ezparam.ReturnObjFromRetrieve listRet=null;
	Hashtable UploadLines = new Hashtable();
	String fstr="";
	Vector itemNums=new Vector();
	for(int i=0;i<lineCount;i++)
	{
		itemNums.addElement(retLines.getFieldValueString(i,"LINE_NR"));
		fstr=fstr+"'"+currSysKey+"SHIPSCHD"+shipid+retLines.getFieldValueString(i,"LINE_NR")+"',";
	}
	if(schdflag.equals("Y"))
	{
		fstr=fstr.substring(0,fstr.length()-1);
		params.setObjectNo(fstr);
		mainParams.setObject(params);
		Session.prepareParams(mainParams);
		listRet=(ezc.ezparam.ReturnObjFromRetrieve)EzUploadManager.getUploadedDocs(mainParams);
		int cc = listRet.getRowCount();
		for (int i=0 ; i < cc ; i++)
		{
			UploadLines.put(listRet.getFieldValue(i,"OBJECTNO"),listRet.getFieldValue(i,"FILES"));
		}

	}
	////for getting shipment level uploads

	fstr="";
	fstr="'"+currSysKey+"SHIPMENT"+shipid+"'";
	String fstring="";
	String sfstr="";
	if(shipflag.equals("Y"))
	{
		params.setObjectNo(fstr);
		mainParams.setObject(params);
		Session.prepareParams(mainParams);
		listRet=(ezc.ezparam.ReturnObjFromRetrieve)EzUploadManager.getUploadedDocs(mainParams);
		if(listRet.getRowCount()>0)
		{
			ReturnObjFromRetrieve shfileret=(ReturnObjFromRetrieve)listRet.getFieldValue(0,"FILES");
			//System.out.println(shfileret.toEzcString());
			Vector v= new Vector();
			v.addElement("DCDOC");
			v.addElement("LRDOC");
			v.addElement("PACKAGEDOC");
			v.addElement("INVOICEDOC");
			for(int p=0;p<shfileret.getRowCount();p++)
			{
				if(shfileret.getFieldValueString(p,"TYPE").equals("DCDOC"))
				{
					fstring=fstring+shfileret.getFieldValueString(p,"CLIENTFILENAME")+"¤DCDOC§";
					sfstr=sfstr+shfileret.getFieldValueString(p,"SERVERFILENAME")+"µ";
				}
				else if(shfileret.getFieldValueString(p,"TYPE").equals("LRDOC"))
				{
					fstring=fstring+shfileret.getFieldValueString(p,"CLIENTFILENAME")+"¤LRDOC§";
					sfstr=sfstr+shfileret.getFieldValueString(p,"SERVERFILENAME")+"µ";
				}
				else if(shfileret.getFieldValueString(p,"TYPE").equals("PACKAGEDOC"))
				{
					fstring=fstring+shfileret.getFieldValueString(p,"CLIENTFILENAME")+"¤PACKAGEDOC§";
					sfstr=sfstr+shfileret.getFieldValueString(p,"SERVERFILENAME")+"µ";
				}
				else if(shfileret.getFieldValueString(p,"TYPE").equals("INVOICEDOC"))
				{
					fstring=fstring+shfileret.getFieldValueString(p,"CLIENTFILENAME")+"¤INVOICEDOC§";
					sfstr=sfstr+shfileret.getFieldValueString(p,"SERVERFILENAME")+"µ";
				}
			}
			fstring=fstring.substring(0,fstring.length()-1);
			sfstr=sfstr.substring(0,sfstr.length()-1);
			Vector cv= new Vector();
			Vector ctypes=new Vector();
			Vector sv = new Vector();
			Vector finalcfiles=new Vector();
			Vector finalsfiles=new Vector();
			StringTokenizer tempcfiles=new StringTokenizer(fstring,"§");
			StringTokenizer tempsfiles=new StringTokenizer(sfstr,"µ");
			while(tempcfiles.hasMoreElements())
			{
				StringTokenizer tcfiles=new StringTokenizer((String)tempcfiles.nextToken(),"¤");
				while(tcfiles.hasMoreElements())
				{

					cv.addElement(tcfiles.nextToken());;
					ctypes.addElement((String)tcfiles.nextToken());
				}
					sv.addElement(tempsfiles.nextToken());
			}
			for(int i=0;i<v.size();i++)
			{
				String cfiles="";
				String sfiles="";
				String bool="false";
				for(int j=0;j<ctypes.size();j++)
				{
					if(((String)v.elementAt(i)).equals(((String)ctypes.elementAt(j))))
					{
						cfiles=(String)cv.elementAt(j);
						sfiles=(String)sv.elementAt(j);
						bool="true";
					}
				}
				if(bool.equals("true"))
				{
					finalcfiles.addElement(cfiles);
					finalsfiles.addElement(sfiles);
				}
				else
				{
					finalcfiles.addElement("NA");
					finalsfiles.addElement("NA");
				}
			}
			fstring="";
			sfstr="";
			for(int i=0;i<finalcfiles.size();i++)
			{
				fstring=fstring+(String)finalcfiles.elementAt(i)+"§";
				sfstr=sfstr+(String)finalsfiles.elementAt(i)+"µ";
			}
			fstring=fstring.substring(0,fstring.length()-1);
			sfstr=sfstr.substring(0,sfstr.length()-1);
		}
	}


		String coaData="";
		String coaLong="";

		String tempCoaData="";
		String tempCoaLong="";

		String[] coaFields = new String[9];
		coaFields[0] = "DESCRIPTION";
		coaFields[1] = "DIMLENGTH";
		coaFields[2] = "DIMWIDTH";
		coaFields[3] = "DIMHEIGHT";
		coaFields[4] = "GRAMMAGE";
		coaFields[5] = "FLAPCUTTING";
		coaFields[6] = "PRINTING";
		coaFields[7] = "SHADE";
		coaFields[8] = "AQLDEFECTS";
		ezc.ezparam.ReturnObjFromRetrieve retOther = null;

		if(lineCount>0)
		{
			ezc.ezutil.FormatDate formatDate = new ezc.ezutil.FormatDate();
			ezc.ezparam.EzcParams coaParams = new ezc.ezparam.EzcParams(true);
			coaParams.setLocalStore("Y");
			ezc.ezshipment.params.EziCOAParams iParams= new ezc.ezshipment.params.EziCOAParams();
			iParams.setDocumentNo(shipid);
			coaParams.setObject(iParams);
			Session.prepareParams(coaParams);
			ezc.ezparam.ReturnObjFromRetrieve coaListRet=(ezc.ezparam.ReturnObjFromRetrieve)shipManager.ezListCOA(coaParams);
			int coaListCount=coaListRet.getRowCount();


			//out.println(coaListRet.toEzcString());
			boolean newFlag=false;
			for(int i=0;i<lineCount;i++)
			{
				coaData="";
				coaLong="";
				for(int k=0;k<10;k++)
				{
					newFlag=false;
					for(int j=0;j<coaListCount;j++)
					{
					  //  out.println(retLines.getFieldValueString(i,"LINE_NR")+"*******"+coaListRet.getFieldValueString(j,"ITEMNUMBER"));
					     if(retLines.getFieldValueString(i,"LINE_NR").equals(coaListRet.getFieldValueString(j,"ITEMNUMBER")))
					     {
						//out.println(String.valueOf(k+1)+"*******"+coaListRet.getFieldValueString(j,"LINENUMBER"));
						if(String.valueOf(k+1).equals(coaListRet.getFieldValueString(j,"LINENUMBER")))
						{

							   tempCoaData="";
							   tempCoaLong="";
							   String arNumber = coaListRet.getFieldValueString(j,"ARNUMBER");
							   arNumber = (arNumber==null||arNumber.equals("null")||"".equals(arNumber))? "-":arNumber;

							   String dateOfAnal = coaListRet.getFieldValueString(j,"DATEOFANALYSIS");
							   dateOfAnal = (dateOfAnal==null||dateOfAnal.equals("null")||"".equals(dateOfAnal))? "-":formatDate.getStringFromDate((Date) coaListRet.getFieldValue(j,"DATEOFANALYSIS"),".",ezc.ezutil.FormatDate.DDMMYYYY);

							   String dateOfMfg = coaListRet.getFieldValueString(j,"DATEOFMFG");
							   dateOfMfg = (dateOfMfg==null||dateOfMfg.equals("null")||"".equals(dateOfMfg))? "-":formatDate.getStringFromDate((Date) coaListRet.getFieldValue(j,"DATEOFMFG"),".",ezc.ezutil.FormatDate.DDMMYYYY);

							   String boxes = coaListRet.getFieldValueString(j,"BOXES");
							   boxes = (boxes==null||boxes.equals("null")||"".equals(boxes))? "-":boxes;

							   String specNumber = coaListRet.getFieldValueString(j,"SPECNUMBER");
							   specNumber = (specNumber==null||specNumber.equals("null")||"".equals(specNumber))? "-":specNumber;

							   tempCoaData=arNumber+"§"+dateOfAnal+"§"+dateOfMfg+"§"+boxes+"§"+specNumber;
							 //  out.println(tempCoaData);
							   ezc.ezparam.EzcParams oParams = new ezc.ezparam.EzcParams(true);
							   ezc.ezupload.params.EziDocumentTextsTable table =  new ezc.ezupload.params.EziDocumentTextsTable();
							   ezc.ezupload.params.EziDocumentTextsTableRow tableRow=null;

							   for(int l=0;l<coaFields.length;l++)
							   {
								    tableRow =  new ezc.ezupload.params.EziDocumentTextsTableRow();
								    tableRow.setDocType("SHIPMENT");
								    tableRow.setDocNo(shipid+"COA"+retLines.getFieldValueString(i,"LINE_NR")+String.valueOf(k+1));
								    tableRow.setSysKey(currSysKey);
								    tableRow.setKey(coaFields[l]);
								    table.appendRow(tableRow);
							   }

							   oParams.setObject(table);
							   Session.prepareParams(oParams);
							   retOther=(ezc.ezparam.ReturnObjFromRetrieve)EzUploadManager.getDocumentTextDetails(oParams);
							   int retOtherCount = retOther.getRowCount();

							   String subData = "";
							   if(retOtherCount>0)
							   {
								   boolean flag=false;
								   for(int y=0;y<coaFields.length;y++)
								   {
									   flag=false;
									   for(int x=0;x<retOtherCount;x++)
									   {
										if(retOther.getFieldValueString(x,"KEYS").equals(coaFields[y]))
										{
										   subData = retOther.getFieldValueString(x,"VALUE1");
										   flag=true;
										   break;
										}
									   }
									  if(flag)
									  {
										subData = subData.equals("") ? "-":subData;
										tempCoaLong = tempCoaLong+subData+"§";
									  }
									  else
									  {
										tempCoaLong = tempCoaLong+"-§";
									  }
								   }
								   tempCoaLong = tempCoaLong.substring(0,tempCoaLong.lastIndexOf("§"));

							   }
							   else
							   {
								tempCoaLong = "-";
							   }
							   newFlag=true;
							   break;
						    }
					    }
				     }
				     if(newFlag)
				     {
					    coaData = coaData+tempCoaData+"¥";
					    coaLong = coaLong+tempCoaLong+"¥";
				     }
				     else
				     {
					    coaData = coaData+"-¥";
					    coaLong = coaLong+"-¥";
				     }

				}
			  coaData = coaData.substring(0,coaData.lastIndexOf("¥"));
			  coaLong = coaLong.substring(0,coaLong.lastIndexOf("¥"));
			  mainCoaData[i] = coaData;
			  mainCoaLong[i] = coaLong;
			}

		}

	String doctype=retHead.getFieldValueString(0,"DOC_TYPE");
	
%>

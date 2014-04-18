<%@ page import="java.util.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<%@ include file="../../../Includes/Lib/AdminCatalog.jsp"%>
<%@ page import="ezc.ezupload.MultipartRequest" %>
<%@ include file="../../../Includes/Jsps/Inbox/iGetUploadTempDir.jsp"%>

<%
	String filename	= "";
	double length 	= 0.0f;
	File file	= null;
	boolean flg     = false;
	int rowCount    = 0;
    	try
    	{
       		File f1	= new File(inboxPath+session.getId());
        	if((f1.exists()) && (f1.isFile()))
         	{
	        }
         	else
         	{
          	    boolean dir	= f1.mkdir();
	  	    System.out.println("directory created:"+dir);
	 	}
       		String dirName	= f1.getPath();
         	MultipartRequest multi = new MultipartRequest(request, dirName, 10*1024*1024);
         	Enumeration params = multi.getParameterNames();
        	while (params.hasMoreElements())
        	{
           		String name 	= (String)params.nextElement();
           		String value 	= multi.getParameter(name);
	        }
        	Enumeration files = multi.getFileNames();
	        while (files.hasMoreElements())
        	{
           		String name = (String)files.nextElement();
           		filename = multi.getFilesystemName(name);
           		String type = multi.getContentType(name);
          		file = multi.getFile(name);
			if(file.length() <= 3145728)
			{
				flg  = true ;
          		}
        	}
    	}
    	catch(Exception r)
    	{
    	}
%>

<%@page import="java.util.*,java.io.*,org.apache.poi.poifs.filesystem.POIFSFileSystem,org.apache.poi.hssf.usermodel.HSSFDateUtil,org.apache.poi.hssf.usermodel.HSSFCell,org.apache.poi.hssf.usermodel.HSSFSheet,org.apache.poi.hssf.usermodel.HSSFWorkbook,org.apache.poi.hssf.usermodel.HSSFRow;"%>

<%
	ezc.ezparam.ReturnObjFromRetrieve retObj = new ezc.ezparam.ReturnObjFromRetrieve(new String[]{"Product Code","Product Description","Manufacturer","List Price","Status","Family","UPC","Type","Color","Size","Length","Width","UOM","Finish","Specification1","Specification2","Specification3","Specification4"});
    	
	POIFSFileSystem FileSys = null;
	try
	{
		FileSys = new POIFSFileSystem(new FileInputStream(file));
	}
	catch(Exception e)
	{
	        System.out.println(e);
	}		
	boolean flag = true;
	boolean emptyColFlg = false;

	java.util.Vector headVect = new java.util.Vector();

	headVect.add("Product Code");
	headVect.add("Product Description");
	headVect.add("Manufacturer");
	headVect.add("List Price");
	headVect.add("Status");
	headVect.add("Family");
	headVect.add("UPC");
	headVect.add("Type");
	headVect.add("Color");
	headVect.add("Size");
	headVect.add("Length");
	headVect.add("Width");
	headVect.add("UOM");
	headVect.add("Finish");
	headVect.add("Specification1");
	headVect.add("Specification2");
	headVect.add("Specification3");
	headVect.add("Specification4");		
	
	HSSFWorkbook workBook = new HSSFWorkbook(FileSys);

	HSSFSheet firstSheet 	= workBook.getSheetAt(0);
	HSSFRow   firstRow 	= firstSheet.getRow(0);
	HSSFCell  firstCell	= null;
	String 	  firstCellVal	= "";

        
	if(firstRow!=null)
	{
		
		for(int cellNo = 0;cellNo<firstRow.getPhysicalNumberOfCells();cellNo++)
		{
			firstCell = firstRow.getCell((short)cellNo);
			
			if(firstCell==null)
			{
				flag=false;
				break;
			}
			else 
			{
				
				if(firstCell.getCellType()==HSSFCell.CELL_TYPE_STRING)
					firstCellVal=firstCell.getStringCellValue();
				else
					firstCellVal=""+firstCell.getNumericCellValue();

				if(firstCellVal!=null)
				{
					if(!headVect.contains(firstCellVal))
					{
						flag=false;
						break;
					}
				}
				
			}
		}
	}
	else
	    flag=false;
	
	/*********** Start Reading From Excel Sheet **************/		
	
	if(flag)
	{
		HSSFSheet sheet   = workBook.getSheetAt(0);
		
		int numRows = sheet.getPhysicalNumberOfRows();
		int cellType;
                
		for(int r=0;r<numRows;r++)
		{
			HSSFRow row = (HSSFRow)sheet.getRow(r);
			System.out.println("Number of Cells"+row.getPhysicalNumberOfCells());
                        
			if(row.getPhysicalNumberOfCells()==18)
			{
				if(row.getRowNum()>0)
				{
					int numCols = row.getPhysicalNumberOfCells();

					for(int c=0;c<numCols;c++)
					{
						HSSFCell cell = (HSSFCell) row.getCell((short)c);
						int cellNum = cell.getCellNum();
						cellType = cell.getCellType();
						
						if(cellType==0)
						{
							try
							{
								retObj.setFieldValue((String)headVect.get(c),String.valueOf((long)cell.getNumericCellValue()));
							}
							catch(Exception e)
							{
							}
						}	
						else if(cellType==1)
						{
							try
							{
								retObj.setFieldValue((String)headVect.get(c),cell.getStringCellValue());		
							}
							catch(Exception e)
							{
							}
						}
						
					}
					retObj.addRow();
				}
			}

			else
			{
				emptyColFlg = true;
			}
		} 
	
	}	
	if(retObj!=null)
	{
		rowCount = retObj.getRowCount();	
		
	}	
	
	/************* List of catalogs *********************/
	
	ReturnObjFromRetrieve retcat = null;
	int retCatCount =0;
	String cat_num=null;
	
	EzCatalogParams catalogParams = new EzCatalogParams();
	Session.prepareParams(catalogParams);
	catalogParams.setLanguage("EN");
	retcat = (ReturnObjFromRetrieve)catalogObj.getCatalogList(catalogParams);
	retcat.check();
	
		
	if(retcat!=null){
		retCatCount= retcat.getRowCount();
	}

	/****************************************************/
	
%>	
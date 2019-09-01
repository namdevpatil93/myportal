package com.msrtc.portal.core.common.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;

import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

/**
 * The type File utils.
 */
public class FileUtils {

    private FileUtils() {
    }

    /**
     * Save file.
     *
     * @param file     the file
     * @param fileName the file name
     * @param location the location
     */
    public static void saveFile(MultipartFile file, String fileName, String location) {
        File dir = new File(location);
        if (!dir.exists()) {
            dir.mkdirs();
        }
        try {
            BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(new File(location + File.separator + fileName)));
            stream.write(file.getBytes());
            stream.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Delete file.
     *
     * @param fileName the file name
     * @param location the location
     */
    public static void deleteFile(String fileName, String location) {
        File file = new File(location + File.separator + fileName);
        file.delete();
    }
    
    /**
     * Delete Previous Files.
     *
     * @param location the location
     * @param currentFileName, name of file not to be deleted
     */
    public static void deletePreviousFiles(String location, String currentFileName) {
    	File folder = new File(location);
    	File[] listOfFiles = folder.listFiles();
    	if (listOfFiles != null) {
    		for (int i = 0; i < listOfFiles.length; i++) {
    		    if (!(listOfFiles[i].getName().equals(currentFileName))) {
    		    	listOfFiles[i].delete();
    		    }
        	}
    	}
    }
    
    public static boolean downloadFile(HttpServletResponse response, String filePath, String filename, String contentType) {
   	 File uFile = new File(filePath);
   	try {
           int fSize = (int) uFile.length();
           if (fSize > 0) {
               BufferedInputStream in = new BufferedInputStream(new FileInputStream(filePath));
               response.setBufferSize(fSize);
               response.setContentType("application/"+contentType);
               response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");
               response.setContentLength(fSize);
               FileCopyUtils.copy(in, response.getOutputStream());
               try {
                   //response.resetBuffer();
               } catch (IllegalStateException ex) {
                  ex.printStackTrace();
               }
               in.close();
               response.getOutputStream().flush();
               response.getOutputStream().close();
           }
       } catch (Exception e) {
    	   e.printStackTrace();
           return false;
       }
       /*finally
       {
       	// if temporary file exists on the server it will deleted
       	if(uFile.exists())
       	{
       		boolean deleteFlag=FileUtils.deleteQuietly(uFile);
       		log.info("File successfully deleted: ["+deleteFlag+"] in location: ["+uFile.getAbsolutePath()+"]");
       		//System.out.println("File successfully deleted: ["+deleteFlag+"] in location: ["+uFile.getAbsolutePath()+"]");
       	}
       }*/
       return true;
   }

}

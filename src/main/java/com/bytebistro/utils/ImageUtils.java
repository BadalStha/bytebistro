package com.bytebistro.utils;

import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

public class ImageUtils {
    private static final String UPLOAD_DIR = "uploads/menu-items/";

    public static String saveImageFile(Part filePart) throws IOException {
        String uploadDir = System.getProperty("catalina.base") + File.separator + "webapps" + File.separator + "bytebistro_war_exploded" + File.separator + UPLOAD_DIR;

        File uploadFolder = new File(uploadDir);
        if (!uploadFolder.exists()) {
            uploadFolder.mkdirs();
        }

        String fileName = filePart.getSubmittedFileName();
        String fileExtension = fileName.substring(fileName.lastIndexOf("."));
        String uniqueFileName = UUID.randomUUID().toString() + fileExtension;

        String filePath = uploadDir + uniqueFileName;
        filePart.write(filePath);

        return UPLOAD_DIR + uniqueFileName;
    }
}

package com.bytebistro.utils;

import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

public class ImageUtils {
    public static String saveImageInDirectory(Part imagePart) throws IOException {
        String location = "/home/badal/Documents/college/advanceProgramming/coursework/code/bytebistro/src/main/webapp/uploads";

        File imageUploadLocation = new File(location);
        if (!imageUploadLocation.exists()){
            imageUploadLocation.mkdirs();
        }
        String fileName = imagePart.getSubmittedFileName();

        imagePart.write(location + File.separator + fileName);

        return "uploads/menu-items/"+fileName;
    }

}

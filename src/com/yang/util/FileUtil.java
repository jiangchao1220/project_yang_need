package com.yang.util;

import org.springframework.web.multipart.MultipartFile;

import java.io.*;

/**
 * Created by jiang on 2019/5/19.
 */
public final class FileUtil {
    public static final String OUT_IMAGES_PATH = "F:\\house\\out\\artifacts\\house_war_exploded\\jsp\\images";
    public static final String PROJECT_IMAGES_PATH = "F:\\house\\web\\jsp\\images";

    public static String saveFiles(InputStream inputStream, String fileName) throws IOException {
        savePic(inputStream, fileName);
        File tempFile = new File(OUT_IMAGES_PATH + File.separator + fileName);
        File tempFile2 = new File(PROJECT_IMAGES_PATH + File.separator + fileName);
        String msg;
        if (tempFile.exists() && tempFile2.exists()) {
            msg = "success";
        } else {
            msg = "fail";
        }
        return msg;
    }

    private static void savePic(InputStream inputStream, String fileName) throws IOException {

        OutputStream os = null;
        OutputStream os2 = null;
        try {
            // 1K的数据缓冲
            byte[] bs = new byte[1024];
            // 读取到的数据长度
            int len;
            // 输出的文件流保存到本地文件
            File tempFile = new File(OUT_IMAGES_PATH);
            File tempFile2 = new File(PROJECT_IMAGES_PATH);
            if (!tempFile.exists()) {
                tempFile.mkdirs();
            }
            if (!tempFile2.exists()) {
                tempFile2.mkdirs();
            }
            os = new FileOutputStream(tempFile.getPath() + File.separator + fileName);
            os2 = new FileOutputStream(tempFile2.getPath() + File.separator + fileName);
            // 开始读取
            while ((len = inputStream.read(bs)) != -1) {
                os.write(bs, 0, len);
                os2.write(bs, 0, len);
            }
        } finally {
            // 完毕，关闭所有链接
            try {
                os.close();
                os2.close();
                inputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}

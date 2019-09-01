import com.itextpdf.io.image.ImageDataFactory;
import com.itextpdf.layout.element.Image;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.function.Function;
import java.util.stream.Collectors;

public class InvalidImageChecker {

    private static final String BASE_UPLOAD_DIR = "/opt/MSRTC/server/appFiles/uploads";
    private static final String CSV_PATH = "/opt/MSRTC/server/appFiles/dcc.csv";
    private static final String RESULT_PATH = "/opt/MSRTC/server/appFiles/output.xls";

    private static final String COMMA = ",";

    public static void main(String[] args) throws IOException {

        List<CsvRow> csvRows = processCsvFile(CSV_PATH);

        int count = 0;
        int corrupted = 0;

        XSSFWorkbook workbook = new XSSFWorkbook();
        XSSFSheet sheet = workbook.createSheet("Corrupted Applicant IDs");

        int rowNum = 0;

        for(CsvRow csvRow : csvRows){
            String applicantID = csvRow.getApplicantId();
            String photoPath = BASE_UPLOAD_DIR + File.separator + csvRow.getPhoto();
            String signaturePah = BASE_UPLOAD_DIR + File.separator + csvRow.getSignature();

            photoPath = photoPath.replaceAll("\"", "");
            signaturePah = signaturePah.replaceAll("\"", "");

            boolean photoCorrupt = false;
            boolean signatureCorrupt = false;

            try {
                Image photoImage = new Image(ImageDataFactory.create(photoPath));
            } catch(Exception e){
                e.printStackTrace();
                photoCorrupt = true;
            }

            try {
                Image signatureImage = new Image(ImageDataFactory.create(signaturePah));
            } catch(Exception e){
                e.printStackTrace();
                signatureCorrupt = true;
            }

            if(photoCorrupt || signatureCorrupt){
                corrupted = corrupted + 1;

                Row row = sheet.createRow(rowNum++);

                Cell idCell = row.createCell(0);
                Cell photoCell = row.createCell(1);
                Cell signatureCell = row.createCell(2);

                idCell.setCellValue(applicantID);

                if(photoCorrupt){
                    photoCell.setCellValue("Photo Corrupt");
                } else {
                    photoCell.setCellValue("Photo OK");
                }

                if(signatureCorrupt){
                    signatureCell.setCellValue("Signature Corrupt");
                } else {
                    signatureCell.setCellValue("Signature OK");
                }

            }

            count = count + 1;

            System.out.println("[" + count + "] Applicants checked so far. ");
            System.out.println("Corrupted so far -> " + corrupted);

        }

        try {
            FileOutputStream outputStream = new FileOutputStream(RESULT_PATH);
            workbook.write(outputStream);
            workbook.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        System.out.println("Done");
    }

    private static List<CsvRow> processCsvFile(String inputFilePath) {
        List<CsvRow> inputList = new ArrayList<>();
        try{
            File inputF = new File(inputFilePath);
            InputStream inputFS = new FileInputStream(inputF);
            BufferedReader br = new BufferedReader(new InputStreamReader(inputFS));
            // skip the header of the csv
            inputList = br.lines().skip(1).map(mapToItem).collect(Collectors.toList());
            br.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return inputList ;
    }

    private static Function<String, CsvRow> mapToItem = (line) -> {
        String[] p = line.split(COMMA);

        CsvRow csvRow = new CsvRow();

        csvRow.setApplicantId(p[0]);
        csvRow.setPhoto(p[1]);
        csvRow.setSignature(p[1]);

        return csvRow;
    };

}

class CsvRow {

    String applicantId;
    String photo;
    String signature;

    public String getApplicantId() {
        return applicantId;
    }

    public void setApplicantId(String applicantId) {
        this.applicantId = applicantId;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public String getSignature() {
        return signature;
    }

    public void setSignature(String signature) {
        this.signature = signature;
    }

    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder("CsvRow{");
        sb.append("applicantId='").append(applicantId).append('\'');
        sb.append(", photo='").append(photo).append('\'');
        sb.append(", signature='").append(signature).append('\'');
        sb.append('}');
        return sb.toString();
    }
}
import com.itextpdf.io.image.ImageDataFactory;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.element.Image;
import com.itextpdf.layout.element.Table;
import com.itextpdf.licensekey.LicenseKey;

import java.io.File;
import java.io.FileNotFoundException;

/**
 * Created by ashish.meshram on 17/8/17.
 */
public class ImageTest {

    static String licenseKeyPath = "/opt/ashish/projects/MSRTC/Itext7/itextkey-0.xml";
    static String pdfLocation = "/home/sts.local/ashish.meshram/Desktop/test.pdf";
    private static final String BASE_UPLOAD_DIR = "/opt/MSRTC/server/appFiles/uploads";

    public static void main(String[] args) throws Exception {

        String photoPath = "MSRTC0318059/photos/6cea00d0-f8b1-4c15-a90e-b03785e7c57d_MSRTC0318059_photo.jpg";
        String sigPath = "MSRTC0318059/signatures/fdf7e9cc-e5ee-450a-b9d8-6eb015e6b575_MSRTC0318059_signature.jpg";

        LicenseKey.loadLicenseFile(licenseKeyPath);

        PdfDocument pdf = null;
        try {
            pdf = new PdfDocument(new PdfWriter(pdfLocation));
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        Document document = new Document(pdf);

        Table table = new Table(4);

        Cell photoCell = new Cell(1, 1);
        Cell sigCell = new Cell(1, 1);

        Image photo = new Image(ImageDataFactory.create(BASE_UPLOAD_DIR + File.separator + photoPath));
        photo.setWidth(58);
        photo.setHeight(58f);
        photoCell.add(photo);

        table.addCell(photoCell);

        Image sig = new Image(ImageDataFactory.create(BASE_UPLOAD_DIR + File.separator + sigPath));
        sig.setWidth(58);
        sig.setHeight(58f);
        sigCell.add(sig);

        table.addCell(photoCell);
        table.addCell(sigCell);

        document.add(table);
        document.close();

    }

}

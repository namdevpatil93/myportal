import com.msrtc.portal.applicant.dto.UndertakingDTO;
import com.msrtc.portal.applicant.util.UndertakingPDFGenerator;
import com.msrtc.portal.core.common.util.Constants;

import java.io.File;
import java.time.LocalDate;

/**
 * Created by ashish.meshram on 14/8/17.
 */
public class UndertakingPDFGeneratorTest {

    public static void main(String[] args) {
        String portalResourceBasePath = "/opt/MSRTC/server/appFiles";
        String licenseKeyPath = "/opt/ashish/projects/MSRTC/Itext7/itextkey-0.xml";

        UndertakingDTO dto = new UndertakingDTO();

        dto.setApplicationID("MSRTC0000084");

        dto.setFirstName("Ashish");
        dto.setMiddleName("J");
        dto.setSurname("Meshram");

        dto.setFirstNameInMarathi("आशीष");
        dto.setMiddleNameInMarathi("जे");
        dto.setSurnameInMarathi("मेश्राम");

        dto.setDob(LocalDate.of(1982, 12, 21));

        dto.setGender(1);

        dto.setAddress("Some Address ");
        dto.setPinCode("400089");
        dto.setEmail("ashish.meshram@sts.in");
        dto.setMobile("9833707361");
        dto.setDistrict("Mumbai");
        dto.setMaritalStatus(0);
        dto.setMaharashtraDomicile(true);
        dto.setRwsMarathi(true);
        dto.setCaste("SC");
        dto.setSubCaste("Mahar");

        dto.setNonCreamyLayer(true);
        dto.setCertificateValidityEndingDate(LocalDate.of(2017,1,1));

        dto.setEarthQuakeEffected(true);
        dto.setProjectEffected(false);
        dto.setExServiceMan(true);
        dto.setPartTimeEmployee(false);
        dto.setSportsPerson(true);
        dto.setStEmployee(false);

        dto.setFirstPreferredCity("Mumbai");
        dto.setSecondPreferredCity("Pune");
        dto.setThirdPreferredCity("Nagpur");

        dto.setPostId(21);
        dto.setPostAppliedFor("वरिष्ठ संगणित्र चालक (कनिष्ठ) / विभागीय संगणक पर्यवेक्षक (कनिष्ठ)");
        dto.setPriority(1);

        dto.setLogoPath("/home/sts.local/ashish.meshram/Desktop/msrtcLogo.jpg");
        dto.setPhotoLocation(portalResourceBasePath + File.separator + Constants.BASE_UPLOAD_DIR + File.separator + dto.getApplicationID() + File.separator + Constants.APPLICANT_PHOTO_UPLOAD_BASE_DIR + File.separator + "41280752-4f0b-4dba-bae7-91c4bdf0bce6_MSRTC0000084_photo.JPG");
        dto.setSignatureLocation(portalResourceBasePath + File.separator + Constants.BASE_UPLOAD_DIR + File.separator + dto.getApplicationID() + File.separator + Constants.APPLICANT_SIGNATURE_UPLOAD_BASE_DIR + File.separator + "18845bb4-425b-4b9e-92a6-1ab60ff493b2_MSRTC0000084_signature.JPG");

        String pdfLocation = portalResourceBasePath + File.separator + Constants.BASE_DOWNLOAD_DIR + File.separator + Constants.UNDERTAKING_BASE_DIR + File.separator +  dto.getPostId();
        String pdfName = dto.getApplicationID() + "_" + dto.getPostId() + ".pdf";

        String fontLocation = "/home/sts.local/ashish.meshram/Downloads/FreeSans.ttf";

        try {
         //   UndertakingPDFGenerator generator = new UndertakingPDFGenerator(fontLocation, licenseKeyPath);
           // generator.generate(pdfLocation, pdfName, dto);
        } catch (Exception e) {
            e.printStackTrace();
        }


    }
}

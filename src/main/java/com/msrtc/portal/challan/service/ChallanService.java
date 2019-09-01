package com.msrtc.portal.challan.service;

import java.io.IOException;
import java.text.ParseException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.msrtc.portal.challan.domain.Challan;
import com.msrtc.portal.challan.domain.ChallanFile;
import com.msrtc.portal.challan.dto.ChallanDataDTO;
import com.msrtc.portal.challan.dto.ChallanFileSearchDTO;
import com.msrtc.portal.challan.dto.ChallanSearchDTO;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;


public interface ChallanService {

    Page<Challan> searchChallans(ChallanSearchDTO challanSearchDTO, Pageable pageable);

/*
    void saveChallanFile(ChallanFile challanFile);
*/

    Page<ChallanFile> searchChallanFiles(ChallanFileSearchDTO challanFileSearchDTO, Pageable pageable);

    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = {"java.lang.Exception" })
    void saveChallan(Challan challan);

    void saveChallanFile(ChallanFile challanFile);

    ChallanFile findChallanFileByChallanFileId(Long challanFileId);

    Map<String, String> uploadChallan(MultipartFile challanFile, Long userId) throws IOException;

    void updatePaymentStatusViaQueryApi(String orderNo, int status);

    List<Object[]> downloadChallanData(String fromDate, String toDate);

    void markPostAsSubmitted(Long postAssocId, String orderNo);
    
    Date getEndDateString();
    
    Date getStartDateString();
    
    String saveChallanData() throws IOException, ParseException;
    
    void submitQueryList(Date startdate, Date endDate) throws ParseException, IOException;
    //List<String> getChallanDataRows(Date startDate, Date endDate);
    
}


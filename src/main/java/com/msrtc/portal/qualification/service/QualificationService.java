package com.msrtc.portal.qualification.service;

import com.msrtc.portal.qualification.domain.Qualification;
import com.msrtc.portal.qualification.dto.QualificationSearchDTO;

import org.apache.poi.ss.usermodel.Cell;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;

public interface QualificationService {

    Qualification findQualificationById(Long id);

    boolean saveQualification(Qualification qualification);

    void deleteQualification(Long id);

    List<Qualification> findAllQualifications();

    Page<Qualification> searchQualifications(QualificationSearchDTO qualificationSearchDTO, Pageable pageable);
    
    List<Qualification> findAllQualificationByPriority();
    
    List<Qualification> findAllActiveQualificationByPriority();
    
    Qualification qualificationFromCell(List<Cell> cells) throws Exception;
    
    void saveListOfQualification(List<Qualification> listOfQualification);
    
    boolean processMultipleQualification(String fileLocation, String fileName, String fileExtension) throws Exception;
}

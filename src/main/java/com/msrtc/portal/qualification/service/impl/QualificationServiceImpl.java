package com.msrtc.portal.qualification.service.impl;

import com.msrtc.portal.core.common.util.Constants;
import com.msrtc.portal.core.common.util.FileUtils;
import com.msrtc.portal.qualification.custom.exception.DuplicateCheckInQualification;
import com.msrtc.portal.qualification.custom.exception.QualificationFileEmptyException;
import com.msrtc.portal.qualification.domain.Qualification;
import com.msrtc.portal.qualification.dto.QualificationSearchDTO;
import com.msrtc.portal.qualification.respository.QualificationRepository;
import com.msrtc.portal.qualification.service.QualificationService;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.validation.constraints.Size;

@Service(value = "qualificationService")
@Transactional(readOnly = true)
public class QualificationServiceImpl implements QualificationService {

	private final Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	private QualificationRepository qualificationRepository;
	
	@Autowired
	private QualificationService qualificationService;
	@Override
	public List<Qualification> findAllQualifications() {
		log.debug("Finding all qualification entries");
		return (List<Qualification>) qualificationRepository.findAll();
	}

	@Override
	public Page<Qualification> searchQualifications(QualificationSearchDTO qualificationSearchDTO, Pageable pageable){
		return qualificationRepository.searchQualifications(qualificationSearchDTO, pageable);
	}

	@Override
	public Qualification findQualificationById(Long id) {
		log.debug("Finding qualification entry with the qualification id: {}", id);
		return qualificationRepository.findOne(id);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = {"java.lang.Exception" })
	public boolean saveQualification(Qualification qualification) {
		log.debug("Saving Qualification with the information: {}", qualification);

		boolean isNew = qualification.getId() == null ||  qualification.getId() == 0;
		boolean exist=false;
		if(isNew){
				if (qualificationRepository.findByTitle(qualification.getTitle())==null && 
						qualificationRepository.findByTitleInMarathi(qualification.getTitleInMarathi())==null) {
					qualificationRepository.save(qualification);
					exist=true;
				}
			
		} else {
			if ((qualificationRepository.findByTitle(qualification.getTitle())==qualificationService.findQualificationById(qualification.getId())
				&&	qualificationRepository.findByTitleInMarathi(qualification.getTitleInMarathi())==qualificationService.findQualificationById(qualification.getId()))||
				(qualificationRepository.findByTitle(qualification.getTitle())==null || 
				qualificationRepository.findByTitleInMarathi(qualification.getTitleInMarathi())==null)) {
			Qualification dbQualification = qualificationRepository.findOne(qualification.getId());
			dbQualification.setTitle(qualification.getTitle());
			dbQualification.setTitleInMarathi(qualification.getTitleInMarathi());
			dbQualification.setPriority(qualification.getPriority());
			dbQualification.setActive(qualification.isActive());
			qualificationRepository.save(dbQualification);
			exist=true;
		}
		}
		return exist;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = {"java.lang.Exception" })
	public void saveListOfQualification(List<Qualification> listOfQualification){
		
			qualificationRepository.save(listOfQualification);
		
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = {"java.lang.Exception" })
	public void deleteQualification(Long id) {
		log.debug("Deleting qualification entry with the qualification id: {}", id);
		qualificationRepository.delete(id);
	}

	@Override
	public List<Qualification> findAllQualificationByPriority() {
		log.debug("Finding all qualification entries order by priority low to high");
		List<Qualification> qList = qualificationRepository.findAllByOrderByPriorityDesc();
		return qList;
	}

	
	@SuppressWarnings("resource")
	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackForClassName = {"java.lang.Exception" })
	public boolean processMultipleQualification(String fileLocation, String fileName, String fileExtension) throws Exception{
		
		List<Qualification> qualificationData = new ArrayList<Qualification>();
		boolean exist=true;
		Sheet sheet = null;
		Workbook workbook = null;
		
		InputStream input = new FileInputStream(fileLocation + File.separator + fileName);
		
		if (fileExtension.equals(".xls")) { 
				  workbook = new HSSFWorkbook(input); }
		else if (fileExtension.equals(".xlsx")) {
		 workbook = new XSSFWorkbook(input); 
			  }
			 
		sheet = workbook.getSheetAt(0);
		
		if(sheet.getPhysicalNumberOfRows()>1){
				 
		for (int i = 1; i < sheet.getPhysicalNumberOfRows(); i++) {
				
			Qualification qualification;
			Row row = sheet.getRow(i);
			
			if (row.getPhysicalNumberOfCells()>1) {
					
				List<Cell> cells = new ArrayList<Cell>();
					
				for (int columnNumber = 1; columnNumber < sheet.getRow(0).getPhysicalNumberOfCells(); columnNumber++) {
						
					Cell cell = row.getCell(columnNumber);
					if(cell!=null){
					cells.add(cell);
						}
					else{
							throw new QualificationFileEmptyException();
						}
					}
					qualification=qualificationFromCell(cells);
					}
				else {
					 throw new QualificationFileEmptyException();
				}
			
			//Entry Check in database
				
				if (qualificationRepository.findByTitle(qualification.getTitle()) == null && 
						qualificationRepository.findByTitleInMarathi(qualification.getTitleInMarathi()) == null) {
						
					qualificationData.add(qualification);
						
					} 
				else {
						exist= false;
					}

				}
			
			 
			
		for(int i=0; i<=qualificationData.size()-1;i++){
			
			for(int j=i+1; j<=qualificationData.size()-1;j++){
				
				String title1=qualificationData.get(i).getTitle();
				String title2=qualificationData.get(j).getTitle();
				String titleInMarathi1=qualificationData.get(i).getTitleInMarathi();
				String titleInMarathi2=qualificationData.get(j).getTitleInMarathi();
				if(qualificationData.get(i).getTitle().equalsIgnoreCase(qualificationData.get(j).getTitle()) ||
						qualificationData.get(i).getTitleInMarathi().equalsIgnoreCase(qualificationData.get(j).getTitleInMarathi())){
					throw new DuplicateCheckInQualification();
				}
				
			}
			
		}
		if(exist==true){
			 
			qualificationService.saveListOfQualification(qualificationData);
		}
		
		}
		else{
				 throw new QualificationFileEmptyException();
			 }
		
		return exist;
		
	}
	
	
	
	@Override
	public List<Qualification> findAllActiveQualificationByPriority() {
		return qualificationRepository.findByActiveTrueOrderByPriorityDesc();
	}
	
	@Override
	public Qualification qualificationFromCell(List<Cell> cells) throws Exception{
		
		Qualification qualification=new Qualification();
		Cell cell1 = cells.get(0);
        if (cell1 != null) {
        	cell1.setCellType(Cell.CELL_TYPE_STRING);
        	String title=cell1.getStringCellValue().trim();
        	if(!title.isEmpty()){
        	qualification.setTitle(title);
        	}else{
        		throw new QualificationFileEmptyException();
        	}
        }
        
        Cell cell2 = cells.get(1);
        if (cell2 != null) {
        	cell2.setCellType(Cell.CELL_TYPE_STRING);
        	String titleInMarathi=cell2.getStringCellValue().trim();
        	if(!titleInMarathi.isEmpty()){
        	qualification.setTitleInMarathi(titleInMarathi);
        	}else{
        		throw new QualificationFileEmptyException();
        	}
        }
        
        Cell cell3 = cells.get(2);
        if (cell3 != null) {
        	cell3.setCellType(Cell.CELL_TYPE_STRING);
        	String priorty = String
					.valueOf(cell3.getStringCellValue().trim());
        	if(!priorty.isEmpty()){
        	qualification
			.setPriority((int) Double.parseDouble(priorty));
        	}else{
        		throw new QualificationFileEmptyException();
        	}
        }
        
        Cell cell4 = cells.get(3);
        if (cell4 != null) {
        	cell4.setCellType(Cell.CELL_TYPE_STRING);
        	String active=String.valueOf(cell4.getStringCellValue().trim());
        	if(!active.isEmpty()){
        	if (active.equalsIgnoreCase("true")) {
				qualification.setActive(true);
			} else {
				qualification.setActive(false);
			}
        	}else{
        		throw new QualificationFileEmptyException();
        	}
        }
		return qualification;
		
	}

}


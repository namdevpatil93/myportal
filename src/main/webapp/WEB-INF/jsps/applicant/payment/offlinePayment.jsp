<%@ page contentType="text/html; charset=UTF-8" pageEncoding="ISO-8859-1" %>
<%@ include file="../../common/taglibs.jsp"%>
<div style="padding:0 15px;">
<div class="row">
	<div class="col-sm-12" align="left"> &nbsp;
		<c:if test="${viewChallan != true}">
         	<label><span><a href="#"  onclick="javascript:openInstructionPdf()" ><fmt:message key="offline.payment.viewInstructions"/></a></span></label>
         </c:if>
     </div>
 </div>
 <div class="row">
 <div id="printDiv" class="text-center pull-right">
			    <div>
			        <%-- <input class="btn btn-success" id="print" value="<fmt:message key="print"/>" type="button"  onclick="javascript:printContent('divOffline')" /> --%>
			        <a href="#" class="glyphicon glyphicon-print" onclick="javascript:printContent('divOffline')"></a>
			    </div>
			</div>
<div id="divOffline" class="col-sm-12">
    <div class="row offlinepay">
    	
        <div class="col-sm-12 text-center heading">
            <%-- <fmt:message key="offline.payment.kindly.print.copy"/>: --%>
            
            <p>Application Processing Charges Details<%-- <fmt:message key="offline.payment.header.p1"/> --%></p>
            <p>Cash can be tendered at any branch of State Bank of India<%-- <fmt:message key="offline.payment.header.p2"/> --%></p>
            <p>SBI-SWO-PLEASE GO THROUGH CBS SCREEN - 8888 MENU: PREUPLOADED FEE COLLECTION<%-- <fmt:message key="offline.payment.header.p3"/> --%></p>
        	
        </div>
    </div>
    <br>
    <div class="print-page-break">
		    	<p class="headline text-center">Candidate Copy<%-- <fmt:message key="offline.payment.candidate.copy"/> --%></p>
			    <div class="row">
			    	<table class="table table-bordered">
			    		<tr>
			    			<td>
			    				<label>
			                       Fee Type<%-- <fmt:message key="offline.payment.post.fee.type"/> --%>:
			                    </label>
			                </td>
			    			<td>
			    				${feesType}
			    			</td>
			    			<td>
			    				<label>
			                        Challan date<%-- <fmt:message key="offline.payment.challen.date"/> --%>:
			                    </label>
			    			</td>
			    			<td>
			    				${challanDate}
			    			</td>
			    		</tr>
			    		<tr>
			    			<td>
			    				<label>
			                        Applicant Id<%-- <fmt:message key="applicant.applicationId"/> --%>:
			                    </label>
			                </td>
			    			<td>
			    				${applicant.applicationId}
			    			</td>
			    			<td><label></label></td>
							<td></td>
			    		</tr>
			    		<tr>
			    			<td>
			    				<label>
			    					Registration ID/Reference No<%-- <fmt:message key="challan.registration.reference.id"/> --%>:
			    				</label>
			                </td>
			    			<td>
			    				${applicationNo}
			    			</td>
			    			<td></td>
							<td></td>
			    		</tr>
			    		<%-- <tr>
			    			<td>
			    				<label>
			    					<fmt:message key="challan.msrtc.account.number"/>:
			                    </label>
			                </td>
			                <td>
			    				00000030003055476
			    			</td>
			    			<td></td>
							<td></td>
			    		</tr> --%>
			    		<c:forEach items="${applicantPostAssociation}" var="apa">
			    			<tr>
				    			<td>
				    				<label>
				                        Post Name<%-- <fmt:message key="offline.payment.post.name"/> --%>:
				                    </label>
				                </td>
				    			<td>
				    				${apa.post.postTitle}<%-- <fmt:message key="${apa.post.postTitle}"/> --%>
				    			</td>
				    			<c:choose>
				    				<c:when test="${apa.division ne null }">
						    			<td>
						    				<label>
						                        Division<%-- <fmt:message key="offline.payment.division"/> --%>:
						                    </label>
						    			</td>
						    			<td>
											${apa.division.divisionTitle }<%-- <fmt:message key="${apa.division.divisionTitle }"/> --%>
						    			</td>
				    				</c:when>
				    				<c:otherwise><td></td><td></td></c:otherwise>
				    			</c:choose>
				    		</tr>
			            </c:forEach>
			    		
			    		<tr>
			    			<td>
			    				<label>
			    				      Applicant Name<%-- <fmt:message key="offline.payment.applicant.name"/> --%>:
			                    </label>
			                </td>
			    			<td>
			    				 ${applicant.firstName}&nbsp;${ applicant.middleName}&nbsp;${applicant.lastName}
			    			</td>
			    			<td><label></label></td>
							<td></td>
			    		</tr>
			    		<tr>
			    			<td>
			    				<label>
			                        Date Of Birth<%-- <fmt:message key="applicant.date.of.birth"/> --%>:
			                    </label>
			                </td>
			    			<td>
			    				<tags:localDate pattern="dd/MM/yyyy" date="${applicant.birthDate}" />
			    			</td>
			    			<td><label></label></td>
							<td></td>
			    		</tr>
			    		
			    		<tr>
							<td>
								<label>
									Caste Category<%-- <fmt:message key="offline.payment.applicant.category"/> --%>:
								</label>
							</td>
							<td>
								${applicant.caste.casteTitle} <c:if test="${ isOpenCategoryFeesApplicable }">(Open)</c:if><%-- <fmt:message key="${applicant.caste.casteTitle}"/> --%>
							</td>
							<td><label></label></td>
							<td></td>
						</tr>
						<tr>
							<td>
								<label>
									Application Processing Charges<%-- <fmt:message key="offline.payment.post.fees"/> --%>:
								</label>
							</td>
							<td>
								${postFees}
							</td>
							<td><label></label></td>
							<td></td>
						</tr>
			       		<tr>
							<td>
								<label>
									Bank Charges<%-- <fmt:message key="offline.payment.bank.charges"/> --%>:
								</label>
							</td>
							<td>
								 ${bankCharges}
							</td>
							<td><label></label></td>
							<td></td>
						</tr>
						
						<tr>
							<td>
								<label>
									Total Fees<%-- <fmt:message key="offline.payment.total.fees"/> --%>:
								</label>
							</td>
							<td>
								${totalFees}
							</td>
							<td><label></label></td>
							<td></td>
						</tr>
						
						<tr>
							<td>
								<label>
									Description<%-- <fmt:message key="offline.payment.description"/> --%>:
								</label>
							</td>
							<td>
								MSRTC Recruitment-2019<%-- <fmt:message key="offline.payment.description.value"/> --%>
							</td>
							<td><label></label></td>
							<td></td>
						</tr>
						
						<tr>
							<td>
								<label>
									Last Date Of Payment<%-- <fmt:message key="applicant.last.date.of.payment"/> --%>:
								</label>
							</td>
							<td>
								${lastDateOfPayment}
							</td>
							<td><label></label></td>
							<td></td>
						</tr>
						<tr>
							<td>
								<label>
									Transaction ID:(Bank Journal No.)<%-- <fmt:message key="offline.payment.post.bank.transaction.id"/> --%>:
								</label>
							</td>
							<td>
								<%-- ${feesType} --%>
							</td>
							<td>
								<label></label>
							</td>
							<td></td>
						</tr>
						
						<tr>
							<td>
								<label>
									Deposit Date<%-- <fmt:message key="applicant.offline.payment.deposit.date"/> --%>:
								</label>
							</td>
							<td>
								
							</td>
							<td><label></label></td>
							<td></td>
						</tr>
						<tr>
							<td><label></label></td>
							<td></td>
							<td>
								<label>
									Bank Stamp & Signature<%-- <fmt:message key="offline.payment.bank.stamp.and.signature"/> --%>
								</label>
							</td>
							<td></td>
						</tr>
						
						<tr>
							<td><label></label></td>
							<td></td>
							<td>
								<label>
									Date<%-- <fmt:message key="offline.payment.date"/> --%>
								</label>
							</td>
							<td></td>
						</tr>
			    	</table>
			    </div>
		      
			    <div class="row">
			    	<div class="col-sm-12"><p class="headline  text-center">Denomination of Notes<%-- <fmt:message key="offline.payment.denomination.notes"/> --%></p></div>
			    </div>
			    <div class="row">
			    	<div class="col-sm-12">
			    		<div class="denomination">
			    			<p><span>______________</span> x 500<%-- <fmt:message key="challan.rs.notes.500"/> --%> = <span>______________</span></p>
			    			<p><span>______________</span> x 100<%-- <fmt:message key="challan.rs.notes.100"/> --%> = <span>______________</span></p>
			    			<p><span>______________</span> x 50<%-- <fmt:message key="challan.rs.notes.50"/> --%> &nbsp; = <span>______________</span></p>
			    			<p><span>______________</span> x 10<%-- <fmt:message key="challan.rs.notes.10"/> --%>  = <span>______________</span></p>
			    		</div>
			    	</div>
			    </div>
<!-- 			    <div class="row"> -->
			    	<div class="col-sm-12 denominationsign">
				    	<table style="width:80%;">
				    		<tr>
				    			<th style="width:40%">Bank officer Signature and Stamp<%-- <fmt:message key="challan.bank.officer.signature.stamp"/> --%></th>
				    			<th style="width:40%;text-align: right">Applicant Signature<%-- <fmt:message key="challan.applicant.signature"/> --%></th>
				    		</tr>
				    		<tr>
				    			<td colspan="3"></td>
				    		</tr>
				    	</table>
			    	</div>
<!-- 			    </div> -->
			    <div class="row instructions">
			    	<div class="col-sm-12">
			    		<p class="headline text-center">Important Instructions<%-- <fmt:message key="offline.instruction"/> --%></p>
			    		<ul>
			    			<li>Applicant to ensure that the Transaction ID , Journal No and Deposit date is given by the bank, on the challan copy.<%-- <fmt:message key="offline.instruction.1"/> --%></li>
			    			<li>Candidate should deposit the fee in the bank, two days after generating the challan.<%-- <fmt:message key="offline.instruction.2"/> --%></li>
			    			<li>After payment at the bank, you will receive confirmation of the payment after 48 hrs.</li>
			    			<li>Helpline No. for payment related issue: 1800 121 8414<%-- <fmt:message key="offline.instruction.3"/><fmt:message key="helpline.no"/> --%></li>
			    		</ul>
			    	</div>
			    </div>
		    </div>
	
    <div class="print-page-break">
		    	<p class="headline text-center">S.T.Copy<%-- <fmt:message key="offline.payment.s.t.copy"/> --%></p>
			    <div class="row">
			    	<table class="table table-bordered">
			    		<tr>
			    			<td>
			    				<label>
			                       Fee Type<%-- <fmt:message key="offline.payment.post.fee.type"/> --%>:
			                    </label>
			                </td>
			    			<td>
			    				${feesType}
			    			</td>
			    			<td>
			    				<label>
			                        Challan date<%-- <fmt:message key="offline.payment.challen.date"/> --%>:
			                    </label>
			    			</td>
			    			<td>
			    				${challanDate}
			    			</td>
			    		</tr>
			    		<tr>
			    			<td>
			    				<label>
			                        Applicant Id<%-- <fmt:message key="applicant.applicationId"/> --%>:
			                    </label>
			                </td>
			    			<td>
			    				${applicant.applicationId}
			    			</td>
			    			<td><label></label></td>
							<td></td>
			    		</tr>
			    		<tr>
			    			<td>
			    				<label>
			    					Registration ID/Reference No<%-- <fmt:message key="challan.registration.reference.id"/> --%>:
			    				</label>
			                </td>
			    			<td>
			    				${applicationNo}
			    			</td>
			    			<td></td>
							<td></td>
			    		</tr>
			    		<%-- <tr>
			    			<td>
			    				<label>
			    					<fmt:message key="challan.msrtc.account.number"/>:
			                    </label>
			                </td>
			                <td>
			    				00000030003055476
			    			</td>
			    			<td></td>
							<td></td>
			    		</tr> --%>
			    		<c:forEach items="${applicantPostAssociation}" var="apa">
			    			<tr>
				    			<td>
				    				<label>
				                        Post Name<%-- <fmt:message key="offline.payment.post.name"/> --%>:
				                    </label>
				                </td>
				    			<td>
				    				${apa.post.postTitle}<%-- <fmt:message key="${apa.post.postTitle}"/> --%>
				    			</td>
				    			<c:choose>
				    				<c:when test="${apa.division ne null }">
						    			<td>
						    				<label>
						                        Division<%-- <fmt:message key="offline.payment.division"/> --%>:
						                    </label>
						    			</td>
						    			<td>
											${apa.division.divisionTitle }<%-- <fmt:message key="${apa.division.divisionTitle }"/> --%>
						    			</td>
				    				</c:when>
				    				<c:otherwise><td></td><td></td></c:otherwise>
				    			</c:choose>
				    		</tr>
			            </c:forEach>
			    		
			    		<tr>
			    			<td>
			    				<label>
			    				      Applicant Name<%-- <fmt:message key="offline.payment.applicant.name"/> --%>:
			                    </label>
			                </td>
			    			<td>
			    				 ${applicant.firstName}&nbsp;${ applicant.middleName}&nbsp;${applicant.lastName}
			    			</td>
			    			<td><label></label></td>
							<td></td>
			    		</tr>
			    		<tr>
			    			<td>
			    				<label>
			                        Date Of Birth<%-- <fmt:message key="applicant.date.of.birth"/> --%>:
			                    </label>
			                </td>
			    			<td>
			    				<tags:localDate pattern="dd/MM/yyyy" date="${applicant.birthDate}" />
			    			</td>
			    			<td><label></label></td>
							<td></td>
			    		</tr>
			    		
			    		<tr>
							<td>
								<label>
									Caste Category<%-- <fmt:message key="offline.payment.applicant.category"/> --%>:
								</label>
							</td>
							<td>
								${applicant.caste.casteTitle} <c:if test="${ isOpenCategoryFeesApplicable }">(Open)</c:if><%-- <fmt:message key="${applicant.caste.casteTitle}"/> --%>
							</td>
							<td><label></label></td>
							<td></td>
						</tr>
						<tr>
							<td>
								<label>
									Application Processing Charges<%-- <fmt:message key="offline.payment.post.fees"/> --%>:
								</label>
							</td>
							<td>
								${postFees}
							</td>
							<td><label></label></td>
							<td></td>
						</tr>
			       		<tr>
							<td>
								<label>
									Bank Charges<%-- <fmt:message key="offline.payment.bank.charges"/> --%>:
								</label>
							</td>
							<td>
								 ${bankCharges}
							</td>
							<td><label></label></td>
							<td></td>
						</tr>
						
						<tr>
							<td>
								<label>
									Total Fees<%-- <fmt:message key="offline.payment.total.fees"/> --%>:
								</label>
							</td>
							<td>
								${totalFees}
							</td>
							<td><label></label></td>
							<td></td>
						</tr>
						
						<tr>
							<td>
								<label>
									Description<%-- <fmt:message key="offline.payment.description"/> --%>:
								</label>
							</td>
							<td>
								MSRTC Recruitment-2019<%-- <fmt:message key="offline.payment.description.value"/> --%>
							</td>
							<td><label></label></td>
							<td></td>
						</tr>
						
						<tr>
							<td>
								<label>
									Last Date Of Payment<%-- <fmt:message key="applicant.last.date.of.payment"/> --%>:
								</label>
							</td>
							<td>
								${lastDateOfPayment}
							</td>
							<td><label></label></td>
							<td></td>
						</tr>
						<tr>
							<td>
								<label>
									Transaction ID:(Bank Journal No.)<%-- <fmt:message key="offline.payment.post.bank.transaction.id"/> --%>:
								</label>
							</td>
							<td>
								<%-- ${feesType} --%>
							</td>
							<td>
								<label></label>
							</td>
							<td></td>
						</tr>
						
						<tr>
							<td>
								<label>
									Deposit Date<%-- <fmt:message key="applicant.offline.payment.deposit.date"/> --%>:
								</label>
							</td>
							<td>
								
							</td>
							<td><label></label></td>
							<td></td>
						</tr>
						<tr>
							<td><label></label></td>
							<td></td>
							<td>
								<label>
									Bank Stamp & Signature<%-- <fmt:message key="offline.payment.bank.stamp.and.signature"/> --%>
								</label>
							</td>
							<td></td>
						</tr>
						
						<tr>
							<td><label></label></td>
							<td></td>
							<td>
								<label>
									Date<%-- <fmt:message key="offline.payment.date"/> --%>
								</label>
							</td>
							<td></td>
						</tr>
			    	</table>
			    </div>
		      
			    <div class="row">
			    	<div class="col-sm-12"><p class="headline  text-center">Denomination of Notes<%-- <fmt:message key="offline.payment.denomination.notes"/> --%></p></div>
			    </div>
			    <div class="row">
			    	<div class="col-sm-12">
			    		<div class="denomination">
			    			<p><span>______________</span> x 500<%-- <fmt:message key="challan.rs.notes.500"/> --%> = <span>______________</span></p>
			    			<p><span>______________</span> x 100<%-- <fmt:message key="challan.rs.notes.100"/> --%> = <span>______________</span></p>
			    			<p><span>______________</span> x 50<%-- <fmt:message key="challan.rs.notes.50"/> --%> &nbsp; = <span>______________</span></p>
			    			<p><span>______________</span> x 10<%-- <fmt:message key="challan.rs.notes.10"/> --%>  = <span>______________</span></p>
			    		</div>
			    	</div>
			    </div>
<!-- 			    <div class="row"> -->
			    	<div class="col-sm-12 denominationsign">
				    	<table style="width:80%;">
				    		<tr>
				    			<th style="width:40%">Bank officer Signature and Stamp<%-- <fmt:message key="challan.bank.officer.signature.stamp"/> --%></th>
				    			<th style="width:40%;text-align: right">Applicant Signature<%-- <fmt:message key="challan.applicant.signature"/> --%></th>
				    		</tr>
				    		<tr>
				    			<td colspan="3"></td>
				    		</tr>
				    	</table>
			    	</div>
<!-- 			    </div> -->
			    <div class="row instructions">
			    	<div class="col-sm-12">
			    		<p class="headline text-center">Important Instructions<%-- <fmt:message key="offline.instruction"/> --%></p>
			    		<ul>
			    			<li>Applicant to ensure that the Transaction ID , Journal No and Deposit date is given by the bank, on the challan copy.<%-- <fmt:message key="offline.instruction.1"/> --%></li>
			    			<li>Candidate should deposit the fee in the bank, two days after generating the challan.<%-- <fmt:message key="offline.instruction.2"/> --%></li>
			    			<li>After payment at the bank, you will receive confirmation of the payment after 48 hrs.</li>
			    			<li>Helpline No. for payment related issue: 1800 121 8414<%-- <fmt:message key="offline.instruction.3"/><fmt:message key="helpline.no"/> --%></li>
			    		</ul>
			    	</div>
			    </div>
		    </div>
    <div class="print-page-break">
		    	<p class="headline text-center">Bank Copy<%-- <fmt:message key="offline.payment.bank.comp"/> --%></p>
			    <div class="row">
			    	<table class="table table-bordered">
			    		<tr>
			    			<td>
			    				<label>
			                       Fee Type<%-- <fmt:message key="offline.payment.post.fee.type"/> --%>:
			                    </label>
			                </td>
			    			<td>
			    				${feesType}
			    			</td>
			    			<td>
			    				<label>
			                        Challan date<%-- <fmt:message key="offline.payment.challen.date"/> --%>:
			                    </label>
			    			</td>
			    			<td>
			    				${challanDate}
			    			</td>
			    		</tr>
			    		<tr>
			    			<td>
			    				<label>
			                        Applicant Id<%-- <fmt:message key="applicant.applicationId"/> --%>:
			                    </label>
			                </td>
			    			<td>
			    				${applicant.applicationId}
			    			</td>
			    			<td><label></label></td>
							<td></td>
			    		</tr>
			    		<tr>
			    			<td>
			    				<label>
			    					Registration ID/Reference No<%-- <fmt:message key="challan.registration.reference.id"/> --%>:
			    				</label>
			                </td>
			    			<td>
			    				${applicationNo}
			    			</td>
			    			<td></td>
							<td></td>
			    		</tr>
			    		<%-- <tr>
			    			<td>
			    				<label>
			    					<fmt:message key="challan.msrtc.account.number"/>:
			                    </label>
			                </td>
			                <td>
			    				00000030003055476
			    			</td>
			    			<td></td>
							<td></td>
			    		</tr> --%>
			    		<c:forEach items="${applicantPostAssociation}" var="apa">
			    			<tr>
				    			<td>
				    				<label>
				                        Post Name<%-- <fmt:message key="offline.payment.post.name"/> --%>:
				                    </label>
				                </td>
				    			<td>
				    				${apa.post.postTitle}<%-- <fmt:message key="${apa.post.postTitle}"/> --%>
				    			</td>
				    			<c:choose>
				    				<c:when test="${apa.division ne null }">
						    			<td>
						    				<label>
						                        Division<%-- <fmt:message key="offline.payment.division"/> --%>:
						                    </label>
						    			</td>
						    			<td>
											${apa.division.divisionTitle }<%-- <fmt:message key="${apa.division.divisionTitle }"/> --%>
						    			</td>
				    				</c:when>
				    				<c:otherwise><td></td><td></td></c:otherwise>
				    			</c:choose>
				    		</tr>
			            </c:forEach>
			    		
			    		<tr>
			    			<td>
			    				<label>
			    				      Applicant Name<%-- <fmt:message key="offline.payment.applicant.name"/> --%>:
			                    </label>
			                </td>
			    			<td>
			    				 ${applicant.firstName}&nbsp;${ applicant.middleName}&nbsp;${applicant.lastName}
			    			</td>
			    			<td><label></label></td>
							<td></td>
			    		</tr>
			    		<tr>
			    			<td>
			    				<label>
			                        Date Of Birth<%-- <fmt:message key="applicant.date.of.birth"/> --%>:
			                    </label>
			                </td>
			    			<td>
			    				<tags:localDate pattern="dd/MM/yyyy" date="${applicant.birthDate}" />
			    			</td>
			    			<td><label></label></td>
							<td></td>
			    		</tr>
			    		
			    		<tr>
							<td>
								<label>
									Caste Category<%-- <fmt:message key="offline.payment.applicant.category"/> --%>:
								</label>
							</td>
							<td>
								${applicant.caste.casteTitle} <c:if test="${ isOpenCategoryFeesApplicable }">(Open)</c:if><%-- <fmt:message key="${applicant.caste.casteTitle}"/> --%>
							</td>
							<td><label></label></td>
							<td></td>
						</tr>
						<tr>
							<td>
								<label>
									Application Processing Charges<%-- <fmt:message key="offline.payment.post.fees"/> --%>:
								</label>
							</td>
							<td>
								${postFees}
							</td>
							<td><label></label></td>
							<td></td>
						</tr>
			       		<tr>
							<td>
								<label>
									Bank Charges<%-- <fmt:message key="offline.payment.bank.charges"/> --%>:
								</label>
							</td>
							<td>
								 ${bankCharges}
							</td>
							<td><label></label></td>
							<td></td>
						</tr>
						
						<tr>
							<td>
								<label>
									Total Fees<%-- <fmt:message key="offline.payment.total.fees"/> --%>:
								</label>
							</td>
							<td>
								${totalFees}
							</td>
							<td><label></label></td>
							<td></td>
						</tr>
						
						<tr>
							<td>
								<label>
									Description<%-- <fmt:message key="offline.payment.description"/> --%>:
								</label>
							</td>
							<td>
								MSRTC Recruitment-2019<%-- <fmt:message key="offline.payment.description.value"/> --%>
							</td>
							<td><label></label></td>
							<td></td>
						</tr>
						
						<tr>
							<td>
								<label>
									Last Date Of Payment<%-- <fmt:message key="applicant.last.date.of.payment"/> --%>:
								</label>
							</td>
							<td>
								${lastDateOfPayment}
							</td>
							<td><label></label></td>
							<td></td>
						</tr>
						<tr>
							<td>
								<label>
									Transaction ID:(Bank Journal No.)<%-- <fmt:message key="offline.payment.post.bank.transaction.id"/> --%>:
								</label>
							</td>
							<td>
								<%-- ${feesType} --%>
							</td>
							<td>
								<label></label>
							</td>
							<td></td>
						</tr>
						
						<tr>
							<td>
								<label>
									Deposit Date<%-- <fmt:message key="applicant.offline.payment.deposit.date"/> --%>:
								</label>
							</td>
							<td>
								
							</td>
							<td><label></label></td>
							<td></td>
						</tr>
						<tr>
							<td><label></label></td>
							<td></td>
							<td>
								<label>
									Bank Stamp & Signature<%-- <fmt:message key="offline.payment.bank.stamp.and.signature"/> --%>
								</label>
							</td>
							<td></td>
						</tr>
						
						<tr>
							<td><label></label></td>
							<td></td>
							<td>
								<label>
									Date<%-- <fmt:message key="offline.payment.date"/> --%>
								</label>
							</td>
							<td></td>
						</tr>
			    	</table>
			    </div>
		      
			    <div class="row">
			    	<div class="col-sm-12"><p class="headline  text-center">Denomination of Notes<%-- <fmt:message key="offline.payment.denomination.notes"/> --%></p></div>
			    </div>
			    <div class="row">
			    	<div class="col-sm-12">
			    		<div class="denomination">
			    			<p><span>______________</span> x 500<%-- <fmt:message key="challan.rs.notes.500"/> --%> = <span>______________</span></p>
			    			<p><span>______________</span> x 100<%-- <fmt:message key="challan.rs.notes.100"/> --%> = <span>______________</span></p>
			    			<p><span>______________</span> x 50<%-- <fmt:message key="challan.rs.notes.50"/> --%> &nbsp; = <span>______________</span></p>
			    			<p><span>______________</span> x 10<%-- <fmt:message key="challan.rs.notes.10"/> --%>  = <span>______________</span></p>
			    		</div>
			    	</div>
			    </div>
<!-- 			    <div class="row"> -->
			    	<div class="col-sm-12 denominationsign">
				    	<table style="width:80%;">
				    		<tr>
				    			<th style="width:40%">Bank officer Signature and Stamp<%-- <fmt:message key="challan.bank.officer.signature.stamp"/> --%></th>
				    			<th style="width:40%;text-align: right">Applicant Signature<%-- <fmt:message key="challan.applicant.signature"/> --%></th>
				    		</tr>
				    		<tr>
				    			<td colspan="3"></td>
				    		</tr>
				    	</table>
			    	</div>
<!-- 			    </div> -->
			    <div class="row instructions">
			    	<div class="col-sm-12">
			    		<p class="headline text-center">Important Instructions<%-- <fmt:message key="offline.instruction"/> --%></p>
			    		<ul>
			    			<li>Applicant to ensure that the Transaction ID , Journal No and Deposit date is given by the bank, on the challan copy.<%-- <fmt:message key="offline.instruction.1"/> --%></li>
			    			<li>Candidate should deposit the fee in the bank, two days after generating the challan.<%-- <fmt:message key="offline.instruction.2"/> --%></li>
			    			<li>After payment at the bank, you will receive confirmation of the payment after 48 hrs.</li>
			    			<li>Helpline No. for payment related issue: 1800 121 8414<%-- <fmt:message key="offline.instruction.3"/><fmt:message key="helpline.no"/> --%></li>
			    		</ul>
			    	</div>
			    </div>
			  </div>
</div>
</div>
</div>


<%-- <jsp:include page="offlinePaymentProcess.jsp" /> --%>
<div class="sw-container">
    <div id="applySteps" class="step-content" style="display: block;">
        <jsp:include page="offlinePaymentProcess.jsp" />
    </div>
</div>
<script type="text/javascript">

    function printContent(el)
    {
        var restorepage = $('body').html();
        var printcontent = $('#' + el).clone();
        $('body').empty().html(printcontent);
        window.print();
        $('body').html(restorepage);
    }
    
    function openInstructionPdf(){
    	var url = "<c:url value='/static/app/pdf/${ pageContext.response.locale }/Payment process.pdf'/>";
    	window.open(url,'_blank');
    }

</script>


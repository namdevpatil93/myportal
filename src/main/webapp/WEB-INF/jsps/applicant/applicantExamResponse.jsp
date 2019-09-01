<%@ include file="../common/taglibs.jsp" %>
<%@ page pageEncoding="UTF-8"%>

<div class="row well" style="margin-left: 0%;margin-right: 0%;">
	<div class="col-sm-12">
		<div class="row">
			<div class="col-sm-12" style="color:red">
				<b>In Your Response Section</b>
			</div> 
		</div>
		<div class="row">
			<div class="col-sm-12">
				&nbsp;&nbsp;
			
				<i class="fa fa-check" aria-hidden="true" style="color:#66ff33"></i>:
			
				This indicates your answer is correct (हे सूचित करते की आपले उत्तर बरोबर आहे)
			</div> 
		</div>
		
		<div class="row">
			<div class="col-sm-12">
				&nbsp;&nbsp;
			
				<i class="fa fa-times" aria-hidden="true" style="color:red"></i>&nbsp;:
			
				This indicates your answer is incorrect (हे सूचित करते की आपले उत्तर अयोग्य आहे)
			</div> 
		</div>
		<div class="row">
			<div class="col-sm-12">
				&nbsp;
			</div> 
		</div>
		<div class="row">
			<div class="col-sm-12" style="color:red">
				<b>In Choice Section</b>
			</div> 
		</div>
		<div class="row">
			<div class="col-sm-12">
				&nbsp;&nbsp;
			
				<i class="fa fa-check" aria-hidden="true" style="color:#66ff33"></i>:
			
				This indicates correct answer of the question (या प्रश्नाचे योग्य उत्तर दर्शविते) 
			</div> 
		</div>
	</div> 
</div>


<c:choose>
	<c:when test="${ fn:length(questionList) > 0 }">
	 <c:set value="1" var="counter"/>
	 	<c:forEach var="questions" items="${questionList}">
		 	<div class="mcqs">
				<div class="row question">
					 <div class="col-sm-12"><fmt:message key="applicant.exam.questionNo"/>:${counter}.&nbsp;${questions.questionText}</div> 
					 <c:if test="${ fn:length(questions.questionImages) > 0 }">
							<c:forEach var="quesImage" items="${questions.questionImages}">
								 <div class="col-sm-12"><span><img src="${quesImage}" /></span></div>
							</c:forEach>
					</c:if>
				</div>
					<c:set value="${ counter + 1 }" var="counter"/> 
				<div class="row answers">
					<div class="col-sm-12">
						<div class="multiplechoices">
						<p><fmt:message key="applicant.exam.choice"/>:</p>
						<c:set value="1" var="choiceCounter"/>
						<c:forEach var="choice" items="${questions.choices}">
							<div class="row">
								<div class="col-sm-12">
								    
								    ${choiceCounter}.&nbsp;${choice.choiceText}&nbsp;
								    <c:if test="${choice.correct}">
							            <i class="fa fa-check" aria-hidden="true" style="color:#66ff33"></i>&nbsp;
							        </c:if>
									
								</div>
								
								 <c:if test="${ fn:length(choice.choiceImages) > 0 }">
										<c:forEach var="choiceImage" items="${choice.choiceImages}">
											 <div class="col-sm-12"><span><img src="${choiceImage}" /></span></div>
										</c:forEach>
								</c:if>
							</div>
							<c:set value="${ choiceCounter + 1 }" var="choiceCounter"/>
						</c:forEach>
						</div>
						<div class="multiplechoices">
						<p><fmt:message key="applicant.exam.response"/></p>
							<c:forEach var="questionAnswer" items="${questions.questionAnswers}">
							<div class="row">
								<div class="col-sm-12">
								    ${questionAnswer.answersText}
								    &nbsp;
								    <c:choose>
								        <c:when test="${questionAnswer.correct}">
								            <i class="fa fa-check" aria-hidden="true" style="color:#66ff33"></i>
								        </c:when>
								        <c:otherwise>
								            <i class="fa fa-times" aria-hidden="true" style="color:red"></i>
								        </c:otherwise>
								    </c:choose>
								</div>
								<c:if test="${ fn:length(questionAnswer.answersImages) > 0 }">
									<c:forEach var="ansImage" items="${questionAnswer.answersImages}">
										<div class="col-sm-12"><span> <img src="${ansImage}" /></span></div>
									</c:forEach>
								</c:if>
							</div>
							</c:forEach>
						</div>
					</div>
				</div> 
			</div>
		</c:forEach>
	</c:when>
	<c:otherwise>
	<fmt:message key="applicant.exam.noExamAvailable"/>
		
	</c:otherwise>
</c:choose>


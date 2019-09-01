package com.msrtc.portal.applicant.service

import com.blogspot.toomuchcoding.spock.subjcollabs.Collaborator
import com.blogspot.toomuchcoding.spock.subjcollabs.Subject
import com.msrtc.portal.applicant.dto.AgeValidationCriteria
import com.msrtc.portal.applicant.repository.ApplicantOtherInformationRepository
import com.msrtc.portal.applicant.repository.ApplicantRepository
import com.msrtc.portal.applicant.service.impl.AgeValidatorServiceImpl
import com.msrtc.portal.core.systemsetting.service.SystemSettingService
import spock.lang.Shared
import spock.lang.Specification
import spock.lang.Unroll

import java.time.Period

class AgeValidatorServiceTest extends Specification {

    public static final boolean N = false
    public static final boolean Y = true

    @Shared def OPEN = 1
    @Shared def OBC = 2
    @Shared def ST = 3
    @Shared def SC = 4
    @Shared def VJA = 5
    @Shared def NTB = 6
    @Shared def NTC = 7
    @Shared def NTD = 8
    @Shared def SBC = 9

    @Shared def DRIVER = 1
    @Shared def CLERK_TYPIST  = 3
    @Shared def GM_PROJECT = 19
    @Shared def GM_IT = 20
    @Shared def DRIVER_CUM_CONDUCTOR  = 21

    @Collaborator
    ApplicantRepository applicantRepository = Mock()

    @Collaborator
    ApplicantOtherInformationRepository applicantOtherInformationRepository = Mock()

    @Collaborator
    SystemSettingService systemSettingService = Mock()

    @Subject
    AgeValidatorService ageValidatorService = new AgeValidatorServiceImpl()

    @Unroll
    def "should validate the age of the Applicant with [age=#age |  casteId =#caste | postId=#post | isSportsPerson =#isSportsPerson | isEarthQuakeAffected =#isEarthQuakeAffected | isProjectAffected=#isProjectAffected | isPartTimeEmployee =#isPartTimeEmployee | isExServiceMan =#isExServiceMan | isExServiceMan =#exServiceManExpYears | exServiceManExpMonths=#exServiceManExpMonths | isStEmployee=#isStEmployee] Result = isAgeWithinRange=#isAgeWithinRange"() {
        expect:

        AgeValidationCriteria criteria = new AgeValidationCriteria(age,
                caste,
                post,
                isSportsPerson,
                isEarthQuakeAffected,
                isProjectAffected,
                isPartTimeEmployee,
                isExServiceMan,
                exServiceManExpYears,
                exServiceManExpMonths,
                isStEmployee)

        ageValidatorService.isAgeWithinRange(criteria, false) == isAgeWithinRange

        where:
            age                  | caste   | post                 | isSportsPerson | isEarthQuakeAffected | isProjectAffected | isPartTimeEmployee | isExServiceMan | exServiceManExpYears | exServiceManExpMonths | isStEmployee || isAgeWithinRange
            Period.of(18,0,0)    | OPEN    | DRIVER               | N              | N                    | N                 | N                  | N              |0                     |0                      | N            || N
            Period.of(24,0,0)    | OPEN    | DRIVER               | N              | N                    | N                 | N                  | N              |0                     |0                      | N            || Y
            Period.of(38,0,0)    | OPEN    | DRIVER               | N              | N                    | N                 | N                  | N              |0                     |0                      | N            || Y
            Period.of(43,0,0)    | OPEN    | DRIVER               | Y              | N                    | N                 | N                  | N              |0                     |0                      | N            || Y
            Period.of(45,0,0)    | OPEN    | DRIVER               | N              | Y                    | N                 | N                  | N              |0                     |0                      | N            || Y
            Period.of(45,0,0)    | OPEN    | DRIVER               | N              | N                    | Y                 | N                  | N              |0                     |0                      | N            || Y
            Period.of(46,0,0)    | OPEN    | DRIVER               | N              | N                    | N                 | Y                  | N              |0                     |0                      | N            || Y
            Period.of(100,0,0)   | OPEN    | DRIVER               | N              | N                    | N                 | N                  | N              |0                     |0                      | Y            || Y
            Period.of(25,0,0)    | OPEN    | DRIVER               | N              | N                    | N                 | N                  | N              |0                     |0                      | N            || Y
            Period.of(50,0,0)    | OPEN    | DRIVER               | N              | N                    | N                 | N                  | N              |0                     |0                      | N            || N
            Period.of(43,0,0)    | OPEN    | DRIVER               | N              | N                    | N                 | N                  | N              |0                     |0                      | N            || N
            Period.of(39,0,0)    | OPEN    | DRIVER               | N              | N                    | N                 | N                  | Y              |2                     |10                     | N            || Y
            Period.of(43,10,0)   | OPEN    | DRIVER               | N              | N                    | N                 | N                  | Y              |2                     |10                     | N            || Y
            Period.of(43,10,1)   | OPEN    | DRIVER               | N              | N                    | N                 | N                  | Y              |2                     |10                     | N            || N
            Period.of(18,0,0)    | OPEN    | DRIVER_CUM_CONDUCTOR | N              | N                    | N                 | N                  | N              |0                     |0                      | N            || N
            Period.of(24,0,0)    | OPEN    | DRIVER_CUM_CONDUCTOR | N              | N                    | N                 | N                  | N              |0                     |0                      | N            || Y
            Period.of(38,0,0)    | OPEN    | DRIVER_CUM_CONDUCTOR | N              | N                    | N                 | N                  | N              |0                     |0                      | N            || Y
            Period.of(43,0,0)    | OPEN    | DRIVER_CUM_CONDUCTOR | Y              | N                    | N                 | N                  | N              |0                     |0                      | N            || Y
            Period.of(45,0,0)    | OPEN    | DRIVER_CUM_CONDUCTOR | N              | Y                    | N                 | N                  | N              |0                     |0                      | N            || Y
            Period.of(45,0,0)    | OPEN    | DRIVER_CUM_CONDUCTOR | N              | N                    | Y                 | N                  | N              |0                     |0                      | N            || Y
            Period.of(46,0,0)    | OPEN    | DRIVER_CUM_CONDUCTOR | N              | N                    | N                 | Y                  | N              |0                     |0                      | N            || Y
            Period.of(100,0,0)   | OPEN    | DRIVER_CUM_CONDUCTOR | N              | N                    | N                 | N                  | N              |0                     |0                      | Y            || Y
            Period.of(25,0,0)    | OPEN    | DRIVER_CUM_CONDUCTOR | N              | N                    | N                 | N                  | N              |0                     |0                      | N            || Y
            Period.of(50,0,0)    | OPEN    | DRIVER_CUM_CONDUCTOR | N              | N                    | N                 | N                  | N              |0                     |0                      | N            || N
            Period.of(43,0,0)    | OPEN    | DRIVER_CUM_CONDUCTOR | N              | N                    | N                 | N                  | N              |0                     |0                      | N            || N
            Period.of(17,0,0)    | OPEN    | CLERK_TYPIST         | N              | N                    | N                 | N                  | N              |0                     |0                      | N            || N
            Period.of(18,0,0)    | OPEN    | CLERK_TYPIST         | N              | N                    | N                 | N                  | N              |0                     |0                      | N            || Y
            Period.of(24,0,0)    | OPEN    | CLERK_TYPIST         | N              | N                    | N                 | N                  | N              |0                     |0                      | N            || Y
            Period.of(38,0,0)    | OPEN    | CLERK_TYPIST         | N              | N                    | N                 | N                  | N              |0                     |0                      | N            || Y
            Period.of(40,0,0)    | OPEN    | CLERK_TYPIST         | N              | N                    | N                 | N                  | N              |0                     |0                      | N            || N
            Period.of(43,0,0)    | OPEN    | CLERK_TYPIST         | Y              | N                    | N                 | N                  | N              |0                     |0                      | N            || Y
            Period.of(45,0,0)    | OPEN    | CLERK_TYPIST         | N              | Y                    | N                 | N                  | N              |0                     |0                      | N            || Y
            Period.of(45,0,0)    | OPEN    | CLERK_TYPIST         | N              | N                    | Y                 | N                  | N              |0                     |0                      | N            || Y
            Period.of(46,0,0)    | OPEN    | CLERK_TYPIST         | N              | N                    | N                 | Y                  | N              |0                     |0                      | N            || Y
            Period.of(100,0,0)   | OPEN    | CLERK_TYPIST         | N              | N                    | N                 | N                  | N              |0                     |0                      | Y            || Y
            Period.of(25,0,0)    | OPEN    | CLERK_TYPIST         | N              | N                    | N                 | N                  | N              |0                     |0                      | N            || Y
            Period.of(50,0,0)    | OPEN    | CLERK_TYPIST         | N              | N                    | N                 | N                  | N              |0                     |0                      | N            || N
            Period.of(43,0,0)    | OPEN    | CLERK_TYPIST         | N              | N                    | N                 | N                  | N              |0                     |0                      | N            || N
            Period.of(17,0,0)    | OPEN    | GM_PROJECT           | N              | N                    | N                 | N                  | N              |0                     |0                      | N            || N
            Period.of(17,0,0)    | OPEN    | GM_IT                | N              | N                    | N                 | N                  | N              |0                     |0                      | N            || N
            Period.of(23,11,31)  | OPEN    | GM_PROJECT           | N              | N                    | N                 | N                  | N              |0                     |0                      | N            || N
            Period.of(23,11,31)  | OPEN    | GM_IT                | N              | N                    | N                 | N                  | N              |0                     |0                      | N            || N
            Period.of(24,0,0)    | OPEN    | GM_PROJECT           | N              | N                    | N                 | N                  | N              |0                     |0                      | N            || Y
            Period.of(24,0,0)    | OPEN    | GM_IT                | N              | N                    | N                 | N                  | N              |0                     |0                      | N            || Y
            Period.of(24,10,0)   | OPEN    | GM_PROJECT           | N              | N                    | N                 | N                  | N              |0                     |0                      | N            || Y
            Period.of(24,0,10)   | OPEN    | GM_IT                | N              | N                    | N                 | N                  | N              |0                     |0                      | N            || Y
            Period.of(38,0,0)    | OPEN    | GM_PROJECT           | N              | N                    | N                 | N                  | N              |0                     |0                      | N            || Y
            Period.of(38,0,0)    | OPEN    | GM_IT                | N              | N                    | N                 | N                  | N              |0                     |0                      | N            || Y
            Period.of(45,0,0)    | OPEN    | GM_PROJECT           | N              | N                    | N                 | N                  | N              |0                     |0                      | N            || Y
            Period.of(45,0,0)    | OPEN    | GM_IT                | N              | N                    | N                 | N                  | N              |0                     |0                      | N            || Y
            Period.of(45,1,0)    | OPEN    | GM_PROJECT           | N              | N                    | N                 | N                  | N              |0                     |0                      | N            || N
            Period.of(45,0,1)    | OPEN    | GM_IT                | N              | N                    | N                 | N                  | N              |0                     |0                      | N            || N
            Period.of(45,1,0)    | SC      | GM_PROJECT           | N              | N                    | N                 | N                  | N              |0                     |0                      | N            || Y
            Period.of(45,0,1)    | SC      | GM_IT                | N              | N                    | N                 | N                  | N              |0                     |0                      | N            || Y
            Period.of(50,0,0)    | SC      | GM_PROJECT           | N              | N                    | N                 | N                  | N              |0                     |0                      | N            || Y
            Period.of(50,0,0)    | SC      | GM_IT                | N              | N                    | N                 | N                  | N              |0                     |0                      | N            || Y
            Period.of(50,1,0)    | SC      | GM_PROJECT           | N              | N                    | N                 | N                  | N              |0                     |0                      | N            || N
            Period.of(50,0,1)    | SC      | GM_IT                | N              | N                    | N                 | N                  | N              |0                     |0                      | N            || N
            Period.of(150,0,1)   | SC      | GM_IT                | N              | N                    | N                 | N                  | N              |0                     |0                      | Y            || N
            Period.of(18,0,0)    | OPEN    | CLERK_TYPIST         | N              | N                    | N                 | N                  | N              |0                     |0                      | N            || Y
            Period.of(150,0,1)   | SC      | GM_IT                | Y              | Y                    | Y                 | Y                  | Y              |1                     |9                      | Y            || N
            Period.of(45,0,0)    | OPEN    | GM_IT                | Y              | Y                    | Y                 | Y                  | Y              |1                     |9                      | Y            || Y
            Period.of(45,0,1)    | OPEN    | GM_IT                | Y              | Y                    | Y                 | Y                  | Y              |1                     |9                      | Y            || N
            Period.of(50,0,0)    | SC      | GM_IT                | Y              | Y                    | Y                 | Y                  | Y              |1                     |9                      | Y            || Y
            Period.of(51,0,0)    | SC      | GM_IT                | Y              | Y                    | Y                 | Y                  | Y              |1                     |9                      | Y            || N
            Period.of(42,4,0)    | VJA     | DRIVER               | N              | N                    | N                 | N                  | N              |0                     |0                      | N            || Y
            Period.of(43,0,0)    | SC      | DRIVER               | N              | N                    | N                 | N                  | N              |0                     |0                      | N            || Y
            Period.of(43,0,0)    | SC      | DRIVER_CUM_CONDUCTOR | N              | N                    | N                 | N                  | N              |0                     |0                      | N            || Y
            Period.of(43,0,0)    | SC      | CLERK_TYPIST         | N              | N                    | N                 | N                  | N              |0                     |0                      | N            || Y

    }



}
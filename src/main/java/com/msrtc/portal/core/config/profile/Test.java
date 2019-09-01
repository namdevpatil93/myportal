package com.msrtc.portal.core.config.profile;

import com.msrtc.portal.core.common.util.Constants;
import org.springframework.context.annotation.Profile;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Target({ElementType.TYPE, ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Profile(Test.NAME)
public @interface Test {
	String NAME = Constants.SPRING_PROFILE_TEST;
}
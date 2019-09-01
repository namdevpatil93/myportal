package com.msrtc.portal.core.config;

import com.msrtc.portal.core.common.filter.SessionFixationProtectionFilter;
import com.msrtc.portal.core.user.security.LoginFailureHandlerImpl;
import com.msrtc.portal.core.user.security.LoginSuccessHandlerImpl;
import org.jasypt.digest.PooledStringDigester;
import org.jasypt.salt.RandomSaltGenerator;
import org.jasypt.springsecurity3.authentication.encoding.PasswordEncoder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.access.AccessDecisionManager;
import org.springframework.security.access.AccessDecisionVoter;
import org.springframework.security.access.vote.AuthenticatedVoter;
import org.springframework.security.access.vote.UnanimousBased;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.access.expression.WebExpressionVoter;

import com.msrtc.portal.core.user.security.AccessDecisionVoterImpl;
import com.msrtc.portal.core.user.security.LogoutSuccessHandlerImpl;
import org.springframework.security.web.session.SessionManagementFilter;

import java.util.ArrayList;
import java.util.List;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true, securedEnabled = true)
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

	@Autowired
	private UserDetailsService userDetailsService;

    @Autowired
    private AccessDecisionManager accessDecisionManager;

    @Autowired
    private ApplicationProperties applicationProperties;

    @Bean
    public Integer applicationSessionTimeout(){
        return applicationProperties.getSecurity().getSessionTimeout();
    }

    @Bean
    @Autowired
    public AccessDecisionManager accessDecisionManager(AccessDecisionVoterImpl accessDecisionVoter) {
        List<AccessDecisionVoter<?>> accessDecisionVoters = new ArrayList<AccessDecisionVoter<?>>();
        accessDecisionVoters.add(new WebExpressionVoter());
		accessDecisionVoters.add(new AuthenticatedVoter());
		accessDecisionVoters.add(accessDecisionVoter);
        UnanimousBased accessDecisionManager = new UnanimousBased(accessDecisionVoters);
		return accessDecisionManager;
    }

	@Override
	@Autowired
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(userDetailsService).passwordEncoder(passwordEncoder());
	}

	@Bean
	public PasswordEncoder passwordEncoder(){
		PasswordEncoder passwordEncoder = new PasswordEncoder();
		passwordEncoder.setStringDigester(stringDigester());
		return passwordEncoder;
	}
	
	@Bean
	public PooledStringDigester stringDigester() {
		PooledStringDigester psd = new PooledStringDigester();

		psd.setPoolSize(2);
		psd.setAlgorithm("SHA-256");
		psd.setIterations(1000);
		psd.setSaltSizeBytes(16);
		psd.setSaltGenerator(randomSaltGenerator());

		return psd;
	}

	@Bean
	public RandomSaltGenerator randomSaltGenerator() {
		RandomSaltGenerator randomSaltGenerator = new RandomSaltGenerator();
		return randomSaltGenerator;
	}

	@Override
	public void configure(WebSecurity web) throws Exception {
		// web.debug(true);
        web.ignoring()
                .antMatchers("/static/**")
                .antMatchers("/i18n/**");
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http
			.exceptionHandling()
                .accessDeniedPage("/accessDenied")
				.and()
				.csrf()
				.ignoringAntMatchers("/payment/**").and()
				.authorizeRequests()
				.accessDecisionManager(accessDecisionManager)
                .antMatchers("/").permitAll()
				.antMatchers("/applicant/showRegistrationPage**").permitAll()
                .antMatchers("/applicant/register**").permitAll()
				.antMatchers("/adminLogin**").permitAll()
				.antMatchers("/showAdminLogin**").permitAll()
				.antMatchers("/recruitmentFee").permitAll()
                .antMatchers("/importantInformation").permitAll()
                .antMatchers("/instructionForRegistration").permitAll()
                .antMatchers("/timetable").permitAll()
                .antMatchers("/aboutUs").permitAll()
				.antMatchers("/error**").permitAll()
                .antMatchers("/checkLogin/**").permitAll()
				.antMatchers("/checkLogin**").permitAll()
				.antMatchers("/applicant/forgotPasswordForm").permitAll()
                .antMatchers("/applicant/saveForgotPasswordForm").permitAll()
                .antMatchers("/applicant/handleForgotPassword").permitAll()
                .antMatchers("/applicant/saveUpdatedPasswordForm").permitAll()
				.antMatchers("/payment/handleServerToServerPaymentResponse").permitAll()
				.antMatchers("/file/viewPdf**").permitAll()
				.antMatchers("/file/viewAdvertisement**").permitAll()
				.antMatchers("/result").permitAll()
				.antMatchers("/captcha").permitAll()
				.antMatchers("/documents/viewAnnouncementList").permitAll()
				.antMatchers("/viewAnnouncementList").permitAll()
				.anyRequest().fullyAuthenticated()
				.and()
			.formLogin()
				.loginPage("/")
				.loginProcessingUrl("/checkLogin")
				//.successForwardUrl("/dashboard")
				.successHandler(new LoginSuccessHandlerImpl())
//				.defaultSuccessUrl("/dashboard")
                .failureHandler(new LoginFailureHandlerImpl())
                .usernameParameter("username")
				.passwordParameter("password")
				.permitAll()
		        .and()
		        .headers().frameOptions().sameOrigin()
			    .and()
			.logout()
				.logoutUrl("/logout")
				.logoutSuccessHandler(new LogoutSuccessHandlerImpl())
				.permitAll()
		        .and()
            .sessionManagement()
				.sessionFixation().none()
                .maximumSessions(1)/*.expiredUrl("/")*/;

			http.addFilterBefore(sessionFixationProtectionFilter(), SessionManagementFilter.class);
	}

	@Bean(name = "sessionFixationProtectionFilter")
	public SessionFixationProtectionFilter sessionFixationProtectionFilter(){
		final SessionFixationProtectionFilter sessionFixationProtectionFilter = new SessionFixationProtectionFilter();
		return sessionFixationProtectionFilter;
	}

	@Bean(name = "authenticationFilterRegistration")
	public FilterRegistrationBean myAuthenticationFilterRegistration(final SessionFixationProtectionFilter sessionFixationProtectionFilter) {
		final FilterRegistrationBean filterRegistrationBean = new FilterRegistrationBean();
		filterRegistrationBean.setFilter(sessionFixationProtectionFilter);
		filterRegistrationBean.setEnabled(false);
		return filterRegistrationBean;
	}

}

package com.msrtc.portal.core.config;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Locale;

import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.format.FormatterRegistry;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;
import org.springframework.web.servlet.view.UrlBasedViewResolver;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesView;

import com.msrtc.portal.core.common.interceptor.MenuOptionParamInterceptor;
import com.msrtc.portal.core.common.interceptor.SecurityHeadersInterceptor;
import com.msrtc.portal.core.common.util.LocalDateFormatter;
import com.msrtc.portal.core.common.util.LocalDateTimeFormatter;

@Configuration
@EnableScheduling
public class WebMvcConfig extends WebMvcConfigurerAdapter {

	private static final String MESSAGE_SOURCE = "/i18n/messages";
	private static final String TILES_DEFINITIONS = "/WEB-INF/tiles/*-tiles.xml";
	private static final String LOCALE_EN = "en";
	private static final String LOCALE_MR = "mr";
	private static final String LANG_PARAM = "lang";

	@Bean
	public UrlBasedViewResolver viewResolver() {
		UrlBasedViewResolver viewResolver = new UrlBasedViewResolver();
		viewResolver.setViewClass(TilesView.class);
		return viewResolver;
	}

	@Bean
	public TilesConfigurer tilesConfigurer() {
		TilesConfigurer tilesConfigurer = new TilesConfigurer();
		tilesConfigurer.setDefinitions(new String[] { TILES_DEFINITIONS });
		tilesConfigurer.setCheckRefresh(true);
		return tilesConfigurer;
	}

	@Bean
	public MessageSource messageSource() {
		ReloadableResourceBundleMessageSource messageSource = new ReloadableResourceBundleMessageSource();
		messageSource.setBasename(MESSAGE_SOURCE);
		messageSource.setDefaultEncoding("UTF-8");
		messageSource.setFallbackToSystemLocale(false);
		return messageSource;
	}

	@Bean
	public LocaleResolver localeResolver() {
		SessionLocaleResolver resolver = new SessionLocaleResolver();
		resolver.setDefaultLocale(new Locale(LOCALE_MR));
		return resolver;
	}

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		LanguageExceptionHandler localeChangeInterceptor = new LanguageExceptionHandler();
        localeChangeInterceptor.setParamName(LANG_PARAM);
		registry.addInterceptor(localeChangeInterceptor);
		registry.addInterceptor(new MenuOptionParamInterceptor());
		registry.addInterceptor(new SecurityHeadersInterceptor());
	}

	@Override
	public void addFormatters(FormatterRegistry formatterRegistry){
		formatterRegistry.addFormatterForFieldType(LocalDate.class, new LocalDateFormatter());
		formatterRegistry.addFormatterForFieldType(LocalDateTime.class, new LocalDateTimeFormatter());
	}

}


package com.msrtc.portal.core.config;

import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * Properties specific to the Applicant.
 *
 * <p>
 *     Properties are configured in the applicant.yml file.
 * </p>
 */
@ConfigurationProperties(prefix = "application", ignoreUnknownFields = false)
public class ApplicationProperties {

    private final Security security = new Security();
    private final Mail mail = new Mail();
    private final Resources resources = new Resources();
    private final BillDeskPaymentGateway billDeskPaymentGateway = new BillDeskPaymentGateway();

    public Security getSecurity() {
        return this.security;
    }

    public Mail getMail() {
        return this.mail;
    }

    public Resources getResources() {
        return this.resources;
    }

    public BillDeskPaymentGateway getBillDeskPaymentGateway() {
        return this.billDeskPaymentGateway;
    }

    public static class Security {

        // Session Timeout in minutes
        private int sessionTimeout = 30;

        public void setSessionTimeout(int sessionTimeout) {
            this.sessionTimeout = sessionTimeout;
        }

        public int getSessionTimeout() {
            return sessionTimeout;
        }
    }

    public static class Mail {

        private String from = "noreply@msrtcexam.in";

        public String getFrom() {
            return from;
        }

        public void setFrom(String from) {
            this.from = from;
        }
    }

    public static class Resources {

        private String basePath = "";
        private String epassBasePath = "";

        public String getBasePath() {
            return basePath;
        }

        public void setBasePath(String basePath) {
            this.basePath = basePath;
        }

        public String getEpassBasePath() {
            return epassBasePath;
        }

        public void setEpassBasePath(String epassBasePath) {
            this.epassBasePath = epassBasePath;
        }
    }

    public static class BillDeskPaymentGateway {

        private String checksumKey;

        private String securityId;

        private String billDeskURL;

        private String queryApiUrl;

        private String merchantId;

        public String getChecksumKey() {
            return checksumKey;
        }

        public void setChecksumKey(String checksumKey) {
            this.checksumKey = checksumKey;
        }

        public String getSecurityId() {
            return securityId;
        }

        public void setSecurityId(String securityId) {
            this.securityId = securityId;
        }

        public String getBillDeskURL() {
            return billDeskURL;
        }

        public void setBillDeskURL(String billDeskURL) {
            this.billDeskURL = billDeskURL;
        }

        public String getMerchantId() {
            return merchantId;
        }

        public void setMerchantId(String merchantId) {
            this.merchantId = merchantId;
        }

        public String getQueryApiUrl() {
            return queryApiUrl;
        }

        public void setQueryApiUrl(String queryApiUrl) {
            this.queryApiUrl = queryApiUrl;
        }
    }


}
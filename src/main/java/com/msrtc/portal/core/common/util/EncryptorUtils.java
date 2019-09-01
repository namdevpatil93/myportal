package com.msrtc.portal.core.common.util;

import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;

public class EncryptorUtils {

    private final static String seed = "vQ10N+kETU5GKMqo";

    private EncryptorUtils(){

    }

    public static String encrypt(String value){
        StandardPBEStringEncryptor encryptor = new StandardPBEStringEncryptor();
        encryptor.setPassword(seed);
        String encrypted= encryptor.encrypt(value);
        return encrypted;
    }

    public static String decrypt(String encrypted){
        StandardPBEStringEncryptor encryptor = new StandardPBEStringEncryptor();
        encryptor.setPassword(seed);
        String decrypted = encryptor.decrypt(encrypted);
        return decrypted;
    }

}

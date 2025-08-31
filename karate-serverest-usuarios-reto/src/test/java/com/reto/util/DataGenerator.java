package com.reto.util;

import java.util.UUID;

public class DataGenerator {

    public static String nombre() {
        return "User-" + UUID.randomUUID().toString().substring(0, 5);
    }

    public static String email() {
        return "user_" + UUID.randomUUID().toString().substring(0, 8) + "@mail.com";
    }

    public static String password() {
        return "Pwd@" + UUID.randomUUID().toString().substring(0, 4);
    }
}

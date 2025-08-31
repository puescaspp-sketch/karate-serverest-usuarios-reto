package com.reto.tests;

import com.intuit.karate.junit5.Karate;

class UsuariosTest {

    @Karate.Test
    Karate testUsuarios() {
        // ejecuta todos los .feature dentro de features/usuarios
        return Karate.run("classpath:features/usuarios").relativeTo(getClass());
    }
}

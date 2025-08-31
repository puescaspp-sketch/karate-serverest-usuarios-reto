Feature: Eliminar usuario
  Background:
    * url baseUrl
    * def DataGen = Java.type('com.reto.util.DataGenerator')
    * def nombre = DataGen.nombre()
    * def email = DataGen.email()
    * def password = DataGen.password()

  Scenario: Crear y eliminar usuario (200)
    Given path '/usuarios'
    And request { nome: '#(nombre)', email: '#(email)', password: '#(password)', administrador: 'true' }
    When method post
    Then status 201
    * def id = response._id

    Given path '/usuarios', id
    When method delete
    Then status 200
    And match response contains { message: '#string' }

  Scenario: Eliminar usuario inexistente (200 o 404 según API)
    Given path '/usuarios', 'id-que-no-existe'
    When method delete
    Then status 200
    And match response contains { message: '#string' }

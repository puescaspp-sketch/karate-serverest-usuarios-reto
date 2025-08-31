Feature: Buscar usuario por ID
  Background:
    * url baseUrl
    * def DataGen = Java.type('com.reto.util.DataGenerator')
    * def nombre = DataGen.nombre()
    * def email = DataGen.email()
    * def password = DataGen.password()

  Scenario: Crear y consultar usuario por ID (200)
    Given path '/usuarios'
    And request { nome: '#(nombre)', email: '#(email)', password: '#(password)', administrador: 'true' }
    When method post
    Then status 201
    * def id = response._id

    Given path '/usuarios', id
    When method get
    Then status 200
    And match response contains { _id: '#(id)', nome: '#string', email: '#string' }

  Scenario: Consultar usuario inexistente (400 o 404)
    Given path '/usuarios/123'
    When method get
    Then status 400
    And match response contains { id: '#string' }

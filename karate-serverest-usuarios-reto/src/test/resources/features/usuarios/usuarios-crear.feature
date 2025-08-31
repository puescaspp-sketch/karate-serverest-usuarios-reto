Feature: Crear usuarios
  Background:
    * url baseUrl
    * def DataGen = Java.type('com.reto.util.DataGenerator')
    * def nombre = DataGen.nombre()
    * def email = DataGen.email()
    * def password = DataGen.password()

  Scenario: Crear usuario válido (201)
    Given path '/usuarios'
    And request { nome: '#(nombre)', email: '#(email)', password: '#(password)', administrador: 'true' }
    When method post
    Then status 201
    And match response contains { message: 'Cadastro realizado com sucesso', _id: '#string' }
    * def newId = response._id

  Scenario: No permitir email duplicado (400)
    Given path '/usuarios'
    And request { nome: 'Usuario Duplicado', email: 'duplicado@example.com', password: 'Pwd@123', administrador: 'true' }
    When method post
    Then status 400
    * def repeatedId = response._id
    Given path '/usuarios'
    And request { nome: 'Usuario Duplicado', email: 'duplicado@example.com', password: 'Pwd@123', administrador: 'true' }
    When method post
    Then status 400
    And match response contains { message: '#string' }

Feature: Actualizar usuario
  Background:
    * url baseUrl
    * def DataGen = Java.type('com.reto.util.DataGenerator')
    * def nombre = DataGen.nombre()
    * def email = DataGen.email()
    * def password = DataGen.password()

  Scenario: Actualizar un usuario existente (200)
    # Crear
    Given path '/usuarios'
    And request { nome: '#(nombre)', email: '#(email)', password: '#(password)', administrador: 'true' }
    When method post
    Then status 201
    * def id = response._id

    # Actualizar
    Given path '/usuarios', id
    And request { nome: '#(nombre) Editado', email: '#(email)', password: '#(password)', administrador: 'true' }
    When method put
    Then status 200
    And match response contains { message: '#string' }

  Scenario: Intentar actualizar con email ya usado (400)
    # Crear usuario A
    * def emailA = DataGen.email()
    Given path '/usuarios'
    And request { nome: 'Usuario A', email: '#(emailA)', password: 'Pwd@123', administrador: 'true' }
    When method post
    Then status 201
    * def idA = response._id

    # Crear usuario B
    * def emailB = DataGen.email()
    Given path '/usuarios'
    And request { nome: 'Usuario B', email: '#(emailB)', password: 'Pwd@123', administrador: 'true' }
    When method post
    Then status 201
    * def idB = response._id

    # Actualizar B con email A (debería fallar)
    Given path '/usuarios', idB
    And request { nome: 'Usuario B', email: '#(emailA)', password: 'Pwd@123', administrador: 'true' }
    When method put
    Then status 400
    And match response contains { message: '#string' }

Feature: Autenticación para operaciones protegidas

  Background:
    * url baseUrl

  Scenario: Obtener token con credenciales ADMIN_EMAIL / ADMIN_PASSWORD
    Given path '/login'
    And request { email: '#(adminEmail)', password: '#(adminPassword)' }
    When method post
    Then status 200
    And match response contains { authorization: '#string' }
    * def token = response.authorization

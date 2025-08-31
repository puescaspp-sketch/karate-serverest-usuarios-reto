Feature: Listar usuarios
  Background:
    * url baseUrl
    * path '/usuarios'

  @smoke
  Scenario: Listar todos los usuarios (200)
    When method get
    Then status 200
    And match response contains { quantidade: '#number', usuarios: '#[]' }
    And match each response.usuarios contains { _id: '#string', nome: '#string', email: '#string' }

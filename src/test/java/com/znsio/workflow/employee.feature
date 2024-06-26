@prod @getEmployees
Feature: Query Employee APIs using read

  Background:
    Given def getEmployeeResponse = read('classpath:com/znsio/templates/employeeTemplates.feature@t_getEmployees')

  Scenario: Get list of all employees by calling Java function
    Given print "Get list of all employees by calling Java function"
    And def employeeJavaId = karate.call('classpath:com/znsio/common/CommonFunctions.feature@generateRandomNumberInRange', {'min': 5, 'max': 50}).generated
    And print "employeeId generated by calling Java class: " + employeeJavaId
    When print "Get employee details for employeeId: " + employeeJavaId
    And def employeeResponse = call getEmployeeResponse {'empId': #(employeeJavaId) }
    Then print "received empId: ", employeeResponse.empId
    Then print "response from getEmployees: ", employeeResponse.response
    And match employeeResponse.empId == employeeJavaId

  Scenario: Get list of all employees by calling common function
    And print "Get list of all employees by calling common function"
    Given def employeeCommonId = randomNumberInRange(51,100)
    And print "employeeId generated by calling common function: " + employeeCommonId
    When print "Get employee details for employeeId: " + employeeCommonId
    And def employeeResponseCommon = call getEmployeeResponse {'empId': #(employeeCommonId) }
    Then print "received empId: ", employeeResponseCommon.empId
    Then print "response from getEmployees: ", employeeResponseCommon.response
    And match employeeResponseCommon.empId == employeeCommonId

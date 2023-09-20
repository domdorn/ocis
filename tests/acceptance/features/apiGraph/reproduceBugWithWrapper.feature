@env-config
Feature: 
  Reproduse bug

  Background:
    Given these users have been created with default attributes and without skeleton files:
      | username |
      | Alice    |
      | Brian    |
      | Bob      |
    And the config "OCIS_SHARING_PUBLIC_WRITEABLE_SHARE_MUST_HAVE_PASSWORD" has been set to "true"
    And the administrator has assigned the role "Space Admin" to user "Alice" using the Graph API
    And the administrator has assigned the role "Space Admin" to user "Brian" using the Graph API
    And the administrator has assigned the role "Space Admin" to user "Bob" using the Graph API
    And user "Alice" has created a space "Project-al" with the default quota using the GraphApi
    And user "Brian" has created a space "Project-br" with the default quota using the GraphApi
    And user "Bob" has created a space "Project-bo" with the default quota using the GraphApi


# TRYing to Reproduse BUG in rhe config
  Scenario Outline: test1
    Given using OCS API version "<ocs-api-version>"
    #  restart server
    And the config "OCIS_SHARING_PUBLIC_WRITEABLE_SHARE_MUST_HAVE_PASSWORD" has been set to "true"
    And user "Alice" has uploaded a file inside space "Project-al" with content "some content" to "test.txt"
    And user "Alice" has uploaded file with content "ownCloud test text file 0" to "/textfile0.txt"
    Then the content of file "/textfile0.txt" for user "Alice" should be "ownCloud test text file 0" 
    #  restart server
    Given the config "FRONTEND_PASSWORD_POLICY_MIN_CHARACTERS" has been set to "true"
    And user "Brian" has uploaded a file inside space "Project-br" with content "some content" to "test.txt"
    And user "Brian" has uploaded file with content "ownCloud test text file 0" to "/textfile0.txt"
    Then the content of file "/textfile0.txt" for user "Brian" should be "ownCloud test text file 0" 
    #  restart server
    Given the config "FRONTEND_PASSWORD_POLICY_MIN_LOWERCASE_CHARACTERS" has been set to "true"
    And user "Bob" has uploaded a file inside space "Project-bo" with content "some content" to "test.txt"
    And user "Bob" has uploaded file with content "ownCloud test text file 0" to "/textfile0.txt"
    Then the content of file "/textfile0.txt" for user "Bob" should be "ownCloud test text file 0" 
    Examples:
      | ocs_api_version |
      | 1               |
      | 2               |


  Scenario Outline: test2
    Given using OCS API version "<ocs-api-version>"
    #  restart server
    And the config "OCIS_SHARING_PUBLIC_WRITEABLE_SHARE_MUST_HAVE_PASSWORD" has been set to "true"
    And user "Alice" has uploaded a file inside space "Project-al" with content "some content" to "test.txt"
    And user "Alice" has uploaded file with content "ownCloud test text file 0" to "/textfile0.txt"
    Then the content of file "/textfile0.txt" for user "Alice" should be "ownCloud test text file 0" 
    #  restart server
    Given the config "FRONTEND_PASSWORD_POLICY_MIN_CHARACTERS" has been set to "true"
    And user "Brian" has uploaded a file inside space "Project-br" with content "some content" to "test.txt"
    And user "Brian" has uploaded file with content "ownCloud test text file 0" to "/textfile0.txt"
    Then the content of file "/textfile0.txt" for user "Brian" should be "ownCloud test text file 0" 
    #  restart server
    Given the config "FRONTEND_PASSWORD_POLICY_MIN_LOWERCASE_CHARACTERS" has been set to "true"
    And user "Bob" has uploaded a file inside space "Project-bo" with content "some content" to "test.txt"
    And user "Bob" has uploaded file with content "ownCloud test text file 0" to "/textfile0.txt"
    Then the content of file "/textfile0.txt" for user "Bob" should be "ownCloud test text file 0" 
    Examples:
      | ocs_api_version |
      | 1               |
      | 2               |


  Scenario Outline: test3
    Given using OCS API version "<ocs-api-version>"
    #  restart server
    And the config "OCIS_SHARING_PUBLIC_WRITEABLE_SHARE_MUST_HAVE_PASSWORD" has been set to "true"
    And user "Alice" has uploaded a file inside space "Project-al" with content "some content" to "test.txt"
    And user "Alice" has uploaded file with content "ownCloud test text file 0" to "/textfile0.txt"
    Then the content of file "/textfile0.txt" for user "Alice" should be "ownCloud test text file 0" 
    #  restart server
    Given the config "FRONTEND_PASSWORD_POLICY_MIN_CHARACTERS" has been set to "true"
    And user "Brian" has uploaded a file inside space "Project-br" with content "some content" to "test.txt"
    And user "Brian" has uploaded file with content "ownCloud test text file 0" to "/textfile0.txt"
    Then the content of file "/textfile0.txt" for user "Brian" should be "ownCloud test text file 0" 
    #  restart server
    Given the config "FRONTEND_PASSWORD_POLICY_MIN_LOWERCASE_CHARACTERS" has been set to "true"
    And user "Bob" has uploaded a file inside space "Project-bo" with content "some content" to "test.txt"
    And user "Bob" has uploaded file with content "ownCloud test text file 0" to "/textfile0.txt"
    Then the content of file "/textfile0.txt" for user "Bob" should be "ownCloud test text file 0" 
    Examples:
      | ocs_api_version |
      | 1               |
      | 2               |


  Scenario Outline: test4
    Given using OCS API version "<ocs-api-version>"
    #  restart server
    And the config "OCIS_SHARING_PUBLIC_WRITEABLE_SHARE_MUST_HAVE_PASSWORD" has been set to "true"
    And user "Alice" has uploaded a file inside space "Project-al" with content "some content" to "test.txt"
    And user "Alice" has uploaded file with content "ownCloud test text file 0" to "/textfile0.txt"
    Then the content of file "/textfile0.txt" for user "Alice" should be "ownCloud test text file 0" 
    #  restart server
    Given the config "FRONTEND_PASSWORD_POLICY_MIN_CHARACTERS" has been set to "true"
    And user "Brian" has uploaded a file inside space "Project-br" with content "some content" to "test.txt"
    And user "Brian" has uploaded file with content "ownCloud test text file 0" to "/textfile0.txt"
    Then the content of file "/textfile0.txt" for user "Brian" should be "ownCloud test text file 0" 
    #  restart server
    Given the config "FRONTEND_PASSWORD_POLICY_MIN_LOWERCASE_CHARACTERS" has been set to "true"
    And user "Bob" has uploaded a file inside space "Project-bo" with content "some content" to "test.txt"
    And user "Bob" has uploaded file with content "ownCloud test text file 0" to "/textfile0.txt"
    Then the content of file "/textfile0.txt" for user "Bob" should be "ownCloud test text file 0" 
    Examples:
      | ocs_api_version |
      | 1               |
      | 2               |


  Scenario Outline: test5
    Given using OCS API version "<ocs-api-version>"
    #  restart server
    And the config "OCIS_SHARING_PUBLIC_WRITEABLE_SHARE_MUST_HAVE_PASSWORD" has been set to "true"
    And user "Alice" has uploaded a file inside space "Project-al" with content "some content" to "test.txt"
    And user "Alice" has uploaded file with content "ownCloud test text file 0" to "/textfile0.txt"
    Then the content of file "/textfile0.txt" for user "Alice" should be "ownCloud test text file 0" 
    #  restart server
    Given the config "FRONTEND_PASSWORD_POLICY_MIN_CHARACTERS" has been set to "true"
    And user "Brian" has uploaded a file inside space "Project-br" with content "some content" to "test.txt"
    And user "Brian" has uploaded file with content "ownCloud test text file 0" to "/textfile0.txt"
    Then the content of file "/textfile0.txt" for user "Brian" should be "ownCloud test text file 0" 
    #  restart server
    Given the config "FRONTEND_PASSWORD_POLICY_MIN_LOWERCASE_CHARACTERS" has been set to "true"
    And user "Bob" has uploaded a file inside space "Project-bo" with content "some content" to "test.txt"
    And user "Bob" has uploaded file with content "ownCloud test text file 0" to "/textfile0.txt"
    Then the content of file "/textfile0.txt" for user "Bob" should be "ownCloud test text file 0" 
    Examples:
      | ocs_api_version |
      | 1               |
      | 2               |


  Scenario Outline: test6
    Given using OCS API version "<ocs-api-version>"
    #  restart server
    And the config "OCIS_SHARING_PUBLIC_WRITEABLE_SHARE_MUST_HAVE_PASSWORD" has been set to "true"
    And user "Alice" has uploaded a file inside space "Project-al" with content "some content" to "test.txt"
    And user "Alice" has uploaded file with content "ownCloud test text file 0" to "/textfile0.txt"
    Then the content of file "/textfile0.txt" for user "Alice" should be "ownCloud test text file 0" 
    #  restart server
    Given the config "FRONTEND_PASSWORD_POLICY_MIN_CHARACTERS" has been set to "true"
    And user "Brian" has uploaded a file inside space "Project-br" with content "some content" to "test.txt"
    And user "Brian" has uploaded file with content "ownCloud test text file 0" to "/textfile0.txt"
    Then the content of file "/textfile0.txt" for user "Brian" should be "ownCloud test text file 0" 
    #  restart server
    Given the config "FRONTEND_PASSWORD_POLICY_MIN_LOWERCASE_CHARACTERS" has been set to "true"
    And user "Bob" has uploaded a file inside space "Project-bo" with content "some content" to "test.txt"
    And user "Bob" has uploaded file with content "ownCloud test text file 0" to "/textfile0.txt"
    Then the content of file "/textfile0.txt" for user "Bob" should be "ownCloud test text file 0" 
    Examples:
      | ocs_api_version |
      | 1               |
      | 2               |


  Scenario Outline: test7
    Given using OCS API version "<ocs-api-version>"
    #  restart server
    And the config "OCIS_SHARING_PUBLIC_WRITEABLE_SHARE_MUST_HAVE_PASSWORD" has been set to "true"
    And user "Alice" has uploaded a file inside space "Project-al" with content "some content" to "test.txt"
    And user "Alice" has uploaded file with content "ownCloud test text file 0" to "/textfile0.txt"
    Then the content of file "/textfile0.txt" for user "Alice" should be "ownCloud test text file 0" 
    #  restart server
    Given the config "FRONTEND_PASSWORD_POLICY_MIN_CHARACTERS" has been set to "true"
    And user "Brian" has uploaded a file inside space "Project-br" with content "some content" to "test.txt"
    And user "Brian" has uploaded file with content "ownCloud test text file 0" to "/textfile0.txt"
    Then the content of file "/textfile0.txt" for user "Brian" should be "ownCloud test text file 0" 
    #  restart server
    Given the config "FRONTEND_PASSWORD_POLICY_MIN_LOWERCASE_CHARACTERS" has been set to "true"
    And user "Bob" has uploaded a file inside space "Project-bo" with content "some content" to "test.txt"
    And user "Bob" has uploaded file with content "ownCloud test text file 0" to "/textfile0.txt"
    Then the content of file "/textfile0.txt" for user "Bob" should be "ownCloud test text file 0" 
    Examples:
      | ocs_api_version |
      | 1               |
      | 2               |


  Scenario Outline: test8
    Given using OCS API version "<ocs-api-version>"
    #  restart server
    And the config "OCIS_SHARING_PUBLIC_WRITEABLE_SHARE_MUST_HAVE_PASSWORD" has been set to "true"
    And user "Alice" has uploaded a file inside space "Project-al" with content "some content" to "test.txt"
    And user "Alice" has uploaded file with content "ownCloud test text file 0" to "/textfile0.txt"
    Then the content of file "/textfile0.txt" for user "Alice" should be "ownCloud test text file 0" 
    #  restart server
    Given the config "FRONTEND_PASSWORD_POLICY_MIN_CHARACTERS" has been set to "true"
    And user "Brian" has uploaded a file inside space "Project-br" with content "some content" to "test.txt"
    And user "Brian" has uploaded file with content "ownCloud test text file 0" to "/textfile0.txt"
    Then the content of file "/textfile0.txt" for user "Brian" should be "ownCloud test text file 0" 
    #  restart server
    Given the config "FRONTEND_PASSWORD_POLICY_MIN_LOWERCASE_CHARACTERS" has been set to "true"
    And user "Bob" has uploaded a file inside space "Project-bo" with content "some content" to "test.txt"
    And user "Bob" has uploaded file with content "ownCloud test text file 0" to "/textfile0.txt"
    Then the content of file "/textfile0.txt" for user "Bob" should be "ownCloud test text file 0" 
    Examples:
      | ocs_api_version |
      | 1               |
      | 2               |


  Scenario Outline: test9
    Given using OCS API version "<ocs-api-version>"
    #  restart server
    And the config "OCIS_SHARING_PUBLIC_WRITEABLE_SHARE_MUST_HAVE_PASSWORD" has been set to "true"
    And user "Alice" has uploaded a file inside space "Project-al" with content "some content" to "test.txt"
    And user "Alice" has uploaded file with content "ownCloud test text file 0" to "/textfile0.txt"
    Then the content of file "/textfile0.txt" for user "Alice" should be "ownCloud test text file 0" 
    #  restart server
    Given the config "FRONTEND_PASSWORD_POLICY_MIN_CHARACTERS" has been set to "true"
    And user "Brian" has uploaded a file inside space "Project-br" with content "some content" to "test.txt"
    And user "Brian" has uploaded file with content "ownCloud test text file 0" to "/textfile0.txt"
    Then the content of file "/textfile0.txt" for user "Brian" should be "ownCloud test text file 0" 
    #  restart server
    Given the config "FRONTEND_PASSWORD_POLICY_MIN_LOWERCASE_CHARACTERS" has been set to "true"
    And user "Bob" has uploaded a file inside space "Project-bo" with content "some content" to "test.txt"
    And user "Bob" has uploaded file with content "ownCloud test text file 0" to "/textfile0.txt"
    Then the content of file "/textfile0.txt" for user "Bob" should be "ownCloud test text file 0" 
    Examples:
      | ocs_api_version |
      | 1               |
      | 2               |
      
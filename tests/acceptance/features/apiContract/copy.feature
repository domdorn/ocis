@api
Feature: Copy test
  As a user
  I want to check the PROPFIND response
  So that I can make sure that the response contains all the relevant values


  Background:
    Given these users have been created with default attributes and without skeleton files:
      | username |
      | Alice    |
      | Brian    |
    And using spaces DAV path
    And the administrator has assigned the role "Space Admin" to user "Alice" using the Graph API
    And user "Alice" has created a space "new-space" with the default quota using the GraphApi


  Scenario: check the COPY response headers
    Given user "Alice" has uploaded a file inside space "new-space" with content "some content" to "testfile.txt"
    And user "Alice" has created a folder "new" in space "new-space"
    When user "Alice" copies file "testfile.txt" from space "new-space" to "/new/testfile.txt" inside space "new-space" using the WebDAV API
    Then the HTTP status code should be "201"
    And the following headers should match these regular expressions
      | Oc-Fileid                   | /^[a-f0-9!\$\-]{110}$/ |
      | Access-Control-Allow-Origin | /^[*]{1}$/             |
      | X-Request-Id                | /^[a-f0-9!\-]{36}$/    |


  Scenario Outline: copy files inside subfolder using fileid
    And user "Alice" has created folder "FOLDER"
    Given user "Alice" has uploaded file with content "some data" to "/textfile.txt"
    And user "Alice" makes WebdAv request to "COPY" from "/textfile.txt" to "/FOLDER/text.txt" using "<dav-path>" davpath
    Then the HTTP status code should be "201"
    And as "Alice" file "/textfile.txt" should exist
    And as "Alice" file "/FOLDER/text.txt" should exist
    Examples:
      | dav-path                |
      | /remote.php/dav/spaces/ |
      | /dav/spaces/            |


  Scenario Outline: copy files inside subfolder using fileid
    And user "Brian" has created folder "/FOLDER"
    Given user "Alice" has uploaded file with content "some data" to "/textfile.txt"
    And we save it into "FILEID"
    And user "Brian" makes WebdAv request to "COPY" from "/<<FILEID>>" to "FOLDER/text.txt" using "<dav-path>" davpath
    Then the HTTP status code should be "404"
    And as "Alice" file "/textfile.txt" should exist
    And as "Brian" file "/FOLDER/text.txt" should not exist
    Examples:
      | dav-path                |
      | /remote.php/dav/spaces/ |
      | /dav/spaces/            |


  Scenario Outline: copy file from one share toanother

Feature: Propfind test
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
    And user "Alice" has created a space "new-space" with the default quota using the Graph API


  Scenario: space-admin checks the PROPFIND request of a space
    Given user "Alice" has uploaded a file inside space "new-space" with content "some content" to "testfile.txt"
    When user "Alice" sends PROPFIND request to space "new-space" with depth "0" using the WebDAV API
    Then the HTTP status code should be "207"
    And the following headers should match these regular expressions
      | X-Request-Id | /^[a-zA-Z]+\/[a-zA-Z]+\.feature:\d+(-\d+)?$/ |
    And the "PROPFIND" response should contain a space "new-space" with these key and value pairs:
      | key            | value            |
      | oc:fileid      | UUIDof:new-space |
      | oc:name        | new-space        |
      | oc:permissions | RDNVCKZP         |
      | oc:privatelink |                  |
      | oc:size        | 12               |


  Scenario Outline: space member with a different role checks the PROPFIND request of a space
    Given user "Alice" has uploaded a file inside space "new-space" with content "some content" to "testfile.txt"
    And user "Alice" has sent the following space share invitation:
      | space           | new-space    |
      | sharee          | Brian        |
      | shareType       | user         |
      | permissionsRole | <space-role> |
    When user "Brian" sends PROPFIND request to space "new-space" with depth "0" using the WebDAV API
    Then the HTTP status code should be "207"
    And the following headers should match these regular expressions
      | X-Request-Id | /^[a-zA-Z]+\/[a-zA-Z]+\.feature:\d+(-\d+)?$/ |
    And the "PROPFIND" response should contain a space "new-space" with these key and value pairs:
      | key            | value            |
      | oc:fileid      | UUIDof:new-space |
      | oc:name        | new-space        |
      | oc:permissions | <oc-permission>  |
      | oc:privatelink |                  |
      | oc:size        | 12               |
    Examples:
      | space-role   | oc-permission |
      | Manager      | RDNVCKZP      |
      | Space Editor | DNVCK         |
      | Space Viewer |               |


  Scenario Outline: space member with a different role checks the PROPFIND request of the folder in the space
    Given user "Alice" has created a folder "folderMain" in space "new-space"
    And user "Alice" has sent the following space share invitation:
      | space           | new-space    |
      | sharee          | Brian        |
      | shareType       | user         |
      | permissionsRole | <space-role> |
    When user "Brian" sends PROPFIND request from the space "new-space" to the resource "folderMain" with depth "0" using the WebDAV API
    Then the HTTP status code should be "207"
    And the "PROPFIND" response should contain a space "new-space" with these key and value pairs:
      | key            | value             |
      | oc:fileid      | UUIDof:folderMain |
      | oc:file-parent | UUIDof:new-space  |
      | oc:name        | folderMain        |
      | oc:permissions | <oc-permission>   |
      | oc:size        | 0                 |
    Examples:
      | space-role   | oc-permission |
      | Manager      | RDNVCKZP      |
      | Space Editor | DNVCK         |
      | Space Viewer |               |


  Scenario Outline: space member with a different role checks the PROPFIND request of the sub-folder in the space
    Given user "Alice" has created a folder "folderMain/subFolder1/subFolder2" in space "new-space"
    And user "Alice" has sent the following space share invitation:
      | space           | new-space    |
      | sharee          | Brian        |
      | shareType       | user         |
      | permissionsRole | <space-role> |
    When user "Brian" sends PROPFIND request from the space "new-space" to the resource "folderMain/subFolder1/subFolder2" with depth "0" using the WebDAV API
    Then the HTTP status code should be "207"
    And the "PROPFIND" response should contain a space "new-space" with these key and value pairs:
      | key            | value                                   |
      | oc:fileid      | UUIDof:folderMain/subFolder1/subFolder2 |
      | oc:file-parent | UUIDof:folderMain/subFolder1            |
      | oc:name        | subFolder2                              |
      | oc:permissions | <oc-permission>                         |
      | oc:size        | 0                                       |
    Examples:
      | space-role   | oc-permission |
      | Manager      | RDNVCKZP      |
      | Space Editor | DNVCK         |
      | Space Viewer |               |


  Scenario Outline: space member with a different role checks the PROPFIND request of the file in the space
    Given user "Alice" has uploaded a file inside space "new-space" with content "some content" to "testfile.txt"
    And user "Alice" has sent the following space share invitation:
      | space           | new-space    |
      | sharee          | Brian        |
      | shareType       | user         |
      | permissionsRole | <space-role> |
    When user "Brian" sends PROPFIND request from the space "new-space" to the resource "testfile.txt" with depth "0" using the WebDAV API
    Then the HTTP status code should be "207"
    And the "PROPFIND" response should contain a space "new-space" with these key and value pairs:
      | key            | value               |
      | oc:fileid      | UUIDof:testfile.txt |
      | oc:file-parent | UUIDof:new-space    |
      | oc:name        | testfile.txt        |
      | oc:permissions | <oc-permission>     |
      | oc:size        | 12                  |
    Examples:
      | space-role   | oc-permission |
      | Manager      | RDNVWZP       |
      | Space Editor | DNVW          |
      | Space Viewer |               |


  Scenario: space-admin checks the audio, image, photo and location properties of PROPFIND request of file from project space
    Given user "Alice" has uploaded a file "filesForUpload/testimage.mp3" to "testimage.mp3" in space "new-space"
    And user "Alice" has uploaded a file "filesForUpload/testImage.jpg" to "testImage.jpg" in space "new-space"
    When user "Alice" gets the following properties of resource "testimage.mp3" inside space "new-space" using the WebDAV API
      | propertyName |
      | oc:audio     |
    Then the HTTP status code should be "207"
    And the "PROPFIND" response should contain a space "new-space" with these key and value pairs:
      | key                | value                          |
      | oc:audio/oc:album  | ALBUM1234567890123456789012345 |
      | oc:audio/oc:artist | ARTIST123456789012345678901234 |
      | oc:audio/oc:genre  | Pop                            |
      | oc:audio/oc:title  | TITLE1234567890123456789012345 |
      | oc:audio/oc:track  | 1                              |
      | oc:audio/oc:year   | 2001                           |
    When user "Alice" gets the following properties of resource "testImage.jpg" inside space "new-space" using the WebDAV API
        | propertyName |
        | oc:image     |
        | oc:location  |
        | oc:photo     |
    Then the HTTP status code should be "207"
    And the "PROPFIND" response should contain a space "new-space" with these key and value pairs:
      | key                              | value                |
      | oc:image/oc:width                | 640                  |
      | oc:image/oc:height               | 480                  |
      | oc:location/oc:latitude          | 43.467157            |
      | oc:location/oc:longitude         | 11.885395            |
      | oc:photo/oc:camera-make          | NIKON                |
      | oc:photo/oc:camera-model         | COOLPIX P6000        |
      | oc:photo/oc:exposure-denominator | 178                  |
      | oc:photo/oc:exposure-numerator   | 1                    |
      | oc:photo/oc:f-number             | 4.5                  |
      | oc:photo/oc:focal-length         | 6                    |
      | oc:photo/oc:orientation          | 1                    |
      | oc:photo/oc:taken-date-time      | 2008-10-22T16:29:49Z |


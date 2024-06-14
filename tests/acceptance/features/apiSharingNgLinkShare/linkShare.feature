Feature: Create a share link for a resource
  https://owncloud.dev/libre-graph-api/#/drives.permissions/CreateLink

  Background:
    Given these users have been created with default attributes and without skeleton files:
      | username |
      | Alice    |

  @issue-7879
  Scenario Outline: create a link share of a folder using permissions endpoint
    Given user "Alice" has created folder "folder"
    When user "Alice" creates the following resource link share using the Graph API:
      | resource        | folder             |
      | space           | Personal           |
      | permissionsRole | <permissions-role> |
      | password        | %public%           |
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "hasPassword",
          "id",
          "link"
        ],
        "properties": {
          "hasPassword": {
            "const": true
          },
          "id": {
            "type": "string",
            "pattern": "^[a-zA-Z]{15}$"
          },
          "link": {
            "type": "object",
            "required": [
              "@libre.graph.displayName",
              "@libre.graph.quickLink",
              "preventsDownload",
              "type",
              "webUrl"
            ],
            "properties": {
              "@libre.graph.displayName": {
                "const": ""
              },
              "@libre.graph.quickLink": {
                "const": false
              },
              "preventsDownload": {
                "const": false
              },
              "type": {
                "const": "<permissions-role>"
              },
              "webUrl": {
                "type": "string",
                "pattern": "^%base_url%/s/[a-zA-Z]{15}$"
              }
            }
          }
        }
      }
      """
    Examples:
      | permissions-role |
      | view             |
      | edit             |
      | upload           |
      | createOnly       |
      | blocksDownload   |

  @issue-8619
  Scenario: create an internal link share of a folder using permissions endpoint
    Given user "Alice" has created folder "folder"
    When user "Alice" creates the following resource link share using the Graph API:
      | resource        | folder   |
      | space           | Personal |
      | permissionsRole | internal |
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "hasPassword",
          "id",
          "link"
        ],
        "properties": {
          "hasPassword": {
            "const": false
          },
          "id": {
            "type": "string",
            "pattern": "^[a-zA-Z]{15}$"
          },
          "link": {
            "type": "object",
            "required": [
              "@libre.graph.displayName",
              "@libre.graph.quickLink",
              "preventsDownload",
              "type",
              "webUrl"
            ],
            "properties": {
              "@libre.graph.displayName": {
                "const": ""
              },
              "@libre.graph.quickLink": {
                "const": false
              },
              "preventsDownload": {
                "const": false
              },
              "type": {
                "const": "internal"
              },
              "webUrl": {
                "type": "string",
                "pattern": "^%base_url%/s/[a-zA-Z]{15}$"
              }
            }
          }
        }
      }
      """

  @issue-8619
  Scenario: try to create an internal link share of a folder with password using permissions endpoint
    Given user "Alice" has created folder "folder"
    When user "Alice" creates the following resource link share using the Graph API:
      | resource        | folder   |
      | space           | Personal |
      | permissionsRole | internal |
      | password        | %public% |
    Then the HTTP status code should be "400"

  @issue-7879
  Scenario Outline: create a link share of a file using permissions endpoint
    Given user "Alice" has uploaded file with content "other data" to "textfile1.txt"
    When user "Alice" creates the following resource link share using the Graph API:
      | resource        | textfile1.txt      |
      | space           | Personal           |
      | permissionsRole | <permissions-role> |
      | password        | %public%           |
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "hasPassword",
          "id",
          "link"
        ],
        "properties": {
          "hasPassword": {
            "const": true
          },
          "id": {
            "type": "string",
            "pattern": "^[a-zA-Z]{15}$"
          },
          "link": {
            "type": "object",
            "required": [
              "@libre.graph.displayName",
              "@libre.graph.quickLink",
              "preventsDownload",
              "type",
              "webUrl"
            ],
            "properties": {
              "@libre.graph.displayName": {
                "const": ""
              },
              "@libre.graph.quickLink": {
                "const": false
              },
              "preventsDownload": {
                "const": false
              },
              "type": {
                "const": "<permissions-role>"
              },
              "webUrl": {
                "type": "string",
                "pattern": "^%base_url%/s/[a-zA-Z]{15}$"
              }
            }
          }
        }
      }
      """
    Examples:
      | permissions-role |
      | view             |
      | edit             |
      | blocksDownload   |

  @issue-8619
  Scenario: create an internal link share of a file using permissions endpoint
    Given user "Alice" has uploaded file with content "other data" to "textfile1.txt"
    When user "Alice" creates the following resource link share using the Graph API:
      | resource        | textfile1.txt |
      | space           | Personal      |
      | permissionsRole | internal      |
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "hasPassword",
          "id",
          "link"
        ],
        "properties": {
          "hasPassword": {
            "const": false
          },
          "id": {
            "type": "string",
            "pattern": "^[a-zA-Z]{15}$"
          },
          "link": {
            "type": "object",
            "required": [
              "@libre.graph.displayName",
              "@libre.graph.quickLink",
              "preventsDownload",
              "type",
              "webUrl"
            ],
            "properties": {
              "@libre.graph.displayName": {
                "const": ""
              },
              "@libre.graph.quickLink": {
                "const": false
              },
              "preventsDownload": {
                "const": false
              },
              "type": {
                "const": "internal"
              },
              "webUrl": {
                "type": "string",
                "pattern": "^%base_url%/s/[a-zA-Z]{15}$"
              }
            }
          }
        }
      }
      """

  @issue-8619
  Scenario: try to create an internal link share of a file with password using permissions endpoint
    Given user "Alice" has uploaded file with content "other data" to "textfile1.txt"
    When user "Alice" creates the following resource link share using the Graph API:
      | resource        | textfile1.txt |
      | space           | Personal      |
      | permissionsRole | internal      |
      | password        | %public%      |
    Then the HTTP status code should be "400"

  @issue-7879
  Scenario Outline: create a link share of a folder with display name and expiry date using permissions endpoint
    Given user "Alice" has created folder "folder"
    When user "Alice" creates the following resource link share using the Graph API:
      | resource           | folder                   |
      | space              | Personal                 |
      | permissionsRole    | <permissions-role>       |
      | password           | %public%                 |
      | displayName        | Homework                 |
      | expirationDateTime | 2200-07-15T14:00:00.000Z |
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "hasPassword",
          "id",
          "link",
          "expirationDateTime"
        ],
        "properties": {
          "hasPassword": {
            "const": true
          },
          "id": {
            "type": "string",
            "pattern": "^[a-zA-Z]{15}$"
          },
          "expirationDateTime": {
            "const": "2200-07-15T23:59:59Z"
          },
          "link": {
            "type": "object",
            "required": [
              "@libre.graph.displayName",
              "@libre.graph.quickLink",
              "preventsDownload",
              "type",
              "webUrl"
            ],
            "properties": {
              "@libre.graph.displayName": {
                "const": "Homework"
              },
              "@libre.graph.quickLink": {
                "const": false
              },
              "preventsDownload": {
                "const": false
              },
              "type": {
                "const": "<permissions-role>"
              },
              "webUrl": {
                "type": "string",
                "pattern": "^%base_url%/s/[a-zA-Z]{15}$"
              }
            }
          }
        }
      }
      """
    Examples:
      | permissions-role |
      | view             |
      | edit             |
      | upload           |
      | createOnly       |
      | blocksDownload   |

  @issue-7879
  Scenario Outline: create a link share of a file with display name and expiry date using permissions endpoint
    Given user "Alice" has uploaded file with content "other data" to "textfile1.txt"
    When user "Alice" creates the following resource link share using the Graph API:
      | resource           | textfile1.txt            |
      | space              | Personal                 |
      | permissionsRole    | <permissions-role>       |
      | password           | %public%                 |
      | displayName        | Homework                 |
      | expirationDateTime | 2200-07-15T14:00:00.000Z |
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "hasPassword",
          "id",
          "link",
          "expirationDateTime"
        ],
        "properties": {
          "hasPassword": {
            "const": true
          },
          "id": {
            "type": "string",
            "pattern": "^[a-zA-Z]{15}$"
          },
          "expirationDateTime": {
            "const": "2200-07-15T23:59:59Z"
          },
          "link": {
            "type": "object",
            "required": [
              "@libre.graph.displayName",
              "@libre.graph.quickLink",
              "preventsDownload",
              "type",
              "webUrl"
            ],
            "properties": {
              "@libre.graph.displayName": {
                "const": "Homework"
              },
              "@libre.graph.quickLink": {
                "const": false
              },
              "preventsDownload": {
                "const": false
              },
              "type": {
                "const": "<permissions-role>"
              },
              "webUrl": {
                "type": "string",
                "pattern": "^%base_url%/s/[a-zA-Z]{15}$"
              }
            }
          }
        }
      }
      """
    Examples:
      | permissions-role |
      | view             |
      | edit             |
      | blocksDownload   |

  @env-config @issue-7879
  Scenario Outline: create a link share of a file without password using permissions endpoint
    Given the following configs have been set:
      | config                                       | value |
      | OCIS_SHARING_PUBLIC_SHARE_MUST_HAVE_PASSWORD | false |
    And user "Alice" has uploaded file with content "other data" to "textfile1.txt"
    When user "Alice" creates the following resource link share using the Graph API:
      | resource        | textfile1.txt      |
      | space           | Personal           |
      | permissionsRole | <permissions-role> |
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "hasPassword",
          "id",
          "link"
        ],
        "properties": {
          "hasPassword": {
            "const": false
          },
          "id": {
            "type": "string",
            "pattern": "^[a-zA-Z]{15}$"
          },
          "link": {
            "type": "object",
            "required": [
              "@libre.graph.displayName",
              "@libre.graph.quickLink",
              "preventsDownload",
              "type",
              "webUrl"
            ],
            "properties": {
              "@libre.graph.displayName": {
                "const": ""
              },
              "@libre.graph.quickLink": {
                "const": false
              },
              "preventsDownload": {
                "const": false
              },
              "type": {
                "const": "<permissions-role>"
              },
              "webUrl": {
                "type": "string",
                "pattern": "^%base_url%/s/[a-zA-Z]{15}$"
              }
            }
          }
        }
      }
      """
    Examples:
      | permissions-role |
      | view             |
      | edit             |
      | internal         |
      | blocksDownload   |

  @issue-7879
  Scenario Outline: update role of a file's link share using permissions endpoint
    Given user "Alice" has uploaded file with content "other data" to "textfile1.txt"
    And user "Alice" has created the following resource link share:
      | resource        | textfile1.txt      |
      | space           | Personal           |
      | permissionsRole | <permissions-role> |
      | password        | %public%           |
    When user "Alice" updates the last public link share using the permissions endpoint of the Graph API:
      | resource        | textfile1.txt          |
      | space           | Personal               |
      | permissionsRole | <new-permissions-role> |
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "hasPassword",
          "id",
          "link"
        ],
        "properties": {
          "hasPassword": {
            "const": true
          },
          "id": {
            "type": "string",
            "pattern": "^[a-zA-Z]{15}$"
          },
          "link": {
            "type": "object",
            "required": [
              "@libre.graph.displayName",
              "@libre.graph.quickLink",
              "preventsDownload",
              "type",
              "webUrl"
            ],
            "properties": {
              "@libre.graph.displayName": {
                "const": ""
              },
              "@libre.graph.quickLink": {
                "const": false
              },
              "preventsDownload": {
                "const": false
              },
              "type": {
                "const": "<new-permissions-role>"
              },
              "webUrl": {
                "type": "string",
                "pattern": "^%base_url%/s/[a-zA-Z]{15}$"
              }
            }
          }
        }
      }
      """
    Examples:
      | permissions-role | new-permissions-role |
      | view             | edit                 |
      | view             | blocksDownload       |
      | edit             | view                 |
      | edit             | blocksDownload       |
      | blocksDownload   | edit                 |
      | blocksDownload   | blocksDownload       |

  @issue-8619
  Scenario Outline: update role of a file's to internal link share using permissions endpoint
    Given user "Alice" has uploaded file with content "other data" to "textfile1.txt"
    And user "Alice" has created the following resource link share:
      | resource        | textfile1.txt      |
      | space           | Personal           |
      | permissionsRole | <permissions-role> |
      | password        | %public%           |
    When user "Alice" updates the last public link share using the permissions endpoint of the Graph API:
      | resource        | textfile1.txt |
      | space           | Personal      |
      | permissionsRole | internal      |
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "hasPassword",
          "id",
          "link"
        ],
        "properties": {
          "hasPassword": {
            "const": false
          },
          "id": {
            "type": "string",
            "pattern": "^[a-zA-Z]{15}$"
          },
          "link": {
            "type": "object",
            "required": [
              "@libre.graph.displayName",
              "@libre.graph.quickLink",
              "preventsDownload",
              "type",
              "webUrl"
            ],
            "properties": {
              "@libre.graph.displayName": {
                "const": ""
              },
              "@libre.graph.quickLink": {
                "const": false
              },
              "preventsDownload": {
                "const": false
              },
              "type": {
                "const": "internal"
              },
              "webUrl": {
                "pattern": "^%base_url%/s/[a-zA-Z]{15}$"
              }
            }
          }
        }
      }
      """
    Examples:
      | permissions-role |
      | view             |
      | edit             |
      | blocksDownload   |


  Scenario: update expiration date of a file's link share using permissions endpoint
    Given user "Alice" has uploaded file with content "other data" to "textfile1.txt"
    And user "Alice" has created the following resource link share:
      | resource           | textfile1.txt            |
      | space              | Personal                 |
      | permissionsRole    | view                     |
      | password           | %public%                 |
      | expirationDateTime | 2200-07-15T14:00:00.000Z |
    When user "Alice" updates the last public link share using the permissions endpoint of the Graph API:
      | resource           | textfile1.txt            |
      | space              | Personal                 |
      | expirationDateTime | 2201-07-15T14:00:00.000Z |
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "hasPassword",
          "id",
          "link",
          "expirationDateTime"
        ],
        "properties": {
          "hasPassword": {
            "const": true
          },
          "id": {
            "pattern": "^[a-zA-Z]{15}$"
          },
          "expirationDateTime": {
            "const": "2201-07-15T23:59:59Z"
          },
          "link": {
            "type": "object",
            "required": [
              "@libre.graph.displayName",
              "@libre.graph.quickLink",
              "preventsDownload",
              "type",
              "webUrl"
            ],
            "properties": {
              "@libre.graph.quickLink": {
                "const": false
              },
              "preventsDownload": {
                "const": false
              },
              "type": {
                "const": "view"
              },
              "webUrl": {
                "type": "string",
                "pattern": "^%base_url%/s/[a-zA-Z]{15}$"
              }
            }
          }
        }
      }
      """

  @issues-8405
  Scenario Outline: remove expiration date of a resource link share using permissions endpoint
    Given user "Alice" has uploaded file with content "other data" to "textfile1.txt"
    And user "Alice" has created folder "folder"
    And user "Alice" has created the following resource link share:
      | resource           | <resource>               |
      | space              | Personal                 |
      | permissionsRole    | view                     |
      | password           | %public%                 |
      | expirationDateTime | 2200-07-15T14:00:00.000Z |
    When user "Alice" updates the last public link share using the permissions endpoint of the Graph API:
      | resource           | <resource> |
      | space              | Personal   |
      | expirationDateTime |            |
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "hasPassword",
          "id",
          "link"
        ],
        "properties": {
          "hasPassword": {
            "const": true
          },
          "id": {
            "type": "string",
            "pattern": "^[a-zA-Z]{15}$"
          },
          "link": {
            "type": "object",
            "required": [
              "@libre.graph.displayName",
              "@libre.graph.quickLink",
              "preventsDownload",
              "type",
              "webUrl"
            ],
            "properties": {
              "@libre.graph.quickLink": {
                "const": false
              },
              "preventsDownload": {
                "const": false
              },
              "type": {
                "const": "view"
              },
              "webUrl": {
                "type": "string",
                "pattern": "^%base_url%/s/[a-zA-Z]{15}$"
              }
            }
          }
        }
      }
      """
    Examples:
      | resource      |
      | textfile1.txt |
      | folder        |

  @env-config
  Scenario: set password on a file's link share using permissions endpoint
    Given the following configs have been set:
      | config                                       | value |
      | OCIS_SHARING_PUBLIC_SHARE_MUST_HAVE_PASSWORD | false |
    And user "Alice" has uploaded file with content "other data" to "textfile1.txt"
    And user "Alice" has created the following resource link share:
      | resource        | textfile1.txt |
      | space           | Personal      |
      | permissionsRole | view          |
    When user "Alice" sets the following password for the last link share using the Graph API:
      | resource | textfile1.txt |
      | space    | Personal      |
      | password | %public%      |
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "hasPassword"
        ],
        "properties": {
          "hasPassword": {
            "const": true
          }
        }
      }
      """
    And the public should be able to download file "textfile1.txt" from the last link share with password "%public%" and the content should be "other data"


  Scenario: update password of a file's link share using permissions endpoint
    Given user "Alice" has uploaded file with content "other data" to "textfile1.txt"
    And user "Alice" has created the following resource link share:
      | resource        | textfile1.txt |
      | space           | Personal      |
      | permissionsRole | view          |
      | password        | $heLlo*1234*  |
    When user "Alice" sets the following password for the last link share using the Graph API:
      | resource | textfile1.txt |
      | space    | Personal      |
      | password | %public%      |
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "hasPassword"
        ],
        "properties": {
          "hasPassword": {
            "const": true
          }
        }
      }
      """
    And the public should be able to download file "textfile1.txt" from the last link share with password "%public%" and the content should be "other data"
    And the public download of file "textfile1.txt" from the last link share with password "$heLlo*1234*" should fail with HTTP status code "401" using shareNg


  Scenario Outline: create a file's link share with a password that is listed in the Banned-Password-List using permissions endpoint
    Given the config "OCIS_PASSWORD_POLICY_BANNED_PASSWORDS_LIST" has been set to path "config/drone/banned-password-list.txt"
    And user "Alice" has uploaded file with content "other data" to "text.txt"
    When user "Alice" creates the following resource link share using the Graph API:
      | resource        | text.txt          |
      | space           | Personal          |
      | permissionsRole | view              |
      | password        | <banned-password> |
    Then the HTTP status code should be "400"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "error"
        ],
        "properties": {
          "error": {
            "type": "object",
            "required": [
              "code",
              "message"
            ],
            "properties": {
              "code": {
                "type": "string",
                "pattern": "invalidRequest"
              },
              "message": {
                "const": "unfortunately, your password is commonly used. please pick a harder-to-guess password for your safety"
              }
            }
          }
        }
      }
      """
    Examples:
      | banned-password |
      | 123             |
      | password        |
      | ownCloud        |


  Scenario Outline: update a file's link share with a password that is listed in the Banned-Password-List using permissions endpoint
    Given the config "OCIS_PASSWORD_POLICY_BANNED_PASSWORDS_LIST" has been set to path "config/drone/banned-password-list.txt"
    And user "Alice" has uploaded file with content "other data" to "text.txt"
    And user "Alice" has created the following resource link share:
      | resource        | text.txt |
      | space           | Personal |
      | permissionsRole | view     |
      | password        | %public% |
    When user "Alice" sets the following password for the last link share using the Graph API:
      | resource        | text.txt          |
      | space           | Personal          |
      | permissionsRole | view              |
      | password        | <banned-password> |
    Then the HTTP status code should be "400"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "error"
        ],
        "properties": {
          "error": {
            "type": "object",
            "required": [
              "code",
              "message"
            ],
            "properties": {
              "code": {
                "type": "string",
                "pattern": "invalidRequest"
              },
              "message": {
                "const": "unfortunately, your password is commonly used. please pick a harder-to-guess password for your safety"
              }
            }
          }
        }
      }
      """
    Examples:
      | banned-password |
      | 123             |
      | password        |
      | ownCloud        |

  @issue-7879
  Scenario Outline: create a share link of a folder inside project-space using permissions endpoint
    Given using spaces DAV path
    And the administrator has assigned the role "Space Admin" to user "Alice" using the Graph API
    And user "Alice" has created a space "projectSpace" with the default quota using the Graph API
    And user "Alice" has created a folder "folderToShare" in space "projectSpace"
    When user "Alice" creates the following resource link share using the Graph API:
      | resource        | folderToShare      |
      | space           | projectSpace       |
      | permissionsRole | <permissions-role> |
      | password        | %public%           |
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "hasPassword",
          "id",
          "link"
        ],
        "properties": {
          "hasPassword": {
            "const": true
          },
          "id": {
            "type": "string",
            "pattern": "^[a-zA-Z]{15}$"
          },
          "link": {
            "type": "object",
            "required": [
              "@libre.graph.displayName",
              "@libre.graph.quickLink",
              "preventsDownload",
              "type",
              "webUrl"
            ],
            "properties": {
              "@libre.graph.displayName": {
                "const": ""
              },
              "@libre.graph.quickLink": {
                "const": false
              },
              "preventsDownload": {
                "const": false
              },
              "type": {
                "const": "<permissions-role>"
              },
              "webUrl": {
                "type": "string",
                "pattern": "^%base_url%/s/[a-zA-Z]{15}$"
              }
            }
          }
        }
      }
      """
    Examples:
      | permissions-role |
      | view             |
      | edit             |
      | upload           |
      | createOnly       |
      | blocksDownload   |


  Scenario: create an internal link share of a folder inside project-space using permissions endpoint
    Given using spaces DAV path
    And the administrator has assigned the role "Space Admin" to user "Alice" using the Graph API
    And user "Alice" has created a space "projectSpace" with the default quota using the Graph API
    And user "Alice" has created a folder "folderToShare" in space "projectSpace"
    When user "Alice" creates the following resource link share using the Graph API:
      | resource        | folderToShare |
      | space           | projectSpace  |
      | permissionsRole | internal      |
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "hasPassword",
          "id",
          "link"
        ],
        "properties": {
          "hasPassword": {
            "const": false
          },
          "id": {
            "pattern": "^[a-zA-Z]{15}$"
          },
          "link": {
            "type": "object",
            "required": [
              "@libre.graph.displayName",
              "@libre.graph.quickLink",
              "preventsDownload",
              "type",
              "webUrl"
            ],
            "properties": {
              "@libre.graph.displayName": {
                "const": ""
              },
              "@libre.graph.quickLink": {
                "const": false
              },
              "preventsDownload": {
                "const": false
              },
              "type": {
                "const": "internal"
              },
              "webUrl": {
                "type": "string",
                "pattern": "^%base_url%/s/[a-zA-Z]{15}$"
              }
            }
          }
        }
      }
      """

  @issue-8619
  Scenario: try to create an internal share link of a folder inside project-space with password using permissions endpoint
    Given using spaces DAV path
    And the administrator has assigned the role "Space Admin" to user "Alice" using the Graph API
    And user "Alice" has created a space "projectSpace" with the default quota using the Graph API
    And user "Alice" has created a folder "folderToShare" in space "projectSpace"
    When user "Alice" creates the following resource link share using the Graph API:
      | resource        | folderToShare |
      | space           | projectSpace  |
      | permissionsRole | internal      |
      | password        | %public%      |
    Then the HTTP status code should be "400"

  @issue-7879
  Scenario Outline: create a share link of a folder inside project-space with display name and expiry date using permissions endpoint
    Given using spaces DAV path
    And the administrator has assigned the role "Space Admin" to user "Alice" using the Graph API
    And user "Alice" has created a space "projectSpace" with the default quota using the Graph API
    And user "Alice" has created a folder "folderToShare" in space "projectSpace"
    When user "Alice" creates the following resource link share using the Graph API:
      | resource           | folderToShare            |
      | space              | projectSpace             |
      | permissionsRole    | <permissions-role>       |
      | password           | %public%                 |
      | displayName        | Homework                 |
      | expirationDateTime | 2200-07-15T14:00:00.000Z |
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "hasPassword",
          "id",
          "link",
          "expirationDateTime"
        ],
        "properties": {
          "hasPassword": {
            "const": true
          },
          "id": {
            "type": "string",
            "pattern": "^[a-zA-Z]{15}$"
          },
          "expirationDateTime": {
            "const": "2200-07-15T23:59:59Z"
          },
          "link": {
            "type": "object",
            "required": [
              "@libre.graph.displayName",
              "@libre.graph.quickLink",
              "preventsDownload",
              "type",
              "webUrl"
            ],
            "properties": {
              "@libre.graph.displayName": {
                "const": "Homework"
              },
              "@libre.graph.quickLink": {
                "const": false
              },
              "preventsDownload": {
                "const": false
              },
              "type": {
                "const": "<permissions-role>"
              },
              "webUrl": {
                "type": "string",
                "pattern": "^%base_url%/s/[a-zA-Z]{15}$"
              }
            }
          }
        }
      }
      """
    Examples:
      | permissions-role |
      | view             |
      | edit             |
      | upload           |
      | createOnly       |
      | blocksDownload   |


  Scenario Outline: create a share link of a folder inside project-space with a password that is listed in the Banned-Password-List using permissions endpoint
    Given the config "OCIS_PASSWORD_POLICY_BANNED_PASSWORDS_LIST" has been set to path "config/drone/banned-password-list.txt"
    And using spaces DAV path
    And the administrator has assigned the role "Space Admin" to user "Alice" using the Graph API
    And user "Alice" has created a space "projectSpace" with the default quota using the Graph API
    And user "Alice" has created a folder "folderToShare" in space "projectSpace"
    When user "Alice" creates the following resource link share using the Graph API:
      | resource        | folderToShare      |
      | space           | projectSpace       |
      | permissionsRole | <permissions-role> |
      | password        | <banned-password>  |
    Then the HTTP status code should be "400"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "error"
        ],
        "properties": {
          "error": {
            "type": "object",
            "required": [
              "code",
              "message"
            ],
            "properties": {
              "code": {
                "type": "string",
                "pattern": "invalidRequest"
              },
              "message": {
                "const": "unfortunately, your password is commonly used. please pick a harder-to-guess password for your safety"
              }
            }
          }
        }
      }
      """
    Examples:
      | banned-password | permissions-role |
      | 123             | view             |
      | password        | view             |
      | ownCloud        | view             |
      | 123             | edit             |
      | password        | edit             |
      | ownCloud        | edit             |
      | 123             | upload           |
      | password        | upload           |
      | ownCloud        | upload           |
      | 123             | createOnly       |
      | password        | createOnly       |
      | ownCloud        | createOnly       |
      | 123             | blocksDownload   |
      | password        | blocksDownload   |
      | ownCloud        | blocksDownload   |

  @env-config
  Scenario: set password on a existing share link of a folder inside project-space using permissions endpoint
    Given the following configs have been set:
      | config                                       | value |
      | OCIS_SHARING_PUBLIC_SHARE_MUST_HAVE_PASSWORD | false |
    And using spaces DAV path
    And the administrator has assigned the role "Space Admin" to user "Alice" using the Graph API
    And user "Alice" has created a space "projectSpace" with the default quota using the Graph API
    And user "Alice" has created a folder "folderToShare" in space "projectSpace"
    And user "Alice" has uploaded a file inside space "projectSpace" with content "to share" to "folderToShare/textfile.txt"
    And user "Alice" has created the following resource link share:
      | resource        | folderToShare |
      | space           | projectSpace  |
      | permissionsRole | view          |
    When user "Alice" sets the following password for the last link share using the Graph API:
      | resource | folderToShare |
      | space    | projectSpace  |
      | password | %public%      |
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "hasPassword"
        ],
        "properties": {
          "hasPassword": {
            "const": true
          }
        }
      }
      """
    And the public should be able to download file "/textfile.txt" from the last link share with password "%public%" and the content should be "to share"

  @env-config @issue-7879
  Scenario Outline: create a share link of a file inside project-space without password using permissions endpoint
    Given the following configs have been set:
      | config                                       | value |
      | OCIS_SHARING_PUBLIC_SHARE_MUST_HAVE_PASSWORD | false |
    And using spaces DAV path
    And the administrator has assigned the role "Space Admin" to user "Alice" using the Graph API
    And user "Alice" has created a space "projectSpace" with the default quota using the Graph API
    And user "Alice" has created a folder "folderToShare" in space "projectSpace"
    When user "Alice" creates the following resource link share using the Graph API:
      | resource        | folderToShare      |
      | space           | projectSpace       |
      | permissionsRole | <permissions-role> |
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "hasPassword",
          "id",
          "link"
        ],
        "properties": {
          "hasPassword": {
            "const": false
          },
          "id": {
            "type": "string",
            "pattern": "^[a-zA-Z]{15}$"
          },
          "link": {
            "type": "object",
            "required": [
              "@libre.graph.displayName",
              "@libre.graph.quickLink",
              "preventsDownload",
              "type",
              "webUrl"
            ],
            "properties": {
              "@libre.graph.displayName": {
                "const": ""
              },
              "@libre.graph.quickLink": {
                "const": false
              },
              "preventsDownload": {
                "const": false
              },
              "type": {
                "const": "<permissions-role>"
              },
              "webUrl": {
                "type": "string",
                "pattern": "^%base_url%/s/[a-zA-Z]{15}$"
              }
            }
          }
        }
      }
      """
    Examples:
      | permissions-role |
      | view             |
      | edit             |
      | upload           |
      | createOnly       |
      | blocksDownload   |

  @issue-7879
  Scenario Outline: create a share link of a file inside project-space using permissions endpoint
    Given using spaces DAV path
    And the administrator has assigned the role "Space Admin" to user "Alice" using the Graph API
    And user "Alice" has created a space "projectSpace" with the default quota using the Graph API
    And user "Alice" has uploaded a file inside space "projectSpace" with content "to share" to "textfile.txt"
    When user "Alice" creates the following resource link share using the Graph API:
      | resource        | textfile.txt       |
      | space           | projectSpace       |
      | permissionsRole | <permissions-role> |
      | password        | %public%           |
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "hasPassword",
          "id",
          "link"
        ],
        "properties": {
          "hasPassword": {
            "const": true
          },
          "id": {
            "type": "string",
            "pattern": "^[a-zA-Z]{15}$"
          },
          "link": {
            "type": "object",
            "required": [
              "@libre.graph.displayName",
              "@libre.graph.quickLink",
              "preventsDownload",
              "type",
              "webUrl"
            ],
            "properties": {
              "@libre.graph.displayName": {
                "const": ""
              },
              "@libre.graph.quickLink": {
                "const": false
              },
              "preventsDownload": {
                "const": false
              },
              "type": {
                "const": "<permissions-role>"
              },
              "webUrl": {
                "type": "string",
                "pattern": "^%base_url%/s/[a-zA-Z]{15}$"
              }
            }
          }
        }
      }
      """
    Examples:
      | permissions-role |
      | view             |
      | edit             |
      | blocksDownload   |

  @issue-8619
  Scenario: create an internal share link of a file inside project-space using permissions endpoint
    Given using spaces DAV path
    And the administrator has assigned the role "Space Admin" to user "Alice" using the Graph API
    And user "Alice" has created a space "projectSpace" with the default quota using the Graph API
    And user "Alice" has uploaded a file inside space "projectSpace" with content "to share" to "textfile.txt"
    When user "Alice" creates the following resource link share using the Graph API:
      | resource        | textfile.txt |
      | space           | projectSpace |
      | permissionsRole | internal     |
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "hasPassword",
          "id",
          "link"
        ],
        "properties": {
          "hasPassword": {
            "const": false
          },
          "id": {
            "type": "string",
            "pattern": "^[a-zA-Z]{15}$"
          },
          "link": {
            "type": "object",
            "required": [
              "@libre.graph.displayName",
              "@libre.graph.quickLink",
              "preventsDownload",
              "type",
              "webUrl"
            ],
            "properties": {
              "@libre.graph.displayName": {
                "const": ""
              },
              "@libre.graph.quickLink": {
                "const": false
              },
              "preventsDownload": {
                "const": false
              },
              "type": {
                "const": "internal"
              },
              "webUrl": {
                "type": "string",
                "pattern": "^%base_url%/s/[a-zA-Z]{15}$"
              }
            }
          }
        }
      }
      """

  @issue-8619
  Scenario: try to create an internal share link of a file inside project-space with password from project-space using permissions endpoint
    Given using spaces DAV path
    And the administrator has assigned the role "Space Admin" to user "Alice" using the Graph API
    And user "Alice" has created a space "projectSpace" with the default quota using the Graph API
    And user "Alice" has uploaded a file inside space "projectSpace" with content "to share" to "textfile.txt"
    When user "Alice" creates the following resource link share using the Graph API:
      | resource        | textfile.txt |
      | space           | projectSpace |
      | permissionsRole | internal     |
      | password        | %public%     |
    Then the HTTP status code should be "400"

  @issue-7879
  Scenario Outline: create a share link of a file inside project-space with display name and expiry date using permissions endpoint
    Given using spaces DAV path
    And the administrator has assigned the role "Space Admin" to user "Alice" using the Graph API
    And user "Alice" has created a space "projectSpace" with the default quota using the Graph API
    And user "Alice" has uploaded a file inside space "projectSpace" with content "to share" to "textfile.txt"
    When user "Alice" creates the following resource link share using the Graph API:
      | resource           | textfile.txt             |
      | space              | projectSpace             |
      | permissionsRole    | <permissions-role>       |
      | password           | %public%                 |
      | displayName        | Homework                 |
      | expirationDateTime | 2200-07-15T14:00:00.000Z |
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "hasPassword",
          "id",
          "link",
          "expirationDateTime"
        ],
        "properties": {
          "hasPassword": {
            "const": true
          },
          "id": {
            "type": "string",
            "pattern": "^[a-zA-Z]{15}$"
          },
          "expirationDateTime": {
            "const": "2200-07-15T23:59:59Z"
          },
          "link": {
            "type": "object",
            "required": [
              "@libre.graph.displayName",
              "@libre.graph.quickLink",
              "preventsDownload",
              "type",
              "webUrl"
            ],
            "properties": {
              "@libre.graph.displayName": {
                "const": "Homework"
              },
              "@libre.graph.quickLink": {
                "const": false
              },
              "preventsDownload": {
                "const": false
              },
              "type": {
                "const": "<permissions-role>"
              },
              "webUrl": {
                "pattern": "^%base_url%/s/[a-zA-Z]{15}$"
              }
            }
          }
        }
      }
      """
    Examples:
      | permissions-role |
      | view             |
      | edit             |
      | blocksDownload   |

  @env-config @issue-7879
  Scenario Outline: create a share link of a file inside project-space without password using permissions endpoint
    Given the following configs have been set:
      | config                                       | value |
      | OCIS_SHARING_PUBLIC_SHARE_MUST_HAVE_PASSWORD | false |
    And using spaces DAV path
    And the administrator has assigned the role "Space Admin" to user "Alice" using the Graph API
    And user "Alice" has created a space "projectSpace" with the default quota using the Graph API
    And user "Alice" has uploaded a file inside space "projectSpace" with content "to share" to "textfile.txt"
    When user "Alice" creates the following resource link share using the Graph API:
      | resource        | textfile.txt       |
      | space           | projectSpace       |
      | permissionsRole | <permissions-role> |
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "hasPassword",
          "id",
          "link"
        ],
        "properties": {
          "hasPassword": {
            "const": false
          },
          "id": {
            "type": "string",
            "pattern": "^[a-zA-Z]{15}$"
          },
          "link": {
            "type": "object",
            "required": [
              "@libre.graph.displayName",
              "@libre.graph.quickLink",
              "preventsDownload",
              "type",
              "webUrl"
            ],
            "properties": {
              "@libre.graph.displayName": {
                "const": ""
              },
              "@libre.graph.quickLink": {
                "const": false
              },
              "preventsDownload": {
                "const": false
              },
              "type": {
                "const": "<permissions-role>"
              },
              "webUrl": {
                "type": "string",
                "pattern": "^%base_url%/s/[a-zA-Z]{15}$"
              }
            }
          }
        }
      }
      """
    Examples:
      | permissions-role |
      | view             |
      | edit             |
      | internal         |
      | blocksDownload   |


  Scenario Outline: create a share link of a file inside project-space with a password that is listed in the Banned-Password-List using permissions endpoint
    Given the config "OCIS_PASSWORD_POLICY_BANNED_PASSWORDS_LIST" has been set to path "config/drone/banned-password-list.txt"
    And using spaces DAV path
    And the administrator has assigned the role "Space Admin" to user "Alice" using the Graph API
    And user "Alice" has created a space "projectSpace" with the default quota using the Graph API
    And user "Alice" has uploaded a file inside space "projectSpace" with content "to share" to "textfile.txt"
    When user "Alice" creates the following resource link share using the Graph API:
      | resource        | textfile.txt       |
      | space           | projectSpace       |
      | permissionsRole | <permissions-role> |
      | password        | <banned-password>  |
    Then the HTTP status code should be "400"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "error"
        ],
        "properties": {
          "error": {
            "type": "object",
            "required": [
              "code",
              "message"
            ],
            "properties": {
              "code": {
                "type": "string",
                "pattern": "invalidRequest"
              },
              "message": {
                "const": "unfortunately, your password is commonly used. please pick a harder-to-guess password for your safety"
              }
            }
          }
        }
      }
      """
    Examples:
      | banned-password | permissions-role |
      | 123             | view             |
      | password        | view             |
      | ownCloud        | view             |
      | 123             | edit             |
      | password        | edit             |
      | ownCloud        | edit             |
      | 123             | blocksDownload   |
      | password        | blocksDownload   |
      | ownCloud        | blocksDownload   |

  @env-config
  Scenario: set password on a existing share link of a file inside project-space using permissions endpoint
    Given the following configs have been set:
      | config                                       | value |
      | OCIS_SHARING_PUBLIC_SHARE_MUST_HAVE_PASSWORD | false |
    And using spaces DAV path
    And the administrator has assigned the role "Space Admin" to user "Alice" using the Graph API
    And user "Alice" has created a space "projectSpace" with the default quota using the Graph API
    And user "Alice" has uploaded a file inside space "projectSpace" with content "to share" to "textfile.txt"
    And user "Alice" has created the following resource link share:
      | resource        | textfile.txt |
      | space           | projectSpace |
      | permissionsRole | view         |
    When user "Alice" sets the following password for the last link share using the Graph API:
      | resource | textfile.txt |
      | space    | projectSpace |
      | password | %public%     |
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "hasPassword"
        ],
        "properties": {
          "hasPassword": {
            "const": true
          }
        }
      }
      """
    And the public should be able to download file "textfile.txt" from the last link share with password "%public%" and the content should be "to share"

  @issue-7879
  Scenario Outline: try to create a link share of a Personal and Share drive using root endpoint
    When user "Alice" tries to create the following space link share using root endpoint of the Graph API:
      | space           | <drive>            |
      | permissionsRole | <permissions-role> |
      | password        | %public%           |
    Then the HTTP status code should be "400"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": ["error"],
        "properties": {
          "error": {
            "type": "object",
            "required": [
              "code",
              "innererror",
              "message"
            ],
            "properties": {
              "code": {
                "const": "invalidRequest"
              },
              "innererror": {
                "type": "object",
                "required": [
                  "date",
                  "request-id"
                ]
              },
              "message": {
                "const": "unsupported space type"
              }
            }
          }
        }
      }
      """
    Examples:
      | permissions-role | drive    |
      | view             | Shares   |
      | edit             | Shares   |
      | upload           | Shares   |
      | createOnly       | Shares   |
      | blocksDownload   | Shares   |
      | view             | Personal |
      | edit             | Personal |
      | upload           | Personal |
      | createOnly       | Personal |
      | blocksDownload   | Personal |


  Scenario Outline: try to create an internal link share of a Personal and Share drives using root endpoint
    When user "Alice" tries to create the following space link share using root endpoint of the Graph API:
      | space           | <drive>  |
      | permissionsRole | internal |
    Then the HTTP status code should be "400"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": ["error"],
        "properties": {
          "error": {
            "type": "object",
            "required": [
              "code",
              "innererror",
              "message"
            ],
            "properties": {
              "code": {
                "const": "invalidRequest"
              },
              "innererror": {
                "type": "object",
                "required": [
                  "date",
                  "request-id"
                ]
              },
              "message": {
                "const": "unsupported space type"
              }
            }
          }
        }
      }
      """
    Examples:
      | drive    |
      | Personal |
      | Shares   |


  Scenario Outline: try to create an internal link share with password of a Personal and Share drive using root endpoint
    When user "Alice" tries to create the following space link share using root endpoint of the Graph API:
      | space           | <drive>  |
      | permissionsRole | internal |
      | password        | %public% |
    Then the HTTP status code should be "400"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": ["error"],
        "properties": {
          "error": {
            "type": "object",
            "required": [
              "code",
              "innererror",
              "message"
            ],
            "properties": {
              "code": {
                "const": "invalidRequest"
              },
              "innererror": {
                "type": "object",
                "required": [
                  "date",
                  "request-id"
                ]
              },
              "message": {
                "const": "unsupported space type"
              }
            }
          }
        }
      }
      """
    Examples:
      | drive    |
      | Personal |
      | Shares   |

  @issue-7879
  Scenario Outline: create a link share of a project-space drive with different permissions using root endpoint
    Given using spaces DAV path
    And the administrator has assigned the role "Space Admin" to user "Alice" using the Graph API
    And user "Alice" has created a space "projectSpace" with the default quota using the Graph API
    When user "Alice" creates the following space link share using root endpoint of the Graph API:
      | space           | projectSpace       |
      | permissionsRole | <permissions-role> |
      | password        | %public%           |
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "hasPassword",
          "id",
          "link"
        ],
        "properties": {
          "hasPassword": {
            "const": true
          },
          "id": {
            "type": "string",
            "pattern": "^[a-zA-Z]{15}$"
          },
          "link": {
            "type": "object",
            "required": [
              "@libre.graph.displayName",
              "@libre.graph.quickLink",
              "preventsDownload",
              "type",
              "webUrl"
            ],
            "properties": {
              "@libre.graph.displayName": {
                "const": ""
              },
              "@libre.graph.quickLink": {
                "const": false
              },
              "preventsDownload": {
                "const": false
              },
              "type": {
                "const": "<permissions-role>"
              },
              "webUrl": {
                "type": "string",
                "pattern": "^%base_url%/s/[a-zA-Z]{15}$"
              }
            }
          }
        }
      }
      """
    Examples:
      | permissions-role |
      | view             |
      | edit             |
      | upload           |
      | createOnly       |
      | blocksDownload   |


  Scenario: create an internal link share of a project-space using root endpoint
    Given using spaces DAV path
    And the administrator has assigned the role "Space Admin" to user "Alice" using the Graph API
    And user "Alice" has created a space "projectSpace" with the default quota using the Graph API
    When user "Alice" creates the following space link share using root endpoint of the Graph API:
      | space           | projectSpace  |
      | permissionsRole | internal      |
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "hasPassword",
          "id",
          "link"
        ],
        "properties": {
          "hasPassword": {
            "const": false
          },
          "id": {
            "pattern": "^[a-zA-Z]{15}$"
          },
          "link": {
            "type": "object",
            "required": [
              "@libre.graph.displayName",
              "@libre.graph.quickLink",
              "preventsDownload",
              "type",
              "webUrl"
            ],
            "properties": {
              "@libre.graph.displayName": {
                "const": ""
              },
              "@libre.graph.quickLink": {
                "const": false
              },
              "preventsDownload": {
                "const": false
              },
              "type": {
                "const": "internal"
              },
              "webUrl": {
                "type": "string",
                "pattern": "^%base_url%/s/[a-zA-Z]{15}$"
              }
            }
          }
        }
      }
      """


  Scenario: try to create an internal link share of a project-space drive with password
    Given using spaces DAV path
    And the administrator has assigned the role "Space Admin" to user "Alice" using the Graph API
    And user "Alice" has created a space "projectSpace" with the default quota using the Graph API
    When user "Alice" tries to create the following space link share using root endpoint of the Graph API:
      | space           | projectSpace  |
      | permissionsRole | internal      |
      | password        | %public%      |
    Then the HTTP status code should be "400"

  @issue-7879
  Scenario Outline: create a link share of a project-space drive with display name and expiry date using root endpoint
    Given using spaces DAV path
    And the administrator has assigned the role "Space Admin" to user "Alice" using the Graph API
    And user "Alice" has created a space "projectSpace" with the default quota using the Graph API
    When user "Alice" creates the following space link share using root endpoint of the Graph API:
      | space              | projectSpace             |
      | permissionsRole    | <permissions-role>       |
      | password           | %public%                 |
      | displayName        | Homework                 |
      | expirationDateTime | 2200-07-15T14:00:00.000Z |
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "hasPassword",
          "id",
          "link",
          "expirationDateTime"
        ],
        "properties": {
          "hasPassword": {
            "const": true
          },
          "id": {
            "type": "string",
            "pattern": "^[a-zA-Z]{15}$"
          },
          "expirationDateTime": {
            "const": "2200-07-15T23:59:59Z"
          },
          "link": {
            "type": "object",
            "required": [
              "@libre.graph.displayName",
              "@libre.graph.quickLink",
              "preventsDownload",
              "type",
              "webUrl"
            ],
            "properties": {
              "@libre.graph.displayName": {
                "const": "Homework"
              },
              "@libre.graph.quickLink": {
                "const": false
              },
              "preventsDownload": {
                "const": false
              },
              "type": {
                "const": "<permissions-role>"
              },
              "webUrl": {
                "type": "string",
                "pattern": "^%base_url%/s/[a-zA-Z]{15}$"
              }
            }
          }
        }
      }
      """
    Examples:
      | permissions-role |
      | view             |
      | edit             |
      | upload           |
      | createOnly       |
      | blocksDownload   |

  @issue-7879
  Scenario Outline: try to create a link share of a project-space drive with a password that is listed in the Banned-Password-List using root endpoint
    Given the config "OCIS_PASSWORD_POLICY_BANNED_PASSWORDS_LIST" has been set to path "config/drone/banned-password-list.txt"
    And using spaces DAV path
    And the administrator has assigned the role "Space Admin" to user "Alice" using the Graph API
    And user "Alice" has created a space "projectSpace" with the default quota using the Graph API
    When user "Alice" tries to create the following space link share using root endpoint of the Graph API:
      | space           | projectSpace       |
      | permissionsRole | <permissions-role> |
      | password        | <banned-password>  |
    Then the HTTP status code should be "400"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "error"
        ],
        "properties": {
          "error": {
            "type": "object",
            "required": [
              "code",
              "message"
            ],
            "properties": {
              "code": {
                "type": "string",
                "pattern": "invalidRequest"
              },
              "message": {
                "const": "unfortunately, your password is commonly used. please pick a harder-to-guess password for your safety"
              }
            }
          }
        }
      }
      """
    Examples:
      | banned-password | permissions-role |
      | 123             | view             |
      | password        | view             |
      | ownCloud        | view             |
      | 123             | edit             |
      | password        | edit             |
      | ownCloud        | edit             |
      | 123             | upload           |
      | password        | upload           |
      | ownCloud        | upload           |
      | 123             | createOnly       |
      | password        | createOnly       |
      | ownCloud        | createOnly       |
      | 123             | blocksDownload   |
      | password        | blocksDownload   |
      | ownCloud        | blocksDownload   |

  @env-config @issue-7879
  Scenario Outline: create a link share of a project-space drive without password using root endpoint
    Given the following configs have been set:
      | config                                       | value |
      | OCIS_SHARING_PUBLIC_SHARE_MUST_HAVE_PASSWORD | false |
    And using spaces DAV path
    And the administrator has assigned the role "Space Admin" to user "Alice" using the Graph API
    And user "Alice" has created a space "projectSpace" with the default quota using the Graph API
    When user "Alice" creates the following space link share using root endpoint of the Graph API:
      | space           | projectSpace       |
      | permissionsRole | <permissions-role> |
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "hasPassword",
          "id",
          "link"
        ],
        "properties": {
          "hasPassword": {
            "const": false
          },
          "id": {
            "type": "string",
            "pattern": "^[a-zA-Z]{15}$"
          },
          "link": {
            "type": "object",
            "required": [
              "@libre.graph.displayName",
              "@libre.graph.quickLink",
              "preventsDownload",
              "type",
              "webUrl"
            ],
            "properties": {
              "@libre.graph.displayName": {
                "const": ""
              },
              "@libre.graph.quickLink": {
                "const": false
              },
              "preventsDownload": {
                "const": false
              },
              "type": {
                "const": "<permissions-role>"
              },
              "webUrl": {
                "type": "string",
                "pattern": "^%base_url%/s/[a-zA-Z]{15}$"
              }
            }
          }
        }
      }
      """
    Examples:
      | permissions-role |
      | view             |
      | edit             |
      | upload           |
      | createOnly       |
      | blocksDownload   |

  @issue-7879
  Scenario Outline: create a link share of a project-space drive with display name using root endpoint
    Given using spaces DAV path
    And the administrator has assigned the role "Space Admin" to user "Alice" using the Graph API
    And user "Alice" has created a space "projectSpace" with the default quota using the Graph API
    When user "Alice" creates the following space link share using root endpoint of the Graph API:
      | space              | projectSpace             |
      | permissionsRole    | <permissions-role>       |
      | password           | %public%                 |
      | displayName        | Homework                 |
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "hasPassword",
          "id",
          "link"
        ],
        "properties": {
          "hasPassword": {
            "const": true
          },
          "id": {
            "type": "string",
            "pattern": "^[a-zA-Z]{15}$"
          },
          "link": {
            "type": "object",
            "required": [
              "@libre.graph.displayName",
              "@libre.graph.quickLink",
              "preventsDownload",
              "type",
              "webUrl"
            ],
            "properties": {
              "@libre.graph.displayName": {
                "const": "Homework"
              },
              "@libre.graph.quickLink": {
                "const": false
              },
              "preventsDownload": {
                "const": false
              },
              "type": {
                "const": "<permissions-role>"
              },
              "webUrl": {
                "type": "string",
                "pattern": "^%base_url%/s/[a-zA-Z]{15}$"
              }
            }
          }
        }
      }
      """
    Examples:
      | permissions-role |
      | view             |
      | edit             |
      | upload           |
      | createOnly       |
      | blocksDownload   |

  @issue-7879
  Scenario Outline: create a link share of a project-space drive with expiry date using root endpoint
    Given using spaces DAV path
    And the administrator has assigned the role "Space Admin" to user "Alice" using the Graph API
    And user "Alice" has created a space "projectSpace" with the default quota using the Graph API
    When user "Alice" creates the following space link share using root endpoint of the Graph API:
      | space              | projectSpace             |
      | permissionsRole    | <permissions-role>       |
      | password           | %public%                 |
      | expirationDateTime | 2200-07-15T14:00:00.000Z |
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "hasPassword",
          "id",
          "link",
          "expirationDateTime"
        ],
        "properties": {
          "hasPassword": {
            "const": true
          },
          "id": {
            "type": "string",
            "pattern": "^[a-zA-Z]{15}$"
          },
          "expirationDateTime": {
            "const": "2200-07-15T23:59:59Z"
          },
          "link": {
            "type": "object",
            "required": [
              "@libre.graph.displayName",
              "@libre.graph.quickLink",
              "preventsDownload",
              "type",
              "webUrl"
            ],
            "properties": {
              "@libre.graph.displayName": {
                "const": ""
              },
              "@libre.graph.quickLink": {
                "const": false
              },
              "preventsDownload": {
                "const": false
              },
              "type": {
                "const": "<permissions-role>"
              },
              "webUrl": {
                "type": "string",
                "pattern": "^%base_url%/s/[a-zA-Z]{15}$"
              }
            }
          }
        }
      }
      """
    Examples:
      | permissions-role |
      | view             |
      | edit             |
      | upload           |
      | createOnly       |
      | blocksDownload   |

  @env-config
  Scenario: set password on a existing link share of a project-space drive using root endpoint
    Given the following configs have been set:
      | config                                       | value |
      | OCIS_SHARING_PUBLIC_SHARE_MUST_HAVE_PASSWORD | false |
    And using spaces DAV path
    And the administrator has assigned the role "Space Admin" to user "Alice" using the Graph API
    And user "Alice" has created a space "projectSpace" with the default quota using the Graph API
    And user "Alice" has uploaded a file inside space "projectSpace" with content "to share" to "textfile.txt"
    And user "Alice" has created the following space link share:
      | space           | projectSpace |
      | permissionsRole | view         |
    When user "Alice" sets the following password for the last space link share using root endpoint of the Graph API:
      | space    | projectSpace |
      | password | %public%     |
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "hasPassword"
        ],
        "properties": {
          "hasPassword": {
            "const": true
          }
        }
      }
      """
    And the public should be able to download file "textfile.txt" from the last link share with password "%public%" and the content should be "to share"


  Scenario: update password on a existing link share of a project-space drive using root endpoint
    And using spaces DAV path
    And the administrator has assigned the role "Space Admin" to user "Alice" using the Graph API
    And user "Alice" has created a space "projectSpace" with the default quota using the Graph API
    And user "Alice" has uploaded a file inside space "projectSpace" with content "to share" to "textfile.txt"
    And user "Alice" has created the following space link share:
      | space           | projectSpace |
      | permissionsRole | view         |
      | password        | $heLlo*1234* |
    When user "Alice" sets the following password for the last space link share using root endpoint of the Graph API:
      | space    | projectSpace |
      | password | %public%     |
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "hasPassword"
        ],
        "properties": {
          "hasPassword": {
            "const": true
          }
        }
      }
      """
    And the public should be able to download file "textfile.txt" from the last link share with password "%public%" and the content should be "to share"
    And the public download of file "textfile.txt" from the last link share with password "$heLlo*1234*" should fail with HTTP status code "401" using shareNg

  @issue-7879
  Scenario Outline: try to create a link share of a Personal and Shares drives using permissions endpoint
    When user "Alice" tries to create the following space link share using permissions endpoint of the Graph API:
      | space           | <drive>            |
      | permissionsRole | <permissions-role> |
      | password        | %public%           |
    Then the HTTP status code should be "400"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": ["error"],
        "properties": {
          "error": {
            "type": "object",
            "required": [
              "code",
              "innererror",
              "message"
            ],
            "properties": {
              "code": {
                "const": "invalidRequest"
              },
              "innererror": {
                "type": "object",
                "required": [
                  "date",
                  "request-id"
                ]
              },
              "message": {
                "const": "<message>"
              }
            }
          }
        }
      }
      """
    Examples:
      | permissions-role | drive    | message                                   |
      | view             | Shares   | no share permission                       |
      | edit             | Shares   | no share permission                       |
      | upload           | Shares   | no share permission                       |
      | createOnly       | Shares   | no share permission                       |
      | blocksDownload   | Shares   | invalid link type                         |
      | view             | Personal | cannot create link on personal space root |
      | edit             | Personal | cannot create link on personal space root |
      | upload           | Personal | cannot create link on personal space root |
      | createOnly       | Personal | cannot create link on personal space root |
      | blocksDownload   | Personal | invalid link type                         |

  @issue-7879
  Scenario Outline: create a link share of a project-space drive using permissions endpoint
    Given using spaces DAV path
    And the administrator has assigned the role "Space Admin" to user "Alice" using the Graph API
    And user "Alice" has created a space "projectSpace" with the default quota using the Graph API
    When user "Alice" creates the following space link share using permissions endpoint of the Graph API:
      | space           | projectSpace       |
      | permissionsRole | <permissions-role> |
      | password        | %public%           |
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "hasPassword",
          "id",
          "link"
        ],
        "properties": {
          "hasPassword": {
            "const": true
          },
          "id": {
            "type": "string",
            "pattern": "^[a-zA-Z]{15}$"
          },
          "link": {
            "type": "object",
            "required": [
              "@libre.graph.displayName",
              "@libre.graph.quickLink",
              "preventsDownload",
              "type",
              "webUrl"
            ],
            "properties": {
              "@libre.graph.displayName": {
                "const": ""
              },
              "@libre.graph.quickLink": {
                "const": false
              },
              "preventsDownload": {
                "const": false
              },
              "type": {
                "const": "<permissions-role>"
              },
              "webUrl": {
                "type": "string",
                "pattern": "^%base_url%/s/[a-zA-Z]{15}$"
              }
            }
          }
        }
      }
      """
    Examples:
      | permissions-role |
      | view             |
      | edit             |
      | upload           |
      | createOnly       |
      | blocksDownload   |


  Scenario Outline: try to create an internal link share of a Personal and Shares drives using permissions endpoint
    When user "Alice" tries to create the following space link share using permissions endpoint of the Graph API:
      | space           | <drive>  |
      | permissionsRole | internal |
    Then the HTTP status code should be "400"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": ["error"],
        "properties": {
          "error": {
            "type": "object",
            "required": [
              "code",
              "innererror",
              "message"
            ],
            "properties": {
              "code": {
                "const": "invalidRequest"
              },
              "innererror": {
                "type": "object",
                "required": [
                  "date",
                  "request-id"
                ]
              },
              "message": {
                "const": "<message>"
              }
            }
          }
        }
      }
      """
    Examples:
      | drive    | message                                   |
      | Personal | cannot create link on personal space root |
      | Shares   | no share permission                       |


  Scenario Outline: try to create an internal link share with password of a Personal and Shares drives using permissions endpoint
    When user "Alice" tries to create the following space link share using permissions endpoint of the Graph API:
      | space           | <drive>  |
      | permissionsRole | internal |
      | password        | %public% |
    Then the HTTP status code should be "400"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": ["error"],
        "properties": {
          "error": {
            "type": "object",
            "required": [
              "code",
              "innererror",
              "message"
            ],
            "properties": {
              "code": {
                "const": "invalidRequest"
              },
              "innererror": {
                "type": "object",
                "required": [
                  "date",
                  "request-id"
                ]
              },
              "message": {
                "const": "password is redundant for the internal link"
              }
            }
          }
        }
      }
      """
    Examples:
      | drive    |
      | Personal |
      | Shares   |


  Scenario: create an internal link share of a project-space using permissions endpoint
    Given using spaces DAV path
    And the administrator has assigned the role "Space Admin" to user "Alice" using the Graph API
    And user "Alice" has created a space "projectSpace" with the default quota using the Graph API
    When user "Alice" creates the following space link share using permissions endpoint of the Graph API:
      | space           | projectSpace  |
      | permissionsRole | internal      |
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "hasPassword",
          "id",
          "link"
        ],
        "properties": {
          "hasPassword": {
            "const": false
          },
          "id": {
            "pattern": "^[a-zA-Z]{15}$"
          },
          "link": {
            "type": "object",
            "required": [
              "@libre.graph.displayName",
              "@libre.graph.quickLink",
              "preventsDownload",
              "type",
              "webUrl"
            ],
            "properties": {
              "@libre.graph.displayName": {
                "const": ""
              },
              "@libre.graph.quickLink": {
                "const": false
              },
              "preventsDownload": {
                "const": false
              },
              "type": {
                "const": "internal"
              },
              "webUrl": {
                "type": "string",
                "pattern": "^%base_url%/s/[a-zA-Z]{15}$"
              }
            }
          }
        }
      }
      """


  Scenario: try to create an internal link share of a project-space with password using permissions endpoint
    Given using spaces DAV path
    And the administrator has assigned the role "Space Admin" to user "Alice" using the Graph API
    And user "Alice" has created a space "projectSpace" with the default quota using the Graph API
    When user "Alice" creates the following space link share using permissions endpoint of the Graph API:
      | space           | projectSpace  |
      | permissionsRole | internal      |
      | password        | %public%      |
    Then the HTTP status code should be "400"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": ["error"],
        "properties": {
          "error": {
            "type": "object",
            "required": [
              "code",
              "innererror",
              "message"
            ],
            "properties": {
              "code": {
                "const": "invalidRequest"
              },
              "innererror": {
                "type": "object",
                "required": [
                  "date",
                  "request-id"
                ]
              },
              "message": {
                "const": "password is redundant for the internal link"
              }
            }
          }
        }
      }
      """


  Scenario Outline: create a link share of a project-space with display name and expiry date using permissions endpoint
    Given using spaces DAV path
    And the administrator has assigned the role "Space Admin" to user "Alice" using the Graph API
    And user "Alice" has created a space "projectSpace" with the default quota using the Graph API
    When user "Alice" creates the following space link share using permissions endpoint of the Graph API:
      | space              | projectSpace             |
      | permissionsRole    | <permissions-role>       |
      | password           | %public%                 |
      | displayName        | Homework                 |
      | expirationDateTime | 2200-07-15T14:00:00.000Z |
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "hasPassword",
          "id",
          "link",
          "expirationDateTime"
        ],
        "properties": {
          "hasPassword": {
            "const": true
          },
          "id": {
            "type": "string",
            "pattern": "^[a-zA-Z]{15}$"
          },
          "expirationDateTime": {
            "const": "2200-07-15T23:59:59Z"
          },
          "link": {
            "type": "object",
            "required": [
              "@libre.graph.displayName",
              "@libre.graph.quickLink",
              "preventsDownload",
              "type",
              "webUrl"
            ],
            "properties": {
              "@libre.graph.displayName": {
                "const": "Homework"
              },
              "@libre.graph.quickLink": {
                "const": false
              },
              "preventsDownload": {
                "const": false
              },
              "type": {
                "const": "<permissions-role>"
              },
              "webUrl": {
                "type": "string",
                "pattern": "^%base_url%/s/[a-zA-Z]{15}$"
              }
            }
          }
        }
      }
      """
    Examples:
      | permissions-role |
      | view             |
      | edit             |
      | upload           |
      | createOnly       |
      | blocksDownload   |


  Scenario Outline: try to create a link share of a project-space with a password that is listed in the Banned-Password-List using permissions endpoint
    Given the config "OCIS_PASSWORD_POLICY_BANNED_PASSWORDS_LIST" has been set to path "config/drone/banned-password-list.txt"
    And using spaces DAV path
    And the administrator has assigned the role "Space Admin" to user "Alice" using the Graph API
    And user "Alice" has created a space "projectSpace" with the default quota using the Graph API
    When user "Alice" creates the following space link share using permissions endpoint of the Graph API:
      | space           | projectSpace       |
      | permissionsRole | <permissions-role> |
      | password        | <banned-password>  |
    Then the HTTP status code should be "400"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "error"
        ],
        "properties": {
          "error": {
            "type": "object",
            "required": [
              "code",
              "message"
            ],
            "properties": {
              "code": {
                "type": "string",
                "pattern": "invalidRequest"
              },
              "message": {
                "const": "unfortunately, your password is commonly used. please pick a harder-to-guess password for your safety"
              }
            }
          }
        }
      }
      """
    Examples:
      | banned-password | permissions-role |
      | 123             | view             |
      | password        | view             |
      | ownCloud        | view             |
      | 123             | edit             |
      | password        | edit             |
      | ownCloud        | edit             |
      | 123             | upload           |
      | password        | upload           |
      | ownCloud        | upload           |
      | 123             | createOnly       |
      | password        | createOnly       |
      | ownCloud        | createOnly       |
      | 123             | blocksDownload   |
      | password        | blocksDownload   |
      | ownCloud        | blocksDownload   |


  Scenario Outline: create a link share of a project-space without password using permissions endpoint
    Given the following configs have been set:
      | config                                       | value |
      | OCIS_SHARING_PUBLIC_SHARE_MUST_HAVE_PASSWORD | false |
    And using spaces DAV path
    And the administrator has assigned the role "Space Admin" to user "Alice" using the Graph API
    And user "Alice" has created a space "projectSpace" with the default quota using the Graph API
    When user "Alice" creates the following space link share using permissions endpoint of the Graph API:
      | space           | projectSpace       |
      | permissionsRole | <permissions-role> |
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
      {
        "type": "object",
        "required": [
          "hasPassword",
          "id",
          "link"
        ],
        "properties": {
          "hasPassword": {
            "const": false
          },
          "id": {
            "type": "string",
            "pattern": "^[a-zA-Z]{15}$"
          },
          "link": {
            "type": "object",
            "required": [
              "@libre.graph.displayName",
              "@libre.graph.quickLink",
              "preventsDownload",
              "type",
              "webUrl"
            ],
            "properties": {
              "@libre.graph.displayName": {
                "const": ""
              },
              "@libre.graph.quickLink": {
                "const": false
              },
              "preventsDownload": {
                "const": false
              },
              "type": {
                "const": "<permissions-role>"
              },
              "webUrl": {
                "type": "string",
                "pattern": "^%base_url%/s/[a-zA-Z]{15}$"
              }
            }
          }
        }
      }
      """
    Examples:
      | permissions-role |
      | view             |
      | edit             |
      | upload           |
      | createOnly       |
      | blocksDownload   |


  Scenario Outline: update link share of a project-space using permissions endpoint
    Given using spaces DAV path
    And the administrator has assigned the role "Space Admin" to user "Alice" using the Graph API
    And user "Alice" has created a space "projectSpace" with the default quota using the Graph API
    And user "Alice" has created the following space link share:
      | space              | projectSpace             |
      | permissionsRole    | <permissions-role>       |
      | password           | %public%                 |
      | displayName        | Homework                 |
      | expirationDateTime | 2200-07-15T14:00:00.000Z |
    When user "Alice" updates the last public link share using the permissions endpoint of the Graph API:
      | space              | projectSpace           |
      | permissionsRole    | <new-permissions-role> |
      | password           | p@$$w0rD               |
      | expirationDateTime | 2201-07-15T14:00:00Z   |
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
        {
          "type": "object",
          "required": [
            "hasPassword",
            "id",
            "link",
            "expirationDateTime",
            "createdDateTime"
          ],
          "properties": {
            "hasPassword": {
              "const": true
            },
            "id": {
              "type": "string",
              "pattern": "^[a-zA-Z]{15}$"
            },
            "expirationDateTime": {
              "const": "2201-07-15T23:59:59Z"
            },
            "link": {
              "type": "object",
              "required": [
                "@libre.graph.displayName",
                "@libre.graph.quickLink",
                "preventsDownload",
                "type",
                "webUrl"
              ],
              "properties": {
                "@libre.graph.displayName": {
                  "const": "Homework"
                },
                "@libre.graph.quickLink": {
                  "const": false
                },
                "preventsDownload": {
                  "const": false
                },
                "type": {
                  "const": "<new-permissions-role>"
                },
                "webUrl": {
                  "type": "string",
                  "pattern": "^%base_url%/s/[a-zA-Z]{15}$"
                }
              }
            }
          }
        }
        """
    Examples:
      | permissions-role | new-permissions-role |
      | view             | edit                 |
      | view             | upload               |
      | view             | createOnly           |
      | edit             | view                 |
      | edit             | upload               |
      | edit             | createOnly           |
      | upload           | view                 |
      | upload           | edit                 |
      | upload           | createOnly           |
      | createOnly       | view                 |
      | createOnly       | edit                 |
      | createOnly       | upload               |
      | blocksDownload   | blocksDownload       |


  Scenario Outline: update role of a folder's link share inside project-space using permissions endpoint
    Given using spaces DAV path
    And the administrator has assigned the role "Space Admin" to user "Alice" using the Graph API
    And user "Alice" has created a space "projectSpace" with the default quota using the Graph API
    And user "Alice" has created a folder "folderToShare" in space "projectSpace"
    And user "Alice" has created the following resource link share:
      | resource        | folderToShare      |
      | space           | projectSpace       |
      | permissionsRole | <permissions-role> |
      | displayName     | Link               |
      | password        | %public%           |
    When user "Alice" updates the last public link share using the permissions endpoint of the Graph API:
      | resource           | folderToShare          |
      | space              | projectSpace           |
      | permissionsRole    | <new-permissions-role> |
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
        {
          "type": "object",
          "required": [
            "hasPassword",
            "id",
            "link",
            "createdDateTime"
          ],
          "properties": {
            "hasPassword": {
              "const": true
            },
            "id": {
              "type": "string",
              "pattern": "^[a-zA-Z]{15}$"
            },
            "expirationDateTime": {
              "const": "2201-07-15T23:59:59Z"
            },
            "link": {
              "type": "object",
              "required": [
                "@libre.graph.displayName",
                "@libre.graph.quickLink",
                "preventsDownload",
                "type",
                "webUrl"
              ],
              "properties": {
                "@libre.graph.displayName": {
                  "const": "Link"
                },
                "@libre.graph.quickLink": {
                  "const": false
                },
                "preventsDownload": {
                  "const": false
                },
                "type": {
                  "const": "<new-permissions-role>"
                },
                "webUrl": {
                  "type": "string",
                  "pattern": "^%base_url%/s/[a-zA-Z]{15}$"
                }
              }
            }
          }
        }
        """
    Examples:
      | permissions-role | new-permissions-role |
      | view             | edit                 |
      | view             | upload               |
      | view             | createOnly           |
      | edit             | view                 |
      | edit             | upload               |
      | edit             | createOnly           |
      | upload           | view                 |
      | upload           | edit                 |
      | upload           | createOnly           |
      | createOnly       | view                 |
      | createOnly       | edit                 |
      | createOnly       | upload               |


  Scenario Outline: update role of a file's link share inside a project-space using permissions endpoint
    Given using spaces DAV path
    And the administrator has assigned the role "Space Admin" to user "Alice" using the Graph API
    And user "Alice" has created a space "projectSpace" with the default quota using the Graph API
    And user "Alice" has uploaded a file inside space "projectSpace" with content "to share" to "textfile.txt"
    And user "Alice" has created the following resource link share:
      | resource        | textfile.txt       |
      | space           | projectSpace       |
      | permissionsRole | <permissions-role> |
      | displayName     | Link               |
      | password        | %public%           |
    When user "Alice" updates the last public link share using the permissions endpoint of the Graph API:
      | resource           | textfile.txt           |
      | space              | projectSpace           |
      | permissionsRole    | <new-permissions-role> |
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
        {
          "type": "object",
          "required": [
            "hasPassword",
            "id",
            "link",
            "createdDateTime"
          ],
          "properties": {
            "hasPassword": {
              "const": true
            },
            "id": {
              "type": "string",
              "pattern": "^[a-zA-Z]{15}$"
            },
            "link": {
              "type": "object",
              "required": [
                "@libre.graph.displayName",
                "@libre.graph.quickLink",
                "preventsDownload",
                "type",
                "webUrl"
              ],
              "properties": {
                "@libre.graph.displayName": {
                  "const": "Link"
                },
                "@libre.graph.quickLink": {
                  "const": false
                },
                "preventsDownload": {
                  "const": false
                },
                "type": {
                  "const": "<new-permissions-role>"
                },
                "webUrl": {
                  "type": "string",
                  "pattern": "^%base_url%/s/[a-zA-Z]{15}$"
                }
              }
            }
          }
        }
        """
    Examples:
      | permissions-role | new-permissions-role |
      | view             | edit                 |
      | edit             | view                 |


  Scenario Outline: update role of a file's link share to internal inside a project-space using permissions endpoint
    Given using spaces DAV path
    And the administrator has assigned the role "Space Admin" to user "Alice" using the Graph API
    And user "Alice" has created a space "projectSpace" with the default quota using the Graph API
    And user "Alice" has uploaded a file inside space "projectSpace" with content "to share" to "textfile.txt"
    And user "Alice" has created the following resource link share:
      | resource        | textfile.txt       |
      | space           | projectSpace       |
      | permissionsRole | <permissions-role> |
      | displayName     | Link               |
      | password        | %public%           |
    When user "Alice" updates the last public link share using the permissions endpoint of the Graph API:
      | resource           | textfile.txt           |
      | space              | projectSpace           |
      | permissionsRole    | <new-permissions-role> |
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
        {
          "type": "object",
          "required": [
            "hasPassword",
            "id",
            "link",
            "createdDateTime"
          ],
          "properties": {
            "hasPassword": {
              "const": false
            },
            "id": {
              "type": "string",
              "pattern": "^[a-zA-Z]{15}$"
            },
            "link": {
              "type": "object",
              "required": [
                "@libre.graph.displayName",
                "@libre.graph.quickLink",
                "preventsDownload",
                "type",
                "webUrl"
              ],
              "properties": {
                "@libre.graph.displayName": {
                  "const": "Link"
                },
                "@libre.graph.quickLink": {
                  "const": false
                },
                "preventsDownload": {
                  "const": false
                },
                "type": {
                  "const": "<new-permissions-role>"
                },
                "webUrl": {
                  "type": "string",
                  "pattern": "^%base_url%/s/[a-zA-Z]{15}$"
                }
              }
            }
          }
        }
        """
    Examples:
      | permissions-role | new-permissions-role |
      | view             | internal             |
      | edit             | internal             |


  Scenario Outline: update role of a folder's link share to internal inside project-space using permissions endpoint
    Given using spaces DAV path
    And the administrator has assigned the role "Space Admin" to user "Alice" using the Graph API
    And user "Alice" has created a space "projectSpace" with the default quota using the Graph API
    And user "Alice" has created a folder "folderToShare" in space "projectSpace"
    And user "Alice" has created the following resource link share:
      | resource        | folderToShare      |
      | space           | projectSpace       |
      | permissionsRole | <permissions-role> |
      | displayName     | Link               |
      | password        | %public%           |
    When user "Alice" updates the last public link share using the permissions endpoint of the Graph API:
      | resource           | folderToShare          |
      | space              | projectSpace           |
      | permissionsRole    | <new-permissions-role> |
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
        {
          "type": "object",
          "required": [
            "hasPassword",
            "id",
            "link",
            "createdDateTime"
          ],
          "properties": {
            "hasPassword": {
              "const": false
            },
            "id": {
              "type": "string",
              "pattern": "^[a-zA-Z]{15}$"
            },
            "expirationDateTime": {
              "const": "2201-07-15T23:59:59Z"
            },
            "link": {
              "type": "object",
              "required": [
                "@libre.graph.displayName",
                "@libre.graph.quickLink",
                "preventsDownload",
                "type",
                "webUrl"
              ],
              "properties": {
                "@libre.graph.displayName": {
                  "const": "Link"
                },
                "@libre.graph.quickLink": {
                  "const": false
                },
                "preventsDownload": {
                  "const": false
                },
                "type": {
                  "const": "<new-permissions-role>"
                },
                "webUrl": {
                  "type": "string",
                  "pattern": "^%base_url%/s/[a-zA-Z]{15}$"
                }
              }
            }
          }
        }
        """
    Examples:
      | permissions-role | new-permissions-role |
      | view             | internal             |
      | edit             | internal             |
      | upload           | internal             |
      | createOnly       | internal             |



  Scenario Outline: update link share of a folder inside personal drive using permissions endpoint
    Given user "Alice" has created folder "folder"
    And user "Alice" has created the following resource link share:
      | space           | Personal           |
      | resource        | folder             |
      | permissionsRole | <permissions-role> |
      | password        | %public%           |
      | displayName     | Homework           |
    When user "Alice" updates the last public link share using the permissions endpoint of the Graph API:
      | space              | Personal               |
      | resource           | folder                 |
      | permissionsRole    | <new-permissions-role> |
      | password           | p@$$w0rD               |
      | expirationDateTime | 2201-07-15T14:00:00Z   |
    Then the HTTP status code should be "200"
    And the JSON data of the response should match
      """
        {
          "type": "object",
          "required": [
            "hasPassword",
            "id",
            "link",
            "expirationDateTime",
            "createdDateTime"
          ],
          "properties": {
            "hasPassword": {
              "const": true
            },
            "id": {
              "type": "string",
              "pattern": "^[a-zA-Z]{15}$"
            },
            "expirationDateTime": {
              "const": "2201-07-15T23:59:59Z"
            },
            "link": {
              "type": "object",
              "required": [
                "@libre.graph.displayName",
                "@libre.graph.quickLink",
                "preventsDownload",
                "type",
                "webUrl"
              ],
              "properties": {
                "@libre.graph.displayName": {
                  "const": "Homework"
                },
                "@libre.graph.quickLink": {
                  "const": false
                },
                "preventsDownload": {
                  "const": false
                },
                "type": {
                  "const": "<new-permissions-role>"
                },
                "webUrl": {
                  "type": "string",
                  "pattern": "^%base_url%/s/[a-zA-Z]{15}$"
                }
              }
            }
          }
        }
      """
    Examples:
      | permissions-role | new-permissions-role |
      | view             | edit                 |
      | view             | upload               |
      | view             | createOnly           |
      | edit             | view                 |
      | edit             | upload               |
      | edit             | createOnly           |
      | upload           | view                 |
      | upload           | edit                 |
      | upload           | createOnly           |
      | createOnly       | view                 |
      | createOnly       | edit                 |
      | createOnly       | upload               |
      | blocksDownload   | blocksDownload       |
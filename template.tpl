___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Unique Event ID",
  "description": "Ultra simple code to generate (UUID v7 like, but only numbers) IDs to deduplicate browser- and server-side events.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const ts = require('templateStorage');
const dl = require('copyFromDataLayer');
const t = require('getTimestampMillis');
const g = require('generateRandom');
const s = '-';

const gt = dl('gtm.uniqueEventId', 1);

if (ts.getItem(gt) !== null) {
  return ts.getItem(gt);
}


function gr() { return g(100000, 999999); }

const uniqueId = t() + s + [0, 0, 0, 0]
  .map(gr)
  .join(s);

ts.setItem(gt, uniqueId);

return uniqueId;


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "access_template_storage",
        "versionId": "1"
      },
      "param": []
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "read_data_layer",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedKeys",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "keyPatterns",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "gtm.uniqueEventId"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: Return a value
  code: |-
    let variableResult = runCode();


    assertThat(variableResult).isDefined();
- name: Check returned value format
  code: |-
    let variableResult = runCode();

    assertThat(variableResult).isString();
    assertThat(variableResult).contains('-');
    assertThat(variableResult).hasLength(41);
- name: Check ID equality for the same event
  code: |-
    mock('copyFromDataLayer', 5);

    let id1 = runCode();

    let id2 = runCode();

    assertThat(id2).isEqualTo(id1);
- name: Check ID randomness for different events
  code: |-
    mock('copyFromDataLayer', 5);

    let id1 = runCode();

    mock('copyFromDataLayer', 6);

    let id2 = runCode();

    assertThat(id2).isNotEqualTo(id1);


___NOTES___






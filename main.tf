resource "genesyscloud_integration_action" "action" {
    name           = var.action_name
    category       = var.action_category
    integration_id = var.integration_id
    secure         = var.secure_data_action
    
    contract_input  = jsonencode({
        "$schema": "http://json-schema.org/draft-04/schema#",
        "additionalProperties": true,
        "description": "A phone number-based request.",
        "properties": {
            "PHONE_NUMBER": {
                "description": "The phone number used for the query.",
                "type": "string"
            }
        },
        "required": [
            "PHONE_NUMBER"
        ],
        "title": "Phone Number Request",
        "type": "object"
    })
    contract_output = jsonencode({
        "$schema": "http://json-schema.org/draft-04/schema#",
        "items": {
            "$schema": "http://json-schema.org/draft-04/schema#",
            "additionalProperties": true,
            "description": "A Salesforce account.",
            "properties": {
                "Name": {
                    "description": "The name of the account.",
                    "type": "string"
                }
            },
            "title": "Account",
            "type": "object"
        },
        "properties": {},
        "type": "array"
    })
    
    config_request {
        request_template     = "$${input.rawRequest}"
        request_type         = "GET"
        request_url_template = "/services/data/v54.0/search/?q=$esc.url(\"FIND {$salesforce.escReserved($${input.PHONE_NUMBER})} IN PHONE FIELDS RETURNING Account(Name)\")"
        headers = {
			UserAgent = "PureCloudIntegrations/1.0"
		}
    }

    config_response {
        success_template = "$${account}"
        translation_map = { 
			account = "$.searchRecords"
		}
               
    }
}
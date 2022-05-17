package Cx

import data.generic.cloudformation as cloudformation_lib
import data.generic.common as common_lib

CxPolicy[result] {
	resource := input.document[i].Resources[name]
	resource.Type == "AWS::S3::BucketPolicy"

	policy := resource.Properties.PolicyDocument
	st := common_lib.get_statement(common_lib.get_policy(policy))
	statement := st[_]
	common_lib.is_allow_effect(statement)
	common_lib.equalsOrInArray(statement.Resource, "*")
	cloudformation_lib.checkAction(statement.Action, "restore")

	result := {
		"documentId": input.document[i].id,
		"resourceType": resource.Type,
		"resourceName": name,
		"searchKey": sprintf("Resources.%s.Properties.PolicyDocument", [name]),
		"issueType": "IncorrectValue",
		"keyExpectedValue": sprintf("Resources.%s.Properties.PolicyDocument.Statement does not allow a 'Restore' action from all principals", [name]),
		"keyActualValue": sprintf("Resources.%s.Properties.PolicyDocument.Statement allows a 'Restore' action from all principals", [name]),
		"searchLine": common_lib.build_search_line(["Resource", name, "Properties", "PolicyDocument"], []),
	}
}

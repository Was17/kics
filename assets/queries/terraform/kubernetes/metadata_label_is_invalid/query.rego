package Cx

CxPolicy[result] {
	resource := input.document[i].resource[resourceType]

	labels := resource[name].metadata.labels

	regex.match("^(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])?$", labels[key]) == false

	result := {
		"documentId": input.document[i].id,
		"resourceType": resourceType,
		"resourceName": name,
		"searchKey": sprintf("%s[%s].metadata.labels", [resourceType, name]),
		"issueType": "IncorrectValue",
		"keyExpectedValue": sprintf("%s[%s].metada.labels[%s] has valid label", [resourceType, name, key]),
		"keyActualValue": sprintf("%s[%s].metada.labels[%s] has invalid label", [resourceType, name, key]),
	}
}

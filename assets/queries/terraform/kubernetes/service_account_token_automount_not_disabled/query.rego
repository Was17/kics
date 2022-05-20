package Cx

import data.generic.common as common_lib

CxPolicy[result] {
	resource := input.document[i].resource.kubernetes_pod[name]

	not common_lib.valid_key(resource.spec, "automount_service_account_token")

	result := {
		"documentId": input.document[i].id,
		"resourceType": "kubernetes_pod",
		"resourceName": name,
		"searchKey": sprintf("kubernetes_pod[%s].spec", [name]),
		"issueType": "MissingAttribute",
		"keyExpectedValue": sprintf("kubernetes_pod[%s].spec.automount_service_account_token is set", [name]),
		"keyActualValue": sprintf("kubernetes_pod[%s].spec.automount_service_account_token is undefined", [name]),
	}
}

CxPolicy[result] {
	resource := input.document[i].resource.kubernetes_pod[name]

	resource.spec.automount_service_account_token == true

	result := {
		"documentId": input.document[i].id,
		"resourceType": "kubernetes_pod",
		"resourceName": name,
		"searchKey": sprintf("kubernetes_pod[%s].spec.automount_service_account_token", [name]),
		"issueType": "IncorrectValue",
		"keyExpectedValue": sprintf("kubernetes_pod[%s].spec.automount_service_account_token is set to false", [name]),
		"keyActualValue": sprintf("kubernetes_pod[%s].spec.automount_service_account_token is set to true", [name]),
	}
}

listKinds := {"kubernetes_deployment", "kubernetes_daemonset", "kubernetes_job", "kubernetes_stateful_set", "kubernetes_replication_controller"}

CxPolicy[result] {
	resource := input.document[i].resource

	k8 := resource[listKinds[x]][name].spec.template.spec

	not common_lib.valid_key(k8, "automount_service_account_token")

	result := {
		"documentId": input.document[i].id,
		"resourceType": listKinds[x],
		"resourceName": name,
		"searchKey": sprintf("%s[%s].spec.template.spec", [listKinds[x], name]),
		"issueType": "MissingAttribute",
		"keyExpectedValue": sprintf("%s[%s].spec.template.spec.automount_service_account_token is set", [listKinds[x], name]),
		"keyActualValue": sprintf("%s[%s].spec.template.spec.automount_service_account_token is undefined", [listKinds[x], name]),
	}
}

CxPolicy[result] {
	resource := input.document[i].resource

	resource[listKinds[x]][name].spec.template.spec.automount_service_account_token == true

	result := {
		"documentId": input.document[i].id,
		"resourceType": listKinds[x],
		"resourceName": name,
		"searchKey": sprintf("%s[%s].spec.template.spec.automount_service_account_token", [listKinds[x], name]),
		"issueType": "IncorrectValue",
		"keyExpectedValue": sprintf("%s[%s].spec.template.spec.automount_service_account_token is set to false", [listKinds[x], name]),
		"keyActualValue": sprintf("%s[%s].spec.template.spec.automount_service_account_token is set to true", [listKinds[x], name]),
	}
}

CxPolicy[result] {
	resource := input.document[i].resource.kubernetes_cron_job[name]

	not common_lib.valid_key(resource.spec.jobTemplate.spec.template.spec, "automount_service_account_token")

	result := {
		"documentId": input.document[i].id,
		"resourceType": "kubernetes_cron_job",
		"resourceName": name,
		"searchKey": sprintf("kubernetes_cron_job[%s].spec.jobTemplate.spec.template.spec", [name]),
		"issueType": "MissingAttribute",
		"keyExpectedValue": sprintf("kubernetes_cron_job[%s].spec.job_template.spec.template.spec.automount_service_account_token is set", [name]),
		"keyActualValue": sprintf("kubernetes_cron_job[%s].spec.job_template.spec.template.spec.automount_service_account_token is undefined", [name]),
	}
}

CxPolicy[result] {
	resource := input.document[i].resource.kubernetes_cron_job[name]

	resource.spec.job_template.spec.template.spec.automount_service_account_token == true

	result := {
		"documentId": input.document[i].id,
		"resourceType": "kubernetes_cron_job",
		"resourceName": name,
		"searchKey": sprintf("kubernetes_cron_job[%s].spec.job_template.spec.template.spec.automount_service_account_token", [name]),
		"issueType": "IncorrectValue",
		"keyExpectedValue": sprintf("kubernetes_cron_job[%s].spec.job_template.spec.template.spec.automount_service_account_token is set to false", [name]),
		"keyActualValue": sprintf("kubernetes_cron_job[%s].spec.job_template.spec.template.spec.automount_service_account_token is set to true", [name]),
	}
}

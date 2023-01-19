package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestStandardBlobStorageExample(t *testing.T) {
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../examples/standard-blob-storage",
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	storage_account_tier := terraform.Output(t, terraformOptions, "storage_account_tier")
	assert.Equal(t, "Standard", storage_account_tier)

	storage_account_kind := terraform.Output(t, terraformOptions, "storage_account_kind")
	assert.Equal(t, "BlobStorage", storage_account_kind)

	storage_account_replication_type := terraform.Output(t, terraformOptions, "storage_account_replication_type")
	assert.Equal(t, "RAGRS", storage_account_replication_type)
}

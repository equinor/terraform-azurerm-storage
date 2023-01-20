package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestPremiumDataLakeStorageExample(t *testing.T) {
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../examples/premium-data-lake-storage",
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	storage_account_tier := terraform.Output(t, terraformOptions, "storage_account_tier")
	assert.Equal(t, "Premium", storage_account_tier)

	storage_account_kind := terraform.Output(t, terraformOptions, "storage_account_kind")
	assert.Equal(t, "BlockBlobStorage", storage_account_kind)

	storage_account_replication_type := terraform.Output(t, terraformOptions, "storage_account_replication_type")
	assert.Equal(t, "LRS", storage_account_replication_type)
}

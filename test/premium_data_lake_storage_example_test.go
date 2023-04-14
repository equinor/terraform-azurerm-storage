package test

import (
	"log"
	"testing"

	"github.com/gruntwork-io/terratest/modules/azure"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestPremiumDataLakeStorageExample(t *testing.T) {
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../examples/premium-data-lake-storage",
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	// Make sure there are no breaking changes

	storage_account_name := terraform.Output(t, terraformOptions, "storage_account_name")
	resource_group_name := terraform.Output(t, terraformOptions, "resource_group_name")
	subscription_id := terraform.Output(t, terraformOptions, "subscription_id")

	storage_account_tier := azure.GetStorageAccountSkuTier(t, storage_account_name, resource_group_name, subscription_id)
	assert.Equal(t, "Premium", storage_account_tier)

	storage_account_kind := azure.GetStorageAccountKind(t, storage_account_name, resource_group_name, subscription_id)
	assert.Equal(t, "BlockBlobStorage", storage_account_kind)

	storage_account, err := azure.GetStorageAccountE(storage_account_name, resource_group_name, subscription_id)

	if err != nil {
		log.Fatalf("%v", err)
	}

	assert.True(t, *storage_account.AccountProperties.IsHnsEnabled)
}

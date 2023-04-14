package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/azure"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestPremiumBlockBlobStorageExample(t *testing.T) {
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../examples/premium-block-blob-storage",
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
		t.Fatalf("%v", err)
	}

	assert.False(t, *storage_account.AccountProperties.IsHnsEnabled)
}

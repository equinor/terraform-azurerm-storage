package test

import (
	"fmt"
	"log"
	"regexp"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/azure"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestBasicExample(t *testing.T) {
	uniqueApplication := random.UniqueId()
	uniqueEnvironment := random.UniqueId()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../examples/gpv2-storage-account",
		Vars: map[string]interface{}{
			"application": uniqueApplication,
			"environment": uniqueEnvironment,
		},
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	storageAccountName := terraform.Output(t, terraformOptions, "storage_account_name")
	resourceGroupName := terraform.Output(t, terraformOptions, "resource_group_name")
	subscriptionId := terraform.Output(t, terraformOptions, "subscription_id")

	// Check storage account name
	reg, err := regexp.Compile("[^a-z0-9]+")
	if err != nil {
		log.Fatal(err)
	}
	expectedStorageAccountName := reg.ReplaceAllString(strings.ToLower(fmt.Sprintf("st%s%s", uniqueApplication, uniqueEnvironment)), "")
	assert.Equal(t, expectedStorageAccountName, storageAccountName)

	// Check storage account exists
	storageAccountExists := azure.StorageAccountExists(t, storageAccountName, resourceGroupName, subscriptionId)
	assert.True(t, storageAccountExists)

	// Check storage account kind
	storageAccountKind := azure.GetStorageAccountKind(t, storageAccountName, resourceGroupName, subscriptionId)
	assert.Equal(t, "StorageV2", storageAccountKind)

	// Check storage account SKU tier
	storageAccountSkuTier := azure.GetStorageAccountSkuTier(t, storageAccountName, resourceGroupName, subscriptionId)
	assert.Equal(t, "Standard", storageAccountSkuTier)
}

package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestStandardDataLakeStorageExample(t *testing.T) {
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../examples/standard-data-lake-storage",
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)
}

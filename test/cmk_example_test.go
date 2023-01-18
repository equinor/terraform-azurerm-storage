package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestCMKExample(t *testing.T) {
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../examples/cmk",
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)
}

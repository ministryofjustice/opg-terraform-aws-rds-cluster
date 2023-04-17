package test

import (
	"fmt"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraformPostgresServerlessV2(t *testing.T) {
	t.Parallel()

	// Select a random AWS region to test in from a list of regions that we actively use. This helps ensure the code works in all used regions.
	approvedRegions := []string{"eu-west-1", "eu-west-2"}
	awsRegion := aws.GetRandomStableRegion(t, approvedRegions, nil)
	awsAvailabilityZones := aws.GetAvailabilityZones(t, awsRegion)

	expectedClusterIdent := fmt.Sprintf("postgres-serverless-v2-%s", strings.ToLower(random.UniqueId()))
	expectedDbName := "terratest"
	expectedDbUser := "terrauser"
	expectedDbPass := "terrapass"

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../examples/serverlessv2_psql",

		Vars: map[string]interface{}{
			"database_name":      expectedDbName,
			"cluster_identifier": expectedClusterIdent,
			"master_username":    expectedDbUser,
			"master_password":    expectedDbPass,
			"availability_zones": awsAvailabilityZones,
		},

		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": awsRegion,
		},
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	terraformDbName := terraform.Output(t, terraformOptions, "db_name")
	assert.Equal(t, expectedDbName, terraformDbName)
}

// run: go test -v -timeout 40m serverlessv2_psql_test.go

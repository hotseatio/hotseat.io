package envutil

import (
	"sync"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/sns"
)

var (
	client        *sns.SNS
	awsClientOnce sync.Once
)

func CreateAWSClient() *sns.SNS {
	awsClientOnce.Do(func() {
		mySession := session.Must(session.NewSession())
		client = sns.New(mySession, aws.NewConfig().WithRegion("us-east-1"))
	})
	return client

}

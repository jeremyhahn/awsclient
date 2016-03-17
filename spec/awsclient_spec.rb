require 'spec_helper'

describe Awsclient do

  it 'has a version number' do
    expect(Awsclient::VERSION).not_to be nil
  end

  it 'can instantiate default SharedCredentials profile' do
    aws = Awsclient::Connection.new
    expect(aws.credentials.profile_name).to eq("default")
  end

  it 'can instantiate specified SharedCredentials profile' do
    aws = Awsclient::Connection.new
    aws.profile = "rspec"
    expect(aws.credentials.profile_name).to eq("rspec")
  end

  it 'can assume a role' do
    aws = Awsclient::Connection.new
    aws.role = "rspec"
    expect(aws.credentials).to be_an_instance_of Aws::AssumeRoleCredentials
    expect(aws.credentials.client.get_session_token.credentials.access_key_id).to be_truthy
  end
=begin
  it 'can instantiate AWS Certificate Manager client' do
    aws = Awsclient::Connection.new
    expect(aws.acm).to be_an_instance_of Aws::ACM::Client
  end
=end
  it 'can instantiate API Gateway client' do
    aws = Awsclient::Connection.new
    expect(aws.apigateway).to be_an_instance_of Aws::APIGateway::Client
  end

  it 'can instantiate AutoScaling client' do
    aws = Awsclient::Connection.new
    expect(aws.autoscaling).to be_an_instance_of Aws::AutoScaling::Client
  end

  it 'can instantiate CloudFormation client' do
    aws = Awsclient::Connection.new
    expect(aws.cloudformation).to be_an_instance_of Aws::CloudFormation::Client
  end

  it 'can instantiate CloudFront client' do
    aws = Awsclient::Connection.new
    expect(aws.cloudfront).to be_an_instance_of Aws::CloudFront::Client
  end

  it 'can instantiate CloudHSM client' do
    aws = Awsclient::Connection.new
    expect(aws.cloudhsm).to be_an_instance_of Aws::CloudHSM::Client
  end

  it 'can instantiate CloudSearch client' do
    aws = Awsclient::Connection.new
    expect(aws.cloudsearch).to be_an_instance_of Aws::CloudSearch::Client
  end

  it 'can instantiate CloudTrail client' do
    aws = Awsclient::Connection.new
    expect(aws.cloudtrail).to be_an_instance_of Aws::CloudTrail::Client
  end

  it 'can instantiate CloudWatch client' do
    aws = Awsclient::Connection.new
    expect(aws.cloudwatch).to be_an_instance_of Aws::CloudWatch::Client
  end
=begin
  it 'can instantiate CloudWatchEvents client' do
    aws = Awsclient::Connection.new
    expect(aws.cloudwatchevents).to be_an_instance_of Aws::CloudWatchEvents::Client
  end
=end
  it 'can instantiate CloudWatchLogs client' do
    aws = Awsclient::Connection.new
    expect(aws.cloudwatchlogs).to be_an_instance_of Aws::CloudWatchLogs::Client
  end

  it 'can instantiate CodeCommit client' do
    aws = Awsclient::Connection.new
    expect(aws.codecommit).to be_an_instance_of Aws::CodeCommit::Client
  end

  it 'can instantiate CodeDeploy client' do
    aws = Awsclient::Connection.new
    expect(aws.codedeploy).to be_an_instance_of Aws::CodeDeploy::Client
  end

  it 'can instantiate CodePipeline client' do
    aws = Awsclient::Connection.new
    expect(aws.codepipeline).to be_an_instance_of Aws::CodePipeline::Client
  end

  it 'can instantiate CognitoIdentity client' do
    aws = Awsclient::Connection.new
    expect(aws.cognitoidentity).to be_an_instance_of Aws::CognitoIdentity::Client
  end

  it 'can instantiate CognitoSync client' do
    aws = Awsclient::Connection.new
    expect(aws.cognitosync).to be_an_instance_of Aws::CognitoSync::Client
  end

  it 'can instantiate ConfigService client' do
    aws = Awsclient::Connection.new
    expect(aws.configservice).to be_an_instance_of Aws::ConfigService::Client
  end

  it 'can instantiate DataPipeline client' do
    aws = Awsclient::Connection.new
    expect(aws.datapipeline).to be_an_instance_of Aws::DataPipeline::Client
  end
=begin
  it 'can instantiate DatabaseMigrationService client' do
    aws = Awsclient::Connection.new
    expect(aws.databasemigrationservice).to be_an_instance_of Aws::DatabaseMigrationService::Client
  end
=end
  it 'can instantiate DeviceFarm client' do
    aws = Awsclient::Connection.new
    expect(aws.devicefarm).to be_an_instance_of Aws::DeviceFarm::Client
  end

  it 'can instantiate DirectConnect client' do
    aws = Awsclient::Connection.new
    expect(aws.directconnect).to be_an_instance_of Aws::DirectConnect::Client
  end

  it 'can instantiate DirectoryService client' do
    aws = Awsclient::Connection.new
    expect(aws.directoryservice).to be_an_instance_of Aws::DirectoryService::Client
  end

  it 'can instantiate DynamoDB client' do
    aws = Awsclient::Connection.new
    expect(aws.dynamodb).to be_an_instance_of Aws::DynamoDB::Client
  end

  it 'can instantiate DynamoDBStreams client' do
    aws = Awsclient::Connection.new
    expect(aws.dynamodbstreams).to be_an_instance_of Aws::DynamoDBStreams::Client
  end

  it 'can instantiate EC2 client' do
    aws = Awsclient::Connection.new
    expect(aws.ec2).to be_an_instance_of Aws::EC2::Client
  end

  it 'can instantiate ECR client' do
    aws = Awsclient::Connection.new
    expect(aws.ecr).to be_an_instance_of Aws::ECR::Client
  end

  it 'can instantiate ECS client' do
    aws = Awsclient::Connection.new
    expect(aws.ecs).to be_an_instance_of Aws::ECS::Client
  end

  it 'can instantiate EFS client' do
    aws = Awsclient::Connection.new
    expect(aws.efs).to be_an_instance_of Aws::EFS::Client
  end

  it 'can instantiate EMR client' do
    aws = Awsclient::Connection.new
    expect(aws.emr).to be_an_instance_of Aws::EMR::Client
  end

  it 'can instantiate ElasticBeanstalk client' do
    aws = Awsclient::Connection.new
    expect(aws.elasticbeanstalk).to be_an_instance_of Aws::ElasticBeanstalk::Client
  end

  it 'can instantiate ElasticLoadBalancing client' do
    aws = Awsclient::Connection.new
    expect(aws.elasticloadbalancing).to be_an_instance_of Aws::ElasticLoadBalancing::Client
  end

  it 'can instantiate ElasticLoadBalancing client' do
    aws = Awsclient::Connection.new
    expect(aws.elasticloadbalancing).to be_an_instance_of Aws::ElasticLoadBalancing::Client
  end

  it 'can instantiate ElasticTranscoder client' do
    aws = Awsclient::Connection.new
    expect(aws.elastictranscoder).to be_an_instance_of Aws::ElasticTranscoder::Client
  end

  it 'can instantiate ElasticsearchService client' do
    aws = Awsclient::Connection.new
    expect(aws.elasticsearchservice).to be_an_instance_of Aws::ElasticsearchService::Client
  end

  it 'can instantiate Firehose client' do
    aws = Awsclient::Connection.new
    expect(aws.firehose).to be_an_instance_of Aws::Firehose::Client
  end
=begin
  it 'can instantiate GameLift client' do
    aws = Awsclient::Connection.new
    expect(aws.gamelift).to be_an_instance_of Aws::GameLift::Client
  end
=end
  it 'can instantiate Glacier client' do
    aws = Awsclient::Connection.new
    expect(aws.glacier).to be_an_instance_of Aws::Glacier::Client
  end

  it 'can instantiate IAM client' do
    aws = Awsclient::Connection.new
    expect(aws.iam).to be_an_instance_of Aws::IAM::Client
  end

  it 'can instantiate ImportExport client' do
    aws = Awsclient::Connection.new
    expect(aws.importexport).to be_an_instance_of Aws::ImportExport::Client
  end

  it 'can instantiate Inspector client' do
    aws = Awsclient::Connection.new
    expect(aws.inspector).to be_an_instance_of Aws::Inspector::Client
  end

  it 'can instantiate IoT client' do
    aws = Awsclient::Connection.new
    expect(aws.iot).to be_an_instance_of Aws::IoT::Client
  end

  it 'can instantiate IoTDataPlane client' do
    aws = Awsclient::Connection.new
    expect(aws.iotdataplane(endpoint: "http://localhost")).to be_an_instance_of Aws::IoTDataPlane::Client
  end

  it 'can instantiate KMS client' do
    aws = Awsclient::Connection.new
    expect(aws.kms).to be_an_instance_of Aws::KMS::Client
  end

  it 'can instantiate Kinesis client' do
    aws = Awsclient::Connection.new
    expect(aws.kinesis).to be_an_instance_of Aws::Kinesis::Client
  end

  it 'can instantiate Lambda client' do
    aws = Awsclient::Connection.new
    expect(aws.lambda).to be_an_instance_of Aws::Lambda::Client
  end

  it 'can instantiate lambdapreview client' do
    aws = Awsclient::Connection.new
    expect(aws.lambdapreview).to be_an_instance_of Aws::LambdaPreview::Client
  end

  it 'can instantiate MachineLearning client' do
    aws = Awsclient::Connection.new
    expect(aws.machinelearning).to be_an_instance_of Aws::MachineLearning::Client
  end

  it 'can instantiate MarketplaceCommerceAnalytics client' do
    aws = Awsclient::Connection.new
    expect(aws.marketplacecommerceanalytics).to be_an_instance_of Aws::MarketplaceCommerceAnalytics::Client
  end

  it 'can instantiate RDS client' do
    aws = Awsclient::Connection.new
    expect(aws.rds).to be_an_instance_of Aws::RDS::Client
  end

  it 'can instantiate Route53 client' do
    aws = Awsclient::Connection.new
    expect(aws.route53).to be_an_instance_of Aws::Route53::Client
  end

  it 'can instantiate Route53Domains client' do
    aws = Awsclient::Connection.new
    expect(aws.route53domains).to be_an_instance_of Aws::Route53Domains::Client
  end

  it 'can instantiate S3 client' do
    aws = Awsclient::Connection.new
    expect(aws.s3).to be_an_instance_of Aws::S3::Client
  end

  it 'can instantiate S3 client' do
    aws = Awsclient::Connection.new
    expect(aws.s3).to be_an_instance_of Aws::S3::Client
  end

  it 'can instantiate SES client' do
    aws = Awsclient::Connection.new
    expect(aws.ses).to be_an_instance_of Aws::SES::Client
  end

  it 'can instantiate SNS client' do
    aws = Awsclient::Connection.new
    expect(aws.sns).to be_an_instance_of Aws::SNS::Client
  end

  it 'can instantiate SQS client' do
    aws = Awsclient::Connection.new
    expect(aws.sqs).to be_an_instance_of Aws::SQS::Client
  end

  it 'can instantiate SSM client' do
    aws = Awsclient::Connection.new
    expect(aws.ssm).to be_an_instance_of Aws::SSM::Client
  end

  it 'can instantiate STS client' do
    aws = Awsclient::Connection.new
    expect(aws.sts).to be_an_instance_of Aws::STS::Client
  end

  it 'can instantiate SWF client' do
    aws = Awsclient::Connection.new
    expect(aws.swf).to be_an_instance_of Aws::SWF::Client
  end

  it 'can instantiate SimpleDB client' do
    aws = Awsclient::Connection.new
    expect(aws.simpledb).to be_an_instance_of Aws::SimpleDB::Client
  end

  it 'can instantiate StorageGateway client' do
    aws = Awsclient::Connection.new
    expect(aws.storagegateway).to be_an_instance_of Aws::StorageGateway::Client
  end

  it 'can instantiate Support client' do
    aws = Awsclient::Connection.new
    expect(aws.support).to be_an_instance_of Aws::Support::Client
  end

  it 'can instantiate WAF client' do
    aws = Awsclient::Connection.new
    expect(aws.waf).to be_an_instance_of Aws::WAF::Client
  end

  it 'can instantiate Workspaces client' do
    aws = Awsclient::Connection.new
    expect(aws.workspaces).to be_an_instance_of Aws::WorkSpaces::Client
  end

end


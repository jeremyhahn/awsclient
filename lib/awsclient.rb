require "awsclient/version"
require 'aws-sdk'

module Awsclient

  class Connection

    attr_accessor :client_options
    attr_accessor :credentials
    attr_accessor :region

    SERVICES = [
      :acm, :apigateway, :autoscaling, :cloudformation, :cloudfront, :cloudhsm,
      :cloudsearch, :cloudtrail, :cloudwatch, :cloudwatchevents, :cloudwatchlogs,
      :codecommit, :codedeploy, :codepipeline, :cognitoidentity, :cognitosync, :configservice,
      :datapipeline, :databasemigrationservice, :devicefarm, :directconnect, :directoryservice,
      :dynamodb, :dynamodbstreams, :ec2, :ecr, :ecs, :efs, :emr, :elasticache, :elasticbeanstalk,
      :elasticloadbalancing, :elastictranscoder, :elasticsearchservice, :firehose, :gamelift, :glacier,
      :iam, :importexport, :inspector, :iot, :iotdataplane, :kms, :kinesis, :lambda, :lambdapreview,
      :machinelearning, :marketplacecommerceanalysis, :opsworks, :rds, :redshift, :route53, :route53domains,
      :s3, :ses, :sns, :sqs, :ssm, :sts, :swf, :simpledb, :storagegateway, :support, :waf, :workspaces
    ]

    SERVICES.each do |svc|
      attr_accessor svc
    end

    def initialize(client_options = {})
      self.client_options = client_options
    end

    def credentials
      unless @credentials
        self.credentials = load_credentials
      end
      @credentials
    end

    def credentials=(credentials)
      @credentials = credentials
      reload
    end

    def load_credentials(profile_name='default')
      creds = ::Aws::SharedCredentials.new(profile_name: profile_name)
      return creds if creds.set?
      instance_profile_credentials
    end

    def instance_profile_credentials
      ::Aws::InstanceProfileCredentials.new
    end

    def assume_role!(role_name, duration_seconds = 3600)
      role_arn = "arn:aws:iam::#{account_id}:role/#{role_name}"
      self.credentials = ::Aws::AssumeRoleCredentials.new(
        client: sts,
        role_arn: role_arn,
        role_session_name: random_string(32),
        duration_seconds: duration_seconds
      )
    end

    def role=(role_name)
      assume_role!(role_name)
    end

    def profile?
      credentials.respond_to?(:profile_name)
    end

    def profile
      credentials.profile_name
    end

    def profile=(profile_name)
      self.credentials = ::Aws::SharedCredentials.new(profile_name: profile_name)
    end

    def region
      @region ||= 'us-east-1'
    end

    def underscored_region
      region.gsub('-', '_')
    end

    def account_id
      iam.get_user.user.arn.split(':')[4]
    end

    def acm
      @acm ||= ::Aws::ACM::Client.new(
        credentials: credentials,
        region: region
      )
    end

    def apigateway
      @apigateway ||= ::Aws::APIGateway::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def autoscaling
      @autoscaling ||= ::Aws::AutoScaling::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def cloudformation
      @cloudformation ||= ::Aws::CloudFormation::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def cloudfront
      @cloudformation ||= ::Aws::CloudFront::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def cloudhsm
      @cloudformation ||= ::Aws::CloudHSM::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def cloudsearch
      @cloudformation ||= ::Aws::CloudSearch::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def cloudtrail
      @cloudtrail ||= ::Aws::CloudTrail::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def cloudwatch
      @cloudwatch ||= ::Aws::CloudWatch::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def cloudwatchevents
      @cloudwatchevents ||= ::Aws::CloudWatchEvents::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def cloudwatchlogs
      @cloudwatchlogs ||= ::Aws::CloudWatchLogs::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def codecommit
      @codecommit ||= ::Aws::CodeCommit::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def codedeploy
      @codedeploy ||= ::Aws::CodeDeploy::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def codepipeline
      @codepipeline ||= ::Aws::CodePipeline::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def cognitoidentity
      @cognitoidentity ||= ::Aws::CognitoIdentity::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def cognitosync
      @cognitosync ||= ::Aws::CognitoSync::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def configservice
      @codedeploy ||= ::Aws::ConfigService::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def datapipeline
      @datapipeline ||= ::Aws::DataPipeline::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def databasemigrationservice
      @databasemigrationservice ||= ::Aws::DatabaseMigrationService::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def devicefarm
      @devicefarm ||= ::Aws::DeviceFarm::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def directconnect
      @directconnect ||= ::Aws::DirectConnect::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def directoryservice
      @directoryservice ||= ::Aws::DirectoryService::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def dynamodb
      @dynamodb ||= ::Aws::DynamoDB::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def dynamodbstreams
      @dynamodbstreams ||= ::Aws::DynamoDBStreams::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def ec2
      @ec2 ||= ::Aws::EC2::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def ecr
      @ecr ||= ::Aws::ECR::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def ecs
      @ecs ||= ::Aws::ECS::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def efs
      @efs ||= ::Aws::EFS::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def emr
      @emr ||= ::Aws::EMR::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def elasticbeanstalk
      @elasticbeanstalk ||= ::Aws::ElasticBeanstalk::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def elasticloadbalancing
      @elasticloadbalancing ||= ::Aws::ElasticLoadBalancing::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def elastictranscoder
      @elastictranscoder ||= ::Aws::ElasticTranscoder::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def elasticsearchservice
      @elasticsearchservice ||= ::Aws::ElasticsearchService::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def firehose
      @firehose ||= ::Aws::Firehose::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def gamelift
      @gamelift ||= ::Aws::GameLift::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def glacier
      @glacier ||= ::Aws::Glacier::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def iam
      @iam ||= ::Aws::IAM::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def importexport
      @importexport ||= ::Aws::ImportExport::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def inspector
      @importexport ||= ::Aws::Inspector::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def iot
      @iot ||= ::Aws::IoT::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def iotdataplane
      @iotdataplane ||= ::Aws::IoTDataPlane::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def kms
      @kms ||= ::Aws::KMS::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def kinesis
      @kinesis ||= ::Aws::Kinesis::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def lambda
      @lambda ||= ::Aws::Lambda::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def lambdapreview
      @lambdapreview ||= ::Aws::LambdaPreview::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def machinelearning
      @machinelearning ||= ::Aws::MachineLearning::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def marketplacecommerceanalytics
      @marketplacecommerceanalytics ||= ::Aws::MarketplaceCommerceAnalytics::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def rds
      @rds ||= ::Aws::RDS::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def route53
      @route53 ||= ::Aws::Route53::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def route53domains
      @route53domains ||= ::Aws::Route53Domains::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def s3
      @s3 ||= ::Aws::S3::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def s3_bucket(name, options = {})
      @bucket ||= ::Aws::S3::Bucket.new(name, {
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def ses
      @ses ||= ::Aws::SES::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def sns
      @sns ||= ::Aws::SNS::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def sqs
      @sqs ||= ::Aws::SQS::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def ssm
      @ssm ||= ::Aws::SSM::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def sts
      @sts ||= ::Aws::STS::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def swf
      @swf ||= ::Aws::SWF::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def simpledb
      @simpledb ||= ::Aws::SimpleDB::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def storagegateway
      @storagegateway ||= ::Aws::StorageGateway::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def support
      @support ||= ::Aws::Support::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def waf
      @waf ||= ::Aws::WAF::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

    def workspaces
      @workspaces ||= ::Aws::WorkSpaces::Client.new({
        credentials: credentials,
        region: region
      }.merge(client_options))
    end

  private

      def reload
        SERVICES.each do |svc|
          send("#{svc}=".to_sym, nil)
        end
      end

      def random_string(length = nil)
        length ||= rand(15..30)
        o = [('a'..'z'), ('A'..'Z'), (1..9)].map { |i| i.to_a }.flatten
        (0...length).map { o[rand(o.length)] }.join
      end

  end
end

require "awsclient/version"
require 'aws-sdk'

module Awsclient

  class Connection

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

    def acm(options = {})
      @acm ||= ::Aws::ACM::Client.new(
        credentials: credentials,
        region: region
      )
    end

    def apigateway(options = {})
      @apigateway ||= ::Aws::APIGateway::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def autoscaling(options = {})
      @autoscaling ||= ::Aws::AutoScaling::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def cloudformation(options = {})
      @cloudformation ||= ::Aws::CloudFormation::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def cloudfront(options = {})
      @cloudformation ||= ::Aws::CloudFront::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def cloudhsm(options = {})
      @cloudformation ||= ::Aws::CloudHSM::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def cloudsearch(options = {})
      @cloudformation ||= ::Aws::CloudSearch::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def cloudtrail(options = {})
      @cloudtrail ||= ::Aws::CloudTrail::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def cloudwatch(options = {})
      @cloudwatch ||= ::Aws::CloudWatch::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def cloudwatchevents(options = {})
      @cloudwatchevents ||= ::Aws::CloudWatchEvents::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def cloudwatchlogs(options = {})
      @cloudwatchlogs ||= ::Aws::CloudWatchLogs::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def codecommit(options = {})
      @codecommit ||= ::Aws::CodeCommit::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def codedeploy(options = {})
      @codedeploy ||= ::Aws::CodeDeploy::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def codepipeline(options = {})
      @codepipeline ||= ::Aws::CodePipeline::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def cognitoidentity(options = {})
      @cognitoidentity ||= ::Aws::CognitoIdentity::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def cognitosync(options = {})
      @cognitosync ||= ::Aws::CognitoSync::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def configservice(options = {})
      @codedeploy ||= ::Aws::ConfigService::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def datapipeline(options = {})
      @datapipeline ||= ::Aws::DataPipeline::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def databasemigrationservice(options = {})
      @databasemigrationservice ||= ::Aws::DatabaseMigrationService::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def devicefarm(options = {})
      @devicefarm ||= ::Aws::DeviceFarm::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def directconnect(options = {})
      @directconnect ||= ::Aws::DirectConnect::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def directoryservice(options = {})
      @directoryservice ||= ::Aws::DirectoryService::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def dynamodb(options = {})
      @dynamodb ||= ::Aws::DynamoDB::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def dynamodbstreams(options = {})
      @dynamodbstreams ||= ::Aws::DynamoDBStreams::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def ec2(options = {})
      @ec2 ||= ::Aws::EC2::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def ecr(options = {})
      @ecr ||= ::Aws::ECR::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def ecs(options = {})
      @ecs ||= ::Aws::ECS::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def efs(options = {})
      @efs ||= ::Aws::EFS::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def emr(options = {})
      @emr ||= ::Aws::EMR::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def elasticbeanstalk(options = {})
      @elasticbeanstalk ||= ::Aws::ElasticBeanstalk::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def elasticloadbalancing(options = {})
      @elasticloadbalancing ||= ::Aws::ElasticLoadBalancing::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def elastictranscoder(options = {})
      @elastictranscoder ||= ::Aws::ElasticTranscoder::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def elasticsearchservice(options = {})
      @elasticsearchservice ||= ::Aws::ElasticsearchService::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def firehose(options = {})
      @firehose ||= ::Aws::Firehose::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def gamelift(options = {})
      @gamelift ||= ::Aws::GameLift::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def glacier(options = {})
      @glacier ||= ::Aws::Glacier::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def iam(options = {})
      @iam ||= ::Aws::IAM::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def importexport(options = {})
      @importexport ||= ::Aws::ImportExport::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def inspector(options = {})
      @importexport ||= ::Aws::Inspector::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def iot(options = {})
      @iot ||= ::Aws::IoT::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def iotdataplane(options = {})
      @iotdataplane ||= ::Aws::IoTDataPlane::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def kms(options = {})
      @kms ||= ::Aws::KMS::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def kinesis(options = {})
      @kinesis ||= ::Aws::Kinesis::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def lambda(options = {})
      @lambda ||= ::Aws::Lambda::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def lambdapreview(options = {})
      @lambdapreview ||= ::Aws::LambdaPreview::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def machinelearning(options = {})
      @machinelearning ||= ::Aws::MachineLearning::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def marketplacecommerceanalytics(options = {})
      @marketplacecommerceanalytics ||= ::Aws::MarketplaceCommerceAnalytics::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def rds(options = {})
      @rds ||= ::Aws::RDS::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def route53(options = {})
      @route53 ||= ::Aws::Route53::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def route53domains(options = {})
      @route53domains ||= ::Aws::Route53Domains::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def s3(options = {})
      @s3 ||= ::Aws::S3::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def s3_bucket(name, options = {})
      @bucket ||= ::Aws::S3::Bucket.new(name, {
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def ses(options = {})
      @ses ||= ::Aws::SES::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def sns(options = {})
      @sns ||= ::Aws::SNS::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def sqs(options = {})
      @sqs ||= ::Aws::SQS::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def ssm(options = {})
      @ssm ||= ::Aws::SSM::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def sts(options = {})
      @sts ||= ::Aws::STS::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def swf(options = {})
      @swf ||= ::Aws::SWF::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def simpledb(options = {})
      @simpledb ||= ::Aws::SimpleDB::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def storagegateway(options = {})
      @storagegateway ||= ::Aws::StorageGateway::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def support(options = {})
      @support ||= ::Aws::Support::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def waf(options = {})
      @waf ||= ::Aws::WAF::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
    end

    def workspaces(options = {})
      @workspaces ||= ::Aws::WorkSpaces::Client.new({
        credentials: credentials,
        region: region
      }.merge(options))
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

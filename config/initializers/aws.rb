# config/initializers/aws.rb
require "aws-sdk-s3"

Aws.config.update({
                    region: "us-east-1",
                    endpoint: "http://minio:9000",
                    force_path_style: true,
                    credentials: Aws::Credentials.new("minio", "minio123")
                  })

# frozen_string_literal: true

class S3Uploader
  require 'aws-sdk-s3'

  def self.upload_avatar(file)
    s3 = Aws::S3::Resource.new
    bucket_name = "rails-storage"
    filename = "avatars/#{SecureRandom.uuid}_#{file.original_filename}"
    object = s3.bucket(bucket_name).object(filename)

    object.put(body: file.tempfile, acl: "public-read")
    object.public_url
  end
end

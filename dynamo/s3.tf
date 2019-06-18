resource "aws_s3_bucket" "main" {
    bucket = "my-s3-bucket-for-san"
    acl    = "private"
    
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
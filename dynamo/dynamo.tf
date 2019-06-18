resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "MyDynamo"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "UserId"
  range_key      = "username"
  stream_enabled  = true
  stream_view_type  = "NEW_IMAGE"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "username"
    type = "S"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }

  tags = {
    Name        = "dynamodb-table-1"
    Environment = "production"
  }
}
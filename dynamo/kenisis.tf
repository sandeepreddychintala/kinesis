resource "aws_kinesis_stream" "test_stream" {
  name             = "kinesis-test"
  shard_count      = 1
  retention_period = 24

  shard_level_metrics = [
    "IncomingBytes",
    "OutgoingBytes",
  ]

  tags = {
    Environment = "test"
  }
}
# Example EC2 Instance
resource "aws_instance" "web_server" {
  ami           = "ami-00d8fc944fb171e29"
  instance_type = var.environment == "production" ? "t3.medium" : "t2.micro"
  key_name      = "singapore-elasticsearch"

  tags = {
    Name        = "${var.project_name}-web-${var.environment}"
    Environment = var.environment
    Project     = var.project_name
  }
}

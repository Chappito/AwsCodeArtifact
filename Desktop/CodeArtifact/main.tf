provider "aws" {
    region = var.region
    access_key = var.access_key
    secret_key = var.secret_key
  
}

resource "aws_codeartifact_domain" "demo" {
  domain = "my-domain"
}
resource "aws_codeartifact_domain_permissions_policy" "demo" {
  domain          = aws_codeartifact_domain.demo.domain
  policy_document = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "codeartifact:CreateRepository",
            "Effect": "Allow",
            "Principal": "*",
            "Resource": "${aws_codeartifact_domain.demo.arn}"
        }
    ]
}
EOF
}
resource "aws_codeartifact_repository" "demo1" {
  repository = "my-repos"
  domain     = aws_codeartifact_domain.demo.domain
}
resource "aws_codeartifact_repository_permissions_policy" "demo1" {
  repository      = aws_codeartifact_repository.demo1.repository
  domain          = aws_codeartifact_domain.demo.domain
  policy_document = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "codeartifact:CreateRepository",
            "Effect": "Allow",
            "Principal": "*",
            "Resource": "${aws_codeartifact_domain.demo.arn}"
        }
    ]
}
EOF
}
data "aws_codeartifact_authorization_token" "demo3" {
  domain = aws_codeartifact_domain.demo.domain
}
data "aws_codeartifact_repository_endpoint" "demo4" {
  domain     = aws_codeartifact_domain.demo.domain
  repository = aws_codeartifact_repository.demo1.repository
  format     = "npm"
}
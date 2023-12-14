variable "private_subnets"  {
  default = {
      private-us-east-1a = {
          cidr_block = "10.0.0.0/19"
          map_public_ip_on_launch = false
          availability_zone = "us-east-1a"
      }
      private-us-east-1b = {
          cidr_block = "10.0.32.0/24"
          map_public_ip_on_launch = false
          availability_zone = "us-east-1b"
      }
      # and so on      
  }
}
variable "public_subnets"  {
  default = {
      public-us-east-1a = {
          cidr_block = "10.0.64.0/24"
          map_public_ip_on_launch = true
          availability_zone = "us-east-1a"
      }
     public-us-east-1b = {
          cidr_block = "10.0.96.0/24"
          map_public_ip_on_launch = true
          availability_zone = "us-east-1b"
      }
      # and so on      
  }
}
resource "aws_subnet" "private_subnet" {

  for_each = var.private_subnets

  availability_zone = each.value.availability_zone
  vpc_id = aws_vpc.main.id
  cidr_block = each.value.cidr_block
  map_public_ip_on_launch = each.value.map_public_ip_on_launch
   tags = {
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo"      = "owned"
  }
}
resource "aws_subnet" "public_subnet" {

  for_each = var.private_subnets

  availability_zone = each.value.availability_zone
  vpc_id = aws_vpc.main.id
  cidr_block = each.value.cidr_block
  map_public_ip_on_launch = each.value.map_public_ip_on_launch
    tags = {
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo"      = "owned"
  }
}

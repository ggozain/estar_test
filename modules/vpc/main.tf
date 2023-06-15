 locals {
  availability_zones = data.aws_availability_zones.available.names
  public_subnet_numbers = { for az in local.availability_zones : az => index(local.availability_zones, az) + 1 }
  private_subnet_numbers = { for az in local.availability_zones : az => index(local.availability_zones, az) + length(local.availability_zones) + 1 }
  eip_ids = aws_eip.elastic_ip[*].id
  public_subnet_ids = {
    for idx, subnet in aws_subnet.public:
    idx => subnet.id
  }
  private_subnet_ids = {
    for idx, subnet in aws_subnet.private:
    idx => subnet.id
  }
}

data "aws_availability_zones" "available" {
  state = "available"
  filter {
    name = "region-name"
    values = [var.aws_region]
  }
}
 
 #Create new VPC 
 resource "aws_vpc" "vpc" {
  cidr_block                       = var.vpc_cidr
  instance_tenancy                 = "default"
  enable_dns_support               = var.enable_dns_support
  enable_dns_hostnames             = var.enable_dns_hostnames 
  assign_generated_ipv6_cidr_block = var.assign_generated_ipv6_cidr_block
  
  # tags = {
  #   Name = "${var.infra_env}-vpc"
  # }
}

#Create Public Subnets
resource "aws_subnet" "public" {
    for_each = local.public_subnet_numbers
    
    vpc_id = aws_vpc.vpc.id
    availability_zone = each.key
    cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 8, each.value)

    # tags = {
    #     Name        = "gozain-lab-${var.infra_env}-public-subnet-${each.key}"
    #     Project     = var.tag_project_name
    #     Role        = "public"
    #     Environment = var.infra_env
    #     Subnet      = "${each.key}-${each.value}"
    # }
}

#Create Private Subnets
resource "aws_subnet" "private" {
    for_each = local.private_subnet_numbers

    vpc_id = aws_vpc.vpc.id
    availability_zone = each.key

    cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 5, each.value)

    # tags = {
    #     Name        = "gozain-lab-${var.infra_env}-private-subnet-${each.key}"
    #     Project     = var.tag_project_name
    #     Role        = "private"
    #     Environment = var.infra_env
    #     Subnet      = "${each.key}-${each.value}"
    # }
}

#Create Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.vpc.id
#   tags = {
#     Name        = "gozain-lab-${var.infra_env}-igw"
#     Project     = var.tag_project_name
#     Role        = "public"
#     Environment = var.infra_env
#   }
}

#Create Elastic IPs
resource "aws_eip" "elastic_ip" {
    depends_on = [aws_internet_gateway.main]
    count = length(local.public_subnet_numbers)
}

#Create NatGW per ElasticIPs assigning one to each public subnet
resource "aws_nat_gateway" "nat_gw" {

    count = length(local.eip_ids)
    allocation_id = local.eip_ids[count.index]
    subnet_id     = values(local.public_subnet_ids)[count.index]

#   tags = {
#     Name = "gozain-lab-${var.infra_env}-private-natgw-${var.vpc_public_subnet_ids[count.index]}"
#     Project     = var.tag_project_name
#     Environment = var.infra_env
#   }
}

resource "aws_route_table" "public" {

    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main.id
    }
    # tags = {
    #     Name = "gozain-lab-${var.infra_env}-public-routing-table"
    #     Project     = var.tag_project_name
    #     Environment = var.infra_env
    # }
  
}

resource "aws_route_table" "private" {
    count = length(aws_nat_gateway.nat_gw[*].id)

    vpc_id = aws_vpc.vpc.id
    
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = (aws_nat_gateway.nat_gw[*].id)[count.index]
    }
    # tags = {
    #     Name = "gozain-lab-${var.infra_env}-private-routing-table-${var.nat_gw_ids[count.index]}"
    #     Project     = var.tag_project_name
    #     Environment = var.infra_env
    # }
  
}

resource "aws_route_table_association" "public" {
    for_each = local.public_subnet_ids
    subnet_id = each.value
    route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
    count = length(aws_route_table.private[*].id)
    subnet_id = values(local.private_subnet_ids)[count.index]
    route_table_id = (aws_route_table.private[*].id)[count.index]
}
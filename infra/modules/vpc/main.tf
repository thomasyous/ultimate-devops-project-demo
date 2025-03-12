resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name                                        = "${var.cluster_name}-vpc"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}


#### PUBLIC SUBNETS #### 


resource "aws_subnet" "public" {
  count             = length(var.public_subnet_cidrs)      # Creates a subnet for each CIDR block
  vpc_id            = aws_vpc.main.id                      # Associates subnet with the main VPC
  cidr_block        = var.public_subnet_cidrs[count.index] # Assigns CIDR blocks dynamically
  availability_zone = var.availability_zones[count.index]  # Places subnet in a specific AZ

  map_public_ip_on_launch = true # Ensures instances in the subnet get public IPs
  #  Ensures that EC2 instances launched in this subnet automatically receive a public IP address. Without this, instances cannot directly access or be accessed from the internet.
  /*
  Required for Public-Facing Applications
  If your EC2 instances are running: 
  ✔️ A public website
  ✔️ A REST API
  ✔️ A bastion host (jump server)

  They must have a public IP, or they will be inaccessible from outside AWS.

  For Private Subnets
  Private subnets should not assign public IPs to instances.
  Instead, instances should route internet-bound traffic through a NAT Gateway.
  */

  tags = {
    Name                                        = "${var.cluster_name}-public-${count.index + 1}"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared" # Marks the subnet as part of an EKS cluster
    "kubernetes.io/role/elb"                    = 1        # Indicates this subnet is for ELBs (Load Balancers)
  }
}


resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0" # Defines a default route (0.0.0.0/0) This makes the entire internet accessible from the subnet. Traffic is routed through the Internet Gateway.
    gateway_id = aws_internet_gateway.main.id
  }

  /*
  1️⃣ An EC2 instance inside the public subnet sends a request to an external service (e.g., Google).
  2️⃣ The route table forwards traffic (since 0.0.0.0/0 matches all addresses) to the IGW.
  3️⃣ The IGW sends the request to the internet.
  4️⃣ The response comes back through the IGW → reaches the instance if Security Groups allow it.

  ✅ Allows outbound traffic from the associated subnets to the internet.
  ✅ Makes subnets public (instances get public access if they have a public IP).
  ✅ Allows return traffic from the internet (if security groups allow it).

  ❌ It does NOT control inbound traffic (that’s handled by Security Groups & NACLs).
  ❌ It does NOT provide internet access to instances without a public IP (use a NAT Gateway for private subnets).
  ❌ It does NOT control internal VPC traffic (only external traffic).
  */

  tags = {
    Name = "${var.cluster_name}-public"
  }
}


resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}


resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.cluster_name}-IGW"
  }
}


#### PRIVATE SUBNETS #### 


resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidrs)      # Creates a subnet for each CIDR block
  vpc_id            = aws_vpc.main.id                       # Associates subnet with the main VPC
  cidr_block        = var.private_subnet_cidrs[count.index] # Assigns CIDR blocks dynamically
  availability_zone = var.availability_zones[count.index]   # Places subnet in a specific AZ


  tags = {
    Name                                        = "${var.cluster_name}-private-${count.index + 1}"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared" # Marks the subnet as part of an EKS cluster
    "kubernetes.io/role/elb"                    = 1        # Indicates this subnet is for ELBs (Load Balancers)
  }
}


resource "aws_route_table" "private" {
  count  = length(var.private_subnet_cidrs)
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0" # Directs traffic to the NAT Gateway
    nat_gateway_id = aws_nat_gateway.main[count.index].id
  }

  tags = {
    Name = "${var.cluster_name}-private-${count.index + 1}"
  }
}

resource "aws_eip" "nat" {
  count = length(var.public_subnet_cidrs)
  domain = "vpc"

  tags = {
    Name = "${var.cluster_name}-nat-${count.index + 1}"
  }
}

resource "aws_nat_gateway" "main" {
  count         = length(var.private_subnet_cidrs)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = {
    Name = "${var.cluster_name}-nat-${count.index + 1}"
  }
}

# A NAT Gateway connects to the each route table for HA (If one subnet collapses with one gateway we have more) 

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnet_cidrs)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}

resource "aws_eip" "blueprints_eip" {
  tags = {
    Name    = "nat"
  }
}

resource "aws_nat_gateway" "blueprints_nat" {
  allocation_id = aws_eip.blueprints_eip.id
  subnet_id = aws_subnet.public_sub_us-east-1a.id
  tags = {
    Name    = "nat"
  }
  depends_on = [aws_internet_gateway.eks_igw]
}
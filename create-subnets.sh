#!/bin/bash

# Run dos2unix filename to correct the EOF EOL from windows to linux
# To run this script correctly you must have a VPC configured in each region already 


regions=`aws ec2 describe-regions --query Regions[*].RegionName --output text`

#Gets every region in AWS.
for region in $regions
do
    # Retrieves all of the vpc cidr address
    vpccidr=`aws ec2 describe-vpcs --region $region --query Vpcs[*].CidrBlock --output text`
    #this removes the /16 from the vpc ip address and adds a 24 for a class c subnet
    subnetcidr=${vpccidr::-3}/24


    # First need to get id's of the vpc that we want to delete
    vpcids=`aws ec2 describe-vpcs --region $region --query Vpcs[*].VpcId --output text`

    currentsubnetcidr=`aws ec2 describe-subnets --region $region --query Subnets[*].CidrBlock --output text`

    echo "This is subnetcidr: $subnetcidr"
    echo "This is currentsubnetcidr: $currentsubnetcidr"


    # Iterating over each vpc id
    for vpcid in $vpcids
    do
    # Making sure that if a subnet already exists not create another one with the same cidr block
    if [ "$subnetcidr" != "$currentsubnetcidr" ];
    then
    #create a subnet for each VPC
    aws ec2 create-subnet --cidr-block $subnetcidr --vpc-id $vpcid --region $region
    fi
    #sleep 1m
    done
done




#!/bin/bash

# When executing this script in linux 
# Run dos2unix filename to correct the EOF EOL
# Run dos2unix filename command for the script to run fine in linux since this script was edited in windows

regions=`aws ec2 describe-regions --query Regions[*].RegionName --output text`

#Gets every region in AWS. 
for region in $regions
do

    # VPC ids
    vpcids=`aws ec2 describe-vpcs --region $region --query Vpcs[*].VpcId --output text`

    for vpcid in $vpcids 
    do
    aws ec2 create-route-table --vpc-id $vpcid --region $region 
    done

done

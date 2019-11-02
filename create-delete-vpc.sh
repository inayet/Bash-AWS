# When executing this script in linux 
# Run dos2unix filename to correct the EOF EOL
# Make sure that you have AWS CLI installed and configured correctly.
# Run dos2unix filename command for the script to run fine in linux since this script was edited in windows


#Gets every region in AWS. 
regions=`aws ec2 describe-regions --query Regions[*].RegionName --output text`


for region in $regions
do

    # First need to get ids of the vpc that we want to delete
    vpcids=`aws ec2 describe-vpcs --region $region --query Vpcs[*].VpcId --output text`

    # Creates an empty VPC without any dependencies uncommet the line below
    ##aws ec2 create-vpc --cidr-block 130.255.0.0/16 --region $region

    # Iterating over each vpc id
    for vpcid in $vpcids
    do
    # Deleting each vpc in each region 
    aws ec2  delete-vpc --vpc-id $vpcid --region $region
    done
 

done
regions=`aws ec2 describe-regions --query Regions[*].RegionName --output text`
 # Get all instances ids that match the filters

for region in $regions
do
instanceids=`aws ec2 describe-instances --region $region --filters 'Name=instance-type, Values=t2.micro' --query 'Reservations[*].Instances[*].InstanceId' --output text`
echo "this is the region: $region"
    
    # For each instance id loop through it
    for instanceid in $instanceids
    do
    echo "this is the instance id: $instanceid"
    # This command stops all instances with the specific id
    aws ec2 stop-instances --region $region --instance-ids $instanceid ;
    done
    
done





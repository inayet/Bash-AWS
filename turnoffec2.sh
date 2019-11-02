# When executing this script in linux to run dos2unix filename to correct the
# Run dos2unix filename command for the script to run fine in linux since this script was edited in windows


#Gets every region in AWS. 
regions=`aws ec2 describe-regions --query Regions[*].RegionName --output text`


for region in $regions
do
 # Get all instances ids that match the filters
instanceids=`aws ec2 describe-instances --region $region --filters 'Name=instance-type, Values=t2.micro' --query 'Reservations[*].Instances[*].InstanceId' --output text`

    # For each instance id loop through it
    for instanceid in $instanceids
    do
    # To stops all instances with the specific id
   # aws ec2 stop-instances --region $region --instance-ids $instanceid ;

    # To start all ec2 uncomment the lin below 
      aws ec2 start-instances --region $region --instance-ids $instanceid ;

    done

done





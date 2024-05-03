function handler () {
  event=`echo $1 | /var/task/jq -r .event`
  if [ "$event" = "scalein" ]; then
    aws autoscaling update-auto-scaling-group --desired-capacity 0 --min-size=0 --max-size=0 --auto-scaling-group-name essesense-stg-Server-spike-asg
    exit
  fi

  aws autoscaling update-auto-scaling-group --desired-capacity 5 --min-size=5 --max-size=10 --auto-scaling-group-name essesense-stg-Server-spike-asg
  aws scheduler create-schedule --name `date --date='15 minutes' +'scalein-schedule_%Y-%m-%d-%H%M'` \
    --flexible-time-window MaximumWindowInMinutes=1,Mode=FLEXIBLE \
    --target '{"Arn":"arn:aws:lambda:ap-northeast-1:991315227616:function:esse-sense-autoscale-stg","Input":"{\"event\":\"scalein\"}","RoleArn":"arn:aws:iam::991315227616:role/esse-sense-autoscale-eventbridge-stg"}' \
    --schedule-expression=`date --date='15 minutes' +"at(%Y-%m-%dT%H:%M:%S)"`
}

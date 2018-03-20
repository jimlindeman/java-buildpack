cd /home/vcap
tar -xvzf app/shared-folder/cf-files/mt-logstash-forwarder.tgz

mkdir -p /home/vcap/mt-logstash-forwarder/etc
# Here we expect there to be a cf-lsf-<app-name>.conf file in the git project of the deployed app
cp app/cf-lsf-*.conf /home/vcap/mt-logstash-forwarder/etc/

# start logrotate
/home/vcap/app/shared-folder/cf-files/rotate_logs.sh &

# Now kick off mt-logstash-forwarder
if [[ "$USE_LSF" == "true" ]]; then
  /home/vcap/mt-logstash-forwarder/bin/mt-logstash-forwarder -config /home/vcap/mt-logstash-forwarder/etc -spool-size 100 -load-vcap true > /home/vcap/mt-logstash-forwarder/mt-lsf.log 2>&1
fi

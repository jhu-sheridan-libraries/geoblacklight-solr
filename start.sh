python /flask/app.py &
/opt/solr/bin/solr start -noprompt -f
find . -name "/opt/data/**/*.json" -exec /opt/solr/bin/post -c development {} ";"
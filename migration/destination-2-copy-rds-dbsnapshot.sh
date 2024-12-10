#!/usr/bin/env bash

CURRENT_DB_INDENTIFIER=ma-common-db
SNAPSHOT_INDENTIFIER=mattermost-db-latest-manual-snapshot
CURRENT_TIME=`date "+%Y%m%d%H%M%S"`

SOURCE_ACCOUNT=`aws ssm get-parameters-by-path --path "/ma-migration" --recursive | jq -r .Parameters[].Value`

aws rds copy-db-snapshot --source-db-snapshot-identifier arn:aws:rds::$SOURCE_ACCOUNT:snapshot:$SNAPSHOT_INDENTIFIER --target-db-snapshot-identifier $SNAPSHOT_INDENTIFIER

#aws rds restore-db-instance-from-db-snapshot --db-instance-identifier $CURRENT_DB_INDENTIFIER --db-snapshot-identifier $SNAPSHOT_INDENTIFIER
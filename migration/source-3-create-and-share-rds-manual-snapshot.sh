#!/usr/bin/env bash

# How to migrate mattermost RDS to new database.
# https://repost.aws/ja/knowledge-center/rds-snapshots-share-account
# 1. Create manual snapshot from Current auto-snapshot by following procedure.
# See https://docs.aws.amazon.com/ja_jp/AmazonRDS/latest/UserGuide/USER_CreateSnapshot.html
# 1. 移行元Accountでシングルリージョンすナップショットを作成する(暗号化なし)

CURRENT_DB_INDENTIFIER=ma-common-db
SNAPSHOT_INDENTIFIER=mattermost-db-latest-manual-snapshot
CURRENT_TIME=`date "+%Y%m%d%H%M%S"`

#aws rds create-db-snapshot --db-instance-identifier $CURRENT_DB_INDENTIFIER --db-snapshot-identifier $SNAPSHOT_INDENTIFIER --tags $CURRENT_TIME

# 2. Share the latest snapshot to new AWS Account to be going to migrate.
# If snapshot got be selected encryption, Create KMS Key and copy and share snapshot to specified account.
# Before this operation, it should be set ssm parameter store for migrated destination account.
# 2. 移行元Accountで事前にSystemsManager Parameter Storeに移行先アカウントを登録しておく
# 作成したスナップショットに共有アカウント属性を付与する
# See
# https://docs.aws.amazon.com/ja_jp/AmazonRDS/latest/UserGuide/USER_ShareSnapshot.html
DESTINATION_ACCOUNT=`aws ssm get-parameters-by-path --path "/ma-migration" --recursive | jq -r .Parameters[].Value`

#

aws rds modify-db-snapshot-attribute --db-snapshot-identifier $SNAPSHOT_INDENTIFIER  --attribute-name restore --values-to-add $DESTINATION_ACCOUNT





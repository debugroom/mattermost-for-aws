package org.debugroom.cloud.aws.lambda.dbinit.config;

import com.amazonaws.services.simplesystemsmanagement.AWSSimpleSystemsManagement;
import com.amazonaws.services.simplesystemsmanagement.AWSSimpleSystemsManagementClientBuilder;
import com.amazonaws.services.simplesystemsmanagement.model.GetParameterRequest;
import lombok.extern.slf4j.Slf4j;
import org.debugroom.cloud.aws.lambda.dbinit.app.CloudFormationStackResolver;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.cloud.aws.context.config.annotation.EnableStackConfiguration;
import org.springframework.cloud.aws.jdbc.config.annotation.EnableRdsInstance;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.sql.DataSource;

@EnableStackConfiguration(stackName = "ma-common-rds")
//Not use @EnableRdsInstance annotation because of dynamic referenec by AWS Systems Manager Parameter Store Client.
//@EnableRdsInstance(
//        dbInstanceIdentifier = "mynavi-sample-cloudformation-dev-postgresql",
//        password = "${rds.password}",
//        readReplicaSupport = false)
@Slf4j
@Configuration
public class RdsConfig {

    private static final String dbName = "ma-common-vpc-RDS-DBName";
    private static final String rdsEndpoint = "ma-common-vpc-RDS-Endpoint";
    private static final String rdsUserName = "ma-common-vpc-RDS-UserName";

    @Bean
    CloudFormationStackResolver cloudFormationStackResolver(){
        return new CloudFormationStackResolver();
    }

    @Bean
    AWSSimpleSystemsManagement awsSimpleSystemsManagement(){
        return AWSSimpleSystemsManagementClientBuilder.defaultClient();
    }

    @Bean
    public DataSource dataSource(){
        DataSourceBuilder dataSourceBuilder = DataSourceBuilder.create();
        dataSourceBuilder.driverClassName("org.postgresql.Driver");
        dataSourceBuilder.url("jdbc:postgresql://" +
                cloudFormationStackResolver().getExportValue(rdsEndpoint)
                + ":5432/mattermost");
        dataSourceBuilder.username(cloudFormationStackResolver().getExportValue(rdsUserName));
        GetParameterRequest request = new GetParameterRequest();
        request.setName("ma-rds-postgres-master-password");
        request.setWithDecryption(true);
        dataSourceBuilder.password(awsSimpleSystemsManagement().getParameter(request)
                .getParameter().getValue());
        return dataSourceBuilder.build();
    }

}

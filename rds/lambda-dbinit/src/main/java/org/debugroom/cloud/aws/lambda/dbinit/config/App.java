package org.debugroom.cloud.aws.lambda.dbinit.config;

import org.debugroom.cloud.aws.lambda.dbinit.app.AppHandler;
import org.debugroom.cloud.aws.lambda.dbinit.app.CloudFormationResponseSender;
import org.debugroom.cloud.aws.lambda.dbinit.app.CloudFormationStackResolver;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.web.client.RestOperations;
import org.springframework.web.client.RestTemplate;

@SpringBootApplication
public class App {

    public static void main(String[] args) {
        SpringApplication.run(App.class, args);
    }

}

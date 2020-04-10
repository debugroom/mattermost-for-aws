package org.debugroom.cloud.aws.lambda.dbinit.app.function;

import com.amazonaws.services.simplesystemsmanagement.AWSSimpleSystemsManagement;
import com.amazonaws.services.simplesystemsmanagement.model.GetParameterRequest;
import lombok.extern.slf4j.Slf4j;

import java.util.Map;
import java.util.function.Function;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import reactor.core.publisher.Flux;

@Slf4j
public class DbInitFunction implements Function<Map<String, Object>, Flux<String>> {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Autowired
    AWSSimpleSystemsManagement awsSimpleSystemsManagement;

    @Override
    public Flux<String> apply(Map<String, Object> event) {
        GetParameterRequest request = new GetParameterRequest();
        request.setName("ma-mattermost-password");
        request.setWithDecryption(true);
        jdbcTemplate.execute("CREATE ROLE mattermost WITH LOGIN PASSWORD '"
                + awsSimpleSystemsManagement.getParameter(request).getParameter().getValue()
                + "';");
        return Flux.just("Complete!");
    }

}

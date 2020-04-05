package org.debugroom.cloud.aws.lambda.dbinit.app;

import com.amazonaws.services.lambda.runtime.Context;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;

import java.net.URI;
import java.util.HashMap;
import java.util.Map;

import static org.hamcrest.core.Is.is;
import static org.hamcrest.core.IsNull.nullValue;
import static org.mockito.Mockito.when;
import static org.junit.jupiter.api.Assertions.*;

@Slf4j
public class CloudFormationResponseSenderTest {

    @Nested
    class getUriTest {

        @Mock
        private Map<String, Object> event = new HashMap<>();
        @Mock
        private Context context;

        @Test
        public void normal(){
           URI uri = CloudFormationResponseSender.getUri("https://cloudformation-custom-resource-response-apnortheast1.s3-ap-northeast-1.amazonaws.com/arn%3Aaws%3Acloudformation%3Aap-northeast-1%3A576249913131%3Astack/debugroom-technical-academy-custom/559a4c30-7717-11ea-8be6-0ae3ffe7265e%7CLambdaTrigger%7Cc506a2bc-f814-48af-a1df-8de4e42f572f?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20200405T085106Z&X-Amz-SignedHeaders=host&X-Amz-Expires=7200&X-Amz-Credential=AKI%2F20200405%2Fap-northeast-1%2Fs3%2Faws4_request&X-Amz-Signature=4a");
           assertEquals("https://cloudformation-custom-resource-response-apnortheast1.s3-ap-northeast-1.amazonaws.com/arn%3Aaws%3Acloudformation%3Aap-northeast-1%3A576249913131%3Astack/debugroom-technical-academy-custom/559a4c30-7717-11ea-8be6-0ae3ffe7265e%7CLambdaTrigger%7Cc506a2bc-f814-48af-a1df-8de4e42f572f?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20200405T085106Z&X-Amz-SignedHeaders=host&X-Amz-Expires=7200&X-Amz-Credential=AKI%2F20200405%2Fap-northeast-1%2Fs3%2Faws4_request&X-Amz-Signature=4a", uri.toString());
        }

    }
}

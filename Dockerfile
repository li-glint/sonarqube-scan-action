FROM sonarsource/sonar-scanner-cli:4.6

LABEL version="1.0.0" \
      repository="https://github.com/sonarsource/sonarqube-scan-action" \
      homepage="https://github.com/sonarsource/sonarqube-scan-action" \
      maintainer="SonarSource" \
      com.github.actions.name="SonarQube Scan" \
      com.github.actions.description="Scan your code with SonarQube to detect Bugs, Vulnerabilities and Code Smells in up to 27 programming languages!" \
      com.github.actions.icon="check" \
      com.github.actions.color="green"

# Set up local envs in order to allow for special chars (non-asci) in filenames.
ENV LC_ALL="C.UTF-8"

# Copy Glint root CA cert for connecting to sonarqube server and validation of SSL
COPY lib/tls-ca.pem /tmp/tls-ca.pem
RUN keytool -import -v -trustcacerts -alias glint -file /tmp/tls-ca.pem \
      -keystore ${JAVA_HOME}/lib/security/cacerts -noprompt -storepass changeit

# https://help.github.com/en/actions/creating-actions/dockerfile-support-for-github-actions#user
USER root

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

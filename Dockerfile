# 최신 Tomcat 이미지를 기반으로 컨테이너를 생성
FROM tomcat:latest

# 작업 디렉토리를 Tomcat의 webapps 디렉토리로 설정
WORKDIR /usr/local/tomcat/webapps 

# ROOT 디렉토리를 생성하고 MySQL JDBC 드라이버를 다운로드 및 이동
RUN mkdir ROOT && \ 
        # MySQL Connector/J (JDBC 드라이버) 다운로드
        wget https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.23/mysql-connector-java-8.0.23.jar && \
        # 다운로드한 드라이버를 Tomcat의 lib 디렉토리로 이동 (JDBC 드라이버는 Tomcat의 lib 폴더에 있어야 함)
        mv mysql-connector-java-8.0.23.jar /usr/local/tomcat/lib/ && \
        # Tomcat 디렉토리의 권한을 777로 변경 (모든 사용자에게 읽기, 쓰기, 실행 권한 부여)
        chmod -R 777 /usr/local/tomcat && \
	mkdir -p /usr/local/tomcat/webapps/ROOT/exam

# Tomcat을 시작하기 전에 먼저 중지한 후 3초 대기 후 다시 실행
CMD ["sh", "-c", "/usr/local/tomcat/bin/catalina.sh stop; sleep 3; /usr/local/tomcat/bin/catalina.sh run"]


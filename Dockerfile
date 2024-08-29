FROM maven:3-eclipse-temurin-17 AS build
COPY . .
RUN mvn clean package -Dmaven.test.skip=true
FROM eclipse-temurin:17-alpine
COPY --from=build /target/render-spring-0.0.1-SNAPSHOT.jar demo.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "demo.jar"]


# # ベースイメージとしてOpenJDK 17を使用
# FROM openjdk:17-jdk-slim as builder

# # dos2unix をインストール
# RUN apt-get update && apt-get install -y dos2unix

# # 作業ディレクトリを設定
# WORKDIR /app

# # Gradleのキャッシュを利用するために、Gradleのラッパーと依存関係をコピー
# COPY demo/gradlew .
# COPY demo/gradle gradle
# COPY demo/build.gradle .
# COPY demo/settings.gradle .

# # gradlew ファイルの改行コードを LF に変換
# RUN dos2unix gradlew

# # 権限を付与
# RUN chmod +x ./gradlew

# # 依存関係を解決
# RUN ./gradlew dependencies

# # プロジェクトのソースコードをコピー
# COPY ../ .

# # 再度gradlew ファイルの改行コードを LF に変換
# RUN dos2unix gradlew

# # プロジェクトをビルド　※テストは実行しない
# RUN ./gradlew build -x test

# # ランタイムイメージとしてTomcatを使用
# FROM tomcat:9.0-jdk17-openjdk-slim

# # 作業ディレクトリを設定
# WORKDIR /usr/local/tomcat/webapps/

# # ビルド済みのWARファイルをTomcatのwebappsディレクトリにコピー
# COPY --from=builder /app/build/libs/demo-0.0.1-SNAPSHOT.war ./ROOT.war

# # ポートを公開
# EXPOSE 8080

# # WARファイルを実行
# CMD ["java", "-jar", "ROOT.war"]
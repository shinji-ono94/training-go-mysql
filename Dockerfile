# 2020/10/14最新versionを取得
# FROM golang:1.15.2-alpine
FROM golang:1.13.12
# アップデートとgitのインストール
RUN apk update && apk add git
# appディレクトリの作成
RUN mkdir /go/src/app
# ワーキングディレクトリの設定
WORKDIR /go/src/app
# ホストのファイルをコンテナの作業ディレクトリに移行
ADD . /go/src/app
# sqlを使うためのモジュール
RUN go get -u github.com/go-sql-driver/mysql
# go mod
RUN go mod init
RUN go mod tidy
# CMD ["realize", "start"]
RUN go build -o go-app app/main.go
RUN chmod 770 go-app
RUN mv go-app
ENTRYPOINT ["/go-app"]